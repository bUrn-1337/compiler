/* main.cpp -- driver of the compiler.
 *
 *   mipscc <source.c> [-o output.s] [--emit-ir[=file.ir]] [-O0|-O1]
 *
 * Pipeline: flex+bison parse -> AST -> semantic analysis -> IR (in memory)
 * -> MIPS assembly for spim, with the runtime routines the program uses
 * appended.  The default output is the source path with its extension
 * replaced by ".s" (the same rule Stage 3 used for ".ir").
 *
 * On any lexical, syntax or semantic error every error is reported with its
 * line and column exactly as Stage 3 reports them, the exit status is 1, and
 * no assembly file is left behind (a stale one at the output path is removed;
 * the file is only created once the whole program has been generated).
 *
 * --runtime is internal: it compiles src/runtime/rt_lib.c as the runtime
 * library (see sema.h's runtimeMode and the makefile).
 */
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdio>
#include <cstring>
#include <utility>
#include <vector>
#include <pthread.h>

#include "ast.h"
#include "ir.h"
#include "sema.h"
#include "irgen.h"
#include "mips.h"

extern int   yyparse();
extern FILE* yyin;
extern void  init_typedef_names(void);

extern int   syntax_errors;
extern int   lexical_errors;
extern Node* g_program;

namespace {

std::string replaceExt(const std::string& src, const char* ext) {
    size_t slash = src.find_last_of('/');
    size_t dot   = src.find_last_of('.');
    if (dot != std::string::npos && (slash == std::string::npos || dot > slash))
        return src.substr(0, dot) + ext;
    return src + ext;
}

void usage(const char* argv0) {
    std::cerr << "usage: " << argv0 << " <source.c> [-o output.s] [--emit-ir[=file.ir]] [-O0|-O1]\n"
              << "  -o FILE         write the assembly to FILE (default: the source path\n"
              << "                  with its extension replaced by '.s')\n"
              << "  --emit-ir[=F]   also write the Stage 3 IR text (default: '.ir' next to\n"
              << "                  the assembly output)\n"
              << "  -O0             simple code: every IR register lives in a stack slot\n"
              << "                  (the default)\n"
              << "  -O1             allocate IR registers to $s0-$s7 / $f20-$f30\n"
              << "The output runs on spim:  spim -file output.s [args...]\n";
}

struct Options {
    std::string src, out, irOut;
    bool emitIr = false, runtime = false;
    int  opt = 0;
};

/* Parses the command line into `o`; returns 0 to continue, or the exit status
   to stop with (2 for a usage error, 0 after --help). */
int parseArgs(int argc, char** argv, Options& o) {
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        if (a == "-h" || a == "--help") { usage(argv[0]); return -1; }
        else if (a == "-o") {
            if (i + 1 >= argc) { std::cerr << "error: -o needs a file name\n"; return 2; }
            o.out = argv[++i];
        }
        else if (a.compare(0, 2, "-o") == 0 && a.size() > 2) o.out = a.substr(2);
        else if (a == "--emit-ir") o.emitIr = true;
        else if (a.compare(0, 10, "--emit-ir=") == 0) { o.emitIr = true; o.irOut = a.substr(10); }
        else if (a == "-O0") o.opt = 0;
        else if (a == "-O1" || a == "-O") o.opt = 1;
        else if (a == "--runtime") o.runtime = true;
        else if (!a.empty() && a[0] == '-') {
            std::cerr << "error: unknown option '" << a << "'\n"; usage(argv[0]); return 2;
        }
        else if (o.src.empty()) o.src = a;
        else { std::cerr << "error: more than one source file\n"; usage(argv[0]); return 2; }
    }
    if (o.src.empty()) { usage(argv[0]); return 2; }
    if (o.out.empty()) o.out = replaceExt(o.src, ".s");
    if (o.emitIr && o.irOut.empty()) o.irOut = replaceExt(o.out, ".ir");
    if (o.emitIr && o.irOut == o.out) {
        std::cerr << "error: the IR and the assembly would both be written to '" << o.out << "'\n";
        return 2;
    }
    return 0;
}

/* Writes `text` to `path` in one go; on failure removes what was written. */
bool writeFile(const std::string& path, const std::string& text) {
    std::ofstream out(path.c_str(), std::ios::binary | std::ios::trunc);
    if (out) { out << text; out.close(); }
    if (!out) {
        std::cerr << "error: cannot write output file '" << path << "'\n";
        std::remove(path.c_str());
        return false;
    }
    return true;
}

void failSummary(int total, const Options& o) {
    std::cerr << "\n" << total << " error" << (total == 1 ? "" : "s")
              << " found in '" << o.src << "'; no assembly written.\n";
    std::remove(o.out.c_str());
    if (o.emitIr) std::remove(o.irOut.c_str());
}

/* Runs the whole pipeline on the parsed tree; returns the exit status. */
int compile(const Options& o, TypeArena& types) {
    int frontEndErrors = lexical_errors + syntax_errors;
    Diag           diag;
    AnalysisResult ar;
    IrModule       mod;
    mod.sourceName = o.src;

    for (size_t i = 0; i < g_parseDiags.size(); ++i)
        diag.error(g_parseDiags[i].line, g_parseDiags[i].col, g_parseDiags[i].msg);
    if (frontEndErrors == 0 && g_program) {
        Sema sema(types, diag);
        sema.runtimeMode = o.runtime;
        sema.run(g_program, ar);
    }
    diag.flush(std::cerr);
    int total = frontEndErrors + diag.count;
    if (total > 0) { failSummary(total, o); return 1; }

    IrGen gen(types, diag);
    gen.run(g_program, ar, mod);
    if (diag.count > 0) {
        diag.flush(std::cerr);
        failSummary(diag.count, o);
        return 1;
    }

    MipsOptions mo;
    mo.optLevel = o.opt;
    mo.runtimeMode = o.runtime;
    mo.sourceName = o.src;
    mo.outputName = o.out;
    std::ostringstream asmText;
    std::string err;
    if (!emitMips(asmText, mod, mo, &err)) {
        std::cerr << "internal error: " << err << "\n";
        failSummary(1, o);
        return 1;
    }
    if (o.emitIr) {
        std::ostringstream irText;
        writeIr(irText, mod);
        if (!writeFile(o.irOut, irText.str())) { std::remove(o.out.c_str()); return 2; }
    }
    if (!writeFile(o.out, asmText.str())) {
        if (o.emitIr) std::remove(o.irOut.c_str());
        return 2;
    }
    return 0;
}

/* Every pass over the tree (semantic analysis, IR generation) is
   recursive, so a tree nested deeper than this is rejected before they run.
   Bison already stops at 10000 open parentheses or braces ("memory
   exhausted"), but a long left-associative chain such as 1+1+...+1 is parsed
   with a shallow parser stack and still builds a tree as deep as it is long.
   The compiler thread's stack (kStackBytes) is sized so that this depth is
   safe in every pass, also under AddressSanitizer. */
const size_t kMaxDepth   = 10000;
const size_t kStackBytes = (size_t)1 << 30;

/* Finds, without recursion, the first node (in depth-first order) that is
   more than kMaxDepth levels deep, and reports it as a syntax error.
   Returns true if the tree is within the limit. */
bool checkDepth(Node* root) {
    std::vector<std::pair<Node*, size_t> > work;
    work.push_back(std::make_pair(root, (size_t)1));
    while (!work.empty()) {
        Node* n = work.back().first;
        size_t d = work.back().second;
        work.pop_back();
        if (d > kMaxDepth) {
            std::cerr << "Syntax Error [Line " << n->line << ", Col " << n->col
                      << "]: expression or statement nested too deeply (limit "
                      << kMaxDepth << " levels)" << std::endl;
            ++syntax_errors;
            return false;
        }
        for (size_t i = n->kids.size(); i-- > 0; )
            if (n->kids[i]) work.push_back(std::make_pair(n->kids[i], d + 1));
    }
    return true;
}

struct Job { int argc; char** argv; int status; };

/* The whole compiler: parse, check, generate, write.  Runs on the big-stack
   thread started by main(). */
int run(int argc, char** argv) {
    Options o;
    int st = parseArgs(argc, argv, o);
    if (st == -1) return 0;
    if (st != 0) return st;

    yyin = std::fopen(o.src.c_str(), "r");
    if (!yyin) {
        std::cerr << "error: cannot open source file '" << o.src << "'\n";
        std::remove(o.out.c_str());
        return 2;
    }
    NodeArena nodes;
    TypeArena types;
    g_nodes = &nodes;
    g_types = &types;
    init_typedef_names();

    yyparse();
    std::fclose(yyin);
    yyin = 0;
    if (lexical_errors + syntax_errors == 0 && g_program) checkDepth(g_program);
    int status = compile(o, types);

    nodes.clear();
    g_nodes = 0;
    g_types = 0;
    clearLexemePool();
    return status;
}

void* runJob(void* p) {
    Job* job = static_cast<Job*>(p);
    job->status = run(job->argc, job->argv);
    return 0;
}

} // namespace

/* Runs the compiler on a thread with a kStackBytes stack (only the pages
   actually used are ever allocated); falls back to the main thread if the
   thread cannot be created. */
int main(int argc, char** argv) {
    Job job = { argc, argv, 2 };
    pthread_attr_t attr;
    pthread_t      tid;
    if (pthread_attr_init(&attr) == 0) {
        bool ok = pthread_attr_setstacksize(&attr, kStackBytes) == 0 &&
                  pthread_create(&tid, &attr, runJob, &job) == 0;
        pthread_attr_destroy(&attr);
        if (ok && pthread_join(tid, 0) == 0) return job.status;
    }
    return run(argc, argv);
}
