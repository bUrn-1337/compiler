/* mips.h -- the MIPS back end: lowers the in-memory IR (ir.h) to an assembly
 * file for the SPIM simulator.  docs/MIPS-DESIGN.md specifies the register
 * use, frame layout, calling convention and the lowering of every IR
 * instruction; the comments in mips.cpp refer to its sections.
 */
#ifndef MIPS_H
#define MIPS_H

#include <ostream>
#include <string>
#include "ir.h"

struct MipsOptions {
    int  optLevel = 0;          /* 0: every IR register lives in a stack slot;
                                   1: linear-scan allocation into $s0-$s7 and
                                      $f20-$f30, the rest in stack slots      */
    bool runtimeMode = false;   /* compiling src/runtime/rt_lib.c: name every
                                   symbol __rt_*, mark units, no header and no
                                   runtime linking                           */
    std::string sourceName;     /* for the header comment                    */
    std::string outputName;     /* for the run command in the header comment */
};

/* Writes the complete assembly program for `m` -- the header comment, the data
   and text of the program, and (unless runtimeMode) the runtime routines it
   needs, taken from the runtime embedded in the compiler.  Returns false and
   fills *err if the IR uses something the back end cannot lower or a runtime
   routine is missing; nothing useful has been written to `os` in that case. */
bool emitMips(std::ostream& os, const IrModule& m, const MipsOptions& opt,
              std::string* err);

/* The runtime, embedded at build time (build/rt_table.cpp): the hand-written
   core (src/runtime/rt_core.s) and the library compiled from
   src/runtime/rt_lib.c in runtime mode.  Both are split into units by lines
   of the form "# @unit <symbol>". */
extern const char* const kRuntimeCore;
extern const char* const kRuntimeLib;

#endif
