# rt_core.s -- the hand-written part of the runtime (MIPS-DESIGN.md section 8).
#
# The compiler appends to every program the units of this file and of the
# compiled rt_lib.c that the program needs.  A unit starts at a line
# "# @unit <symbol>" and runs to the next one; it is included when the program
# or another included unit mentions <symbol> outside a comment.  Every unit
# states its own section (.text/.data) because units are concatenated in an
# order the compiler does not otherwise control.
#
# Everything here follows the compiler's calling convention: arguments in
# $a0-$a3 then 16($sp) up, result in $v0, $s0-$s7/$fp/$ra/$f20-$f31 preserved.
# These routines use only $a*, $t*, $v* and the home area their caller
# provides at 0..15($sp), so none of them needs a frame unless it calls out.

# @unit main
	.text
	.globl	main
# Entry point: spim's __start calls `main' with argc in $a0, argv in $a1 and
# $sp only 4-byte aligned.  Realign to 8, give fn_main a home area, run it and
# exit with its result (syscall 17 uses the low 8 bits as the exit status).
main:
	li	$t0, -8
	and	$sp, $sp, $t0
	addiu	$sp, $sp, -16
	jal	fn_main
	move	$a0, $v0
	li	$v0, 17
	syscall

# @unit __rt_exit
	.text
# void exit(int status): output is never buffered, so nothing to flush.
__rt_exit:
	li	$v0, 17
	syscall

# @unit __rt_divzero
	.data
__rt_divzero_msg:
	.asciiz	"runtime error: division by zero\n"
	.text
# Called by the inline check before every `div' whose divisor is zero:
# message on stderr, exit status 70 (the same status as irsim).
__rt_divzero:
	li	$a0, 2
	la	$a1, __rt_divzero_msg
	li	$a2, 32
	li	$v0, 15
	syscall
	li	$a0, 70
	li	$v0, 17
	syscall

# @unit __rt_sys_write
	.text
# int sys_write(int fd, char *buf, int n) -- syscall 15
__rt_sys_write:
	li	$v0, 15
	syscall
	jr	$ra

# @unit __rt_sys_read
	.text
# int sys_read(int fd, char *buf, int n) -- syscall 14; 0 at end of file
__rt_sys_read:
	li	$v0, 14
	syscall
	jr	$ra

# @unit __rt_sys_open
	.text
# int sys_open(char *name, int flags, int mode) -- syscall 13, Linux flag
# values (spim hands them to open(2)); -1 on failure
__rt_sys_open:
	li	$v0, 13
	syscall
	jr	$ra

# @unit __rt_sys_close
	.text
# int sys_close(int fd) -- syscall 16
__rt_sys_close:
	li	$v0, 16
	syscall
	jr	$ra

# @unit __rt_sys_sbrk
	.text
# char *sys_sbrk(int n) -- syscall 9; spim rounds n up to a multiple of 8
__rt_sys_sbrk:
	li	$v0, 9
	syscall
	jr	$ra

# @unit __rt_memmove
	.text
# void *memmove(void *dst, void *src, int n): forwards when dst <= src,
# backwards otherwise, a word at a time when both pointers and n allow it.
# Used for every blkcopy of more than 16 bytes, so struct copies are fast.
__rt_memmove:
	move	$v0, $a0
	blez	$a2, __rt_memmove.done
	beq	$a0, $a1, __rt_memmove.done
	or	$t0, $a0, $a1
	or	$t0, $t0, $a2
	andi	$t0, $t0, 3
	sltu	$t1, $a1, $a0
	bne	$t1, $zero, __rt_memmove.back
	bne	$t0, $zero, __rt_memmove.fb
__rt_memmove.fw:
	lw	$t2, 0($a1)
	sw	$t2, 0($a0)
	addiu	$a0, $a0, 4
	addiu	$a1, $a1, 4
	addiu	$a2, $a2, -4
	bgtz	$a2, __rt_memmove.fw
	jr	$ra
__rt_memmove.fb:
	lb	$t2, 0($a1)
	sb	$t2, 0($a0)
	addiu	$a0, $a0, 1
	addiu	$a1, $a1, 1
	addiu	$a2, $a2, -1
	bgtz	$a2, __rt_memmove.fb
	jr	$ra
__rt_memmove.back:
	addu	$a0, $a0, $a2
	addu	$a1, $a1, $a2
	bne	$t0, $zero, __rt_memmove.bb
__rt_memmove.bw:
	addiu	$a0, $a0, -4
	addiu	$a1, $a1, -4
	lw	$t2, 0($a1)
	sw	$t2, 0($a0)
	addiu	$a2, $a2, -4
	bgtz	$a2, __rt_memmove.bw
	jr	$ra
__rt_memmove.bb:
	addiu	$a0, $a0, -1
	addiu	$a1, $a1, -1
	lb	$t2, 0($a1)
	sb	$t2, 0($a0)
	addiu	$a2, $a2, -1
	bgtz	$a2, __rt_memmove.bb
__rt_memmove.done:
	jr	$ra

# @unit __rt_bzero
	.text
# void bzero(void *p, int n): used for memzero of more than 16 bytes
__rt_bzero:
	blez	$a1, __rt_bzero.done
	or	$t0, $a0, $a1
	andi	$t0, $t0, 3
	bne	$t0, $zero, __rt_bzero.b
__rt_bzero.w:
	sw	$zero, 0($a0)
	addiu	$a0, $a0, 4
	addiu	$a1, $a1, -4
	bgtz	$a1, __rt_bzero.w
	jr	$ra
__rt_bzero.b:
	sb	$zero, 0($a0)
	addiu	$a0, $a0, 1
	addiu	$a1, $a1, -1
	bgtz	$a1, __rt_bzero.b
__rt_bzero.done:
	jr	$ra

# ---------------------------------------------------------------------------
# Variadic entry points.  The caller has laid the arguments out in its
# outgoing area exactly as a struct (MIPS-DESIGN.md section 4.2), so after
# storing $a0-$a3 back into their home words the variable arguments are an
# array in memory.  Each stub passes the fixed arguments and a pointer `ap'
# to the first variable one to the C routine that does the work; that routine
# rounds ap up to 8 before reading a double.

# @unit __rt_printf
	.text
# int printf(char *fmt, ...) -> vprintf(fmt, ap)
__rt_printf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a1, $sp, 28
	jal	__rt_vprintf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# @unit __rt_fprintf
	.text
# int fprintf(FILE *f, char *fmt, ...) -> vfprintf(f, fmt, ap)
__rt_fprintf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a2, $sp, 32
	jal	__rt_vfprintf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# @unit __rt_sprintf
	.text
# int sprintf(char *buf, char *fmt, ...) -> vsprintf(buf, fmt, ap)
__rt_sprintf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a2, $sp, 32
	jal	__rt_vsprintf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# @unit __rt_scanf
	.text
# int scanf(char *fmt, ...) -> vscanf(fmt, ap)
__rt_scanf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a1, $sp, 28
	jal	__rt_vscanf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# @unit __rt_fscanf
	.text
# int fscanf(FILE *f, char *fmt, ...) -> vfscanf(f, fmt, ap)
__rt_fscanf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a2, $sp, 32
	jal	__rt_vfscanf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# @unit __rt_sscanf
	.text
# int sscanf(char *str, char *fmt, ...) -> vsscanf(str, fmt, ap)
__rt_sscanf:
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	addiu	$a2, $sp, 32
	jal	__rt_vsscanf
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra
