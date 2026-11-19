# runtime library compiled from src/runtime/rt_lib.c by mipscc -O0

# @unit __rtd.str0
	.data
__rtd.str0:		# .str0, 16 bytes
	.asciiz "runtime error: "

# @unit __rtd.str1
	.data
__rtd.str1:		# .str1, 2 bytes
	.asciiz "\n"

# @unit __rtd.str2
	.data
__rtd.str2:		# .str2, 1 bytes
	.asciiz ""

# @unit __rtd.str3
	.data
__rtd.str3:		# .str3, 7 bytes
	.asciiz "(null)"

# @unit __rtd.str4
	.data
__rtd.str4:		# .str4, 4 bytes
	.asciiz "NAN"

# @unit __rtd.str5
	.data
__rtd.str5:		# .str5, 4 bytes
	.asciiz "nan"

# @unit __rtd.str6
	.data
__rtd.str6:		# .str6, 4 bytes
	.asciiz "INF"

# @unit __rtd.str7
	.data
__rtd.str7:		# .str7, 4 bytes
	.asciiz "inf"

# @unit __rtd.str8
	.data
__rtd.str8:		# .str8, 14 bytes
	.asciiz "out of memory"

# @unit __rtd.str9
	.data
__rtd.str9:		# .str9, 24 bytes
	.asciiz "free() of a bad pointer"

# @unit __rtd.str10
	.data
__rtd.str10:		# .str10, 12 bytes
	.asciiz "double free"

# @unit __rtd.str11
	.data
__rtd.str11:		# .str11, 27 bytes
	.asciiz "realloc() of a bad pointer"

# @unit __rtg_out_fd
	.data
	.align  2
__rtg_out_fd:		# int, 4 bytes
	.space  4

# @unit __rtg_out_str
	.data
	.align  2
__rtg_out_str:		# char *, 4 bytes
	.space  4

# @unit __rtg_out_count
	.data
	.align  2
__rtg_out_count:		# int, 4 bytes
	.space  4

# @unit __rtg_out_len
	.data
	.align  2
__rtg_out_len:		# int, 4 bytes
	.space  4

# @unit __rtg_out_buf
	.data
__rtg_out_buf:		# char [256], 256 bytes
	.space  256

# @unit __rtg_pf_left
	.data
	.align  2
__rtg_pf_left:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_plus
	.data
	.align  2
__rtg_pf_plus:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_space
	.data
	.align  2
__rtg_pf_space:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_alt
	.data
	.align  2
__rtg_pf_alt:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_zero
	.data
	.align  2
__rtg_pf_zero:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_width
	.data
	.align  2
__rtg_pf_width:		# int, 4 bytes
	.space  4

# @unit __rtg_pf_prec
	.data
	.align  2
__rtg_pf_prec:		# int, 4 bytes
	.space  4

# @unit __rtg_fd_big
	.data
	.align  2
__rtg_fd_big:		# int [208], 832 bytes
	.space  832

# @unit __rtg_fd_nbig
	.data
	.align  2
__rtg_fd_nbig:		# int, 4 bytes
	.space  4

# @unit __rtg_fd_dig
	.data
__rtg_fd_dig:		# char [840], 840 bytes
	.space  840

# @unit __rtg_fd_n
	.data
	.align  2
__rtg_fd_n:		# int, 4 bytes
	.space  4

# @unit __rtg_fd_exp
	.data
	.align  2
__rtg_fd_exp:		# int, 4 bytes
	.space  4

# @unit __rtg_rt_files
	.data
	.align  2
__rtg_rt_files:		# struct rtfile [16], 12800 bytes
	.space  12800

# @unit __rtg_rt_stdin
	.data
	.align  2
__rtg_rt_stdin:		# struct rtfile, 800 bytes
	.space  800

# @unit __rtg_rm_names
	.data
__rtg_rm_names:		# char [2048], 2048 bytes
	.space  2048

# @unit __rtg_rm_used
	.data
	.align  2
__rtg_rm_used:		# int [8], 32 bytes
	.space  32

# @unit __rtg_acc
	.data
	.align  2
__rtg_acc:		# int [4], 16 bytes
	.space  16

# @unit __rtg_acc_ovf
	.data
	.align  2
__rtg_acc_ovf:		# int, 4 bytes
	.space  4

# @unit __rtg_dd_dig
	.data
__rtg_dd_dig:		# char [800], 800 bytes
	.space  800

# @unit __rtg_dd_n
	.data
	.align  2
__rtg_dd_n:		# int, 4 bytes
	.space  4

# @unit __rtg_dd_adj
	.data
	.align  2
__rtg_dd_adj:		# int, 4 bytes
	.space  4

# @unit __rtg_dd_sticky
	.data
	.align  2
__rtg_dd_sticky:		# int, 4 bytes
	.space  4

# @unit __rtg_bg_num
	.data
	.align  2
__rtg_bg_num:		# struct big, 1060 bytes
	.space  1060

# @unit __rtg_bg_den
	.data
	.align  2
__rtg_bg_den:		# struct big, 1060 bytes
	.space  1060

# @unit __rtg_sc_str
	.data
	.align  2
__rtg_sc_str:		# int, 4 bytes
	.space  4

# @unit __rtg_sc_s
	.data
	.align  2
__rtg_sc_s:		# char *, 4 bytes
	.space  4

# @unit __rtg_sc_f
	.data
	.align  2
__rtg_sc_f:		# struct rtfile *, 4 bytes
	.space  4

# @unit __rtg_sc_eof
	.data
	.align  2
__rtg_sc_eof:		# int, 4 bytes
	.space  4

# @unit __rtg_heap_lo
	.data
	.align  2
__rtg_heap_lo:		# char *, 4 bytes
	.space  4

# @unit __rtg_heap_hi
	.data
	.align  2
__rtg_heap_hi:		# char *, 4 bytes
	.space  4

# @unit __rtg_free_head
	.data
	.align  2
__rtg_free_head:		# char *, 4 bytes
	.space  4

# @unit __rt_is_space
	.text
# ---------------------------------------------------------------
# function is_space (line 39), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_is_space
__rt_is_space:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = %c == 32   ; line 40
	lw      $t0, -12($fp)
	xori    $t0, $t0, 32
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# if %t2 goto .L1   ; line 40
	lw      $t0, -20($fp)
	bne     $t0, $zero, __rt_is_space.L1
	# %t3 = %c >= 9   ; line 40
	lw      $t0, -12($fp)
	slti    $t0, $t0, 9
	xori    $t0, $t0, 1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L2   ; line 40
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_is_space.L2
	# %t4 = %c <= 13   ; line 40
	lw      $t0, -12($fp)
	li      $t1, 13
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L2   ; line 40
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_is_space.L2
__rt_is_space.L1:
	# %t1 = 1   ; line 40
	li      $t0, 1
	sw      $t0, -16($fp)
	# goto .L3   ; line 40
	b       __rt_is_space.L3
__rt_is_space.L2:
	# %t1 = 0   ; line 40
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_is_space.L3:
	# return %t1   ; line 40
	lw      $v0, -16($fp)
__rt_is_space.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_is_digit
	.text
# ---------------------------------------------------------------
# function is_digit (line 43), returns int
# frame 40 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_is_digit
__rt_is_digit:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = %c >= 48   ; line 44
	lw      $t0, -12($fp)
	slti    $t0, $t0, 48
	xori    $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L5   ; line 44
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_is_digit.L5
	# %t3 = %c <= 57   ; line 44
	lw      $t0, -12($fp)
	li      $t1, 57
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L5   ; line 44
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_is_digit.L5
	# %t1 = 1   ; line 44
	li      $t0, 1
	sw      $t0, -16($fp)
	# goto .L6   ; line 44
	b       __rt_is_digit.L6
__rt_is_digit.L5:
	# %t1 = 0   ; line 44
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_is_digit.L6:
	# return %t1   ; line 44
	lw      $v0, -16($fp)
__rt_is_digit.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strlen
	.text
# ---------------------------------------------------------------
# function strlen (line 47), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%n : int
#   -20($fp)	%t2 : str
#   -24($fp)	%t3 : char
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strlen
__rt_strlen:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %n = 0   ; line 49
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_strlen.L7:
	# %t2 = %s + %n   ; line 50
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -20($fp)
	# %t3 = load.b %t2   ; line 50
	lw      $t0, -20($fp)
	lb      $t1, 0($t0)
	sw      $t1, -24($fp)
	# ifFalse %t3 goto .L9   ; line 50
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_strlen.L9
	# %t4 = %n   ; line 50
	lw      $t0, -16($fp)
	sw      $t0, -28($fp)
	# %t5 = %t4 + 1   ; line 50
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -32($fp)
	# %n = %t5   ; line 50
	lw      $t0, -32($fp)
	sw      $t0, -16($fp)
	# goto .L7   ; line 50
	b       __rt_strlen.L7
__rt_strlen.L9:
	# return %n   ; line 51
	lw      $v0, -16($fp)
__rt_strlen.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_rt_fatal
	.text
# ---------------------------------------------------------------
# function rt_fatal (line 56), returns void
# frame 80 bytes ($fp = $sp at entry):
#   0($fp)	param msg (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%msg : str
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : str
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_rt_fatal
__rt_rt_fatal:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -80
	sw      $a0, 0($fp)
	# param msg : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = 2   ; line 57
	li      $t0, 2
	sw      $t0, -16($fp)
	# %t2 = addr @.str0   ; line 57
	la      $t0, __rtd.str0
	sw      $t0, -20($fp)
	# %t3 = 15   ; line 57
	li      $t0, 15
	sw      $t0, -24($fp)
	# param %t1 : int   ; line 57
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# param %t2 : str   ; line 57
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# param %t3 : int   ; line 57
	lw      $t0, -24($fp)
	sw      $t0, 8($sp)
	# %t4 = call @sys_write, 3   ; line 57
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -28($fp)
	# %t5 = 2   ; line 58
	li      $t0, 2
	sw      $t0, -32($fp)
	# param %msg : str   ; line 58
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t6 = call @strlen, 1   ; line 58
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -36($fp)
	# param %t5 : int   ; line 58
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# param %msg : str   ; line 58
	lw      $t0, -12($fp)
	sw      $t0, 4($sp)
	# param %t6 : int   ; line 58
	lw      $t0, -36($fp)
	sw      $t0, 8($sp)
	# %t7 = call @sys_write, 3   ; line 58
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -40($fp)
	# %t8 = 2   ; line 59
	li      $t0, 2
	sw      $t0, -44($fp)
	# %t9 = addr @.str1   ; line 59
	la      $t0, __rtd.str1
	sw      $t0, -48($fp)
	# %t10 = 1   ; line 59
	li      $t0, 1
	sw      $t0, -52($fp)
	# param %t8 : int   ; line 59
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# param %t9 : str   ; line 59
	lw      $t0, -48($fp)
	sw      $t0, 4($sp)
	# param %t10 : int   ; line 59
	lw      $t0, -52($fp)
	sw      $t0, 8($sp)
	# %t11 = call @sys_write, 3   ; line 59
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -56($fp)
	# %t12 = 70   ; line 60
	li      $t0, 70
	sw      $t0, -60($fp)
	# param %t12 : int   ; line 60
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @exit, 1   ; line 60
	lw      $a0, 0($sp)
	jal     __rt_exit
	# return
__rt_rt_fatal.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_flush
	.text
# ---------------------------------------------------------------
# function out_flush (line 73), returns void
# frame 64 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%t0 : ptr
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_flush
__rt_out_flush:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	# %t0 = addr @out_len   ; line 74
	la      $t0, __rtg_out_len
	sw      $t0, -12($fp)
	# %t1 = load.w %t0   ; line 74
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -16($fp)
	# %t2 = %t1 > 0   ; line 74
	lw      $t0, -16($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L11   ; line 74
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_out_flush.L11
	# %t3 = addr @out_fd   ; line 74
	la      $t0, __rtg_out_fd
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 74
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = addr @out_buf   ; line 74
	la      $t0, __rtg_out_buf
	sw      $t0, -32($fp)
	# %t6 = addr @out_len   ; line 74
	la      $t0, __rtg_out_len
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 74
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# param %t4 : int   ; line 74
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %t5 : str   ; line 74
	lw      $t0, -32($fp)
	sw      $t0, 4($sp)
	# param %t7 : int   ; line 74
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# %t8 = call @sys_write, 3   ; line 74
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -44($fp)
__rt_out_flush.L11:
	# %t9 = addr @out_len   ; line 75
	la      $t0, __rtg_out_len
	sw      $t0, -48($fp)
	# store.w %t9, 0   ; line 75
	lw      $t0, -48($fp)
	sw      $zero, 0($t0)
	# return
__rt_out_flush.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_char
	.text
# ---------------------------------------------------------------
# function out_char (line 78), returns void
# frame 136 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : char
#   -52($fp)	%t10 : char
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : str
#   -68($fp)	%t14 : str
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : str
#   -88($fp)	%t19 : char
#   -92($fp)	%t20 : char
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : ptr
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_char
__rt_out_char:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -136
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = addr @out_count   ; line 79
	la      $t0, __rtg_out_count
	sw      $t0, -16($fp)
	# %t2 = load.w %t1   ; line 79
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# %t3 = %t2   ; line 79
	lw      $t0, -20($fp)
	sw      $t0, -24($fp)
	# %t4 = %t3 + 1   ; line 79
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# store.w %t1, %t4   ; line 79
	lw      $t0, -16($fp)
	lw      $t1, -28($fp)
	sw      $t1, 0($t0)
	# %t5 = addr @out_str   ; line 80
	la      $t0, __rtg_out_str
	sw      $t0, -32($fp)
	# %t6 = load.w %t5   ; line 80
	lw      $t0, -32($fp)
	lw      $t1, 0($t0)
	sw      $t1, -36($fp)
	# ifFalse %t6 goto .L13   ; line 80
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_out_char.L13
	# %t7 = addr @out_str   ; line 81
	la      $t0, __rtg_out_str
	sw      $t0, -40($fp)
	# %t8 = load.w %t7   ; line 81
	lw      $t0, -40($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# %t9 = sext.b %c   ; line 81
	lw      $t0, -12($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -48($fp)
	# store.b %t8, %t9   ; line 81
	lw      $t0, -44($fp)
	lw      $t1, -48($fp)
	sb      $t1, 0($t0)
	# %t10 = sext.b %t9   ; line 81
	lw      $t0, -48($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -52($fp)
	# %t11 = addr @out_str   ; line 82
	la      $t0, __rtg_out_str
	sw      $t0, -56($fp)
	# %t12 = addr @out_str   ; line 82
	la      $t0, __rtg_out_str
	sw      $t0, -60($fp)
	# %t13 = load.w %t12   ; line 82
	lw      $t0, -60($fp)
	lw      $t1, 0($t0)
	sw      $t1, -64($fp)
	# %t14 = %t13 + 1   ; line 82
	lw      $t0, -64($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# store.w %t11, %t14   ; line 82
	lw      $t0, -56($fp)
	lw      $t1, -68($fp)
	sw      $t1, 0($t0)
	# return   ; line 83
	b       __rt_out_char.ret
__rt_out_char.L13:
	# %t15 = addr @out_buf   ; line 85
	la      $t0, __rtg_out_buf
	sw      $t0, -72($fp)
	# %t16 = addr @out_len   ; line 85
	la      $t0, __rtg_out_len
	sw      $t0, -76($fp)
	# %t17 = load.w %t16   ; line 85
	lw      $t0, -76($fp)
	lw      $t1, 0($t0)
	sw      $t1, -80($fp)
	# %t18 = %t15 + %t17   ; line 85
	lw      $t0, -72($fp)
	lw      $t1, -80($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %t19 = sext.b %c   ; line 85
	lw      $t0, -12($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -88($fp)
	# store.b %t18, %t19   ; line 85
	lw      $t0, -84($fp)
	lw      $t1, -88($fp)
	sb      $t1, 0($t0)
	# %t20 = sext.b %t19   ; line 85
	lw      $t0, -88($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -92($fp)
	# %t21 = addr @out_len   ; line 86
	la      $t0, __rtg_out_len
	sw      $t0, -96($fp)
	# %t22 = load.w %t21   ; line 86
	lw      $t0, -96($fp)
	lw      $t1, 0($t0)
	sw      $t1, -100($fp)
	# %t23 = %t22   ; line 86
	lw      $t0, -100($fp)
	sw      $t0, -104($fp)
	# %t24 = %t23 + 1   ; line 86
	lw      $t0, -104($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# store.w %t21, %t24   ; line 86
	lw      $t0, -96($fp)
	lw      $t1, -108($fp)
	sw      $t1, 0($t0)
	# %t25 = addr @out_len   ; line 87
	la      $t0, __rtg_out_len
	sw      $t0, -112($fp)
	# %t26 = load.w %t25   ; line 87
	lw      $t0, -112($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# %t27 = %t26 == 256   ; line 87
	lw      $t0, -116($fp)
	xori    $t0, $t0, 256
	sltiu   $t0, $t0, 1
	sw      $t0, -120($fp)
	# ifFalse %t27 goto .L15   ; line 87
	lw      $t0, -120($fp)
	beq     $t0, $zero, __rt_out_char.L15
	# call @out_flush, 0   ; line 87
	jal     __rt_out_flush
__rt_out_char.L15:
	# return
__rt_out_char.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_pad
	.text
# ---------------------------------------------------------------
# function out_pad (line 90), returns void
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%n : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_pad
__rt_out_pad:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param n : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
__rt_out_pad.L16:
	# %t2 = %n > 0   ; line 91
	lw      $t0, -16($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L18   ; line 91
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_out_pad.L18
	# param %c : int   ; line 92
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 92
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t3 = %n   ; line 93
	lw      $t0, -16($fp)
	sw      $t0, -24($fp)
	# %t4 = %t3 - 1   ; line 93
	lw      $t0, -24($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -28($fp)
	# %n = %t4   ; line 93
	lw      $t0, -28($fp)
	sw      $t0, -16($fp)
	# goto .L16   ; line 93
	b       __rt_out_pad.L16
__rt_out_pad.L18:
	# return
__rt_out_pad.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_mem
	.text
# ---------------------------------------------------------------
# function out_mem (line 97), returns void
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%n : int
#   -20($fp)	%i : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : str
#   -32($fp)	%t5 : char
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_mem
__rt_out_mem:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param n : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %i = 0   ; line 99
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_out_mem.L19:
	# %t3 = %i < %n   ; line 99
	lw      $t0, -20($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L22   ; line 99
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_out_mem.L22
	# %t4 = %s + %i   ; line 99
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -28($fp)
	# %t5 = load.b %t4   ; line 99
	lw      $t0, -28($fp)
	lb      $t1, 0($t0)
	sw      $t1, -32($fp)
	# param %t5 : int   ; line 99
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 99
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t6 = %i   ; line 99
	lw      $t0, -20($fp)
	sw      $t0, -36($fp)
	# %t7 = %t6 + 1   ; line 99
	lw      $t0, -36($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# %i = %t7   ; line 99
	lw      $t0, -40($fp)
	sw      $t0, -20($fp)
	# goto .L19   ; line 99
	b       __rt_out_mem.L19
__rt_out_mem.L22:
	# return
__rt_out_mem.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_dig_char
	.text
# ---------------------------------------------------------------
# function dig_char (line 103), returns int
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param d (int, arrives in $a0)
#   4($fp)	param upper (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : int
#   -16($fp)	%upper : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_dig_char
__rt_dig_char:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param d : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param upper : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t2 = %d < 10   ; line 104
	lw      $t0, -12($fp)
	slti    $t0, $t0, 10
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L24   ; line 104
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_dig_char.L24
	# %t3 = 48 + %d   ; line 104
	li      $t0, 48
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -24($fp)
	# return %t3   ; line 104
	lw      $v0, -24($fp)
	b       __rt_dig_char.ret
__rt_dig_char.L24:
	# ifFalse %upper goto .L26   ; line 105
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_dig_char.L26
	# %t4 = 65 + %d   ; line 105
	li      $t0, 65
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -28($fp)
	# %t5 = %t4 - 10   ; line 105
	lw      $t0, -28($fp)
	addiu   $t0, $t0, -10
	sw      $t0, -32($fp)
	# return %t5   ; line 105
	lw      $v0, -32($fp)
	b       __rt_dig_char.ret
__rt_dig_char.L26:
	# %t6 = 97 + %d   ; line 106
	li      $t0, 97
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = %t6 - 10   ; line 106
	lw      $t0, -36($fp)
	addiu   $t0, $t0, -10
	sw      $t0, -40($fp)
	# return %t7   ; line 106
	lw      $v0, -40($fp)
__rt_dig_char.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_udigits
	.text
# ---------------------------------------------------------------
# function udigits (line 111), returns int
# frame 168 bytes ($fp = $sp at entry):
#   0($fp)	param v (int, arrives in $a0)
#   4($fp)	param base (int, arrives in $a1)
#   8($fp)	param upper (int, arrives in $a2)
#   12($fp)	param dg (str, arrives in $a3)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%v : int
#   -16($fp)	%base : int
#   -20($fp)	%upper : int
#   -24($fp)	%dg : str
#   -28($fp)	%n : int
#   -32($fp)	%d : int
#   -36($fp)	%q : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : str
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : char
#   -116($fp)	%t26 : char
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : str
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : char
#   -148($fp)	%t34 : char
#   -152($fp)	%t35 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_udigits
__rt_udigits:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -168
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param v : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param base : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param upper : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param dg : str at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# %n = 0   ; line 113
	move    $t0, $zero
	sw      $t0, -28($fp)
	# %t7 = %v < 0   ; line 114
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L28   ; line 114
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_udigits.L28
	# %t8 = %base == 10   ; line 116
	lw      $t0, -16($fp)
	xori    $t0, $t0, 10
	sltiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L30   ; line 116
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_udigits.L30
	# %t9 = %v >> 1   ; line 117
	lw      $t0, -12($fp)
	sra     $t0, $t0, 1
	sw      $t0, -48($fp)
	# %t10 = %t9 & 2147483647   ; line 117
	lw      $t0, -48($fp)
	li      $t1, 2147483647
	and     $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %t11 = %t10 / 5   ; line 117
	lw      $t0, -52($fp)
	li      $t1, 5
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -56($fp)
	# %q = %t11   ; line 117
	lw      $t0, -56($fp)
	sw      $t0, -36($fp)
	# %t12 = %q * 10   ; line 118
	lw      $t0, -36($fp)
	li      $t1, 10
	mul     $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t13 = %v - %t12   ; line 118
	lw      $t0, -12($fp)
	lw      $t1, -60($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %d = %t13   ; line 118
	lw      $t0, -64($fp)
	sw      $t0, -32($fp)
	# goto .L31   ; line 118
	b       __rt_udigits.L31
__rt_udigits.L30:
	# %t14 = %base == 16   ; line 119
	lw      $t0, -16($fp)
	xori    $t0, $t0, 16
	sltiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L33   ; line 119
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_udigits.L33
	# %t15 = %v >> 4   ; line 120
	lw      $t0, -12($fp)
	sra     $t0, $t0, 4
	sw      $t0, -72($fp)
	# %t16 = %t15 & 268435455   ; line 120
	lw      $t0, -72($fp)
	li      $t1, 268435455
	and     $t0, $t0, $t1
	sw      $t0, -76($fp)
	# %q = %t16   ; line 120
	lw      $t0, -76($fp)
	sw      $t0, -36($fp)
	# %t17 = %v & 15   ; line 121
	lw      $t0, -12($fp)
	andi    $t0, $t0, 15
	sw      $t0, -80($fp)
	# %d = %t17   ; line 121
	lw      $t0, -80($fp)
	sw      $t0, -32($fp)
	# goto .L34   ; line 121
	b       __rt_udigits.L34
__rt_udigits.L33:
	# %t18 = %v >> 3   ; line 123
	lw      $t0, -12($fp)
	sra     $t0, $t0, 3
	sw      $t0, -84($fp)
	# %t19 = %t18 & 536870911   ; line 123
	lw      $t0, -84($fp)
	li      $t1, 536870911
	and     $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %q = %t19   ; line 123
	lw      $t0, -88($fp)
	sw      $t0, -36($fp)
	# %t20 = %v & 7   ; line 124
	lw      $t0, -12($fp)
	andi    $t0, $t0, 7
	sw      $t0, -92($fp)
	# %d = %t20   ; line 124
	lw      $t0, -92($fp)
	sw      $t0, -32($fp)
__rt_udigits.L34:
__rt_udigits.L31:
	# %t21 = %n   ; line 126
	lw      $t0, -28($fp)
	sw      $t0, -96($fp)
	# %t22 = %t21 + 1   ; line 126
	lw      $t0, -96($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# %n = %t22   ; line 126
	lw      $t0, -100($fp)
	sw      $t0, -28($fp)
	# %t23 = %dg + %t21   ; line 126
	lw      $t0, -24($fp)
	lw      $t1, -96($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -104($fp)
	# param %d : int   ; line 126
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# param %upper : int   ; line 126
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t24 = call @dig_char, 2   ; line 126
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dig_char
	sw      $v0, -108($fp)
	# %t25 = sext.b %t24   ; line 126
	lw      $t0, -108($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -112($fp)
	# store.b %t23, %t25   ; line 126
	lw      $t0, -104($fp)
	lw      $t1, -112($fp)
	sb      $t1, 0($t0)
	# %t26 = sext.b %t25   ; line 126
	lw      $t0, -112($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -116($fp)
	# %v = %q   ; line 127
	lw      $t0, -36($fp)
	sw      $t0, -12($fp)
__rt_udigits.L28:
__rt_udigits.L35:
	# %t27 = %v % %base   ; line 130
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	bne     $t1, $zero, __rt_udigits.c0
	jal     __rt_divzero
__rt_udigits.c0:
	li      $t2, -1
	bne     $t1, $t2, __rt_udigits.c1
	move    $t0, $zero
	b       __rt_udigits.c2
__rt_udigits.c1:
	div     $t0, $t1
	mfhi    $t0
__rt_udigits.c2:
	sw      $t0, -120($fp)
	# %d = %t27   ; line 130
	lw      $t0, -120($fp)
	sw      $t0, -32($fp)
	# %t28 = %v / %base   ; line 131
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	bne     $t1, $zero, __rt_udigits.c3
	jal     __rt_divzero
__rt_udigits.c3:
	li      $t2, -1
	bne     $t1, $t2, __rt_udigits.c4
	subu    $t0, $zero, $t0
	b       __rt_udigits.c5
__rt_udigits.c4:
	div     $t0, $t1
	mflo    $t0
__rt_udigits.c5:
	sw      $t0, -124($fp)
	# %v = %t28   ; line 131
	lw      $t0, -124($fp)
	sw      $t0, -12($fp)
	# %t29 = %n   ; line 132
	lw      $t0, -28($fp)
	sw      $t0, -128($fp)
	# %t30 = %t29 + 1   ; line 132
	lw      $t0, -128($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# %n = %t30   ; line 132
	lw      $t0, -132($fp)
	sw      $t0, -28($fp)
	# %t31 = %dg + %t29   ; line 132
	lw      $t0, -24($fp)
	lw      $t1, -128($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -136($fp)
	# param %d : int   ; line 132
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# param %upper : int   ; line 132
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t32 = call @dig_char, 2   ; line 132
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dig_char
	sw      $v0, -140($fp)
	# %t33 = sext.b %t32   ; line 132
	lw      $t0, -140($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -144($fp)
	# store.b %t31, %t33   ; line 132
	lw      $t0, -136($fp)
	lw      $t1, -144($fp)
	sb      $t1, 0($t0)
	# %t34 = sext.b %t33   ; line 132
	lw      $t0, -144($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -148($fp)
	# %t35 = %v != 0   ; line 133
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -152($fp)
	# if %t35 goto .L35   ; line 133
	lw      $t0, -152($fp)
	bne     $t0, $zero, __rt_udigits.L35
	# return %n   ; line 134
	lw      $v0, -28($fp)
__rt_udigits.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_num
	.text
# ---------------------------------------------------------------
# function out_num (line 138), returns void
# frame 112 bytes ($fp = $sp at entry):
#   0($fp)	param v (int, arrives in $a0)
#   4($fp)	param mind (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -24($fp)	local b : char [16] (16 bytes)
#   -28($fp)	%v : int
#   -32($fp)	%mind : int
#   -36($fp)	%n : int
#   -40($fp)	%t3 : int
#   -44($fp)	%t4 : int
#   -48($fp)	%t5 : ptr
#   -52($fp)	%t6 : int
#   -56($fp)	%t7 : int
#   -60($fp)	%t8 : ptr
#   -64($fp)	%t9 : int
#   -68($fp)	%t10 : int
#   -72($fp)	%t11 : str
#   -76($fp)	%t12 : int
#   -80($fp)	%t13 : ptr
#   -84($fp)	%t14 : int
#   -88($fp)	%t15 : int
#   -92($fp)	%t16 : str
#   -96($fp)	%t17 : char
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_num
__rt_out_num:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -112
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param v : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -28($fp)
	# param mind : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -32($fp)
	# %t3 = 10   ; line 141
	li      $t0, 10
	sw      $t0, -40($fp)
	# %t4 = 0   ; line 141
	move    $t0, $zero
	sw      $t0, -44($fp)
	# %t5 = addr b   ; line 141
	addiu   $t0, $fp, -24
	sw      $t0, -48($fp)
	# param %v : int   ; line 141
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %t3 : int   ; line 141
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# param %t4 : int   ; line 141
	lw      $t0, -44($fp)
	sw      $t0, 8($sp)
	# param %t5 : str   ; line 141
	lw      $t0, -48($fp)
	sw      $t0, 12($sp)
	# %t6 = call @udigits, 4   ; line 141
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_udigits
	sw      $v0, -52($fp)
	# %n = %t6   ; line 141
	lw      $t0, -52($fp)
	sw      $t0, -36($fp)
__rt_out_num.L38:
	# %t7 = %n < %mind   ; line 142
	lw      $t0, -36($fp)
	lw      $t1, -32($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# ifFalse %t7 goto .L40   ; line 142
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_out_num.L40
	# %t8 = addr b   ; line 142
	addiu   $t0, $fp, -24
	sw      $t0, -60($fp)
	# %t9 = %n   ; line 142
	lw      $t0, -36($fp)
	sw      $t0, -64($fp)
	# %t10 = %t9 + 1   ; line 142
	lw      $t0, -64($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# %n = %t10   ; line 142
	lw      $t0, -68($fp)
	sw      $t0, -36($fp)
	# %t11 = %t8 + %t9   ; line 142
	lw      $t0, -60($fp)
	lw      $t1, -64($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# store.b %t11, 48   ; line 142
	lw      $t0, -72($fp)
	li      $t1, 48
	sb      $t1, 0($t0)
	# goto .L38   ; line 142
	b       __rt_out_num.L38
__rt_out_num.L40:
__rt_out_num.L41:
	# %t12 = %n > 0   ; line 143
	lw      $t0, -36($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -76($fp)
	# ifFalse %t12 goto .L43   ; line 143
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_out_num.L43
	# %t13 = addr b   ; line 143
	addiu   $t0, $fp, -24
	sw      $t0, -80($fp)
	# %t14 = %n   ; line 143
	lw      $t0, -36($fp)
	sw      $t0, -84($fp)
	# %t15 = %t14 - 1   ; line 143
	lw      $t0, -84($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -88($fp)
	# %n = %t15   ; line 143
	lw      $t0, -88($fp)
	sw      $t0, -36($fp)
	# %t16 = %t13 + %n   ; line 143
	lw      $t0, -80($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t17 = load.b %t16   ; line 143
	lw      $t0, -92($fp)
	lb      $t1, 0($t0)
	sw      $t1, -96($fp)
	# param %t17 : int   ; line 143
	lw      $t0, -96($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 143
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# goto .L41   ; line 143
	b       __rt_out_num.L41
__rt_out_num.L43:
	# return
__rt_out_num.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_pad_before
	.text
# ---------------------------------------------------------------
# function pad_before (line 157), returns void
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param len (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%len : int
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_pad_before
__rt_pad_before:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	# param len : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = addr @pf_left   ; line 158
	la      $t0, __rtg_pf_left
	sw      $t0, -16($fp)
	# %t2 = load.w %t1   ; line 158
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# if %t2 goto .L45   ; line 158
	lw      $t0, -20($fp)
	bne     $t0, $zero, __rt_pad_before.L45
	# %t3 = 32   ; line 158
	li      $t0, 32
	sw      $t0, -24($fp)
	# %t4 = addr @pf_width   ; line 158
	la      $t0, __rtg_pf_width
	sw      $t0, -28($fp)
	# %t5 = load.w %t4   ; line 158
	lw      $t0, -28($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %t5 - %len   ; line 158
	lw      $t0, -32($fp)
	lw      $t1, -12($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# param %t3 : int   ; line 158
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %t6 : int   ; line 158
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# call @out_pad, 2   ; line 158
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_pad
__rt_pad_before.L45:
	# return
__rt_pad_before.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_pad_after
	.text
# ---------------------------------------------------------------
# function pad_after (line 161), returns void
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param len (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%len : int
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_pad_after
__rt_pad_after:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	# param len : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = addr @pf_left   ; line 162
	la      $t0, __rtg_pf_left
	sw      $t0, -16($fp)
	# %t2 = load.w %t1   ; line 162
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# ifFalse %t2 goto .L47   ; line 162
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_pad_after.L47
	# %t3 = 32   ; line 162
	li      $t0, 32
	sw      $t0, -24($fp)
	# %t4 = addr @pf_width   ; line 162
	la      $t0, __rtg_pf_width
	sw      $t0, -28($fp)
	# %t5 = load.w %t4   ; line 162
	lw      $t0, -28($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %t5 - %len   ; line 162
	lw      $t0, -32($fp)
	lw      $t1, -12($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# param %t3 : int   ; line 162
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %t6 : int   ; line 162
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# call @out_pad, 2   ; line 162
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_pad
__rt_pad_after.L47:
	# return
__rt_pad_after.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fmt_int
	.text
# ---------------------------------------------------------------
# function fmt_int (line 169), returns void
# frame 432 bytes ($fp = $sp at entry):
#   0($fp)	param v (int, arrives in $a0)
#   4($fp)	param conv (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -32($fp)	local dg : char [16] (16 bytes)
#   -16($fp)	local pre : char [4] (4 bytes)
#   -36($fp)	%v : int
#   -40($fp)	%conv : int
#   -44($fp)	%nd : int
#   -48($fp)	%np : int
#   -52($fp)	%zeros : int
#   -56($fp)	%base : int
#   -60($fp)	%len : int
#   -64($fp)	%i : int
#   -68($fp)	%t8 : int
#   -72($fp)	%t9 : int
#   -76($fp)	%t10 : int
#   -80($fp)	%t11 : int
#   -84($fp)	%t12 : int
#   -88($fp)	%t13 : int
#   -92($fp)	%t14 : ptr
#   -96($fp)	%t15 : int
#   -100($fp)	%t16 : int
#   -104($fp)	%t17 : str
#   -108($fp)	%t18 : int
#   -112($fp)	%t19 : ptr
#   -116($fp)	%t20 : int
#   -120($fp)	%t21 : ptr
#   -124($fp)	%t22 : int
#   -128($fp)	%t23 : int
#   -132($fp)	%t24 : str
#   -136($fp)	%t25 : ptr
#   -140($fp)	%t26 : int
#   -144($fp)	%t27 : ptr
#   -148($fp)	%t28 : int
#   -152($fp)	%t29 : int
#   -156($fp)	%t30 : str
#   -160($fp)	%t31 : int
#   -164($fp)	%t32 : ptr
#   -168($fp)	%t33 : int
#   -172($fp)	%t34 : int
#   -176($fp)	%t35 : int
#   -180($fp)	%t36 : ptr
#   -184($fp)	%t37 : int
#   -188($fp)	%t38 : ptr
#   -192($fp)	%t39 : int
#   -196($fp)	%t40 : int
#   -200($fp)	%t41 : ptr
#   -204($fp)	%t42 : int
#   -208($fp)	%t43 : int
#   -212($fp)	%t44 : int
#   -216($fp)	%t45 : ptr
#   -220($fp)	%t46 : int
#   -224($fp)	%t47 : int
#   -228($fp)	%t48 : int
#   -232($fp)	%t49 : ptr
#   -236($fp)	%t50 : int
#   -240($fp)	%t51 : str
#   -244($fp)	%t52 : char
#   -248($fp)	%t53 : int
#   -252($fp)	%t54 : int
#   -256($fp)	%t55 : int
#   -260($fp)	%t56 : ptr
#   -264($fp)	%t57 : int
#   -268($fp)	%t58 : int
#   -272($fp)	%t59 : ptr
#   -276($fp)	%t60 : int
#   -280($fp)	%t61 : int
#   -284($fp)	%t62 : str
#   -288($fp)	%t63 : ptr
#   -292($fp)	%t64 : int
#   -296($fp)	%t65 : int
#   -300($fp)	%t66 : str
#   -304($fp)	%t67 : char
#   -308($fp)	%t68 : char
#   -312($fp)	%t69 : int
#   -316($fp)	%t70 : int
#   -320($fp)	%t71 : ptr
#   -324($fp)	%t72 : int
#   -328($fp)	%t73 : ptr
#   -332($fp)	%t74 : int
#   -336($fp)	%t75 : ptr
#   -340($fp)	%t76 : int
#   -344($fp)	%t77 : int
#   -348($fp)	%t78 : ptr
#   -352($fp)	%t79 : int
#   -356($fp)	%t80 : int
#   -360($fp)	%t81 : ptr
#   -364($fp)	%t82 : int
#   -368($fp)	%t83 : int
#   -372($fp)	%t84 : int
#   -376($fp)	%t85 : ptr
#   -380($fp)	%t86 : int
#   -384($fp)	%t87 : ptr
#   -388($fp)	%t88 : int
#   -392($fp)	%t89 : int
#   -396($fp)	%t90 : int
#   -400($fp)	%t91 : ptr
#   -404($fp)	%t92 : str
#   -408($fp)	%t93 : char
#   -412($fp)	%t94 : int
#   -416($fp)	%t95 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fmt_int
__rt_fmt_int:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -432
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param v : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -36($fp)
	# param conv : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -40($fp)
	# %base = 10   ; line 173
	li      $t0, 10
	sw      $t0, -56($fp)
	# %np = 0   ; line 174
	move    $t0, $zero
	sw      $t0, -48($fp)
	# %t8 = %conv == 111   ; line 175
	lw      $t0, -40($fp)
	xori    $t0, $t0, 111
	sltiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t8 goto .L49   ; line 175
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_fmt_int.L49
	# %base = 8   ; line 175
	li      $t0, 8
	sw      $t0, -56($fp)
__rt_fmt_int.L49:
	# %t9 = %conv == 120   ; line 176
	lw      $t0, -40($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -72($fp)
	# if %t9 goto .L50   ; line 176
	lw      $t0, -72($fp)
	bne     $t0, $zero, __rt_fmt_int.L50
	# %t10 = %conv == 88   ; line 176
	lw      $t0, -40($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -76($fp)
	# ifFalse %t10 goto .L51   ; line 176
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_fmt_int.L51
__rt_fmt_int.L50:
	# %base = 16   ; line 176
	li      $t0, 16
	sw      $t0, -56($fp)
__rt_fmt_int.L51:
	# %t11 = %conv == 100   ; line 177
	lw      $t0, -40($fp)
	xori    $t0, $t0, 100
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# if %t11 goto .L52   ; line 177
	lw      $t0, -80($fp)
	bne     $t0, $zero, __rt_fmt_int.L52
	# %t12 = %conv == 105   ; line 177
	lw      $t0, -40($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# ifFalse %t12 goto .L53   ; line 177
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_fmt_int.L53
__rt_fmt_int.L52:
	# %t13 = %v < 0   ; line 178
	lw      $t0, -36($fp)
	slti    $t0, $t0, 0
	sw      $t0, -88($fp)
	# ifFalse %t13 goto .L55   ; line 178
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_fmt_int.L55
	# %t14 = addr pre   ; line 179
	addiu   $t0, $fp, -16
	sw      $t0, -92($fp)
	# %t15 = %np   ; line 179
	lw      $t0, -48($fp)
	sw      $t0, -96($fp)
	# %t16 = %t15 + 1   ; line 179
	lw      $t0, -96($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# %np = %t16   ; line 179
	lw      $t0, -100($fp)
	sw      $t0, -48($fp)
	# %t17 = %t14 + %t15   ; line 179
	lw      $t0, -92($fp)
	lw      $t1, -96($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -104($fp)
	# store.b %t17, 45   ; line 179
	lw      $t0, -104($fp)
	li      $t1, 45
	sb      $t1, 0($t0)
	# %t18 = - %v   ; line 180
	lw      $t0, -36($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -108($fp)
	# %v = %t18   ; line 180
	lw      $t0, -108($fp)
	sw      $t0, -36($fp)
	# goto .L56   ; line 180
	b       __rt_fmt_int.L56
__rt_fmt_int.L55:
	# %t19 = addr @pf_plus   ; line 181
	la      $t0, __rtg_pf_plus
	sw      $t0, -112($fp)
	# %t20 = load.w %t19   ; line 181
	lw      $t0, -112($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# ifFalse %t20 goto .L58   ; line 181
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_fmt_int.L58
	# %t21 = addr pre   ; line 181
	addiu   $t0, $fp, -16
	sw      $t0, -120($fp)
	# %t22 = %np   ; line 181
	lw      $t0, -48($fp)
	sw      $t0, -124($fp)
	# %t23 = %t22 + 1   ; line 181
	lw      $t0, -124($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -128($fp)
	# %np = %t23   ; line 181
	lw      $t0, -128($fp)
	sw      $t0, -48($fp)
	# %t24 = %t21 + %t22   ; line 181
	lw      $t0, -120($fp)
	lw      $t1, -124($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -132($fp)
	# store.b %t24, 43   ; line 181
	lw      $t0, -132($fp)
	li      $t1, 43
	sb      $t1, 0($t0)
	# goto .L59   ; line 181
	b       __rt_fmt_int.L59
__rt_fmt_int.L58:
	# %t25 = addr @pf_space   ; line 182
	la      $t0, __rtg_pf_space
	sw      $t0, -136($fp)
	# %t26 = load.w %t25   ; line 182
	lw      $t0, -136($fp)
	lw      $t1, 0($t0)
	sw      $t1, -140($fp)
	# ifFalse %t26 goto .L61   ; line 182
	lw      $t0, -140($fp)
	beq     $t0, $zero, __rt_fmt_int.L61
	# %t27 = addr pre   ; line 182
	addiu   $t0, $fp, -16
	sw      $t0, -144($fp)
	# %t28 = %np   ; line 182
	lw      $t0, -48($fp)
	sw      $t0, -148($fp)
	# %t29 = %t28 + 1   ; line 182
	lw      $t0, -148($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# %np = %t29   ; line 182
	lw      $t0, -152($fp)
	sw      $t0, -48($fp)
	# %t30 = %t27 + %t28   ; line 182
	lw      $t0, -144($fp)
	lw      $t1, -148($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -156($fp)
	# store.b %t30, 32   ; line 182
	lw      $t0, -156($fp)
	li      $t1, 32
	sb      $t1, 0($t0)
__rt_fmt_int.L61:
__rt_fmt_int.L59:
__rt_fmt_int.L56:
__rt_fmt_int.L53:
	# %nd = 0   ; line 184
	move    $t0, $zero
	sw      $t0, -44($fp)
	# %t31 = %v == 0   ; line 185
	lw      $t0, -36($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -160($fp)
	# ifFalse %t31 goto .L62   ; line 185
	lw      $t0, -160($fp)
	beq     $t0, $zero, __rt_fmt_int.L62
	# %t32 = addr @pf_prec   ; line 185
	la      $t0, __rtg_pf_prec
	sw      $t0, -164($fp)
	# %t33 = load.w %t32   ; line 185
	lw      $t0, -164($fp)
	lw      $t1, 0($t0)
	sw      $t1, -168($fp)
	# %t34 = %t33 == 0   ; line 185
	lw      $t0, -168($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -172($fp)
	# if %t34 goto .L63   ; line 185
	lw      $t0, -172($fp)
	bne     $t0, $zero, __rt_fmt_int.L63
__rt_fmt_int.L62:
	# %t35 = %conv == 88   ; line 185
	lw      $t0, -40($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -176($fp)
	# %t36 = addr dg   ; line 185
	addiu   $t0, $fp, -32
	sw      $t0, -180($fp)
	# param %v : int   ; line 185
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# param %base : int   ; line 185
	lw      $t0, -56($fp)
	sw      $t0, 4($sp)
	# param %t35 : int   ; line 185
	lw      $t0, -176($fp)
	sw      $t0, 8($sp)
	# param %t36 : str   ; line 185
	lw      $t0, -180($fp)
	sw      $t0, 12($sp)
	# %t37 = call @udigits, 4   ; line 185
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_udigits
	sw      $v0, -184($fp)
	# %nd = %t37   ; line 185
	lw      $t0, -184($fp)
	sw      $t0, -44($fp)
__rt_fmt_int.L63:
	# %zeros = 0   ; line 186
	move    $t0, $zero
	sw      $t0, -52($fp)
	# %t38 = addr @pf_prec   ; line 187
	la      $t0, __rtg_pf_prec
	sw      $t0, -188($fp)
	# %t39 = load.w %t38   ; line 187
	lw      $t0, -188($fp)
	lw      $t1, 0($t0)
	sw      $t1, -192($fp)
	# %t40 = %t39 > %nd   ; line 187
	lw      $t0, -192($fp)
	lw      $t1, -44($fp)
	slt     $t0, $t1, $t0
	sw      $t0, -196($fp)
	# ifFalse %t40 goto .L65   ; line 187
	lw      $t0, -196($fp)
	beq     $t0, $zero, __rt_fmt_int.L65
	# %t41 = addr @pf_prec   ; line 187
	la      $t0, __rtg_pf_prec
	sw      $t0, -200($fp)
	# %t42 = load.w %t41   ; line 187
	lw      $t0, -200($fp)
	lw      $t1, 0($t0)
	sw      $t1, -204($fp)
	# %t43 = %t42 - %nd   ; line 187
	lw      $t0, -204($fp)
	lw      $t1, -44($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -208($fp)
	# %zeros = %t43   ; line 187
	lw      $t0, -208($fp)
	sw      $t0, -52($fp)
__rt_fmt_int.L65:
	# %t44 = %conv == 111   ; line 188
	lw      $t0, -40($fp)
	xori    $t0, $t0, 111
	sltiu   $t0, $t0, 1
	sw      $t0, -212($fp)
	# ifFalse %t44 goto .L67   ; line 188
	lw      $t0, -212($fp)
	beq     $t0, $zero, __rt_fmt_int.L67
	# %t45 = addr @pf_alt   ; line 188
	la      $t0, __rtg_pf_alt
	sw      $t0, -216($fp)
	# %t46 = load.w %t45   ; line 188
	lw      $t0, -216($fp)
	lw      $t1, 0($t0)
	sw      $t1, -220($fp)
	# ifFalse %t46 goto .L67   ; line 188
	lw      $t0, -220($fp)
	beq     $t0, $zero, __rt_fmt_int.L67
	# %t47 = %zeros == 0   ; line 188
	lw      $t0, -52($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -224($fp)
	# ifFalse %t47 goto .L67   ; line 188
	lw      $t0, -224($fp)
	beq     $t0, $zero, __rt_fmt_int.L67
	# %t48 = %nd == 0   ; line 188
	lw      $t0, -44($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -228($fp)
	# if %t48 goto .L66   ; line 188
	lw      $t0, -228($fp)
	bne     $t0, $zero, __rt_fmt_int.L66
	# %t49 = addr dg   ; line 188
	addiu   $t0, $fp, -32
	sw      $t0, -232($fp)
	# %t50 = %nd - 1   ; line 188
	lw      $t0, -44($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -236($fp)
	# %t51 = %t49 + %t50   ; line 188
	lw      $t0, -232($fp)
	lw      $t1, -236($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -240($fp)
	# %t52 = load.b %t51   ; line 188
	lw      $t0, -240($fp)
	lb      $t1, 0($t0)
	sw      $t1, -244($fp)
	# %t53 = %t52 != 48   ; line 188
	lw      $t0, -244($fp)
	xori    $t0, $t0, 48
	sltu    $t0, $zero, $t0
	sw      $t0, -248($fp)
	# ifFalse %t53 goto .L67   ; line 188
	lw      $t0, -248($fp)
	beq     $t0, $zero, __rt_fmt_int.L67
__rt_fmt_int.L66:
	# %zeros = 1   ; line 189
	li      $t0, 1
	sw      $t0, -52($fp)
__rt_fmt_int.L67:
	# %t54 = %conv == 120   ; line 190
	lw      $t0, -40($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -252($fp)
	# if %t54 goto .L70   ; line 190
	lw      $t0, -252($fp)
	bne     $t0, $zero, __rt_fmt_int.L70
	# %t55 = %conv == 88   ; line 190
	lw      $t0, -40($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -256($fp)
	# ifFalse %t55 goto .L69   ; line 190
	lw      $t0, -256($fp)
	beq     $t0, $zero, __rt_fmt_int.L69
__rt_fmt_int.L70:
	# %t56 = addr @pf_alt   ; line 190
	la      $t0, __rtg_pf_alt
	sw      $t0, -260($fp)
	# %t57 = load.w %t56   ; line 190
	lw      $t0, -260($fp)
	lw      $t1, 0($t0)
	sw      $t1, -264($fp)
	# ifFalse %t57 goto .L69   ; line 190
	lw      $t0, -264($fp)
	beq     $t0, $zero, __rt_fmt_int.L69
	# %t58 = %v != 0   ; line 190
	lw      $t0, -36($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -268($fp)
	# ifFalse %t58 goto .L69   ; line 190
	lw      $t0, -268($fp)
	beq     $t0, $zero, __rt_fmt_int.L69
	# %t59 = addr pre   ; line 191
	addiu   $t0, $fp, -16
	sw      $t0, -272($fp)
	# %t60 = %np   ; line 191
	lw      $t0, -48($fp)
	sw      $t0, -276($fp)
	# %t61 = %t60 + 1   ; line 191
	lw      $t0, -276($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -280($fp)
	# %np = %t61   ; line 191
	lw      $t0, -280($fp)
	sw      $t0, -48($fp)
	# %t62 = %t59 + %t60   ; line 191
	lw      $t0, -272($fp)
	lw      $t1, -276($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -284($fp)
	# store.b %t62, 48   ; line 191
	lw      $t0, -284($fp)
	li      $t1, 48
	sb      $t1, 0($t0)
	# %t63 = addr pre   ; line 192
	addiu   $t0, $fp, -16
	sw      $t0, -288($fp)
	# %t64 = %np   ; line 192
	lw      $t0, -48($fp)
	sw      $t0, -292($fp)
	# %t65 = %t64 + 1   ; line 192
	lw      $t0, -292($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -296($fp)
	# %np = %t65   ; line 192
	lw      $t0, -296($fp)
	sw      $t0, -48($fp)
	# %t66 = %t63 + %t64   ; line 192
	lw      $t0, -288($fp)
	lw      $t1, -292($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -300($fp)
	# %t67 = sext.b %conv   ; line 192
	lw      $t0, -40($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -304($fp)
	# store.b %t66, %t67   ; line 192
	lw      $t0, -300($fp)
	lw      $t1, -304($fp)
	sb      $t1, 0($t0)
	# %t68 = sext.b %t67   ; line 192
	lw      $t0, -304($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -308($fp)
__rt_fmt_int.L69:
	# %t69 = %np + %zeros   ; line 194
	lw      $t0, -48($fp)
	lw      $t1, -52($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -312($fp)
	# %t70 = %t69 + %nd   ; line 194
	lw      $t0, -312($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -316($fp)
	# %len = %t70   ; line 194
	lw      $t0, -316($fp)
	sw      $t0, -60($fp)
	# %t71 = addr @pf_zero   ; line 195
	la      $t0, __rtg_pf_zero
	sw      $t0, -320($fp)
	# %t72 = load.w %t71   ; line 195
	lw      $t0, -320($fp)
	lw      $t1, 0($t0)
	sw      $t1, -324($fp)
	# ifFalse %t72 goto .L72   ; line 195
	lw      $t0, -324($fp)
	beq     $t0, $zero, __rt_fmt_int.L72
	# %t73 = addr @pf_left   ; line 195
	la      $t0, __rtg_pf_left
	sw      $t0, -328($fp)
	# %t74 = load.w %t73   ; line 195
	lw      $t0, -328($fp)
	lw      $t1, 0($t0)
	sw      $t1, -332($fp)
	# if %t74 goto .L72   ; line 195
	lw      $t0, -332($fp)
	bne     $t0, $zero, __rt_fmt_int.L72
	# %t75 = addr @pf_prec   ; line 195
	la      $t0, __rtg_pf_prec
	sw      $t0, -336($fp)
	# %t76 = load.w %t75   ; line 195
	lw      $t0, -336($fp)
	lw      $t1, 0($t0)
	sw      $t1, -340($fp)
	# %t77 = %t76 < 0   ; line 195
	lw      $t0, -340($fp)
	slti    $t0, $t0, 0
	sw      $t0, -344($fp)
	# ifFalse %t77 goto .L72   ; line 195
	lw      $t0, -344($fp)
	beq     $t0, $zero, __rt_fmt_int.L72
	# %t78 = addr @pf_width   ; line 195
	la      $t0, __rtg_pf_width
	sw      $t0, -348($fp)
	# %t79 = load.w %t78   ; line 195
	lw      $t0, -348($fp)
	lw      $t1, 0($t0)
	sw      $t1, -352($fp)
	# %t80 = %t79 > %len   ; line 195
	lw      $t0, -352($fp)
	lw      $t1, -60($fp)
	slt     $t0, $t1, $t0
	sw      $t0, -356($fp)
	# ifFalse %t80 goto .L72   ; line 195
	lw      $t0, -356($fp)
	beq     $t0, $zero, __rt_fmt_int.L72
	# %t81 = addr @pf_width   ; line 196
	la      $t0, __rtg_pf_width
	sw      $t0, -360($fp)
	# %t82 = load.w %t81   ; line 196
	lw      $t0, -360($fp)
	lw      $t1, 0($t0)
	sw      $t1, -364($fp)
	# %t83 = %zeros + %t82   ; line 196
	lw      $t0, -52($fp)
	lw      $t1, -364($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -368($fp)
	# %t84 = %t83 - %len   ; line 196
	lw      $t0, -368($fp)
	lw      $t1, -60($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -372($fp)
	# %zeros = %t84   ; line 196
	lw      $t0, -372($fp)
	sw      $t0, -52($fp)
	# %t85 = addr @pf_width   ; line 197
	la      $t0, __rtg_pf_width
	sw      $t0, -376($fp)
	# %t86 = load.w %t85   ; line 197
	lw      $t0, -376($fp)
	lw      $t1, 0($t0)
	sw      $t1, -380($fp)
	# %len = %t86   ; line 197
	lw      $t0, -380($fp)
	sw      $t0, -60($fp)
__rt_fmt_int.L72:
	# param %len : int   ; line 199
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 199
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# %t87 = addr pre   ; line 200
	addiu   $t0, $fp, -16
	sw      $t0, -384($fp)
	# param %t87 : str   ; line 200
	lw      $t0, -384($fp)
	sw      $t0, 0($sp)
	# param %np : int   ; line 200
	lw      $t0, -48($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 200
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# %t88 = 48   ; line 201
	li      $t0, 48
	sw      $t0, -388($fp)
	# param %t88 : int   ; line 201
	lw      $t0, -388($fp)
	sw      $t0, 0($sp)
	# param %zeros : int   ; line 201
	lw      $t0, -52($fp)
	sw      $t0, 4($sp)
	# call @out_pad, 2   ; line 201
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_pad
	# %t89 = %nd - 1   ; line 202
	lw      $t0, -44($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -392($fp)
	# %i = %t89   ; line 202
	lw      $t0, -392($fp)
	sw      $t0, -64($fp)
__rt_fmt_int.L73:
	# %t90 = %i >= 0   ; line 202
	lw      $t0, -64($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -396($fp)
	# ifFalse %t90 goto .L76   ; line 202
	lw      $t0, -396($fp)
	beq     $t0, $zero, __rt_fmt_int.L76
	# %t91 = addr dg   ; line 202
	addiu   $t0, $fp, -32
	sw      $t0, -400($fp)
	# %t92 = %t91 + %i   ; line 202
	lw      $t0, -400($fp)
	lw      $t1, -64($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -404($fp)
	# %t93 = load.b %t92   ; line 202
	lw      $t0, -404($fp)
	lb      $t1, 0($t0)
	sw      $t1, -408($fp)
	# param %t93 : int   ; line 202
	lw      $t0, -408($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 202
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t94 = %i   ; line 202
	lw      $t0, -64($fp)
	sw      $t0, -412($fp)
	# %t95 = %t94 - 1   ; line 202
	lw      $t0, -412($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -416($fp)
	# %i = %t95   ; line 202
	lw      $t0, -416($fp)
	sw      $t0, -64($fp)
	# goto .L73   ; line 202
	b       __rt_fmt_int.L73
__rt_fmt_int.L76:
	# param %len : int   ; line 203
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 203
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# return
__rt_fmt_int.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fmt_str
	.text
# ---------------------------------------------------------------
# function fmt_str (line 208), returns void
# frame 112 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%n : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : str
#   -56($fp)	%t11 : str
#   -60($fp)	%t12 : char
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fmt_str
__rt_fmt_str:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -112
	sw      $a0, 0($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = %s == 0   ; line 210
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L78   ; line 210
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_fmt_str.L78
	# %t3 = addr @pf_prec   ; line 211
	la      $t0, __rtg_pf_prec
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 211
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = %t4 >= 0   ; line 211
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L80   ; line 211
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fmt_str.L80
	# %t6 = addr @pf_prec   ; line 211
	la      $t0, __rtg_pf_prec
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 211
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = %t7 < 6   ; line 211
	lw      $t0, -40($fp)
	slti    $t0, $t0, 6
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L80   ; line 211
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_fmt_str.L80
	# %t9 = addr @.str2   ; line 211
	la      $t0, __rtd.str2
	sw      $t0, -48($fp)
	# %s = %t9   ; line 211
	lw      $t0, -48($fp)
	sw      $t0, -12($fp)
	# goto .L81   ; line 211
	b       __rt_fmt_str.L81
__rt_fmt_str.L80:
	# %t10 = addr @.str3   ; line 212
	la      $t0, __rtd.str3
	sw      $t0, -52($fp)
	# %s = %t10   ; line 212
	lw      $t0, -52($fp)
	sw      $t0, -12($fp)
__rt_fmt_str.L81:
__rt_fmt_str.L78:
	# %n = 0   ; line 214
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_fmt_str.L82:
	# %t11 = %s + %n   ; line 215
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = load.b %t11   ; line 215
	lw      $t0, -56($fp)
	lb      $t1, 0($t0)
	sw      $t1, -60($fp)
	# ifFalse %t12 goto .L84   ; line 215
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_fmt_str.L84
	# %t13 = addr @pf_prec   ; line 215
	la      $t0, __rtg_pf_prec
	sw      $t0, -64($fp)
	# %t14 = load.w %t13   ; line 215
	lw      $t0, -64($fp)
	lw      $t1, 0($t0)
	sw      $t1, -68($fp)
	# %t15 = %t14 < 0   ; line 215
	lw      $t0, -68($fp)
	slti    $t0, $t0, 0
	sw      $t0, -72($fp)
	# if %t15 goto .L83   ; line 215
	lw      $t0, -72($fp)
	bne     $t0, $zero, __rt_fmt_str.L83
	# %t16 = addr @pf_prec   ; line 215
	la      $t0, __rtg_pf_prec
	sw      $t0, -76($fp)
	# %t17 = load.w %t16   ; line 215
	lw      $t0, -76($fp)
	lw      $t1, 0($t0)
	sw      $t1, -80($fp)
	# %t18 = %n < %t17   ; line 215
	lw      $t0, -16($fp)
	lw      $t1, -80($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -84($fp)
	# ifFalse %t18 goto .L84   ; line 215
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_fmt_str.L84
__rt_fmt_str.L83:
	# %t19 = %n   ; line 215
	lw      $t0, -16($fp)
	sw      $t0, -88($fp)
	# %t20 = %t19 + 1   ; line 215
	lw      $t0, -88($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -92($fp)
	# %n = %t20   ; line 215
	lw      $t0, -92($fp)
	sw      $t0, -16($fp)
	# goto .L82   ; line 215
	b       __rt_fmt_str.L82
__rt_fmt_str.L84:
	# param %n : int   ; line 216
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 216
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# param %s : str   ; line 217
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %n : int   ; line 217
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 217
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# param %n : int   ; line 218
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 218
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# return
__rt_fmt_str.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fd_mul
	.text
# ---------------------------------------------------------------
# function fd_mul (line 236), returns void
# frame 144 bytes ($fp = $sp at entry):
#   0($fp)	param m (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%m : int
#   -16($fp)	%i : int
#   -20($fp)	%t : int
#   -24($fp)	%carry : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : ptr
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fd_mul
__rt_fd_mul:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -144
	sw      $a0, 0($fp)
	# param m : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %carry = 0   ; line 238
	move    $t0, $zero
	sw      $t0, -24($fp)
	# %i = 0   ; line 239
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_fd_mul.L85:
	# %t4 = addr @fd_nbig   ; line 239
	la      $t0, __rtg_fd_nbig
	sw      $t0, -28($fp)
	# %t5 = load.w %t4   ; line 239
	lw      $t0, -28($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %i < %t5   ; line 239
	lw      $t0, -16($fp)
	lw      $t1, -32($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L88   ; line 239
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_fd_mul.L88
	# %t7 = addr @fd_big   ; line 240
	la      $t0, __rtg_fd_big
	sw      $t0, -40($fp)
	# %t8 = %i * 4   ; line 240
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = %t7 + %t8   ; line 240
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 240
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 * %m   ; line 240
	lw      $t0, -52($fp)
	lw      $t1, -12($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = %t11 + %carry   ; line 240
	lw      $t0, -56($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t = %t12   ; line 240
	lw      $t0, -60($fp)
	sw      $t0, -20($fp)
	# %t13 = addr @fd_big   ; line 241
	la      $t0, __rtg_fd_big
	sw      $t0, -64($fp)
	# %t14 = %i * 4   ; line 241
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = %t13 + %t14   ; line 241
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = %t % 10000   ; line 241
	lw      $t0, -20($fp)
	li      $t1, 10000
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -76($fp)
	# store.w %t15, %t16   ; line 241
	lw      $t0, -72($fp)
	lw      $t1, -76($fp)
	sw      $t1, 0($t0)
	# %t17 = %t / 10000   ; line 242
	lw      $t0, -20($fp)
	li      $t1, 10000
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -80($fp)
	# %carry = %t17   ; line 242
	lw      $t0, -80($fp)
	sw      $t0, -24($fp)
	# %t18 = %i   ; line 239
	lw      $t0, -16($fp)
	sw      $t0, -84($fp)
	# %t19 = %t18 + 1   ; line 239
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %i = %t19   ; line 239
	lw      $t0, -88($fp)
	sw      $t0, -16($fp)
	# goto .L85   ; line 239
	b       __rt_fd_mul.L85
__rt_fd_mul.L88:
__rt_fd_mul.L89:
	# ifFalse %carry goto .L91   ; line 244
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_fd_mul.L91
	# %t20 = addr @fd_big   ; line 245
	la      $t0, __rtg_fd_big
	sw      $t0, -92($fp)
	# %t21 = addr @fd_nbig   ; line 245
	la      $t0, __rtg_fd_nbig
	sw      $t0, -96($fp)
	# %t22 = load.w %t21   ; line 245
	lw      $t0, -96($fp)
	lw      $t1, 0($t0)
	sw      $t1, -100($fp)
	# %t23 = %t22   ; line 245
	lw      $t0, -100($fp)
	sw      $t0, -104($fp)
	# %t24 = %t23 + 1   ; line 245
	lw      $t0, -104($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# store.w %t21, %t24   ; line 245
	lw      $t0, -96($fp)
	lw      $t1, -108($fp)
	sw      $t1, 0($t0)
	# %t25 = %t23 * 4   ; line 245
	lw      $t0, -104($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -112($fp)
	# %t26 = %t20 + %t25   ; line 245
	lw      $t0, -92($fp)
	lw      $t1, -112($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -116($fp)
	# %t27 = %carry % 10000   ; line 245
	lw      $t0, -24($fp)
	li      $t1, 10000
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -120($fp)
	# store.w %t26, %t27   ; line 245
	lw      $t0, -116($fp)
	lw      $t1, -120($fp)
	sw      $t1, 0($t0)
	# %t28 = %carry / 10000   ; line 246
	lw      $t0, -24($fp)
	li      $t1, 10000
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -124($fp)
	# %carry = %t28   ; line 246
	lw      $t0, -124($fp)
	sw      $t0, -24($fp)
	# goto .L89   ; line 246
	b       __rt_fd_mul.L89
__rt_fd_mul.L91:
	# return
__rt_fd_mul.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fd_add
	.text
# ---------------------------------------------------------------
# function fd_add (line 251), returns void
# frame 120 bytes ($fp = $sp at entry):
#   0($fp)	param a (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%a : int
#   -16($fp)	%i : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : ptr
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fd_add
__rt_fd_add:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -120
	sw      $a0, 0($fp)
	# param a : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %i = 0   ; line 253
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_fd_add.L92:
	# ifFalse %a goto .L94   ; line 254
	lw      $t0, -12($fp)
	beq     $t0, $zero, __rt_fd_add.L94
	# %t2 = addr @fd_nbig   ; line 255
	la      $t0, __rtg_fd_nbig
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 255
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = %i == %t3   ; line 255
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L96   ; line 255
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_fd_add.L96
	# %t5 = addr @fd_big   ; line 255
	la      $t0, __rtg_fd_big
	sw      $t0, -32($fp)
	# %t6 = addr @fd_nbig   ; line 255
	la      $t0, __rtg_fd_nbig
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 255
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = %t7   ; line 255
	lw      $t0, -40($fp)
	sw      $t0, -44($fp)
	# %t9 = %t8 + 1   ; line 255
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -48($fp)
	# store.w %t6, %t9   ; line 255
	lw      $t0, -36($fp)
	lw      $t1, -48($fp)
	sw      $t1, 0($t0)
	# %t10 = %t8 * 4   ; line 255
	lw      $t0, -44($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %t11 = %t5 + %t10   ; line 255
	lw      $t0, -32($fp)
	lw      $t1, -52($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# store.w %t11, 0   ; line 255
	lw      $t0, -56($fp)
	sw      $zero, 0($t0)
__rt_fd_add.L96:
	# %t12 = addr @fd_big   ; line 256
	la      $t0, __rtg_fd_big
	sw      $t0, -60($fp)
	# %t13 = %i * 4   ; line 256
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %t14 = %t12 + %t13   ; line 256
	lw      $t0, -60($fp)
	lw      $t1, -64($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 256
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t16 = %a + %t15   ; line 256
	lw      $t0, -12($fp)
	lw      $t1, -72($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -76($fp)
	# %a = %t16   ; line 256
	lw      $t0, -76($fp)
	sw      $t0, -12($fp)
	# %t17 = addr @fd_big   ; line 257
	la      $t0, __rtg_fd_big
	sw      $t0, -80($fp)
	# %t18 = %i * 4   ; line 257
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %t19 = %t17 + %t18   ; line 257
	lw      $t0, -80($fp)
	lw      $t1, -84($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t20 = %a % 10000   ; line 257
	lw      $t0, -12($fp)
	li      $t1, 10000
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -92($fp)
	# store.w %t19, %t20   ; line 257
	lw      $t0, -88($fp)
	lw      $t1, -92($fp)
	sw      $t1, 0($t0)
	# %t21 = %a / 10000   ; line 258
	lw      $t0, -12($fp)
	li      $t1, 10000
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -96($fp)
	# %a = %t21   ; line 258
	lw      $t0, -96($fp)
	sw      $t0, -12($fp)
	# %t22 = %i   ; line 259
	lw      $t0, -16($fp)
	sw      $t0, -100($fp)
	# %t23 = %t22 + 1   ; line 259
	lw      $t0, -100($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -104($fp)
	# %i = %t23   ; line 259
	lw      $t0, -104($fp)
	sw      $t0, -16($fp)
	# goto .L92   ; line 259
	b       __rt_fd_add.L92
__rt_fd_add.L94:
	# return
__rt_fd_add.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fd_decode
	.text
# ---------------------------------------------------------------
# function fd_decode (line 265), returns void
# frame 456 bytes ($fp = $sp at entry):
#   0($fp)	param hi (int, arrives in $a0)
#   4($fp)	param lo (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%hi : int
#   -16($fp)	%lo : int
#   -20($fp)	%ex : int
#   -24($fp)	%e : int
#   -28($fp)	%k : int
#   -32($fp)	%t : int
#   -36($fp)	%i : int
#   -40($fp)	%j : int
#   -44($fp)	%nd : int
#   -48($fp)	%frac : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : int
#   -152($fp)	%t35 : int
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : int
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : ptr
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : int
#   -184($fp)	%t43 : int
#   -188($fp)	%t44 : ptr
#   -192($fp)	%t45 : int
#   -196($fp)	%t46 : ptr
#   -200($fp)	%t47 : int
#   -204($fp)	%t48 : ptr
#   -208($fp)	%t49 : str
#   -212($fp)	%t50 : int
#   -216($fp)	%t51 : int
#   -220($fp)	%t52 : char
#   -224($fp)	%t53 : char
#   -228($fp)	%t54 : ptr
#   -232($fp)	%t55 : int
#   -236($fp)	%t56 : str
#   -240($fp)	%t57 : int
#   -244($fp)	%t58 : int
#   -248($fp)	%t59 : int
#   -252($fp)	%t60 : char
#   -256($fp)	%t61 : char
#   -260($fp)	%t62 : ptr
#   -264($fp)	%t63 : int
#   -268($fp)	%t64 : str
#   -272($fp)	%t65 : int
#   -276($fp)	%t66 : int
#   -280($fp)	%t67 : int
#   -284($fp)	%t68 : char
#   -288($fp)	%t69 : char
#   -292($fp)	%t70 : ptr
#   -296($fp)	%t71 : int
#   -300($fp)	%t72 : str
#   -304($fp)	%t73 : int
#   -308($fp)	%t74 : int
#   -312($fp)	%t75 : char
#   -316($fp)	%t76 : char
#   -320($fp)	%t77 : int
#   -324($fp)	%t78 : int
#   -328($fp)	%t79 : int
#   -332($fp)	%t80 : ptr
#   -336($fp)	%t81 : str
#   -340($fp)	%t82 : char
#   -344($fp)	%t83 : int
#   -348($fp)	%t84 : int
#   -352($fp)	%t85 : int
#   -356($fp)	%t86 : int
#   -360($fp)	%t87 : ptr
#   -364($fp)	%t88 : int
#   -368($fp)	%t89 : str
#   -372($fp)	%t90 : ptr
#   -376($fp)	%t91 : str
#   -380($fp)	%t92 : char
#   -384($fp)	%t93 : char
#   -388($fp)	%t94 : int
#   -392($fp)	%t95 : int
#   -396($fp)	%t96 : int
#   -400($fp)	%t97 : ptr
#   -404($fp)	%t98 : int
#   -408($fp)	%t99 : int
#   -412($fp)	%t100 : ptr
#   -416($fp)	%t101 : int
#   -420($fp)	%t102 : str
#   -424($fp)	%t103 : char
#   -428($fp)	%t104 : int
#   -432($fp)	%t105 : int
#   -436($fp)	%t106 : int
#   -440($fp)	%t107 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fd_decode
__rt_fd_decode:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -456
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param hi : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param lo : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t10 = %hi >> 20   ; line 267
	lw      $t0, -12($fp)
	sra     $t0, $t0, 20
	sw      $t0, -52($fp)
	# %t11 = %t10 & 2047   ; line 267
	lw      $t0, -52($fp)
	andi    $t0, $t0, 2047
	sw      $t0, -56($fp)
	# %ex = %t11   ; line 267
	lw      $t0, -56($fp)
	sw      $t0, -20($fp)
	# %t12 = %hi & 1048575   ; line 268
	lw      $t0, -12($fp)
	li      $t1, 1048575
	and     $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %hi = %t12   ; line 268
	lw      $t0, -60($fp)
	sw      $t0, -12($fp)
	# ifFalse %ex goto .L98   ; line 269
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_fd_decode.L98
	# %t13 = %hi | 1048576   ; line 270
	lw      $t0, -12($fp)
	li      $t1, 1048576
	or      $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %hi = %t13   ; line 270
	lw      $t0, -64($fp)
	sw      $t0, -12($fp)
	# %t14 = %ex - 1075   ; line 271
	lw      $t0, -20($fp)
	addiu   $t0, $t0, -1075
	sw      $t0, -68($fp)
	# %e = %t14   ; line 271
	lw      $t0, -68($fp)
	sw      $t0, -24($fp)
	# goto .L99   ; line 271
	b       __rt_fd_decode.L99
__rt_fd_decode.L98:
	# %e = -1074   ; line 272
	li      $t0, -1074
	sw      $t0, -24($fp)
__rt_fd_decode.L99:
	# %t15 = addr @fd_nbig   ; line 273
	la      $t0, __rtg_fd_nbig
	sw      $t0, -72($fp)
	# store.w %t15, 0   ; line 273
	lw      $t0, -72($fp)
	sw      $zero, 0($t0)
	# param %hi : int   ; line 274
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# call @fd_add, 1   ; line 274
	lw      $a0, 0($sp)
	jal     __rt_fd_add
	# %t16 = 65536   ; line 275
	li      $t0, 65536
	sw      $t0, -76($fp)
	# param %t16 : int   ; line 275
	lw      $t0, -76($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 275
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
	# %t17 = %lo >> 16   ; line 276
	lw      $t0, -16($fp)
	sra     $t0, $t0, 16
	sw      $t0, -80($fp)
	# %t18 = %t17 & 65535   ; line 276
	lw      $t0, -80($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -84($fp)
	# param %t18 : int   ; line 276
	lw      $t0, -84($fp)
	sw      $t0, 0($sp)
	# call @fd_add, 1   ; line 276
	lw      $a0, 0($sp)
	jal     __rt_fd_add
	# %t19 = 65536   ; line 277
	li      $t0, 65536
	sw      $t0, -88($fp)
	# param %t19 : int   ; line 277
	lw      $t0, -88($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 277
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
	# %t20 = %lo & 65535   ; line 278
	lw      $t0, -16($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -92($fp)
	# param %t20 : int   ; line 278
	lw      $t0, -92($fp)
	sw      $t0, 0($sp)
	# call @fd_add, 1   ; line 278
	lw      $a0, 0($sp)
	jal     __rt_fd_add
	# %t21 = addr @fd_n   ; line 279
	la      $t0, __rtg_fd_n
	sw      $t0, -96($fp)
	# store.w %t21, 0   ; line 279
	lw      $t0, -96($fp)
	sw      $zero, 0($t0)
	# %t22 = addr @fd_exp   ; line 280
	la      $t0, __rtg_fd_exp
	sw      $t0, -100($fp)
	# store.w %t22, 0   ; line 280
	lw      $t0, -100($fp)
	sw      $zero, 0($t0)
	# %t23 = addr @fd_nbig   ; line 281
	la      $t0, __rtg_fd_nbig
	sw      $t0, -104($fp)
	# %t24 = load.w %t23   ; line 281
	lw      $t0, -104($fp)
	lw      $t1, 0($t0)
	sw      $t1, -108($fp)
	# %t25 = %t24 == 0   ; line 281
	lw      $t0, -108($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# ifFalse %t25 goto .L101   ; line 281
	lw      $t0, -112($fp)
	beq     $t0, $zero, __rt_fd_decode.L101
	# return   ; line 281
	b       __rt_fd_decode.ret
__rt_fd_decode.L101:
	# %frac = 0   ; line 282
	move    $t0, $zero
	sw      $t0, -48($fp)
	# %t26 = %e > 0   ; line 283
	lw      $t0, -24($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -116($fp)
	# ifFalse %t26 goto .L103   ; line 283
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_fd_decode.L103
	# %k = %e   ; line 284
	lw      $t0, -24($fp)
	sw      $t0, -28($fp)
__rt_fd_decode.L104:
	# %t27 = %k >= 13   ; line 285
	lw      $t0, -28($fp)
	slti    $t0, $t0, 13
	xori    $t0, $t0, 1
	sw      $t0, -120($fp)
	# ifFalse %t27 goto .L106   ; line 285
	lw      $t0, -120($fp)
	beq     $t0, $zero, __rt_fd_decode.L106
	# %t28 = 8192   ; line 285
	li      $t0, 8192
	sw      $t0, -124($fp)
	# param %t28 : int   ; line 285
	lw      $t0, -124($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 285
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
	# %t29 = %k - 13   ; line 285
	lw      $t0, -28($fp)
	addiu   $t0, $t0, -13
	sw      $t0, -128($fp)
	# %k = %t29   ; line 285
	lw      $t0, -128($fp)
	sw      $t0, -28($fp)
	# goto .L104   ; line 285
	b       __rt_fd_decode.L104
__rt_fd_decode.L106:
	# %t30 = 1 << %k   ; line 286
	li      $t0, 1
	lw      $t1, -28($fp)
	sllv    $t0, $t0, $t1
	sw      $t0, -132($fp)
	# param %t30 : int   ; line 286
	lw      $t0, -132($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 286
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
	# goto .L107   ; line 286
	b       __rt_fd_decode.L107
__rt_fd_decode.L103:
	# %t31 = %e < 0   ; line 287
	lw      $t0, -24($fp)
	slti    $t0, $t0, 0
	sw      $t0, -136($fp)
	# ifFalse %t31 goto .L109   ; line 287
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_fd_decode.L109
	# %t32 = - %e   ; line 288
	lw      $t0, -24($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -140($fp)
	# %k = %t32   ; line 288
	lw      $t0, -140($fp)
	sw      $t0, -28($fp)
	# %frac = %k   ; line 289
	lw      $t0, -28($fp)
	sw      $t0, -48($fp)
__rt_fd_decode.L110:
	# %t33 = %k >= 7   ; line 290
	lw      $t0, -28($fp)
	slti    $t0, $t0, 7
	xori    $t0, $t0, 1
	sw      $t0, -144($fp)
	# ifFalse %t33 goto .L112   ; line 290
	lw      $t0, -144($fp)
	beq     $t0, $zero, __rt_fd_decode.L112
	# %t34 = 78125   ; line 290
	li      $t0, 78125
	sw      $t0, -148($fp)
	# param %t34 : int   ; line 290
	lw      $t0, -148($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 290
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
	# %t35 = %k - 7   ; line 290
	lw      $t0, -28($fp)
	addiu   $t0, $t0, -7
	sw      $t0, -152($fp)
	# %k = %t35   ; line 290
	lw      $t0, -152($fp)
	sw      $t0, -28($fp)
	# goto .L110   ; line 290
	b       __rt_fd_decode.L110
__rt_fd_decode.L112:
	# %t = 1   ; line 291
	li      $t0, 1
	sw      $t0, -32($fp)
__rt_fd_decode.L113:
	# %t36 = %k > 0   ; line 292
	lw      $t0, -28($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -156($fp)
	# ifFalse %t36 goto .L115   ; line 292
	lw      $t0, -156($fp)
	beq     $t0, $zero, __rt_fd_decode.L115
	# %t37 = %t * 5   ; line 292
	lw      $t0, -32($fp)
	li      $t1, 5
	mul     $t0, $t0, $t1
	sw      $t0, -160($fp)
	# %t = %t37   ; line 292
	lw      $t0, -160($fp)
	sw      $t0, -32($fp)
	# %t38 = %k   ; line 292
	lw      $t0, -28($fp)
	sw      $t0, -164($fp)
	# %t39 = %t38 - 1   ; line 292
	lw      $t0, -164($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -168($fp)
	# %k = %t39   ; line 292
	lw      $t0, -168($fp)
	sw      $t0, -28($fp)
	# goto .L113   ; line 292
	b       __rt_fd_decode.L113
__rt_fd_decode.L115:
	# param %t : int   ; line 293
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# call @fd_mul, 1   ; line 293
	lw      $a0, 0($sp)
	jal     __rt_fd_mul
__rt_fd_decode.L109:
__rt_fd_decode.L107:
	# %nd = 0   ; line 295
	move    $t0, $zero
	sw      $t0, -44($fp)
	# %t40 = addr @fd_nbig   ; line 296
	la      $t0, __rtg_fd_nbig
	sw      $t0, -172($fp)
	# %t41 = load.w %t40   ; line 296
	lw      $t0, -172($fp)
	lw      $t1, 0($t0)
	sw      $t1, -176($fp)
	# %t42 = %t41 - 1   ; line 296
	lw      $t0, -176($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -180($fp)
	# %i = %t42   ; line 296
	lw      $t0, -180($fp)
	sw      $t0, -36($fp)
__rt_fd_decode.L116:
	# %t43 = %i >= 0   ; line 296
	lw      $t0, -36($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -184($fp)
	# ifFalse %t43 goto .L119   ; line 296
	lw      $t0, -184($fp)
	beq     $t0, $zero, __rt_fd_decode.L119
	# %t44 = addr @fd_big   ; line 297
	la      $t0, __rtg_fd_big
	sw      $t0, -188($fp)
	# %t45 = %i * 4   ; line 297
	lw      $t0, -36($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -192($fp)
	# %t46 = %t44 + %t45   ; line 297
	lw      $t0, -188($fp)
	lw      $t1, -192($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -196($fp)
	# %t47 = load.w %t46   ; line 297
	lw      $t0, -196($fp)
	lw      $t1, 0($t0)
	sw      $t1, -200($fp)
	# %t = %t47   ; line 297
	lw      $t0, -200($fp)
	sw      $t0, -32($fp)
	# %t48 = addr @fd_dig   ; line 298
	la      $t0, __rtg_fd_dig
	sw      $t0, -204($fp)
	# %t49 = %t48 + %nd   ; line 298
	lw      $t0, -204($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -208($fp)
	# %t50 = %t / 1000   ; line 298
	lw      $t0, -32($fp)
	li      $t1, 1000
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -212($fp)
	# %t51 = 48 + %t50   ; line 298
	li      $t0, 48
	lw      $t1, -212($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -216($fp)
	# %t52 = sext.b %t51   ; line 298
	lw      $t0, -216($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -220($fp)
	# store.b %t49, %t52   ; line 298
	lw      $t0, -208($fp)
	lw      $t1, -220($fp)
	sb      $t1, 0($t0)
	# %t53 = sext.b %t52   ; line 298
	lw      $t0, -220($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -224($fp)
	# %t54 = addr @fd_dig   ; line 299
	la      $t0, __rtg_fd_dig
	sw      $t0, -228($fp)
	# %t55 = %nd + 1   ; line 299
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -232($fp)
	# %t56 = %t54 + %t55   ; line 299
	lw      $t0, -228($fp)
	lw      $t1, -232($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -236($fp)
	# %t57 = %t / 100   ; line 299
	lw      $t0, -32($fp)
	li      $t1, 100
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -240($fp)
	# %t58 = %t57 % 10   ; line 299
	lw      $t0, -240($fp)
	li      $t1, 10
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -244($fp)
	# %t59 = 48 + %t58   ; line 299
	li      $t0, 48
	lw      $t1, -244($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -248($fp)
	# %t60 = sext.b %t59   ; line 299
	lw      $t0, -248($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -252($fp)
	# store.b %t56, %t60   ; line 299
	lw      $t0, -236($fp)
	lw      $t1, -252($fp)
	sb      $t1, 0($t0)
	# %t61 = sext.b %t60   ; line 299
	lw      $t0, -252($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -256($fp)
	# %t62 = addr @fd_dig   ; line 300
	la      $t0, __rtg_fd_dig
	sw      $t0, -260($fp)
	# %t63 = %nd + 2   ; line 300
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 2
	sw      $t0, -264($fp)
	# %t64 = %t62 + %t63   ; line 300
	lw      $t0, -260($fp)
	lw      $t1, -264($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -268($fp)
	# %t65 = %t / 10   ; line 300
	lw      $t0, -32($fp)
	li      $t1, 10
	div     $t0, $t1
	mflo    $t0
	sw      $t0, -272($fp)
	# %t66 = %t65 % 10   ; line 300
	lw      $t0, -272($fp)
	li      $t1, 10
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -276($fp)
	# %t67 = 48 + %t66   ; line 300
	li      $t0, 48
	lw      $t1, -276($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -280($fp)
	# %t68 = sext.b %t67   ; line 300
	lw      $t0, -280($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -284($fp)
	# store.b %t64, %t68   ; line 300
	lw      $t0, -268($fp)
	lw      $t1, -284($fp)
	sb      $t1, 0($t0)
	# %t69 = sext.b %t68   ; line 300
	lw      $t0, -284($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -288($fp)
	# %t70 = addr @fd_dig   ; line 301
	la      $t0, __rtg_fd_dig
	sw      $t0, -292($fp)
	# %t71 = %nd + 3   ; line 301
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 3
	sw      $t0, -296($fp)
	# %t72 = %t70 + %t71   ; line 301
	lw      $t0, -292($fp)
	lw      $t1, -296($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -300($fp)
	# %t73 = %t % 10   ; line 301
	lw      $t0, -32($fp)
	li      $t1, 10
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -304($fp)
	# %t74 = 48 + %t73   ; line 301
	li      $t0, 48
	lw      $t1, -304($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -308($fp)
	# %t75 = sext.b %t74   ; line 301
	lw      $t0, -308($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -312($fp)
	# store.b %t72, %t75   ; line 301
	lw      $t0, -300($fp)
	lw      $t1, -312($fp)
	sb      $t1, 0($t0)
	# %t76 = sext.b %t75   ; line 301
	lw      $t0, -312($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -316($fp)
	# %t77 = %nd + 4   ; line 302
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -320($fp)
	# %nd = %t77   ; line 302
	lw      $t0, -320($fp)
	sw      $t0, -44($fp)
	# %t78 = %i   ; line 296
	lw      $t0, -36($fp)
	sw      $t0, -324($fp)
	# %t79 = %t78 - 1   ; line 296
	lw      $t0, -324($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -328($fp)
	# %i = %t79   ; line 296
	lw      $t0, -328($fp)
	sw      $t0, -36($fp)
	# goto .L116   ; line 296
	b       __rt_fd_decode.L116
__rt_fd_decode.L119:
	# %j = 0   ; line 304
	move    $t0, $zero
	sw      $t0, -40($fp)
__rt_fd_decode.L120:
	# %t80 = addr @fd_dig   ; line 305
	la      $t0, __rtg_fd_dig
	sw      $t0, -332($fp)
	# %t81 = %t80 + %j   ; line 305
	lw      $t0, -332($fp)
	lw      $t1, -40($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -336($fp)
	# %t82 = load.b %t81   ; line 305
	lw      $t0, -336($fp)
	lb      $t1, 0($t0)
	sw      $t1, -340($fp)
	# %t83 = %t82 == 48   ; line 305
	lw      $t0, -340($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -344($fp)
	# ifFalse %t83 goto .L122   ; line 305
	lw      $t0, -344($fp)
	beq     $t0, $zero, __rt_fd_decode.L122
	# %t84 = %j   ; line 305
	lw      $t0, -40($fp)
	sw      $t0, -348($fp)
	# %t85 = %t84 + 1   ; line 305
	lw      $t0, -348($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -352($fp)
	# %j = %t85   ; line 305
	lw      $t0, -352($fp)
	sw      $t0, -40($fp)
	# goto .L120   ; line 305
	b       __rt_fd_decode.L120
__rt_fd_decode.L122:
	# %i = %j   ; line 306
	lw      $t0, -40($fp)
	sw      $t0, -36($fp)
__rt_fd_decode.L123:
	# %t86 = %i < %nd   ; line 306
	lw      $t0, -36($fp)
	lw      $t1, -44($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -356($fp)
	# ifFalse %t86 goto .L126   ; line 306
	lw      $t0, -356($fp)
	beq     $t0, $zero, __rt_fd_decode.L126
	# %t87 = addr @fd_dig   ; line 306
	la      $t0, __rtg_fd_dig
	sw      $t0, -360($fp)
	# %t88 = %i - %j   ; line 306
	lw      $t0, -36($fp)
	lw      $t1, -40($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -364($fp)
	# %t89 = %t87 + %t88   ; line 306
	lw      $t0, -360($fp)
	lw      $t1, -364($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -368($fp)
	# %t90 = addr @fd_dig   ; line 306
	la      $t0, __rtg_fd_dig
	sw      $t0, -372($fp)
	# %t91 = %t90 + %i   ; line 306
	lw      $t0, -372($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -376($fp)
	# %t92 = load.b %t91   ; line 306
	lw      $t0, -376($fp)
	lb      $t1, 0($t0)
	sw      $t1, -380($fp)
	# store.b %t89, %t92   ; line 306
	lw      $t0, -368($fp)
	lw      $t1, -380($fp)
	sb      $t1, 0($t0)
	# %t93 = sext.b %t92   ; line 306
	lw      $t0, -380($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -384($fp)
	# %t94 = %i   ; line 306
	lw      $t0, -36($fp)
	sw      $t0, -388($fp)
	# %t95 = %t94 + 1   ; line 306
	lw      $t0, -388($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -392($fp)
	# %i = %t95   ; line 306
	lw      $t0, -392($fp)
	sw      $t0, -36($fp)
	# goto .L123   ; line 306
	b       __rt_fd_decode.L123
__rt_fd_decode.L126:
	# %t96 = %nd - %j   ; line 307
	lw      $t0, -44($fp)
	lw      $t1, -40($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -396($fp)
	# %nd = %t96   ; line 307
	lw      $t0, -396($fp)
	sw      $t0, -44($fp)
	# %t97 = addr @fd_exp   ; line 308
	la      $t0, __rtg_fd_exp
	sw      $t0, -400($fp)
	# %t98 = %nd - %frac   ; line 308
	lw      $t0, -44($fp)
	lw      $t1, -48($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -404($fp)
	# store.w %t97, %t98   ; line 308
	lw      $t0, -400($fp)
	lw      $t1, -404($fp)
	sw      $t1, 0($t0)
__rt_fd_decode.L127:
	# %t99 = %nd > 0   ; line 309
	lw      $t0, -44($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -408($fp)
	# ifFalse %t99 goto .L129   ; line 309
	lw      $t0, -408($fp)
	beq     $t0, $zero, __rt_fd_decode.L129
	# %t100 = addr @fd_dig   ; line 309
	la      $t0, __rtg_fd_dig
	sw      $t0, -412($fp)
	# %t101 = %nd - 1   ; line 309
	lw      $t0, -44($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -416($fp)
	# %t102 = %t100 + %t101   ; line 309
	lw      $t0, -412($fp)
	lw      $t1, -416($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -420($fp)
	# %t103 = load.b %t102   ; line 309
	lw      $t0, -420($fp)
	lb      $t1, 0($t0)
	sw      $t1, -424($fp)
	# %t104 = %t103 == 48   ; line 309
	lw      $t0, -424($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -428($fp)
	# ifFalse %t104 goto .L129   ; line 309
	lw      $t0, -428($fp)
	beq     $t0, $zero, __rt_fd_decode.L129
	# %t105 = %nd   ; line 309
	lw      $t0, -44($fp)
	sw      $t0, -432($fp)
	# %t106 = %t105 - 1   ; line 309
	lw      $t0, -432($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -436($fp)
	# %nd = %t106   ; line 309
	lw      $t0, -436($fp)
	sw      $t0, -44($fp)
	# goto .L127   ; line 309
	b       __rt_fd_decode.L127
__rt_fd_decode.L129:
	# %t107 = addr @fd_n   ; line 310
	la      $t0, __rtg_fd_n
	sw      $t0, -440($fp)
	# store.w %t107, %nd   ; line 310
	lw      $t0, -440($fp)
	lw      $t1, -44($fp)
	sw      $t1, 0($t0)
	# return
__rt_fd_decode.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fd_round
	.text
# ---------------------------------------------------------------
# function fd_round (line 316), returns void
# frame 384 bytes ($fp = $sp at entry):
#   0($fp)	param n (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%n : int
#   -16($fp)	%up : int
#   -20($fp)	%i : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : str
#   -60($fp)	%t12 : char
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : str
#   -76($fp)	%t16 : char
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : ptr
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : str
#   -108($fp)	%t24 : ptr
#   -112($fp)	%t25 : ptr
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : ptr
#   -136($fp)	%t31 : str
#   -140($fp)	%t32 : char
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : ptr
#   -152($fp)	%t35 : str
#   -156($fp)	%t36 : char
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : ptr
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : ptr
#   -184($fp)	%t43 : int
#   -188($fp)	%t44 : str
#   -192($fp)	%t45 : char
#   -196($fp)	%t46 : int
#   -200($fp)	%t47 : int
#   -204($fp)	%t48 : int
#   -208($fp)	%t49 : ptr
#   -212($fp)	%t50 : int
#   -216($fp)	%t51 : int
#   -220($fp)	%t52 : ptr
#   -224($fp)	%t53 : str
#   -228($fp)	%t54 : char
#   -232($fp)	%t55 : int
#   -236($fp)	%t56 : int
#   -240($fp)	%t57 : int
#   -244($fp)	%t58 : int
#   -248($fp)	%t59 : ptr
#   -252($fp)	%t60 : str
#   -256($fp)	%t61 : ptr
#   -260($fp)	%t62 : ptr
#   -264($fp)	%t63 : int
#   -268($fp)	%t64 : int
#   -272($fp)	%t65 : int
#   -276($fp)	%t66 : ptr
#   -280($fp)	%t67 : str
#   -284($fp)	%t68 : ptr
#   -288($fp)	%t69 : str
#   -292($fp)	%t70 : char
#   -296($fp)	%t71 : int
#   -300($fp)	%t72 : char
#   -304($fp)	%t73 : char
#   -308($fp)	%t74 : ptr
#   -312($fp)	%t75 : int
#   -316($fp)	%t76 : ptr
#   -320($fp)	%t77 : int
#   -324($fp)	%t78 : int
#   -328($fp)	%t79 : ptr
#   -332($fp)	%t80 : ptr
#   -336($fp)	%t81 : int
#   -340($fp)	%t82 : int
#   -344($fp)	%t83 : str
#   -348($fp)	%t84 : char
#   -352($fp)	%t85 : int
#   -356($fp)	%t86 : ptr
#   -360($fp)	%t87 : int
#   -364($fp)	%t88 : int
#   -368($fp)	%t89 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fd_round
__rt_fd_round:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -384
	sw      $a0, 0($fp)
	# param n : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t3 = addr @fd_n   ; line 318
	la      $t0, __rtg_fd_n
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 318
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = %n >= %t4   ; line 318
	lw      $t0, -12($fp)
	lw      $t1, -28($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L131   ; line 318
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fd_round.L131
	# return   ; line 318
	b       __rt_fd_round.ret
__rt_fd_round.L131:
	# %t6 = %n < 0   ; line 319
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L133   ; line 319
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_fd_round.L133
	# %t7 = addr @fd_n   ; line 319
	la      $t0, __rtg_fd_n
	sw      $t0, -40($fp)
	# store.w %t7, 0   ; line 319
	lw      $t0, -40($fp)
	sw      $zero, 0($t0)
	# return   ; line 319
	b       __rt_fd_round.ret
__rt_fd_round.L133:
	# %t8 = %n == 0   ; line 320
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L135   ; line 320
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_fd_round.L135
	# %t10 = addr @fd_dig   ; line 321
	la      $t0, __rtg_fd_dig
	sw      $t0, -52($fp)
	# %t11 = %t10 + 0   ; line 321
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -56($fp)
	# %t12 = load.b %t11   ; line 321
	lw      $t0, -56($fp)
	lb      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %t12 > 53   ; line 321
	lw      $t0, -60($fp)
	li      $t1, 53
	slt     $t0, $t1, $t0
	sw      $t0, -64($fp)
	# if %t13 goto .L136   ; line 321
	lw      $t0, -64($fp)
	bne     $t0, $zero, __rt_fd_round.L136
	# %t14 = addr @fd_dig   ; line 321
	la      $t0, __rtg_fd_dig
	sw      $t0, -68($fp)
	# %t15 = %t14 + 0   ; line 321
	lw      $t0, -68($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -72($fp)
	# %t16 = load.b %t15   ; line 321
	lw      $t0, -72($fp)
	lb      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t16 == 53   ; line 321
	lw      $t0, -76($fp)
	xori    $t0, $t0, 53
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L137   ; line 321
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_fd_round.L137
	# %t18 = addr @fd_n   ; line 321
	la      $t0, __rtg_fd_n
	sw      $t0, -84($fp)
	# %t19 = load.w %t18   ; line 321
	lw      $t0, -84($fp)
	lw      $t1, 0($t0)
	sw      $t1, -88($fp)
	# %t20 = %t19 > 1   ; line 321
	lw      $t0, -88($fp)
	li      $t1, 1
	slt     $t0, $t1, $t0
	sw      $t0, -92($fp)
	# ifFalse %t20 goto .L137   ; line 321
	lw      $t0, -92($fp)
	beq     $t0, $zero, __rt_fd_round.L137
__rt_fd_round.L136:
	# %t9 = 1   ; line 321
	li      $t0, 1
	sw      $t0, -48($fp)
	# goto .L138   ; line 321
	b       __rt_fd_round.L138
__rt_fd_round.L137:
	# %t9 = 0   ; line 321
	move    $t0, $zero
	sw      $t0, -48($fp)
__rt_fd_round.L138:
	# %up = %t9   ; line 321
	lw      $t0, -48($fp)
	sw      $t0, -16($fp)
	# %t21 = addr @fd_n   ; line 322
	la      $t0, __rtg_fd_n
	sw      $t0, -96($fp)
	# store.w %t21, 0   ; line 322
	lw      $t0, -96($fp)
	sw      $zero, 0($t0)
	# ifFalse %up goto .L140   ; line 323
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_fd_round.L140
	# %t22 = addr @fd_dig   ; line 324
	la      $t0, __rtg_fd_dig
	sw      $t0, -100($fp)
	# %t23 = %t22 + 0   ; line 324
	lw      $t0, -100($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -104($fp)
	# store.b %t23, 49   ; line 324
	lw      $t0, -104($fp)
	li      $t1, 49
	sb      $t1, 0($t0)
	# %t24 = addr @fd_n   ; line 325
	la      $t0, __rtg_fd_n
	sw      $t0, -108($fp)
	# store.w %t24, 1   ; line 325
	lw      $t0, -108($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t25 = addr @fd_exp   ; line 326
	la      $t0, __rtg_fd_exp
	sw      $t0, -112($fp)
	# %t26 = load.w %t25   ; line 326
	lw      $t0, -112($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# %t27 = %t26   ; line 326
	lw      $t0, -116($fp)
	sw      $t0, -120($fp)
	# %t28 = %t27 + 1   ; line 326
	lw      $t0, -120($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -124($fp)
	# store.w %t25, %t28   ; line 326
	lw      $t0, -112($fp)
	lw      $t1, -124($fp)
	sw      $t1, 0($t0)
__rt_fd_round.L140:
	# return   ; line 328
	b       __rt_fd_round.ret
__rt_fd_round.L135:
	# %t30 = addr @fd_dig   ; line 330
	la      $t0, __rtg_fd_dig
	sw      $t0, -132($fp)
	# %t31 = %t30 + %n   ; line 330
	lw      $t0, -132($fp)
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -136($fp)
	# %t32 = load.b %t31   ; line 330
	lw      $t0, -136($fp)
	lb      $t1, 0($t0)
	sw      $t1, -140($fp)
	# %t33 = %t32 > 53   ; line 330
	lw      $t0, -140($fp)
	li      $t1, 53
	slt     $t0, $t1, $t0
	sw      $t0, -144($fp)
	# if %t33 goto .L141   ; line 330
	lw      $t0, -144($fp)
	bne     $t0, $zero, __rt_fd_round.L141
	# %t34 = addr @fd_dig   ; line 331
	la      $t0, __rtg_fd_dig
	sw      $t0, -148($fp)
	# %t35 = %t34 + %n   ; line 331
	lw      $t0, -148($fp)
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -152($fp)
	# %t36 = load.b %t35   ; line 331
	lw      $t0, -152($fp)
	lb      $t1, 0($t0)
	sw      $t1, -156($fp)
	# %t37 = %t36 == 53   ; line 331
	lw      $t0, -156($fp)
	xori    $t0, $t0, 53
	sltiu   $t0, $t0, 1
	sw      $t0, -160($fp)
	# ifFalse %t37 goto .L142   ; line 331
	lw      $t0, -160($fp)
	beq     $t0, $zero, __rt_fd_round.L142
	# %t38 = addr @fd_n   ; line 331
	la      $t0, __rtg_fd_n
	sw      $t0, -164($fp)
	# %t39 = load.w %t38   ; line 331
	lw      $t0, -164($fp)
	lw      $t1, 0($t0)
	sw      $t1, -168($fp)
	# %t40 = %n + 1   ; line 331
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -172($fp)
	# %t41 = %t39 > %t40   ; line 331
	lw      $t0, -168($fp)
	lw      $t1, -172($fp)
	slt     $t0, $t1, $t0
	sw      $t0, -176($fp)
	# if %t41 goto .L141   ; line 331
	lw      $t0, -176($fp)
	bne     $t0, $zero, __rt_fd_round.L141
	# %t42 = addr @fd_dig   ; line 331
	la      $t0, __rtg_fd_dig
	sw      $t0, -180($fp)
	# %t43 = %n - 1   ; line 331
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -184($fp)
	# %t44 = %t42 + %t43   ; line 331
	lw      $t0, -180($fp)
	lw      $t1, -184($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -188($fp)
	# %t45 = load.b %t44   ; line 331
	lw      $t0, -188($fp)
	lb      $t1, 0($t0)
	sw      $t1, -192($fp)
	# %t46 = %t45 - 48   ; line 331
	lw      $t0, -192($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -196($fp)
	# %t47 = %t46 % 2   ; line 331
	lw      $t0, -196($fp)
	li      $t1, 2
	div     $t0, $t1
	mfhi    $t0
	sw      $t0, -200($fp)
	# %t48 = %t47 == 1   ; line 331
	lw      $t0, -200($fp)
	xori    $t0, $t0, 1
	sltiu   $t0, $t0, 1
	sw      $t0, -204($fp)
	# ifFalse %t48 goto .L142   ; line 331
	lw      $t0, -204($fp)
	beq     $t0, $zero, __rt_fd_round.L142
__rt_fd_round.L141:
	# %t29 = 1   ; line 331
	li      $t0, 1
	sw      $t0, -128($fp)
	# goto .L143   ; line 331
	b       __rt_fd_round.L143
__rt_fd_round.L142:
	# %t29 = 0   ; line 331
	move    $t0, $zero
	sw      $t0, -128($fp)
__rt_fd_round.L143:
	# %up = %t29   ; line 331
	lw      $t0, -128($fp)
	sw      $t0, -16($fp)
	# %t49 = addr @fd_n   ; line 332
	la      $t0, __rtg_fd_n
	sw      $t0, -208($fp)
	# store.w %t49, %n   ; line 332
	lw      $t0, -208($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
	# ifFalse %up goto .L145   ; line 333
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_fd_round.L145
	# %t50 = %n - 1   ; line 334
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -212($fp)
	# %i = %t50   ; line 334
	lw      $t0, -212($fp)
	sw      $t0, -20($fp)
__rt_fd_round.L146:
	# %t51 = %i >= 0   ; line 335
	lw      $t0, -20($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -216($fp)
	# ifFalse %t51 goto .L148   ; line 335
	lw      $t0, -216($fp)
	beq     $t0, $zero, __rt_fd_round.L148
	# %t52 = addr @fd_dig   ; line 335
	la      $t0, __rtg_fd_dig
	sw      $t0, -220($fp)
	# %t53 = %t52 + %i   ; line 335
	lw      $t0, -220($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -224($fp)
	# %t54 = load.b %t53   ; line 335
	lw      $t0, -224($fp)
	lb      $t1, 0($t0)
	sw      $t1, -228($fp)
	# %t55 = %t54 == 57   ; line 335
	lw      $t0, -228($fp)
	xori    $t0, $t0, 57
	sltiu   $t0, $t0, 1
	sw      $t0, -232($fp)
	# ifFalse %t55 goto .L148   ; line 335
	lw      $t0, -232($fp)
	beq     $t0, $zero, __rt_fd_round.L148
	# %t56 = %i   ; line 335
	lw      $t0, -20($fp)
	sw      $t0, -236($fp)
	# %t57 = %t56 - 1   ; line 335
	lw      $t0, -236($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -240($fp)
	# %i = %t57   ; line 335
	lw      $t0, -240($fp)
	sw      $t0, -20($fp)
	# goto .L146   ; line 335
	b       __rt_fd_round.L146
__rt_fd_round.L148:
	# %t58 = %i < 0   ; line 336
	lw      $t0, -20($fp)
	slti    $t0, $t0, 0
	sw      $t0, -244($fp)
	# ifFalse %t58 goto .L150   ; line 336
	lw      $t0, -244($fp)
	beq     $t0, $zero, __rt_fd_round.L150
	# %t59 = addr @fd_dig   ; line 337
	la      $t0, __rtg_fd_dig
	sw      $t0, -248($fp)
	# %t60 = %t59 + 0   ; line 337
	lw      $t0, -248($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -252($fp)
	# store.b %t60, 49   ; line 337
	lw      $t0, -252($fp)
	li      $t1, 49
	sb      $t1, 0($t0)
	# %t61 = addr @fd_n   ; line 338
	la      $t0, __rtg_fd_n
	sw      $t0, -256($fp)
	# store.w %t61, 1   ; line 338
	lw      $t0, -256($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t62 = addr @fd_exp   ; line 339
	la      $t0, __rtg_fd_exp
	sw      $t0, -260($fp)
	# %t63 = load.w %t62   ; line 339
	lw      $t0, -260($fp)
	lw      $t1, 0($t0)
	sw      $t1, -264($fp)
	# %t64 = %t63   ; line 339
	lw      $t0, -264($fp)
	sw      $t0, -268($fp)
	# %t65 = %t64 + 1   ; line 339
	lw      $t0, -268($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -272($fp)
	# store.w %t62, %t65   ; line 339
	lw      $t0, -260($fp)
	lw      $t1, -272($fp)
	sw      $t1, 0($t0)
	# goto .L151   ; line 339
	b       __rt_fd_round.L151
__rt_fd_round.L150:
	# %t66 = addr @fd_dig   ; line 341
	la      $t0, __rtg_fd_dig
	sw      $t0, -276($fp)
	# %t67 = %t66 + %i   ; line 341
	lw      $t0, -276($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -280($fp)
	# %t68 = addr @fd_dig   ; line 341
	la      $t0, __rtg_fd_dig
	sw      $t0, -284($fp)
	# %t69 = %t68 + %i   ; line 341
	lw      $t0, -284($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -288($fp)
	# %t70 = load.b %t69   ; line 341
	lw      $t0, -288($fp)
	lb      $t1, 0($t0)
	sw      $t1, -292($fp)
	# %t71 = %t70 + 1   ; line 341
	lw      $t0, -292($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -296($fp)
	# %t72 = sext.b %t71   ; line 341
	lw      $t0, -296($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -300($fp)
	# store.b %t67, %t72   ; line 341
	lw      $t0, -280($fp)
	lw      $t1, -300($fp)
	sb      $t1, 0($t0)
	# %t73 = sext.b %t72   ; line 341
	lw      $t0, -300($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -304($fp)
	# %t74 = addr @fd_n   ; line 342
	la      $t0, __rtg_fd_n
	sw      $t0, -308($fp)
	# %t75 = %i + 1   ; line 342
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -312($fp)
	# store.w %t74, %t75   ; line 342
	lw      $t0, -308($fp)
	lw      $t1, -312($fp)
	sw      $t1, 0($t0)
__rt_fd_round.L151:
__rt_fd_round.L145:
__rt_fd_round.L152:
	# %t76 = addr @fd_n   ; line 345
	la      $t0, __rtg_fd_n
	sw      $t0, -316($fp)
	# %t77 = load.w %t76   ; line 345
	lw      $t0, -316($fp)
	lw      $t1, 0($t0)
	sw      $t1, -320($fp)
	# %t78 = %t77 > 0   ; line 345
	lw      $t0, -320($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -324($fp)
	# ifFalse %t78 goto .L154   ; line 345
	lw      $t0, -324($fp)
	beq     $t0, $zero, __rt_fd_round.L154
	# %t79 = addr @fd_dig   ; line 345
	la      $t0, __rtg_fd_dig
	sw      $t0, -328($fp)
	# %t80 = addr @fd_n   ; line 345
	la      $t0, __rtg_fd_n
	sw      $t0, -332($fp)
	# %t81 = load.w %t80   ; line 345
	lw      $t0, -332($fp)
	lw      $t1, 0($t0)
	sw      $t1, -336($fp)
	# %t82 = %t81 - 1   ; line 345
	lw      $t0, -336($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -340($fp)
	# %t83 = %t79 + %t82   ; line 345
	lw      $t0, -328($fp)
	lw      $t1, -340($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -344($fp)
	# %t84 = load.b %t83   ; line 345
	lw      $t0, -344($fp)
	lb      $t1, 0($t0)
	sw      $t1, -348($fp)
	# %t85 = %t84 == 48   ; line 345
	lw      $t0, -348($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -352($fp)
	# ifFalse %t85 goto .L154   ; line 345
	lw      $t0, -352($fp)
	beq     $t0, $zero, __rt_fd_round.L154
	# %t86 = addr @fd_n   ; line 345
	la      $t0, __rtg_fd_n
	sw      $t0, -356($fp)
	# %t87 = load.w %t86   ; line 345
	lw      $t0, -356($fp)
	lw      $t1, 0($t0)
	sw      $t1, -360($fp)
	# %t88 = %t87   ; line 345
	lw      $t0, -360($fp)
	sw      $t0, -364($fp)
	# %t89 = %t88 - 1   ; line 345
	lw      $t0, -364($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -368($fp)
	# store.w %t86, %t89   ; line 345
	lw      $t0, -356($fp)
	lw      $t1, -368($fp)
	sw      $t1, 0($t0)
	# goto .L152   ; line 345
	b       __rt_fd_round.L152
__rt_fd_round.L154:
	# return
__rt_fd_round.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fd_at
	.text
# ---------------------------------------------------------------
# function fd_at (line 349), returns int
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param i (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%i : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : char
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fd_at
__rt_fd_at:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	# param i : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = %i >= 0   ; line 350
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -16($fp)
	# ifFalse %t1 goto .L156   ; line 350
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_fd_at.L156
	# %t2 = addr @fd_n   ; line 350
	la      $t0, __rtg_fd_n
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 350
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = %i < %t3   ; line 350
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L156   ; line 350
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_fd_at.L156
	# %t5 = addr @fd_dig   ; line 350
	la      $t0, __rtg_fd_dig
	sw      $t0, -32($fp)
	# %t6 = %t5 + %i   ; line 350
	lw      $t0, -32($fp)
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = load.b %t6   ; line 350
	lw      $t0, -36($fp)
	lb      $t1, 0($t0)
	sw      $t1, -40($fp)
	# return %t7   ; line 350
	lw      $v0, -40($fp)
	b       __rt_fd_at.ret
__rt_fd_at.L156:
	# return 48   ; line 351
	li      $v0, 48
__rt_fd_at.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_emit_f
	.text
# ---------------------------------------------------------------
# function emit_f (line 355), returns void
# frame 112 bytes ($fp = $sp at entry):
#   0($fp)	param prec (int, arrives in $a0)
#   4($fp)	param point (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%prec : int
#   -16($fp)	%point : int
#   -20($fp)	%i : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_emit_f
__rt_emit_f:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -112
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param prec : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param point : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t3 = addr @fd_exp   ; line 357
	la      $t0, __rtg_fd_exp
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 357
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = %t4 > 0   ; line 357
	lw      $t0, -28($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L158   ; line 357
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_emit_f.L158
	# %i = 0   ; line 358
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_emit_f.L159:
	# %t6 = addr @fd_exp   ; line 358
	la      $t0, __rtg_fd_exp
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 358
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = %i < %t7   ; line 358
	lw      $t0, -20($fp)
	lw      $t1, -40($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L162   ; line 358
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_emit_f.L162
	# param %i : int   ; line 358
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# %t9 = call @fd_at, 1   ; line 358
	lw      $a0, 0($sp)
	jal     __rt_fd_at
	sw      $v0, -48($fp)
	# param %t9 : int   ; line 358
	lw      $t0, -48($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 358
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t10 = %i   ; line 358
	lw      $t0, -20($fp)
	sw      $t0, -52($fp)
	# %t11 = %t10 + 1   ; line 358
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# %i = %t11   ; line 358
	lw      $t0, -56($fp)
	sw      $t0, -20($fp)
	# goto .L159   ; line 358
	b       __rt_emit_f.L159
__rt_emit_f.L162:
	# goto .L163   ; line 358
	b       __rt_emit_f.L163
__rt_emit_f.L158:
	# %t12 = 48   ; line 359
	li      $t0, 48
	sw      $t0, -60($fp)
	# param %t12 : int   ; line 359
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 359
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_emit_f.L163:
	# ifFalse %point goto .L165   ; line 360
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_emit_f.L165
	# %t13 = 46   ; line 360
	li      $t0, 46
	sw      $t0, -64($fp)
	# param %t13 : int   ; line 360
	lw      $t0, -64($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 360
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_emit_f.L165:
	# %i = 1   ; line 361
	li      $t0, 1
	sw      $t0, -20($fp)
__rt_emit_f.L166:
	# %t14 = %i <= %prec   ; line 361
	lw      $t0, -20($fp)
	lw      $t1, -12($fp)
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L169   ; line 361
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_emit_f.L169
	# %t15 = addr @fd_exp   ; line 361
	la      $t0, __rtg_fd_exp
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 361
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t16 - 1   ; line 361
	lw      $t0, -76($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -80($fp)
	# %t18 = %t17 + %i   ; line 361
	lw      $t0, -80($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -84($fp)
	# param %t18 : int   ; line 361
	lw      $t0, -84($fp)
	sw      $t0, 0($sp)
	# %t19 = call @fd_at, 1   ; line 361
	lw      $a0, 0($sp)
	jal     __rt_fd_at
	sw      $v0, -88($fp)
	# param %t19 : int   ; line 361
	lw      $t0, -88($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 361
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t20 = %i   ; line 361
	lw      $t0, -20($fp)
	sw      $t0, -92($fp)
	# %t21 = %t20 + 1   ; line 361
	lw      $t0, -92($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# %i = %t21   ; line 361
	lw      $t0, -96($fp)
	sw      $t0, -20($fp)
	# goto .L166   ; line 361
	b       __rt_emit_f.L166
__rt_emit_f.L169:
	# return
__rt_emit_f.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_emit_e
	.text
# ---------------------------------------------------------------
# function emit_e (line 365), returns void
# frame 120 bytes ($fp = $sp at entry):
#   0($fp)	param prec (int, arrives in $a0)
#   4($fp)	param point (int, arrives in $a1)
#   8($fp)	param upper (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%prec : int
#   -16($fp)	%point : int
#   -20($fp)	%upper : int
#   -24($fp)	%i : int
#   -28($fp)	%x : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_emit_e
__rt_emit_e:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -120
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param prec : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param point : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param upper : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %t5 = 0   ; line 367
	move    $t0, $zero
	sw      $t0, -32($fp)
	# param %t5 : int   ; line 367
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# %t6 = call @fd_at, 1   ; line 367
	lw      $a0, 0($sp)
	jal     __rt_fd_at
	sw      $v0, -36($fp)
	# param %t6 : int   ; line 367
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 367
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# ifFalse %point goto .L171   ; line 368
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_emit_e.L171
	# %t7 = 46   ; line 368
	li      $t0, 46
	sw      $t0, -40($fp)
	# param %t7 : int   ; line 368
	lw      $t0, -40($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 368
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_emit_e.L171:
	# %i = 1   ; line 369
	li      $t0, 1
	sw      $t0, -24($fp)
__rt_emit_e.L172:
	# %t8 = %i <= %prec   ; line 369
	lw      $t0, -24($fp)
	lw      $t1, -12($fp)
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L175   ; line 369
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_emit_e.L175
	# param %i : int   ; line 369
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t9 = call @fd_at, 1   ; line 369
	lw      $a0, 0($sp)
	jal     __rt_fd_at
	sw      $v0, -48($fp)
	# param %t9 : int   ; line 369
	lw      $t0, -48($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 369
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t10 = %i   ; line 369
	lw      $t0, -24($fp)
	sw      $t0, -52($fp)
	# %t11 = %t10 + 1   ; line 369
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# %i = %t11   ; line 369
	lw      $t0, -56($fp)
	sw      $t0, -24($fp)
	# goto .L172   ; line 369
	b       __rt_emit_e.L172
__rt_emit_e.L175:
	# ifFalse %upper goto .L177   ; line 370
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_emit_e.L177
	# %t12 = 69   ; line 370
	li      $t0, 69
	sw      $t0, -60($fp)
	# goto .L178   ; line 370
	b       __rt_emit_e.L178
__rt_emit_e.L177:
	# %t12 = 101   ; line 370
	li      $t0, 101
	sw      $t0, -60($fp)
__rt_emit_e.L178:
	# param %t12 : int   ; line 370
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 370
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %x = 0   ; line 371
	move    $t0, $zero
	sw      $t0, -28($fp)
	# %t13 = addr @fd_n   ; line 372
	la      $t0, __rtg_fd_n
	sw      $t0, -64($fp)
	# %t14 = load.w %t13   ; line 372
	lw      $t0, -64($fp)
	lw      $t1, 0($t0)
	sw      $t1, -68($fp)
	# ifFalse %t14 goto .L180   ; line 372
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_emit_e.L180
	# %t15 = addr @fd_exp   ; line 372
	la      $t0, __rtg_fd_exp
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 372
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t16 - 1   ; line 372
	lw      $t0, -76($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -80($fp)
	# %x = %t17   ; line 372
	lw      $t0, -80($fp)
	sw      $t0, -28($fp)
__rt_emit_e.L180:
	# %t18 = %x < 0   ; line 373
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	sw      $t0, -84($fp)
	# ifFalse %t18 goto .L182   ; line 373
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_emit_e.L182
	# %t19 = 45   ; line 373
	li      $t0, 45
	sw      $t0, -88($fp)
	# param %t19 : int   ; line 373
	lw      $t0, -88($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 373
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t20 = - %x   ; line 373
	lw      $t0, -28($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -92($fp)
	# %x = %t20   ; line 373
	lw      $t0, -92($fp)
	sw      $t0, -28($fp)
	# goto .L183   ; line 373
	b       __rt_emit_e.L183
__rt_emit_e.L182:
	# %t21 = 43   ; line 374
	li      $t0, 43
	sw      $t0, -96($fp)
	# param %t21 : int   ; line 374
	lw      $t0, -96($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 374
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_emit_e.L183:
	# %t22 = 2   ; line 375
	li      $t0, 2
	sw      $t0, -100($fp)
	# param %x : int   ; line 375
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %t22 : int   ; line 375
	lw      $t0, -100($fp)
	sw      $t0, 4($sp)
	# call @out_num, 2   ; line 375
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_num
	# return
__rt_emit_e.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fmt_hexf
	.text
# ---------------------------------------------------------------
# function fmt_hexf (line 382), returns void
# frame 728 bytes ($fp = $sp at entry):
#   0($fp)	param hi (int, arrives in $a0)
#   4($fp)	param lo (int, arrives in $a1)
#   8($fp)	param upper (int, arrives in $a2)
#   12($fp)	param pre (str, arrives in $a3)
#   16($fp)	param np (int)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -72($fp)	local nib : int [16] (64 bytes)
#   -76($fp)	%hi : int
#   -80($fp)	%lo : int
#   -84($fp)	%upper : int
#   -88($fp)	%pre : str
#   -92($fp)	%np : int
#   -96($fp)	%i : int
#   -100($fp)	%ex : int
#   -104($fp)	%lead : int
#   -108($fp)	%e : int
#   -112($fp)	%prec : int
#   -116($fp)	%up : int
#   -120($fp)	%rest : int
#   -124($fp)	%len : int
#   -128($fp)	%zeros : int
#   -132($fp)	%ax : int
#   -136($fp)	%point : int
#   -140($fp)	%t16 : int
#   -144($fp)	%t17 : int
#   -148($fp)	%t18 : int
#   -152($fp)	%t19 : ptr
#   -156($fp)	%t20 : int
#   -160($fp)	%t21 : ptr
#   -164($fp)	%t22 : int
#   -168($fp)	%t23 : int
#   -172($fp)	%t24 : int
#   -176($fp)	%t25 : int
#   -180($fp)	%t26 : int
#   -184($fp)	%t27 : int
#   -188($fp)	%t28 : int
#   -192($fp)	%t29 : ptr
#   -196($fp)	%t30 : int
#   -200($fp)	%t31 : int
#   -204($fp)	%t32 : ptr
#   -208($fp)	%t33 : int
#   -212($fp)	%t34 : int
#   -216($fp)	%t35 : int
#   -220($fp)	%t36 : int
#   -224($fp)	%t37 : int
#   -228($fp)	%t38 : int
#   -232($fp)	%t39 : int
#   -236($fp)	%t40 : int
#   -240($fp)	%t41 : int
#   -244($fp)	%t42 : int
#   -248($fp)	%t43 : ptr
#   -252($fp)	%t44 : int
#   -256($fp)	%t45 : int
#   -260($fp)	%t46 : int
#   -264($fp)	%t47 : ptr
#   -268($fp)	%t48 : int
#   -272($fp)	%t49 : int
#   -276($fp)	%t50 : ptr
#   -280($fp)	%t51 : int
#   -284($fp)	%t52 : int
#   -288($fp)	%t53 : int
#   -292($fp)	%t54 : int
#   -296($fp)	%t55 : ptr
#   -300($fp)	%t56 : int
#   -304($fp)	%t57 : int
#   -308($fp)	%t58 : int
#   -312($fp)	%t59 : int
#   -316($fp)	%t60 : ptr
#   -320($fp)	%t61 : int
#   -324($fp)	%t62 : ptr
#   -328($fp)	%t63 : int
#   -332($fp)	%t64 : int
#   -336($fp)	%t65 : int
#   -340($fp)	%t66 : int
#   -344($fp)	%t67 : ptr
#   -348($fp)	%t68 : int
#   -352($fp)	%t69 : int
#   -356($fp)	%t70 : ptr
#   -360($fp)	%t71 : int
#   -364($fp)	%t72 : int
#   -368($fp)	%t73 : int
#   -372($fp)	%t74 : int
#   -376($fp)	%t75 : ptr
#   -380($fp)	%t76 : int
#   -384($fp)	%t77 : ptr
#   -388($fp)	%t78 : int
#   -392($fp)	%t79 : int
#   -396($fp)	%t80 : ptr
#   -400($fp)	%t81 : int
#   -404($fp)	%t82 : ptr
#   -408($fp)	%t83 : int
#   -412($fp)	%t84 : int
#   -416($fp)	%t85 : int
#   -420($fp)	%t86 : int
#   -424($fp)	%t87 : ptr
#   -428($fp)	%t88 : int
#   -432($fp)	%t89 : ptr
#   -436($fp)	%t90 : int
#   -440($fp)	%t91 : int
#   -444($fp)	%t92 : ptr
#   -448($fp)	%t93 : int
#   -452($fp)	%t94 : ptr
#   -456($fp)	%t95 : int
#   -460($fp)	%t96 : int
#   -464($fp)	%t97 : int
#   -468($fp)	%t98 : int
#   -472($fp)	%t99 : int
#   -476($fp)	%t100 : ptr
#   -480($fp)	%t101 : int
#   -484($fp)	%t102 : ptr
#   -488($fp)	%t103 : int
#   -492($fp)	%t104 : int
#   -496($fp)	%t105 : int
#   -500($fp)	%t106 : int
#   -504($fp)	%t107 : int
#   -508($fp)	%t108 : ptr
#   -512($fp)	%t109 : int
#   -516($fp)	%t110 : int
#   -520($fp)	%t111 : int
#   -524($fp)	%t112 : int
#   -528($fp)	%t113 : int
#   -532($fp)	%t114 : int
#   -536($fp)	%t115 : int
#   -540($fp)	%t116 : int
#   -544($fp)	%t117 : int
#   -548($fp)	%t118 : int
#   -552($fp)	%t119 : int
#   -556($fp)	%t120 : int
#   -560($fp)	%t121 : int
#   -564($fp)	%t122 : int
#   -568($fp)	%t123 : int
#   -572($fp)	%t124 : int
#   -576($fp)	%t125 : int
#   -580($fp)	%t126 : int
#   -584($fp)	%t127 : int
#   -588($fp)	%t128 : ptr
#   -592($fp)	%t129 : int
#   -596($fp)	%t130 : ptr
#   -600($fp)	%t131 : int
#   -604($fp)	%t132 : ptr
#   -608($fp)	%t133 : int
#   -612($fp)	%t134 : int
#   -616($fp)	%t135 : ptr
#   -620($fp)	%t136 : int
#   -624($fp)	%t137 : int
#   -628($fp)	%t138 : int
#   -632($fp)	%t139 : int
#   -636($fp)	%t140 : int
#   -640($fp)	%t141 : int
#   -644($fp)	%t142 : int
#   -648($fp)	%t143 : int
#   -652($fp)	%t144 : int
#   -656($fp)	%t145 : int
#   -660($fp)	%t146 : ptr
#   -664($fp)	%t147 : int
#   -668($fp)	%t148 : ptr
#   -672($fp)	%t149 : int
#   -676($fp)	%t150 : int
#   -680($fp)	%t151 : int
#   -684($fp)	%t152 : int
#   -688($fp)	%t153 : int
#   -692($fp)	%t154 : int
#   -696($fp)	%t155 : int
#   -700($fp)	%t156 : int
#   -704($fp)	%t157 : int
#   -708($fp)	%t158 : int
#   -712($fp)	%t159 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fmt_hexf
__rt_fmt_hexf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -728
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param hi : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -76($fp)
	# param lo : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -80($fp)
	# param upper : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -84($fp)
	# param pre : str at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -88($fp)
	# param np : int at 16($fp)
	lw      $t0, 16($fp)
	sw      $t0, -92($fp)
	# %t16 = %hi >> 20   ; line 385
	lw      $t0, -76($fp)
	sra     $t0, $t0, 20
	sw      $t0, -140($fp)
	# %t17 = %t16 & 2047   ; line 385
	lw      $t0, -140($fp)
	andi    $t0, $t0, 2047
	sw      $t0, -144($fp)
	# %ex = %t17   ; line 385
	lw      $t0, -144($fp)
	sw      $t0, -100($fp)
	# %i = 0   ; line 386
	move    $t0, $zero
	sw      $t0, -96($fp)
__rt_fmt_hexf.L184:
	# %t18 = %i < 5   ; line 386
	lw      $t0, -96($fp)
	slti    $t0, $t0, 5
	sw      $t0, -148($fp)
	# ifFalse %t18 goto .L187   ; line 386
	lw      $t0, -148($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L187
	# %t19 = addr nib   ; line 386
	addiu   $t0, $fp, -72
	sw      $t0, -152($fp)
	# %t20 = %i * 4   ; line 386
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -156($fp)
	# %t21 = %t19 + %t20   ; line 386
	lw      $t0, -152($fp)
	lw      $t1, -156($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -160($fp)
	# %t22 = 4 * %i   ; line 386
	li      $t0, 4
	lw      $t1, -96($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -164($fp)
	# %t23 = 16 - %t22   ; line 386
	li      $t0, 16
	lw      $t1, -164($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -168($fp)
	# %t24 = %hi >> %t23   ; line 386
	lw      $t0, -76($fp)
	lw      $t1, -168($fp)
	srav    $t0, $t0, $t1
	sw      $t0, -172($fp)
	# %t25 = %t24 & 15   ; line 386
	lw      $t0, -172($fp)
	andi    $t0, $t0, 15
	sw      $t0, -176($fp)
	# store.w %t21, %t25   ; line 386
	lw      $t0, -160($fp)
	lw      $t1, -176($fp)
	sw      $t1, 0($t0)
	# %t26 = %i   ; line 386
	lw      $t0, -96($fp)
	sw      $t0, -180($fp)
	# %t27 = %t26 + 1   ; line 386
	lw      $t0, -180($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -184($fp)
	# %i = %t27   ; line 386
	lw      $t0, -184($fp)
	sw      $t0, -96($fp)
	# goto .L184   ; line 386
	b       __rt_fmt_hexf.L184
__rt_fmt_hexf.L187:
	# %i = 0   ; line 387
	move    $t0, $zero
	sw      $t0, -96($fp)
__rt_fmt_hexf.L188:
	# %t28 = %i < 8   ; line 387
	lw      $t0, -96($fp)
	slti    $t0, $t0, 8
	sw      $t0, -188($fp)
	# ifFalse %t28 goto .L191   ; line 387
	lw      $t0, -188($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L191
	# %t29 = addr nib   ; line 387
	addiu   $t0, $fp, -72
	sw      $t0, -192($fp)
	# %t30 = 5 + %i   ; line 387
	li      $t0, 5
	lw      $t1, -96($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -196($fp)
	# %t31 = %t30 * 4   ; line 387
	lw      $t0, -196($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -200($fp)
	# %t32 = %t29 + %t31   ; line 387
	lw      $t0, -192($fp)
	lw      $t1, -200($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -204($fp)
	# %t33 = 4 * %i   ; line 387
	li      $t0, 4
	lw      $t1, -96($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -208($fp)
	# %t34 = 28 - %t33   ; line 387
	li      $t0, 28
	lw      $t1, -208($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -212($fp)
	# %t35 = %lo >> %t34   ; line 387
	lw      $t0, -80($fp)
	lw      $t1, -212($fp)
	srav    $t0, $t0, $t1
	sw      $t0, -216($fp)
	# %t36 = %t35 & 15   ; line 387
	lw      $t0, -216($fp)
	andi    $t0, $t0, 15
	sw      $t0, -220($fp)
	# store.w %t32, %t36   ; line 387
	lw      $t0, -204($fp)
	lw      $t1, -220($fp)
	sw      $t1, 0($t0)
	# %t37 = %i   ; line 387
	lw      $t0, -96($fp)
	sw      $t0, -224($fp)
	# %t38 = %t37 + 1   ; line 387
	lw      $t0, -224($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -228($fp)
	# %i = %t38   ; line 387
	lw      $t0, -228($fp)
	sw      $t0, -96($fp)
	# goto .L188   ; line 387
	b       __rt_fmt_hexf.L188
__rt_fmt_hexf.L191:
	# %lead = 0   ; line 388
	move    $t0, $zero
	sw      $t0, -104($fp)
	# %e = 0   ; line 389
	move    $t0, $zero
	sw      $t0, -108($fp)
	# ifFalse %ex goto .L193   ; line 390
	lw      $t0, -100($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L193
	# %lead = 1   ; line 390
	li      $t0, 1
	sw      $t0, -104($fp)
	# %t39 = %ex - 1023   ; line 390
	lw      $t0, -100($fp)
	addiu   $t0, $t0, -1023
	sw      $t0, -232($fp)
	# %e = %t39   ; line 390
	lw      $t0, -232($fp)
	sw      $t0, -108($fp)
	# goto .L194   ; line 390
	b       __rt_fmt_hexf.L194
__rt_fmt_hexf.L193:
	# %t40 = %hi & 1048575   ; line 391
	lw      $t0, -76($fp)
	li      $t1, 1048575
	and     $t0, $t0, $t1
	sw      $t0, -236($fp)
	# %t41 = %t40 != 0   ; line 391
	lw      $t0, -236($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -240($fp)
	# if %t41 goto .L195   ; line 391
	lw      $t0, -240($fp)
	bne     $t0, $zero, __rt_fmt_hexf.L195
	# %t42 = %lo != 0   ; line 391
	lw      $t0, -80($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -244($fp)
	# ifFalse %t42 goto .L196   ; line 391
	lw      $t0, -244($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L196
__rt_fmt_hexf.L195:
	# %e = -1022   ; line 391
	li      $t0, -1022
	sw      $t0, -108($fp)
__rt_fmt_hexf.L196:
__rt_fmt_hexf.L194:
	# %t43 = addr @pf_prec   ; line 392
	la      $t0, __rtg_pf_prec
	sw      $t0, -248($fp)
	# %t44 = load.w %t43   ; line 392
	lw      $t0, -248($fp)
	lw      $t1, 0($t0)
	sw      $t1, -252($fp)
	# %t45 = %t44 < 0   ; line 392
	lw      $t0, -252($fp)
	slti    $t0, $t0, 0
	sw      $t0, -256($fp)
	# ifFalse %t45 goto .L198   ; line 392
	lw      $t0, -256($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L198
	# %prec = 13   ; line 393
	li      $t0, 13
	sw      $t0, -112($fp)
__rt_fmt_hexf.L199:
	# %t46 = %prec > 0   ; line 394
	lw      $t0, -112($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -260($fp)
	# ifFalse %t46 goto .L201   ; line 394
	lw      $t0, -260($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L201
	# %t47 = addr nib   ; line 394
	addiu   $t0, $fp, -72
	sw      $t0, -264($fp)
	# %t48 = %prec - 1   ; line 394
	lw      $t0, -112($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -268($fp)
	# %t49 = %t48 * 4   ; line 394
	lw      $t0, -268($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -272($fp)
	# %t50 = %t47 + %t49   ; line 394
	lw      $t0, -264($fp)
	lw      $t1, -272($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -276($fp)
	# %t51 = load.w %t50   ; line 394
	lw      $t0, -276($fp)
	lw      $t1, 0($t0)
	sw      $t1, -280($fp)
	# %t52 = %t51 == 0   ; line 394
	lw      $t0, -280($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -284($fp)
	# ifFalse %t52 goto .L201   ; line 394
	lw      $t0, -284($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L201
	# %t53 = %prec   ; line 394
	lw      $t0, -112($fp)
	sw      $t0, -288($fp)
	# %t54 = %t53 - 1   ; line 394
	lw      $t0, -288($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -292($fp)
	# %prec = %t54   ; line 394
	lw      $t0, -292($fp)
	sw      $t0, -112($fp)
	# goto .L199   ; line 394
	b       __rt_fmt_hexf.L199
__rt_fmt_hexf.L201:
	# goto .L202   ; line 394
	b       __rt_fmt_hexf.L202
__rt_fmt_hexf.L198:
	# %t55 = addr @pf_prec   ; line 396
	la      $t0, __rtg_pf_prec
	sw      $t0, -296($fp)
	# %t56 = load.w %t55   ; line 396
	lw      $t0, -296($fp)
	lw      $t1, 0($t0)
	sw      $t1, -300($fp)
	# %prec = %t56   ; line 396
	lw      $t0, -300($fp)
	sw      $t0, -112($fp)
	# %t57 = %prec < 13   ; line 397
	lw      $t0, -112($fp)
	slti    $t0, $t0, 13
	sw      $t0, -304($fp)
	# ifFalse %t57 goto .L204   ; line 397
	lw      $t0, -304($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L204
	# %rest = 0   ; line 398
	move    $t0, $zero
	sw      $t0, -120($fp)
	# %t58 = %prec + 1   ; line 399
	lw      $t0, -112($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -308($fp)
	# %i = %t58   ; line 399
	lw      $t0, -308($fp)
	sw      $t0, -96($fp)
__rt_fmt_hexf.L205:
	# %t59 = %i < 13   ; line 399
	lw      $t0, -96($fp)
	slti    $t0, $t0, 13
	sw      $t0, -312($fp)
	# ifFalse %t59 goto .L208   ; line 399
	lw      $t0, -312($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L208
	# %t60 = addr nib   ; line 399
	addiu   $t0, $fp, -72
	sw      $t0, -316($fp)
	# %t61 = %i * 4   ; line 399
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -320($fp)
	# %t62 = %t60 + %t61   ; line 399
	lw      $t0, -316($fp)
	lw      $t1, -320($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -324($fp)
	# %t63 = load.w %t62   ; line 399
	lw      $t0, -324($fp)
	lw      $t1, 0($t0)
	sw      $t1, -328($fp)
	# ifFalse %t63 goto .L210   ; line 399
	lw      $t0, -328($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L210
	# %rest = 1   ; line 399
	li      $t0, 1
	sw      $t0, -120($fp)
__rt_fmt_hexf.L210:
	# %t64 = %i   ; line 399
	lw      $t0, -96($fp)
	sw      $t0, -332($fp)
	# %t65 = %t64 + 1   ; line 399
	lw      $t0, -332($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -336($fp)
	# %i = %t65   ; line 399
	lw      $t0, -336($fp)
	sw      $t0, -96($fp)
	# goto .L205   ; line 399
	b       __rt_fmt_hexf.L205
__rt_fmt_hexf.L208:
	# %t66 = %prec > 0   ; line 400
	lw      $t0, -112($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -340($fp)
	# ifFalse %t66 goto .L212   ; line 400
	lw      $t0, -340($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L212
	# %t67 = addr nib   ; line 400
	addiu   $t0, $fp, -72
	sw      $t0, -344($fp)
	# %t68 = %prec - 1   ; line 400
	lw      $t0, -112($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -348($fp)
	# %t69 = %t68 * 4   ; line 400
	lw      $t0, -348($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -352($fp)
	# %t70 = %t67 + %t69   ; line 400
	lw      $t0, -344($fp)
	lw      $t1, -352($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -356($fp)
	# %t71 = load.w %t70   ; line 400
	lw      $t0, -356($fp)
	lw      $t1, 0($t0)
	sw      $t1, -360($fp)
	# %t72 = %t71 & 1   ; line 400
	lw      $t0, -360($fp)
	andi    $t0, $t0, 1
	sw      $t0, -364($fp)
	# %up = %t72   ; line 400
	lw      $t0, -364($fp)
	sw      $t0, -116($fp)
	# goto .L213   ; line 400
	b       __rt_fmt_hexf.L213
__rt_fmt_hexf.L212:
	# %t73 = %lead & 1   ; line 401
	lw      $t0, -104($fp)
	andi    $t0, $t0, 1
	sw      $t0, -368($fp)
	# %up = %t73   ; line 401
	lw      $t0, -368($fp)
	sw      $t0, -116($fp)
__rt_fmt_hexf.L213:
	# %t75 = addr nib   ; line 402
	addiu   $t0, $fp, -72
	sw      $t0, -376($fp)
	# %t76 = %prec * 4   ; line 402
	lw      $t0, -112($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -380($fp)
	# %t77 = %t75 + %t76   ; line 402
	lw      $t0, -376($fp)
	lw      $t1, -380($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -384($fp)
	# %t78 = load.w %t77   ; line 402
	lw      $t0, -384($fp)
	lw      $t1, 0($t0)
	sw      $t1, -388($fp)
	# %t79 = %t78 > 8   ; line 402
	lw      $t0, -388($fp)
	li      $t1, 8
	slt     $t0, $t1, $t0
	sw      $t0, -392($fp)
	# if %t79 goto .L214   ; line 402
	lw      $t0, -392($fp)
	bne     $t0, $zero, __rt_fmt_hexf.L214
	# %t80 = addr nib   ; line 402
	addiu   $t0, $fp, -72
	sw      $t0, -396($fp)
	# %t81 = %prec * 4   ; line 402
	lw      $t0, -112($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -400($fp)
	# %t82 = %t80 + %t81   ; line 402
	lw      $t0, -396($fp)
	lw      $t1, -400($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -404($fp)
	# %t83 = load.w %t82   ; line 402
	lw      $t0, -404($fp)
	lw      $t1, 0($t0)
	sw      $t1, -408($fp)
	# %t84 = %t83 == 8   ; line 402
	lw      $t0, -408($fp)
	xori    $t0, $t0, 8
	sltiu   $t0, $t0, 1
	sw      $t0, -412($fp)
	# ifFalse %t84 goto .L215   ; line 402
	lw      $t0, -412($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L215
	# if %rest goto .L214   ; line 402
	lw      $t0, -120($fp)
	bne     $t0, $zero, __rt_fmt_hexf.L214
	# ifFalse %up goto .L215   ; line 402
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L215
__rt_fmt_hexf.L214:
	# %t74 = 1   ; line 402
	li      $t0, 1
	sw      $t0, -372($fp)
	# goto .L216   ; line 402
	b       __rt_fmt_hexf.L216
__rt_fmt_hexf.L215:
	# %t74 = 0   ; line 402
	move    $t0, $zero
	sw      $t0, -372($fp)
__rt_fmt_hexf.L216:
	# %up = %t74   ; line 402
	lw      $t0, -372($fp)
	sw      $t0, -116($fp)
	# ifFalse %up goto .L218   ; line 403
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L218
	# %t85 = %prec - 1   ; line 404
	lw      $t0, -112($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -416($fp)
	# %i = %t85   ; line 404
	lw      $t0, -416($fp)
	sw      $t0, -96($fp)
__rt_fmt_hexf.L219:
	# %t86 = %i >= 0   ; line 405
	lw      $t0, -96($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -420($fp)
	# ifFalse %t86 goto .L221   ; line 405
	lw      $t0, -420($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L221
	# %t87 = addr nib   ; line 405
	addiu   $t0, $fp, -72
	sw      $t0, -424($fp)
	# %t88 = %i * 4   ; line 405
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -428($fp)
	# %t89 = %t87 + %t88   ; line 405
	lw      $t0, -424($fp)
	lw      $t1, -428($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -432($fp)
	# %t90 = load.w %t89   ; line 405
	lw      $t0, -432($fp)
	lw      $t1, 0($t0)
	sw      $t1, -436($fp)
	# %t91 = %t90 == 15   ; line 405
	lw      $t0, -436($fp)
	xori    $t0, $t0, 15
	sltiu   $t0, $t0, 1
	sw      $t0, -440($fp)
	# ifFalse %t91 goto .L221   ; line 405
	lw      $t0, -440($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L221
	# %t92 = addr nib   ; line 405
	addiu   $t0, $fp, -72
	sw      $t0, -444($fp)
	# %t93 = %i * 4   ; line 405
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -448($fp)
	# %t94 = %t92 + %t93   ; line 405
	lw      $t0, -444($fp)
	lw      $t1, -448($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -452($fp)
	# store.w %t94, 0   ; line 405
	lw      $t0, -452($fp)
	sw      $zero, 0($t0)
	# %t95 = %i   ; line 405
	lw      $t0, -96($fp)
	sw      $t0, -456($fp)
	# %t96 = %t95 - 1   ; line 405
	lw      $t0, -456($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -460($fp)
	# %i = %t96   ; line 405
	lw      $t0, -460($fp)
	sw      $t0, -96($fp)
	# goto .L219   ; line 405
	b       __rt_fmt_hexf.L219
__rt_fmt_hexf.L221:
	# %t97 = %i < 0   ; line 406
	lw      $t0, -96($fp)
	slti    $t0, $t0, 0
	sw      $t0, -464($fp)
	# ifFalse %t97 goto .L223   ; line 406
	lw      $t0, -464($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L223
	# %t98 = %lead   ; line 406
	lw      $t0, -104($fp)
	sw      $t0, -468($fp)
	# %t99 = %t98 + 1   ; line 406
	lw      $t0, -468($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -472($fp)
	# %lead = %t99   ; line 406
	lw      $t0, -472($fp)
	sw      $t0, -104($fp)
	# goto .L224   ; line 406
	b       __rt_fmt_hexf.L224
__rt_fmt_hexf.L223:
	# %t100 = addr nib   ; line 407
	addiu   $t0, $fp, -72
	sw      $t0, -476($fp)
	# %t101 = %i * 4   ; line 407
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -480($fp)
	# %t102 = %t100 + %t101   ; line 407
	lw      $t0, -476($fp)
	lw      $t1, -480($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -484($fp)
	# %t103 = load.w %t102   ; line 407
	lw      $t0, -484($fp)
	lw      $t1, 0($t0)
	sw      $t1, -488($fp)
	# %t104 = %t103   ; line 407
	lw      $t0, -488($fp)
	sw      $t0, -492($fp)
	# %t105 = %t104 + 1   ; line 407
	lw      $t0, -492($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -496($fp)
	# store.w %t102, %t105   ; line 407
	lw      $t0, -484($fp)
	lw      $t1, -496($fp)
	sw      $t1, 0($t0)
__rt_fmt_hexf.L224:
__rt_fmt_hexf.L218:
__rt_fmt_hexf.L204:
__rt_fmt_hexf.L202:
	# %t107 = %prec > 0   ; line 411
	lw      $t0, -112($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -504($fp)
	# if %t107 goto .L225   ; line 411
	lw      $t0, -504($fp)
	bne     $t0, $zero, __rt_fmt_hexf.L225
	# %t108 = addr @pf_alt   ; line 411
	la      $t0, __rtg_pf_alt
	sw      $t0, -508($fp)
	# %t109 = load.w %t108   ; line 411
	lw      $t0, -508($fp)
	lw      $t1, 0($t0)
	sw      $t1, -512($fp)
	# ifFalse %t109 goto .L226   ; line 411
	lw      $t0, -512($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L226
__rt_fmt_hexf.L225:
	# %t106 = 1   ; line 411
	li      $t0, 1
	sw      $t0, -500($fp)
	# goto .L227   ; line 411
	b       __rt_fmt_hexf.L227
__rt_fmt_hexf.L226:
	# %t106 = 0   ; line 411
	move    $t0, $zero
	sw      $t0, -500($fp)
__rt_fmt_hexf.L227:
	# %point = %t106   ; line 411
	lw      $t0, -500($fp)
	sw      $t0, -136($fp)
	# %t111 = %e < 0   ; line 412
	lw      $t0, -108($fp)
	slti    $t0, $t0, 0
	sw      $t0, -520($fp)
	# ifFalse %t111 goto .L229   ; line 412
	lw      $t0, -520($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L229
	# %t112 = - %e   ; line 412
	lw      $t0, -108($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -524($fp)
	# %t110 = %t112   ; line 412
	lw      $t0, -524($fp)
	sw      $t0, -516($fp)
	# goto .L230   ; line 412
	b       __rt_fmt_hexf.L230
__rt_fmt_hexf.L229:
	# %t110 = %e   ; line 412
	lw      $t0, -108($fp)
	sw      $t0, -516($fp)
__rt_fmt_hexf.L230:
	# %ax = %t110   ; line 412
	lw      $t0, -516($fp)
	sw      $t0, -132($fp)
	# %t113 = %np + 2   ; line 413
	lw      $t0, -92($fp)
	addiu   $t0, $t0, 2
	sw      $t0, -528($fp)
	# %t114 = %t113 + 1   ; line 413
	lw      $t0, -528($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -532($fp)
	# ifFalse %point goto .L232   ; line 413
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L232
	# %t116 = 1 + %prec   ; line 413
	li      $t0, 1
	lw      $t1, -112($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -540($fp)
	# %t115 = %t116   ; line 413
	lw      $t0, -540($fp)
	sw      $t0, -536($fp)
	# goto .L233   ; line 413
	b       __rt_fmt_hexf.L233
__rt_fmt_hexf.L232:
	# %t115 = 0   ; line 413
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_fmt_hexf.L233:
	# %t117 = %t114 + %t115   ; line 413
	lw      $t0, -532($fp)
	lw      $t1, -536($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -544($fp)
	# %t118 = %t117 + 2   ; line 413
	lw      $t0, -544($fp)
	addiu   $t0, $t0, 2
	sw      $t0, -548($fp)
	# %len = %t118   ; line 413
	lw      $t0, -548($fp)
	sw      $t0, -124($fp)
	# %t119 = %ax >= 10   ; line 414
	lw      $t0, -132($fp)
	slti    $t0, $t0, 10
	xori    $t0, $t0, 1
	sw      $t0, -552($fp)
	# ifFalse %t119 goto .L235   ; line 414
	lw      $t0, -552($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L235
	# %t120 = %len   ; line 414
	lw      $t0, -124($fp)
	sw      $t0, -556($fp)
	# %t121 = %t120 + 1   ; line 414
	lw      $t0, -556($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -560($fp)
	# %len = %t121   ; line 414
	lw      $t0, -560($fp)
	sw      $t0, -124($fp)
__rt_fmt_hexf.L235:
	# %t122 = %ax >= 100   ; line 415
	lw      $t0, -132($fp)
	slti    $t0, $t0, 100
	xori    $t0, $t0, 1
	sw      $t0, -564($fp)
	# ifFalse %t122 goto .L237   ; line 415
	lw      $t0, -564($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L237
	# %t123 = %len   ; line 415
	lw      $t0, -124($fp)
	sw      $t0, -568($fp)
	# %t124 = %t123 + 1   ; line 415
	lw      $t0, -568($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -572($fp)
	# %len = %t124   ; line 415
	lw      $t0, -572($fp)
	sw      $t0, -124($fp)
__rt_fmt_hexf.L237:
	# %t125 = %ax >= 1000   ; line 416
	lw      $t0, -132($fp)
	slti    $t0, $t0, 1000
	xori    $t0, $t0, 1
	sw      $t0, -576($fp)
	# ifFalse %t125 goto .L239   ; line 416
	lw      $t0, -576($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L239
	# %t126 = %len   ; line 416
	lw      $t0, -124($fp)
	sw      $t0, -580($fp)
	# %t127 = %t126 + 1   ; line 416
	lw      $t0, -580($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -584($fp)
	# %len = %t127   ; line 416
	lw      $t0, -584($fp)
	sw      $t0, -124($fp)
__rt_fmt_hexf.L239:
	# %zeros = 0   ; line 417
	move    $t0, $zero
	sw      $t0, -128($fp)
	# %t128 = addr @pf_zero   ; line 418
	la      $t0, __rtg_pf_zero
	sw      $t0, -588($fp)
	# %t129 = load.w %t128   ; line 418
	lw      $t0, -588($fp)
	lw      $t1, 0($t0)
	sw      $t1, -592($fp)
	# ifFalse %t129 goto .L241   ; line 418
	lw      $t0, -592($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L241
	# %t130 = addr @pf_left   ; line 418
	la      $t0, __rtg_pf_left
	sw      $t0, -596($fp)
	# %t131 = load.w %t130   ; line 418
	lw      $t0, -596($fp)
	lw      $t1, 0($t0)
	sw      $t1, -600($fp)
	# if %t131 goto .L241   ; line 418
	lw      $t0, -600($fp)
	bne     $t0, $zero, __rt_fmt_hexf.L241
	# %t132 = addr @pf_width   ; line 418
	la      $t0, __rtg_pf_width
	sw      $t0, -604($fp)
	# %t133 = load.w %t132   ; line 418
	lw      $t0, -604($fp)
	lw      $t1, 0($t0)
	sw      $t1, -608($fp)
	# %t134 = %t133 > %len   ; line 418
	lw      $t0, -608($fp)
	lw      $t1, -124($fp)
	slt     $t0, $t1, $t0
	sw      $t0, -612($fp)
	# ifFalse %t134 goto .L241   ; line 418
	lw      $t0, -612($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L241
	# %t135 = addr @pf_width   ; line 418
	la      $t0, __rtg_pf_width
	sw      $t0, -616($fp)
	# %t136 = load.w %t135   ; line 418
	lw      $t0, -616($fp)
	lw      $t1, 0($t0)
	sw      $t1, -620($fp)
	# %t137 = %t136 - %len   ; line 418
	lw      $t0, -620($fp)
	lw      $t1, -124($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -624($fp)
	# %zeros = %t137   ; line 418
	lw      $t0, -624($fp)
	sw      $t0, -128($fp)
__rt_fmt_hexf.L241:
	# %t138 = %len + %zeros   ; line 419
	lw      $t0, -124($fp)
	lw      $t1, -128($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -628($fp)
	# param %t138 : int   ; line 419
	lw      $t0, -628($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 419
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# param %pre : str   ; line 420
	lw      $t0, -88($fp)
	sw      $t0, 0($sp)
	# param %np : int   ; line 420
	lw      $t0, -92($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 420
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# %t139 = 48   ; line 421
	li      $t0, 48
	sw      $t0, -632($fp)
	# param %t139 : int   ; line 421
	lw      $t0, -632($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 421
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# ifFalse %upper goto .L243   ; line 422
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L243
	# %t140 = 88   ; line 422
	li      $t0, 88
	sw      $t0, -636($fp)
	# goto .L244   ; line 422
	b       __rt_fmt_hexf.L244
__rt_fmt_hexf.L243:
	# %t140 = 120   ; line 422
	li      $t0, 120
	sw      $t0, -636($fp)
__rt_fmt_hexf.L244:
	# param %t140 : int   ; line 422
	lw      $t0, -636($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 422
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t141 = 48   ; line 423
	li      $t0, 48
	sw      $t0, -640($fp)
	# param %t141 : int   ; line 423
	lw      $t0, -640($fp)
	sw      $t0, 0($sp)
	# param %zeros : int   ; line 423
	lw      $t0, -128($fp)
	sw      $t0, 4($sp)
	# call @out_pad, 2   ; line 423
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_pad
	# param %lead : int   ; line 424
	lw      $t0, -104($fp)
	sw      $t0, 0($sp)
	# param %upper : int   ; line 424
	lw      $t0, -84($fp)
	sw      $t0, 4($sp)
	# %t142 = call @dig_char, 2   ; line 424
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dig_char
	sw      $v0, -644($fp)
	# param %t142 : int   ; line 424
	lw      $t0, -644($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 424
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# ifFalse %point goto .L246   ; line 425
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L246
	# %t143 = 46   ; line 425
	li      $t0, 46
	sw      $t0, -648($fp)
	# param %t143 : int   ; line 425
	lw      $t0, -648($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 425
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_fmt_hexf.L246:
	# %i = 0   ; line 426
	move    $t0, $zero
	sw      $t0, -96($fp)
__rt_fmt_hexf.L247:
	# %t144 = %i < %prec   ; line 426
	lw      $t0, -96($fp)
	lw      $t1, -112($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -652($fp)
	# ifFalse %t144 goto .L250   ; line 426
	lw      $t0, -652($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L250
	# %t145 = %i < 13   ; line 427
	lw      $t0, -96($fp)
	slti    $t0, $t0, 13
	sw      $t0, -656($fp)
	# ifFalse %t145 goto .L252   ; line 427
	lw      $t0, -656($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L252
	# %t146 = addr nib   ; line 427
	addiu   $t0, $fp, -72
	sw      $t0, -660($fp)
	# %t147 = %i * 4   ; line 427
	lw      $t0, -96($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -664($fp)
	# %t148 = %t146 + %t147   ; line 427
	lw      $t0, -660($fp)
	lw      $t1, -664($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -668($fp)
	# %t149 = load.w %t148   ; line 427
	lw      $t0, -668($fp)
	lw      $t1, 0($t0)
	sw      $t1, -672($fp)
	# param %t149 : int   ; line 427
	lw      $t0, -672($fp)
	sw      $t0, 0($sp)
	# param %upper : int   ; line 427
	lw      $t0, -84($fp)
	sw      $t0, 4($sp)
	# %t150 = call @dig_char, 2   ; line 427
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dig_char
	sw      $v0, -676($fp)
	# param %t150 : int   ; line 427
	lw      $t0, -676($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 427
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# goto .L253   ; line 427
	b       __rt_fmt_hexf.L253
__rt_fmt_hexf.L252:
	# %t151 = 48   ; line 428
	li      $t0, 48
	sw      $t0, -680($fp)
	# param %t151 : int   ; line 428
	lw      $t0, -680($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 428
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_fmt_hexf.L253:
	# %t152 = %i   ; line 426
	lw      $t0, -96($fp)
	sw      $t0, -684($fp)
	# %t153 = %t152 + 1   ; line 426
	lw      $t0, -684($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -688($fp)
	# %i = %t153   ; line 426
	lw      $t0, -688($fp)
	sw      $t0, -96($fp)
	# goto .L247   ; line 426
	b       __rt_fmt_hexf.L247
__rt_fmt_hexf.L250:
	# ifFalse %upper goto .L255   ; line 430
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L255
	# %t154 = 80   ; line 430
	li      $t0, 80
	sw      $t0, -692($fp)
	# goto .L256   ; line 430
	b       __rt_fmt_hexf.L256
__rt_fmt_hexf.L255:
	# %t154 = 112   ; line 430
	li      $t0, 112
	sw      $t0, -692($fp)
__rt_fmt_hexf.L256:
	# param %t154 : int   ; line 430
	lw      $t0, -692($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 430
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t155 = %e < 0   ; line 431
	lw      $t0, -108($fp)
	slti    $t0, $t0, 0
	sw      $t0, -696($fp)
	# ifFalse %t155 goto .L258   ; line 431
	lw      $t0, -696($fp)
	beq     $t0, $zero, __rt_fmt_hexf.L258
	# %t156 = 45   ; line 431
	li      $t0, 45
	sw      $t0, -700($fp)
	# param %t156 : int   ; line 431
	lw      $t0, -700($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 431
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# goto .L259   ; line 431
	b       __rt_fmt_hexf.L259
__rt_fmt_hexf.L258:
	# %t157 = 43   ; line 432
	li      $t0, 43
	sw      $t0, -704($fp)
	# param %t157 : int   ; line 432
	lw      $t0, -704($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 432
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_fmt_hexf.L259:
	# %t158 = 1   ; line 433
	li      $t0, 1
	sw      $t0, -708($fp)
	# param %ax : int   ; line 433
	lw      $t0, -132($fp)
	sw      $t0, 0($sp)
	# param %t158 : int   ; line 433
	lw      $t0, -708($fp)
	sw      $t0, 4($sp)
	# call @out_num, 2   ; line 433
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_num
	# %t159 = %len + %zeros   ; line 434
	lw      $t0, -124($fp)
	lw      $t1, -128($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -712($fp)
	# param %t159 : int   ; line 434
	lw      $t0, -712($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 434
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# return
__rt_fmt_hexf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fmt_float
	.text
# ---------------------------------------------------------------
# function fmt_float (line 442), returns void
# frame 616 bytes ($fp = $sp at entry):
#   0($fp)	param hi (int, arrives in $a0)
#   4($fp)	param lo (int, arrives in $a1)
#   8($fp)	param conv (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	local pre : char [4] (4 bytes)
#   -20($fp)	%hi : int
#   -24($fp)	%lo : int
#   -28($fp)	%conv : int
#   -32($fp)	%upper : int
#   -36($fp)	%c : int
#   -40($fp)	%np : int
#   -44($fp)	%prec : int
#   -48($fp)	%p : int
#   -52($fp)	%x : int
#   -56($fp)	%t : int
#   -60($fp)	%kind : int
#   -64($fp)	%point : int
#   -68($fp)	%len : int
#   -72($fp)	%zeros : int
#   -76($fp)	%ax : int
#   -80($fp)	%t15 : int
#   -84($fp)	%t16 : int
#   -88($fp)	%t17 : int
#   -92($fp)	%t18 : int
#   -96($fp)	%t19 : int
#   -100($fp)	%t20 : int
#   -104($fp)	%t21 : int
#   -108($fp)	%t22 : ptr
#   -112($fp)	%t23 : int
#   -116($fp)	%t24 : int
#   -120($fp)	%t25 : str
#   -124($fp)	%t26 : ptr
#   -128($fp)	%t27 : int
#   -132($fp)	%t28 : ptr
#   -136($fp)	%t29 : int
#   -140($fp)	%t30 : int
#   -144($fp)	%t31 : str
#   -148($fp)	%t32 : ptr
#   -152($fp)	%t33 : int
#   -156($fp)	%t34 : ptr
#   -160($fp)	%t35 : int
#   -164($fp)	%t36 : int
#   -168($fp)	%t37 : str
#   -172($fp)	%t38 : int
#   -176($fp)	%t39 : int
#   -180($fp)	%t40 : int
#   -184($fp)	%t41 : ptr
#   -188($fp)	%t42 : int
#   -192($fp)	%t43 : int
#   -196($fp)	%t44 : int
#   -200($fp)	%t45 : str
#   -204($fp)	%t46 : str
#   -208($fp)	%t47 : str
#   -212($fp)	%t48 : int
#   -216($fp)	%t49 : str
#   -220($fp)	%t50 : str
#   -224($fp)	%t51 : str
#   -228($fp)	%t52 : int
#   -232($fp)	%t53 : int
#   -236($fp)	%t54 : ptr
#   -240($fp)	%t55 : int
#   -244($fp)	%t56 : ptr
#   -248($fp)	%t57 : int
#   -252($fp)	%t58 : int
#   -256($fp)	%t59 : ptr
#   -260($fp)	%t60 : int
#   -264($fp)	%t61 : int
#   -268($fp)	%t62 : ptr
#   -272($fp)	%t63 : int
#   -276($fp)	%t64 : int
#   -280($fp)	%t65 : int
#   -284($fp)	%t66 : int
#   -288($fp)	%t67 : int
#   -292($fp)	%t68 : int
#   -296($fp)	%t69 : int
#   -300($fp)	%t70 : ptr
#   -304($fp)	%t71 : int
#   -308($fp)	%t72 : ptr
#   -312($fp)	%t73 : int
#   -316($fp)	%t74 : int
#   -320($fp)	%t75 : int
#   -324($fp)	%t76 : int
#   -328($fp)	%t77 : int
#   -332($fp)	%t78 : int
#   -336($fp)	%t79 : ptr
#   -340($fp)	%t80 : int
#   -344($fp)	%t81 : ptr
#   -348($fp)	%t82 : int
#   -352($fp)	%t83 : int
#   -356($fp)	%t84 : ptr
#   -360($fp)	%t85 : int
#   -364($fp)	%t86 : int
#   -368($fp)	%t87 : int
#   -372($fp)	%t88 : int
#   -376($fp)	%t89 : int
#   -380($fp)	%t90 : ptr
#   -384($fp)	%t91 : int
#   -388($fp)	%t92 : int
#   -392($fp)	%t93 : ptr
#   -396($fp)	%t94 : int
#   -400($fp)	%t95 : int
#   -404($fp)	%t96 : int
#   -408($fp)	%t97 : int
#   -412($fp)	%t98 : int
#   -416($fp)	%t99 : int
#   -420($fp)	%t100 : ptr
#   -424($fp)	%t101 : int
#   -428($fp)	%t102 : int
#   -432($fp)	%t103 : int
#   -436($fp)	%t104 : ptr
#   -440($fp)	%t105 : int
#   -444($fp)	%t106 : int
#   -448($fp)	%t107 : ptr
#   -452($fp)	%t108 : int
#   -456($fp)	%t109 : int
#   -460($fp)	%t110 : int
#   -464($fp)	%t111 : int
#   -468($fp)	%t112 : int
#   -472($fp)	%t113 : ptr
#   -476($fp)	%t114 : int
#   -480($fp)	%t115 : ptr
#   -484($fp)	%t116 : int
#   -488($fp)	%t117 : int
#   -492($fp)	%t118 : int
#   -496($fp)	%t119 : int
#   -500($fp)	%t120 : int
#   -504($fp)	%t121 : int
#   -508($fp)	%t122 : int
#   -512($fp)	%t123 : int
#   -516($fp)	%t124 : int
#   -520($fp)	%t125 : int
#   -524($fp)	%t126 : int
#   -528($fp)	%t127 : int
#   -532($fp)	%t128 : int
#   -536($fp)	%t129 : ptr
#   -540($fp)	%t130 : int
#   -544($fp)	%t131 : ptr
#   -548($fp)	%t132 : int
#   -552($fp)	%t133 : ptr
#   -556($fp)	%t134 : int
#   -560($fp)	%t135 : int
#   -564($fp)	%t136 : ptr
#   -568($fp)	%t137 : int
#   -572($fp)	%t138 : int
#   -576($fp)	%t139 : int
#   -580($fp)	%t140 : ptr
#   -584($fp)	%t141 : int
#   -588($fp)	%t142 : int
#   -592($fp)	%t143 : int
#   0($sp)	outgoing arguments (24 bytes)
# ---------------------------------------------------------------
	.globl __rt_fmt_float
__rt_fmt_float:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -616
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param hi : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -20($fp)
	# param lo : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -24($fp)
	# param conv : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -28($fp)
	# %t16 = %conv == 70   ; line 445
	lw      $t0, -28($fp)
	xori    $t0, $t0, 70
	sltiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# if %t16 goto .L260   ; line 445
	lw      $t0, -84($fp)
	bne     $t0, $zero, __rt_fmt_float.L260
	# %t17 = %conv == 69   ; line 445
	lw      $t0, -28($fp)
	xori    $t0, $t0, 69
	sltiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# if %t17 goto .L260   ; line 445
	lw      $t0, -88($fp)
	bne     $t0, $zero, __rt_fmt_float.L260
	# %t18 = %conv == 71   ; line 445
	lw      $t0, -28($fp)
	xori    $t0, $t0, 71
	sltiu   $t0, $t0, 1
	sw      $t0, -92($fp)
	# if %t18 goto .L260   ; line 445
	lw      $t0, -92($fp)
	bne     $t0, $zero, __rt_fmt_float.L260
	# %t19 = %conv == 65   ; line 445
	lw      $t0, -28($fp)
	xori    $t0, $t0, 65
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t19 goto .L261   ; line 445
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_fmt_float.L261
__rt_fmt_float.L260:
	# %t15 = 1   ; line 445
	li      $t0, 1
	sw      $t0, -80($fp)
	# goto .L262   ; line 445
	b       __rt_fmt_float.L262
__rt_fmt_float.L261:
	# %t15 = 0   ; line 445
	move    $t0, $zero
	sw      $t0, -80($fp)
__rt_fmt_float.L262:
	# %upper = %t15   ; line 445
	lw      $t0, -80($fp)
	sw      $t0, -32($fp)
	# %t20 = %conv | 32   ; line 446
	lw      $t0, -28($fp)
	ori     $t0, $t0, 32
	sw      $t0, -100($fp)
	# %c = %t20   ; line 446
	lw      $t0, -100($fp)
	sw      $t0, -36($fp)
	# %np = 0   ; line 447
	move    $t0, $zero
	sw      $t0, -40($fp)
	# %t21 = %hi < 0   ; line 448
	lw      $t0, -20($fp)
	slti    $t0, $t0, 0
	sw      $t0, -104($fp)
	# ifFalse %t21 goto .L264   ; line 448
	lw      $t0, -104($fp)
	beq     $t0, $zero, __rt_fmt_float.L264
	# %t22 = addr pre   ; line 448
	addiu   $t0, $fp, -16
	sw      $t0, -108($fp)
	# %t23 = %np   ; line 448
	lw      $t0, -40($fp)
	sw      $t0, -112($fp)
	# %t24 = %t23 + 1   ; line 448
	lw      $t0, -112($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -116($fp)
	# %np = %t24   ; line 448
	lw      $t0, -116($fp)
	sw      $t0, -40($fp)
	# %t25 = %t22 + %t23   ; line 448
	lw      $t0, -108($fp)
	lw      $t1, -112($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -120($fp)
	# store.b %t25, 45   ; line 448
	lw      $t0, -120($fp)
	li      $t1, 45
	sb      $t1, 0($t0)
	# goto .L265   ; line 448
	b       __rt_fmt_float.L265
__rt_fmt_float.L264:
	# %t26 = addr @pf_plus   ; line 449
	la      $t0, __rtg_pf_plus
	sw      $t0, -124($fp)
	# %t27 = load.w %t26   ; line 449
	lw      $t0, -124($fp)
	lw      $t1, 0($t0)
	sw      $t1, -128($fp)
	# ifFalse %t27 goto .L267   ; line 449
	lw      $t0, -128($fp)
	beq     $t0, $zero, __rt_fmt_float.L267
	# %t28 = addr pre   ; line 449
	addiu   $t0, $fp, -16
	sw      $t0, -132($fp)
	# %t29 = %np   ; line 449
	lw      $t0, -40($fp)
	sw      $t0, -136($fp)
	# %t30 = %t29 + 1   ; line 449
	lw      $t0, -136($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -140($fp)
	# %np = %t30   ; line 449
	lw      $t0, -140($fp)
	sw      $t0, -40($fp)
	# %t31 = %t28 + %t29   ; line 449
	lw      $t0, -132($fp)
	lw      $t1, -136($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -144($fp)
	# store.b %t31, 43   ; line 449
	lw      $t0, -144($fp)
	li      $t1, 43
	sb      $t1, 0($t0)
	# goto .L268   ; line 449
	b       __rt_fmt_float.L268
__rt_fmt_float.L267:
	# %t32 = addr @pf_space   ; line 450
	la      $t0, __rtg_pf_space
	sw      $t0, -148($fp)
	# %t33 = load.w %t32   ; line 450
	lw      $t0, -148($fp)
	lw      $t1, 0($t0)
	sw      $t1, -152($fp)
	# ifFalse %t33 goto .L270   ; line 450
	lw      $t0, -152($fp)
	beq     $t0, $zero, __rt_fmt_float.L270
	# %t34 = addr pre   ; line 450
	addiu   $t0, $fp, -16
	sw      $t0, -156($fp)
	# %t35 = %np   ; line 450
	lw      $t0, -40($fp)
	sw      $t0, -160($fp)
	# %t36 = %t35 + 1   ; line 450
	lw      $t0, -160($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -164($fp)
	# %np = %t36   ; line 450
	lw      $t0, -164($fp)
	sw      $t0, -40($fp)
	# %t37 = %t34 + %t35   ; line 450
	lw      $t0, -156($fp)
	lw      $t1, -160($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -168($fp)
	# store.b %t37, 32   ; line 450
	lw      $t0, -168($fp)
	li      $t1, 32
	sb      $t1, 0($t0)
__rt_fmt_float.L270:
__rt_fmt_float.L268:
__rt_fmt_float.L265:
	# %t38 = %hi & 2146435072   ; line 451
	lw      $t0, -20($fp)
	li      $t1, 2146435072
	and     $t0, $t0, $t1
	sw      $t0, -172($fp)
	# %t39 = %t38 == 2146435072   ; line 451
	lw      $t0, -172($fp)
	li      $t1, 2146435072
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -176($fp)
	# ifFalse %t39 goto .L272   ; line 451
	lw      $t0, -176($fp)
	beq     $t0, $zero, __rt_fmt_float.L272
	# %t40 = %np + 3   ; line 452
	lw      $t0, -40($fp)
	addiu   $t0, $t0, 3
	sw      $t0, -180($fp)
	# %len = %t40   ; line 452
	lw      $t0, -180($fp)
	sw      $t0, -68($fp)
	# param %len : int   ; line 453
	lw      $t0, -68($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 453
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# %t41 = addr pre   ; line 454
	addiu   $t0, $fp, -16
	sw      $t0, -184($fp)
	# param %t41 : str   ; line 454
	lw      $t0, -184($fp)
	sw      $t0, 0($sp)
	# param %np : int   ; line 454
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 454
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# %t42 = %hi & 1048575   ; line 455
	lw      $t0, -20($fp)
	li      $t1, 1048575
	and     $t0, $t0, $t1
	sw      $t0, -188($fp)
	# %t43 = %t42 != 0   ; line 455
	lw      $t0, -188($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -192($fp)
	# if %t43 goto .L273   ; line 455
	lw      $t0, -192($fp)
	bne     $t0, $zero, __rt_fmt_float.L273
	# %t44 = %lo != 0   ; line 455
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -196($fp)
	# ifFalse %t44 goto .L274   ; line 455
	lw      $t0, -196($fp)
	beq     $t0, $zero, __rt_fmt_float.L274
__rt_fmt_float.L273:
	# ifFalse %upper goto .L276   ; line 455
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fmt_float.L276
	# %t46 = addr @.str4   ; line 455
	la      $t0, __rtd.str4
	sw      $t0, -204($fp)
	# %t45 = %t46   ; line 455
	lw      $t0, -204($fp)
	sw      $t0, -200($fp)
	# goto .L277   ; line 455
	b       __rt_fmt_float.L277
__rt_fmt_float.L276:
	# %t47 = addr @.str5   ; line 455
	la      $t0, __rtd.str5
	sw      $t0, -208($fp)
	# %t45 = %t47   ; line 455
	lw      $t0, -208($fp)
	sw      $t0, -200($fp)
__rt_fmt_float.L277:
	# %t48 = 3   ; line 455
	li      $t0, 3
	sw      $t0, -212($fp)
	# param %t45 : str   ; line 455
	lw      $t0, -200($fp)
	sw      $t0, 0($sp)
	# param %t48 : int   ; line 455
	lw      $t0, -212($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 455
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# goto .L278   ; line 455
	b       __rt_fmt_float.L278
__rt_fmt_float.L274:
	# ifFalse %upper goto .L280   ; line 456
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fmt_float.L280
	# %t50 = addr @.str6   ; line 456
	la      $t0, __rtd.str6
	sw      $t0, -220($fp)
	# %t49 = %t50   ; line 456
	lw      $t0, -220($fp)
	sw      $t0, -216($fp)
	# goto .L281   ; line 456
	b       __rt_fmt_float.L281
__rt_fmt_float.L280:
	# %t51 = addr @.str7   ; line 456
	la      $t0, __rtd.str7
	sw      $t0, -224($fp)
	# %t49 = %t51   ; line 456
	lw      $t0, -224($fp)
	sw      $t0, -216($fp)
__rt_fmt_float.L281:
	# %t52 = 3   ; line 456
	li      $t0, 3
	sw      $t0, -228($fp)
	# param %t49 : str   ; line 456
	lw      $t0, -216($fp)
	sw      $t0, 0($sp)
	# param %t52 : int   ; line 456
	lw      $t0, -228($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 456
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
__rt_fmt_float.L278:
	# param %len : int   ; line 457
	lw      $t0, -68($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 457
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# return   ; line 458
	b       __rt_fmt_float.ret
__rt_fmt_float.L272:
	# %t53 = %c == 97   ; line 460
	lw      $t0, -36($fp)
	xori    $t0, $t0, 97
	sltiu   $t0, $t0, 1
	sw      $t0, -232($fp)
	# ifFalse %t53 goto .L283   ; line 460
	lw      $t0, -232($fp)
	beq     $t0, $zero, __rt_fmt_float.L283
	# %t54 = addr pre   ; line 461
	addiu   $t0, $fp, -16
	sw      $t0, -236($fp)
	# param %hi : int   ; line 461
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# param %lo : int   ; line 461
	lw      $t0, -24($fp)
	sw      $t0, 4($sp)
	# param %upper : int   ; line 461
	lw      $t0, -32($fp)
	sw      $t0, 8($sp)
	# param %t54 : str   ; line 461
	lw      $t0, -236($fp)
	sw      $t0, 12($sp)
	# param %np : int   ; line 461
	lw      $t0, -40($fp)
	sw      $t0, 16($sp)
	# call @fmt_hexf, 5   ; line 461
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_fmt_hexf
	# return   ; line 462
	b       __rt_fmt_float.ret
__rt_fmt_float.L283:
	# param %hi : int   ; line 464
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# param %lo : int   ; line 464
	lw      $t0, -24($fp)
	sw      $t0, 4($sp)
	# call @fd_decode, 2   ; line 464
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_fd_decode
	# %t56 = addr @pf_prec   ; line 465
	la      $t0, __rtg_pf_prec
	sw      $t0, -244($fp)
	# %t57 = load.w %t56   ; line 465
	lw      $t0, -244($fp)
	lw      $t1, 0($t0)
	sw      $t1, -248($fp)
	# %t58 = %t57 < 0   ; line 465
	lw      $t0, -248($fp)
	slti    $t0, $t0, 0
	sw      $t0, -252($fp)
	# ifFalse %t58 goto .L285   ; line 465
	lw      $t0, -252($fp)
	beq     $t0, $zero, __rt_fmt_float.L285
	# %t55 = 6   ; line 465
	li      $t0, 6
	sw      $t0, -240($fp)
	# goto .L286   ; line 465
	b       __rt_fmt_float.L286
__rt_fmt_float.L285:
	# %t59 = addr @pf_prec   ; line 465
	la      $t0, __rtg_pf_prec
	sw      $t0, -256($fp)
	# %t60 = load.w %t59   ; line 465
	lw      $t0, -256($fp)
	lw      $t1, 0($t0)
	sw      $t1, -260($fp)
	# %t55 = %t60   ; line 465
	lw      $t0, -260($fp)
	sw      $t0, -240($fp)
__rt_fmt_float.L286:
	# %prec = %t55   ; line 465
	lw      $t0, -240($fp)
	sw      $t0, -44($fp)
	# %kind = %c   ; line 466
	lw      $t0, -36($fp)
	sw      $t0, -60($fp)
	# %t61 = %c == 102   ; line 467
	lw      $t0, -36($fp)
	xori    $t0, $t0, 102
	sltiu   $t0, $t0, 1
	sw      $t0, -264($fp)
	# ifFalse %t61 goto .L288   ; line 467
	lw      $t0, -264($fp)
	beq     $t0, $zero, __rt_fmt_float.L288
	# %t62 = addr @fd_exp   ; line 467
	la      $t0, __rtg_fd_exp
	sw      $t0, -268($fp)
	# %t63 = load.w %t62   ; line 467
	lw      $t0, -268($fp)
	lw      $t1, 0($t0)
	sw      $t1, -272($fp)
	# %t64 = %t63 + %prec   ; line 467
	lw      $t0, -272($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -276($fp)
	# param %t64 : int   ; line 467
	lw      $t0, -276($fp)
	sw      $t0, 0($sp)
	# call @fd_round, 1   ; line 467
	lw      $a0, 0($sp)
	jal     __rt_fd_round
	# goto .L289   ; line 467
	b       __rt_fmt_float.L289
__rt_fmt_float.L288:
	# %t65 = %c == 101   ; line 468
	lw      $t0, -36($fp)
	xori    $t0, $t0, 101
	sltiu   $t0, $t0, 1
	sw      $t0, -280($fp)
	# ifFalse %t65 goto .L291   ; line 468
	lw      $t0, -280($fp)
	beq     $t0, $zero, __rt_fmt_float.L291
	# %t66 = %prec + 1   ; line 468
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -284($fp)
	# param %t66 : int   ; line 468
	lw      $t0, -284($fp)
	sw      $t0, 0($sp)
	# call @fd_round, 1   ; line 468
	lw      $a0, 0($sp)
	jal     __rt_fd_round
	# goto .L292   ; line 468
	b       __rt_fmt_float.L292
__rt_fmt_float.L291:
	# %t68 = %prec == 0   ; line 470
	lw      $t0, -44($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -292($fp)
	# ifFalse %t68 goto .L294   ; line 470
	lw      $t0, -292($fp)
	beq     $t0, $zero, __rt_fmt_float.L294
	# %t67 = 1   ; line 470
	li      $t0, 1
	sw      $t0, -288($fp)
	# goto .L295   ; line 470
	b       __rt_fmt_float.L295
__rt_fmt_float.L294:
	# %t67 = %prec   ; line 470
	lw      $t0, -44($fp)
	sw      $t0, -288($fp)
__rt_fmt_float.L295:
	# %p = %t67   ; line 470
	lw      $t0, -288($fp)
	sw      $t0, -48($fp)
	# param %p : int   ; line 471
	lw      $t0, -48($fp)
	sw      $t0, 0($sp)
	# call @fd_round, 1   ; line 471
	lw      $a0, 0($sp)
	jal     __rt_fd_round
	# %t70 = addr @fd_n   ; line 472
	la      $t0, __rtg_fd_n
	sw      $t0, -300($fp)
	# %t71 = load.w %t70   ; line 472
	lw      $t0, -300($fp)
	lw      $t1, 0($t0)
	sw      $t1, -304($fp)
	# ifFalse %t71 goto .L297   ; line 472
	lw      $t0, -304($fp)
	beq     $t0, $zero, __rt_fmt_float.L297
	# %t72 = addr @fd_exp   ; line 472
	la      $t0, __rtg_fd_exp
	sw      $t0, -308($fp)
	# %t73 = load.w %t72   ; line 472
	lw      $t0, -308($fp)
	lw      $t1, 0($t0)
	sw      $t1, -312($fp)
	# %t74 = %t73 - 1   ; line 472
	lw      $t0, -312($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -316($fp)
	# %t69 = %t74   ; line 472
	lw      $t0, -316($fp)
	sw      $t0, -296($fp)
	# goto .L298   ; line 472
	b       __rt_fmt_float.L298
__rt_fmt_float.L297:
	# %t69 = 0   ; line 472
	move    $t0, $zero
	sw      $t0, -296($fp)
__rt_fmt_float.L298:
	# %x = %t69   ; line 472
	lw      $t0, -296($fp)
	sw      $t0, -52($fp)
	# %t75 = %x < %p   ; line 473
	lw      $t0, -52($fp)
	lw      $t1, -48($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -320($fp)
	# ifFalse %t75 goto .L300   ; line 473
	lw      $t0, -320($fp)
	beq     $t0, $zero, __rt_fmt_float.L300
	# %t76 = %x >= -4   ; line 473
	lw      $t0, -52($fp)
	slti    $t0, $t0, -4
	xori    $t0, $t0, 1
	sw      $t0, -324($fp)
	# ifFalse %t76 goto .L300   ; line 473
	lw      $t0, -324($fp)
	beq     $t0, $zero, __rt_fmt_float.L300
	# %kind = 102   ; line 474
	li      $t0, 102
	sw      $t0, -60($fp)
	# %t77 = %p - 1   ; line 475
	lw      $t0, -48($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -328($fp)
	# %t78 = %t77 - %x   ; line 475
	lw      $t0, -328($fp)
	lw      $t1, -52($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -332($fp)
	# %prec = %t78   ; line 475
	lw      $t0, -332($fp)
	sw      $t0, -44($fp)
	# %t79 = addr @fd_n   ; line 476
	la      $t0, __rtg_fd_n
	sw      $t0, -336($fp)
	# %t80 = load.w %t79   ; line 476
	lw      $t0, -336($fp)
	lw      $t1, 0($t0)
	sw      $t1, -340($fp)
	# %t81 = addr @fd_exp   ; line 476
	la      $t0, __rtg_fd_exp
	sw      $t0, -344($fp)
	# %t82 = load.w %t81   ; line 476
	lw      $t0, -344($fp)
	lw      $t1, 0($t0)
	sw      $t1, -348($fp)
	# %t83 = %t80 - %t82   ; line 476
	lw      $t0, -340($fp)
	lw      $t1, -348($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -352($fp)
	# %t = %t83   ; line 476
	lw      $t0, -352($fp)
	sw      $t0, -56($fp)
	# %t84 = addr @pf_alt   ; line 477
	la      $t0, __rtg_pf_alt
	sw      $t0, -356($fp)
	# %t85 = load.w %t84   ; line 477
	lw      $t0, -356($fp)
	lw      $t1, 0($t0)
	sw      $t1, -360($fp)
	# if %t85 goto .L302   ; line 477
	lw      $t0, -360($fp)
	bne     $t0, $zero, __rt_fmt_float.L302
	# %t86 = %t < %prec   ; line 477
	lw      $t0, -56($fp)
	lw      $t1, -44($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -364($fp)
	# ifFalse %t86 goto .L302   ; line 477
	lw      $t0, -364($fp)
	beq     $t0, $zero, __rt_fmt_float.L302
	# %t88 = %t < 0   ; line 477
	lw      $t0, -56($fp)
	slti    $t0, $t0, 0
	sw      $t0, -372($fp)
	# ifFalse %t88 goto .L304   ; line 477
	lw      $t0, -372($fp)
	beq     $t0, $zero, __rt_fmt_float.L304
	# %t87 = 0   ; line 477
	move    $t0, $zero
	sw      $t0, -368($fp)
	# goto .L305   ; line 477
	b       __rt_fmt_float.L305
__rt_fmt_float.L304:
	# %t87 = %t   ; line 477
	lw      $t0, -56($fp)
	sw      $t0, -368($fp)
__rt_fmt_float.L305:
	# %prec = %t87   ; line 477
	lw      $t0, -368($fp)
	sw      $t0, -44($fp)
__rt_fmt_float.L302:
	# goto .L306   ; line 477
	b       __rt_fmt_float.L306
__rt_fmt_float.L300:
	# %kind = 101   ; line 479
	li      $t0, 101
	sw      $t0, -60($fp)
	# %t89 = %p - 1   ; line 480
	lw      $t0, -48($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -376($fp)
	# %prec = %t89   ; line 480
	lw      $t0, -376($fp)
	sw      $t0, -44($fp)
	# %t90 = addr @fd_n   ; line 481
	la      $t0, __rtg_fd_n
	sw      $t0, -380($fp)
	# %t91 = load.w %t90   ; line 481
	lw      $t0, -380($fp)
	lw      $t1, 0($t0)
	sw      $t1, -384($fp)
	# %t92 = %t91 - 1   ; line 481
	lw      $t0, -384($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -388($fp)
	# %t = %t92   ; line 481
	lw      $t0, -388($fp)
	sw      $t0, -56($fp)
	# %t93 = addr @pf_alt   ; line 482
	la      $t0, __rtg_pf_alt
	sw      $t0, -392($fp)
	# %t94 = load.w %t93   ; line 482
	lw      $t0, -392($fp)
	lw      $t1, 0($t0)
	sw      $t1, -396($fp)
	# if %t94 goto .L308   ; line 482
	lw      $t0, -396($fp)
	bne     $t0, $zero, __rt_fmt_float.L308
	# %t95 = %t < %prec   ; line 482
	lw      $t0, -56($fp)
	lw      $t1, -44($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -400($fp)
	# ifFalse %t95 goto .L308   ; line 482
	lw      $t0, -400($fp)
	beq     $t0, $zero, __rt_fmt_float.L308
	# %t97 = %t < 0   ; line 482
	lw      $t0, -56($fp)
	slti    $t0, $t0, 0
	sw      $t0, -408($fp)
	# ifFalse %t97 goto .L310   ; line 482
	lw      $t0, -408($fp)
	beq     $t0, $zero, __rt_fmt_float.L310
	# %t96 = 0   ; line 482
	move    $t0, $zero
	sw      $t0, -404($fp)
	# goto .L311   ; line 482
	b       __rt_fmt_float.L311
__rt_fmt_float.L310:
	# %t96 = %t   ; line 482
	lw      $t0, -56($fp)
	sw      $t0, -404($fp)
__rt_fmt_float.L311:
	# %prec = %t96   ; line 482
	lw      $t0, -404($fp)
	sw      $t0, -44($fp)
__rt_fmt_float.L308:
__rt_fmt_float.L306:
__rt_fmt_float.L292:
__rt_fmt_float.L289:
	# %t99 = %prec > 0   ; line 485
	lw      $t0, -44($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -416($fp)
	# if %t99 goto .L312   ; line 485
	lw      $t0, -416($fp)
	bne     $t0, $zero, __rt_fmt_float.L312
	# %t100 = addr @pf_alt   ; line 485
	la      $t0, __rtg_pf_alt
	sw      $t0, -420($fp)
	# %t101 = load.w %t100   ; line 485
	lw      $t0, -420($fp)
	lw      $t1, 0($t0)
	sw      $t1, -424($fp)
	# ifFalse %t101 goto .L313   ; line 485
	lw      $t0, -424($fp)
	beq     $t0, $zero, __rt_fmt_float.L313
__rt_fmt_float.L312:
	# %t98 = 1   ; line 485
	li      $t0, 1
	sw      $t0, -412($fp)
	# goto .L314   ; line 485
	b       __rt_fmt_float.L314
__rt_fmt_float.L313:
	# %t98 = 0   ; line 485
	move    $t0, $zero
	sw      $t0, -412($fp)
__rt_fmt_float.L314:
	# %point = %t98   ; line 485
	lw      $t0, -412($fp)
	sw      $t0, -64($fp)
	# %t102 = %kind == 102   ; line 486
	lw      $t0, -60($fp)
	xori    $t0, $t0, 102
	sltiu   $t0, $t0, 1
	sw      $t0, -428($fp)
	# ifFalse %t102 goto .L316   ; line 486
	lw      $t0, -428($fp)
	beq     $t0, $zero, __rt_fmt_float.L316
	# %t104 = addr @fd_exp   ; line 487
	la      $t0, __rtg_fd_exp
	sw      $t0, -436($fp)
	# %t105 = load.w %t104   ; line 487
	lw      $t0, -436($fp)
	lw      $t1, 0($t0)
	sw      $t1, -440($fp)
	# %t106 = %t105 > 0   ; line 487
	lw      $t0, -440($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -444($fp)
	# ifFalse %t106 goto .L318   ; line 487
	lw      $t0, -444($fp)
	beq     $t0, $zero, __rt_fmt_float.L318
	# %t107 = addr @fd_exp   ; line 487
	la      $t0, __rtg_fd_exp
	sw      $t0, -448($fp)
	# %t108 = load.w %t107   ; line 487
	lw      $t0, -448($fp)
	lw      $t1, 0($t0)
	sw      $t1, -452($fp)
	# %t103 = %t108   ; line 487
	lw      $t0, -452($fp)
	sw      $t0, -432($fp)
	# goto .L319   ; line 487
	b       __rt_fmt_float.L319
__rt_fmt_float.L318:
	# %t103 = 1   ; line 487
	li      $t0, 1
	sw      $t0, -432($fp)
__rt_fmt_float.L319:
	# ifFalse %point goto .L321   ; line 487
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_fmt_float.L321
	# %t110 = 1 + %prec   ; line 487
	li      $t0, 1
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -460($fp)
	# %t109 = %t110   ; line 487
	lw      $t0, -460($fp)
	sw      $t0, -456($fp)
	# goto .L322   ; line 487
	b       __rt_fmt_float.L322
__rt_fmt_float.L321:
	# %t109 = 0   ; line 487
	move    $t0, $zero
	sw      $t0, -456($fp)
__rt_fmt_float.L322:
	# %t111 = %t103 + %t109   ; line 487
	lw      $t0, -432($fp)
	lw      $t1, -456($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -464($fp)
	# %len = %t111   ; line 487
	lw      $t0, -464($fp)
	sw      $t0, -68($fp)
	# goto .L323   ; line 487
	b       __rt_fmt_float.L323
__rt_fmt_float.L316:
	# %t113 = addr @fd_n   ; line 489
	la      $t0, __rtg_fd_n
	sw      $t0, -472($fp)
	# %t114 = load.w %t113   ; line 489
	lw      $t0, -472($fp)
	lw      $t1, 0($t0)
	sw      $t1, -476($fp)
	# ifFalse %t114 goto .L325   ; line 489
	lw      $t0, -476($fp)
	beq     $t0, $zero, __rt_fmt_float.L325
	# %t115 = addr @fd_exp   ; line 489
	la      $t0, __rtg_fd_exp
	sw      $t0, -480($fp)
	# %t116 = load.w %t115   ; line 489
	lw      $t0, -480($fp)
	lw      $t1, 0($t0)
	sw      $t1, -484($fp)
	# %t117 = %t116 - 1   ; line 489
	lw      $t0, -484($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -488($fp)
	# %t112 = %t117   ; line 489
	lw      $t0, -488($fp)
	sw      $t0, -468($fp)
	# goto .L326   ; line 489
	b       __rt_fmt_float.L326
__rt_fmt_float.L325:
	# %t112 = 0   ; line 489
	move    $t0, $zero
	sw      $t0, -468($fp)
__rt_fmt_float.L326:
	# %x = %t112   ; line 489
	lw      $t0, -468($fp)
	sw      $t0, -52($fp)
	# %t119 = %x < 0   ; line 490
	lw      $t0, -52($fp)
	slti    $t0, $t0, 0
	sw      $t0, -496($fp)
	# ifFalse %t119 goto .L328   ; line 490
	lw      $t0, -496($fp)
	beq     $t0, $zero, __rt_fmt_float.L328
	# %t120 = - %x   ; line 490
	lw      $t0, -52($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -500($fp)
	# %t118 = %t120   ; line 490
	lw      $t0, -500($fp)
	sw      $t0, -492($fp)
	# goto .L329   ; line 490
	b       __rt_fmt_float.L329
__rt_fmt_float.L328:
	# %t118 = %x   ; line 490
	lw      $t0, -52($fp)
	sw      $t0, -492($fp)
__rt_fmt_float.L329:
	# %ax = %t118   ; line 490
	lw      $t0, -492($fp)
	sw      $t0, -76($fp)
	# ifFalse %point goto .L331   ; line 491
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_fmt_float.L331
	# %t122 = 1 + %prec   ; line 491
	li      $t0, 1
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -508($fp)
	# %t121 = %t122   ; line 491
	lw      $t0, -508($fp)
	sw      $t0, -504($fp)
	# goto .L332   ; line 491
	b       __rt_fmt_float.L332
__rt_fmt_float.L331:
	# %t121 = 0   ; line 491
	move    $t0, $zero
	sw      $t0, -504($fp)
__rt_fmt_float.L332:
	# %t123 = 1 + %t121   ; line 491
	li      $t0, 1
	lw      $t1, -504($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -512($fp)
	# %t124 = %t123 + 2   ; line 491
	lw      $t0, -512($fp)
	addiu   $t0, $t0, 2
	sw      $t0, -516($fp)
	# %t126 = %ax >= 100   ; line 491
	lw      $t0, -76($fp)
	slti    $t0, $t0, 100
	xori    $t0, $t0, 1
	sw      $t0, -524($fp)
	# ifFalse %t126 goto .L334   ; line 491
	lw      $t0, -524($fp)
	beq     $t0, $zero, __rt_fmt_float.L334
	# %t125 = 3   ; line 491
	li      $t0, 3
	sw      $t0, -520($fp)
	# goto .L335   ; line 491
	b       __rt_fmt_float.L335
__rt_fmt_float.L334:
	# %t125 = 2   ; line 491
	li      $t0, 2
	sw      $t0, -520($fp)
__rt_fmt_float.L335:
	# %t127 = %t124 + %t125   ; line 491
	lw      $t0, -516($fp)
	lw      $t1, -520($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -528($fp)
	# %len = %t127   ; line 491
	lw      $t0, -528($fp)
	sw      $t0, -68($fp)
__rt_fmt_float.L323:
	# %t128 = %len + %np   ; line 493
	lw      $t0, -68($fp)
	lw      $t1, -40($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -532($fp)
	# %len = %t128   ; line 493
	lw      $t0, -532($fp)
	sw      $t0, -68($fp)
	# %zeros = 0   ; line 494
	move    $t0, $zero
	sw      $t0, -72($fp)
	# %t129 = addr @pf_zero   ; line 495
	la      $t0, __rtg_pf_zero
	sw      $t0, -536($fp)
	# %t130 = load.w %t129   ; line 495
	lw      $t0, -536($fp)
	lw      $t1, 0($t0)
	sw      $t1, -540($fp)
	# ifFalse %t130 goto .L337   ; line 495
	lw      $t0, -540($fp)
	beq     $t0, $zero, __rt_fmt_float.L337
	# %t131 = addr @pf_left   ; line 495
	la      $t0, __rtg_pf_left
	sw      $t0, -544($fp)
	# %t132 = load.w %t131   ; line 495
	lw      $t0, -544($fp)
	lw      $t1, 0($t0)
	sw      $t1, -548($fp)
	# if %t132 goto .L337   ; line 495
	lw      $t0, -548($fp)
	bne     $t0, $zero, __rt_fmt_float.L337
	# %t133 = addr @pf_width   ; line 495
	la      $t0, __rtg_pf_width
	sw      $t0, -552($fp)
	# %t134 = load.w %t133   ; line 495
	lw      $t0, -552($fp)
	lw      $t1, 0($t0)
	sw      $t1, -556($fp)
	# %t135 = %t134 > %len   ; line 495
	lw      $t0, -556($fp)
	lw      $t1, -68($fp)
	slt     $t0, $t1, $t0
	sw      $t0, -560($fp)
	# ifFalse %t135 goto .L337   ; line 495
	lw      $t0, -560($fp)
	beq     $t0, $zero, __rt_fmt_float.L337
	# %t136 = addr @pf_width   ; line 495
	la      $t0, __rtg_pf_width
	sw      $t0, -564($fp)
	# %t137 = load.w %t136   ; line 495
	lw      $t0, -564($fp)
	lw      $t1, 0($t0)
	sw      $t1, -568($fp)
	# %t138 = %t137 - %len   ; line 495
	lw      $t0, -568($fp)
	lw      $t1, -68($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -572($fp)
	# %zeros = %t138   ; line 495
	lw      $t0, -572($fp)
	sw      $t0, -72($fp)
__rt_fmt_float.L337:
	# %t139 = %len + %zeros   ; line 496
	lw      $t0, -68($fp)
	lw      $t1, -72($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -576($fp)
	# param %t139 : int   ; line 496
	lw      $t0, -576($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 496
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# %t140 = addr pre   ; line 497
	addiu   $t0, $fp, -16
	sw      $t0, -580($fp)
	# param %t140 : str   ; line 497
	lw      $t0, -580($fp)
	sw      $t0, 0($sp)
	# param %np : int   ; line 497
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# call @out_mem, 2   ; line 497
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_mem
	# %t141 = 48   ; line 498
	li      $t0, 48
	sw      $t0, -584($fp)
	# param %t141 : int   ; line 498
	lw      $t0, -584($fp)
	sw      $t0, 0($sp)
	# param %zeros : int   ; line 498
	lw      $t0, -72($fp)
	sw      $t0, 4($sp)
	# call @out_pad, 2   ; line 498
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_pad
	# %t142 = %kind == 102   ; line 499
	lw      $t0, -60($fp)
	xori    $t0, $t0, 102
	sltiu   $t0, $t0, 1
	sw      $t0, -588($fp)
	# ifFalse %t142 goto .L339   ; line 499
	lw      $t0, -588($fp)
	beq     $t0, $zero, __rt_fmt_float.L339
	# param %prec : int   ; line 499
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# param %point : int   ; line 499
	lw      $t0, -64($fp)
	sw      $t0, 4($sp)
	# call @emit_f, 2   ; line 499
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_emit_f
	# goto .L340   ; line 499
	b       __rt_fmt_float.L340
__rt_fmt_float.L339:
	# param %prec : int   ; line 500
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# param %point : int   ; line 500
	lw      $t0, -64($fp)
	sw      $t0, 4($sp)
	# param %upper : int   ; line 500
	lw      $t0, -32($fp)
	sw      $t0, 8($sp)
	# call @emit_e, 3   ; line 500
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_emit_e
__rt_fmt_float.L340:
	# %t143 = %len + %zeros   ; line 501
	lw      $t0, -68($fp)
	lw      $t1, -72($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -592($fp)
	# param %t143 : int   ; line 501
	lw      $t0, -592($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 501
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# return
__rt_fmt_float.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_out_spec
	.text
# ---------------------------------------------------------------
# function out_spec (line 506), returns void
# frame 160 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param from (int, arrives in $a1)
#   8($fp)	param to (int, arrives in $a2)
#   12($fp)	param wv (int, arrives in $a3)
#   16($fp)	param pv (int)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%fmt : str
#   -16($fp)	%from : int
#   -20($fp)	%to : int
#   -24($fp)	%wv : int
#   -28($fp)	%pv : int
#   -32($fp)	%i : int
#   -36($fp)	%dot : int
#   -40($fp)	%v : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : char
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : str
#   -68($fp)	%t14 : char
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : str
#   -92($fp)	%t20 : char
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : str
#   -104($fp)	%t23 : char
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : str
#   -136($fp)	%t31 : char
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_out_spec
__rt_out_spec:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -160
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param from : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param to : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param wv : int at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# param pv : int at 16($fp)
	lw      $t0, 16($fp)
	sw      $t0, -28($fp)
	# %dot = 0   ; line 508
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %i = %from   ; line 509
	lw      $t0, -16($fp)
	sw      $t0, -32($fp)
__rt_out_spec.L341:
	# %t8 = %i < %to   ; line 509
	lw      $t0, -32($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L344   ; line 509
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_out_spec.L344
	# %t9 = %fmt + %i   ; line 510
	lw      $t0, -12($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.b %t9   ; line 510
	lw      $t0, -48($fp)
	lb      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 == 46   ; line 510
	lw      $t0, -52($fp)
	xori    $t0, $t0, 46
	sltiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L346   ; line 510
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_out_spec.L346
	# %t12 = %i + 1   ; line 510
	lw      $t0, -32($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# %t13 = %fmt + %t12   ; line 510
	lw      $t0, -12($fp)
	lw      $t1, -60($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %t14 = load.b %t13   ; line 510
	lw      $t0, -64($fp)
	lb      $t1, 0($t0)
	sw      $t1, -68($fp)
	# %t15 = %t14 == 42   ; line 510
	lw      $t0, -68($fp)
	xori    $t0, $t0, 42
	sltiu   $t0, $t0, 1
	sw      $t0, -72($fp)
	# ifFalse %t15 goto .L346   ; line 510
	lw      $t0, -72($fp)
	beq     $t0, $zero, __rt_out_spec.L346
	# %t16 = %pv < 0   ; line 510
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	sw      $t0, -76($fp)
	# ifFalse %t16 goto .L346   ; line 510
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_out_spec.L346
	# %t17 = %i   ; line 511
	lw      $t0, -32($fp)
	sw      $t0, -80($fp)
	# %t18 = %t17 + 1   ; line 511
	lw      $t0, -80($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# %i = %t18   ; line 511
	lw      $t0, -84($fp)
	sw      $t0, -32($fp)
	# goto .L343   ; line 512
	b       __rt_out_spec.L343
__rt_out_spec.L346:
	# %t19 = %fmt + %i   ; line 514
	lw      $t0, -12($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t20 = load.b %t19   ; line 514
	lw      $t0, -88($fp)
	lb      $t1, 0($t0)
	sw      $t1, -92($fp)
	# %t21 = %t20 == 46   ; line 514
	lw      $t0, -92($fp)
	xori    $t0, $t0, 46
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t21 goto .L348   ; line 514
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_out_spec.L348
	# %dot = 1   ; line 514
	li      $t0, 1
	sw      $t0, -36($fp)
__rt_out_spec.L348:
	# %t22 = %fmt + %i   ; line 515
	lw      $t0, -12($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -100($fp)
	# %t23 = load.b %t22   ; line 515
	lw      $t0, -100($fp)
	lb      $t1, 0($t0)
	sw      $t1, -104($fp)
	# %t24 = %t23 == 42   ; line 515
	lw      $t0, -104($fp)
	xori    $t0, $t0, 42
	sltiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# ifFalse %t24 goto .L350   ; line 515
	lw      $t0, -108($fp)
	beq     $t0, $zero, __rt_out_spec.L350
	# ifFalse %dot goto .L352   ; line 516
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_out_spec.L352
	# %t25 = %pv   ; line 516
	lw      $t0, -28($fp)
	sw      $t0, -112($fp)
	# goto .L353   ; line 516
	b       __rt_out_spec.L353
__rt_out_spec.L352:
	# %t25 = %wv   ; line 516
	lw      $t0, -24($fp)
	sw      $t0, -112($fp)
__rt_out_spec.L353:
	# %v = %t25   ; line 516
	lw      $t0, -112($fp)
	sw      $t0, -40($fp)
	# %t26 = %v < 0   ; line 517
	lw      $t0, -40($fp)
	slti    $t0, $t0, 0
	sw      $t0, -116($fp)
	# ifFalse %t26 goto .L355   ; line 517
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_out_spec.L355
	# %t27 = 45   ; line 517
	li      $t0, 45
	sw      $t0, -120($fp)
	# param %t27 : int   ; line 517
	lw      $t0, -120($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 517
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t28 = - %v   ; line 517
	lw      $t0, -40($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -124($fp)
	# %v = %t28   ; line 517
	lw      $t0, -124($fp)
	sw      $t0, -40($fp)
__rt_out_spec.L355:
	# %t29 = 1   ; line 518
	li      $t0, 1
	sw      $t0, -128($fp)
	# param %v : int   ; line 518
	lw      $t0, -40($fp)
	sw      $t0, 0($sp)
	# param %t29 : int   ; line 518
	lw      $t0, -128($fp)
	sw      $t0, 4($sp)
	# call @out_num, 2   ; line 518
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_out_num
	# goto .L356   ; line 518
	b       __rt_out_spec.L356
__rt_out_spec.L350:
	# %t30 = %fmt + %i   ; line 519
	lw      $t0, -12($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -132($fp)
	# %t31 = load.b %t30   ; line 519
	lw      $t0, -132($fp)
	lb      $t1, 0($t0)
	sw      $t1, -136($fp)
	# param %t31 : int   ; line 519
	lw      $t0, -136($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 519
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_out_spec.L356:
__rt_out_spec.L343:
	# %t32 = %i   ; line 509
	lw      $t0, -32($fp)
	sw      $t0, -140($fp)
	# %t33 = %t32 + 1   ; line 509
	lw      $t0, -140($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -144($fp)
	# %i = %t33   ; line 509
	lw      $t0, -144($fp)
	sw      $t0, -32($fp)
	# goto .L341   ; line 509
	b       __rt_out_spec.L341
__rt_out_spec.L344:
	# return
__rt_out_spec.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_is_lenmod
	.text
# ---------------------------------------------------------------
# function is_lenmod (line 523), returns int
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_is_lenmod
__rt_is_lenmod:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = %c == 104   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 104
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# if %t2 goto .L357   ; line 524
	lw      $t0, -20($fp)
	bne     $t0, $zero, __rt_is_lenmod.L357
	# %t3 = %c == 108   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 108
	sltiu   $t0, $t0, 1
	sw      $t0, -24($fp)
	# if %t3 goto .L357   ; line 524
	lw      $t0, -24($fp)
	bne     $t0, $zero, __rt_is_lenmod.L357
	# %t4 = %c == 76   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 76
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# if %t4 goto .L357   ; line 524
	lw      $t0, -28($fp)
	bne     $t0, $zero, __rt_is_lenmod.L357
	# %t5 = %c == 122   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 122
	sltiu   $t0, $t0, 1
	sw      $t0, -32($fp)
	# if %t5 goto .L357   ; line 524
	lw      $t0, -32($fp)
	bne     $t0, $zero, __rt_is_lenmod.L357
	# %t6 = %c == 106   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 106
	sltiu   $t0, $t0, 1
	sw      $t0, -36($fp)
	# if %t6 goto .L357   ; line 524
	lw      $t0, -36($fp)
	bne     $t0, $zero, __rt_is_lenmod.L357
	# %t7 = %c == 116   ; line 524
	lw      $t0, -12($fp)
	xori    $t0, $t0, 116
	sltiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L358   ; line 524
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_is_lenmod.L358
__rt_is_lenmod.L357:
	# %t1 = 1   ; line 524
	li      $t0, 1
	sw      $t0, -16($fp)
	# goto .L359   ; line 524
	b       __rt_is_lenmod.L359
__rt_is_lenmod.L358:
	# %t1 = 0   ; line 524
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_is_lenmod.L359:
	# return %t1   ; line 524
	lw      $v0, -16($fp)
__rt_is_lenmod.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_narrow
	.text
# ---------------------------------------------------------------
# function narrow (line 531), returns int
# frame 144 bytes ($fp = $sp at entry):
#   0($fp)	param v (int, arrives in $a0)
#   4($fp)	param fmt (str, arrives in $a1)
#   8($fp)	param from (int, arrives in $a2)
#   12($fp)	param to (int, arrives in $a3)
#   16($fp)	param conv (int)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%v : int
#   -16($fp)	%fmt : str
#   -20($fp)	%from : int
#   -24($fp)	%to : int
#   -28($fp)	%conv : int
#   -32($fp)	%sgn : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : str
#   -60($fp)	%t12 : char
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : str
#   -92($fp)	%t20 : char
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : str
#   -108($fp)	%t24 : char
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_narrow
__rt_narrow:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -144
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param v : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param fmt : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param from : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param to : int at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# param conv : int at 16($fp)
	lw      $t0, 16($fp)
	sw      $t0, -28($fp)
	# %t7 = %conv == 100   ; line 533
	lw      $t0, -28($fp)
	xori    $t0, $t0, 100
	sltiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# if %t7 goto .L360   ; line 533
	lw      $t0, -40($fp)
	bne     $t0, $zero, __rt_narrow.L360
	# %t8 = %conv == 105   ; line 533
	lw      $t0, -28($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L361   ; line 533
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_narrow.L361
__rt_narrow.L360:
	# %t6 = 1   ; line 533
	li      $t0, 1
	sw      $t0, -36($fp)
	# goto .L362   ; line 533
	b       __rt_narrow.L362
__rt_narrow.L361:
	# %t6 = 0   ; line 533
	move    $t0, $zero
	sw      $t0, -36($fp)
__rt_narrow.L362:
	# %sgn = %t6   ; line 533
	lw      $t0, -36($fp)
	sw      $t0, -32($fp)
	# %t9 = %to - %from   ; line 534
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = %t9 == 1   ; line 534
	lw      $t0, -48($fp)
	xori    $t0, $t0, 1
	sltiu   $t0, $t0, 1
	sw      $t0, -52($fp)
	# ifFalse %t10 goto .L364   ; line 534
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_narrow.L364
	# %t11 = %fmt + %from   ; line 534
	lw      $t0, -16($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = load.b %t11   ; line 534
	lw      $t0, -56($fp)
	lb      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %t12 == 104   ; line 534
	lw      $t0, -60($fp)
	xori    $t0, $t0, 104
	sltiu   $t0, $t0, 1
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L364   ; line 534
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_narrow.L364
	# ifFalse %sgn goto .L366   ; line 535
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_narrow.L366
	# %t14 = %v << 16   ; line 535
	lw      $t0, -12($fp)
	sll     $t0, $t0, 16
	sw      $t0, -68($fp)
	# %t15 = %t14 >> 16   ; line 535
	lw      $t0, -68($fp)
	sra     $t0, $t0, 16
	sw      $t0, -72($fp)
	# return %t15   ; line 535
	lw      $v0, -72($fp)
	b       __rt_narrow.ret
__rt_narrow.L366:
	# %t16 = %v & 65535   ; line 536
	lw      $t0, -12($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -76($fp)
	# return %t16   ; line 536
	lw      $v0, -76($fp)
	b       __rt_narrow.ret
__rt_narrow.L364:
	# %t17 = %to - %from   ; line 538
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -80($fp)
	# %t18 = %t17 == 2   ; line 538
	lw      $t0, -80($fp)
	xori    $t0, $t0, 2
	sltiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# ifFalse %t18 goto .L368   ; line 538
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_narrow.L368
	# %t19 = %fmt + %from   ; line 538
	lw      $t0, -16($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t20 = load.b %t19   ; line 538
	lw      $t0, -88($fp)
	lb      $t1, 0($t0)
	sw      $t1, -92($fp)
	# %t21 = %t20 == 104   ; line 538
	lw      $t0, -92($fp)
	xori    $t0, $t0, 104
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t21 goto .L368   ; line 538
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_narrow.L368
	# %t22 = %from + 1   ; line 538
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# %t23 = %fmt + %t22   ; line 538
	lw      $t0, -16($fp)
	lw      $t1, -100($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -104($fp)
	# %t24 = load.b %t23   ; line 538
	lw      $t0, -104($fp)
	lb      $t1, 0($t0)
	sw      $t1, -108($fp)
	# %t25 = %t24 == 104   ; line 538
	lw      $t0, -108($fp)
	xori    $t0, $t0, 104
	sltiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# ifFalse %t25 goto .L368   ; line 538
	lw      $t0, -112($fp)
	beq     $t0, $zero, __rt_narrow.L368
	# ifFalse %sgn goto .L370   ; line 539
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_narrow.L370
	# %t26 = %v << 24   ; line 539
	lw      $t0, -12($fp)
	sll     $t0, $t0, 24
	sw      $t0, -116($fp)
	# %t27 = %t26 >> 24   ; line 539
	lw      $t0, -116($fp)
	sra     $t0, $t0, 24
	sw      $t0, -120($fp)
	# return %t27   ; line 539
	lw      $v0, -120($fp)
	b       __rt_narrow.ret
__rt_narrow.L370:
	# %t28 = %v & 255   ; line 540
	lw      $t0, -12($fp)
	andi    $t0, $t0, 255
	sw      $t0, -124($fp)
	# return %t28   ; line 540
	lw      $v0, -124($fp)
	b       __rt_narrow.ret
__rt_narrow.L368:
	# return %v   ; line 542
	lw      $v0, -12($fp)
__rt_narrow.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_parse_spec
	.text
# ---------------------------------------------------------------
# function parse_spec (line 549), returns int
# frame 408 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param i (int, arrives in $a1)
#   8($fp)	param app (ptr, arrives in $a2)
#   12($fp)	param wv (ptr, arrives in $a3)
#   16($fp)	param pv (ptr)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%fmt : str
#   -16($fp)	%i : int
#   -20($fp)	%app : ptr
#   -24($fp)	%wv : ptr
#   -28($fp)	%pv : ptr
#   -32($fp)	%c : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : str
#   -68($fp)	%t14 : char
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : ptr
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : ptr
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : str
#   -124($fp)	%t28 : char
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : ptr
#   -136($fp)	%t31 : ptr
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : ptr
#   -148($fp)	%t34 : ptr
#   -152($fp)	%t35 : ptr
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : ptr
#   -164($fp)	%t38 : int
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : ptr
#   -176($fp)	%t41 : ptr
#   -180($fp)	%t42 : ptr
#   -184($fp)	%t43 : int
#   -188($fp)	%t44 : int
#   -192($fp)	%t45 : int
#   -196($fp)	%t46 : int
#   -200($fp)	%t47 : str
#   -204($fp)	%t48 : char
#   -208($fp)	%t49 : int
#   -212($fp)	%t50 : ptr
#   -216($fp)	%t51 : ptr
#   -220($fp)	%t52 : int
#   -224($fp)	%t53 : int
#   -228($fp)	%t54 : str
#   -232($fp)	%t55 : char
#   -236($fp)	%t56 : int
#   -240($fp)	%t57 : int
#   -244($fp)	%t58 : int
#   -248($fp)	%t59 : int
#   -252($fp)	%t60 : str
#   -256($fp)	%t61 : char
#   -260($fp)	%t62 : int
#   -264($fp)	%t63 : int
#   -268($fp)	%t64 : int
#   -272($fp)	%t65 : ptr
#   -276($fp)	%t66 : str
#   -280($fp)	%t67 : char
#   -284($fp)	%t68 : int
#   -288($fp)	%t69 : ptr
#   -292($fp)	%t70 : ptr
#   -296($fp)	%t71 : int
#   -300($fp)	%t72 : ptr
#   -304($fp)	%t73 : ptr
#   -308($fp)	%t74 : ptr
#   -312($fp)	%t75 : int
#   -316($fp)	%t76 : ptr
#   -320($fp)	%t77 : int
#   -324($fp)	%t78 : int
#   -328($fp)	%t79 : ptr
#   -332($fp)	%t80 : int
#   -336($fp)	%t81 : int
#   -340($fp)	%t82 : str
#   -344($fp)	%t83 : char
#   -348($fp)	%t84 : int
#   -352($fp)	%t85 : ptr
#   -356($fp)	%t86 : ptr
#   -360($fp)	%t87 : int
#   -364($fp)	%t88 : int
#   -368($fp)	%t89 : str
#   -372($fp)	%t90 : char
#   -376($fp)	%t91 : int
#   -380($fp)	%t92 : int
#   -384($fp)	%t93 : int
#   -388($fp)	%t94 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_parse_spec
__rt_parse_spec:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -408
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param i : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param app : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param wv : ptr at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# param pv : ptr at 16($fp)
	lw      $t0, 16($fp)
	sw      $t0, -28($fp)
	# %t6 = addr @pf_left   ; line 551
	la      $t0, __rtg_pf_left
	sw      $t0, -36($fp)
	# store.w %t6, 0   ; line 551
	lw      $t0, -36($fp)
	sw      $zero, 0($t0)
	# %t7 = addr @pf_plus   ; line 551
	la      $t0, __rtg_pf_plus
	sw      $t0, -40($fp)
	# store.w %t7, 0   ; line 551
	lw      $t0, -40($fp)
	sw      $zero, 0($t0)
	# %t8 = addr @pf_space   ; line 551
	la      $t0, __rtg_pf_space
	sw      $t0, -44($fp)
	# store.w %t8, 0   ; line 551
	lw      $t0, -44($fp)
	sw      $zero, 0($t0)
	# %t9 = addr @pf_alt   ; line 551
	la      $t0, __rtg_pf_alt
	sw      $t0, -48($fp)
	# store.w %t9, 0   ; line 551
	lw      $t0, -48($fp)
	sw      $zero, 0($t0)
	# %t10 = addr @pf_zero   ; line 551
	la      $t0, __rtg_pf_zero
	sw      $t0, -52($fp)
	# store.w %t10, 0   ; line 551
	lw      $t0, -52($fp)
	sw      $zero, 0($t0)
	# %t11 = addr @pf_width   ; line 552
	la      $t0, __rtg_pf_width
	sw      $t0, -56($fp)
	# store.w %t11, 0   ; line 552
	lw      $t0, -56($fp)
	sw      $zero, 0($t0)
	# %t12 = addr @pf_prec   ; line 553
	la      $t0, __rtg_pf_prec
	sw      $t0, -60($fp)
	# store.w %t12, -1   ; line 553
	lw      $t0, -60($fp)
	li      $t1, -1
	sw      $t1, 0($t0)
__rt_parse_spec.L371:
	# %t13 = %fmt + %i   ; line 555
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %t14 = load.b %t13   ; line 555
	lw      $t0, -64($fp)
	lb      $t1, 0($t0)
	sw      $t1, -68($fp)
	# %c = %t14   ; line 555
	lw      $t0, -68($fp)
	sw      $t0, -32($fp)
	# %t15 = %c == 45   ; line 556
	lw      $t0, -32($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -72($fp)
	# ifFalse %t15 goto .L375   ; line 556
	lw      $t0, -72($fp)
	beq     $t0, $zero, __rt_parse_spec.L375
	# %t16 = addr @pf_left   ; line 556
	la      $t0, __rtg_pf_left
	sw      $t0, -76($fp)
	# store.w %t16, 1   ; line 556
	lw      $t0, -76($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# goto .L376   ; line 556
	b       __rt_parse_spec.L376
__rt_parse_spec.L375:
	# %t17 = %c == 43   ; line 557
	lw      $t0, -32($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L378   ; line 557
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_parse_spec.L378
	# %t18 = addr @pf_plus   ; line 557
	la      $t0, __rtg_pf_plus
	sw      $t0, -84($fp)
	# store.w %t18, 1   ; line 557
	lw      $t0, -84($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# goto .L379   ; line 557
	b       __rt_parse_spec.L379
__rt_parse_spec.L378:
	# %t19 = %c == 32   ; line 558
	lw      $t0, -32($fp)
	xori    $t0, $t0, 32
	sltiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L381   ; line 558
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_parse_spec.L381
	# %t20 = addr @pf_space   ; line 558
	la      $t0, __rtg_pf_space
	sw      $t0, -92($fp)
	# store.w %t20, 1   ; line 558
	lw      $t0, -92($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# goto .L382   ; line 558
	b       __rt_parse_spec.L382
__rt_parse_spec.L381:
	# %t21 = %c == 35   ; line 559
	lw      $t0, -32($fp)
	xori    $t0, $t0, 35
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t21 goto .L384   ; line 559
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_parse_spec.L384
	# %t22 = addr @pf_alt   ; line 559
	la      $t0, __rtg_pf_alt
	sw      $t0, -100($fp)
	# store.w %t22, 1   ; line 559
	lw      $t0, -100($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# goto .L385   ; line 559
	b       __rt_parse_spec.L385
__rt_parse_spec.L384:
	# %t23 = %c == 48   ; line 560
	lw      $t0, -32($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -104($fp)
	# ifFalse %t23 goto .L387   ; line 560
	lw      $t0, -104($fp)
	beq     $t0, $zero, __rt_parse_spec.L387
	# %t24 = addr @pf_zero   ; line 560
	la      $t0, __rtg_pf_zero
	sw      $t0, -108($fp)
	# store.w %t24, 1   ; line 560
	lw      $t0, -108($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# goto .L388   ; line 560
	b       __rt_parse_spec.L388
__rt_parse_spec.L387:
	# goto .L373   ; line 561
	b       __rt_parse_spec.L373
__rt_parse_spec.L388:
__rt_parse_spec.L385:
__rt_parse_spec.L382:
__rt_parse_spec.L379:
__rt_parse_spec.L376:
	# %t25 = %i   ; line 562
	lw      $t0, -16($fp)
	sw      $t0, -112($fp)
	# %t26 = %t25 + 1   ; line 562
	lw      $t0, -112($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -116($fp)
	# %i = %t26   ; line 562
	lw      $t0, -116($fp)
	sw      $t0, -16($fp)
	# goto .L371   ; line 562
	b       __rt_parse_spec.L371
__rt_parse_spec.L373:
	# %t27 = %fmt + %i   ; line 564
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -120($fp)
	# %t28 = load.b %t27   ; line 564
	lw      $t0, -120($fp)
	lb      $t1, 0($t0)
	sw      $t1, -124($fp)
	# %t29 = %t28 == 42   ; line 564
	lw      $t0, -124($fp)
	xori    $t0, $t0, 42
	sltiu   $t0, $t0, 1
	sw      $t0, -128($fp)
	# ifFalse %t29 goto .L390   ; line 564
	lw      $t0, -128($fp)
	beq     $t0, $zero, __rt_parse_spec.L390
	# %t30 = addr @pf_width   ; line 565
	la      $t0, __rtg_pf_width
	sw      $t0, -132($fp)
	# %t31 = load.w %app   ; line 565
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -136($fp)
	# %t32 = load.w %t31   ; line 565
	lw      $t0, -136($fp)
	lw      $t1, 0($t0)
	sw      $t1, -140($fp)
	# store.w %t30, %t32   ; line 565
	lw      $t0, -132($fp)
	lw      $t1, -140($fp)
	sw      $t1, 0($t0)
	# %t33 = load.w %app   ; line 566
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -144($fp)
	# %t34 = %t33 + 4   ; line 566
	lw      $t0, -144($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -148($fp)
	# store.w %app, %t34   ; line 566
	lw      $t0, -20($fp)
	lw      $t1, -148($fp)
	sw      $t1, 0($t0)
	# %t35 = addr @pf_width   ; line 567
	la      $t0, __rtg_pf_width
	sw      $t0, -152($fp)
	# %t36 = load.w %t35   ; line 567
	lw      $t0, -152($fp)
	lw      $t1, 0($t0)
	sw      $t1, -156($fp)
	# store.w %wv, %t36   ; line 567
	lw      $t0, -24($fp)
	lw      $t1, -156($fp)
	sw      $t1, 0($t0)
	# %t37 = addr @pf_width   ; line 568
	la      $t0, __rtg_pf_width
	sw      $t0, -160($fp)
	# %t38 = load.w %t37   ; line 568
	lw      $t0, -160($fp)
	lw      $t1, 0($t0)
	sw      $t1, -164($fp)
	# %t39 = %t38 < 0   ; line 568
	lw      $t0, -164($fp)
	slti    $t0, $t0, 0
	sw      $t0, -168($fp)
	# ifFalse %t39 goto .L392   ; line 568
	lw      $t0, -168($fp)
	beq     $t0, $zero, __rt_parse_spec.L392
	# %t40 = addr @pf_left   ; line 568
	la      $t0, __rtg_pf_left
	sw      $t0, -172($fp)
	# store.w %t40, 1   ; line 568
	lw      $t0, -172($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t41 = addr @pf_width   ; line 568
	la      $t0, __rtg_pf_width
	sw      $t0, -176($fp)
	# %t42 = addr @pf_width   ; line 568
	la      $t0, __rtg_pf_width
	sw      $t0, -180($fp)
	# %t43 = load.w %t42   ; line 568
	lw      $t0, -180($fp)
	lw      $t1, 0($t0)
	sw      $t1, -184($fp)
	# %t44 = - %t43   ; line 568
	lw      $t0, -184($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -188($fp)
	# store.w %t41, %t44   ; line 568
	lw      $t0, -176($fp)
	lw      $t1, -188($fp)
	sw      $t1, 0($t0)
__rt_parse_spec.L392:
	# %t45 = %i   ; line 569
	lw      $t0, -16($fp)
	sw      $t0, -192($fp)
	# %t46 = %t45 + 1   ; line 569
	lw      $t0, -192($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -196($fp)
	# %i = %t46   ; line 569
	lw      $t0, -196($fp)
	sw      $t0, -16($fp)
	# goto .L393   ; line 569
	b       __rt_parse_spec.L393
__rt_parse_spec.L390:
__rt_parse_spec.L394:
	# %t47 = %fmt + %i   ; line 570
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -200($fp)
	# %t48 = load.b %t47   ; line 570
	lw      $t0, -200($fp)
	lb      $t1, 0($t0)
	sw      $t1, -204($fp)
	# param %t48 : int   ; line 570
	lw      $t0, -204($fp)
	sw      $t0, 0($sp)
	# %t49 = call @is_digit, 1   ; line 570
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -208($fp)
	# ifFalse %t49 goto .L396   ; line 570
	lw      $t0, -208($fp)
	beq     $t0, $zero, __rt_parse_spec.L396
	# %t50 = addr @pf_width   ; line 570
	la      $t0, __rtg_pf_width
	sw      $t0, -212($fp)
	# %t51 = addr @pf_width   ; line 570
	la      $t0, __rtg_pf_width
	sw      $t0, -216($fp)
	# %t52 = load.w %t51   ; line 570
	lw      $t0, -216($fp)
	lw      $t1, 0($t0)
	sw      $t1, -220($fp)
	# %t53 = %t52 * 10   ; line 570
	lw      $t0, -220($fp)
	li      $t1, 10
	mul     $t0, $t0, $t1
	sw      $t0, -224($fp)
	# %t54 = %fmt + %i   ; line 570
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -228($fp)
	# %t55 = load.b %t54   ; line 570
	lw      $t0, -228($fp)
	lb      $t1, 0($t0)
	sw      $t1, -232($fp)
	# %t56 = %t53 + %t55   ; line 570
	lw      $t0, -224($fp)
	lw      $t1, -232($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -236($fp)
	# %t57 = %t56 - 48   ; line 570
	lw      $t0, -236($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -240($fp)
	# store.w %t50, %t57   ; line 570
	lw      $t0, -212($fp)
	lw      $t1, -240($fp)
	sw      $t1, 0($t0)
	# %t58 = %i   ; line 570
	lw      $t0, -16($fp)
	sw      $t0, -244($fp)
	# %t59 = %t58 + 1   ; line 570
	lw      $t0, -244($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -248($fp)
	# %i = %t59   ; line 570
	lw      $t0, -248($fp)
	sw      $t0, -16($fp)
	# goto .L394   ; line 570
	b       __rt_parse_spec.L394
__rt_parse_spec.L396:
__rt_parse_spec.L393:
	# %t60 = %fmt + %i   ; line 571
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -252($fp)
	# %t61 = load.b %t60   ; line 571
	lw      $t0, -252($fp)
	lb      $t1, 0($t0)
	sw      $t1, -256($fp)
	# %t62 = %t61 == 46   ; line 571
	lw      $t0, -256($fp)
	xori    $t0, $t0, 46
	sltiu   $t0, $t0, 1
	sw      $t0, -260($fp)
	# ifFalse %t62 goto .L398   ; line 571
	lw      $t0, -260($fp)
	beq     $t0, $zero, __rt_parse_spec.L398
	# %t63 = %i   ; line 572
	lw      $t0, -16($fp)
	sw      $t0, -264($fp)
	# %t64 = %t63 + 1   ; line 572
	lw      $t0, -264($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -268($fp)
	# %i = %t64   ; line 572
	lw      $t0, -268($fp)
	sw      $t0, -16($fp)
	# %t65 = addr @pf_prec   ; line 573
	la      $t0, __rtg_pf_prec
	sw      $t0, -272($fp)
	# store.w %t65, 0   ; line 573
	lw      $t0, -272($fp)
	sw      $zero, 0($t0)
	# %t66 = %fmt + %i   ; line 574
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -276($fp)
	# %t67 = load.b %t66   ; line 574
	lw      $t0, -276($fp)
	lb      $t1, 0($t0)
	sw      $t1, -280($fp)
	# %t68 = %t67 == 42   ; line 574
	lw      $t0, -280($fp)
	xori    $t0, $t0, 42
	sltiu   $t0, $t0, 1
	sw      $t0, -284($fp)
	# ifFalse %t68 goto .L400   ; line 574
	lw      $t0, -284($fp)
	beq     $t0, $zero, __rt_parse_spec.L400
	# %t69 = addr @pf_prec   ; line 575
	la      $t0, __rtg_pf_prec
	sw      $t0, -288($fp)
	# %t70 = load.w %app   ; line 575
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -292($fp)
	# %t71 = load.w %t70   ; line 575
	lw      $t0, -292($fp)
	lw      $t1, 0($t0)
	sw      $t1, -296($fp)
	# store.w %t69, %t71   ; line 575
	lw      $t0, -288($fp)
	lw      $t1, -296($fp)
	sw      $t1, 0($t0)
	# %t72 = load.w %app   ; line 576
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -300($fp)
	# %t73 = %t72 + 4   ; line 576
	lw      $t0, -300($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -304($fp)
	# store.w %app, %t73   ; line 576
	lw      $t0, -20($fp)
	lw      $t1, -304($fp)
	sw      $t1, 0($t0)
	# %t74 = addr @pf_prec   ; line 577
	la      $t0, __rtg_pf_prec
	sw      $t0, -308($fp)
	# %t75 = load.w %t74   ; line 577
	lw      $t0, -308($fp)
	lw      $t1, 0($t0)
	sw      $t1, -312($fp)
	# store.w %pv, %t75   ; line 577
	lw      $t0, -28($fp)
	lw      $t1, -312($fp)
	sw      $t1, 0($t0)
	# %t76 = addr @pf_prec   ; line 578
	la      $t0, __rtg_pf_prec
	sw      $t0, -316($fp)
	# %t77 = load.w %t76   ; line 578
	lw      $t0, -316($fp)
	lw      $t1, 0($t0)
	sw      $t1, -320($fp)
	# %t78 = %t77 < 0   ; line 578
	lw      $t0, -320($fp)
	slti    $t0, $t0, 0
	sw      $t0, -324($fp)
	# ifFalse %t78 goto .L402   ; line 578
	lw      $t0, -324($fp)
	beq     $t0, $zero, __rt_parse_spec.L402
	# %t79 = addr @pf_prec   ; line 578
	la      $t0, __rtg_pf_prec
	sw      $t0, -328($fp)
	# store.w %t79, -1   ; line 578
	lw      $t0, -328($fp)
	li      $t1, -1
	sw      $t1, 0($t0)
__rt_parse_spec.L402:
	# %t80 = %i   ; line 579
	lw      $t0, -16($fp)
	sw      $t0, -332($fp)
	# %t81 = %t80 + 1   ; line 579
	lw      $t0, -332($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -336($fp)
	# %i = %t81   ; line 579
	lw      $t0, -336($fp)
	sw      $t0, -16($fp)
	# goto .L403   ; line 579
	b       __rt_parse_spec.L403
__rt_parse_spec.L400:
__rt_parse_spec.L404:
	# %t82 = %fmt + %i   ; line 580
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -340($fp)
	# %t83 = load.b %t82   ; line 580
	lw      $t0, -340($fp)
	lb      $t1, 0($t0)
	sw      $t1, -344($fp)
	# param %t83 : int   ; line 580
	lw      $t0, -344($fp)
	sw      $t0, 0($sp)
	# %t84 = call @is_digit, 1   ; line 580
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -348($fp)
	# ifFalse %t84 goto .L406   ; line 580
	lw      $t0, -348($fp)
	beq     $t0, $zero, __rt_parse_spec.L406
	# %t85 = addr @pf_prec   ; line 580
	la      $t0, __rtg_pf_prec
	sw      $t0, -352($fp)
	# %t86 = addr @pf_prec   ; line 580
	la      $t0, __rtg_pf_prec
	sw      $t0, -356($fp)
	# %t87 = load.w %t86   ; line 580
	lw      $t0, -356($fp)
	lw      $t1, 0($t0)
	sw      $t1, -360($fp)
	# %t88 = %t87 * 10   ; line 580
	lw      $t0, -360($fp)
	li      $t1, 10
	mul     $t0, $t0, $t1
	sw      $t0, -364($fp)
	# %t89 = %fmt + %i   ; line 580
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -368($fp)
	# %t90 = load.b %t89   ; line 580
	lw      $t0, -368($fp)
	lb      $t1, 0($t0)
	sw      $t1, -372($fp)
	# %t91 = %t88 + %t90   ; line 580
	lw      $t0, -364($fp)
	lw      $t1, -372($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -376($fp)
	# %t92 = %t91 - 48   ; line 580
	lw      $t0, -376($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -380($fp)
	# store.w %t85, %t92   ; line 580
	lw      $t0, -352($fp)
	lw      $t1, -380($fp)
	sw      $t1, 0($t0)
	# %t93 = %i   ; line 580
	lw      $t0, -16($fp)
	sw      $t0, -384($fp)
	# %t94 = %t93 + 1   ; line 580
	lw      $t0, -384($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -388($fp)
	# %i = %t94   ; line 580
	lw      $t0, -388($fp)
	sw      $t0, -16($fp)
	# goto .L404   ; line 580
	b       __rt_parse_spec.L404
__rt_parse_spec.L406:
__rt_parse_spec.L403:
__rt_parse_spec.L398:
	# return %i   ; line 582
	lw      $v0, -16($fp)
__rt_parse_spec.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vformat
	.text
# ---------------------------------------------------------------
# function vformat (line 592), returns int
# frame 544 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param ap (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -24($fp)	local ap : int * (4 bytes)
#   -20($fp)	local wv : int (4 bytes)
#   -16($fp)	local pv : int (4 bytes)
#   -28($fp)	%fmt : str
#   -32($fp)	%i : int
#   -36($fp)	%start : int
#   -40($fp)	%mods : int
#   -44($fp)	%conv : int
#   -48($fp)	%t5 : str
#   -52($fp)	%t6 : char
#   -56($fp)	%t7 : str
#   -60($fp)	%t8 : char
#   -64($fp)	%t9 : int
#   -68($fp)	%t10 : str
#   -72($fp)	%t11 : char
#   -76($fp)	%t12 : int
#   -80($fp)	%t13 : int
#   -84($fp)	%t14 : int
#   -88($fp)	%t15 : str
#   -92($fp)	%t16 : char
#   -96($fp)	%t17 : int
#   -100($fp)	%t18 : int
#   -104($fp)	%t19 : int
#   -108($fp)	%t20 : ptr
#   -112($fp)	%t21 : ptr
#   -116($fp)	%t22 : int
#   -120($fp)	%t23 : ptr
#   -124($fp)	%t24 : ptr
#   -128($fp)	%t25 : ptr
#   -132($fp)	%t26 : int
#   -136($fp)	%t27 : str
#   -140($fp)	%t28 : char
#   -144($fp)	%t29 : int
#   -148($fp)	%t30 : int
#   -152($fp)	%t31 : int
#   -156($fp)	%t32 : str
#   -160($fp)	%t33 : char
#   -164($fp)	%t34 : int
#   -168($fp)	%t35 : ptr
#   -172($fp)	%t36 : int
#   -176($fp)	%t37 : ptr
#   -180($fp)	%t38 : int
#   -184($fp)	%t39 : str
#   -188($fp)	%t40 : char
#   -192($fp)	%t41 : int
#   -196($fp)	%t42 : int
#   -200($fp)	%t43 : int
#   -204($fp)	%t44 : int
#   -208($fp)	%t45 : int
#   -212($fp)	%t46 : int
#   -216($fp)	%t47 : int
#   -220($fp)	%t48 : int
#   -224($fp)	%t49 : int
#   -228($fp)	%t50 : int
#   -232($fp)	%t51 : int
#   -236($fp)	%t52 : int
#   -240($fp)	%t53 : int
#   -244($fp)	%t54 : int
#   -248($fp)	%t55 : int
#   -252($fp)	%t56 : int
#   -256($fp)	%t57 : int
#   -260($fp)	%t58 : int
#   -264($fp)	%t59 : int
#   -268($fp)	%t60 : int
#   -272($fp)	%t61 : ptr
#   -276($fp)	%t62 : ptr
#   -280($fp)	%t63 : int
#   -284($fp)	%t64 : int
#   -288($fp)	%t65 : int
#   -292($fp)	%t66 : ptr
#   -296($fp)	%t67 : ptr
#   -300($fp)	%t68 : ptr
#   -304($fp)	%t69 : ptr
#   -308($fp)	%t70 : int
#   -312($fp)	%t71 : ptr
#   -316($fp)	%t72 : ptr
#   -320($fp)	%t73 : int
#   -324($fp)	%t74 : int
#   -328($fp)	%t75 : int
#   -332($fp)	%t76 : ptr
#   -336($fp)	%t77 : ptr
#   -340($fp)	%t78 : ptr
#   -344($fp)	%t79 : ptr
#   -348($fp)	%t80 : ptr
#   -352($fp)	%t81 : ptr
#   -356($fp)	%t82 : int
#   -360($fp)	%t83 : ptr
#   -364($fp)	%t84 : ptr
#   -368($fp)	%t85 : ptr
#   -372($fp)	%t86 : ptr
#   -376($fp)	%t87 : int
#   -380($fp)	%t88 : int
#   -384($fp)	%t89 : ptr
#   -388($fp)	%t90 : ptr
#   -392($fp)	%t91 : ptr
#   -396($fp)	%t92 : ptr
#   -400($fp)	%t93 : ptr
#   -404($fp)	%t94 : int
#   -408($fp)	%t95 : int
#   -412($fp)	%t96 : ptr
#   -416($fp)	%t97 : ptr
#   -420($fp)	%t98 : ptr
#   -424($fp)	%t99 : ptr
#   -428($fp)	%t100 : ptr
#   -432($fp)	%t101 : ptr
#   -436($fp)	%t102 : ptr
#   -440($fp)	%t103 : int
#   -444($fp)	%t104 : int
#   -448($fp)	%t105 : ptr
#   -452($fp)	%t106 : ptr
#   -456($fp)	%t107 : ptr
#   -460($fp)	%t108 : int
#   -464($fp)	%t109 : ptr
#   -468($fp)	%t110 : ptr
#   -472($fp)	%t111 : ptr
#   -476($fp)	%t112 : int
#   -480($fp)	%t113 : ptr
#   -484($fp)	%t114 : ptr
#   -488($fp)	%t115 : ptr
#   -492($fp)	%t116 : ptr
#   -496($fp)	%t117 : int
#   -500($fp)	%t118 : ptr
#   -504($fp)	%t119 : int
#   -508($fp)	%t120 : ptr
#   -512($fp)	%t121 : int
#   -516($fp)	%t122 : ptr
#   -520($fp)	%t123 : int
#   0($sp)	outgoing arguments (24 bytes)
# ---------------------------------------------------------------
	.globl __rt_vformat
__rt_vformat:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -544
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -28($fp)
	# param ap : ptr at 4($fp) -> slot ap
	lw      $t0, 4($fp)
	sw      $t0, -24($fp)
	# %i = 0   ; line 594
	move    $t0, $zero
	sw      $t0, -32($fp)
__rt_vformat.L407:
	# %t5 = %fmt + %i   ; line 595
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t6 = load.b %t5   ; line 595
	lw      $t0, -48($fp)
	lb      $t1, 0($t0)
	sw      $t1, -52($fp)
	# ifFalse %t6 goto .L409   ; line 595
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_vformat.L409
	# %t7 = %fmt + %i   ; line 596
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t8 = load.b %t7   ; line 596
	lw      $t0, -56($fp)
	lb      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t9 = %t8 != 37   ; line 596
	lw      $t0, -60($fp)
	xori    $t0, $t0, 37
	sltu    $t0, $zero, $t0
	sw      $t0, -64($fp)
	# ifFalse %t9 goto .L411   ; line 596
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_vformat.L411
	# %t10 = %fmt + %i   ; line 596
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t11 = load.b %t10   ; line 596
	lw      $t0, -68($fp)
	lb      $t1, 0($t0)
	sw      $t1, -72($fp)
	# param %t11 : int   ; line 596
	lw      $t0, -72($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 596
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t12 = %i   ; line 596
	lw      $t0, -32($fp)
	sw      $t0, -76($fp)
	# %t13 = %t12 + 1   ; line 596
	lw      $t0, -76($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# %i = %t13   ; line 596
	lw      $t0, -80($fp)
	sw      $t0, -32($fp)
	# goto .L407   ; line 596
	b       __rt_vformat.L407
__rt_vformat.L411:
	# %t14 = %i + 1   ; line 597
	lw      $t0, -32($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# %t15 = %fmt + %t14   ; line 597
	lw      $t0, -28($fp)
	lw      $t1, -84($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t16 = load.b %t15   ; line 597
	lw      $t0, -88($fp)
	lb      $t1, 0($t0)
	sw      $t1, -92($fp)
	# %t17 = %t16 == 37   ; line 597
	lw      $t0, -92($fp)
	xori    $t0, $t0, 37
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t17 goto .L413   ; line 597
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_vformat.L413
	# %t18 = 37   ; line 597
	li      $t0, 37
	sw      $t0, -100($fp)
	# param %t18 : int   ; line 597
	lw      $t0, -100($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 597
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t19 = %i + 2   ; line 597
	lw      $t0, -32($fp)
	addiu   $t0, $t0, 2
	sw      $t0, -104($fp)
	# %i = %t19   ; line 597
	lw      $t0, -104($fp)
	sw      $t0, -32($fp)
	# goto .L407   ; line 597
	b       __rt_vformat.L407
__rt_vformat.L413:
	# %start = %i   ; line 598
	lw      $t0, -32($fp)
	sw      $t0, -36($fp)
	# %t20 = addr wv   ; line 599
	addiu   $t0, $fp, -20
	sw      $t0, -108($fp)
	# store.w %t20, 0   ; line 599
	lw      $t0, -108($fp)
	sw      $zero, 0($t0)
	# %t21 = addr pv   ; line 600
	addiu   $t0, $fp, -16
	sw      $t0, -112($fp)
	# store.w %t21, 0   ; line 600
	lw      $t0, -112($fp)
	sw      $zero, 0($t0)
	# %t22 = %i + 1   ; line 601
	lw      $t0, -32($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -116($fp)
	# %t23 = addr ap   ; line 601
	addiu   $t0, $fp, -24
	sw      $t0, -120($fp)
	# %t24 = addr wv   ; line 601
	addiu   $t0, $fp, -20
	sw      $t0, -124($fp)
	# %t25 = addr pv   ; line 601
	addiu   $t0, $fp, -16
	sw      $t0, -128($fp)
	# param %fmt : str   ; line 601
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %t22 : int   ; line 601
	lw      $t0, -116($fp)
	sw      $t0, 4($sp)
	# param %t23 : ptr   ; line 601
	lw      $t0, -120($fp)
	sw      $t0, 8($sp)
	# param %t24 : ptr   ; line 601
	lw      $t0, -124($fp)
	sw      $t0, 12($sp)
	# param %t25 : ptr   ; line 601
	lw      $t0, -128($fp)
	sw      $t0, 16($sp)
	# %t26 = call @parse_spec, 5   ; line 601
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_parse_spec
	sw      $v0, -132($fp)
	# %i = %t26   ; line 601
	lw      $t0, -132($fp)
	sw      $t0, -32($fp)
	# %mods = %i   ; line 602
	lw      $t0, -32($fp)
	sw      $t0, -40($fp)
__rt_vformat.L414:
	# %t27 = %fmt + %i   ; line 603
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -136($fp)
	# %t28 = load.b %t27   ; line 603
	lw      $t0, -136($fp)
	lb      $t1, 0($t0)
	sw      $t1, -140($fp)
	# param %t28 : int   ; line 603
	lw      $t0, -140($fp)
	sw      $t0, 0($sp)
	# %t29 = call @is_lenmod, 1   ; line 603
	lw      $a0, 0($sp)
	jal     __rt_is_lenmod
	sw      $v0, -144($fp)
	# ifFalse %t29 goto .L416   ; line 603
	lw      $t0, -144($fp)
	beq     $t0, $zero, __rt_vformat.L416
	# %t30 = %i   ; line 603
	lw      $t0, -32($fp)
	sw      $t0, -148($fp)
	# %t31 = %t30 + 1   ; line 603
	lw      $t0, -148($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# %i = %t31   ; line 603
	lw      $t0, -152($fp)
	sw      $t0, -32($fp)
	# goto .L414   ; line 603
	b       __rt_vformat.L414
__rt_vformat.L416:
	# %t32 = %fmt + %i   ; line 604
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -156($fp)
	# %t33 = load.b %t32   ; line 604
	lw      $t0, -156($fp)
	lb      $t1, 0($t0)
	sw      $t1, -160($fp)
	# %t34 = %t33 == 0   ; line 604
	lw      $t0, -160($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -164($fp)
	# ifFalse %t34 goto .L418   ; line 604
	lw      $t0, -164($fp)
	beq     $t0, $zero, __rt_vformat.L418
	# %t35 = addr wv   ; line 604
	addiu   $t0, $fp, -20
	sw      $t0, -168($fp)
	# %t36 = load.w %t35   ; line 604
	lw      $t0, -168($fp)
	lw      $t1, 0($t0)
	sw      $t1, -172($fp)
	# %t37 = addr pv   ; line 604
	addiu   $t0, $fp, -16
	sw      $t0, -176($fp)
	# %t38 = load.w %t37   ; line 604
	lw      $t0, -176($fp)
	lw      $t1, 0($t0)
	sw      $t1, -180($fp)
	# param %fmt : str   ; line 604
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %start : int   ; line 604
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# param %mods : int   ; line 604
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# param %t36 : int   ; line 604
	lw      $t0, -172($fp)
	sw      $t0, 12($sp)
	# param %t38 : int   ; line 604
	lw      $t0, -180($fp)
	sw      $t0, 16($sp)
	# call @out_spec, 5   ; line 604
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_out_spec
	# goto .L409   ; line 604
	b       __rt_vformat.L409
__rt_vformat.L418:
	# %t39 = %fmt + %i   ; line 605
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -184($fp)
	# %t40 = load.b %t39   ; line 605
	lw      $t0, -184($fp)
	lb      $t1, 0($t0)
	sw      $t1, -188($fp)
	# %conv = %t40   ; line 605
	lw      $t0, -188($fp)
	sw      $t0, -44($fp)
	# %t41 = %i   ; line 606
	lw      $t0, -32($fp)
	sw      $t0, -192($fp)
	# %t42 = %t41 + 1   ; line 606
	lw      $t0, -192($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -196($fp)
	# %i = %t42   ; line 606
	lw      $t0, -196($fp)
	sw      $t0, -32($fp)
	# %t43 = %conv == 100   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 100
	sltiu   $t0, $t0, 1
	sw      $t0, -200($fp)
	# if %t43 goto .L420   ; line 608
	lw      $t0, -200($fp)
	bne     $t0, $zero, __rt_vformat.L420
	# %t44 = %conv == 105   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -204($fp)
	# if %t44 goto .L421   ; line 608
	lw      $t0, -204($fp)
	bne     $t0, $zero, __rt_vformat.L421
	# %t45 = %conv == 117   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 117
	sltiu   $t0, $t0, 1
	sw      $t0, -208($fp)
	# if %t45 goto .L422   ; line 608
	lw      $t0, -208($fp)
	bne     $t0, $zero, __rt_vformat.L422
	# %t46 = %conv == 111   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 111
	sltiu   $t0, $t0, 1
	sw      $t0, -212($fp)
	# if %t46 goto .L423   ; line 608
	lw      $t0, -212($fp)
	bne     $t0, $zero, __rt_vformat.L423
	# %t47 = %conv == 120   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -216($fp)
	# if %t47 goto .L424   ; line 608
	lw      $t0, -216($fp)
	bne     $t0, $zero, __rt_vformat.L424
	# %t48 = %conv == 88   ; line 608
	lw      $t0, -44($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -220($fp)
	# if %t48 goto .L425   ; line 608
	lw      $t0, -220($fp)
	bne     $t0, $zero, __rt_vformat.L425
	# %t49 = %conv == 99   ; line 612
	lw      $t0, -44($fp)
	xori    $t0, $t0, 99
	sltiu   $t0, $t0, 1
	sw      $t0, -224($fp)
	# if %t49 goto .L426   ; line 612
	lw      $t0, -224($fp)
	bne     $t0, $zero, __rt_vformat.L426
	# %t50 = %conv == 115   ; line 618
	lw      $t0, -44($fp)
	xori    $t0, $t0, 115
	sltiu   $t0, $t0, 1
	sw      $t0, -228($fp)
	# if %t50 goto .L427   ; line 618
	lw      $t0, -228($fp)
	bne     $t0, $zero, __rt_vformat.L427
	# %t51 = %conv == 112   ; line 622
	lw      $t0, -44($fp)
	xori    $t0, $t0, 112
	sltiu   $t0, $t0, 1
	sw      $t0, -232($fp)
	# if %t51 goto .L428   ; line 622
	lw      $t0, -232($fp)
	bne     $t0, $zero, __rt_vformat.L428
	# %t52 = %conv == 102   ; line 629
	lw      $t0, -44($fp)
	xori    $t0, $t0, 102
	sltiu   $t0, $t0, 1
	sw      $t0, -236($fp)
	# if %t52 goto .L429   ; line 629
	lw      $t0, -236($fp)
	bne     $t0, $zero, __rt_vformat.L429
	# %t53 = %conv == 70   ; line 629
	lw      $t0, -44($fp)
	xori    $t0, $t0, 70
	sltiu   $t0, $t0, 1
	sw      $t0, -240($fp)
	# if %t53 goto .L430   ; line 629
	lw      $t0, -240($fp)
	bne     $t0, $zero, __rt_vformat.L430
	# %t54 = %conv == 101   ; line 629
	lw      $t0, -44($fp)
	xori    $t0, $t0, 101
	sltiu   $t0, $t0, 1
	sw      $t0, -244($fp)
	# if %t54 goto .L431   ; line 629
	lw      $t0, -244($fp)
	bne     $t0, $zero, __rt_vformat.L431
	# %t55 = %conv == 69   ; line 629
	lw      $t0, -44($fp)
	xori    $t0, $t0, 69
	sltiu   $t0, $t0, 1
	sw      $t0, -248($fp)
	# if %t55 goto .L432   ; line 629
	lw      $t0, -248($fp)
	bne     $t0, $zero, __rt_vformat.L432
	# %t56 = %conv == 103   ; line 630
	lw      $t0, -44($fp)
	xori    $t0, $t0, 103
	sltiu   $t0, $t0, 1
	sw      $t0, -252($fp)
	# if %t56 goto .L433   ; line 630
	lw      $t0, -252($fp)
	bne     $t0, $zero, __rt_vformat.L433
	# %t57 = %conv == 71   ; line 630
	lw      $t0, -44($fp)
	xori    $t0, $t0, 71
	sltiu   $t0, $t0, 1
	sw      $t0, -256($fp)
	# if %t57 goto .L434   ; line 630
	lw      $t0, -256($fp)
	bne     $t0, $zero, __rt_vformat.L434
	# %t58 = %conv == 97   ; line 630
	lw      $t0, -44($fp)
	xori    $t0, $t0, 97
	sltiu   $t0, $t0, 1
	sw      $t0, -260($fp)
	# if %t58 goto .L435   ; line 630
	lw      $t0, -260($fp)
	bne     $t0, $zero, __rt_vformat.L435
	# %t59 = %conv == 65   ; line 630
	lw      $t0, -44($fp)
	xori    $t0, $t0, 65
	sltiu   $t0, $t0, 1
	sw      $t0, -264($fp)
	# if %t59 goto .L436   ; line 630
	lw      $t0, -264($fp)
	bne     $t0, $zero, __rt_vformat.L436
	# %t60 = %conv == 37   ; line 635
	lw      $t0, -44($fp)
	xori    $t0, $t0, 37
	sltiu   $t0, $t0, 1
	sw      $t0, -268($fp)
	# if %t60 goto .L437   ; line 635
	lw      $t0, -268($fp)
	bne     $t0, $zero, __rt_vformat.L437
	# goto .L438   ; line 607
	b       __rt_vformat.L438
__rt_vformat.L420:
__rt_vformat.L421:
__rt_vformat.L422:
__rt_vformat.L423:
__rt_vformat.L424:
__rt_vformat.L425:
	# %t61 = addr ap   ; line 609
	addiu   $t0, $fp, -24
	sw      $t0, -272($fp)
	# %t62 = load.w %t61   ; line 609
	lw      $t0, -272($fp)
	lw      $t1, 0($t0)
	sw      $t1, -276($fp)
	# %t63 = load.w %t62   ; line 609
	lw      $t0, -276($fp)
	lw      $t1, 0($t0)
	sw      $t1, -280($fp)
	# %t64 = %i - 1   ; line 609
	lw      $t0, -32($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -284($fp)
	# param %t63 : int   ; line 609
	lw      $t0, -280($fp)
	sw      $t0, 0($sp)
	# param %fmt : str   ; line 609
	lw      $t0, -28($fp)
	sw      $t0, 4($sp)
	# param %mods : int   ; line 609
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# param %t64 : int   ; line 609
	lw      $t0, -284($fp)
	sw      $t0, 12($sp)
	# param %conv : int   ; line 609
	lw      $t0, -44($fp)
	sw      $t0, 16($sp)
	# %t65 = call @narrow, 5   ; line 609
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_narrow
	sw      $v0, -288($fp)
	# param %t65 : int   ; line 609
	lw      $t0, -288($fp)
	sw      $t0, 0($sp)
	# param %conv : int   ; line 609
	lw      $t0, -44($fp)
	sw      $t0, 4($sp)
	# call @fmt_int, 2   ; line 609
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_fmt_int
	# %t66 = addr ap   ; line 610
	addiu   $t0, $fp, -24
	sw      $t0, -292($fp)
	# %t67 = addr ap   ; line 610
	addiu   $t0, $fp, -24
	sw      $t0, -296($fp)
	# %t68 = load.w %t67   ; line 610
	lw      $t0, -296($fp)
	lw      $t1, 0($t0)
	sw      $t1, -300($fp)
	# %t69 = %t68 + 4   ; line 610
	lw      $t0, -300($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -304($fp)
	# store.w %t66, %t69   ; line 610
	lw      $t0, -292($fp)
	lw      $t1, -304($fp)
	sw      $t1, 0($t0)
	# goto .L419   ; line 611
	b       __rt_vformat.L419
__rt_vformat.L426:
	# %t70 = 1   ; line 613
	li      $t0, 1
	sw      $t0, -308($fp)
	# param %t70 : int   ; line 613
	lw      $t0, -308($fp)
	sw      $t0, 0($sp)
	# call @pad_before, 1   ; line 613
	lw      $a0, 0($sp)
	jal     __rt_pad_before
	# %t71 = addr ap   ; line 614
	addiu   $t0, $fp, -24
	sw      $t0, -312($fp)
	# %t72 = load.w %t71   ; line 614
	lw      $t0, -312($fp)
	lw      $t1, 0($t0)
	sw      $t1, -316($fp)
	# %t73 = load.w %t72   ; line 614
	lw      $t0, -316($fp)
	lw      $t1, 0($t0)
	sw      $t1, -320($fp)
	# %t74 = %t73 & 255   ; line 614
	lw      $t0, -320($fp)
	andi    $t0, $t0, 255
	sw      $t0, -324($fp)
	# param %t74 : int   ; line 614
	lw      $t0, -324($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 614
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t75 = 1   ; line 615
	li      $t0, 1
	sw      $t0, -328($fp)
	# param %t75 : int   ; line 615
	lw      $t0, -328($fp)
	sw      $t0, 0($sp)
	# call @pad_after, 1   ; line 615
	lw      $a0, 0($sp)
	jal     __rt_pad_after
	# %t76 = addr ap   ; line 616
	addiu   $t0, $fp, -24
	sw      $t0, -332($fp)
	# %t77 = addr ap   ; line 616
	addiu   $t0, $fp, -24
	sw      $t0, -336($fp)
	# %t78 = load.w %t77   ; line 616
	lw      $t0, -336($fp)
	lw      $t1, 0($t0)
	sw      $t1, -340($fp)
	# %t79 = %t78 + 4   ; line 616
	lw      $t0, -340($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -344($fp)
	# store.w %t76, %t79   ; line 616
	lw      $t0, -332($fp)
	lw      $t1, -344($fp)
	sw      $t1, 0($t0)
	# goto .L419   ; line 617
	b       __rt_vformat.L419
__rt_vformat.L427:
	# %t80 = addr ap   ; line 619
	addiu   $t0, $fp, -24
	sw      $t0, -348($fp)
	# %t81 = load.w %t80   ; line 619
	lw      $t0, -348($fp)
	lw      $t1, 0($t0)
	sw      $t1, -352($fp)
	# %t82 = load.w %t81   ; line 619
	lw      $t0, -352($fp)
	lw      $t1, 0($t0)
	sw      $t1, -356($fp)
	# param %t82 : str   ; line 619
	lw      $t0, -356($fp)
	sw      $t0, 0($sp)
	# call @fmt_str, 1   ; line 619
	lw      $a0, 0($sp)
	jal     __rt_fmt_str
	# %t83 = addr ap   ; line 620
	addiu   $t0, $fp, -24
	sw      $t0, -360($fp)
	# %t84 = addr ap   ; line 620
	addiu   $t0, $fp, -24
	sw      $t0, -364($fp)
	# %t85 = load.w %t84   ; line 620
	lw      $t0, -364($fp)
	lw      $t1, 0($t0)
	sw      $t1, -368($fp)
	# %t86 = %t85 + 4   ; line 620
	lw      $t0, -368($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -372($fp)
	# store.w %t83, %t86   ; line 620
	lw      $t0, -360($fp)
	lw      $t1, -372($fp)
	sw      $t1, 0($t0)
	# goto .L419   ; line 621
	b       __rt_vformat.L419
__rt_vformat.L428:
	# %t87 = 48   ; line 623
	li      $t0, 48
	sw      $t0, -376($fp)
	# param %t87 : int   ; line 623
	lw      $t0, -376($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 623
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t88 = 120   ; line 624
	li      $t0, 120
	sw      $t0, -380($fp)
	# param %t88 : int   ; line 624
	lw      $t0, -380($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 624
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# %t89 = addr @pf_alt   ; line 625
	la      $t0, __rtg_pf_alt
	sw      $t0, -384($fp)
	# store.w %t89, 0   ; line 625
	lw      $t0, -384($fp)
	sw      $zero, 0($t0)
	# %t90 = addr @pf_prec   ; line 625
	la      $t0, __rtg_pf_prec
	sw      $t0, -388($fp)
	# store.w %t90, -1   ; line 625
	lw      $t0, -388($fp)
	li      $t1, -1
	sw      $t1, 0($t0)
	# %t91 = addr @pf_width   ; line 625
	la      $t0, __rtg_pf_width
	sw      $t0, -392($fp)
	# store.w %t91, 0   ; line 625
	lw      $t0, -392($fp)
	sw      $zero, 0($t0)
	# %t92 = addr ap   ; line 626
	addiu   $t0, $fp, -24
	sw      $t0, -396($fp)
	# %t93 = load.w %t92   ; line 626
	lw      $t0, -396($fp)
	lw      $t1, 0($t0)
	sw      $t1, -400($fp)
	# %t94 = load.w %t93   ; line 626
	lw      $t0, -400($fp)
	lw      $t1, 0($t0)
	sw      $t1, -404($fp)
	# %t95 = 120   ; line 626
	li      $t0, 120
	sw      $t0, -408($fp)
	# param %t94 : int   ; line 626
	lw      $t0, -404($fp)
	sw      $t0, 0($sp)
	# param %t95 : int   ; line 626
	lw      $t0, -408($fp)
	sw      $t0, 4($sp)
	# call @fmt_int, 2   ; line 626
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_fmt_int
	# %t96 = addr ap   ; line 627
	addiu   $t0, $fp, -24
	sw      $t0, -412($fp)
	# %t97 = addr ap   ; line 627
	addiu   $t0, $fp, -24
	sw      $t0, -416($fp)
	# %t98 = load.w %t97   ; line 627
	lw      $t0, -416($fp)
	lw      $t1, 0($t0)
	sw      $t1, -420($fp)
	# %t99 = %t98 + 4   ; line 627
	lw      $t0, -420($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -424($fp)
	# store.w %t96, %t99   ; line 627
	lw      $t0, -412($fp)
	lw      $t1, -424($fp)
	sw      $t1, 0($t0)
	# goto .L419   ; line 628
	b       __rt_vformat.L419
__rt_vformat.L429:
__rt_vformat.L430:
__rt_vformat.L431:
__rt_vformat.L432:
__rt_vformat.L433:
__rt_vformat.L434:
__rt_vformat.L435:
__rt_vformat.L436:
	# %t100 = addr ap   ; line 631
	addiu   $t0, $fp, -24
	sw      $t0, -428($fp)
	# %t101 = addr ap   ; line 631
	addiu   $t0, $fp, -24
	sw      $t0, -432($fp)
	# %t102 = load.w %t101   ; line 631
	lw      $t0, -432($fp)
	lw      $t1, 0($t0)
	sw      $t1, -436($fp)
	# %t103 = %t102 + 7   ; line 631
	lw      $t0, -436($fp)
	addiu   $t0, $t0, 7
	sw      $t0, -440($fp)
	# %t104 = %t103 & -8   ; line 631
	lw      $t0, -440($fp)
	li      $t1, -8
	and     $t0, $t0, $t1
	sw      $t0, -444($fp)
	# store.w %t100, %t104   ; line 631
	lw      $t0, -428($fp)
	lw      $t1, -444($fp)
	sw      $t1, 0($t0)
	# %t105 = addr ap   ; line 632
	addiu   $t0, $fp, -24
	sw      $t0, -448($fp)
	# %t106 = load.w %t105   ; line 632
	lw      $t0, -448($fp)
	lw      $t1, 0($t0)
	sw      $t1, -452($fp)
	# %t107 = %t106 + 4   ; line 632
	lw      $t0, -452($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -456($fp)
	# %t108 = load.w %t107   ; line 632
	lw      $t0, -456($fp)
	lw      $t1, 0($t0)
	sw      $t1, -460($fp)
	# %t109 = addr ap   ; line 632
	addiu   $t0, $fp, -24
	sw      $t0, -464($fp)
	# %t110 = load.w %t109   ; line 632
	lw      $t0, -464($fp)
	lw      $t1, 0($t0)
	sw      $t1, -468($fp)
	# %t111 = %t110 + 0   ; line 632
	lw      $t0, -468($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -472($fp)
	# %t112 = load.w %t111   ; line 632
	lw      $t0, -472($fp)
	lw      $t1, 0($t0)
	sw      $t1, -476($fp)
	# param %t108 : int   ; line 632
	lw      $t0, -460($fp)
	sw      $t0, 0($sp)
	# param %t112 : int   ; line 632
	lw      $t0, -476($fp)
	sw      $t0, 4($sp)
	# param %conv : int   ; line 632
	lw      $t0, -44($fp)
	sw      $t0, 8($sp)
	# call @fmt_float, 3   ; line 632
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_fmt_float
	# %t113 = addr ap   ; line 633
	addiu   $t0, $fp, -24
	sw      $t0, -480($fp)
	# %t114 = addr ap   ; line 633
	addiu   $t0, $fp, -24
	sw      $t0, -484($fp)
	# %t115 = load.w %t114   ; line 633
	lw      $t0, -484($fp)
	lw      $t1, 0($t0)
	sw      $t1, -488($fp)
	# %t116 = %t115 + 8   ; line 633
	lw      $t0, -488($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -492($fp)
	# store.w %t113, %t116   ; line 633
	lw      $t0, -480($fp)
	lw      $t1, -492($fp)
	sw      $t1, 0($t0)
	# goto .L419   ; line 634
	b       __rt_vformat.L419
__rt_vformat.L437:
	# %t117 = 37   ; line 636
	li      $t0, 37
	sw      $t0, -496($fp)
	# param %t117 : int   ; line 636
	lw      $t0, -496($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 636
	lw      $a0, 0($sp)
	jal     __rt_out_char
	# goto .L419   ; line 637
	b       __rt_vformat.L419
__rt_vformat.L438:
	# %t118 = addr wv   ; line 639
	addiu   $t0, $fp, -20
	sw      $t0, -500($fp)
	# %t119 = load.w %t118   ; line 639
	lw      $t0, -500($fp)
	lw      $t1, 0($t0)
	sw      $t1, -504($fp)
	# %t120 = addr pv   ; line 639
	addiu   $t0, $fp, -16
	sw      $t0, -508($fp)
	# %t121 = load.w %t120   ; line 639
	lw      $t0, -508($fp)
	lw      $t1, 0($t0)
	sw      $t1, -512($fp)
	# param %fmt : str   ; line 639
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %start : int   ; line 639
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# param %mods : int   ; line 639
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# param %t119 : int   ; line 639
	lw      $t0, -504($fp)
	sw      $t0, 12($sp)
	# param %t121 : int   ; line 639
	lw      $t0, -512($fp)
	sw      $t0, 16($sp)
	# call @out_spec, 5   ; line 639
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_out_spec
	# param %conv : int   ; line 640
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# call @out_char, 1   ; line 640
	lw      $a0, 0($sp)
	jal     __rt_out_char
__rt_vformat.L419:
	# goto .L407   ; line 641
	b       __rt_vformat.L407
__rt_vformat.L409:
	# %t122 = addr @out_count   ; line 644
	la      $t0, __rtg_out_count
	sw      $t0, -516($fp)
	# %t123 = load.w %t122   ; line 644
	lw      $t0, -516($fp)
	lw      $t1, 0($t0)
	sw      $t1, -520($fp)
	# return %t123   ; line 644
	lw      $v0, -520($fp)
__rt_vformat.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_file_of
	.text
# ---------------------------------------------------------------
# function file_of (line 671), returns ptr
# frame 80 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%i : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_file_of
__rt_file_of:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -80
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %i = 0   ; line 673
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_file_of.L439:
	# %t2 = %i < 16   ; line 673
	lw      $t0, -16($fp)
	slti    $t0, $t0, 16
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L442   ; line 673
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_file_of.L442
	# %t3 = addr @rt_files   ; line 674
	la      $t0, __rtg_rt_files
	sw      $t0, -24($fp)
	# %t4 = %i * 800   ; line 674
	lw      $t0, -16($fp)
	li      $t1, 800
	mul     $t0, $t0, $t1
	sw      $t0, -28($fp)
	# %t5 = %t3 + %t4   ; line 674
	lw      $t0, -24($fp)
	lw      $t1, -28($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = %f == %t5   ; line 674
	lw      $t0, -12($fp)
	lw      $t1, -32($fp)
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L444   ; line 674
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_file_of.L444
	# %t7 = addr @rt_files   ; line 674
	la      $t0, __rtg_rt_files
	sw      $t0, -40($fp)
	# %t8 = %i * 800   ; line 674
	lw      $t0, -16($fp)
	li      $t1, 800
	mul     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = %t7 + %t8   ; line 674
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 674
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# ifFalse %t10 goto .L444   ; line 674
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_file_of.L444
	# return %f   ; line 674
	lw      $v0, -12($fp)
	b       __rt_file_of.ret
__rt_file_of.L444:
	# %t11 = %i   ; line 673
	lw      $t0, -16($fp)
	sw      $t0, -56($fp)
	# %t12 = %t11 + 1   ; line 673
	lw      $t0, -56($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# %i = %t12   ; line 673
	lw      $t0, -60($fp)
	sw      $t0, -16($fp)
	# goto .L439   ; line 673
	b       __rt_file_of.L439
__rt_file_of.L442:
	# return 0   ; line 675
	move    $v0, $zero
__rt_file_of.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_f_getc
	.text
# ---------------------------------------------------------------
# function f_getc (line 679), returns int
# frame 160 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%n : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : ptr
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : str
#   -120($fp)	%t27 : char
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : ptr
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_f_getc
__rt_f_getc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -160
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = %f + 16   ; line 681
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 16
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 681
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# ifFalse %t3 goto .L446   ; line 681
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_f_getc.L446
	# %t4 = %f + 16   ; line 682
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 16
	sw      $t0, -28($fp)
	# store.w %t4, 0   ; line 682
	lw      $t0, -28($fp)
	sw      $zero, 0($t0)
	# %t5 = %f + 20   ; line 683
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 20
	sw      $t0, -32($fp)
	# %t6 = load.w %t5   ; line 683
	lw      $t0, -32($fp)
	lw      $t1, 0($t0)
	sw      $t1, -36($fp)
	# return %t6   ; line 683
	lw      $v0, -36($fp)
	b       __rt_f_getc.ret
__rt_f_getc.L446:
	# %t7 = %f + 12   ; line 685
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -40($fp)
	# %t8 = load.w %t7   ; line 685
	lw      $t0, -40($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# ifFalse %t8 goto .L448   ; line 685
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_f_getc.L448
	# return -1   ; line 685
	li      $v0, -1
	b       __rt_f_getc.ret
__rt_f_getc.L448:
	# %t9 = %f + 24   ; line 686
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 686
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %f + 28   ; line 686
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 28
	sw      $t0, -56($fp)
	# %t12 = load.w %t11   ; line 686
	lw      $t0, -56($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %t10 >= %t12   ; line 686
	lw      $t0, -52($fp)
	lw      $t1, -60($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L450   ; line 686
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_f_getc.L450
	# %t14 = %f + 4   ; line 687
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 687
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t16 = %f + 32   ; line 687
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 32
	sw      $t0, -76($fp)
	# %t17 = 512   ; line 687
	li      $t0, 512
	sw      $t0, -80($fp)
	# param %t15 : int   ; line 687
	lw      $t0, -72($fp)
	sw      $t0, 0($sp)
	# param %t16 : str   ; line 687
	lw      $t0, -76($fp)
	sw      $t0, 4($sp)
	# param %t17 : int   ; line 687
	lw      $t0, -80($fp)
	sw      $t0, 8($sp)
	# %t18 = call @sys_read, 3   ; line 687
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_read
	sw      $v0, -84($fp)
	# %n = %t18   ; line 687
	lw      $t0, -84($fp)
	sw      $t0, -16($fp)
	# %t19 = %n <= 0   ; line 688
	lw      $t0, -16($fp)
	slt     $t0, $zero, $t0
	xori    $t0, $t0, 1
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L452   ; line 688
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_f_getc.L452
	# %t20 = %f + 12   ; line 689
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -92($fp)
	# store.w %t20, 1   ; line 689
	lw      $t0, -92($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# return -1   ; line 690
	li      $v0, -1
	b       __rt_f_getc.ret
__rt_f_getc.L452:
	# %t21 = %f + 24   ; line 692
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -96($fp)
	# store.w %t21, 0   ; line 692
	lw      $t0, -96($fp)
	sw      $zero, 0($t0)
	# %t22 = %f + 28   ; line 693
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 28
	sw      $t0, -100($fp)
	# store.w %t22, %n   ; line 693
	lw      $t0, -100($fp)
	lw      $t1, -16($fp)
	sw      $t1, 0($t0)
__rt_f_getc.L450:
	# %t23 = %f + 32   ; line 695
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 32
	sw      $t0, -104($fp)
	# %t24 = %f + 24   ; line 695
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -108($fp)
	# %t25 = load.w %t24   ; line 695
	lw      $t0, -108($fp)
	lw      $t1, 0($t0)
	sw      $t1, -112($fp)
	# %t26 = %t23 + %t25   ; line 695
	lw      $t0, -104($fp)
	lw      $t1, -112($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -116($fp)
	# %t27 = load.b %t26   ; line 695
	lw      $t0, -116($fp)
	lb      $t1, 0($t0)
	sw      $t1, -120($fp)
	# %t28 = %t27 & 255   ; line 695
	lw      $t0, -120($fp)
	andi    $t0, $t0, 255
	sw      $t0, -124($fp)
	# %n = %t28   ; line 695
	lw      $t0, -124($fp)
	sw      $t0, -16($fp)
	# %t29 = %f + 24   ; line 696
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -128($fp)
	# %t30 = load.w %t29   ; line 696
	lw      $t0, -128($fp)
	lw      $t1, 0($t0)
	sw      $t1, -132($fp)
	# %t31 = %t30   ; line 696
	lw      $t0, -132($fp)
	sw      $t0, -136($fp)
	# %t32 = %t31 + 1   ; line 696
	lw      $t0, -136($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -140($fp)
	# store.w %t29, %t32   ; line 696
	lw      $t0, -128($fp)
	lw      $t1, -140($fp)
	sw      $t1, 0($t0)
	# return %n   ; line 697
	lw      $v0, -16($fp)
__rt_f_getc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_rm_find
	.text
# ---------------------------------------------------------------
# function rm_find (line 705), returns int
# frame 152 bytes ($fp = $sp at entry):
#   0($fp)	param name (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%name : str
#   -16($fp)	%i : int
#   -20($fp)	%k : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : char
#   -52($fp)	%t10 : str
#   -56($fp)	%t11 : char
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : str
#   -76($fp)	%t16 : char
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : str
#   -96($fp)	%t21 : char
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : str
#   -120($fp)	%t27 : char
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_rm_find
__rt_rm_find:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -152
	sw      $a0, 0($fp)
	# param name : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %i = 0   ; line 707
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_rm_find.L453:
	# %t3 = %i < 8   ; line 707
	lw      $t0, -16($fp)
	slti    $t0, $t0, 8
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L456   ; line 707
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_rm_find.L456
	# %t4 = addr @rm_used   ; line 708
	la      $t0, __rtg_rm_used
	sw      $t0, -28($fp)
	# %t5 = %i * 4   ; line 708
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = %t4 + %t5   ; line 708
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 708
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# if %t7 goto .L458   ; line 708
	lw      $t0, -40($fp)
	bne     $t0, $zero, __rt_rm_find.L458
	# goto .L455   ; line 708
	b       __rt_rm_find.L455
__rt_rm_find.L458:
	# %k = 0   ; line 709
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_rm_find.L459:
	# %t8 = %name + %k   ; line 710
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = load.b %t8   ; line 710
	lw      $t0, -44($fp)
	lb      $t1, 0($t0)
	sw      $t1, -48($fp)
	# ifFalse %t9 goto .L461   ; line 710
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_rm_find.L461
	# %t10 = %name + %k   ; line 710
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %t11 = load.b %t10   ; line 710
	lw      $t0, -52($fp)
	lb      $t1, 0($t0)
	sw      $t1, -56($fp)
	# %t12 = addr @rm_names   ; line 710
	la      $t0, __rtg_rm_names
	sw      $t0, -60($fp)
	# %t13 = %i * 256   ; line 710
	lw      $t0, -16($fp)
	li      $t1, 256
	mul     $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %t14 = %t13 + %k   ; line 710
	lw      $t0, -64($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = %t12 + %t14   ; line 710
	lw      $t0, -60($fp)
	lw      $t1, -68($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = load.b %t15   ; line 710
	lw      $t0, -72($fp)
	lb      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t11 == %t16   ; line 710
	lw      $t0, -56($fp)
	lw      $t1, -76($fp)
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L461   ; line 710
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_rm_find.L461
	# %t18 = %k   ; line 710
	lw      $t0, -20($fp)
	sw      $t0, -84($fp)
	# %t19 = %t18 + 1   ; line 710
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %k = %t19   ; line 710
	lw      $t0, -88($fp)
	sw      $t0, -20($fp)
	# goto .L459   ; line 710
	b       __rt_rm_find.L459
__rt_rm_find.L461:
	# %t20 = %name + %k   ; line 711
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t21 = load.b %t20   ; line 711
	lw      $t0, -92($fp)
	lb      $t1, 0($t0)
	sw      $t1, -96($fp)
	# %t22 = %t21 == 0   ; line 711
	lw      $t0, -96($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# ifFalse %t22 goto .L463   ; line 711
	lw      $t0, -100($fp)
	beq     $t0, $zero, __rt_rm_find.L463
	# %t23 = addr @rm_names   ; line 711
	la      $t0, __rtg_rm_names
	sw      $t0, -104($fp)
	# %t24 = %i * 256   ; line 711
	lw      $t0, -16($fp)
	li      $t1, 256
	mul     $t0, $t0, $t1
	sw      $t0, -108($fp)
	# %t25 = %t24 + %k   ; line 711
	lw      $t0, -108($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -112($fp)
	# %t26 = %t23 + %t25   ; line 711
	lw      $t0, -104($fp)
	lw      $t1, -112($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -116($fp)
	# %t27 = load.b %t26   ; line 711
	lw      $t0, -116($fp)
	lb      $t1, 0($t0)
	sw      $t1, -120($fp)
	# %t28 = %t27 == 0   ; line 711
	lw      $t0, -120($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -124($fp)
	# ifFalse %t28 goto .L463   ; line 711
	lw      $t0, -124($fp)
	beq     $t0, $zero, __rt_rm_find.L463
	# return %i   ; line 711
	lw      $v0, -16($fp)
	b       __rt_rm_find.ret
__rt_rm_find.L463:
__rt_rm_find.L455:
	# %t29 = %i   ; line 707
	lw      $t0, -16($fp)
	sw      $t0, -128($fp)
	# %t30 = %t29 + 1   ; line 707
	lw      $t0, -128($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# %i = %t30   ; line 707
	lw      $t0, -132($fp)
	sw      $t0, -16($fp)
	# goto .L453   ; line 707
	b       __rt_rm_find.L453
__rt_rm_find.L456:
	# return -1   ; line 713
	li      $v0, -1
__rt_rm_find.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fopen
	.text
# ---------------------------------------------------------------
# function fopen (line 719), returns ptr
# frame 312 bytes ($fp = $sp at entry):
#   0($fp)	param name (str, arrives in $a0)
#   4($fp)	param mode (str, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%name : str
#   -16($fp)	%mode : str
#   -20($fp)	%f : ptr
#   -24($fp)	%i : int
#   -28($fp)	%flags : int
#   -32($fp)	%plus : int
#   -36($fp)	%fd : int
#   -40($fp)	%n : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : str
#   -96($fp)	%t21 : char
#   -100($fp)	%t22 : str
#   -104($fp)	%t23 : char
#   -108($fp)	%t24 : str
#   -112($fp)	%t25 : char
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : str
#   -132($fp)	%t30 : char
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : str
#   -148($fp)	%t34 : char
#   -152($fp)	%t35 : int
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : str
#   -164($fp)	%t38 : char
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : int
#   -184($fp)	%t43 : str
#   -188($fp)	%t44 : char
#   -192($fp)	%t45 : int
#   -196($fp)	%t46 : ptr
#   -200($fp)	%t47 : int
#   -204($fp)	%t48 : ptr
#   -208($fp)	%t49 : int
#   -212($fp)	%t50 : int
#   -216($fp)	%t51 : int
#   -220($fp)	%t52 : ptr
#   -224($fp)	%t53 : ptr
#   -228($fp)	%t54 : int
#   -232($fp)	%t55 : ptr
#   -236($fp)	%t56 : ptr
#   -240($fp)	%t57 : ptr
#   -244($fp)	%t58 : ptr
#   -248($fp)	%t59 : int
#   -252($fp)	%t60 : int
#   -256($fp)	%t61 : int
#   -260($fp)	%t62 : ptr
#   -264($fp)	%t63 : str
#   -268($fp)	%t64 : str
#   -272($fp)	%t65 : char
#   -276($fp)	%t66 : char
#   -280($fp)	%t67 : int
#   -284($fp)	%t68 : int
#   -288($fp)	%t69 : ptr
#   -292($fp)	%t70 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fopen
__rt_fopen:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -312
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param name : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param mode : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %f = 0   ; line 722
	move    $t0, $zero
	sw      $t0, -20($fp)
	# %i = 0   ; line 723
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_fopen.L464:
	# %t8 = %i < 16   ; line 723
	lw      $t0, -24($fp)
	slti    $t0, $t0, 16
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L467   ; line 723
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_fopen.L467
	# %t9 = %f == 0   ; line 723
	lw      $t0, -20($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -48($fp)
	# ifFalse %t9 goto .L467   ; line 723
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_fopen.L467
	# %t10 = addr @rt_files   ; line 723
	la      $t0, __rtg_rt_files
	sw      $t0, -52($fp)
	# %t11 = %i * 800   ; line 723
	lw      $t0, -24($fp)
	li      $t1, 800
	mul     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = %t10 + %t11   ; line 723
	lw      $t0, -52($fp)
	lw      $t1, -56($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t13 = load.w %t12   ; line 723
	lw      $t0, -60($fp)
	lw      $t1, 0($t0)
	sw      $t1, -64($fp)
	# if %t13 goto .L469   ; line 723
	lw      $t0, -64($fp)
	bne     $t0, $zero, __rt_fopen.L469
	# %t14 = addr @rt_files   ; line 723
	la      $t0, __rtg_rt_files
	sw      $t0, -68($fp)
	# %t15 = %i * 800   ; line 723
	lw      $t0, -24($fp)
	li      $t1, 800
	mul     $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = %t14 + %t15   ; line 723
	lw      $t0, -68($fp)
	lw      $t1, -72($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -76($fp)
	# %f = %t16   ; line 723
	lw      $t0, -76($fp)
	sw      $t0, -20($fp)
__rt_fopen.L469:
	# %t17 = %i   ; line 723
	lw      $t0, -24($fp)
	sw      $t0, -80($fp)
	# %t18 = %t17 + 1   ; line 723
	lw      $t0, -80($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# %i = %t18   ; line 723
	lw      $t0, -84($fp)
	sw      $t0, -24($fp)
	# goto .L464   ; line 723
	b       __rt_fopen.L464
__rt_fopen.L467:
	# %t19 = %f == 0   ; line 724
	lw      $t0, -20($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L471   ; line 724
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_fopen.L471
	# return 0   ; line 724
	move    $v0, $zero
	b       __rt_fopen.ret
__rt_fopen.L471:
	# %plus = 0   ; line 725
	move    $t0, $zero
	sw      $t0, -32($fp)
	# %i = 1   ; line 726
	li      $t0, 1
	sw      $t0, -24($fp)
__rt_fopen.L472:
	# %t20 = %mode + 0   ; line 726
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -92($fp)
	# %t21 = load.b %t20   ; line 726
	lw      $t0, -92($fp)
	lb      $t1, 0($t0)
	sw      $t1, -96($fp)
	# ifFalse %t21 goto .L475   ; line 726
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_fopen.L475
	# %t22 = %mode + %i   ; line 726
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -100($fp)
	# %t23 = load.b %t22   ; line 726
	lw      $t0, -100($fp)
	lb      $t1, 0($t0)
	sw      $t1, -104($fp)
	# ifFalse %t23 goto .L475   ; line 726
	lw      $t0, -104($fp)
	beq     $t0, $zero, __rt_fopen.L475
	# %t24 = %mode + %i   ; line 726
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -108($fp)
	# %t25 = load.b %t24   ; line 726
	lw      $t0, -108($fp)
	lb      $t1, 0($t0)
	sw      $t1, -112($fp)
	# %t26 = %t25 == 43   ; line 726
	lw      $t0, -112($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -116($fp)
	# ifFalse %t26 goto .L477   ; line 726
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_fopen.L477
	# %plus = 1   ; line 726
	li      $t0, 1
	sw      $t0, -32($fp)
__rt_fopen.L477:
	# %t27 = %i   ; line 726
	lw      $t0, -24($fp)
	sw      $t0, -120($fp)
	# %t28 = %t27 + 1   ; line 726
	lw      $t0, -120($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -124($fp)
	# %i = %t28   ; line 726
	lw      $t0, -124($fp)
	sw      $t0, -24($fp)
	# goto .L472   ; line 726
	b       __rt_fopen.L472
__rt_fopen.L475:
	# %t29 = %mode + 0   ; line 727
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -128($fp)
	# %t30 = load.b %t29   ; line 727
	lw      $t0, -128($fp)
	lb      $t1, 0($t0)
	sw      $t1, -132($fp)
	# %t31 = %t30 == 114   ; line 727
	lw      $t0, -132($fp)
	xori    $t0, $t0, 114
	sltiu   $t0, $t0, 1
	sw      $t0, -136($fp)
	# ifFalse %t31 goto .L479   ; line 727
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_fopen.L479
	# ifFalse %plus goto .L481   ; line 727
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fopen.L481
	# %t32 = 2   ; line 727
	li      $t0, 2
	sw      $t0, -140($fp)
	# goto .L482   ; line 727
	b       __rt_fopen.L482
__rt_fopen.L481:
	# %t32 = 0   ; line 727
	move    $t0, $zero
	sw      $t0, -140($fp)
__rt_fopen.L482:
	# %flags = %t32   ; line 727
	lw      $t0, -140($fp)
	sw      $t0, -28($fp)
	# goto .L483   ; line 727
	b       __rt_fopen.L483
__rt_fopen.L479:
	# %t33 = %mode + 0   ; line 728
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -144($fp)
	# %t34 = load.b %t33   ; line 728
	lw      $t0, -144($fp)
	lb      $t1, 0($t0)
	sw      $t1, -148($fp)
	# %t35 = %t34 == 119   ; line 728
	lw      $t0, -148($fp)
	xori    $t0, $t0, 119
	sltiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# ifFalse %t35 goto .L485   ; line 728
	lw      $t0, -152($fp)
	beq     $t0, $zero, __rt_fopen.L485
	# ifFalse %plus goto .L487   ; line 728
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fopen.L487
	# %t36 = 578   ; line 728
	li      $t0, 578
	sw      $t0, -156($fp)
	# goto .L488   ; line 728
	b       __rt_fopen.L488
__rt_fopen.L487:
	# %t36 = 577   ; line 728
	li      $t0, 577
	sw      $t0, -156($fp)
__rt_fopen.L488:
	# %flags = %t36   ; line 728
	lw      $t0, -156($fp)
	sw      $t0, -28($fp)
	# goto .L489   ; line 728
	b       __rt_fopen.L489
__rt_fopen.L485:
	# %t37 = %mode + 0   ; line 729
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -160($fp)
	# %t38 = load.b %t37   ; line 729
	lw      $t0, -160($fp)
	lb      $t1, 0($t0)
	sw      $t1, -164($fp)
	# %t39 = %t38 == 97   ; line 729
	lw      $t0, -164($fp)
	xori    $t0, $t0, 97
	sltiu   $t0, $t0, 1
	sw      $t0, -168($fp)
	# ifFalse %t39 goto .L491   ; line 729
	lw      $t0, -168($fp)
	beq     $t0, $zero, __rt_fopen.L491
	# ifFalse %plus goto .L493   ; line 729
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_fopen.L493
	# %t40 = 1090   ; line 729
	li      $t0, 1090
	sw      $t0, -172($fp)
	# goto .L494   ; line 729
	b       __rt_fopen.L494
__rt_fopen.L493:
	# %t40 = 1089   ; line 729
	li      $t0, 1089
	sw      $t0, -172($fp)
__rt_fopen.L494:
	# %flags = %t40   ; line 729
	lw      $t0, -172($fp)
	sw      $t0, -28($fp)
	# goto .L495   ; line 729
	b       __rt_fopen.L495
__rt_fopen.L491:
	# return 0   ; line 730
	move    $v0, $zero
	b       __rt_fopen.ret
__rt_fopen.L495:
__rt_fopen.L489:
__rt_fopen.L483:
	# param %name : str   ; line 731
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t41 = call @rm_find, 1   ; line 731
	lw      $a0, 0($sp)
	jal     __rt_rm_find
	sw      $v0, -176($fp)
	# %i = %t41   ; line 731
	lw      $t0, -176($fp)
	sw      $t0, -24($fp)
	# %t42 = %i >= 0   ; line 732
	lw      $t0, -24($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -180($fp)
	# ifFalse %t42 goto .L497   ; line 732
	lw      $t0, -180($fp)
	beq     $t0, $zero, __rt_fopen.L497
	# %t43 = %mode + 0   ; line 733
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -184($fp)
	# %t44 = load.b %t43   ; line 733
	lw      $t0, -184($fp)
	lb      $t1, 0($t0)
	sw      $t1, -188($fp)
	# %t45 = %t44 == 114   ; line 733
	lw      $t0, -188($fp)
	xori    $t0, $t0, 114
	sltiu   $t0, $t0, 1
	sw      $t0, -192($fp)
	# ifFalse %t45 goto .L499   ; line 733
	lw      $t0, -192($fp)
	beq     $t0, $zero, __rt_fopen.L499
	# return 0   ; line 733
	move    $v0, $zero
	b       __rt_fopen.ret
__rt_fopen.L499:
	# %t46 = addr @rm_used   ; line 734
	la      $t0, __rtg_rm_used
	sw      $t0, -196($fp)
	# %t47 = %i * 4   ; line 734
	lw      $t0, -24($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -200($fp)
	# %t48 = %t46 + %t47   ; line 734
	lw      $t0, -196($fp)
	lw      $t1, -200($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -204($fp)
	# store.w %t48, 0   ; line 734
	lw      $t0, -204($fp)
	sw      $zero, 0($t0)
__rt_fopen.L497:
	# %t49 = 420   ; line 736
	li      $t0, 420
	sw      $t0, -208($fp)
	# param %name : str   ; line 736
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %flags : int   ; line 736
	lw      $t0, -28($fp)
	sw      $t0, 4($sp)
	# param %t49 : int   ; line 736
	lw      $t0, -208($fp)
	sw      $t0, 8($sp)
	# %t50 = call @sys_open, 3   ; line 736
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_open
	sw      $v0, -212($fp)
	# %fd = %t50   ; line 736
	lw      $t0, -212($fp)
	sw      $t0, -36($fp)
	# %t51 = %fd < 0   ; line 737
	lw      $t0, -36($fp)
	slti    $t0, $t0, 0
	sw      $t0, -216($fp)
	# ifFalse %t51 goto .L501   ; line 737
	lw      $t0, -216($fp)
	beq     $t0, $zero, __rt_fopen.L501
	# return 0   ; line 737
	move    $v0, $zero
	b       __rt_fopen.ret
__rt_fopen.L501:
	# store.w %f, 1   ; line 738
	lw      $t0, -20($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t52 = %f + 4   ; line 739
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -220($fp)
	# store.w %t52, %fd   ; line 739
	lw      $t0, -220($fp)
	lw      $t1, -36($fp)
	sw      $t1, 0($t0)
	# %t53 = %f + 8   ; line 740
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -224($fp)
	# %t54 = %flags & -513   ; line 740
	lw      $t0, -28($fp)
	li      $t1, -513
	and     $t0, $t0, $t1
	sw      $t0, -228($fp)
	# store.w %t53, %t54   ; line 740
	lw      $t0, -224($fp)
	lw      $t1, -228($fp)
	sw      $t1, 0($t0)
	# %t55 = %f + 12   ; line 741
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -232($fp)
	# store.w %t55, 0   ; line 741
	lw      $t0, -232($fp)
	sw      $zero, 0($t0)
	# %t56 = %f + 16   ; line 742
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 16
	sw      $t0, -236($fp)
	# store.w %t56, 0   ; line 742
	lw      $t0, -236($fp)
	sw      $zero, 0($t0)
	# %t57 = %f + 24   ; line 743
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -240($fp)
	# store.w %t57, 0   ; line 743
	lw      $t0, -240($fp)
	sw      $zero, 0($t0)
	# %t58 = %f + 28   ; line 744
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 28
	sw      $t0, -244($fp)
	# store.w %t58, 0   ; line 744
	lw      $t0, -244($fp)
	sw      $zero, 0($t0)
	# param %name : str   ; line 745
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t59 = call @strlen, 1   ; line 745
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -248($fp)
	# %n = %t59   ; line 745
	lw      $t0, -248($fp)
	sw      $t0, -40($fp)
	# %t60 = %n < 256   ; line 746
	lw      $t0, -40($fp)
	slti    $t0, $t0, 256
	sw      $t0, -252($fp)
	# ifFalse %t60 goto .L503   ; line 746
	lw      $t0, -252($fp)
	beq     $t0, $zero, __rt_fopen.L503
	# %i = 0   ; line 747
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_fopen.L504:
	# %t61 = %i <= %n   ; line 747
	lw      $t0, -24($fp)
	lw      $t1, -40($fp)
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -256($fp)
	# ifFalse %t61 goto .L507   ; line 747
	lw      $t0, -256($fp)
	beq     $t0, $zero, __rt_fopen.L507
	# %t62 = %f + 544   ; line 747
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 544
	sw      $t0, -260($fp)
	# %t63 = %t62 + %i   ; line 747
	lw      $t0, -260($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -264($fp)
	# %t64 = %name + %i   ; line 747
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -268($fp)
	# %t65 = load.b %t64   ; line 747
	lw      $t0, -268($fp)
	lb      $t1, 0($t0)
	sw      $t1, -272($fp)
	# store.b %t63, %t65   ; line 747
	lw      $t0, -264($fp)
	lw      $t1, -272($fp)
	sb      $t1, 0($t0)
	# %t66 = sext.b %t65   ; line 747
	lw      $t0, -272($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -276($fp)
	# %t67 = %i   ; line 747
	lw      $t0, -24($fp)
	sw      $t0, -280($fp)
	# %t68 = %t67 + 1   ; line 747
	lw      $t0, -280($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -284($fp)
	# %i = %t68   ; line 747
	lw      $t0, -284($fp)
	sw      $t0, -24($fp)
	# goto .L504   ; line 747
	b       __rt_fopen.L504
__rt_fopen.L507:
	# goto .L508   ; line 747
	b       __rt_fopen.L508
__rt_fopen.L503:
	# %t69 = %f + 544   ; line 748
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 544
	sw      $t0, -288($fp)
	# %t70 = %t69 + 0   ; line 748
	lw      $t0, -288($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -292($fp)
	# store.b %t70, 0   ; line 748
	lw      $t0, -292($fp)
	sb      $zero, 0($t0)
__rt_fopen.L508:
	# return %f   ; line 749
	lw      $v0, -20($fp)
__rt_fopen.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fclose
	.text
# ---------------------------------------------------------------
# function fclose (line 752), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fclose
__rt_fclose:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %f : ptr   ; line 753
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t1 = call @file_of, 1   ; line 753
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -16($fp)
	# %f = %t1   ; line 753
	lw      $t0, -16($fp)
	sw      $t0, -12($fp)
	# %t2 = %f == 0   ; line 754
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L510   ; line 754
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_fclose.L510
	# return -1   ; line 754
	li      $v0, -1
	b       __rt_fclose.ret
__rt_fclose.L510:
	# %t3 = %f + 4   ; line 755
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 755
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# param %t4 : int   ; line 755
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# %t5 = call @sys_close, 1   ; line 755
	lw      $a0, 0($sp)
	jal     __rt_sys_close
	sw      $v0, -32($fp)
	# store.w %f, 0   ; line 756
	lw      $t0, -12($fp)
	sw      $zero, 0($t0)
	# return 0   ; line 757
	move    $v0, $zero
__rt_fclose.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_rewind
	.text
# ---------------------------------------------------------------
# function rewind (line 762), returns void
# frame 104 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : char
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_rewind
__rt_rewind:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -104
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %f : ptr   ; line 763
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t1 = call @file_of, 1   ; line 763
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -16($fp)
	# %f = %t1   ; line 763
	lw      $t0, -16($fp)
	sw      $t0, -12($fp)
	# %t2 = %f == 0   ; line 764
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L512   ; line 764
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_rewind.L512
	# return   ; line 764
	b       __rt_rewind.ret
__rt_rewind.L512:
	# %t3 = %f + 12   ; line 765
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -24($fp)
	# store.w %t3, 0   ; line 765
	lw      $t0, -24($fp)
	sw      $zero, 0($t0)
	# %t4 = %f + 16   ; line 766
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 16
	sw      $t0, -28($fp)
	# store.w %t4, 0   ; line 766
	lw      $t0, -28($fp)
	sw      $zero, 0($t0)
	# %t5 = %f + 24   ; line 767
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 24
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 767
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# %t6 = %f + 28   ; line 768
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 28
	sw      $t0, -36($fp)
	# store.w %t6, 0   ; line 768
	lw      $t0, -36($fp)
	sw      $zero, 0($t0)
	# %t7 = %f + 544   ; line 769
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 544
	sw      $t0, -40($fp)
	# %t8 = %t7 + 0   ; line 769
	lw      $t0, -40($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -44($fp)
	# %t9 = load.b %t8   ; line 769
	lw      $t0, -44($fp)
	lb      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %t10 = %t9 == 0   ; line 769
	lw      $t0, -48($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -52($fp)
	# ifFalse %t10 goto .L514   ; line 769
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_rewind.L514
	# return   ; line 769
	b       __rt_rewind.ret
__rt_rewind.L514:
	# %t11 = %f + 4   ; line 770
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -56($fp)
	# %t12 = load.w %t11   ; line 770
	lw      $t0, -56($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# param %t12 : int   ; line 770
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# %t13 = call @sys_close, 1   ; line 770
	lw      $a0, 0($sp)
	jal     __rt_sys_close
	sw      $v0, -64($fp)
	# %t14 = %f + 4   ; line 771
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -68($fp)
	# %t15 = %f + 544   ; line 771
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 544
	sw      $t0, -72($fp)
	# %t16 = %f + 8   ; line 771
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -76($fp)
	# %t17 = load.w %t16   ; line 771
	lw      $t0, -76($fp)
	lw      $t1, 0($t0)
	sw      $t1, -80($fp)
	# %t18 = 420   ; line 771
	li      $t0, 420
	sw      $t0, -84($fp)
	# param %t15 : str   ; line 771
	lw      $t0, -72($fp)
	sw      $t0, 0($sp)
	# param %t17 : int   ; line 771
	lw      $t0, -80($fp)
	sw      $t0, 4($sp)
	# param %t18 : int   ; line 771
	lw      $t0, -84($fp)
	sw      $t0, 8($sp)
	# %t19 = call @sys_open, 3   ; line 771
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_open
	sw      $v0, -88($fp)
	# store.w %t14, %t19   ; line 771
	lw      $t0, -68($fp)
	lw      $t1, -88($fp)
	sw      $t1, 0($t0)
	# return
__rt_rewind.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_remove
	.text
# ---------------------------------------------------------------
# function remove (line 778), returns int
# frame 200 bytes ($fp = $sp at entry):
#   0($fp)	param name (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%name : str
#   -16($fp)	%fd : int
#   -20($fp)	%i : int
#   -24($fp)	%k : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : ptr
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : ptr
#   -124($fp)	%t28 : str
#   -128($fp)	%t29 : char
#   -132($fp)	%t30 : ptr
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : str
#   -148($fp)	%t34 : str
#   -152($fp)	%t35 : char
#   -156($fp)	%t36 : char
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : int
#   -168($fp)	%t39 : ptr
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_remove
__rt_remove:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -200
	sw      $a0, 0($fp)
	# param name : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %name : str   ; line 780
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t4 = call @rm_find, 1   ; line 780
	lw      $a0, 0($sp)
	jal     __rt_rm_find
	sw      $v0, -28($fp)
	# %t5 = %t4 >= 0   ; line 780
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L516   ; line 780
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_remove.L516
	# return -1   ; line 780
	li      $v0, -1
	b       __rt_remove.ret
__rt_remove.L516:
	# %t6 = 0   ; line 781
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %t7 = 0   ; line 781
	move    $t0, $zero
	sw      $t0, -40($fp)
	# param %name : str   ; line 781
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %t6 : int   ; line 781
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# param %t7 : int   ; line 781
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# %t8 = call @sys_open, 3   ; line 781
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_open
	sw      $v0, -44($fp)
	# %fd = %t8   ; line 781
	lw      $t0, -44($fp)
	sw      $t0, -16($fp)
	# %t9 = %fd < 0   ; line 782
	lw      $t0, -16($fp)
	slti    $t0, $t0, 0
	sw      $t0, -48($fp)
	# ifFalse %t9 goto .L518   ; line 782
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_remove.L518
	# return -1   ; line 782
	li      $v0, -1
	b       __rt_remove.ret
__rt_remove.L518:
	# param %fd : int   ; line 783
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t10 = call @sys_close, 1   ; line 783
	lw      $a0, 0($sp)
	jal     __rt_sys_close
	sw      $v0, -52($fp)
	# %t11 = 513   ; line 784
	li      $t0, 513
	sw      $t0, -56($fp)
	# %t12 = 420   ; line 784
	li      $t0, 420
	sw      $t0, -60($fp)
	# param %name : str   ; line 784
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %t11 : int   ; line 784
	lw      $t0, -56($fp)
	sw      $t0, 4($sp)
	# param %t12 : int   ; line 784
	lw      $t0, -60($fp)
	sw      $t0, 8($sp)
	# %t13 = call @sys_open, 3   ; line 784
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_open
	sw      $v0, -64($fp)
	# %fd = %t13   ; line 784
	lw      $t0, -64($fp)
	sw      $t0, -16($fp)
	# %t14 = %fd >= 0   ; line 785
	lw      $t0, -16($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L520   ; line 785
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_remove.L520
	# param %fd : int   ; line 785
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t15 = call @sys_close, 1   ; line 785
	lw      $a0, 0($sp)
	jal     __rt_sys_close
	sw      $v0, -72($fp)
__rt_remove.L520:
	# param %name : str   ; line 786
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t16 = call @strlen, 1   ; line 786
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -76($fp)
	# %k = %t16   ; line 786
	lw      $t0, -76($fp)
	sw      $t0, -24($fp)
	# %t17 = %k >= 256   ; line 787
	lw      $t0, -24($fp)
	slti    $t0, $t0, 256
	xori    $t0, $t0, 1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L522   ; line 787
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_remove.L522
	# return 0   ; line 787
	move    $v0, $zero
	b       __rt_remove.ret
__rt_remove.L522:
	# %i = 0   ; line 788
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_remove.L523:
	# %t18 = %i < 7   ; line 789
	lw      $t0, -20($fp)
	slti    $t0, $t0, 7
	sw      $t0, -84($fp)
	# ifFalse %t18 goto .L525   ; line 789
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_remove.L525
	# %t19 = addr @rm_used   ; line 789
	la      $t0, __rtg_rm_used
	sw      $t0, -88($fp)
	# %t20 = %i * 4   ; line 789
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t21 = %t19 + %t20   ; line 789
	lw      $t0, -88($fp)
	lw      $t1, -92($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -96($fp)
	# %t22 = load.w %t21   ; line 789
	lw      $t0, -96($fp)
	lw      $t1, 0($t0)
	sw      $t1, -100($fp)
	# ifFalse %t22 goto .L525   ; line 789
	lw      $t0, -100($fp)
	beq     $t0, $zero, __rt_remove.L525
	# %t23 = %i   ; line 789
	lw      $t0, -20($fp)
	sw      $t0, -104($fp)
	# %t24 = %t23 + 1   ; line 789
	lw      $t0, -104($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# %i = %t24   ; line 789
	lw      $t0, -108($fp)
	sw      $t0, -20($fp)
	# goto .L523   ; line 789
	b       __rt_remove.L523
__rt_remove.L525:
	# %t25 = addr @rm_used   ; line 790
	la      $t0, __rtg_rm_used
	sw      $t0, -112($fp)
	# %t26 = %i * 4   ; line 790
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -116($fp)
	# %t27 = %t25 + %t26   ; line 790
	lw      $t0, -112($fp)
	lw      $t1, -116($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -120($fp)
	# store.w %t27, 1   ; line 790
	lw      $t0, -120($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %k = 0   ; line 791
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_remove.L526:
	# %t28 = %name + %k   ; line 791
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -124($fp)
	# %t29 = load.b %t28   ; line 791
	lw      $t0, -124($fp)
	lb      $t1, 0($t0)
	sw      $t1, -128($fp)
	# ifFalse %t29 goto .L529   ; line 791
	lw      $t0, -128($fp)
	beq     $t0, $zero, __rt_remove.L529
	# %t30 = addr @rm_names   ; line 791
	la      $t0, __rtg_rm_names
	sw      $t0, -132($fp)
	# %t31 = %i * 256   ; line 791
	lw      $t0, -20($fp)
	li      $t1, 256
	mul     $t0, $t0, $t1
	sw      $t0, -136($fp)
	# %t32 = %t31 + %k   ; line 791
	lw      $t0, -136($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -140($fp)
	# %t33 = %t30 + %t32   ; line 791
	lw      $t0, -132($fp)
	lw      $t1, -140($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -144($fp)
	# %t34 = %name + %k   ; line 791
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -148($fp)
	# %t35 = load.b %t34   ; line 791
	lw      $t0, -148($fp)
	lb      $t1, 0($t0)
	sw      $t1, -152($fp)
	# store.b %t33, %t35   ; line 791
	lw      $t0, -144($fp)
	lw      $t1, -152($fp)
	sb      $t1, 0($t0)
	# %t36 = sext.b %t35   ; line 791
	lw      $t0, -152($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -156($fp)
	# %t37 = %k   ; line 791
	lw      $t0, -24($fp)
	sw      $t0, -160($fp)
	# %t38 = %t37 + 1   ; line 791
	lw      $t0, -160($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -164($fp)
	# %k = %t38   ; line 791
	lw      $t0, -164($fp)
	sw      $t0, -24($fp)
	# goto .L526   ; line 791
	b       __rt_remove.L526
__rt_remove.L529:
	# %t39 = addr @rm_names   ; line 792
	la      $t0, __rtg_rm_names
	sw      $t0, -168($fp)
	# %t40 = %i * 256   ; line 792
	lw      $t0, -20($fp)
	li      $t1, 256
	mul     $t0, $t0, $t1
	sw      $t0, -172($fp)
	# %t41 = %t40 + %k   ; line 792
	lw      $t0, -172($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -176($fp)
	# %t42 = %t39 + %t41   ; line 792
	lw      $t0, -168($fp)
	lw      $t1, -176($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -180($fp)
	# store.b %t42, 0   ; line 792
	lw      $t0, -180($fp)
	sb      $zero, 0($t0)
	# return 0   ; line 793
	move    $v0, $zero
__rt_remove.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_feof
	.text
# ---------------------------------------------------------------
# function feof (line 796), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_feof
__rt_feof:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %f : ptr   ; line 797
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t1 = call @file_of, 1   ; line 797
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -16($fp)
	# %f = %t1   ; line 797
	lw      $t0, -16($fp)
	sw      $t0, -12($fp)
	# %t2 = %f == 0   ; line 798
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L531   ; line 798
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_feof.L531
	# return 1   ; line 798
	li      $v0, 1
	b       __rt_feof.ret
__rt_feof.L531:
	# %t3 = %f + 12   ; line 799
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 799
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# return %t4   ; line 799
	lw      $v0, -28($fp)
__rt_feof.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fgetc
	.text
# ---------------------------------------------------------------
# function fgetc (line 802), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%g : ptr
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fgetc
__rt_fgetc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %f : ptr   ; line 804
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t2 = call @file_of, 1   ; line 804
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -20($fp)
	# %g = %t2   ; line 804
	lw      $t0, -20($fp)
	sw      $t0, -16($fp)
	# %t3 = %g == 0   ; line 805
	lw      $t0, -16($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L533   ; line 805
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_fgetc.L533
	# %t4 = addr @rt_stdin   ; line 805
	la      $t0, __rtg_rt_stdin
	sw      $t0, -28($fp)
	# %g = %t4   ; line 805
	lw      $t0, -28($fp)
	sw      $t0, -16($fp)
__rt_fgetc.L533:
	# param %g : ptr   ; line 806
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t5 = call @f_getc, 1   ; line 806
	lw      $a0, 0($sp)
	jal     __rt_f_getc
	sw      $v0, -32($fp)
	# return %t5   ; line 806
	lw      $v0, -32($fp)
__rt_fgetc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_getchar
	.text
# ---------------------------------------------------------------
# function getchar (line 809), returns int
# frame 32 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%t0 : ptr
#   -16($fp)	%t1 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_getchar
__rt_getchar:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -32
	# %t0 = addr @rt_stdin   ; line 810
	la      $t0, __rtg_rt_stdin
	sw      $t0, -12($fp)
	# param %t0 : ptr   ; line 810
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t1 = call @f_getc, 1   ; line 810
	lw      $a0, 0($sp)
	jal     __rt_f_getc
	sw      $v0, -16($fp)
	# return %t1   ; line 810
	lw      $v0, -16($fp)
__rt_getchar.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fgets
	.text
# ---------------------------------------------------------------
# function fgets (line 815), returns str
# frame 112 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   8($fp)	param f (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%n : int
#   -20($fp)	%f : ptr
#   -24($fp)	%g : ptr
#   -28($fp)	%i : int
#   -32($fp)	%c : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : str
#   -72($fp)	%t15 : char
#   -76($fp)	%t16 : char
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fgets
__rt_fgets:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -112
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param n : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param f : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param %f : ptr   ; line 818
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# %t6 = call @file_of, 1   ; line 818
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -36($fp)
	# %g = %t6   ; line 818
	lw      $t0, -36($fp)
	sw      $t0, -24($fp)
	# %t7 = %g == 0   ; line 819
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L535   ; line 819
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_fgets.L535
	# %t8 = addr @rt_stdin   ; line 819
	la      $t0, __rtg_rt_stdin
	sw      $t0, -44($fp)
	# %g = %t8   ; line 819
	lw      $t0, -44($fp)
	sw      $t0, -24($fp)
__rt_fgets.L535:
	# %t9 = %n <= 0   ; line 820
	lw      $t0, -16($fp)
	slt     $t0, $zero, $t0
	xori    $t0, $t0, 1
	sw      $t0, -48($fp)
	# ifFalse %t9 goto .L537   ; line 820
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_fgets.L537
	# return 0   ; line 820
	move    $v0, $zero
	b       __rt_fgets.ret
__rt_fgets.L537:
	# %i = 0   ; line 821
	move    $t0, $zero
	sw      $t0, -28($fp)
__rt_fgets.L538:
	# %t10 = %n - 1   ; line 822
	lw      $t0, -16($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -52($fp)
	# %t11 = %i < %t10   ; line 822
	lw      $t0, -28($fp)
	lw      $t1, -52($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L540   ; line 822
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_fgets.L540
	# param %g : ptr   ; line 823
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t12 = call @f_getc, 1   ; line 823
	lw      $a0, 0($sp)
	jal     __rt_f_getc
	sw      $v0, -60($fp)
	# %c = %t12   ; line 823
	lw      $t0, -60($fp)
	sw      $t0, -32($fp)
	# %t13 = %c < 0   ; line 824
	lw      $t0, -32($fp)
	slti    $t0, $t0, 0
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L542   ; line 824
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_fgets.L542
	# goto .L540   ; line 824
	b       __rt_fgets.L540
__rt_fgets.L542:
	# %t14 = %s + %i   ; line 825
	lw      $t0, -12($fp)
	lw      $t1, -28($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = sext.b %c   ; line 825
	lw      $t0, -32($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -72($fp)
	# store.b %t14, %t15   ; line 825
	lw      $t0, -68($fp)
	lw      $t1, -72($fp)
	sb      $t1, 0($t0)
	# %t16 = sext.b %t15   ; line 825
	lw      $t0, -72($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -76($fp)
	# %t17 = %i   ; line 826
	lw      $t0, -28($fp)
	sw      $t0, -80($fp)
	# %t18 = %t17 + 1   ; line 826
	lw      $t0, -80($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# %i = %t18   ; line 826
	lw      $t0, -84($fp)
	sw      $t0, -28($fp)
	# %t19 = %c == 10   ; line 827
	lw      $t0, -32($fp)
	xori    $t0, $t0, 10
	sltiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L544   ; line 827
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_fgets.L544
	# goto .L540   ; line 827
	b       __rt_fgets.L540
__rt_fgets.L544:
	# goto .L538   ; line 827
	b       __rt_fgets.L538
__rt_fgets.L540:
	# %t20 = %i == 0   ; line 829
	lw      $t0, -28($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -92($fp)
	# ifFalse %t20 goto .L546   ; line 829
	lw      $t0, -92($fp)
	beq     $t0, $zero, __rt_fgets.L546
	# return 0   ; line 829
	move    $v0, $zero
	b       __rt_fgets.ret
__rt_fgets.L546:
	# %t21 = %s + %i   ; line 830
	lw      $t0, -12($fp)
	lw      $t1, -28($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -96($fp)
	# store.b %t21, 0   ; line 830
	lw      $t0, -96($fp)
	sb      $zero, 0($t0)
	# return %s   ; line 831
	lw      $v0, -12($fp)
__rt_fgets.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_file_fd
	.text
# ---------------------------------------------------------------
# function file_fd (line 835), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_file_fd
__rt_file_fd:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %f : ptr   ; line 836
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t1 = call @file_of, 1   ; line 836
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -16($fp)
	# %f = %t1   ; line 836
	lw      $t0, -16($fp)
	sw      $t0, -12($fp)
	# %t2 = %f == 0   ; line 837
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L548   ; line 837
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_file_fd.L548
	# return 1   ; line 837
	li      $v0, 1
	b       __rt_file_fd.ret
__rt_file_fd.L548:
	# %t3 = %f + 4   ; line 838
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 838
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# return %t4   ; line 838
	lw      $v0, -28($fp)
__rt_file_fd.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fputc
	.text
# ---------------------------------------------------------------
# function fputc (line 841), returns int
# frame 80 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   4($fp)	param f (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	local b : char [4] (4 bytes)
#   -20($fp)	%c : int
#   -24($fp)	%f : ptr
#   -28($fp)	%t2 : ptr
#   -32($fp)	%t3 : str
#   -36($fp)	%t4 : char
#   -40($fp)	%t5 : char
#   -44($fp)	%t6 : int
#   -48($fp)	%t7 : ptr
#   -52($fp)	%t8 : int
#   -56($fp)	%t9 : int
#   -60($fp)	%t10 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fputc
__rt_fputc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -80
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -20($fp)
	# param f : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -24($fp)
	# %t2 = addr b   ; line 843
	addiu   $t0, $fp, -16
	sw      $t0, -28($fp)
	# %t3 = %t2 + 0   ; line 843
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -32($fp)
	# %t4 = sext.b %c   ; line 843
	lw      $t0, -20($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -36($fp)
	# store.b %t3, %t4   ; line 843
	lw      $t0, -32($fp)
	lw      $t1, -36($fp)
	sb      $t1, 0($t0)
	# %t5 = sext.b %t4   ; line 843
	lw      $t0, -36($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -40($fp)
	# param %f : ptr   ; line 844
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t6 = call @file_fd, 1   ; line 844
	lw      $a0, 0($sp)
	jal     __rt_file_fd
	sw      $v0, -44($fp)
	# %t7 = addr b   ; line 844
	addiu   $t0, $fp, -16
	sw      $t0, -48($fp)
	# %t8 = 1   ; line 844
	li      $t0, 1
	sw      $t0, -52($fp)
	# param %t6 : int   ; line 844
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# param %t7 : str   ; line 844
	lw      $t0, -48($fp)
	sw      $t0, 4($sp)
	# param %t8 : int   ; line 844
	lw      $t0, -52($fp)
	sw      $t0, 8($sp)
	# %t9 = call @sys_write, 3   ; line 844
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -56($fp)
	# %t10 = %c & 255   ; line 845
	lw      $t0, -20($fp)
	andi    $t0, $t0, 255
	sw      $t0, -60($fp)
	# return %t10   ; line 845
	lw      $v0, -60($fp)
__rt_fputc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_fputs
	.text
# ---------------------------------------------------------------
# function fputs (line 848), returns int
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   4($fp)	param f (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%f : ptr
#   -20($fp)	%n : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_fputs
__rt_fputs:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param f : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param %s : str   ; line 850
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t3 = call @strlen, 1   ; line 850
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -24($fp)
	# %n = %t3   ; line 850
	lw      $t0, -24($fp)
	sw      $t0, -20($fp)
	# param %f : ptr   ; line 851
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t4 = call @file_fd, 1   ; line 851
	lw      $a0, 0($sp)
	jal     __rt_file_fd
	sw      $v0, -28($fp)
	# param %t4 : int   ; line 851
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %s : str   ; line 851
	lw      $t0, -12($fp)
	sw      $t0, 4($sp)
	# param %n : int   ; line 851
	lw      $t0, -20($fp)
	sw      $t0, 8($sp)
	# %t5 = call @sys_write, 3   ; line 851
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -32($fp)
	# return %n   ; line 852
	lw      $v0, -20($fp)
__rt_fputs.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_putchar
	.text
# ---------------------------------------------------------------
# function putchar (line 855), returns int
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	local b : char [4] (4 bytes)
#   -20($fp)	%c : int
#   -24($fp)	%t1 : ptr
#   -28($fp)	%t2 : str
#   -32($fp)	%t3 : char
#   -36($fp)	%t4 : char
#   -40($fp)	%t5 : int
#   -44($fp)	%t6 : ptr
#   -48($fp)	%t7 : int
#   -52($fp)	%t8 : int
#   -56($fp)	%t9 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_putchar
__rt_putchar:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -72
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -20($fp)
	# %t1 = addr b   ; line 857
	addiu   $t0, $fp, -16
	sw      $t0, -24($fp)
	# %t2 = %t1 + 0   ; line 857
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -28($fp)
	# %t3 = sext.b %c   ; line 857
	lw      $t0, -20($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -32($fp)
	# store.b %t2, %t3   ; line 857
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	sb      $t1, 0($t0)
	# %t4 = sext.b %t3   ; line 857
	lw      $t0, -32($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -36($fp)
	# %t5 = 1   ; line 858
	li      $t0, 1
	sw      $t0, -40($fp)
	# %t6 = addr b   ; line 858
	addiu   $t0, $fp, -16
	sw      $t0, -44($fp)
	# %t7 = 1   ; line 858
	li      $t0, 1
	sw      $t0, -48($fp)
	# param %t5 : int   ; line 858
	lw      $t0, -40($fp)
	sw      $t0, 0($sp)
	# param %t6 : str   ; line 858
	lw      $t0, -44($fp)
	sw      $t0, 4($sp)
	# param %t7 : int   ; line 858
	lw      $t0, -48($fp)
	sw      $t0, 8($sp)
	# %t8 = call @sys_write, 3   ; line 858
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -52($fp)
	# %t9 = %c & 255   ; line 859
	lw      $t0, -20($fp)
	andi    $t0, $t0, 255
	sw      $t0, -56($fp)
	# return %t9   ; line 859
	lw      $v0, -56($fp)
__rt_putchar.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_puts
	.text
# ---------------------------------------------------------------
# function puts (line 862), returns int
# frame 64 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%n : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_puts
__rt_puts:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	sw      $a0, 0($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param %s : str   ; line 864
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t2 = call @strlen, 1   ; line 864
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -20($fp)
	# %n = %t2   ; line 864
	lw      $t0, -20($fp)
	sw      $t0, -16($fp)
	# %t3 = 1   ; line 865
	li      $t0, 1
	sw      $t0, -24($fp)
	# param %t3 : int   ; line 865
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %s : str   ; line 865
	lw      $t0, -12($fp)
	sw      $t0, 4($sp)
	# param %n : int   ; line 865
	lw      $t0, -16($fp)
	sw      $t0, 8($sp)
	# %t4 = call @sys_write, 3   ; line 865
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -28($fp)
	# %t5 = 1   ; line 866
	li      $t0, 1
	sw      $t0, -32($fp)
	# %t6 = addr @.str1   ; line 866
	la      $t0, __rtd.str1
	sw      $t0, -36($fp)
	# %t7 = 1   ; line 866
	li      $t0, 1
	sw      $t0, -40($fp)
	# param %t5 : int   ; line 866
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# param %t6 : str   ; line 866
	lw      $t0, -36($fp)
	sw      $t0, 4($sp)
	# param %t7 : int   ; line 866
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# %t8 = call @sys_write, 3   ; line 866
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_sys_write
	sw      $v0, -44($fp)
	# %t9 = %n + 1   ; line 867
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -48($fp)
	# return %t9   ; line 867
	lw      $v0, -48($fp)
__rt_puts.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vprintf
	.text
# ---------------------------------------------------------------
# function vprintf (line 873), returns int
# frame 64 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param ap (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%fmt : str
#   -16($fp)	%ap : ptr
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vprintf
__rt_vprintf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param ap : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t2 = addr @out_fd   ; line 874
	la      $t0, __rtg_out_fd
	sw      $t0, -20($fp)
	# store.w %t2, 1   ; line 874
	lw      $t0, -20($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t3 = addr @out_str   ; line 875
	la      $t0, __rtg_out_str
	sw      $t0, -24($fp)
	# store.w %t3, 0   ; line 875
	lw      $t0, -24($fp)
	sw      $zero, 0($t0)
	# %t4 = addr @out_count   ; line 876
	la      $t0, __rtg_out_count
	sw      $t0, -28($fp)
	# store.w %t4, 0   ; line 876
	lw      $t0, -28($fp)
	sw      $zero, 0($t0)
	# %t5 = addr @out_len   ; line 877
	la      $t0, __rtg_out_len
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 877
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 878
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 878
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# %t6 = call @vformat, 2   ; line 878
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vformat
	sw      $v0, -36($fp)
	# call @out_flush, 0   ; line 879
	jal     __rt_out_flush
	# %t7 = addr @out_count   ; line 880
	la      $t0, __rtg_out_count
	sw      $t0, -40($fp)
	# %t8 = load.w %t7   ; line 880
	lw      $t0, -40($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# return %t8   ; line 880
	lw      $v0, -44($fp)
__rt_vprintf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vfprintf
	.text
# ---------------------------------------------------------------
# function vfprintf (line 883), returns int
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   4($fp)	param fmt (str, arrives in $a1)
#   8($fp)	param ap (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%fmt : str
#   -20($fp)	%ap : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vfprintf
__rt_vfprintf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -72
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param fmt : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param ap : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %t3 = addr @out_fd   ; line 884
	la      $t0, __rtg_out_fd
	sw      $t0, -24($fp)
	# param %f : ptr   ; line 884
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t4 = call @file_fd, 1   ; line 884
	lw      $a0, 0($sp)
	jal     __rt_file_fd
	sw      $v0, -28($fp)
	# store.w %t3, %t4   ; line 884
	lw      $t0, -24($fp)
	lw      $t1, -28($fp)
	sw      $t1, 0($t0)
	# %t5 = addr @out_str   ; line 885
	la      $t0, __rtg_out_str
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 885
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# %t6 = addr @out_count   ; line 886
	la      $t0, __rtg_out_count
	sw      $t0, -36($fp)
	# store.w %t6, 0   ; line 886
	lw      $t0, -36($fp)
	sw      $zero, 0($t0)
	# %t7 = addr @out_len   ; line 887
	la      $t0, __rtg_out_len
	sw      $t0, -40($fp)
	# store.w %t7, 0   ; line 887
	lw      $t0, -40($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 888
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 888
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t8 = call @vformat, 2   ; line 888
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vformat
	sw      $v0, -44($fp)
	# call @out_flush, 0   ; line 889
	jal     __rt_out_flush
	# %t9 = addr @out_count   ; line 890
	la      $t0, __rtg_out_count
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 890
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# return %t10   ; line 890
	lw      $v0, -52($fp)
__rt_vfprintf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vsprintf
	.text
# ---------------------------------------------------------------
# function vsprintf (line 893), returns int
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param buf (str, arrives in $a0)
#   4($fp)	param fmt (str, arrives in $a1)
#   8($fp)	param ap (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%buf : str
#   -16($fp)	%fmt : str
#   -20($fp)	%ap : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vsprintf
__rt_vsprintf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -72
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param buf : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param fmt : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param ap : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %t3 = addr @out_str   ; line 894
	la      $t0, __rtg_out_str
	sw      $t0, -24($fp)
	# store.w %t3, %buf   ; line 894
	lw      $t0, -24($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
	# %t4 = addr @out_count   ; line 895
	la      $t0, __rtg_out_count
	sw      $t0, -28($fp)
	# store.w %t4, 0   ; line 895
	lw      $t0, -28($fp)
	sw      $zero, 0($t0)
	# %t5 = addr @out_len   ; line 896
	la      $t0, __rtg_out_len
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 896
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 897
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 897
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t6 = call @vformat, 2   ; line 897
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vformat
	sw      $v0, -36($fp)
	# %t7 = addr @out_str   ; line 898
	la      $t0, __rtg_out_str
	sw      $t0, -40($fp)
	# %t8 = load.w %t7   ; line 898
	lw      $t0, -40($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# store.b %t8, 0   ; line 898
	lw      $t0, -44($fp)
	sb      $zero, 0($t0)
	# %t9 = addr @out_str   ; line 899
	la      $t0, __rtg_out_str
	sw      $t0, -48($fp)
	# store.w %t9, 0   ; line 899
	lw      $t0, -48($fp)
	sw      $zero, 0($t0)
	# %t10 = addr @out_count   ; line 900
	la      $t0, __rtg_out_count
	sw      $t0, -52($fp)
	# %t11 = load.w %t10   ; line 900
	lw      $t0, -52($fp)
	lw      $t1, 0($t0)
	sw      $t1, -56($fp)
	# return %t11   ; line 900
	lw      $v0, -56($fp)
__rt_vsprintf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_acc_clear
	.text
# ---------------------------------------------------------------
# function acc_clear (line 913), returns void
# frame 64 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%t0 : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_acc_clear
__rt_acc_clear:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	# %t0 = addr @acc   ; line 914
	la      $t0, __rtg_acc
	sw      $t0, -12($fp)
	# %t1 = %t0 + 0   ; line 914
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -16($fp)
	# store.w %t1, 0   ; line 914
	lw      $t0, -16($fp)
	sw      $zero, 0($t0)
	# %t2 = addr @acc   ; line 914
	la      $t0, __rtg_acc
	sw      $t0, -20($fp)
	# %t3 = %t2 + 4   ; line 914
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -24($fp)
	# store.w %t3, 0   ; line 914
	lw      $t0, -24($fp)
	sw      $zero, 0($t0)
	# %t4 = addr @acc   ; line 914
	la      $t0, __rtg_acc
	sw      $t0, -28($fp)
	# %t5 = %t4 + 8   ; line 914
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 914
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# %t6 = addr @acc   ; line 914
	la      $t0, __rtg_acc
	sw      $t0, -36($fp)
	# %t7 = %t6 + 12   ; line 914
	lw      $t0, -36($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -40($fp)
	# store.w %t7, 0   ; line 914
	lw      $t0, -40($fp)
	sw      $zero, 0($t0)
	# %t8 = addr @acc_ovf   ; line 915
	la      $t0, __rtg_acc_ovf
	sw      $t0, -44($fp)
	# store.w %t8, 0   ; line 915
	lw      $t0, -44($fp)
	sw      $zero, 0($t0)
	# return
__rt_acc_clear.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_acc_digit
	.text
# ---------------------------------------------------------------
# function acc_digit (line 918), returns void
# frame 104 bytes ($fp = $sp at entry):
#   0($fp)	param d (int, arrives in $a0)
#   4($fp)	param base (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : int
#   -16($fp)	%base : int
#   -20($fp)	%i : int
#   -24($fp)	%t : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_acc_digit
__rt_acc_digit:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -104
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param d : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param base : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %i = 0   ; line 920
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_acc_digit.L549:
	# %t4 = %i < 4   ; line 920
	lw      $t0, -20($fp)
	slti    $t0, $t0, 4
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L552   ; line 920
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_acc_digit.L552
	# %t5 = addr @acc   ; line 921
	la      $t0, __rtg_acc
	sw      $t0, -32($fp)
	# %t6 = %i * 4   ; line 921
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = %t5 + %t6   ; line 921
	lw      $t0, -32($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -40($fp)
	# %t8 = load.w %t7   ; line 921
	lw      $t0, -40($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# %t9 = %t8 * %base   ; line 921
	lw      $t0, -44($fp)
	lw      $t1, -16($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = %t9 + %d   ; line 921
	lw      $t0, -48($fp)
	lw      $t1, -12($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %t = %t10   ; line 921
	lw      $t0, -52($fp)
	sw      $t0, -24($fp)
	# %t11 = addr @acc   ; line 922
	la      $t0, __rtg_acc
	sw      $t0, -56($fp)
	# %t12 = %i * 4   ; line 922
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t13 = %t11 + %t12   ; line 922
	lw      $t0, -56($fp)
	lw      $t1, -60($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -64($fp)
	# %t14 = %t & 65535   ; line 922
	lw      $t0, -24($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -68($fp)
	# store.w %t13, %t14   ; line 922
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	sw      $t1, 0($t0)
	# %t15 = %t >> 16   ; line 923
	lw      $t0, -24($fp)
	sra     $t0, $t0, 16
	sw      $t0, -72($fp)
	# %d = %t15   ; line 923
	lw      $t0, -72($fp)
	sw      $t0, -12($fp)
	# %t16 = %i   ; line 920
	lw      $t0, -20($fp)
	sw      $t0, -76($fp)
	# %t17 = %t16 + 1   ; line 920
	lw      $t0, -76($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# %i = %t17   ; line 920
	lw      $t0, -80($fp)
	sw      $t0, -20($fp)
	# goto .L549   ; line 920
	b       __rt_acc_digit.L549
__rt_acc_digit.L552:
	# ifFalse %d goto .L554   ; line 925
	lw      $t0, -12($fp)
	beq     $t0, $zero, __rt_acc_digit.L554
	# %t18 = addr @acc_ovf   ; line 925
	la      $t0, __rtg_acc_ovf
	sw      $t0, -84($fp)
	# store.w %t18, 1   ; line 925
	lw      $t0, -84($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_acc_digit.L554:
	# return
__rt_acc_digit.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_acc_value
	.text
# ---------------------------------------------------------------
# function acc_value (line 928), returns int
# frame 184 bytes ($fp = $sp at entry):
#   0($fp)	param neg (int, arrives in $a0)
#   4($fp)	param sgn (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%neg : int
#   -16($fp)	%sgn : int
#   -20($fp)	%v : int
#   -24($fp)	%big : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : ptr
#   -84($fp)	%t18 : ptr
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : ptr
#   -120($fp)	%t27 : ptr
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : ptr
#   -136($fp)	%t31 : ptr
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : ptr
#   -152($fp)	%t35 : ptr
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_acc_value
__rt_acc_value:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -184
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param neg : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param sgn : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t5 = addr @acc_ovf   ; line 930
	la      $t0, __rtg_acc_ovf
	sw      $t0, -32($fp)
	# %t6 = load.w %t5   ; line 930
	lw      $t0, -32($fp)
	lw      $t1, 0($t0)
	sw      $t1, -36($fp)
	# if %t6 goto .L555   ; line 930
	lw      $t0, -36($fp)
	bne     $t0, $zero, __rt_acc_value.L555
	# %t7 = addr @acc   ; line 930
	la      $t0, __rtg_acc
	sw      $t0, -40($fp)
	# %t8 = %t7 + 8   ; line 930
	lw      $t0, -40($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -44($fp)
	# %t9 = load.w %t8   ; line 930
	lw      $t0, -44($fp)
	lw      $t1, 0($t0)
	sw      $t1, -48($fp)
	# if %t9 goto .L555   ; line 930
	lw      $t0, -48($fp)
	bne     $t0, $zero, __rt_acc_value.L555
	# %t10 = addr @acc   ; line 930
	la      $t0, __rtg_acc
	sw      $t0, -52($fp)
	# %t11 = %t10 + 12   ; line 930
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 12
	sw      $t0, -56($fp)
	# %t12 = load.w %t11   ; line 930
	lw      $t0, -56($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# ifFalse %t12 goto .L556   ; line 930
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_acc_value.L556
__rt_acc_value.L555:
	# %t4 = 1   ; line 930
	li      $t0, 1
	sw      $t0, -28($fp)
	# goto .L557   ; line 930
	b       __rt_acc_value.L557
__rt_acc_value.L556:
	# %t4 = 0   ; line 930
	move    $t0, $zero
	sw      $t0, -28($fp)
__rt_acc_value.L557:
	# %big = %t4   ; line 930
	lw      $t0, -28($fp)
	sw      $t0, -24($fp)
	# %t13 = addr @acc   ; line 931
	la      $t0, __rtg_acc
	sw      $t0, -64($fp)
	# %t14 = %t13 + 4   ; line 931
	lw      $t0, -64($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 931
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t16 = %t15 << 16   ; line 931
	lw      $t0, -72($fp)
	sll     $t0, $t0, 16
	sw      $t0, -76($fp)
	# %t17 = addr @acc   ; line 931
	la      $t0, __rtg_acc
	sw      $t0, -80($fp)
	# %t18 = %t17 + 0   ; line 931
	lw      $t0, -80($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -84($fp)
	# %t19 = load.w %t18   ; line 931
	lw      $t0, -84($fp)
	lw      $t1, 0($t0)
	sw      $t1, -88($fp)
	# %t20 = %t16 | %t19   ; line 931
	lw      $t0, -76($fp)
	lw      $t1, -88($fp)
	or      $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %v = %t20   ; line 931
	lw      $t0, -92($fp)
	sw      $t0, -20($fp)
	# if %sgn goto .L559   ; line 932
	lw      $t0, -16($fp)
	bne     $t0, $zero, __rt_acc_value.L559
	# ifFalse %big goto .L561   ; line 933
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_acc_value.L561
	# return -1   ; line 933
	li      $v0, -1
	b       __rt_acc_value.ret
__rt_acc_value.L561:
	# ifFalse %neg goto .L563   ; line 934
	lw      $t0, -12($fp)
	beq     $t0, $zero, __rt_acc_value.L563
	# %t21 = - %v   ; line 934
	lw      $t0, -20($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -96($fp)
	# return %t21   ; line 934
	lw      $v0, -96($fp)
	b       __rt_acc_value.ret
__rt_acc_value.L563:
	# return %v   ; line 935
	lw      $v0, -20($fp)
	b       __rt_acc_value.ret
__rt_acc_value.L559:
	# if %neg goto .L565   ; line 937
	lw      $t0, -12($fp)
	bne     $t0, $zero, __rt_acc_value.L565
	# if %big goto .L566   ; line 938
	lw      $t0, -24($fp)
	bne     $t0, $zero, __rt_acc_value.L566
	# %t22 = addr @acc   ; line 938
	la      $t0, __rtg_acc
	sw      $t0, -100($fp)
	# %t23 = %t22 + 4   ; line 938
	lw      $t0, -100($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -104($fp)
	# %t24 = load.w %t23   ; line 938
	lw      $t0, -104($fp)
	lw      $t1, 0($t0)
	sw      $t1, -108($fp)
	# %t25 = %t24 >= 32768   ; line 938
	lw      $t0, -108($fp)
	li      $t1, 32768
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -112($fp)
	# ifFalse %t25 goto .L567   ; line 938
	lw      $t0, -112($fp)
	beq     $t0, $zero, __rt_acc_value.L567
__rt_acc_value.L566:
	# return 2147483647   ; line 938
	li      $v0, 2147483647
	b       __rt_acc_value.ret
__rt_acc_value.L567:
	# return %v   ; line 939
	lw      $v0, -20($fp)
	b       __rt_acc_value.ret
__rt_acc_value.L565:
	# if %big goto .L568   ; line 941
	lw      $t0, -24($fp)
	bne     $t0, $zero, __rt_acc_value.L568
	# %t26 = addr @acc   ; line 941
	la      $t0, __rtg_acc
	sw      $t0, -116($fp)
	# %t27 = %t26 + 4   ; line 941
	lw      $t0, -116($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -120($fp)
	# %t28 = load.w %t27   ; line 941
	lw      $t0, -120($fp)
	lw      $t1, 0($t0)
	sw      $t1, -124($fp)
	# %t29 = %t28 > 32768   ; line 941
	lw      $t0, -124($fp)
	li      $t1, 32768
	slt     $t0, $t1, $t0
	sw      $t0, -128($fp)
	# if %t29 goto .L568   ; line 941
	lw      $t0, -128($fp)
	bne     $t0, $zero, __rt_acc_value.L568
	# %t30 = addr @acc   ; line 941
	la      $t0, __rtg_acc
	sw      $t0, -132($fp)
	# %t31 = %t30 + 4   ; line 941
	lw      $t0, -132($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -136($fp)
	# %t32 = load.w %t31   ; line 941
	lw      $t0, -136($fp)
	lw      $t1, 0($t0)
	sw      $t1, -140($fp)
	# %t33 = %t32 == 32768   ; line 941
	lw      $t0, -140($fp)
	xori    $t0, $t0, 32768
	sltiu   $t0, $t0, 1
	sw      $t0, -144($fp)
	# ifFalse %t33 goto .L569   ; line 941
	lw      $t0, -144($fp)
	beq     $t0, $zero, __rt_acc_value.L569
	# %t34 = addr @acc   ; line 941
	la      $t0, __rtg_acc
	sw      $t0, -148($fp)
	# %t35 = %t34 + 0   ; line 941
	lw      $t0, -148($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -152($fp)
	# %t36 = load.w %t35   ; line 941
	lw      $t0, -152($fp)
	lw      $t1, 0($t0)
	sw      $t1, -156($fp)
	# %t37 = %t36 != 0   ; line 941
	lw      $t0, -156($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -160($fp)
	# ifFalse %t37 goto .L569   ; line 941
	lw      $t0, -160($fp)
	beq     $t0, $zero, __rt_acc_value.L569
__rt_acc_value.L568:
	# return 2147483648   ; line 942
	li      $v0, -2147483648
	b       __rt_acc_value.ret
__rt_acc_value.L569:
	# %t38 = - %v   ; line 943
	lw      $t0, -20($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -164($fp)
	# return %t38   ; line 943
	lw      $v0, -164($fp)
__rt_acc_value.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_digit_val
	.text
# ---------------------------------------------------------------
# function digit_val (line 947), returns int
# frame 88 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   4($fp)	param base (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%base : int
#   -20($fp)	%d : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_digit_val
__rt_digit_val:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -88
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param base : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %d = -1   ; line 949
	li      $t0, -1
	sw      $t0, -20($fp)
	# %t3 = %c >= 48   ; line 950
	lw      $t0, -12($fp)
	slti    $t0, $t0, 48
	xori    $t0, $t0, 1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L571   ; line 950
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_digit_val.L571
	# %t4 = %c <= 57   ; line 950
	lw      $t0, -12($fp)
	li      $t1, 57
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L571   ; line 950
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_digit_val.L571
	# %t5 = %c - 48   ; line 950
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -32($fp)
	# %d = %t5   ; line 950
	lw      $t0, -32($fp)
	sw      $t0, -20($fp)
	# goto .L572   ; line 950
	b       __rt_digit_val.L572
__rt_digit_val.L571:
	# %t6 = %c >= 97   ; line 951
	lw      $t0, -12($fp)
	slti    $t0, $t0, 97
	xori    $t0, $t0, 1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L574   ; line 951
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_digit_val.L574
	# %t7 = %c <= 102   ; line 951
	lw      $t0, -12($fp)
	li      $t1, 102
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L574   ; line 951
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_digit_val.L574
	# %t8 = %c - 97   ; line 951
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -97
	sw      $t0, -44($fp)
	# %t9 = %t8 + 10   ; line 951
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 10
	sw      $t0, -48($fp)
	# %d = %t9   ; line 951
	lw      $t0, -48($fp)
	sw      $t0, -20($fp)
	# goto .L575   ; line 951
	b       __rt_digit_val.L575
__rt_digit_val.L574:
	# %t10 = %c >= 65   ; line 952
	lw      $t0, -12($fp)
	slti    $t0, $t0, 65
	xori    $t0, $t0, 1
	sw      $t0, -52($fp)
	# ifFalse %t10 goto .L577   ; line 952
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_digit_val.L577
	# %t11 = %c <= 70   ; line 952
	lw      $t0, -12($fp)
	li      $t1, 70
	slt     $t0, $t1, $t0
	xori    $t0, $t0, 1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L577   ; line 952
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_digit_val.L577
	# %t12 = %c - 65   ; line 952
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -65
	sw      $t0, -60($fp)
	# %t13 = %t12 + 10   ; line 952
	lw      $t0, -60($fp)
	addiu   $t0, $t0, 10
	sw      $t0, -64($fp)
	# %d = %t13   ; line 952
	lw      $t0, -64($fp)
	sw      $t0, -20($fp)
__rt_digit_val.L577:
__rt_digit_val.L575:
__rt_digit_val.L572:
	# %t14 = %d >= %base   ; line 953
	lw      $t0, -20($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L579   ; line 953
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_digit_val.L579
	# return -1   ; line 953
	li      $v0, -1
	b       __rt_digit_val.ret
__rt_digit_val.L579:
	# return %d   ; line 954
	lw      $v0, -20($fp)
__rt_digit_val.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_atoi
	.text
# ---------------------------------------------------------------
# function atoi (line 957), returns int
# frame 144 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%i : int
#   -20($fp)	%neg : int
#   -24($fp)	%d : int
#   -28($fp)	%t4 : str
#   -32($fp)	%t5 : char
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : char
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : str
#   -64($fp)	%t13 : char
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : str
#   -76($fp)	%t16 : char
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : str
#   -96($fp)	%t21 : char
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_atoi
__rt_atoi:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -144
	sw      $a0, 0($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %i = 0   ; line 959
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_atoi.L580:
	# %t4 = %s + %i   ; line 960
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -28($fp)
	# %t5 = load.b %t4   ; line 960
	lw      $t0, -28($fp)
	lb      $t1, 0($t0)
	sw      $t1, -32($fp)
	# param %t5 : int   ; line 960
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# %t6 = call @is_space, 1   ; line 960
	lw      $a0, 0($sp)
	jal     __rt_is_space
	sw      $v0, -36($fp)
	# ifFalse %t6 goto .L582   ; line 960
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_atoi.L582
	# %t7 = %i   ; line 960
	lw      $t0, -16($fp)
	sw      $t0, -40($fp)
	# %t8 = %t7 + 1   ; line 960
	lw      $t0, -40($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# %i = %t8   ; line 960
	lw      $t0, -44($fp)
	sw      $t0, -16($fp)
	# goto .L580   ; line 960
	b       __rt_atoi.L580
__rt_atoi.L582:
	# %neg = 0   ; line 961
	move    $t0, $zero
	sw      $t0, -20($fp)
	# %t9 = %s + %i   ; line 962
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.b %t9   ; line 962
	lw      $t0, -48($fp)
	lb      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 == 43   ; line 962
	lw      $t0, -52($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# if %t11 goto .L583   ; line 962
	lw      $t0, -56($fp)
	bne     $t0, $zero, __rt_atoi.L583
	# %t12 = %s + %i   ; line 962
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t13 = load.b %t12   ; line 962
	lw      $t0, -60($fp)
	lb      $t1, 0($t0)
	sw      $t1, -64($fp)
	# %t14 = %t13 == 45   ; line 962
	lw      $t0, -64($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L584   ; line 962
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_atoi.L584
__rt_atoi.L583:
	# %t15 = %s + %i   ; line 962
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = load.b %t15   ; line 962
	lw      $t0, -72($fp)
	lb      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t16 == 45   ; line 962
	lw      $t0, -76($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# %neg = %t17   ; line 962
	lw      $t0, -80($fp)
	sw      $t0, -20($fp)
	# %t18 = %i   ; line 962
	lw      $t0, -16($fp)
	sw      $t0, -84($fp)
	# %t19 = %t18 + 1   ; line 962
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %i = %t19   ; line 962
	lw      $t0, -88($fp)
	sw      $t0, -16($fp)
__rt_atoi.L584:
	# call @acc_clear, 0   ; line 963
	jal     __rt_acc_clear
__rt_atoi.L585:
	# %t20 = %s + %i   ; line 965
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t21 = load.b %t20   ; line 965
	lw      $t0, -92($fp)
	lb      $t1, 0($t0)
	sw      $t1, -96($fp)
	# %t22 = 10   ; line 965
	li      $t0, 10
	sw      $t0, -100($fp)
	# param %t21 : int   ; line 965
	lw      $t0, -96($fp)
	sw      $t0, 0($sp)
	# param %t22 : int   ; line 965
	lw      $t0, -100($fp)
	sw      $t0, 4($sp)
	# %t23 = call @digit_val, 2   ; line 965
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_digit_val
	sw      $v0, -104($fp)
	# %d = %t23   ; line 965
	lw      $t0, -104($fp)
	sw      $t0, -24($fp)
	# %t24 = %d < 0   ; line 966
	lw      $t0, -24($fp)
	slti    $t0, $t0, 0
	sw      $t0, -108($fp)
	# ifFalse %t24 goto .L589   ; line 966
	lw      $t0, -108($fp)
	beq     $t0, $zero, __rt_atoi.L589
	# goto .L587   ; line 966
	b       __rt_atoi.L587
__rt_atoi.L589:
	# %t25 = 10   ; line 967
	li      $t0, 10
	sw      $t0, -112($fp)
	# param %d : int   ; line 967
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %t25 : int   ; line 967
	lw      $t0, -112($fp)
	sw      $t0, 4($sp)
	# call @acc_digit, 2   ; line 967
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_acc_digit
	# %t26 = %i   ; line 968
	lw      $t0, -16($fp)
	sw      $t0, -116($fp)
	# %t27 = %t26 + 1   ; line 968
	lw      $t0, -116($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -120($fp)
	# %i = %t27   ; line 968
	lw      $t0, -120($fp)
	sw      $t0, -16($fp)
	# goto .L585   ; line 968
	b       __rt_atoi.L585
__rt_atoi.L587:
	# %t28 = 1   ; line 970
	li      $t0, 1
	sw      $t0, -124($fp)
	# param %neg : int   ; line 970
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# param %t28 : int   ; line 970
	lw      $t0, -124($fp)
	sw      $t0, 4($sp)
	# %t29 = call @acc_value, 2   ; line 970
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_acc_value
	sw      $v0, -128($fp)
	# return %t29   ; line 970
	lw      $v0, -128($fp)
__rt_atoi.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_dd_clear
	.text
# ---------------------------------------------------------------
# function dd_clear (line 988), returns void
# frame 40 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%t0 : ptr
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_dd_clear
__rt_dd_clear:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	# %t0 = addr @dd_n   ; line 989
	la      $t0, __rtg_dd_n
	sw      $t0, -12($fp)
	# store.w %t0, 0   ; line 989
	lw      $t0, -12($fp)
	sw      $zero, 0($t0)
	# %t1 = addr @dd_adj   ; line 990
	la      $t0, __rtg_dd_adj
	sw      $t0, -16($fp)
	# store.w %t1, 0   ; line 990
	lw      $t0, -16($fp)
	sw      $zero, 0($t0)
	# %t2 = addr @dd_sticky   ; line 991
	la      $t0, __rtg_dd_sticky
	sw      $t0, -20($fp)
	# store.w %t2, 0   ; line 991
	lw      $t0, -20($fp)
	sw      $zero, 0($t0)
	# return
__rt_dd_clear.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_dd_push
	.text
# ---------------------------------------------------------------
# function dd_push (line 995), returns void
# frame 152 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   4($fp)	param frac (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%frac : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : str
#   -88($fp)	%t19 : char
#   -92($fp)	%t20 : char
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : ptr
#   -120($fp)	%t27 : ptr
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_dd_push
__rt_dd_push:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -152
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param frac : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t2 = addr @dd_n   ; line 996
	la      $t0, __rtg_dd_n
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 996
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = %t3 == 0   ; line 996
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L591   ; line 996
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_dd_push.L591
	# %t5 = %c == 48   ; line 996
	lw      $t0, -12($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L591   ; line 996
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_dd_push.L591
	# ifFalse %frac goto .L593   ; line 997
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_dd_push.L593
	# %t6 = addr @dd_adj   ; line 997
	la      $t0, __rtg_dd_adj
	sw      $t0, -36($fp)
	# %t7 = load.w %t6   ; line 997
	lw      $t0, -36($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = %t7   ; line 997
	lw      $t0, -40($fp)
	sw      $t0, -44($fp)
	# %t9 = %t8 - 1   ; line 997
	lw      $t0, -44($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -48($fp)
	# store.w %t6, %t9   ; line 997
	lw      $t0, -36($fp)
	lw      $t1, -48($fp)
	sw      $t1, 0($t0)
__rt_dd_push.L593:
	# return   ; line 998
	b       __rt_dd_push.ret
__rt_dd_push.L591:
	# %t10 = addr @dd_n   ; line 1000
	la      $t0, __rtg_dd_n
	sw      $t0, -52($fp)
	# %t11 = load.w %t10   ; line 1000
	lw      $t0, -52($fp)
	lw      $t1, 0($t0)
	sw      $t1, -56($fp)
	# %t12 = %t11 < 780   ; line 1000
	lw      $t0, -56($fp)
	slti    $t0, $t0, 780
	sw      $t0, -60($fp)
	# ifFalse %t12 goto .L595   ; line 1000
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_dd_push.L595
	# %t13 = addr @dd_dig   ; line 1001
	la      $t0, __rtg_dd_dig
	sw      $t0, -64($fp)
	# %t14 = addr @dd_n   ; line 1001
	la      $t0, __rtg_dd_n
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 1001
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t16 = %t15   ; line 1001
	lw      $t0, -72($fp)
	sw      $t0, -76($fp)
	# %t17 = %t16 + 1   ; line 1001
	lw      $t0, -76($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# store.w %t14, %t17   ; line 1001
	lw      $t0, -68($fp)
	lw      $t1, -80($fp)
	sw      $t1, 0($t0)
	# %t18 = %t13 + %t16   ; line 1001
	lw      $t0, -64($fp)
	lw      $t1, -76($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %t19 = sext.b %c   ; line 1001
	lw      $t0, -12($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -88($fp)
	# store.b %t18, %t19   ; line 1001
	lw      $t0, -84($fp)
	lw      $t1, -88($fp)
	sb      $t1, 0($t0)
	# %t20 = sext.b %t19   ; line 1001
	lw      $t0, -88($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -92($fp)
	# ifFalse %frac goto .L597   ; line 1002
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_dd_push.L597
	# %t21 = addr @dd_adj   ; line 1002
	la      $t0, __rtg_dd_adj
	sw      $t0, -96($fp)
	# %t22 = load.w %t21   ; line 1002
	lw      $t0, -96($fp)
	lw      $t1, 0($t0)
	sw      $t1, -100($fp)
	# %t23 = %t22   ; line 1002
	lw      $t0, -100($fp)
	sw      $t0, -104($fp)
	# %t24 = %t23 - 1   ; line 1002
	lw      $t0, -104($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -108($fp)
	# store.w %t21, %t24   ; line 1002
	lw      $t0, -96($fp)
	lw      $t1, -108($fp)
	sw      $t1, 0($t0)
__rt_dd_push.L597:
	# goto .L598   ; line 1002
	b       __rt_dd_push.L598
__rt_dd_push.L595:
	# %t25 = %c != 48   ; line 1004
	lw      $t0, -12($fp)
	xori    $t0, $t0, 48
	sltu    $t0, $zero, $t0
	sw      $t0, -112($fp)
	# ifFalse %t25 goto .L600   ; line 1004
	lw      $t0, -112($fp)
	beq     $t0, $zero, __rt_dd_push.L600
	# %t26 = addr @dd_sticky   ; line 1004
	la      $t0, __rtg_dd_sticky
	sw      $t0, -116($fp)
	# store.w %t26, 1   ; line 1004
	lw      $t0, -116($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_dd_push.L600:
	# if %frac goto .L602   ; line 1005
	lw      $t0, -16($fp)
	bne     $t0, $zero, __rt_dd_push.L602
	# %t27 = addr @dd_adj   ; line 1005
	la      $t0, __rtg_dd_adj
	sw      $t0, -120($fp)
	# %t28 = load.w %t27   ; line 1005
	lw      $t0, -120($fp)
	lw      $t1, 0($t0)
	sw      $t1, -124($fp)
	# %t29 = %t28   ; line 1005
	lw      $t0, -124($fp)
	sw      $t0, -128($fp)
	# %t30 = %t29 + 1   ; line 1005
	lw      $t0, -128($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# store.w %t27, %t30   ; line 1005
	lw      $t0, -120($fp)
	lw      $t1, -132($fp)
	sw      $t1, 0($t0)
__rt_dd_push.L602:
__rt_dd_push.L598:
	# return
__rt_dd_push.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_set
	.text
# ---------------------------------------------------------------
# function big_set (line 1017), returns void
# frame 40 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   4($fp)	param v (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%v : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_set
__rt_big_set:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param v : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# store.w %b, 0   ; line 1018
	lw      $t0, -12($fp)
	sw      $zero, 0($t0)
	# ifFalse %v goto .L604   ; line 1019
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_big_set.L604
	# %t2 = %b + 4   ; line 1019
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -20($fp)
	# %t3 = %t2 + 0   ; line 1019
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -24($fp)
	# store.w %t3, %v   ; line 1019
	lw      $t0, -24($fp)
	lw      $t1, -16($fp)
	sw      $t1, 0($t0)
	# store.w %b, 1   ; line 1019
	lw      $t0, -12($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_big_set.L604:
	# return
__rt_big_set.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_muladd
	.text
# ---------------------------------------------------------------
# function big_muladd (line 1023), returns void
# frame 128 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   4($fp)	param m (int, arrives in $a1)
#   8($fp)	param a (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%m : int
#   -20($fp)	%a : int
#   -24($fp)	%i : int
#   -28($fp)	%t : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_muladd
__rt_big_muladd:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -128
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param m : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param a : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %i = 0   ; line 1025
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_big_muladd.L605:
	# %t5 = load.w %b   ; line 1025
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %i < %t5   ; line 1025
	lw      $t0, -24($fp)
	lw      $t1, -32($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L608   ; line 1025
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_big_muladd.L608
	# %t7 = %b + 4   ; line 1026
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -40($fp)
	# %t8 = %i * 4   ; line 1026
	lw      $t0, -24($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = %t7 + %t8   ; line 1026
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 1026
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 * %m   ; line 1026
	lw      $t0, -52($fp)
	lw      $t1, -16($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = %t11 + %a   ; line 1026
	lw      $t0, -56($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t = %t12   ; line 1026
	lw      $t0, -60($fp)
	sw      $t0, -28($fp)
	# %t13 = %b + 4   ; line 1027
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -64($fp)
	# %t14 = %i * 4   ; line 1027
	lw      $t0, -24($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = %t13 + %t14   ; line 1027
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = %t & 65535   ; line 1027
	lw      $t0, -28($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -76($fp)
	# store.w %t15, %t16   ; line 1027
	lw      $t0, -72($fp)
	lw      $t1, -76($fp)
	sw      $t1, 0($t0)
	# %t17 = %t >> 16   ; line 1028
	lw      $t0, -28($fp)
	sra     $t0, $t0, 16
	sw      $t0, -80($fp)
	# %a = %t17   ; line 1028
	lw      $t0, -80($fp)
	sw      $t0, -20($fp)
	# %t18 = %i   ; line 1025
	lw      $t0, -24($fp)
	sw      $t0, -84($fp)
	# %t19 = %t18 + 1   ; line 1025
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %i = %t19   ; line 1025
	lw      $t0, -88($fp)
	sw      $t0, -24($fp)
	# goto .L605   ; line 1025
	b       __rt_big_muladd.L605
__rt_big_muladd.L608:
	# ifFalse %a goto .L610   ; line 1030
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_big_muladd.L610
	# %t20 = %b + 4   ; line 1030
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -92($fp)
	# %t21 = load.w %b   ; line 1030
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -96($fp)
	# %t22 = %t21   ; line 1030
	lw      $t0, -96($fp)
	sw      $t0, -100($fp)
	# %t23 = %t22 + 1   ; line 1030
	lw      $t0, -100($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -104($fp)
	# store.w %b, %t23   ; line 1030
	lw      $t0, -12($fp)
	lw      $t1, -104($fp)
	sw      $t1, 0($t0)
	# %t24 = %t22 * 4   ; line 1030
	lw      $t0, -100($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -108($fp)
	# %t25 = %t20 + %t24   ; line 1030
	lw      $t0, -92($fp)
	lw      $t1, -108($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -112($fp)
	# store.w %t25, %a   ; line 1030
	lw      $t0, -112($fp)
	lw      $t1, -20($fp)
	sw      $t1, 0($t0)
__rt_big_muladd.L610:
	# return
__rt_big_muladd.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_pow10
	.text
# ---------------------------------------------------------------
# function big_pow10 (line 1034), returns void
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   4($fp)	param k (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%k : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_pow10
__rt_big_pow10:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -72
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param k : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
__rt_big_pow10.L611:
	# %t2 = %k >= 4   ; line 1035
	lw      $t0, -16($fp)
	slti    $t0, $t0, 4
	xori    $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L613   ; line 1035
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_big_pow10.L613
	# %t3 = 10000   ; line 1035
	li      $t0, 10000
	sw      $t0, -24($fp)
	# %t4 = 0   ; line 1035
	move    $t0, $zero
	sw      $t0, -28($fp)
	# param %b : ptr   ; line 1035
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %t3 : int   ; line 1035
	lw      $t0, -24($fp)
	sw      $t0, 4($sp)
	# param %t4 : int   ; line 1035
	lw      $t0, -28($fp)
	sw      $t0, 8($sp)
	# call @big_muladd, 3   ; line 1035
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_big_muladd
	# %t5 = %k - 4   ; line 1035
	lw      $t0, -16($fp)
	addiu   $t0, $t0, -4
	sw      $t0, -32($fp)
	# %k = %t5   ; line 1035
	lw      $t0, -32($fp)
	sw      $t0, -16($fp)
	# goto .L611   ; line 1035
	b       __rt_big_pow10.L611
__rt_big_pow10.L613:
__rt_big_pow10.L614:
	# %t6 = %k > 0   ; line 1036
	lw      $t0, -16($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L616   ; line 1036
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_big_pow10.L616
	# %t7 = 10   ; line 1036
	li      $t0, 10
	sw      $t0, -40($fp)
	# %t8 = 0   ; line 1036
	move    $t0, $zero
	sw      $t0, -44($fp)
	# param %b : ptr   ; line 1036
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %t7 : int   ; line 1036
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# param %t8 : int   ; line 1036
	lw      $t0, -44($fp)
	sw      $t0, 8($sp)
	# call @big_muladd, 3   ; line 1036
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_big_muladd
	# %t9 = %k   ; line 1036
	lw      $t0, -16($fp)
	sw      $t0, -48($fp)
	# %t10 = %t9 - 1   ; line 1036
	lw      $t0, -48($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -52($fp)
	# %k = %t10   ; line 1036
	lw      $t0, -52($fp)
	sw      $t0, -16($fp)
	# goto .L614   ; line 1036
	b       __rt_big_pow10.L614
__rt_big_pow10.L616:
	# return
__rt_big_pow10.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_bits
	.text
# ---------------------------------------------------------------
# function big_bits (line 1039), returns int
# frame 96 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%t : int
#   -20($fp)	%n : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_bits
__rt_big_bits:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -96
	sw      $a0, 0($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t3 = load.w %b   ; line 1041
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = %t3 == 0   ; line 1041
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L618   ; line 1041
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_big_bits.L618
	# return 0   ; line 1041
	move    $v0, $zero
	b       __rt_big_bits.ret
__rt_big_bits.L618:
	# %t5 = load.w %b   ; line 1042
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %t5 - 1   ; line 1042
	lw      $t0, -32($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -36($fp)
	# %t7 = %t6 * 16   ; line 1042
	lw      $t0, -36($fp)
	li      $t1, 16
	mul     $t0, $t0, $t1
	sw      $t0, -40($fp)
	# %n = %t7   ; line 1042
	lw      $t0, -40($fp)
	sw      $t0, -20($fp)
	# %t8 = %b + 4   ; line 1043
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -44($fp)
	# %t9 = load.w %b   ; line 1043
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %t10 = %t9 - 1   ; line 1043
	lw      $t0, -48($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -52($fp)
	# %t11 = %t10 * 4   ; line 1043
	lw      $t0, -52($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = %t8 + %t11   ; line 1043
	lw      $t0, -44($fp)
	lw      $t1, -56($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t13 = load.w %t12   ; line 1043
	lw      $t0, -60($fp)
	lw      $t1, 0($t0)
	sw      $t1, -64($fp)
	# %t = %t13   ; line 1043
	lw      $t0, -64($fp)
	sw      $t0, -16($fp)
__rt_big_bits.L619:
	# ifFalse %t goto .L621   ; line 1044
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_big_bits.L621
	# %t14 = %n   ; line 1044
	lw      $t0, -20($fp)
	sw      $t0, -68($fp)
	# %t15 = %t14 + 1   ; line 1044
	lw      $t0, -68($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -72($fp)
	# %n = %t15   ; line 1044
	lw      $t0, -72($fp)
	sw      $t0, -20($fp)
	# %t16 = %t >> 1   ; line 1044
	lw      $t0, -16($fp)
	sra     $t0, $t0, 1
	sw      $t0, -76($fp)
	# %t = %t16   ; line 1044
	lw      $t0, -76($fp)
	sw      $t0, -16($fp)
	# goto .L619   ; line 1044
	b       __rt_big_bits.L619
__rt_big_bits.L621:
	# return %n   ; line 1045
	lw      $v0, -20($fp)
__rt_big_bits.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_shl
	.text
# ---------------------------------------------------------------
# function big_shl (line 1048), returns void
# frame 240 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   4($fp)	param bits (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%bits : int
#   -20($fp)	%w : int
#   -24($fp)	%r : int
#   -28($fp)	%i : int
#   -32($fp)	%v : int
#   -36($fp)	%carry : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : ptr
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : ptr
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : int
#   -152($fp)	%t35 : ptr
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : ptr
#   -168($fp)	%t39 : ptr
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : ptr
#   -180($fp)	%t42 : int
#   -184($fp)	%t43 : int
#   -188($fp)	%t44 : int
#   -192($fp)	%t45 : int
#   -196($fp)	%t46 : ptr
#   -200($fp)	%t47 : int
#   -204($fp)	%t48 : ptr
#   -208($fp)	%t49 : int
#   -212($fp)	%t50 : int
#   -216($fp)	%t51 : int
#   -220($fp)	%t52 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_shl
__rt_big_shl:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -240
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param bits : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t7 = load.w %b   ; line 1050
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = %t7 == 0   ; line 1050
	lw      $t0, -40($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L623   ; line 1050
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_big_shl.L623
	# return   ; line 1050
	b       __rt_big_shl.ret
__rt_big_shl.L623:
	# %t9 = %bits >> 4   ; line 1051
	lw      $t0, -16($fp)
	sra     $t0, $t0, 4
	sw      $t0, -48($fp)
	# %w = %t9   ; line 1051
	lw      $t0, -48($fp)
	sw      $t0, -20($fp)
	# %t10 = %bits & 15   ; line 1052
	lw      $t0, -16($fp)
	andi    $t0, $t0, 15
	sw      $t0, -52($fp)
	# %r = %t10   ; line 1052
	lw      $t0, -52($fp)
	sw      $t0, -24($fp)
	# ifFalse %r goto .L625   ; line 1053
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_big_shl.L625
	# %carry = 0   ; line 1054
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %i = 0   ; line 1055
	move    $t0, $zero
	sw      $t0, -28($fp)
__rt_big_shl.L626:
	# %t11 = load.w %b   ; line 1055
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -56($fp)
	# %t12 = %i < %t11   ; line 1055
	lw      $t0, -28($fp)
	lw      $t1, -56($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -60($fp)
	# ifFalse %t12 goto .L629   ; line 1055
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_big_shl.L629
	# %t13 = %b + 4   ; line 1056
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -64($fp)
	# %t14 = %i * 4   ; line 1056
	lw      $t0, -28($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = %t13 + %t14   ; line 1056
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 1056
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %t16 << %r   ; line 1056
	lw      $t0, -76($fp)
	lw      $t1, -24($fp)
	sllv    $t0, $t0, $t1
	sw      $t0, -80($fp)
	# %t18 = %t17 | %carry   ; line 1056
	lw      $t0, -80($fp)
	lw      $t1, -36($fp)
	or      $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %v = %t18   ; line 1056
	lw      $t0, -84($fp)
	sw      $t0, -32($fp)
	# %t19 = %b + 4   ; line 1057
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -88($fp)
	# %t20 = %i * 4   ; line 1057
	lw      $t0, -28($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t21 = %t19 + %t20   ; line 1057
	lw      $t0, -88($fp)
	lw      $t1, -92($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -96($fp)
	# %t22 = %v & 65535   ; line 1057
	lw      $t0, -32($fp)
	andi    $t0, $t0, 65535
	sw      $t0, -100($fp)
	# store.w %t21, %t22   ; line 1057
	lw      $t0, -96($fp)
	lw      $t1, -100($fp)
	sw      $t1, 0($t0)
	# %t23 = %v >> 16   ; line 1058
	lw      $t0, -32($fp)
	sra     $t0, $t0, 16
	sw      $t0, -104($fp)
	# %carry = %t23   ; line 1058
	lw      $t0, -104($fp)
	sw      $t0, -36($fp)
	# %t24 = %i   ; line 1055
	lw      $t0, -28($fp)
	sw      $t0, -108($fp)
	# %t25 = %t24 + 1   ; line 1055
	lw      $t0, -108($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# %i = %t25   ; line 1055
	lw      $t0, -112($fp)
	sw      $t0, -28($fp)
	# goto .L626   ; line 1055
	b       __rt_big_shl.L626
__rt_big_shl.L629:
	# ifFalse %carry goto .L631   ; line 1060
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_big_shl.L631
	# %t26 = %b + 4   ; line 1060
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -116($fp)
	# %t27 = load.w %b   ; line 1060
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -120($fp)
	# %t28 = %t27   ; line 1060
	lw      $t0, -120($fp)
	sw      $t0, -124($fp)
	# %t29 = %t28 + 1   ; line 1060
	lw      $t0, -124($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -128($fp)
	# store.w %b, %t29   ; line 1060
	lw      $t0, -12($fp)
	lw      $t1, -128($fp)
	sw      $t1, 0($t0)
	# %t30 = %t28 * 4   ; line 1060
	lw      $t0, -124($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -132($fp)
	# %t31 = %t26 + %t30   ; line 1060
	lw      $t0, -116($fp)
	lw      $t1, -132($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -136($fp)
	# store.w %t31, %carry   ; line 1060
	lw      $t0, -136($fp)
	lw      $t1, -36($fp)
	sw      $t1, 0($t0)
__rt_big_shl.L631:
__rt_big_shl.L625:
	# ifFalse %w goto .L633   ; line 1062
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_big_shl.L633
	# %t32 = load.w %b   ; line 1063
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -140($fp)
	# %t33 = %t32 - 1   ; line 1063
	lw      $t0, -140($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -144($fp)
	# %i = %t33   ; line 1063
	lw      $t0, -144($fp)
	sw      $t0, -28($fp)
__rt_big_shl.L634:
	# %t34 = %i >= 0   ; line 1063
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -148($fp)
	# ifFalse %t34 goto .L637   ; line 1063
	lw      $t0, -148($fp)
	beq     $t0, $zero, __rt_big_shl.L637
	# %t35 = %b + 4   ; line 1063
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -152($fp)
	# %t36 = %i + %w   ; line 1063
	lw      $t0, -28($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -156($fp)
	# %t37 = %t36 * 4   ; line 1063
	lw      $t0, -156($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -160($fp)
	# %t38 = %t35 + %t37   ; line 1063
	lw      $t0, -152($fp)
	lw      $t1, -160($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -164($fp)
	# %t39 = %b + 4   ; line 1063
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -168($fp)
	# %t40 = %i * 4   ; line 1063
	lw      $t0, -28($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -172($fp)
	# %t41 = %t39 + %t40   ; line 1063
	lw      $t0, -168($fp)
	lw      $t1, -172($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -176($fp)
	# %t42 = load.w %t41   ; line 1063
	lw      $t0, -176($fp)
	lw      $t1, 0($t0)
	sw      $t1, -180($fp)
	# store.w %t38, %t42   ; line 1063
	lw      $t0, -164($fp)
	lw      $t1, -180($fp)
	sw      $t1, 0($t0)
	# %t43 = %i   ; line 1063
	lw      $t0, -28($fp)
	sw      $t0, -184($fp)
	# %t44 = %t43 - 1   ; line 1063
	lw      $t0, -184($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -188($fp)
	# %i = %t44   ; line 1063
	lw      $t0, -188($fp)
	sw      $t0, -28($fp)
	# goto .L634   ; line 1063
	b       __rt_big_shl.L634
__rt_big_shl.L637:
	# %i = 0   ; line 1064
	move    $t0, $zero
	sw      $t0, -28($fp)
__rt_big_shl.L638:
	# %t45 = %i < %w   ; line 1064
	lw      $t0, -28($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -192($fp)
	# ifFalse %t45 goto .L641   ; line 1064
	lw      $t0, -192($fp)
	beq     $t0, $zero, __rt_big_shl.L641
	# %t46 = %b + 4   ; line 1064
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -196($fp)
	# %t47 = %i * 4   ; line 1064
	lw      $t0, -28($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -200($fp)
	# %t48 = %t46 + %t47   ; line 1064
	lw      $t0, -196($fp)
	lw      $t1, -200($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -204($fp)
	# store.w %t48, 0   ; line 1064
	lw      $t0, -204($fp)
	sw      $zero, 0($t0)
	# %t49 = %i   ; line 1064
	lw      $t0, -28($fp)
	sw      $t0, -208($fp)
	# %t50 = %t49 + 1   ; line 1064
	lw      $t0, -208($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -212($fp)
	# %i = %t50   ; line 1064
	lw      $t0, -212($fp)
	sw      $t0, -28($fp)
	# goto .L638   ; line 1064
	b       __rt_big_shl.L638
__rt_big_shl.L641:
	# %t51 = load.w %b   ; line 1065
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -216($fp)
	# %t52 = %t51 + %w   ; line 1065
	lw      $t0, -216($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -220($fp)
	# store.w %b, %t52   ; line 1065
	lw      $t0, -12($fp)
	lw      $t1, -220($fp)
	sw      $t1, 0($t0)
__rt_big_shl.L633:
	# return
__rt_big_shl.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_shr1
	.text
# ---------------------------------------------------------------
# function big_shr1 (line 1069), returns void
# frame 200 bytes ($fp = $sp at entry):
#   0($fp)	param b (ptr, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%b : ptr
#   -16($fp)	%i : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : ptr
#   -84($fp)	%t18 : ptr
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : ptr
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : ptr
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : ptr
#   -152($fp)	%t35 : int
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : ptr
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : int
#   -184($fp)	%t43 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_shr1
__rt_big_shr1:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -200
	sw      $a0, 0($fp)
	# param b : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %i = 0   ; line 1071
	move    $t0, $zero
	sw      $t0, -16($fp)
__rt_big_shr1.L642:
	# %t2 = load.w %b   ; line 1071
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# %t3 = %i < %t2   ; line 1071
	lw      $t0, -16($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L645   ; line 1071
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_big_shr1.L645
	# %t4 = %b + 4   ; line 1072
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -28($fp)
	# %t5 = %i * 4   ; line 1072
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = %t4 + %t5   ; line 1072
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = %b + 4   ; line 1072
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -40($fp)
	# %t8 = %i * 4   ; line 1072
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = %t7 + %t8   ; line 1072
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 1072
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 >> 1   ; line 1072
	lw      $t0, -52($fp)
	sra     $t0, $t0, 1
	sw      $t0, -56($fp)
	# store.w %t6, %t11   ; line 1072
	lw      $t0, -36($fp)
	lw      $t1, -56($fp)
	sw      $t1, 0($t0)
	# %t12 = %i + 1   ; line 1073
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# %t13 = load.w %b   ; line 1073
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -64($fp)
	# %t14 = %t12 < %t13   ; line 1073
	lw      $t0, -60($fp)
	lw      $t1, -64($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L647   ; line 1073
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_big_shr1.L647
	# %t15 = %b + 4   ; line 1073
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -72($fp)
	# %t16 = %i * 4   ; line 1073
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -76($fp)
	# %t17 = %t15 + %t16   ; line 1073
	lw      $t0, -72($fp)
	lw      $t1, -76($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -80($fp)
	# %t18 = %b + 4   ; line 1073
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -84($fp)
	# %t19 = %i * 4   ; line 1073
	lw      $t0, -16($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t20 = %t18 + %t19   ; line 1073
	lw      $t0, -84($fp)
	lw      $t1, -88($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t21 = load.w %t20   ; line 1073
	lw      $t0, -92($fp)
	lw      $t1, 0($t0)
	sw      $t1, -96($fp)
	# %t22 = %b + 4   ; line 1073
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -100($fp)
	# %t23 = %i + 1   ; line 1073
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -104($fp)
	# %t24 = %t23 * 4   ; line 1073
	lw      $t0, -104($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -108($fp)
	# %t25 = %t22 + %t24   ; line 1073
	lw      $t0, -100($fp)
	lw      $t1, -108($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -112($fp)
	# %t26 = load.w %t25   ; line 1073
	lw      $t0, -112($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# %t27 = %t26 & 1   ; line 1073
	lw      $t0, -116($fp)
	andi    $t0, $t0, 1
	sw      $t0, -120($fp)
	# %t28 = %t27 << 15   ; line 1073
	lw      $t0, -120($fp)
	sll     $t0, $t0, 15
	sw      $t0, -124($fp)
	# %t29 = %t21 | %t28   ; line 1073
	lw      $t0, -96($fp)
	lw      $t1, -124($fp)
	or      $t0, $t0, $t1
	sw      $t0, -128($fp)
	# store.w %t17, %t29   ; line 1073
	lw      $t0, -80($fp)
	lw      $t1, -128($fp)
	sw      $t1, 0($t0)
__rt_big_shr1.L647:
	# %t30 = %i   ; line 1071
	lw      $t0, -16($fp)
	sw      $t0, -132($fp)
	# %t31 = %t30 + 1   ; line 1071
	lw      $t0, -132($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -136($fp)
	# %i = %t31   ; line 1071
	lw      $t0, -136($fp)
	sw      $t0, -16($fp)
	# goto .L642   ; line 1071
	b       __rt_big_shr1.L642
__rt_big_shr1.L645:
__rt_big_shr1.L648:
	# %t32 = load.w %b   ; line 1075
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -140($fp)
	# %t33 = %t32 > 0   ; line 1075
	lw      $t0, -140($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -144($fp)
	# ifFalse %t33 goto .L650   ; line 1075
	lw      $t0, -144($fp)
	beq     $t0, $zero, __rt_big_shr1.L650
	# %t34 = %b + 4   ; line 1075
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -148($fp)
	# %t35 = load.w %b   ; line 1075
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -152($fp)
	# %t36 = %t35 - 1   ; line 1075
	lw      $t0, -152($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -156($fp)
	# %t37 = %t36 * 4   ; line 1075
	lw      $t0, -156($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -160($fp)
	# %t38 = %t34 + %t37   ; line 1075
	lw      $t0, -148($fp)
	lw      $t1, -160($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -164($fp)
	# %t39 = load.w %t38   ; line 1075
	lw      $t0, -164($fp)
	lw      $t1, 0($t0)
	sw      $t1, -168($fp)
	# %t40 = %t39 == 0   ; line 1075
	lw      $t0, -168($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -172($fp)
	# ifFalse %t40 goto .L650   ; line 1075
	lw      $t0, -172($fp)
	beq     $t0, $zero, __rt_big_shr1.L650
	# %t41 = load.w %b   ; line 1075
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -176($fp)
	# %t42 = %t41   ; line 1075
	lw      $t0, -176($fp)
	sw      $t0, -180($fp)
	# %t43 = %t42 - 1   ; line 1075
	lw      $t0, -180($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -184($fp)
	# store.w %b, %t43   ; line 1075
	lw      $t0, -12($fp)
	lw      $t1, -184($fp)
	sw      $t1, 0($t0)
	# goto .L648   ; line 1075
	b       __rt_big_shr1.L648
__rt_big_shr1.L650:
	# return
__rt_big_shr1.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_cmp
	.text
# ---------------------------------------------------------------
# function big_cmp (line 1078), returns int
# frame 160 bytes ($fp = $sp at entry):
#   0($fp)	param a (ptr, arrives in $a0)
#   4($fp)	param b (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%a : ptr
#   -16($fp)	%b : ptr
#   -20($fp)	%i : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : ptr
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : ptr
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : ptr
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : ptr
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_cmp
__rt_big_cmp:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -160
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param a : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param b : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t3 = load.w %a   ; line 1080
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = load.w %b   ; line 1080
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = %t3 != %t4   ; line 1080
	lw      $t0, -24($fp)
	lw      $t1, -28($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L652   ; line 1080
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_big_cmp.L652
	# %t7 = load.w %a   ; line 1080
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -40($fp)
	# %t8 = load.w %b   ; line 1080
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# %t9 = %t7 < %t8   ; line 1080
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -48($fp)
	# ifFalse %t9 goto .L654   ; line 1080
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_big_cmp.L654
	# %t6 = -1   ; line 1080
	li      $t0, -1
	sw      $t0, -36($fp)
	# goto .L655   ; line 1080
	b       __rt_big_cmp.L655
__rt_big_cmp.L654:
	# %t6 = 1   ; line 1080
	li      $t0, 1
	sw      $t0, -36($fp)
__rt_big_cmp.L655:
	# return %t6   ; line 1080
	lw      $v0, -36($fp)
	b       __rt_big_cmp.ret
__rt_big_cmp.L652:
	# %t10 = load.w %a   ; line 1081
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 - 1   ; line 1081
	lw      $t0, -52($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -56($fp)
	# %i = %t11   ; line 1081
	lw      $t0, -56($fp)
	sw      $t0, -20($fp)
__rt_big_cmp.L656:
	# %t12 = %i >= 0   ; line 1081
	lw      $t0, -20($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -60($fp)
	# ifFalse %t12 goto .L659   ; line 1081
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_big_cmp.L659
	# %t13 = %a + 4   ; line 1082
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -64($fp)
	# %t14 = %i * 4   ; line 1082
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t15 = %t13 + %t14   ; line 1082
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 1082
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %b + 4   ; line 1082
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -80($fp)
	# %t18 = %i * 4   ; line 1082
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %t19 = %t17 + %t18   ; line 1082
	lw      $t0, -80($fp)
	lw      $t1, -84($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -88($fp)
	# %t20 = load.w %t19   ; line 1082
	lw      $t0, -88($fp)
	lw      $t1, 0($t0)
	sw      $t1, -92($fp)
	# %t21 = %t16 != %t20   ; line 1082
	lw      $t0, -76($fp)
	lw      $t1, -92($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -96($fp)
	# ifFalse %t21 goto .L661   ; line 1082
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_big_cmp.L661
	# %t23 = %a + 4   ; line 1082
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -104($fp)
	# %t24 = %i * 4   ; line 1082
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -108($fp)
	# %t25 = %t23 + %t24   ; line 1082
	lw      $t0, -104($fp)
	lw      $t1, -108($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -112($fp)
	# %t26 = load.w %t25   ; line 1082
	lw      $t0, -112($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# %t27 = %b + 4   ; line 1082
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -120($fp)
	# %t28 = %i * 4   ; line 1082
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -124($fp)
	# %t29 = %t27 + %t28   ; line 1082
	lw      $t0, -120($fp)
	lw      $t1, -124($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -128($fp)
	# %t30 = load.w %t29   ; line 1082
	lw      $t0, -128($fp)
	lw      $t1, 0($t0)
	sw      $t1, -132($fp)
	# %t31 = %t26 < %t30   ; line 1082
	lw      $t0, -116($fp)
	lw      $t1, -132($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -136($fp)
	# ifFalse %t31 goto .L663   ; line 1082
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_big_cmp.L663
	# %t22 = -1   ; line 1082
	li      $t0, -1
	sw      $t0, -100($fp)
	# goto .L664   ; line 1082
	b       __rt_big_cmp.L664
__rt_big_cmp.L663:
	# %t22 = 1   ; line 1082
	li      $t0, 1
	sw      $t0, -100($fp)
__rt_big_cmp.L664:
	# return %t22   ; line 1082
	lw      $v0, -100($fp)
	b       __rt_big_cmp.ret
__rt_big_cmp.L661:
	# %t32 = %i   ; line 1081
	lw      $t0, -20($fp)
	sw      $t0, -140($fp)
	# %t33 = %t32 - 1   ; line 1081
	lw      $t0, -140($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -144($fp)
	# %i = %t33   ; line 1081
	lw      $t0, -144($fp)
	sw      $t0, -20($fp)
	# goto .L656   ; line 1081
	b       __rt_big_cmp.L656
__rt_big_cmp.L659:
	# return 0   ; line 1083
	move    $v0, $zero
__rt_big_cmp.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_big_sub
	.text
# ---------------------------------------------------------------
# function big_sub (line 1087), returns void
# frame 176 bytes ($fp = $sp at entry):
#   0($fp)	param a (ptr, arrives in $a0)
#   4($fp)	param b (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%a : ptr
#   -16($fp)	%b : ptr
#   -20($fp)	%i : int
#   -24($fp)	%t : int
#   -28($fp)	%borrow : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : ptr
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : ptr
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : ptr
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : ptr
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : int
#   -152($fp)	%t35 : int
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_big_sub
__rt_big_sub:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -176
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param a : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param b : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %borrow = 0   ; line 1089
	move    $t0, $zero
	sw      $t0, -28($fp)
	# %i = 0   ; line 1090
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_big_sub.L665:
	# %t5 = load.w %a   ; line 1090
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %i < %t5   ; line 1090
	lw      $t0, -20($fp)
	lw      $t1, -32($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L668   ; line 1090
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_big_sub.L668
	# %t7 = %a + 4   ; line 1091
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -40($fp)
	# %t8 = %i * 4   ; line 1091
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = %t7 + %t8   ; line 1091
	lw      $t0, -40($fp)
	lw      $t1, -44($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 1091
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 - %borrow   ; line 1091
	lw      $t0, -52($fp)
	lw      $t1, -28($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t = %t11   ; line 1091
	lw      $t0, -56($fp)
	sw      $t0, -24($fp)
	# %t12 = load.w %b   ; line 1092
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %i < %t12   ; line 1092
	lw      $t0, -20($fp)
	lw      $t1, -60($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L670   ; line 1092
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_big_sub.L670
	# %t14 = %b + 4   ; line 1092
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -68($fp)
	# %t15 = %i * 4   ; line 1092
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -72($fp)
	# %t16 = %t14 + %t15   ; line 1092
	lw      $t0, -68($fp)
	lw      $t1, -72($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -76($fp)
	# %t17 = load.w %t16   ; line 1092
	lw      $t0, -76($fp)
	lw      $t1, 0($t0)
	sw      $t1, -80($fp)
	# %t18 = %t - %t17   ; line 1092
	lw      $t0, -24($fp)
	lw      $t1, -80($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -84($fp)
	# %t = %t18   ; line 1092
	lw      $t0, -84($fp)
	sw      $t0, -24($fp)
__rt_big_sub.L670:
	# %borrow = 0   ; line 1093
	move    $t0, $zero
	sw      $t0, -28($fp)
	# %t19 = %t < 0   ; line 1094
	lw      $t0, -24($fp)
	slti    $t0, $t0, 0
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L672   ; line 1094
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_big_sub.L672
	# %t20 = %t + 65536   ; line 1094
	lw      $t0, -24($fp)
	li      $t1, 65536
	addu    $t0, $t0, $t1
	sw      $t0, -92($fp)
	# %t = %t20   ; line 1094
	lw      $t0, -92($fp)
	sw      $t0, -24($fp)
	# %borrow = 1   ; line 1094
	li      $t0, 1
	sw      $t0, -28($fp)
__rt_big_sub.L672:
	# %t21 = %a + 4   ; line 1095
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -96($fp)
	# %t22 = %i * 4   ; line 1095
	lw      $t0, -20($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -100($fp)
	# %t23 = %t21 + %t22   ; line 1095
	lw      $t0, -96($fp)
	lw      $t1, -100($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -104($fp)
	# store.w %t23, %t   ; line 1095
	lw      $t0, -104($fp)
	lw      $t1, -24($fp)
	sw      $t1, 0($t0)
	# %t24 = %i   ; line 1090
	lw      $t0, -20($fp)
	sw      $t0, -108($fp)
	# %t25 = %t24 + 1   ; line 1090
	lw      $t0, -108($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# %i = %t25   ; line 1090
	lw      $t0, -112($fp)
	sw      $t0, -20($fp)
	# goto .L665   ; line 1090
	b       __rt_big_sub.L665
__rt_big_sub.L668:
__rt_big_sub.L673:
	# %t26 = load.w %a   ; line 1097
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -116($fp)
	# %t27 = %t26 > 0   ; line 1097
	lw      $t0, -116($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -120($fp)
	# ifFalse %t27 goto .L675   ; line 1097
	lw      $t0, -120($fp)
	beq     $t0, $zero, __rt_big_sub.L675
	# %t28 = %a + 4   ; line 1097
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -124($fp)
	# %t29 = load.w %a   ; line 1097
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -128($fp)
	# %t30 = %t29 - 1   ; line 1097
	lw      $t0, -128($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -132($fp)
	# %t31 = %t30 * 4   ; line 1097
	lw      $t0, -132($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -136($fp)
	# %t32 = %t28 + %t31   ; line 1097
	lw      $t0, -124($fp)
	lw      $t1, -136($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -140($fp)
	# %t33 = load.w %t32   ; line 1097
	lw      $t0, -140($fp)
	lw      $t1, 0($t0)
	sw      $t1, -144($fp)
	# %t34 = %t33 == 0   ; line 1097
	lw      $t0, -144($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -148($fp)
	# ifFalse %t34 goto .L675   ; line 1097
	lw      $t0, -148($fp)
	beq     $t0, $zero, __rt_big_sub.L675
	# %t35 = load.w %a   ; line 1097
	lw      $t0, -12($fp)
	lw      $t1, 0($t0)
	sw      $t1, -152($fp)
	# %t36 = %t35   ; line 1097
	lw      $t0, -152($fp)
	sw      $t0, -156($fp)
	# %t37 = %t36 - 1   ; line 1097
	lw      $t0, -156($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -160($fp)
	# store.w %a, %t37   ; line 1097
	lw      $t0, -12($fp)
	lw      $t1, -160($fp)
	sw      $t1, 0($t0)
	# goto .L673   ; line 1097
	b       __rt_big_sub.L673
__rt_big_sub.L675:
	# return
__rt_big_sub.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_make_double
	.text
# ---------------------------------------------------------------
# function make_double (line 1101), returns double
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param hi (int, arrives in $a0)
#   4($fp)	param lo (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	local d : double (8 bytes)
#   -20($fp)	%hi : int
#   -24($fp)	%lo : int
#   -28($fp)	%w : ptr
#   -32($fp)	%t3 : ptr
#   -36($fp)	%t4 : ptr
#   -40($fp)	%t5 : ptr
#   -44($fp)	%t6 : ptr
#   -56($fp)	%t7 : double
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_make_double
__rt_make_double:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -72
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param hi : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -20($fp)
	# param lo : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -24($fp)
	# %t3 = addr d   ; line 1104
	addiu   $t0, $fp, -16
	sw      $t0, -32($fp)
	# %w = %t3   ; line 1104
	lw      $t0, -32($fp)
	sw      $t0, -28($fp)
	# %t4 = %w + 0   ; line 1105
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -36($fp)
	# store.w %t4, %lo   ; line 1105
	lw      $t0, -36($fp)
	lw      $t1, -24($fp)
	sw      $t1, 0($t0)
	# %t5 = %w + 4   ; line 1106
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -40($fp)
	# store.w %t5, %hi   ; line 1106
	lw      $t0, -40($fp)
	lw      $t1, -20($fp)
	sw      $t1, 0($t0)
	# %t6 = addr d   ; line 1107
	addiu   $t0, $fp, -16
	sw      $t0, -44($fp)
	# %t7 = load.d %t6   ; line 1107
	lw      $t0, -44($fp)
	ldc1    $f4, 0($t0)
	sdc1    $f4, -56($fp)
	# return %t7   ; line 1107
	ldc1    $f0, -56($fp)
__rt_make_double.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_dd_value
	.text
# ---------------------------------------------------------------
# function dd_value (line 1112), returns double
# frame 1488 bytes ($fp = $sp at entry):
#   0($fp)	param neg (int, arrives in $a0)
#   4($fp)	param e10 (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -520($fp)	local qb : int [64] (256 bytes)
#   -264($fp)	local mb : int [64] (256 bytes)
#   -524($fp)	%neg : int
#   -528($fp)	%e10 : int
#   -532($fp)	%sign : int
#   -536($fp)	%i : int
#   -540($fp)	%k : int
#   -544($fp)	%sh : int
#   -548($fp)	%len : int
#   -552($fp)	%ex : int
#   -556($fp)	%keep : int
#   -560($fp)	%rb : int
#   -564($fp)	%sticky : int
#   -568($fp)	%hi : int
#   -572($fp)	%lo : int
#   -576($fp)	%t13 : int
#   -580($fp)	%t14 : ptr
#   -584($fp)	%t15 : int
#   -588($fp)	%t16 : ptr
#   -592($fp)	%t17 : ptr
#   -596($fp)	%t18 : int
#   -600($fp)	%t19 : int
#   -604($fp)	%t20 : int
#   -608($fp)	%t21 : str
#   -612($fp)	%t22 : ptr
#   -616($fp)	%t23 : int
#   -620($fp)	%t24 : int
#   -624($fp)	%t25 : int
#   -628($fp)	%t26 : ptr
#   -632($fp)	%t27 : int
#   -636($fp)	%t28 : int
#   -640($fp)	%t29 : ptr
#   -644($fp)	%t30 : ptr
#   -648($fp)	%t31 : int
#   -652($fp)	%t32 : int
#   -656($fp)	%t33 : str
#   -660($fp)	%t34 : char
#   -664($fp)	%t35 : int
#   -668($fp)	%t36 : ptr
#   -672($fp)	%t37 : int
#   -676($fp)	%t38 : int
#   -680($fp)	%t39 : int
#   -684($fp)	%t40 : ptr
#   -688($fp)	%t41 : int
#   -692($fp)	%t42 : int
#   -696($fp)	%t43 : int
#   -700($fp)	%t44 : ptr
#   -704($fp)	%t45 : int
#   -708($fp)	%t46 : int
#   -712($fp)	%t47 : int
#   -720($fp)	%t48 : double
#   -724($fp)	%t49 : ptr
#   -728($fp)	%t50 : int
#   -732($fp)	%t51 : int
#   -736($fp)	%t52 : ptr
#   -740($fp)	%t53 : int
#   -744($fp)	%t54 : int
#   -748($fp)	%t55 : int
#   -752($fp)	%t56 : int
#   -756($fp)	%t57 : int
#   -768($fp)	%t58 : double
#   -772($fp)	%t59 : ptr
#   -776($fp)	%t60 : int
#   -780($fp)	%t61 : int
#   -784($fp)	%t62 : int
#   -788($fp)	%t63 : int
#   -800($fp)	%t64 : double
#   -804($fp)	%t65 : ptr
#   -808($fp)	%t66 : int
#   -812($fp)	%t67 : ptr
#   -816($fp)	%t68 : int
#   -820($fp)	%t69 : int
#   -824($fp)	%t70 : ptr
#   -828($fp)	%t71 : int
#   -832($fp)	%t72 : ptr
#   -836($fp)	%t73 : str
#   -840($fp)	%t74 : char
#   -844($fp)	%t75 : int
#   -848($fp)	%t76 : int
#   -852($fp)	%t77 : int
#   -856($fp)	%t78 : ptr
#   -860($fp)	%t79 : int
#   -864($fp)	%t80 : int
#   -868($fp)	%t81 : ptr
#   -872($fp)	%t82 : ptr
#   -876($fp)	%t83 : int
#   -880($fp)	%t84 : ptr
#   -884($fp)	%t85 : int
#   -888($fp)	%t86 : ptr
#   -892($fp)	%t87 : int
#   -896($fp)	%t88 : int
#   -900($fp)	%t89 : int
#   -904($fp)	%t90 : int
#   -908($fp)	%t91 : ptr
#   -912($fp)	%t92 : int
#   -916($fp)	%t93 : ptr
#   -920($fp)	%t94 : int
#   -924($fp)	%t95 : ptr
#   -928($fp)	%t96 : int
#   -932($fp)	%t97 : int
#   -936($fp)	%t98 : ptr
#   -940($fp)	%t99 : int
#   -944($fp)	%t100 : ptr
#   -948($fp)	%t101 : ptr
#   -952($fp)	%t102 : ptr
#   -956($fp)	%t103 : int
#   -960($fp)	%t104 : int
#   -964($fp)	%t105 : ptr
#   -968($fp)	%t106 : ptr
#   -972($fp)	%t107 : ptr
#   -976($fp)	%t108 : int
#   -980($fp)	%t109 : ptr
#   -984($fp)	%t110 : ptr
#   -988($fp)	%t111 : int
#   -992($fp)	%t112 : int
#   -996($fp)	%t113 : ptr
#   -1000($fp)	%t114 : int
#   -1004($fp)	%t115 : int
#   -1008($fp)	%t116 : ptr
#   -1012($fp)	%t117 : int
#   -1016($fp)	%t118 : int
#   -1020($fp)	%t119 : ptr
#   -1024($fp)	%t120 : int
#   -1028($fp)	%t121 : int
#   -1032($fp)	%t122 : int
#   -1036($fp)	%t123 : int
#   -1040($fp)	%t124 : int
#   -1044($fp)	%t125 : int
#   -1048($fp)	%t126 : int
#   -1052($fp)	%t127 : int
#   -1056($fp)	%t128 : int
#   -1064($fp)	%t129 : double
#   -1068($fp)	%t130 : int
#   -1072($fp)	%t131 : int
#   -1076($fp)	%t132 : int
#   -1080($fp)	%t133 : int
#   -1088($fp)	%t134 : double
#   -1092($fp)	%t135 : int
#   -1096($fp)	%t136 : int
#   -1100($fp)	%t137 : int
#   -1104($fp)	%t138 : ptr
#   -1108($fp)	%t139 : int
#   -1112($fp)	%t140 : ptr
#   -1116($fp)	%t141 : int
#   -1120($fp)	%t142 : int
#   -1124($fp)	%t143 : int
#   -1128($fp)	%t144 : ptr
#   -1132($fp)	%t145 : int
#   -1136($fp)	%t146 : ptr
#   -1140($fp)	%t147 : ptr
#   -1144($fp)	%t148 : int
#   -1148($fp)	%t149 : int
#   -1152($fp)	%t150 : int
#   -1156($fp)	%t151 : ptr
#   -1160($fp)	%t152 : int
#   -1164($fp)	%t153 : int
#   -1168($fp)	%t154 : int
#   -1172($fp)	%t155 : int
#   -1176($fp)	%t156 : ptr
#   -1180($fp)	%t157 : int
#   -1184($fp)	%t158 : ptr
#   -1188($fp)	%t159 : int
#   -1192($fp)	%t160 : int
#   -1196($fp)	%t161 : int
#   -1200($fp)	%t162 : ptr
#   -1204($fp)	%t163 : int
#   -1208($fp)	%t164 : ptr
#   -1212($fp)	%t165 : int
#   -1216($fp)	%t166 : ptr
#   -1220($fp)	%t167 : ptr
#   -1224($fp)	%t168 : int
#   -1228($fp)	%t169 : ptr
#   -1232($fp)	%t170 : int
#   -1236($fp)	%t171 : ptr
#   -1240($fp)	%t172 : int
#   -1244($fp)	%t173 : ptr
#   -1248($fp)	%t174 : int
#   -1252($fp)	%t175 : ptr
#   -1256($fp)	%t176 : int
#   -1260($fp)	%t177 : int
#   -1264($fp)	%t178 : ptr
#   -1268($fp)	%t179 : int
#   -1272($fp)	%t180 : ptr
#   -1276($fp)	%t181 : int
#   -1280($fp)	%t182 : ptr
#   -1284($fp)	%t183 : ptr
#   -1288($fp)	%t184 : int
#   -1292($fp)	%t185 : int
#   -1296($fp)	%t186 : ptr
#   -1300($fp)	%t187 : int
#   -1304($fp)	%t188 : ptr
#   -1308($fp)	%t189 : ptr
#   -1312($fp)	%t190 : int
#   -1316($fp)	%t191 : int
#   -1320($fp)	%t192 : ptr
#   -1324($fp)	%t193 : int
#   -1328($fp)	%t194 : int
#   -1332($fp)	%t195 : int
#   -1336($fp)	%t196 : ptr
#   -1340($fp)	%t197 : ptr
#   -1344($fp)	%t198 : int
#   -1348($fp)	%t199 : int
#   -1352($fp)	%t200 : int
#   -1356($fp)	%t201 : int
#   -1360($fp)	%t202 : int
#   -1368($fp)	%t203 : double
#   -1372($fp)	%t204 : int
#   -1376($fp)	%t205 : int
#   -1380($fp)	%t206 : ptr
#   -1384($fp)	%t207 : int
#   -1388($fp)	%t208 : ptr
#   -1392($fp)	%t209 : int
#   -1396($fp)	%t210 : int
#   -1400($fp)	%t211 : int
#   -1404($fp)	%t212 : int
#   -1408($fp)	%t213 : int
#   -1412($fp)	%t214 : int
#   -1416($fp)	%t215 : ptr
#   -1420($fp)	%t216 : int
#   -1424($fp)	%t217 : ptr
#   -1428($fp)	%t218 : int
#   -1432($fp)	%t219 : int
#   -1436($fp)	%t220 : int
#   -1440($fp)	%t221 : int
#   -1444($fp)	%t222 : int
#   -1448($fp)	%t223 : int
#   -1452($fp)	%t224 : int
#   -1456($fp)	%t225 : int
#   -1460($fp)	%t226 : int
#   -1464($fp)	%t227 : int
#   -1472($fp)	%t228 : double
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_dd_value
__rt_dd_value:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -1488
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param neg : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -524($fp)
	# param e10 : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -528($fp)
	# ifFalse %neg goto .L677   ; line 1116
	lw      $t0, -524($fp)
	beq     $t0, $zero, __rt_dd_value.L677
	# %t13 = -2147483648   ; line 1116
	li      $t0, -2147483648
	sw      $t0, -576($fp)
	# goto .L678   ; line 1116
	b       __rt_dd_value.L678
__rt_dd_value.L677:
	# %t13 = 0   ; line 1116
	move    $t0, $zero
	sw      $t0, -576($fp)
__rt_dd_value.L678:
	# %sign = %t13   ; line 1116
	lw      $t0, -576($fp)
	sw      $t0, -532($fp)
	# %t14 = addr @dd_sticky   ; line 1117
	la      $t0, __rtg_dd_sticky
	sw      $t0, -580($fp)
	# %t15 = load.w %t14   ; line 1117
	lw      $t0, -580($fp)
	lw      $t1, 0($t0)
	sw      $t1, -584($fp)
	# ifFalse %t15 goto .L680   ; line 1117
	lw      $t0, -584($fp)
	beq     $t0, $zero, __rt_dd_value.L680
	# %t16 = addr @dd_dig   ; line 1117
	la      $t0, __rtg_dd_dig
	sw      $t0, -588($fp)
	# %t17 = addr @dd_n   ; line 1117
	la      $t0, __rtg_dd_n
	sw      $t0, -592($fp)
	# %t18 = load.w %t17   ; line 1117
	lw      $t0, -592($fp)
	lw      $t1, 0($t0)
	sw      $t1, -596($fp)
	# %t19 = %t18   ; line 1117
	lw      $t0, -596($fp)
	sw      $t0, -600($fp)
	# %t20 = %t19 + 1   ; line 1117
	lw      $t0, -600($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -604($fp)
	# store.w %t17, %t20   ; line 1117
	lw      $t0, -592($fp)
	lw      $t1, -604($fp)
	sw      $t1, 0($t0)
	# %t21 = %t16 + %t19   ; line 1117
	lw      $t0, -588($fp)
	lw      $t1, -600($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -608($fp)
	# store.b %t21, 49   ; line 1117
	lw      $t0, -608($fp)
	li      $t1, 49
	sb      $t1, 0($t0)
	# %t22 = addr @dd_adj   ; line 1117
	la      $t0, __rtg_dd_adj
	sw      $t0, -612($fp)
	# %t23 = load.w %t22   ; line 1117
	lw      $t0, -612($fp)
	lw      $t1, 0($t0)
	sw      $t1, -616($fp)
	# %t24 = %t23   ; line 1117
	lw      $t0, -616($fp)
	sw      $t0, -620($fp)
	# %t25 = %t24 - 1   ; line 1117
	lw      $t0, -620($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -624($fp)
	# store.w %t22, %t25   ; line 1117
	lw      $t0, -612($fp)
	lw      $t1, -624($fp)
	sw      $t1, 0($t0)
__rt_dd_value.L680:
__rt_dd_value.L681:
	# %t26 = addr @dd_n   ; line 1118
	la      $t0, __rtg_dd_n
	sw      $t0, -628($fp)
	# %t27 = load.w %t26   ; line 1118
	lw      $t0, -628($fp)
	lw      $t1, 0($t0)
	sw      $t1, -632($fp)
	# %t28 = %t27 > 0   ; line 1118
	lw      $t0, -632($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -636($fp)
	# ifFalse %t28 goto .L683   ; line 1118
	lw      $t0, -636($fp)
	beq     $t0, $zero, __rt_dd_value.L683
	# %t29 = addr @dd_dig   ; line 1118
	la      $t0, __rtg_dd_dig
	sw      $t0, -640($fp)
	# %t30 = addr @dd_n   ; line 1118
	la      $t0, __rtg_dd_n
	sw      $t0, -644($fp)
	# %t31 = load.w %t30   ; line 1118
	lw      $t0, -644($fp)
	lw      $t1, 0($t0)
	sw      $t1, -648($fp)
	# %t32 = %t31 - 1   ; line 1118
	lw      $t0, -648($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -652($fp)
	# %t33 = %t29 + %t32   ; line 1118
	lw      $t0, -640($fp)
	lw      $t1, -652($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -656($fp)
	# %t34 = load.b %t33   ; line 1118
	lw      $t0, -656($fp)
	lb      $t1, 0($t0)
	sw      $t1, -660($fp)
	# %t35 = %t34 == 48   ; line 1118
	lw      $t0, -660($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -664($fp)
	# ifFalse %t35 goto .L683   ; line 1118
	lw      $t0, -664($fp)
	beq     $t0, $zero, __rt_dd_value.L683
	# %t36 = addr @dd_n   ; line 1118
	la      $t0, __rtg_dd_n
	sw      $t0, -668($fp)
	# %t37 = load.w %t36   ; line 1118
	lw      $t0, -668($fp)
	lw      $t1, 0($t0)
	sw      $t1, -672($fp)
	# %t38 = %t37   ; line 1118
	lw      $t0, -672($fp)
	sw      $t0, -676($fp)
	# %t39 = %t38 - 1   ; line 1118
	lw      $t0, -676($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -680($fp)
	# store.w %t36, %t39   ; line 1118
	lw      $t0, -668($fp)
	lw      $t1, -680($fp)
	sw      $t1, 0($t0)
	# %t40 = addr @dd_adj   ; line 1118
	la      $t0, __rtg_dd_adj
	sw      $t0, -684($fp)
	# %t41 = load.w %t40   ; line 1118
	lw      $t0, -684($fp)
	lw      $t1, 0($t0)
	sw      $t1, -688($fp)
	# %t42 = %t41   ; line 1118
	lw      $t0, -688($fp)
	sw      $t0, -692($fp)
	# %t43 = %t42 + 1   ; line 1118
	lw      $t0, -692($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -696($fp)
	# store.w %t40, %t43   ; line 1118
	lw      $t0, -684($fp)
	lw      $t1, -696($fp)
	sw      $t1, 0($t0)
	# goto .L681   ; line 1118
	b       __rt_dd_value.L681
__rt_dd_value.L683:
	# %t44 = addr @dd_n   ; line 1119
	la      $t0, __rtg_dd_n
	sw      $t0, -700($fp)
	# %t45 = load.w %t44   ; line 1119
	lw      $t0, -700($fp)
	lw      $t1, 0($t0)
	sw      $t1, -704($fp)
	# %t46 = %t45 == 0   ; line 1119
	lw      $t0, -704($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -708($fp)
	# ifFalse %t46 goto .L685   ; line 1119
	lw      $t0, -708($fp)
	beq     $t0, $zero, __rt_dd_value.L685
	# %t47 = 0   ; line 1119
	move    $t0, $zero
	sw      $t0, -712($fp)
	# param %sign : int   ; line 1119
	lw      $t0, -532($fp)
	sw      $t0, 0($sp)
	# param %t47 : int   ; line 1119
	lw      $t0, -712($fp)
	sw      $t0, 4($sp)
	# %t48 = call @make_double, 2   ; line 1119
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -720($fp)
	# return %t48   ; line 1119
	ldc1    $f0, -720($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L685:
	# %t49 = addr @dd_adj   ; line 1120
	la      $t0, __rtg_dd_adj
	sw      $t0, -724($fp)
	# %t50 = load.w %t49   ; line 1120
	lw      $t0, -724($fp)
	lw      $t1, 0($t0)
	sw      $t1, -728($fp)
	# %t51 = %e10 + %t50   ; line 1120
	lw      $t0, -528($fp)
	lw      $t1, -728($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -732($fp)
	# %e10 = %t51   ; line 1120
	lw      $t0, -732($fp)
	sw      $t0, -528($fp)
	# %t52 = addr @dd_n   ; line 1121
	la      $t0, __rtg_dd_n
	sw      $t0, -736($fp)
	# %t53 = load.w %t52   ; line 1121
	lw      $t0, -736($fp)
	lw      $t1, 0($t0)
	sw      $t1, -740($fp)
	# %t54 = %t53 + %e10   ; line 1121
	lw      $t0, -740($fp)
	lw      $t1, -528($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -744($fp)
	# %t55 = %t54 > 310   ; line 1121
	lw      $t0, -744($fp)
	li      $t1, 310
	slt     $t0, $t1, $t0
	sw      $t0, -748($fp)
	# ifFalse %t55 goto .L687   ; line 1121
	lw      $t0, -748($fp)
	beq     $t0, $zero, __rt_dd_value.L687
	# %t56 = %sign | 2146435072   ; line 1121
	lw      $t0, -532($fp)
	li      $t1, 2146435072
	or      $t0, $t0, $t1
	sw      $t0, -752($fp)
	# %t57 = 0   ; line 1121
	move    $t0, $zero
	sw      $t0, -756($fp)
	# param %t56 : int   ; line 1121
	lw      $t0, -752($fp)
	sw      $t0, 0($sp)
	# param %t57 : int   ; line 1121
	lw      $t0, -756($fp)
	sw      $t0, 4($sp)
	# %t58 = call @make_double, 2   ; line 1121
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -768($fp)
	# return %t58   ; line 1121
	ldc1    $f0, -768($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L687:
	# %t59 = addr @dd_n   ; line 1122
	la      $t0, __rtg_dd_n
	sw      $t0, -772($fp)
	# %t60 = load.w %t59   ; line 1122
	lw      $t0, -772($fp)
	lw      $t1, 0($t0)
	sw      $t1, -776($fp)
	# %t61 = %t60 + %e10   ; line 1122
	lw      $t0, -776($fp)
	lw      $t1, -528($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -780($fp)
	# %t62 = %t61 < -326   ; line 1122
	lw      $t0, -780($fp)
	slti    $t0, $t0, -326
	sw      $t0, -784($fp)
	# ifFalse %t62 goto .L689   ; line 1122
	lw      $t0, -784($fp)
	beq     $t0, $zero, __rt_dd_value.L689
	# %t63 = 0   ; line 1122
	move    $t0, $zero
	sw      $t0, -788($fp)
	# param %sign : int   ; line 1122
	lw      $t0, -532($fp)
	sw      $t0, 0($sp)
	# param %t63 : int   ; line 1122
	lw      $t0, -788($fp)
	sw      $t0, 4($sp)
	# %t64 = call @make_double, 2   ; line 1122
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -800($fp)
	# return %t64   ; line 1122
	ldc1    $f0, -800($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L689:
	# %t65 = addr @bg_num   ; line 1123
	la      $t0, __rtg_bg_num
	sw      $t0, -804($fp)
	# %t66 = 0   ; line 1123
	move    $t0, $zero
	sw      $t0, -808($fp)
	# param %t65 : ptr   ; line 1123
	lw      $t0, -804($fp)
	sw      $t0, 0($sp)
	# param %t66 : int   ; line 1123
	lw      $t0, -808($fp)
	sw      $t0, 4($sp)
	# call @big_set, 2   ; line 1123
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_set
	# %i = 0   ; line 1124
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L690:
	# %t67 = addr @dd_n   ; line 1124
	la      $t0, __rtg_dd_n
	sw      $t0, -812($fp)
	# %t68 = load.w %t67   ; line 1124
	lw      $t0, -812($fp)
	lw      $t1, 0($t0)
	sw      $t1, -816($fp)
	# %t69 = %i < %t68   ; line 1124
	lw      $t0, -536($fp)
	lw      $t1, -816($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -820($fp)
	# ifFalse %t69 goto .L693   ; line 1124
	lw      $t0, -820($fp)
	beq     $t0, $zero, __rt_dd_value.L693
	# %t70 = addr @bg_num   ; line 1124
	la      $t0, __rtg_bg_num
	sw      $t0, -824($fp)
	# %t71 = 10   ; line 1124
	li      $t0, 10
	sw      $t0, -828($fp)
	# %t72 = addr @dd_dig   ; line 1124
	la      $t0, __rtg_dd_dig
	sw      $t0, -832($fp)
	# %t73 = %t72 + %i   ; line 1124
	lw      $t0, -832($fp)
	lw      $t1, -536($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -836($fp)
	# %t74 = load.b %t73   ; line 1124
	lw      $t0, -836($fp)
	lb      $t1, 0($t0)
	sw      $t1, -840($fp)
	# %t75 = %t74 - 48   ; line 1124
	lw      $t0, -840($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -844($fp)
	# param %t70 : ptr   ; line 1124
	lw      $t0, -824($fp)
	sw      $t0, 0($sp)
	# param %t71 : int   ; line 1124
	lw      $t0, -828($fp)
	sw      $t0, 4($sp)
	# param %t75 : int   ; line 1124
	lw      $t0, -844($fp)
	sw      $t0, 8($sp)
	# call @big_muladd, 3   ; line 1124
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_big_muladd
	# %t76 = %i   ; line 1124
	lw      $t0, -536($fp)
	sw      $t0, -848($fp)
	# %t77 = %t76 + 1   ; line 1124
	lw      $t0, -848($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -852($fp)
	# %i = %t77   ; line 1124
	lw      $t0, -852($fp)
	sw      $t0, -536($fp)
	# goto .L690   ; line 1124
	b       __rt_dd_value.L690
__rt_dd_value.L693:
	# %t78 = addr @bg_den   ; line 1125
	la      $t0, __rtg_bg_den
	sw      $t0, -856($fp)
	# %t79 = 1   ; line 1125
	li      $t0, 1
	sw      $t0, -860($fp)
	# param %t78 : ptr   ; line 1125
	lw      $t0, -856($fp)
	sw      $t0, 0($sp)
	# param %t79 : int   ; line 1125
	lw      $t0, -860($fp)
	sw      $t0, 4($sp)
	# call @big_set, 2   ; line 1125
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_set
	# %t80 = %e10 >= 0   ; line 1126
	lw      $t0, -528($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -864($fp)
	# ifFalse %t80 goto .L695   ; line 1126
	lw      $t0, -864($fp)
	beq     $t0, $zero, __rt_dd_value.L695
	# %t81 = addr @bg_num   ; line 1126
	la      $t0, __rtg_bg_num
	sw      $t0, -868($fp)
	# param %t81 : ptr   ; line 1126
	lw      $t0, -868($fp)
	sw      $t0, 0($sp)
	# param %e10 : int   ; line 1126
	lw      $t0, -528($fp)
	sw      $t0, 4($sp)
	# call @big_pow10, 2   ; line 1126
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_pow10
	# goto .L696   ; line 1126
	b       __rt_dd_value.L696
__rt_dd_value.L695:
	# %t82 = addr @bg_den   ; line 1127
	la      $t0, __rtg_bg_den
	sw      $t0, -872($fp)
	# %t83 = - %e10   ; line 1127
	lw      $t0, -528($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -876($fp)
	# param %t82 : ptr   ; line 1127
	lw      $t0, -872($fp)
	sw      $t0, 0($sp)
	# param %t83 : int   ; line 1127
	lw      $t0, -876($fp)
	sw      $t0, 4($sp)
	# call @big_pow10, 2   ; line 1127
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_pow10
__rt_dd_value.L696:
	# %t84 = addr @bg_num   ; line 1128
	la      $t0, __rtg_bg_num
	sw      $t0, -880($fp)
	# param %t84 : ptr   ; line 1128
	lw      $t0, -880($fp)
	sw      $t0, 0($sp)
	# %t85 = call @big_bits, 1   ; line 1128
	lw      $a0, 0($sp)
	jal     __rt_big_bits
	sw      $v0, -884($fp)
	# %t86 = addr @bg_den   ; line 1128
	la      $t0, __rtg_bg_den
	sw      $t0, -888($fp)
	# param %t86 : ptr   ; line 1128
	lw      $t0, -888($fp)
	sw      $t0, 0($sp)
	# %t87 = call @big_bits, 1   ; line 1128
	lw      $a0, 0($sp)
	jal     __rt_big_bits
	sw      $v0, -892($fp)
	# %t88 = %t85 - %t87   ; line 1128
	lw      $t0, -884($fp)
	lw      $t1, -892($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -896($fp)
	# %t89 = 55 - %t88   ; line 1128
	li      $t0, 55
	lw      $t1, -896($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -900($fp)
	# %sh = %t89   ; line 1128
	lw      $t0, -900($fp)
	sw      $t0, -544($fp)
	# %t90 = %sh > 0   ; line 1129
	lw      $t0, -544($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -904($fp)
	# ifFalse %t90 goto .L698   ; line 1129
	lw      $t0, -904($fp)
	beq     $t0, $zero, __rt_dd_value.L698
	# %t91 = addr @bg_num   ; line 1129
	la      $t0, __rtg_bg_num
	sw      $t0, -908($fp)
	# param %t91 : ptr   ; line 1129
	lw      $t0, -908($fp)
	sw      $t0, 0($sp)
	# param %sh : int   ; line 1129
	lw      $t0, -544($fp)
	sw      $t0, 4($sp)
	# call @big_shl, 2   ; line 1129
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_shl
	# goto .L699   ; line 1129
	b       __rt_dd_value.L699
__rt_dd_value.L698:
	# %t92 = %sh < 0   ; line 1130
	lw      $t0, -544($fp)
	slti    $t0, $t0, 0
	sw      $t0, -912($fp)
	# ifFalse %t92 goto .L701   ; line 1130
	lw      $t0, -912($fp)
	beq     $t0, $zero, __rt_dd_value.L701
	# %t93 = addr @bg_den   ; line 1130
	la      $t0, __rtg_bg_den
	sw      $t0, -916($fp)
	# %t94 = - %sh   ; line 1130
	lw      $t0, -544($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -920($fp)
	# param %t93 : ptr   ; line 1130
	lw      $t0, -916($fp)
	sw      $t0, 0($sp)
	# param %t94 : int   ; line 1130
	lw      $t0, -920($fp)
	sw      $t0, 4($sp)
	# call @big_shl, 2   ; line 1130
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_shl
__rt_dd_value.L701:
__rt_dd_value.L699:
	# %t95 = addr @bg_den   ; line 1132
	la      $t0, __rtg_bg_den
	sw      $t0, -924($fp)
	# %t96 = 55   ; line 1132
	li      $t0, 55
	sw      $t0, -928($fp)
	# param %t95 : ptr   ; line 1132
	lw      $t0, -924($fp)
	sw      $t0, 0($sp)
	# param %t96 : int   ; line 1132
	lw      $t0, -928($fp)
	sw      $t0, 4($sp)
	# call @big_shl, 2   ; line 1132
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_shl
	# %k = 55   ; line 1133
	li      $t0, 55
	sw      $t0, -540($fp)
__rt_dd_value.L702:
	# %t97 = %k >= 0   ; line 1133
	lw      $t0, -540($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -932($fp)
	# ifFalse %t97 goto .L705   ; line 1133
	lw      $t0, -932($fp)
	beq     $t0, $zero, __rt_dd_value.L705
	# %t98 = addr qb   ; line 1134
	addiu   $t0, $fp, -520
	sw      $t0, -936($fp)
	# %t99 = %k * 4   ; line 1134
	lw      $t0, -540($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -940($fp)
	# %t100 = %t98 + %t99   ; line 1134
	lw      $t0, -936($fp)
	lw      $t1, -940($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -944($fp)
	# store.w %t100, 0   ; line 1134
	lw      $t0, -944($fp)
	sw      $zero, 0($t0)
	# %t101 = addr @bg_num   ; line 1135
	la      $t0, __rtg_bg_num
	sw      $t0, -948($fp)
	# %t102 = addr @bg_den   ; line 1135
	la      $t0, __rtg_bg_den
	sw      $t0, -952($fp)
	# param %t101 : ptr   ; line 1135
	lw      $t0, -948($fp)
	sw      $t0, 0($sp)
	# param %t102 : ptr   ; line 1135
	lw      $t0, -952($fp)
	sw      $t0, 4($sp)
	# %t103 = call @big_cmp, 2   ; line 1135
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_cmp
	sw      $v0, -956($fp)
	# %t104 = %t103 >= 0   ; line 1135
	lw      $t0, -956($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -960($fp)
	# ifFalse %t104 goto .L707   ; line 1135
	lw      $t0, -960($fp)
	beq     $t0, $zero, __rt_dd_value.L707
	# %t105 = addr @bg_num   ; line 1136
	la      $t0, __rtg_bg_num
	sw      $t0, -964($fp)
	# %t106 = addr @bg_den   ; line 1136
	la      $t0, __rtg_bg_den
	sw      $t0, -968($fp)
	# param %t105 : ptr   ; line 1136
	lw      $t0, -964($fp)
	sw      $t0, 0($sp)
	# param %t106 : ptr   ; line 1136
	lw      $t0, -968($fp)
	sw      $t0, 4($sp)
	# call @big_sub, 2   ; line 1136
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_big_sub
	# %t107 = addr qb   ; line 1137
	addiu   $t0, $fp, -520
	sw      $t0, -972($fp)
	# %t108 = %k * 4   ; line 1137
	lw      $t0, -540($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -976($fp)
	# %t109 = %t107 + %t108   ; line 1137
	lw      $t0, -972($fp)
	lw      $t1, -976($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -980($fp)
	# store.w %t109, 1   ; line 1137
	lw      $t0, -980($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_dd_value.L707:
	# %t110 = addr @bg_den   ; line 1139
	la      $t0, __rtg_bg_den
	sw      $t0, -984($fp)
	# param %t110 : ptr   ; line 1139
	lw      $t0, -984($fp)
	sw      $t0, 0($sp)
	# call @big_shr1, 1   ; line 1139
	lw      $a0, 0($sp)
	jal     __rt_big_shr1
	# %t111 = %k   ; line 1133
	lw      $t0, -540($fp)
	sw      $t0, -988($fp)
	# %t112 = %t111 - 1   ; line 1133
	lw      $t0, -988($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -992($fp)
	# %k = %t112   ; line 1133
	lw      $t0, -992($fp)
	sw      $t0, -540($fp)
	# goto .L702   ; line 1133
	b       __rt_dd_value.L702
__rt_dd_value.L705:
	# %t113 = addr @bg_num   ; line 1141
	la      $t0, __rtg_bg_num
	sw      $t0, -996($fp)
	# %t114 = load.w %t113   ; line 1141
	lw      $t0, -996($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1000($fp)
	# %t115 = %t114 != 0   ; line 1141
	lw      $t0, -1000($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -1004($fp)
	# %sticky = %t115   ; line 1141
	lw      $t0, -1004($fp)
	sw      $t0, -564($fp)
	# %len = 56   ; line 1142
	li      $t0, 56
	sw      $t0, -548($fp)
__rt_dd_value.L708:
	# %t116 = addr qb   ; line 1143
	addiu   $t0, $fp, -520
	sw      $t0, -1008($fp)
	# %t117 = %len - 1   ; line 1143
	lw      $t0, -548($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1012($fp)
	# %t118 = %t117 * 4   ; line 1143
	lw      $t0, -1012($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1016($fp)
	# %t119 = %t116 + %t118   ; line 1143
	lw      $t0, -1008($fp)
	lw      $t1, -1016($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1020($fp)
	# %t120 = load.w %t119   ; line 1143
	lw      $t0, -1020($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1024($fp)
	# %t121 = %t120 == 0   ; line 1143
	lw      $t0, -1024($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -1028($fp)
	# ifFalse %t121 goto .L710   ; line 1143
	lw      $t0, -1028($fp)
	beq     $t0, $zero, __rt_dd_value.L710
	# %t122 = %len   ; line 1143
	lw      $t0, -548($fp)
	sw      $t0, -1032($fp)
	# %t123 = %t122 - 1   ; line 1143
	lw      $t0, -1032($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1036($fp)
	# %len = %t123   ; line 1143
	lw      $t0, -1036($fp)
	sw      $t0, -548($fp)
	# goto .L708   ; line 1143
	b       __rt_dd_value.L708
__rt_dd_value.L710:
	# %t124 = %len - 1   ; line 1144
	lw      $t0, -548($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1040($fp)
	# %t125 = %t124 - %sh   ; line 1144
	lw      $t0, -1040($fp)
	lw      $t1, -544($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -1044($fp)
	# %ex = %t125   ; line 1144
	lw      $t0, -1044($fp)
	sw      $t0, -552($fp)
	# %t126 = %ex > 1023   ; line 1145
	lw      $t0, -552($fp)
	li      $t1, 1023
	slt     $t0, $t1, $t0
	sw      $t0, -1048($fp)
	# ifFalse %t126 goto .L712   ; line 1145
	lw      $t0, -1048($fp)
	beq     $t0, $zero, __rt_dd_value.L712
	# %t127 = %sign | 2146435072   ; line 1145
	lw      $t0, -532($fp)
	li      $t1, 2146435072
	or      $t0, $t0, $t1
	sw      $t0, -1052($fp)
	# %t128 = 0   ; line 1145
	move    $t0, $zero
	sw      $t0, -1056($fp)
	# param %t127 : int   ; line 1145
	lw      $t0, -1052($fp)
	sw      $t0, 0($sp)
	# param %t128 : int   ; line 1145
	lw      $t0, -1056($fp)
	sw      $t0, 4($sp)
	# %t129 = call @make_double, 2   ; line 1145
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -1064($fp)
	# return %t129   ; line 1145
	ldc1    $f0, -1064($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L712:
	# %keep = 53   ; line 1146
	li      $t0, 53
	sw      $t0, -556($fp)
	# %t130 = %ex < -1022   ; line 1147
	lw      $t0, -552($fp)
	slti    $t0, $t0, -1022
	sw      $t0, -1068($fp)
	# ifFalse %t130 goto .L714   ; line 1147
	lw      $t0, -1068($fp)
	beq     $t0, $zero, __rt_dd_value.L714
	# %t131 = %ex + 1075   ; line 1147
	lw      $t0, -552($fp)
	addiu   $t0, $t0, 1075
	sw      $t0, -1072($fp)
	# %keep = %t131   ; line 1147
	lw      $t0, -1072($fp)
	sw      $t0, -556($fp)
__rt_dd_value.L714:
	# %t132 = %keep < 0   ; line 1148
	lw      $t0, -556($fp)
	slti    $t0, $t0, 0
	sw      $t0, -1076($fp)
	# ifFalse %t132 goto .L716   ; line 1148
	lw      $t0, -1076($fp)
	beq     $t0, $zero, __rt_dd_value.L716
	# %t133 = 0   ; line 1148
	move    $t0, $zero
	sw      $t0, -1080($fp)
	# param %sign : int   ; line 1148
	lw      $t0, -532($fp)
	sw      $t0, 0($sp)
	# param %t133 : int   ; line 1148
	lw      $t0, -1080($fp)
	sw      $t0, 4($sp)
	# %t134 = call @make_double, 2   ; line 1148
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -1088($fp)
	# return %t134   ; line 1148
	ldc1    $f0, -1088($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L716:
	# %t135 = %len - 1   ; line 1149
	lw      $t0, -548($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1092($fp)
	# %t136 = %t135 - %keep   ; line 1149
	lw      $t0, -1092($fp)
	lw      $t1, -556($fp)
	subu    $t0, $t0, $t1
	sw      $t0, -1096($fp)
	# %rb = %t136   ; line 1149
	lw      $t0, -1096($fp)
	sw      $t0, -560($fp)
	# %i = 0   ; line 1150
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L717:
	# %t137 = %i < 64   ; line 1150
	lw      $t0, -536($fp)
	slti    $t0, $t0, 64
	sw      $t0, -1100($fp)
	# ifFalse %t137 goto .L720   ; line 1150
	lw      $t0, -1100($fp)
	beq     $t0, $zero, __rt_dd_value.L720
	# %t138 = addr mb   ; line 1150
	addiu   $t0, $fp, -264
	sw      $t0, -1104($fp)
	# %t139 = %i * 4   ; line 1150
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1108($fp)
	# %t140 = %t138 + %t139   ; line 1150
	lw      $t0, -1104($fp)
	lw      $t1, -1108($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1112($fp)
	# store.w %t140, 0   ; line 1150
	lw      $t0, -1112($fp)
	sw      $zero, 0($t0)
	# %t141 = %i   ; line 1150
	lw      $t0, -536($fp)
	sw      $t0, -1116($fp)
	# %t142 = %t141 + 1   ; line 1150
	lw      $t0, -1116($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1120($fp)
	# %i = %t142   ; line 1150
	lw      $t0, -1120($fp)
	sw      $t0, -536($fp)
	# goto .L717   ; line 1150
	b       __rt_dd_value.L717
__rt_dd_value.L720:
	# %i = 0   ; line 1151
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L721:
	# %t143 = %i < %keep   ; line 1151
	lw      $t0, -536($fp)
	lw      $t1, -556($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -1124($fp)
	# ifFalse %t143 goto .L724   ; line 1151
	lw      $t0, -1124($fp)
	beq     $t0, $zero, __rt_dd_value.L724
	# %t144 = addr mb   ; line 1151
	addiu   $t0, $fp, -264
	sw      $t0, -1128($fp)
	# %t145 = %i * 4   ; line 1151
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1132($fp)
	# %t146 = %t144 + %t145   ; line 1151
	lw      $t0, -1128($fp)
	lw      $t1, -1132($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1136($fp)
	# %t147 = addr qb   ; line 1151
	addiu   $t0, $fp, -520
	sw      $t0, -1140($fp)
	# %t148 = %rb + 1   ; line 1151
	lw      $t0, -560($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1144($fp)
	# %t149 = %t148 + %i   ; line 1151
	lw      $t0, -1144($fp)
	lw      $t1, -536($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1148($fp)
	# %t150 = %t149 * 4   ; line 1151
	lw      $t0, -1148($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1152($fp)
	# %t151 = %t147 + %t150   ; line 1151
	lw      $t0, -1140($fp)
	lw      $t1, -1152($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1156($fp)
	# %t152 = load.w %t151   ; line 1151
	lw      $t0, -1156($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1160($fp)
	# store.w %t146, %t152   ; line 1151
	lw      $t0, -1136($fp)
	lw      $t1, -1160($fp)
	sw      $t1, 0($t0)
	# %t153 = %i   ; line 1151
	lw      $t0, -536($fp)
	sw      $t0, -1164($fp)
	# %t154 = %t153 + 1   ; line 1151
	lw      $t0, -1164($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1168($fp)
	# %i = %t154   ; line 1151
	lw      $t0, -1168($fp)
	sw      $t0, -536($fp)
	# goto .L721   ; line 1151
	b       __rt_dd_value.L721
__rt_dd_value.L724:
	# %i = 0   ; line 1152
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L725:
	# %t155 = %i < %rb   ; line 1152
	lw      $t0, -536($fp)
	lw      $t1, -560($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -1172($fp)
	# ifFalse %t155 goto .L728   ; line 1152
	lw      $t0, -1172($fp)
	beq     $t0, $zero, __rt_dd_value.L728
	# %t156 = addr qb   ; line 1152
	addiu   $t0, $fp, -520
	sw      $t0, -1176($fp)
	# %t157 = %i * 4   ; line 1152
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1180($fp)
	# %t158 = %t156 + %t157   ; line 1152
	lw      $t0, -1176($fp)
	lw      $t1, -1180($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1184($fp)
	# %t159 = load.w %t158   ; line 1152
	lw      $t0, -1184($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1188($fp)
	# ifFalse %t159 goto .L730   ; line 1152
	lw      $t0, -1188($fp)
	beq     $t0, $zero, __rt_dd_value.L730
	# %sticky = 1   ; line 1152
	li      $t0, 1
	sw      $t0, -564($fp)
__rt_dd_value.L730:
	# %t160 = %i   ; line 1152
	lw      $t0, -536($fp)
	sw      $t0, -1192($fp)
	# %t161 = %t160 + 1   ; line 1152
	lw      $t0, -1192($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1196($fp)
	# %i = %t161   ; line 1152
	lw      $t0, -1196($fp)
	sw      $t0, -536($fp)
	# goto .L725   ; line 1152
	b       __rt_dd_value.L725
__rt_dd_value.L728:
	# %t162 = addr qb   ; line 1153
	addiu   $t0, $fp, -520
	sw      $t0, -1200($fp)
	# %t163 = %rb * 4   ; line 1153
	lw      $t0, -560($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1204($fp)
	# %t164 = %t162 + %t163   ; line 1153
	lw      $t0, -1200($fp)
	lw      $t1, -1204($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1208($fp)
	# %t165 = load.w %t164   ; line 1153
	lw      $t0, -1208($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1212($fp)
	# ifFalse %t165 goto .L732   ; line 1153
	lw      $t0, -1212($fp)
	beq     $t0, $zero, __rt_dd_value.L732
	# if %sticky goto .L731   ; line 1153
	lw      $t0, -564($fp)
	bne     $t0, $zero, __rt_dd_value.L731
	# %t166 = addr mb   ; line 1153
	addiu   $t0, $fp, -264
	sw      $t0, -1216($fp)
	# %t167 = %t166 + 0   ; line 1153
	lw      $t0, -1216($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -1220($fp)
	# %t168 = load.w %t167   ; line 1153
	lw      $t0, -1220($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1224($fp)
	# ifFalse %t168 goto .L732   ; line 1153
	lw      $t0, -1224($fp)
	beq     $t0, $zero, __rt_dd_value.L732
__rt_dd_value.L731:
	# %i = 0   ; line 1154
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L733:
	# %t169 = addr mb   ; line 1155
	addiu   $t0, $fp, -264
	sw      $t0, -1228($fp)
	# %t170 = %i * 4   ; line 1155
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1232($fp)
	# %t171 = %t169 + %t170   ; line 1155
	lw      $t0, -1228($fp)
	lw      $t1, -1232($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1236($fp)
	# %t172 = load.w %t171   ; line 1155
	lw      $t0, -1236($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1240($fp)
	# ifFalse %t172 goto .L735   ; line 1155
	lw      $t0, -1240($fp)
	beq     $t0, $zero, __rt_dd_value.L735
	# %t173 = addr mb   ; line 1155
	addiu   $t0, $fp, -264
	sw      $t0, -1244($fp)
	# %t174 = %i * 4   ; line 1155
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1248($fp)
	# %t175 = %t173 + %t174   ; line 1155
	lw      $t0, -1244($fp)
	lw      $t1, -1248($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1252($fp)
	# store.w %t175, 0   ; line 1155
	lw      $t0, -1252($fp)
	sw      $zero, 0($t0)
	# %t176 = %i   ; line 1155
	lw      $t0, -536($fp)
	sw      $t0, -1256($fp)
	# %t177 = %t176 + 1   ; line 1155
	lw      $t0, -1256($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1260($fp)
	# %i = %t177   ; line 1155
	lw      $t0, -1260($fp)
	sw      $t0, -536($fp)
	# goto .L733   ; line 1155
	b       __rt_dd_value.L733
__rt_dd_value.L735:
	# %t178 = addr mb   ; line 1156
	addiu   $t0, $fp, -264
	sw      $t0, -1264($fp)
	# %t179 = %i * 4   ; line 1156
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1268($fp)
	# %t180 = %t178 + %t179   ; line 1156
	lw      $t0, -1264($fp)
	lw      $t1, -1268($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1272($fp)
	# store.w %t180, 1   ; line 1156
	lw      $t0, -1272($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_dd_value.L732:
	# %t181 = %keep == 53   ; line 1158
	lw      $t0, -556($fp)
	xori    $t0, $t0, 53
	sltiu   $t0, $t0, 1
	sw      $t0, -1276($fp)
	# ifFalse %t181 goto .L737   ; line 1158
	lw      $t0, -1276($fp)
	beq     $t0, $zero, __rt_dd_value.L737
	# %t182 = addr mb   ; line 1158
	addiu   $t0, $fp, -264
	sw      $t0, -1280($fp)
	# %t183 = %t182 + 212   ; line 1158
	lw      $t0, -1280($fp)
	addiu   $t0, $t0, 212
	sw      $t0, -1284($fp)
	# %t184 = load.w %t183   ; line 1158
	lw      $t0, -1284($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1288($fp)
	# ifFalse %t184 goto .L737   ; line 1158
	lw      $t0, -1288($fp)
	beq     $t0, $zero, __rt_dd_value.L737
	# %i = 0   ; line 1159
	move    $t0, $zero
	sw      $t0, -536($fp)
__rt_dd_value.L738:
	# %t185 = %i < 53   ; line 1159
	lw      $t0, -536($fp)
	slti    $t0, $t0, 53
	sw      $t0, -1292($fp)
	# ifFalse %t185 goto .L741   ; line 1159
	lw      $t0, -1292($fp)
	beq     $t0, $zero, __rt_dd_value.L741
	# %t186 = addr mb   ; line 1159
	addiu   $t0, $fp, -264
	sw      $t0, -1296($fp)
	# %t187 = %i * 4   ; line 1159
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1300($fp)
	# %t188 = %t186 + %t187   ; line 1159
	lw      $t0, -1296($fp)
	lw      $t1, -1300($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1304($fp)
	# %t189 = addr mb   ; line 1159
	addiu   $t0, $fp, -264
	sw      $t0, -1308($fp)
	# %t190 = %i + 1   ; line 1159
	lw      $t0, -536($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1312($fp)
	# %t191 = %t190 * 4   ; line 1159
	lw      $t0, -1312($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1316($fp)
	# %t192 = %t189 + %t191   ; line 1159
	lw      $t0, -1308($fp)
	lw      $t1, -1316($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1320($fp)
	# %t193 = load.w %t192   ; line 1159
	lw      $t0, -1320($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1324($fp)
	# store.w %t188, %t193   ; line 1159
	lw      $t0, -1304($fp)
	lw      $t1, -1324($fp)
	sw      $t1, 0($t0)
	# %t194 = %i   ; line 1159
	lw      $t0, -536($fp)
	sw      $t0, -1328($fp)
	# %t195 = %t194 + 1   ; line 1159
	lw      $t0, -1328($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1332($fp)
	# %i = %t195   ; line 1159
	lw      $t0, -1332($fp)
	sw      $t0, -536($fp)
	# goto .L738   ; line 1159
	b       __rt_dd_value.L738
__rt_dd_value.L741:
	# %t196 = addr mb   ; line 1160
	addiu   $t0, $fp, -264
	sw      $t0, -1336($fp)
	# %t197 = %t196 + 212   ; line 1160
	lw      $t0, -1336($fp)
	addiu   $t0, $t0, 212
	sw      $t0, -1340($fp)
	# store.w %t197, 0   ; line 1160
	lw      $t0, -1340($fp)
	sw      $zero, 0($t0)
	# %t198 = %ex   ; line 1161
	lw      $t0, -552($fp)
	sw      $t0, -1344($fp)
	# %t199 = %t198 + 1   ; line 1161
	lw      $t0, -1344($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -1348($fp)
	# %ex = %t199   ; line 1161
	lw      $t0, -1348($fp)
	sw      $t0, -552($fp)
	# %t200 = %ex > 1023   ; line 1162
	lw      $t0, -552($fp)
	li      $t1, 1023
	slt     $t0, $t1, $t0
	sw      $t0, -1352($fp)
	# ifFalse %t200 goto .L743   ; line 1162
	lw      $t0, -1352($fp)
	beq     $t0, $zero, __rt_dd_value.L743
	# %t201 = %sign | 2146435072   ; line 1162
	lw      $t0, -532($fp)
	li      $t1, 2146435072
	or      $t0, $t0, $t1
	sw      $t0, -1356($fp)
	# %t202 = 0   ; line 1162
	move    $t0, $zero
	sw      $t0, -1360($fp)
	# param %t201 : int   ; line 1162
	lw      $t0, -1356($fp)
	sw      $t0, 0($sp)
	# param %t202 : int   ; line 1162
	lw      $t0, -1360($fp)
	sw      $t0, 4($sp)
	# %t203 = call @make_double, 2   ; line 1162
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -1368($fp)
	# return %t203   ; line 1162
	ldc1    $f0, -1368($fp)
	b       __rt_dd_value.ret
__rt_dd_value.L743:
__rt_dd_value.L737:
	# %lo = 0   ; line 1164
	move    $t0, $zero
	sw      $t0, -572($fp)
	# %i = 31   ; line 1165
	li      $t0, 31
	sw      $t0, -536($fp)
__rt_dd_value.L744:
	# %t204 = %i >= 0   ; line 1165
	lw      $t0, -536($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -1372($fp)
	# ifFalse %t204 goto .L747   ; line 1165
	lw      $t0, -1372($fp)
	beq     $t0, $zero, __rt_dd_value.L747
	# %t205 = %lo << 1   ; line 1165
	lw      $t0, -572($fp)
	sll     $t0, $t0, 1
	sw      $t0, -1376($fp)
	# %t206 = addr mb   ; line 1165
	addiu   $t0, $fp, -264
	sw      $t0, -1380($fp)
	# %t207 = %i * 4   ; line 1165
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1384($fp)
	# %t208 = %t206 + %t207   ; line 1165
	lw      $t0, -1380($fp)
	lw      $t1, -1384($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1388($fp)
	# %t209 = load.w %t208   ; line 1165
	lw      $t0, -1388($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1392($fp)
	# %t210 = %t205 | %t209   ; line 1165
	lw      $t0, -1376($fp)
	lw      $t1, -1392($fp)
	or      $t0, $t0, $t1
	sw      $t0, -1396($fp)
	# %lo = %t210   ; line 1165
	lw      $t0, -1396($fp)
	sw      $t0, -572($fp)
	# %t211 = %i   ; line 1165
	lw      $t0, -536($fp)
	sw      $t0, -1400($fp)
	# %t212 = %t211 - 1   ; line 1165
	lw      $t0, -1400($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1404($fp)
	# %i = %t212   ; line 1165
	lw      $t0, -1404($fp)
	sw      $t0, -536($fp)
	# goto .L744   ; line 1165
	b       __rt_dd_value.L744
__rt_dd_value.L747:
	# %hi = 0   ; line 1166
	move    $t0, $zero
	sw      $t0, -568($fp)
	# %i = 52   ; line 1167
	li      $t0, 52
	sw      $t0, -536($fp)
__rt_dd_value.L748:
	# %t213 = %i >= 32   ; line 1167
	lw      $t0, -536($fp)
	slti    $t0, $t0, 32
	xori    $t0, $t0, 1
	sw      $t0, -1408($fp)
	# ifFalse %t213 goto .L751   ; line 1167
	lw      $t0, -1408($fp)
	beq     $t0, $zero, __rt_dd_value.L751
	# %t214 = %hi << 1   ; line 1167
	lw      $t0, -568($fp)
	sll     $t0, $t0, 1
	sw      $t0, -1412($fp)
	# %t215 = addr mb   ; line 1167
	addiu   $t0, $fp, -264
	sw      $t0, -1416($fp)
	# %t216 = %i * 4   ; line 1167
	lw      $t0, -536($fp)
	li      $t1, 4
	mul     $t0, $t0, $t1
	sw      $t0, -1420($fp)
	# %t217 = %t215 + %t216   ; line 1167
	lw      $t0, -1416($fp)
	lw      $t1, -1420($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -1424($fp)
	# %t218 = load.w %t217   ; line 1167
	lw      $t0, -1424($fp)
	lw      $t1, 0($t0)
	sw      $t1, -1428($fp)
	# %t219 = %t214 | %t218   ; line 1167
	lw      $t0, -1412($fp)
	lw      $t1, -1428($fp)
	or      $t0, $t0, $t1
	sw      $t0, -1432($fp)
	# %hi = %t219   ; line 1167
	lw      $t0, -1432($fp)
	sw      $t0, -568($fp)
	# %t220 = %i   ; line 1167
	lw      $t0, -536($fp)
	sw      $t0, -1436($fp)
	# %t221 = %t220 - 1   ; line 1167
	lw      $t0, -1436($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -1440($fp)
	# %i = %t221   ; line 1167
	lw      $t0, -1440($fp)
	sw      $t0, -536($fp)
	# goto .L748   ; line 1167
	b       __rt_dd_value.L748
__rt_dd_value.L751:
	# %t222 = %keep == 53   ; line 1168
	lw      $t0, -556($fp)
	xori    $t0, $t0, 53
	sltiu   $t0, $t0, 1
	sw      $t0, -1444($fp)
	# ifFalse %t222 goto .L753   ; line 1168
	lw      $t0, -1444($fp)
	beq     $t0, $zero, __rt_dd_value.L753
	# %t223 = %hi & 1048575   ; line 1168
	lw      $t0, -568($fp)
	li      $t1, 1048575
	and     $t0, $t0, $t1
	sw      $t0, -1448($fp)
	# %t224 = %ex + 1023   ; line 1168
	lw      $t0, -552($fp)
	addiu   $t0, $t0, 1023
	sw      $t0, -1452($fp)
	# %t225 = %t224 << 20   ; line 1168
	lw      $t0, -1452($fp)
	sll     $t0, $t0, 20
	sw      $t0, -1456($fp)
	# %t226 = %t223 | %t225   ; line 1168
	lw      $t0, -1448($fp)
	lw      $t1, -1456($fp)
	or      $t0, $t0, $t1
	sw      $t0, -1460($fp)
	# %hi = %t226   ; line 1168
	lw      $t0, -1460($fp)
	sw      $t0, -568($fp)
__rt_dd_value.L753:
	# %t227 = %sign | %hi   ; line 1169
	lw      $t0, -532($fp)
	lw      $t1, -568($fp)
	or      $t0, $t0, $t1
	sw      $t0, -1464($fp)
	# param %t227 : int   ; line 1169
	lw      $t0, -1464($fp)
	sw      $t0, 0($sp)
	# param %lo : int   ; line 1169
	lw      $t0, -572($fp)
	sw      $t0, 4($sp)
	# %t228 = call @make_double, 2   ; line 1169
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_make_double
	sdc1    $f0, -1472($fp)
	# return %t228   ; line 1169
	ldc1    $f0, -1472($fp)
__rt_dd_value.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_sc_get
	.text
# ---------------------------------------------------------------
# function sc_get (line 1183), returns int
# frame 96 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : str
#   -32($fp)	%t5 : char
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : str
#   -56($fp)	%t11 : str
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_sc_get
__rt_sc_get:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -96
	# %t1 = addr @sc_str   ; line 1185
	la      $t0, __rtg_sc_str
	sw      $t0, -16($fp)
	# %t2 = load.w %t1   ; line 1185
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# ifFalse %t2 goto .L755   ; line 1185
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_sc_get.L755
	# %t3 = addr @sc_s   ; line 1186
	la      $t0, __rtg_sc_s
	sw      $t0, -24($fp)
	# %t4 = load.w %t3   ; line 1186
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -28($fp)
	# %t5 = load.b %t4   ; line 1186
	lw      $t0, -28($fp)
	lb      $t1, 0($t0)
	sw      $t1, -32($fp)
	# %t6 = %t5 & 255   ; line 1186
	lw      $t0, -32($fp)
	andi    $t0, $t0, 255
	sw      $t0, -36($fp)
	# %c = %t6   ; line 1186
	lw      $t0, -36($fp)
	sw      $t0, -12($fp)
	# %t7 = %c == 0   ; line 1187
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L757   ; line 1187
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_sc_get.L757
	# %c = -1   ; line 1187
	li      $t0, -1
	sw      $t0, -12($fp)
	# goto .L758   ; line 1187
	b       __rt_sc_get.L758
__rt_sc_get.L757:
	# %t8 = addr @sc_s   ; line 1188
	la      $t0, __rtg_sc_s
	sw      $t0, -44($fp)
	# %t9 = addr @sc_s   ; line 1188
	la      $t0, __rtg_sc_s
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 1188
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 + 1   ; line 1188
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# store.w %t8, %t11   ; line 1188
	lw      $t0, -44($fp)
	lw      $t1, -56($fp)
	sw      $t1, 0($t0)
__rt_sc_get.L758:
	# goto .L759   ; line 1188
	b       __rt_sc_get.L759
__rt_sc_get.L755:
	# %t12 = addr @sc_f   ; line 1189
	la      $t0, __rtg_sc_f
	sw      $t0, -60($fp)
	# %t13 = load.w %t12   ; line 1189
	lw      $t0, -60($fp)
	lw      $t1, 0($t0)
	sw      $t1, -64($fp)
	# param %t13 : ptr   ; line 1189
	lw      $t0, -64($fp)
	sw      $t0, 0($sp)
	# %t14 = call @f_getc, 1   ; line 1189
	lw      $a0, 0($sp)
	jal     __rt_f_getc
	sw      $v0, -68($fp)
	# %c = %t14   ; line 1189
	lw      $t0, -68($fp)
	sw      $t0, -12($fp)
__rt_sc_get.L759:
	# %t15 = %c < 0   ; line 1190
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -72($fp)
	# ifFalse %t15 goto .L761   ; line 1190
	lw      $t0, -72($fp)
	beq     $t0, $zero, __rt_sc_get.L761
	# %t16 = addr @sc_eof   ; line 1190
	la      $t0, __rtg_sc_eof
	sw      $t0, -76($fp)
	# store.w %t16, 1   ; line 1190
	lw      $t0, -76($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
__rt_sc_get.L761:
	# return %c   ; line 1191
	lw      $v0, -12($fp)
__rt_sc_get.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_sc_unget
	.text
# ---------------------------------------------------------------
# function sc_unget (line 1194), returns void
# frame 80 bytes ($fp = $sp at entry):
#   0($fp)	param c (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : str
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : ptr
#   -64($fp)	%t13 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_sc_unget
__rt_sc_unget:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -80
	sw      $a0, 0($fp)
	# param c : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = %c < 0   ; line 1195
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -16($fp)
	# ifFalse %t1 goto .L763   ; line 1195
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_sc_unget.L763
	# return   ; line 1195
	b       __rt_sc_unget.ret
__rt_sc_unget.L763:
	# %t2 = addr @sc_str   ; line 1196
	la      $t0, __rtg_sc_str
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 1196
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# ifFalse %t3 goto .L765   ; line 1196
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_sc_unget.L765
	# %t4 = addr @sc_s   ; line 1196
	la      $t0, __rtg_sc_s
	sw      $t0, -28($fp)
	# %t5 = addr @sc_s   ; line 1196
	la      $t0, __rtg_sc_s
	sw      $t0, -32($fp)
	# %t6 = load.w %t5   ; line 1196
	lw      $t0, -32($fp)
	lw      $t1, 0($t0)
	sw      $t1, -36($fp)
	# %t7 = %t6 - 1   ; line 1196
	lw      $t0, -36($fp)
	addiu   $t0, $t0, -1
	sw      $t0, -40($fp)
	# store.w %t4, %t7   ; line 1196
	lw      $t0, -28($fp)
	lw      $t1, -40($fp)
	sw      $t1, 0($t0)
	# goto .L766   ; line 1196
	b       __rt_sc_unget.L766
__rt_sc_unget.L765:
	# %t8 = addr @sc_f   ; line 1198
	la      $t0, __rtg_sc_f
	sw      $t0, -44($fp)
	# %t9 = load.w %t8   ; line 1198
	lw      $t0, -44($fp)
	lw      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %t10 = %t9 + 16   ; line 1198
	lw      $t0, -48($fp)
	addiu   $t0, $t0, 16
	sw      $t0, -52($fp)
	# store.w %t10, 1   ; line 1198
	lw      $t0, -52($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t11 = addr @sc_f   ; line 1199
	la      $t0, __rtg_sc_f
	sw      $t0, -56($fp)
	# %t12 = load.w %t11   ; line 1199
	lw      $t0, -56($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %t12 + 20   ; line 1199
	lw      $t0, -60($fp)
	addiu   $t0, $t0, 20
	sw      $t0, -64($fp)
	# store.w %t13, %c   ; line 1199
	lw      $t0, -64($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
__rt_sc_unget.L766:
	# return
__rt_sc_unget.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_sc_fail
	.text
# ---------------------------------------------------------------
# function sc_fail (line 1203), returns int
# frame 40 bytes ($fp = $sp at entry):
#   0($fp)	param assigned (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%assigned : int
#   -16($fp)	%t1 : ptr
#   -20($fp)	%t2 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_sc_fail
__rt_sc_fail:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	sw      $a0, 0($fp)
	# param assigned : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# ifFalse %assigned goto .L768   ; line 1204
	lw      $t0, -12($fp)
	beq     $t0, $zero, __rt_sc_fail.L768
	# return %assigned   ; line 1204
	lw      $v0, -12($fp)
	b       __rt_sc_fail.ret
__rt_sc_fail.L768:
	# %t1 = addr @sc_eof   ; line 1205
	la      $t0, __rtg_sc_eof
	sw      $t0, -16($fp)
	# %t2 = load.w %t1   ; line 1205
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -20($fp)
	# ifFalse %t2 goto .L770   ; line 1205
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_sc_fail.L770
	# return -1   ; line 1205
	li      $v0, -1
	b       __rt_sc_fail.ret
__rt_sc_fail.L770:
	# return 0   ; line 1206
	move    $v0, $zero
__rt_sc_fail.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_sc_skip_space
	.text
# ---------------------------------------------------------------
# function sc_skip_space (line 1209), returns void
# frame 48 bytes ($fp = $sp at entry):
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%c : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_sc_skip_space
__rt_sc_skip_space:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	# %t1 = call @sc_get, 0   ; line 1211
	jal     __rt_sc_get
	sw      $v0, -16($fp)
	# %c = %t1   ; line 1211
	lw      $t0, -16($fp)
	sw      $t0, -12($fp)
__rt_sc_skip_space.L771:
	# %t2 = %c >= 0   ; line 1212
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -20($fp)
	# ifFalse %t2 goto .L773   ; line 1212
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_sc_skip_space.L773
	# param %c : int   ; line 1212
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t3 = call @is_space, 1   ; line 1212
	lw      $a0, 0($sp)
	jal     __rt_is_space
	sw      $v0, -24($fp)
	# ifFalse %t3 goto .L773   ; line 1212
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_sc_skip_space.L773
	# %t4 = call @sc_get, 0   ; line 1212
	jal     __rt_sc_get
	sw      $v0, -28($fp)
	# %c = %t4   ; line 1212
	lw      $t0, -28($fp)
	sw      $t0, -12($fp)
	# goto .L771   ; line 1212
	b       __rt_sc_skip_space.L771
__rt_sc_skip_space.L773:
	# param %c : int   ; line 1213
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1213
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# return
__rt_sc_skip_space.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_scan_int
	.text
# ---------------------------------------------------------------
# function scan_int (line 1222), returns int
# frame 248 bytes ($fp = $sp at entry):
#   0($fp)	param conv (int, arrives in $a0)
#   4($fp)	param width (int, arrives in $a1)
#   8($fp)	param suppress (int, arrives in $a2)
#   12($fp)	param app (ptr, arrives in $a3)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%conv : int
#   -16($fp)	%width : int
#   -20($fp)	%suppress : int
#   -24($fp)	%app : ptr
#   -28($fp)	%c : int
#   -32($fp)	%cnt : int
#   -36($fp)	%neg : int
#   -40($fp)	%base : int
#   -44($fp)	%ndig : int
#   -48($fp)	%d : int
#   -52($fp)	%p : ptr
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : int
#   -124($fp)	%t28 : int
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : int
#   -148($fp)	%t34 : int
#   -152($fp)	%t35 : int
#   -156($fp)	%t36 : int
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : int
#   -168($fp)	%t39 : int
#   -172($fp)	%t40 : int
#   -176($fp)	%t41 : int
#   -180($fp)	%t42 : int
#   -184($fp)	%t43 : int
#   -188($fp)	%t44 : int
#   -192($fp)	%t45 : int
#   -196($fp)	%t46 : int
#   -200($fp)	%t47 : int
#   -204($fp)	%t48 : ptr
#   -208($fp)	%t49 : int
#   -212($fp)	%t50 : ptr
#   -216($fp)	%t51 : ptr
#   -220($fp)	%t52 : int
#   -224($fp)	%t53 : int
#   -228($fp)	%t54 : int
#   -232($fp)	%t55 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_scan_int
__rt_scan_int:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -248
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param conv : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param width : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param suppress : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param app : ptr at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# %cnt = 0   ; line 1225
	move    $t0, $zero
	sw      $t0, -32($fp)
	# %neg = 0   ; line 1226
	move    $t0, $zero
	sw      $t0, -36($fp)
	# call @acc_clear, 0   ; line 1227
	jal     __rt_acc_clear
	# %t11 = call @sc_get, 0   ; line 1228
	jal     __rt_sc_get
	sw      $v0, -56($fp)
	# %c = %t11   ; line 1228
	lw      $t0, -56($fp)
	sw      $t0, -28($fp)
	# %t12 = %c == 43   ; line 1229
	lw      $t0, -28($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# if %t12 goto .L774   ; line 1229
	lw      $t0, -60($fp)
	bne     $t0, $zero, __rt_scan_int.L774
	# %t13 = %c == 45   ; line 1229
	lw      $t0, -28($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L775   ; line 1229
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_scan_int.L775
__rt_scan_int.L774:
	# %t14 = %c == 45   ; line 1229
	lw      $t0, -28($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -68($fp)
	# %neg = %t14   ; line 1229
	lw      $t0, -68($fp)
	sw      $t0, -36($fp)
	# %t15 = %cnt   ; line 1229
	lw      $t0, -32($fp)
	sw      $t0, -72($fp)
	# %t16 = %t15 + 1   ; line 1229
	lw      $t0, -72($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -76($fp)
	# %cnt = %t16   ; line 1229
	lw      $t0, -76($fp)
	sw      $t0, -32($fp)
	# %t17 = call @sc_get, 0   ; line 1229
	jal     __rt_sc_get
	sw      $v0, -80($fp)
	# %c = %t17   ; line 1229
	lw      $t0, -80($fp)
	sw      $t0, -28($fp)
__rt_scan_int.L775:
	# %base = 10   ; line 1230
	li      $t0, 10
	sw      $t0, -40($fp)
	# %t18 = %conv == 120   ; line 1231
	lw      $t0, -12($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -84($fp)
	# if %t18 goto .L776   ; line 1231
	lw      $t0, -84($fp)
	bne     $t0, $zero, __rt_scan_int.L776
	# %t19 = %conv == 88   ; line 1231
	lw      $t0, -12($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# ifFalse %t19 goto .L777   ; line 1231
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_scan_int.L777
__rt_scan_int.L776:
	# %base = 16   ; line 1231
	li      $t0, 16
	sw      $t0, -40($fp)
__rt_scan_int.L777:
	# %t20 = %conv == 111   ; line 1232
	lw      $t0, -12($fp)
	xori    $t0, $t0, 111
	sltiu   $t0, $t0, 1
	sw      $t0, -92($fp)
	# ifFalse %t20 goto .L779   ; line 1232
	lw      $t0, -92($fp)
	beq     $t0, $zero, __rt_scan_int.L779
	# %base = 8   ; line 1232
	li      $t0, 8
	sw      $t0, -40($fp)
__rt_scan_int.L779:
	# %t21 = %conv == 105   ; line 1233
	lw      $t0, -12($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# ifFalse %t21 goto .L781   ; line 1233
	lw      $t0, -96($fp)
	beq     $t0, $zero, __rt_scan_int.L781
	# %base = 0   ; line 1233
	move    $t0, $zero
	sw      $t0, -40($fp)
__rt_scan_int.L781:
	# %ndig = 0   ; line 1234
	move    $t0, $zero
	sw      $t0, -44($fp)
	# %t22 = %base == 0   ; line 1235
	lw      $t0, -40($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# if %t22 goto .L784   ; line 1235
	lw      $t0, -100($fp)
	bne     $t0, $zero, __rt_scan_int.L784
	# %t23 = %base == 16   ; line 1235
	lw      $t0, -40($fp)
	xori    $t0, $t0, 16
	sltiu   $t0, $t0, 1
	sw      $t0, -104($fp)
	# ifFalse %t23 goto .L783   ; line 1235
	lw      $t0, -104($fp)
	beq     $t0, $zero, __rt_scan_int.L783
__rt_scan_int.L784:
	# %t24 = %c == 48   ; line 1235
	lw      $t0, -28($fp)
	xori    $t0, $t0, 48
	sltiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# ifFalse %t24 goto .L783   ; line 1235
	lw      $t0, -108($fp)
	beq     $t0, $zero, __rt_scan_int.L783
	# ifFalse %width goto .L782   ; line 1235
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_scan_int.L782
	# %t25 = %cnt < %width   ; line 1235
	lw      $t0, -32($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -112($fp)
	# ifFalse %t25 goto .L783   ; line 1235
	lw      $t0, -112($fp)
	beq     $t0, $zero, __rt_scan_int.L783
__rt_scan_int.L782:
	# %t26 = %cnt   ; line 1236
	lw      $t0, -32($fp)
	sw      $t0, -116($fp)
	# %t27 = %t26 + 1   ; line 1236
	lw      $t0, -116($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -120($fp)
	# %cnt = %t27   ; line 1236
	lw      $t0, -120($fp)
	sw      $t0, -32($fp)
	# %t28 = %ndig   ; line 1237
	lw      $t0, -44($fp)
	sw      $t0, -124($fp)
	# %t29 = %t28 + 1   ; line 1237
	lw      $t0, -124($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -128($fp)
	# %ndig = %t29   ; line 1237
	lw      $t0, -128($fp)
	sw      $t0, -44($fp)
	# %t30 = call @sc_get, 0   ; line 1238
	jal     __rt_sc_get
	sw      $v0, -132($fp)
	# %c = %t30   ; line 1238
	lw      $t0, -132($fp)
	sw      $t0, -28($fp)
	# ifFalse %width goto .L787   ; line 1239
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_scan_int.L787
	# %t31 = %cnt < %width   ; line 1239
	lw      $t0, -32($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -136($fp)
	# ifFalse %t31 goto .L786   ; line 1239
	lw      $t0, -136($fp)
	beq     $t0, $zero, __rt_scan_int.L786
__rt_scan_int.L787:
	# %t32 = %c == 120   ; line 1239
	lw      $t0, -28($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -140($fp)
	# if %t32 goto .L785   ; line 1239
	lw      $t0, -140($fp)
	bne     $t0, $zero, __rt_scan_int.L785
	# %t33 = %c == 88   ; line 1239
	lw      $t0, -28($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -144($fp)
	# ifFalse %t33 goto .L786   ; line 1239
	lw      $t0, -144($fp)
	beq     $t0, $zero, __rt_scan_int.L786
__rt_scan_int.L785:
	# %t34 = %cnt   ; line 1240
	lw      $t0, -32($fp)
	sw      $t0, -148($fp)
	# %t35 = %t34 + 1   ; line 1240
	lw      $t0, -148($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# %cnt = %t35   ; line 1240
	lw      $t0, -152($fp)
	sw      $t0, -32($fp)
	# %base = 16   ; line 1241
	li      $t0, 16
	sw      $t0, -40($fp)
	# %t36 = call @sc_get, 0   ; line 1242
	jal     __rt_sc_get
	sw      $v0, -156($fp)
	# %c = %t36   ; line 1242
	lw      $t0, -156($fp)
	sw      $t0, -28($fp)
	# goto .L788   ; line 1242
	b       __rt_scan_int.L788
__rt_scan_int.L786:
	# %t37 = %base == 0   ; line 1243
	lw      $t0, -40($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -160($fp)
	# ifFalse %t37 goto .L790   ; line 1243
	lw      $t0, -160($fp)
	beq     $t0, $zero, __rt_scan_int.L790
	# %base = 8   ; line 1243
	li      $t0, 8
	sw      $t0, -40($fp)
__rt_scan_int.L790:
__rt_scan_int.L788:
__rt_scan_int.L783:
	# %t38 = %base == 0   ; line 1245
	lw      $t0, -40($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -164($fp)
	# ifFalse %t38 goto .L792   ; line 1245
	lw      $t0, -164($fp)
	beq     $t0, $zero, __rt_scan_int.L792
	# %base = 10   ; line 1245
	li      $t0, 10
	sw      $t0, -40($fp)
__rt_scan_int.L792:
__rt_scan_int.L793:
	# %t39 = %c >= 0   ; line 1246
	lw      $t0, -28($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -168($fp)
	# ifFalse %t39 goto .L795   ; line 1246
	lw      $t0, -168($fp)
	beq     $t0, $zero, __rt_scan_int.L795
	# ifFalse %width goto .L794   ; line 1246
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_scan_int.L794
	# %t40 = %cnt < %width   ; line 1246
	lw      $t0, -32($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -172($fp)
	# ifFalse %t40 goto .L795   ; line 1246
	lw      $t0, -172($fp)
	beq     $t0, $zero, __rt_scan_int.L795
__rt_scan_int.L794:
	# param %c : int   ; line 1247
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %base : int   ; line 1247
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# %t41 = call @digit_val, 2   ; line 1247
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_digit_val
	sw      $v0, -176($fp)
	# %d = %t41   ; line 1247
	lw      $t0, -176($fp)
	sw      $t0, -48($fp)
	# %t42 = %d < 0   ; line 1248
	lw      $t0, -48($fp)
	slti    $t0, $t0, 0
	sw      $t0, -180($fp)
	# ifFalse %t42 goto .L797   ; line 1248
	lw      $t0, -180($fp)
	beq     $t0, $zero, __rt_scan_int.L797
	# goto .L795   ; line 1248
	b       __rt_scan_int.L795
__rt_scan_int.L797:
	# param %d : int   ; line 1249
	lw      $t0, -48($fp)
	sw      $t0, 0($sp)
	# param %base : int   ; line 1249
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# call @acc_digit, 2   ; line 1249
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_acc_digit
	# %t43 = %cnt   ; line 1250
	lw      $t0, -32($fp)
	sw      $t0, -184($fp)
	# %t44 = %t43 + 1   ; line 1250
	lw      $t0, -184($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -188($fp)
	# %cnt = %t44   ; line 1250
	lw      $t0, -188($fp)
	sw      $t0, -32($fp)
	# %t45 = %ndig   ; line 1251
	lw      $t0, -44($fp)
	sw      $t0, -192($fp)
	# %t46 = %t45 + 1   ; line 1251
	lw      $t0, -192($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -196($fp)
	# %ndig = %t46   ; line 1251
	lw      $t0, -196($fp)
	sw      $t0, -44($fp)
	# %t47 = call @sc_get, 0   ; line 1252
	jal     __rt_sc_get
	sw      $v0, -200($fp)
	# %c = %t47   ; line 1252
	lw      $t0, -200($fp)
	sw      $t0, -28($fp)
	# goto .L793   ; line 1252
	b       __rt_scan_int.L793
__rt_scan_int.L795:
	# param %c : int   ; line 1254
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1254
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# if %ndig goto .L799   ; line 1255
	lw      $t0, -44($fp)
	bne     $t0, $zero, __rt_scan_int.L799
	# return 0   ; line 1255
	move    $v0, $zero
	b       __rt_scan_int.ret
__rt_scan_int.L799:
	# if %suppress goto .L801   ; line 1256
	lw      $t0, -20($fp)
	bne     $t0, $zero, __rt_scan_int.L801
	# %t48 = load.w %app   ; line 1257
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -204($fp)
	# %t49 = load.w %t48   ; line 1257
	lw      $t0, -204($fp)
	lw      $t1, 0($t0)
	sw      $t1, -208($fp)
	# %p = %t49   ; line 1257
	lw      $t0, -208($fp)
	sw      $t0, -52($fp)
	# %t50 = load.w %app   ; line 1258
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -212($fp)
	# %t51 = %t50 + 4   ; line 1258
	lw      $t0, -212($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -216($fp)
	# store.w %app, %t51   ; line 1258
	lw      $t0, -24($fp)
	lw      $t1, -216($fp)
	sw      $t1, 0($t0)
	# %t53 = %conv == 100   ; line 1259
	lw      $t0, -12($fp)
	xori    $t0, $t0, 100
	sltiu   $t0, $t0, 1
	sw      $t0, -224($fp)
	# if %t53 goto .L802   ; line 1259
	lw      $t0, -224($fp)
	bne     $t0, $zero, __rt_scan_int.L802
	# %t54 = %conv == 105   ; line 1259
	lw      $t0, -12($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -228($fp)
	# ifFalse %t54 goto .L803   ; line 1259
	lw      $t0, -228($fp)
	beq     $t0, $zero, __rt_scan_int.L803
__rt_scan_int.L802:
	# %t52 = 1   ; line 1259
	li      $t0, 1
	sw      $t0, -220($fp)
	# goto .L804   ; line 1259
	b       __rt_scan_int.L804
__rt_scan_int.L803:
	# %t52 = 0   ; line 1259
	move    $t0, $zero
	sw      $t0, -220($fp)
__rt_scan_int.L804:
	# param %neg : int   ; line 1259
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# param %t52 : int   ; line 1259
	lw      $t0, -220($fp)
	sw      $t0, 4($sp)
	# %t55 = call @acc_value, 2   ; line 1259
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_acc_value
	sw      $v0, -232($fp)
	# store.w %p, %t55   ; line 1259
	lw      $t0, -52($fp)
	lw      $t1, -232($fp)
	sw      $t1, 0($t0)
__rt_scan_int.L801:
	# return 1   ; line 1261
	li      $v0, 1
__rt_scan_int.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_scan_float
	.text
# ---------------------------------------------------------------
# function scan_float (line 1267), returns int
# frame 256 bytes ($fp = $sp at entry):
#   0($fp)	param islong (int, arrives in $a0)
#   4($fp)	param suppress (int, arrives in $a1)
#   8($fp)	param app (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%islong : int
#   -16($fp)	%suppress : int
#   -20($fp)	%app : ptr
#   -24($fp)	%c : int
#   -28($fp)	%neg : int
#   -32($fp)	%ndig : int
#   -36($fp)	%eneg : int
#   -40($fp)	%edig : int
#   -44($fp)	%ev : int
#   -48($fp)	%e10 : int
#   -56($fp)	%v : double
#   -60($fp)	%dp : ptr
#   -64($fp)	%fp : ptr
#   -68($fp)	%t13 : int
#   -72($fp)	%t14 : int
#   -76($fp)	%t15 : int
#   -80($fp)	%t16 : int
#   -84($fp)	%t17 : int
#   -88($fp)	%t18 : int
#   -92($fp)	%t19 : int
#   -96($fp)	%t20 : int
#   -100($fp)	%t21 : int
#   -104($fp)	%t22 : int
#   -108($fp)	%t23 : int
#   -112($fp)	%t24 : int
#   -116($fp)	%t25 : int
#   -120($fp)	%t26 : int
#   -124($fp)	%t27 : int
#   -128($fp)	%t28 : int
#   -132($fp)	%t29 : int
#   -136($fp)	%t30 : int
#   -140($fp)	%t31 : int
#   -144($fp)	%t32 : int
#   -148($fp)	%t33 : int
#   -152($fp)	%t34 : int
#   -156($fp)	%t35 : int
#   -160($fp)	%t36 : int
#   -164($fp)	%t37 : int
#   -168($fp)	%t38 : int
#   -172($fp)	%t39 : int
#   -176($fp)	%t40 : int
#   -180($fp)	%t41 : int
#   -184($fp)	%t42 : int
#   -188($fp)	%t43 : int
#   -192($fp)	%t44 : int
#   -196($fp)	%t45 : int
#   -200($fp)	%t46 : int
#   -208($fp)	%t47 : double
#   -212($fp)	%t48 : ptr
#   -216($fp)	%t49 : int
#   -220($fp)	%t50 : ptr
#   -224($fp)	%t51 : int
#   -228($fp)	%t52 : float
#   -232($fp)	%t53 : ptr
#   -236($fp)	%t54 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_scan_float
__rt_scan_float:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -256
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param islong : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param suppress : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param app : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# call @dd_clear, 0   ; line 1272
	jal     __rt_dd_clear
	# %neg = 0   ; line 1273
	move    $t0, $zero
	sw      $t0, -28($fp)
	# %t13 = call @sc_get, 0   ; line 1274
	jal     __rt_sc_get
	sw      $v0, -68($fp)
	# %c = %t13   ; line 1274
	lw      $t0, -68($fp)
	sw      $t0, -24($fp)
	# %t14 = %c == 43   ; line 1275
	lw      $t0, -24($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -72($fp)
	# if %t14 goto .L805   ; line 1275
	lw      $t0, -72($fp)
	bne     $t0, $zero, __rt_scan_float.L805
	# %t15 = %c == 45   ; line 1275
	lw      $t0, -24($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -76($fp)
	# ifFalse %t15 goto .L806   ; line 1275
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_scan_float.L806
__rt_scan_float.L805:
	# %t16 = %c == 45   ; line 1275
	lw      $t0, -24($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# %neg = %t16   ; line 1275
	lw      $t0, -80($fp)
	sw      $t0, -28($fp)
	# %t17 = call @sc_get, 0   ; line 1275
	jal     __rt_sc_get
	sw      $v0, -84($fp)
	# %c = %t17   ; line 1275
	lw      $t0, -84($fp)
	sw      $t0, -24($fp)
__rt_scan_float.L806:
	# %ndig = 0   ; line 1276
	move    $t0, $zero
	sw      $t0, -32($fp)
__rt_scan_float.L807:
	# param %c : int   ; line 1277
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t18 = call @is_digit, 1   ; line 1277
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -88($fp)
	# ifFalse %t18 goto .L809   ; line 1277
	lw      $t0, -88($fp)
	beq     $t0, $zero, __rt_scan_float.L809
	# %t19 = 0   ; line 1277
	move    $t0, $zero
	sw      $t0, -92($fp)
	# param %c : int   ; line 1277
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %t19 : int   ; line 1277
	lw      $t0, -92($fp)
	sw      $t0, 4($sp)
	# call @dd_push, 2   ; line 1277
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dd_push
	# %t20 = %ndig   ; line 1277
	lw      $t0, -32($fp)
	sw      $t0, -96($fp)
	# %t21 = %t20 + 1   ; line 1277
	lw      $t0, -96($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -100($fp)
	# %ndig = %t21   ; line 1277
	lw      $t0, -100($fp)
	sw      $t0, -32($fp)
	# %t22 = call @sc_get, 0   ; line 1277
	jal     __rt_sc_get
	sw      $v0, -104($fp)
	# %c = %t22   ; line 1277
	lw      $t0, -104($fp)
	sw      $t0, -24($fp)
	# goto .L807   ; line 1277
	b       __rt_scan_float.L807
__rt_scan_float.L809:
	# %t23 = %c == 46   ; line 1278
	lw      $t0, -24($fp)
	xori    $t0, $t0, 46
	sltiu   $t0, $t0, 1
	sw      $t0, -108($fp)
	# ifFalse %t23 goto .L811   ; line 1278
	lw      $t0, -108($fp)
	beq     $t0, $zero, __rt_scan_float.L811
	# %t24 = call @sc_get, 0   ; line 1279
	jal     __rt_sc_get
	sw      $v0, -112($fp)
	# %c = %t24   ; line 1279
	lw      $t0, -112($fp)
	sw      $t0, -24($fp)
__rt_scan_float.L812:
	# param %c : int   ; line 1280
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t25 = call @is_digit, 1   ; line 1280
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -116($fp)
	# ifFalse %t25 goto .L814   ; line 1280
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_scan_float.L814
	# %t26 = 1   ; line 1280
	li      $t0, 1
	sw      $t0, -120($fp)
	# param %c : int   ; line 1280
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %t26 : int   ; line 1280
	lw      $t0, -120($fp)
	sw      $t0, 4($sp)
	# call @dd_push, 2   ; line 1280
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dd_push
	# %t27 = %ndig   ; line 1280
	lw      $t0, -32($fp)
	sw      $t0, -124($fp)
	# %t28 = %t27 + 1   ; line 1280
	lw      $t0, -124($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -128($fp)
	# %ndig = %t28   ; line 1280
	lw      $t0, -128($fp)
	sw      $t0, -32($fp)
	# %t29 = call @sc_get, 0   ; line 1280
	jal     __rt_sc_get
	sw      $v0, -132($fp)
	# %c = %t29   ; line 1280
	lw      $t0, -132($fp)
	sw      $t0, -24($fp)
	# goto .L812   ; line 1280
	b       __rt_scan_float.L812
__rt_scan_float.L814:
__rt_scan_float.L811:
	# %e10 = 0   ; line 1282
	move    $t0, $zero
	sw      $t0, -48($fp)
	# ifFalse %ndig goto .L816   ; line 1283
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_scan_float.L816
	# %t30 = %c == 101   ; line 1283
	lw      $t0, -24($fp)
	xori    $t0, $t0, 101
	sltiu   $t0, $t0, 1
	sw      $t0, -136($fp)
	# if %t30 goto .L815   ; line 1283
	lw      $t0, -136($fp)
	bne     $t0, $zero, __rt_scan_float.L815
	# %t31 = %c == 69   ; line 1283
	lw      $t0, -24($fp)
	xori    $t0, $t0, 69
	sltiu   $t0, $t0, 1
	sw      $t0, -140($fp)
	# ifFalse %t31 goto .L816   ; line 1283
	lw      $t0, -140($fp)
	beq     $t0, $zero, __rt_scan_float.L816
__rt_scan_float.L815:
	# %t32 = call @sc_get, 0   ; line 1284
	jal     __rt_sc_get
	sw      $v0, -144($fp)
	# %c = %t32   ; line 1284
	lw      $t0, -144($fp)
	sw      $t0, -24($fp)
	# %eneg = 0   ; line 1285
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %t33 = %c == 43   ; line 1286
	lw      $t0, -24($fp)
	xori    $t0, $t0, 43
	sltiu   $t0, $t0, 1
	sw      $t0, -148($fp)
	# if %t33 goto .L817   ; line 1286
	lw      $t0, -148($fp)
	bne     $t0, $zero, __rt_scan_float.L817
	# %t34 = %c == 45   ; line 1286
	lw      $t0, -24($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# ifFalse %t34 goto .L818   ; line 1286
	lw      $t0, -152($fp)
	beq     $t0, $zero, __rt_scan_float.L818
__rt_scan_float.L817:
	# %t35 = %c == 45   ; line 1286
	lw      $t0, -24($fp)
	xori    $t0, $t0, 45
	sltiu   $t0, $t0, 1
	sw      $t0, -156($fp)
	# %eneg = %t35   ; line 1286
	lw      $t0, -156($fp)
	sw      $t0, -36($fp)
	# %t36 = call @sc_get, 0   ; line 1286
	jal     __rt_sc_get
	sw      $v0, -160($fp)
	# %c = %t36   ; line 1286
	lw      $t0, -160($fp)
	sw      $t0, -24($fp)
__rt_scan_float.L818:
	# %edig = 0   ; line 1287
	move    $t0, $zero
	sw      $t0, -40($fp)
	# %ev = 0   ; line 1288
	move    $t0, $zero
	sw      $t0, -44($fp)
__rt_scan_float.L819:
	# param %c : int   ; line 1289
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# %t37 = call @is_digit, 1   ; line 1289
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -164($fp)
	# ifFalse %t37 goto .L821   ; line 1289
	lw      $t0, -164($fp)
	beq     $t0, $zero, __rt_scan_float.L821
	# %t38 = %ev < 100000   ; line 1290
	lw      $t0, -44($fp)
	li      $t1, 100000
	slt     $t0, $t0, $t1
	sw      $t0, -168($fp)
	# ifFalse %t38 goto .L823   ; line 1290
	lw      $t0, -168($fp)
	beq     $t0, $zero, __rt_scan_float.L823
	# %t39 = %ev * 10   ; line 1290
	lw      $t0, -44($fp)
	li      $t1, 10
	mul     $t0, $t0, $t1
	sw      $t0, -172($fp)
	# %t40 = %t39 + %c   ; line 1290
	lw      $t0, -172($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -176($fp)
	# %t41 = %t40 - 48   ; line 1290
	lw      $t0, -176($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -180($fp)
	# %ev = %t41   ; line 1290
	lw      $t0, -180($fp)
	sw      $t0, -44($fp)
__rt_scan_float.L823:
	# %t42 = %edig   ; line 1291
	lw      $t0, -40($fp)
	sw      $t0, -184($fp)
	# %t43 = %t42 + 1   ; line 1291
	lw      $t0, -184($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -188($fp)
	# %edig = %t43   ; line 1291
	lw      $t0, -188($fp)
	sw      $t0, -40($fp)
	# %t44 = call @sc_get, 0   ; line 1292
	jal     __rt_sc_get
	sw      $v0, -192($fp)
	# %c = %t44   ; line 1292
	lw      $t0, -192($fp)
	sw      $t0, -24($fp)
	# goto .L819   ; line 1292
	b       __rt_scan_float.L819
__rt_scan_float.L821:
	# ifFalse %edig goto .L825   ; line 1294
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_scan_float.L825
	# ifFalse %eneg goto .L827   ; line 1294
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_scan_float.L827
	# %t46 = - %ev   ; line 1294
	lw      $t0, -44($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -200($fp)
	# %t45 = %t46   ; line 1294
	lw      $t0, -200($fp)
	sw      $t0, -196($fp)
	# goto .L828   ; line 1294
	b       __rt_scan_float.L828
__rt_scan_float.L827:
	# %t45 = %ev   ; line 1294
	lw      $t0, -44($fp)
	sw      $t0, -196($fp)
__rt_scan_float.L828:
	# %e10 = %t45   ; line 1294
	lw      $t0, -196($fp)
	sw      $t0, -48($fp)
__rt_scan_float.L825:
__rt_scan_float.L816:
	# param %c : int   ; line 1296
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1296
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# if %ndig goto .L830   ; line 1297
	lw      $t0, -32($fp)
	bne     $t0, $zero, __rt_scan_float.L830
	# return 0   ; line 1297
	move    $v0, $zero
	b       __rt_scan_float.ret
__rt_scan_float.L830:
	# param %neg : int   ; line 1298
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# param %e10 : int   ; line 1298
	lw      $t0, -48($fp)
	sw      $t0, 4($sp)
	# %t47 = call @dd_value, 2   ; line 1298
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_dd_value
	sdc1    $f0, -208($fp)
	# %v = %t47   ; line 1298
	ldc1    $f4, -208($fp)
	sdc1    $f4, -56($fp)
	# if %suppress goto .L832   ; line 1299
	lw      $t0, -16($fp)
	bne     $t0, $zero, __rt_scan_float.L832
	# ifFalse %islong goto .L834   ; line 1300
	lw      $t0, -12($fp)
	beq     $t0, $zero, __rt_scan_float.L834
	# %t48 = load.w %app   ; line 1301
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -212($fp)
	# %t49 = load.w %t48   ; line 1301
	lw      $t0, -212($fp)
	lw      $t1, 0($t0)
	sw      $t1, -216($fp)
	# %dp = %t49   ; line 1301
	lw      $t0, -216($fp)
	sw      $t0, -60($fp)
	# store.d %dp, %v   ; line 1302
	lw      $t0, -60($fp)
	ldc1    $f4, -56($fp)
	sdc1    $f4, 0($t0)
	# goto .L835   ; line 1302
	b       __rt_scan_float.L835
__rt_scan_float.L834:
	# %t50 = load.w %app   ; line 1304
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -220($fp)
	# %t51 = load.w %t50   ; line 1304
	lw      $t0, -220($fp)
	lw      $t1, 0($t0)
	sw      $t1, -224($fp)
	# %fp = %t51   ; line 1304
	lw      $t0, -224($fp)
	sw      $t0, -64($fp)
	# %t52 = cvt.s.d %v   ; line 1305
	ldc1    $f4, -56($fp)
	cvt.s.d $f6, $f4
	swc1    $f6, -228($fp)
	# store.s %fp, %t52   ; line 1305
	lw      $t0, -64($fp)
	lwc1    $f4, -228($fp)
	swc1    $f4, 0($t0)
__rt_scan_float.L835:
	# %t53 = load.w %app   ; line 1307
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -232($fp)
	# %t54 = %t53 + 4   ; line 1307
	lw      $t0, -232($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -236($fp)
	# store.w %app, %t54   ; line 1307
	lw      $t0, -20($fp)
	lw      $t1, -236($fp)
	sw      $t1, 0($t0)
__rt_scan_float.L832:
	# return 1   ; line 1309
	li      $v0, 1
__rt_scan_float.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_scan_chars
	.text
# ---------------------------------------------------------------
# function scan_chars (line 1314), returns int
# frame 160 bytes ($fp = $sp at entry):
#   0($fp)	param conv (int, arrives in $a0)
#   4($fp)	param width (int, arrives in $a1)
#   8($fp)	param suppress (int, arrives in $a2)
#   12($fp)	param app (ptr, arrives in $a3)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%conv : int
#   -16($fp)	%width : int
#   -20($fp)	%suppress : int
#   -24($fp)	%app : ptr
#   -28($fp)	%p : str
#   -32($fp)	%c : int
#   -36($fp)	%got : int
#   -40($fp)	%n : int
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : str
#   -84($fp)	%t18 : char
#   -88($fp)	%t19 : char
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : int
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : str
#   -120($fp)	%t27 : char
#   -124($fp)	%t28 : char
#   -128($fp)	%t29 : int
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : int
#   -140($fp)	%t32 : int
#   -144($fp)	%t33 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_scan_chars
__rt_scan_chars:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -160
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	sw      $a3, 12($fp)
	# param conv : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param width : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param suppress : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param app : ptr at 12($fp)
	lw      $t0, 12($fp)
	sw      $t0, -24($fp)
	# %p = 0   ; line 1317
	move    $t0, $zero
	sw      $t0, -28($fp)
	# if %suppress goto .L837   ; line 1318
	lw      $t0, -20($fp)
	bne     $t0, $zero, __rt_scan_chars.L837
	# %t8 = load.w %app   ; line 1318
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -44($fp)
	# %t9 = load.w %t8   ; line 1318
	lw      $t0, -44($fp)
	lw      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %p = %t9   ; line 1318
	lw      $t0, -48($fp)
	sw      $t0, -28($fp)
	# %t10 = load.w %app   ; line 1318
	lw      $t0, -24($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 + 4   ; line 1318
	lw      $t0, -52($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -56($fp)
	# store.w %app, %t11   ; line 1318
	lw      $t0, -24($fp)
	lw      $t1, -56($fp)
	sw      $t1, 0($t0)
__rt_scan_chars.L837:
	# %got = 0   ; line 1319
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %t12 = %conv == 99   ; line 1320
	lw      $t0, -12($fp)
	xori    $t0, $t0, 99
	sltiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# ifFalse %t12 goto .L839   ; line 1320
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_scan_chars.L839
	# ifFalse %width goto .L841   ; line 1321
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_scan_chars.L841
	# %t13 = %width   ; line 1321
	lw      $t0, -16($fp)
	sw      $t0, -64($fp)
	# goto .L842   ; line 1321
	b       __rt_scan_chars.L842
__rt_scan_chars.L841:
	# %t13 = 1   ; line 1321
	li      $t0, 1
	sw      $t0, -64($fp)
__rt_scan_chars.L842:
	# %n = %t13   ; line 1321
	lw      $t0, -64($fp)
	sw      $t0, -40($fp)
__rt_scan_chars.L843:
	# %t14 = %got < %n   ; line 1322
	lw      $t0, -36($fp)
	lw      $t1, -40($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L845   ; line 1322
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_scan_chars.L845
	# %t15 = call @sc_get, 0   ; line 1323
	jal     __rt_sc_get
	sw      $v0, -72($fp)
	# %c = %t15   ; line 1323
	lw      $t0, -72($fp)
	sw      $t0, -32($fp)
	# %t16 = %c < 0   ; line 1324
	lw      $t0, -32($fp)
	slti    $t0, $t0, 0
	sw      $t0, -76($fp)
	# ifFalse %t16 goto .L847   ; line 1324
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_scan_chars.L847
	# goto .L845   ; line 1324
	b       __rt_scan_chars.L845
__rt_scan_chars.L847:
	# ifFalse %p goto .L849   ; line 1325
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_scan_chars.L849
	# %t17 = %p + %got   ; line 1325
	lw      $t0, -28($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -80($fp)
	# %t18 = sext.b %c   ; line 1325
	lw      $t0, -32($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -84($fp)
	# store.b %t17, %t18   ; line 1325
	lw      $t0, -80($fp)
	lw      $t1, -84($fp)
	sb      $t1, 0($t0)
	# %t19 = sext.b %t18   ; line 1325
	lw      $t0, -84($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -88($fp)
__rt_scan_chars.L849:
	# %t20 = %got   ; line 1326
	lw      $t0, -36($fp)
	sw      $t0, -92($fp)
	# %t21 = %t20 + 1   ; line 1326
	lw      $t0, -92($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -96($fp)
	# %got = %t21   ; line 1326
	lw      $t0, -96($fp)
	sw      $t0, -36($fp)
	# goto .L843   ; line 1326
	b       __rt_scan_chars.L843
__rt_scan_chars.L845:
	# %t22 = %got > 0   ; line 1328
	lw      $t0, -36($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -100($fp)
	# return %t22   ; line 1328
	lw      $v0, -100($fp)
	b       __rt_scan_chars.ret
__rt_scan_chars.L839:
	# %t23 = call @sc_get, 0   ; line 1330
	jal     __rt_sc_get
	sw      $v0, -104($fp)
	# %c = %t23   ; line 1330
	lw      $t0, -104($fp)
	sw      $t0, -32($fp)
__rt_scan_chars.L850:
	# %t24 = %c >= 0   ; line 1331
	lw      $t0, -32($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -108($fp)
	# ifFalse %t24 goto .L852   ; line 1331
	lw      $t0, -108($fp)
	beq     $t0, $zero, __rt_scan_chars.L852
	# param %c : int   ; line 1331
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# %t25 = call @is_space, 1   ; line 1331
	lw      $a0, 0($sp)
	jal     __rt_is_space
	sw      $v0, -112($fp)
	# if %t25 goto .L852   ; line 1331
	lw      $t0, -112($fp)
	bne     $t0, $zero, __rt_scan_chars.L852
	# ifFalse %p goto .L854   ; line 1332
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_scan_chars.L854
	# %t26 = %p + %got   ; line 1332
	lw      $t0, -28($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -116($fp)
	# %t27 = sext.b %c   ; line 1332
	lw      $t0, -32($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -120($fp)
	# store.b %t26, %t27   ; line 1332
	lw      $t0, -116($fp)
	lw      $t1, -120($fp)
	sb      $t1, 0($t0)
	# %t28 = sext.b %t27   ; line 1332
	lw      $t0, -120($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -124($fp)
__rt_scan_chars.L854:
	# %t29 = %got   ; line 1333
	lw      $t0, -36($fp)
	sw      $t0, -128($fp)
	# %t30 = %t29 + 1   ; line 1333
	lw      $t0, -128($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# %got = %t30   ; line 1333
	lw      $t0, -132($fp)
	sw      $t0, -36($fp)
	# %t31 = call @sc_get, 0   ; line 1334
	jal     __rt_sc_get
	sw      $v0, -136($fp)
	# %c = %t31   ; line 1334
	lw      $t0, -136($fp)
	sw      $t0, -32($fp)
	# ifFalse %width goto .L856   ; line 1335
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_scan_chars.L856
	# %t32 = %got >= %width   ; line 1335
	lw      $t0, -36($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -140($fp)
	# ifFalse %t32 goto .L856   ; line 1335
	lw      $t0, -140($fp)
	beq     $t0, $zero, __rt_scan_chars.L856
	# goto .L852   ; line 1335
	b       __rt_scan_chars.L852
__rt_scan_chars.L856:
	# goto .L850   ; line 1335
	b       __rt_scan_chars.L850
__rt_scan_chars.L852:
	# param %c : int   ; line 1337
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1337
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# if %got goto .L858   ; line 1338
	lw      $t0, -36($fp)
	bne     $t0, $zero, __rt_scan_chars.L858
	# return 0   ; line 1338
	move    $v0, $zero
	b       __rt_scan_chars.ret
__rt_scan_chars.L858:
	# ifFalse %p goto .L860   ; line 1339
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_scan_chars.L860
	# %t33 = %p + %got   ; line 1339
	lw      $t0, -28($fp)
	lw      $t1, -36($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -144($fp)
	# store.b %t33, 0   ; line 1339
	lw      $t0, -144($fp)
	sb      $zero, 0($t0)
__rt_scan_chars.L860:
	# return 1   ; line 1340
	li      $v0, 1
__rt_scan_chars.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vscan
	.text
# ---------------------------------------------------------------
# function vscan (line 1347), returns int
# frame 384 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param ap (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	local ap : int * (4 bytes)
#   -20($fp)	%fmt : str
#   -24($fp)	%i : int
#   -28($fp)	%c : int
#   -32($fp)	%fc : int
#   -36($fp)	%assigned : int
#   -40($fp)	%suppress : int
#   -44($fp)	%width : int
#   -48($fp)	%islong : int
#   -52($fp)	%conv : int
#   -56($fp)	%ok : int
#   -60($fp)	%t10 : str
#   -64($fp)	%t11 : char
#   -68($fp)	%t12 : str
#   -72($fp)	%t13 : char
#   -76($fp)	%t14 : int
#   -80($fp)	%t15 : int
#   -84($fp)	%t16 : int
#   -88($fp)	%t17 : int
#   -92($fp)	%t18 : int
#   -96($fp)	%t19 : int
#   -100($fp)	%t20 : int
#   -104($fp)	%t21 : int
#   -108($fp)	%t22 : int
#   -112($fp)	%t23 : int
#   -116($fp)	%t24 : int
#   -120($fp)	%t25 : int
#   -124($fp)	%t26 : str
#   -128($fp)	%t27 : char
#   -132($fp)	%t28 : int
#   -136($fp)	%t29 : int
#   -140($fp)	%t30 : int
#   -144($fp)	%t31 : int
#   -148($fp)	%t32 : int
#   -152($fp)	%t33 : int
#   -156($fp)	%t34 : str
#   -160($fp)	%t35 : char
#   -164($fp)	%t36 : int
#   -168($fp)	%t37 : int
#   -172($fp)	%t38 : int
#   -176($fp)	%t39 : str
#   -180($fp)	%t40 : char
#   -184($fp)	%t41 : int
#   -188($fp)	%t42 : int
#   -192($fp)	%t43 : str
#   -196($fp)	%t44 : char
#   -200($fp)	%t45 : int
#   -204($fp)	%t46 : int
#   -208($fp)	%t47 : int
#   -212($fp)	%t48 : int
#   -216($fp)	%t49 : str
#   -220($fp)	%t50 : char
#   -224($fp)	%t51 : int
#   -228($fp)	%t52 : str
#   -232($fp)	%t53 : char
#   -236($fp)	%t54 : int
#   -240($fp)	%t55 : str
#   -244($fp)	%t56 : char
#   -248($fp)	%t57 : int
#   -252($fp)	%t58 : int
#   -256($fp)	%t59 : int
#   -260($fp)	%t60 : str
#   -264($fp)	%t61 : char
#   -268($fp)	%t62 : int
#   -272($fp)	%t63 : int
#   -276($fp)	%t64 : int
#   -280($fp)	%t65 : int
#   -284($fp)	%t66 : int
#   -288($fp)	%t67 : int
#   -292($fp)	%t68 : int
#   -296($fp)	%t69 : int
#   -300($fp)	%t70 : int
#   -304($fp)	%t71 : int
#   -308($fp)	%t72 : ptr
#   -312($fp)	%t73 : int
#   -316($fp)	%t74 : int
#   -320($fp)	%t75 : int
#   -324($fp)	%t76 : int
#   -328($fp)	%t77 : int
#   -332($fp)	%t78 : int
#   -336($fp)	%t79 : ptr
#   -340($fp)	%t80 : int
#   -344($fp)	%t81 : int
#   -348($fp)	%t82 : int
#   -352($fp)	%t83 : ptr
#   -356($fp)	%t84 : int
#   -360($fp)	%t85 : int
#   -364($fp)	%t86 : int
#   -368($fp)	%t87 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vscan
__rt_vscan:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -384
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -20($fp)
	# param ap : ptr at 4($fp) -> slot ap
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %assigned = 0   ; line 1349
	move    $t0, $zero
	sw      $t0, -36($fp)
	# %i = 0   ; line 1350
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_vscan.L861:
	# %t10 = %fmt + %i   ; line 1351
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -60($fp)
	# %t11 = load.b %t10   ; line 1351
	lw      $t0, -60($fp)
	lb      $t1, 0($t0)
	sw      $t1, -64($fp)
	# ifFalse %t11 goto .L863   ; line 1351
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_vscan.L863
	# %t12 = %fmt + %i   ; line 1352
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -68($fp)
	# %t13 = load.b %t12   ; line 1352
	lw      $t0, -68($fp)
	lb      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t14 = %t13 & 255   ; line 1352
	lw      $t0, -72($fp)
	andi    $t0, $t0, 255
	sw      $t0, -76($fp)
	# %fc = %t14   ; line 1352
	lw      $t0, -76($fp)
	sw      $t0, -32($fp)
	# param %fc : int   ; line 1353
	lw      $t0, -32($fp)
	sw      $t0, 0($sp)
	# %t15 = call @is_space, 1   ; line 1353
	lw      $a0, 0($sp)
	jal     __rt_is_space
	sw      $v0, -80($fp)
	# ifFalse %t15 goto .L865   ; line 1353
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_vscan.L865
	# call @sc_skip_space, 0   ; line 1353
	jal     __rt_sc_skip_space
	# %t16 = %i   ; line 1353
	lw      $t0, -24($fp)
	sw      $t0, -84($fp)
	# %t17 = %t16 + 1   ; line 1353
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %i = %t17   ; line 1353
	lw      $t0, -88($fp)
	sw      $t0, -24($fp)
	# goto .L861   ; line 1353
	b       __rt_vscan.L861
__rt_vscan.L865:
	# %t18 = %fc != 37   ; line 1354
	lw      $t0, -32($fp)
	xori    $t0, $t0, 37
	sltu    $t0, $zero, $t0
	sw      $t0, -92($fp)
	# ifFalse %t18 goto .L867   ; line 1354
	lw      $t0, -92($fp)
	beq     $t0, $zero, __rt_vscan.L867
	# %t19 = call @sc_get, 0   ; line 1355
	jal     __rt_sc_get
	sw      $v0, -96($fp)
	# %c = %t19   ; line 1355
	lw      $t0, -96($fp)
	sw      $t0, -28($fp)
	# %t20 = %c != %fc   ; line 1356
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -100($fp)
	# ifFalse %t20 goto .L869   ; line 1356
	lw      $t0, -100($fp)
	beq     $t0, $zero, __rt_vscan.L869
	# param %c : int   ; line 1356
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1356
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# param %assigned : int   ; line 1356
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# %t21 = call @sc_fail, 1   ; line 1356
	lw      $a0, 0($sp)
	jal     __rt_sc_fail
	sw      $v0, -104($fp)
	# return %t21   ; line 1356
	lw      $v0, -104($fp)
	b       __rt_vscan.ret
__rt_vscan.L869:
	# %t22 = %i   ; line 1357
	lw      $t0, -24($fp)
	sw      $t0, -108($fp)
	# %t23 = %t22 + 1   ; line 1357
	lw      $t0, -108($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# %i = %t23   ; line 1357
	lw      $t0, -112($fp)
	sw      $t0, -24($fp)
	# goto .L861   ; line 1358
	b       __rt_vscan.L861
__rt_vscan.L867:
	# %t24 = %i   ; line 1360
	lw      $t0, -24($fp)
	sw      $t0, -116($fp)
	# %t25 = %t24 + 1   ; line 1360
	lw      $t0, -116($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -120($fp)
	# %i = %t25   ; line 1360
	lw      $t0, -120($fp)
	sw      $t0, -24($fp)
	# %t26 = %fmt + %i   ; line 1361
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -124($fp)
	# %t27 = load.b %t26   ; line 1361
	lw      $t0, -124($fp)
	lb      $t1, 0($t0)
	sw      $t1, -128($fp)
	# %t28 = %t27 == 37   ; line 1361
	lw      $t0, -128($fp)
	xori    $t0, $t0, 37
	sltiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# ifFalse %t28 goto .L871   ; line 1361
	lw      $t0, -132($fp)
	beq     $t0, $zero, __rt_vscan.L871
	# %t29 = call @sc_get, 0   ; line 1362
	jal     __rt_sc_get
	sw      $v0, -136($fp)
	# %c = %t29   ; line 1362
	lw      $t0, -136($fp)
	sw      $t0, -28($fp)
	# %t30 = %c != 37   ; line 1363
	lw      $t0, -28($fp)
	xori    $t0, $t0, 37
	sltu    $t0, $zero, $t0
	sw      $t0, -140($fp)
	# ifFalse %t30 goto .L873   ; line 1363
	lw      $t0, -140($fp)
	beq     $t0, $zero, __rt_vscan.L873
	# param %c : int   ; line 1363
	lw      $t0, -28($fp)
	sw      $t0, 0($sp)
	# call @sc_unget, 1   ; line 1363
	lw      $a0, 0($sp)
	jal     __rt_sc_unget
	# param %assigned : int   ; line 1363
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# %t31 = call @sc_fail, 1   ; line 1363
	lw      $a0, 0($sp)
	jal     __rt_sc_fail
	sw      $v0, -144($fp)
	# return %t31   ; line 1363
	lw      $v0, -144($fp)
	b       __rt_vscan.ret
__rt_vscan.L873:
	# %t32 = %i   ; line 1364
	lw      $t0, -24($fp)
	sw      $t0, -148($fp)
	# %t33 = %t32 + 1   ; line 1364
	lw      $t0, -148($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -152($fp)
	# %i = %t33   ; line 1364
	lw      $t0, -152($fp)
	sw      $t0, -24($fp)
	# goto .L861   ; line 1365
	b       __rt_vscan.L861
__rt_vscan.L871:
	# %suppress = 0   ; line 1367
	move    $t0, $zero
	sw      $t0, -40($fp)
	# %t34 = %fmt + %i   ; line 1368
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -156($fp)
	# %t35 = load.b %t34   ; line 1368
	lw      $t0, -156($fp)
	lb      $t1, 0($t0)
	sw      $t1, -160($fp)
	# %t36 = %t35 == 42   ; line 1368
	lw      $t0, -160($fp)
	xori    $t0, $t0, 42
	sltiu   $t0, $t0, 1
	sw      $t0, -164($fp)
	# ifFalse %t36 goto .L875   ; line 1368
	lw      $t0, -164($fp)
	beq     $t0, $zero, __rt_vscan.L875
	# %suppress = 1   ; line 1368
	li      $t0, 1
	sw      $t0, -40($fp)
	# %t37 = %i   ; line 1368
	lw      $t0, -24($fp)
	sw      $t0, -168($fp)
	# %t38 = %t37 + 1   ; line 1368
	lw      $t0, -168($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -172($fp)
	# %i = %t38   ; line 1368
	lw      $t0, -172($fp)
	sw      $t0, -24($fp)
__rt_vscan.L875:
	# %width = 0   ; line 1369
	move    $t0, $zero
	sw      $t0, -44($fp)
__rt_vscan.L876:
	# %t39 = %fmt + %i   ; line 1370
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -176($fp)
	# %t40 = load.b %t39   ; line 1370
	lw      $t0, -176($fp)
	lb      $t1, 0($t0)
	sw      $t1, -180($fp)
	# param %t40 : int   ; line 1370
	lw      $t0, -180($fp)
	sw      $t0, 0($sp)
	# %t41 = call @is_digit, 1   ; line 1370
	lw      $a0, 0($sp)
	jal     __rt_is_digit
	sw      $v0, -184($fp)
	# ifFalse %t41 goto .L878   ; line 1370
	lw      $t0, -184($fp)
	beq     $t0, $zero, __rt_vscan.L878
	# %t42 = %width * 10   ; line 1370
	lw      $t0, -44($fp)
	li      $t1, 10
	mul     $t0, $t0, $t1
	sw      $t0, -188($fp)
	# %t43 = %fmt + %i   ; line 1370
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -192($fp)
	# %t44 = load.b %t43   ; line 1370
	lw      $t0, -192($fp)
	lb      $t1, 0($t0)
	sw      $t1, -196($fp)
	# %t45 = %t42 + %t44   ; line 1370
	lw      $t0, -188($fp)
	lw      $t1, -196($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -200($fp)
	# %t46 = %t45 - 48   ; line 1370
	lw      $t0, -200($fp)
	addiu   $t0, $t0, -48
	sw      $t0, -204($fp)
	# %width = %t46   ; line 1370
	lw      $t0, -204($fp)
	sw      $t0, -44($fp)
	# %t47 = %i   ; line 1370
	lw      $t0, -24($fp)
	sw      $t0, -208($fp)
	# %t48 = %t47 + 1   ; line 1370
	lw      $t0, -208($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -212($fp)
	# %i = %t48   ; line 1370
	lw      $t0, -212($fp)
	sw      $t0, -24($fp)
	# goto .L876   ; line 1370
	b       __rt_vscan.L876
__rt_vscan.L878:
	# %islong = 0   ; line 1371
	move    $t0, $zero
	sw      $t0, -48($fp)
__rt_vscan.L879:
	# %t49 = %fmt + %i   ; line 1372
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -216($fp)
	# %t50 = load.b %t49   ; line 1372
	lw      $t0, -216($fp)
	lb      $t1, 0($t0)
	sw      $t1, -220($fp)
	# param %t50 : int   ; line 1372
	lw      $t0, -220($fp)
	sw      $t0, 0($sp)
	# %t51 = call @is_lenmod, 1   ; line 1372
	lw      $a0, 0($sp)
	jal     __rt_is_lenmod
	sw      $v0, -224($fp)
	# ifFalse %t51 goto .L881   ; line 1372
	lw      $t0, -224($fp)
	beq     $t0, $zero, __rt_vscan.L881
	# %t52 = %fmt + %i   ; line 1373
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -228($fp)
	# %t53 = load.b %t52   ; line 1373
	lw      $t0, -228($fp)
	lb      $t1, 0($t0)
	sw      $t1, -232($fp)
	# %t54 = %t53 == 108   ; line 1373
	lw      $t0, -232($fp)
	xori    $t0, $t0, 108
	sltiu   $t0, $t0, 1
	sw      $t0, -236($fp)
	# if %t54 goto .L882   ; line 1373
	lw      $t0, -236($fp)
	bne     $t0, $zero, __rt_vscan.L882
	# %t55 = %fmt + %i   ; line 1373
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -240($fp)
	# %t56 = load.b %t55   ; line 1373
	lw      $t0, -240($fp)
	lb      $t1, 0($t0)
	sw      $t1, -244($fp)
	# %t57 = %t56 == 76   ; line 1373
	lw      $t0, -244($fp)
	xori    $t0, $t0, 76
	sltiu   $t0, $t0, 1
	sw      $t0, -248($fp)
	# ifFalse %t57 goto .L883   ; line 1373
	lw      $t0, -248($fp)
	beq     $t0, $zero, __rt_vscan.L883
__rt_vscan.L882:
	# %islong = 1   ; line 1373
	li      $t0, 1
	sw      $t0, -48($fp)
__rt_vscan.L883:
	# %t58 = %i   ; line 1374
	lw      $t0, -24($fp)
	sw      $t0, -252($fp)
	# %t59 = %t58 + 1   ; line 1374
	lw      $t0, -252($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -256($fp)
	# %i = %t59   ; line 1374
	lw      $t0, -256($fp)
	sw      $t0, -24($fp)
	# goto .L879   ; line 1374
	b       __rt_vscan.L879
__rt_vscan.L881:
	# %t60 = %fmt + %i   ; line 1376
	lw      $t0, -20($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -260($fp)
	# %t61 = load.b %t60   ; line 1376
	lw      $t0, -260($fp)
	lb      $t1, 0($t0)
	sw      $t1, -264($fp)
	# %conv = %t61   ; line 1376
	lw      $t0, -264($fp)
	sw      $t0, -52($fp)
	# %t62 = %conv == 0   ; line 1377
	lw      $t0, -52($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -268($fp)
	# ifFalse %t62 goto .L885   ; line 1377
	lw      $t0, -268($fp)
	beq     $t0, $zero, __rt_vscan.L885
	# goto .L863   ; line 1377
	b       __rt_vscan.L863
__rt_vscan.L885:
	# %t63 = %i   ; line 1378
	lw      $t0, -24($fp)
	sw      $t0, -272($fp)
	# %t64 = %t63 + 1   ; line 1378
	lw      $t0, -272($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -276($fp)
	# %i = %t64   ; line 1378
	lw      $t0, -276($fp)
	sw      $t0, -24($fp)
	# %t65 = %conv != 99   ; line 1379
	lw      $t0, -52($fp)
	xori    $t0, $t0, 99
	sltu    $t0, $zero, $t0
	sw      $t0, -280($fp)
	# ifFalse %t65 goto .L887   ; line 1379
	lw      $t0, -280($fp)
	beq     $t0, $zero, __rt_vscan.L887
	# call @sc_skip_space, 0   ; line 1379
	jal     __rt_sc_skip_space
__rt_vscan.L887:
	# %t66 = %conv == 100   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 100
	sltiu   $t0, $t0, 1
	sw      $t0, -284($fp)
	# if %t66 goto .L888   ; line 1380
	lw      $t0, -284($fp)
	bne     $t0, $zero, __rt_vscan.L888
	# %t67 = %conv == 105   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 105
	sltiu   $t0, $t0, 1
	sw      $t0, -288($fp)
	# if %t67 goto .L888   ; line 1380
	lw      $t0, -288($fp)
	bne     $t0, $zero, __rt_vscan.L888
	# %t68 = %conv == 117   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 117
	sltiu   $t0, $t0, 1
	sw      $t0, -292($fp)
	# if %t68 goto .L888   ; line 1380
	lw      $t0, -292($fp)
	bne     $t0, $zero, __rt_vscan.L888
	# %t69 = %conv == 120   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 120
	sltiu   $t0, $t0, 1
	sw      $t0, -296($fp)
	# if %t69 goto .L888   ; line 1380
	lw      $t0, -296($fp)
	bne     $t0, $zero, __rt_vscan.L888
	# %t70 = %conv == 88   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 88
	sltiu   $t0, $t0, 1
	sw      $t0, -300($fp)
	# if %t70 goto .L888   ; line 1380
	lw      $t0, -300($fp)
	bne     $t0, $zero, __rt_vscan.L888
	# %t71 = %conv == 111   ; line 1380
	lw      $t0, -52($fp)
	xori    $t0, $t0, 111
	sltiu   $t0, $t0, 1
	sw      $t0, -304($fp)
	# ifFalse %t71 goto .L889   ; line 1380
	lw      $t0, -304($fp)
	beq     $t0, $zero, __rt_vscan.L889
__rt_vscan.L888:
	# %t72 = addr ap   ; line 1381
	addiu   $t0, $fp, -16
	sw      $t0, -308($fp)
	# param %conv : int   ; line 1381
	lw      $t0, -52($fp)
	sw      $t0, 0($sp)
	# param %width : int   ; line 1381
	lw      $t0, -44($fp)
	sw      $t0, 4($sp)
	# param %suppress : int   ; line 1381
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# param %t72 : ptr   ; line 1381
	lw      $t0, -308($fp)
	sw      $t0, 12($sp)
	# %t73 = call @scan_int, 4   ; line 1381
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_scan_int
	sw      $v0, -312($fp)
	# %ok = %t73   ; line 1381
	lw      $t0, -312($fp)
	sw      $t0, -56($fp)
	# goto .L890   ; line 1381
	b       __rt_vscan.L890
__rt_vscan.L889:
	# %t74 = %conv == 102   ; line 1382
	lw      $t0, -52($fp)
	xori    $t0, $t0, 102
	sltiu   $t0, $t0, 1
	sw      $t0, -316($fp)
	# if %t74 goto .L891   ; line 1382
	lw      $t0, -316($fp)
	bne     $t0, $zero, __rt_vscan.L891
	# %t75 = %conv == 101   ; line 1382
	lw      $t0, -52($fp)
	xori    $t0, $t0, 101
	sltiu   $t0, $t0, 1
	sw      $t0, -320($fp)
	# if %t75 goto .L891   ; line 1382
	lw      $t0, -320($fp)
	bne     $t0, $zero, __rt_vscan.L891
	# %t76 = %conv == 103   ; line 1382
	lw      $t0, -52($fp)
	xori    $t0, $t0, 103
	sltiu   $t0, $t0, 1
	sw      $t0, -324($fp)
	# if %t76 goto .L891   ; line 1382
	lw      $t0, -324($fp)
	bne     $t0, $zero, __rt_vscan.L891
	# %t77 = %conv == 69   ; line 1382
	lw      $t0, -52($fp)
	xori    $t0, $t0, 69
	sltiu   $t0, $t0, 1
	sw      $t0, -328($fp)
	# if %t77 goto .L891   ; line 1382
	lw      $t0, -328($fp)
	bne     $t0, $zero, __rt_vscan.L891
	# %t78 = %conv == 71   ; line 1382
	lw      $t0, -52($fp)
	xori    $t0, $t0, 71
	sltiu   $t0, $t0, 1
	sw      $t0, -332($fp)
	# ifFalse %t78 goto .L892   ; line 1382
	lw      $t0, -332($fp)
	beq     $t0, $zero, __rt_vscan.L892
__rt_vscan.L891:
	# %t79 = addr ap   ; line 1383
	addiu   $t0, $fp, -16
	sw      $t0, -336($fp)
	# param %islong : int   ; line 1383
	lw      $t0, -48($fp)
	sw      $t0, 0($sp)
	# param %suppress : int   ; line 1383
	lw      $t0, -40($fp)
	sw      $t0, 4($sp)
	# param %t79 : ptr   ; line 1383
	lw      $t0, -336($fp)
	sw      $t0, 8($sp)
	# %t80 = call @scan_float, 3   ; line 1383
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_scan_float
	sw      $v0, -340($fp)
	# %ok = %t80   ; line 1383
	lw      $t0, -340($fp)
	sw      $t0, -56($fp)
	# goto .L893   ; line 1383
	b       __rt_vscan.L893
__rt_vscan.L892:
	# %t81 = %conv == 99   ; line 1384
	lw      $t0, -52($fp)
	xori    $t0, $t0, 99
	sltiu   $t0, $t0, 1
	sw      $t0, -344($fp)
	# if %t81 goto .L894   ; line 1384
	lw      $t0, -344($fp)
	bne     $t0, $zero, __rt_vscan.L894
	# %t82 = %conv == 115   ; line 1384
	lw      $t0, -52($fp)
	xori    $t0, $t0, 115
	sltiu   $t0, $t0, 1
	sw      $t0, -348($fp)
	# ifFalse %t82 goto .L895   ; line 1384
	lw      $t0, -348($fp)
	beq     $t0, $zero, __rt_vscan.L895
__rt_vscan.L894:
	# %t83 = addr ap   ; line 1385
	addiu   $t0, $fp, -16
	sw      $t0, -352($fp)
	# param %conv : int   ; line 1385
	lw      $t0, -52($fp)
	sw      $t0, 0($sp)
	# param %width : int   ; line 1385
	lw      $t0, -44($fp)
	sw      $t0, 4($sp)
	# param %suppress : int   ; line 1385
	lw      $t0, -40($fp)
	sw      $t0, 8($sp)
	# param %t83 : ptr   ; line 1385
	lw      $t0, -352($fp)
	sw      $t0, 12($sp)
	# %t84 = call @scan_chars, 4   ; line 1385
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	lw      $a3, 12($sp)
	jal     __rt_scan_chars
	sw      $v0, -356($fp)
	# %ok = %t84   ; line 1385
	lw      $t0, -356($fp)
	sw      $t0, -56($fp)
	# goto .L896   ; line 1385
	b       __rt_vscan.L896
__rt_vscan.L895:
	# return %assigned   ; line 1386
	lw      $v0, -36($fp)
	b       __rt_vscan.ret
__rt_vscan.L896:
__rt_vscan.L893:
__rt_vscan.L890:
	# if %ok goto .L898   ; line 1387
	lw      $t0, -56($fp)
	bne     $t0, $zero, __rt_vscan.L898
	# param %assigned : int   ; line 1387
	lw      $t0, -36($fp)
	sw      $t0, 0($sp)
	# %t85 = call @sc_fail, 1   ; line 1387
	lw      $a0, 0($sp)
	jal     __rt_sc_fail
	sw      $v0, -360($fp)
	# return %t85   ; line 1387
	lw      $v0, -360($fp)
	b       __rt_vscan.ret
__rt_vscan.L898:
	# if %suppress goto .L900   ; line 1388
	lw      $t0, -40($fp)
	bne     $t0, $zero, __rt_vscan.L900
	# %t86 = %assigned   ; line 1388
	lw      $t0, -36($fp)
	sw      $t0, -364($fp)
	# %t87 = %t86 + 1   ; line 1388
	lw      $t0, -364($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -368($fp)
	# %assigned = %t87   ; line 1388
	lw      $t0, -368($fp)
	sw      $t0, -36($fp)
__rt_vscan.L900:
	# goto .L861   ; line 1388
	b       __rt_vscan.L861
__rt_vscan.L863:
	# return %assigned   ; line 1390
	lw      $v0, -36($fp)
__rt_vscan.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vscanf
	.text
# ---------------------------------------------------------------
# function vscanf (line 1393), returns int
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param fmt (str, arrives in $a0)
#   4($fp)	param ap (ptr, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%fmt : str
#   -16($fp)	%ap : ptr
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vscanf
__rt_vscanf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param fmt : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param ap : ptr at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t2 = addr @sc_str   ; line 1394
	la      $t0, __rtg_sc_str
	sw      $t0, -20($fp)
	# store.w %t2, 0   ; line 1394
	lw      $t0, -20($fp)
	sw      $zero, 0($t0)
	# %t3 = addr @sc_f   ; line 1395
	la      $t0, __rtg_sc_f
	sw      $t0, -24($fp)
	# %t4 = addr @rt_stdin   ; line 1395
	la      $t0, __rtg_rt_stdin
	sw      $t0, -28($fp)
	# store.w %t3, %t4   ; line 1395
	lw      $t0, -24($fp)
	lw      $t1, -28($fp)
	sw      $t1, 0($t0)
	# %t5 = addr @sc_eof   ; line 1396
	la      $t0, __rtg_sc_eof
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 1396
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 1397
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 1397
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# %t6 = call @vscan, 2   ; line 1397
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vscan
	sw      $v0, -36($fp)
	# return %t6   ; line 1397
	lw      $v0, -36($fp)
__rt_vscanf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vfscanf
	.text
# ---------------------------------------------------------------
# function vfscanf (line 1400), returns int
# frame 64 bytes ($fp = $sp at entry):
#   0($fp)	param f (ptr, arrives in $a0)
#   4($fp)	param fmt (str, arrives in $a1)
#   8($fp)	param ap (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%f : ptr
#   -16($fp)	%fmt : str
#   -20($fp)	%ap : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : ptr
#   -44($fp)	%t8 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vfscanf
__rt_vfscanf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param f : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param fmt : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param ap : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# param %f : ptr   ; line 1401
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t3 = call @file_of, 1   ; line 1401
	lw      $a0, 0($sp)
	jal     __rt_file_of
	sw      $v0, -24($fp)
	# %f = %t3   ; line 1401
	lw      $t0, -24($fp)
	sw      $t0, -12($fp)
	# %t4 = %f == 0   ; line 1402
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L902   ; line 1402
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_vfscanf.L902
	# return -1   ; line 1402
	li      $v0, -1
	b       __rt_vfscanf.ret
__rt_vfscanf.L902:
	# %t5 = addr @sc_str   ; line 1403
	la      $t0, __rtg_sc_str
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 1403
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# %t6 = addr @sc_f   ; line 1404
	la      $t0, __rtg_sc_f
	sw      $t0, -36($fp)
	# store.w %t6, %f   ; line 1404
	lw      $t0, -36($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
	# %t7 = addr @sc_eof   ; line 1405
	la      $t0, __rtg_sc_eof
	sw      $t0, -40($fp)
	# store.w %t7, 0   ; line 1405
	lw      $t0, -40($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 1406
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 1406
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t8 = call @vscan, 2   ; line 1406
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vscan
	sw      $v0, -44($fp)
	# return %t8   ; line 1406
	lw      $v0, -44($fp)
__rt_vfscanf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_vsscanf
	.text
# ---------------------------------------------------------------
# function vsscanf (line 1409), returns int
# frame 56 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   4($fp)	param fmt (str, arrives in $a1)
#   8($fp)	param ap (ptr, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%fmt : str
#   -20($fp)	%ap : ptr
#   -24($fp)	%t3 : ptr
#   -28($fp)	%t4 : ptr
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_vsscanf
__rt_vsscanf:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -56
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param fmt : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param ap : ptr at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %t3 = addr @sc_str   ; line 1410
	la      $t0, __rtg_sc_str
	sw      $t0, -24($fp)
	# store.w %t3, 1   ; line 1410
	lw      $t0, -24($fp)
	li      $t1, 1
	sw      $t1, 0($t0)
	# %t4 = addr @sc_s   ; line 1411
	la      $t0, __rtg_sc_s
	sw      $t0, -28($fp)
	# store.w %t4, %s   ; line 1411
	lw      $t0, -28($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
	# %t5 = addr @sc_eof   ; line 1412
	la      $t0, __rtg_sc_eof
	sw      $t0, -32($fp)
	# store.w %t5, 0   ; line 1412
	lw      $t0, -32($fp)
	sw      $zero, 0($t0)
	# param %fmt : str   ; line 1413
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# param %ap : ptr   ; line 1413
	lw      $t0, -20($fp)
	sw      $t0, 4($sp)
	# %t6 = call @vscan, 2   ; line 1413
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_vscan
	sw      $v0, -36($fp)
	# return %t6   ; line 1413
	lw      $v0, -36($fp)
__rt_vsscanf.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_heap_header
	.text
# ---------------------------------------------------------------
# function heap_header (line 1430), returns ptr
# frame 120 bytes ($fp = $sp at entry):
#   0($fp)	param p (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%p : str
#   -16($fp)	%h : ptr
#   -20($fp)	%t2 : ptr
#   -24($fp)	%t3 : str
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : ptr
#   -52($fp)	%t10 : str
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : str
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   -92($fp)	%t20 : int
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_heap_header
__rt_heap_header:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -120
	sw      $a0, 0($fp)
	# param p : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t2 = addr @heap_lo   ; line 1432
	la      $t0, __rtg_heap_lo
	sw      $t0, -20($fp)
	# %t3 = load.w %t2   ; line 1432
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -24($fp)
	# %t4 = %t3 == 0   ; line 1432
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# if %t4 goto .L903   ; line 1432
	lw      $t0, -28($fp)
	bne     $t0, $zero, __rt_heap_header.L903
	# %t5 = addr @heap_lo   ; line 1432
	la      $t0, __rtg_heap_lo
	sw      $t0, -32($fp)
	# %t6 = load.w %t5   ; line 1432
	lw      $t0, -32($fp)
	lw      $t1, 0($t0)
	sw      $t1, -36($fp)
	# %t7 = %t6 + 8   ; line 1432
	lw      $t0, -36($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -40($fp)
	# %t8 = %p < %t7   ; line 1432
	lw      $t0, -12($fp)
	lw      $t1, -40($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -44($fp)
	# if %t8 goto .L903   ; line 1432
	lw      $t0, -44($fp)
	bne     $t0, $zero, __rt_heap_header.L903
	# %t9 = addr @heap_hi   ; line 1432
	la      $t0, __rtg_heap_hi
	sw      $t0, -48($fp)
	# %t10 = load.w %t9   ; line 1432
	lw      $t0, -48($fp)
	lw      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %p >= %t10   ; line 1432
	lw      $t0, -12($fp)
	lw      $t1, -52($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L904   ; line 1432
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_heap_header.L904
__rt_heap_header.L903:
	# return 0   ; line 1432
	move    $v0, $zero
	b       __rt_heap_header.ret
__rt_heap_header.L904:
	# %t12 = %p & 7   ; line 1433
	lw      $t0, -12($fp)
	andi    $t0, $t0, 7
	sw      $t0, -60($fp)
	# %t13 = %t12 != 0   ; line 1433
	lw      $t0, -60($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -64($fp)
	# ifFalse %t13 goto .L906   ; line 1433
	lw      $t0, -64($fp)
	beq     $t0, $zero, __rt_heap_header.L906
	# return 0   ; line 1433
	move    $v0, $zero
	b       __rt_heap_header.ret
__rt_heap_header.L906:
	# %t14 = %p - 8   ; line 1434
	lw      $t0, -12($fp)
	addiu   $t0, $t0, -8
	sw      $t0, -68($fp)
	# %h = %t14   ; line 1434
	lw      $t0, -68($fp)
	sw      $t0, -16($fp)
	# %t15 = %h + 4   ; line 1435
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 1435
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %t17 = %p ^ 974917093   ; line 1435
	lw      $t0, -12($fp)
	li      $t1, 974917093
	xor     $t0, $t0, $t1
	sw      $t0, -80($fp)
	# %t18 = %t16 != %t17   ; line 1435
	lw      $t0, -76($fp)
	lw      $t1, -80($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -84($fp)
	# ifFalse %t18 goto .L908   ; line 1435
	lw      $t0, -84($fp)
	beq     $t0, $zero, __rt_heap_header.L908
	# %t19 = %h + 4   ; line 1435
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -88($fp)
	# %t20 = load.w %t19   ; line 1435
	lw      $t0, -88($fp)
	lw      $t1, 0($t0)
	sw      $t1, -92($fp)
	# %t21 = %p ^ 256830224   ; line 1435
	lw      $t0, -12($fp)
	li      $t1, 256830224
	xor     $t0, $t0, $t1
	sw      $t0, -96($fp)
	# %t22 = %t20 != %t21   ; line 1435
	lw      $t0, -92($fp)
	lw      $t1, -96($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -100($fp)
	# ifFalse %t22 goto .L908   ; line 1435
	lw      $t0, -100($fp)
	beq     $t0, $zero, __rt_heap_header.L908
	# return 0   ; line 1435
	move    $v0, $zero
	b       __rt_heap_header.ret
__rt_heap_header.L908:
	# return %h   ; line 1436
	lw      $v0, -16($fp)
__rt_heap_header.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_malloc
	.text
# ---------------------------------------------------------------
# function malloc (line 1439), returns str
# frame 184 bytes ($fp = $sp at entry):
#   0($fp)	param n (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%n : int
#   -16($fp)	%p : str
#   -20($fp)	%prev : str
#   -24($fp)	%h : ptr
#   -28($fp)	%need : int
#   -32($fp)	%t5 : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : ptr
#   -60($fp)	%t12 : str
#   -64($fp)	%t13 : str
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : ptr
#   -88($fp)	%t19 : int
#   -92($fp)	%t20 : ptr
#   -96($fp)	%t21 : int
#   -100($fp)	%t22 : int
#   -104($fp)	%t23 : int
#   -108($fp)	%t24 : str
#   -112($fp)	%t25 : int
#   -116($fp)	%t26 : int
#   -120($fp)	%t27 : str
#   -124($fp)	%t28 : ptr
#   -128($fp)	%t29 : str
#   -132($fp)	%t30 : int
#   -136($fp)	%t31 : ptr
#   -140($fp)	%t32 : ptr
#   -144($fp)	%t33 : str
#   -148($fp)	%t34 : str
#   -152($fp)	%t35 : ptr
#   -156($fp)	%t36 : ptr
#   -160($fp)	%t37 : int
#   -164($fp)	%t38 : int
#   -168($fp)	%t39 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_malloc
__rt_malloc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -184
	sw      $a0, 0($fp)
	# param n : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t5 = %n == 0   ; line 1444
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L910   ; line 1444
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_malloc.L910
	# %n = 1   ; line 1444
	li      $t0, 1
	sw      $t0, -12($fp)
__rt_malloc.L910:
	# %t6 = %n < 0   ; line 1445
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -36($fp)
	# if %t6 goto .L911   ; line 1445
	lw      $t0, -36($fp)
	bne     $t0, $zero, __rt_malloc.L911
	# %t7 = %n > 2147483632   ; line 1445
	lw      $t0, -12($fp)
	li      $t1, 2147483632
	slt     $t0, $t1, $t0
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L912   ; line 1445
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_malloc.L912
__rt_malloc.L911:
	# %t8 = addr @.str8   ; line 1445
	la      $t0, __rtd.str8
	sw      $t0, -44($fp)
	# param %t8 : str   ; line 1445
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# call @rt_fatal, 1   ; line 1445
	lw      $a0, 0($sp)
	jal     __rt_rt_fatal
__rt_malloc.L912:
	# %t9 = %n + 7   ; line 1446
	lw      $t0, -12($fp)
	addiu   $t0, $t0, 7
	sw      $t0, -48($fp)
	# %t10 = %t9 & -8   ; line 1446
	lw      $t0, -48($fp)
	li      $t1, -8
	and     $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %need = %t10   ; line 1446
	lw      $t0, -52($fp)
	sw      $t0, -28($fp)
	# %prev = 0   ; line 1447
	move    $t0, $zero
	sw      $t0, -20($fp)
	# %t11 = addr @free_head   ; line 1448
	la      $t0, __rtg_free_head
	sw      $t0, -56($fp)
	# %t12 = load.w %t11   ; line 1448
	lw      $t0, -56($fp)
	lw      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %p = %t12   ; line 1448
	lw      $t0, -60($fp)
	sw      $t0, -16($fp)
__rt_malloc.L913:
	# ifFalse %p goto .L915   ; line 1449
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_malloc.L915
	# %t13 = %p - 8   ; line 1450
	lw      $t0, -16($fp)
	addiu   $t0, $t0, -8
	sw      $t0, -64($fp)
	# %h = %t13   ; line 1450
	lw      $t0, -64($fp)
	sw      $t0, -24($fp)
	# %t14 = %h + 0   ; line 1451
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 1451
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# %t16 = %t15 >= %need   ; line 1451
	lw      $t0, -72($fp)
	lw      $t1, -28($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -76($fp)
	# ifFalse %t16 goto .L917   ; line 1451
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_malloc.L917
	# ifFalse %prev goto .L919   ; line 1452
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_malloc.L919
	# %t17 = load.w %p   ; line 1452
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -80($fp)
	# store.w %prev, %t17   ; line 1452
	lw      $t0, -20($fp)
	lw      $t1, -80($fp)
	sw      $t1, 0($t0)
	# goto .L920   ; line 1452
	b       __rt_malloc.L920
__rt_malloc.L919:
	# %t18 = addr @free_head   ; line 1453
	la      $t0, __rtg_free_head
	sw      $t0, -84($fp)
	# %t19 = load.w %p   ; line 1453
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -88($fp)
	# store.w %t18, %t19   ; line 1453
	lw      $t0, -84($fp)
	lw      $t1, -88($fp)
	sw      $t1, 0($t0)
__rt_malloc.L920:
	# %t20 = %h + 4   ; line 1454
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -92($fp)
	# %t21 = %p ^ 974917093   ; line 1454
	lw      $t0, -16($fp)
	li      $t1, 974917093
	xor     $t0, $t0, $t1
	sw      $t0, -96($fp)
	# store.w %t20, %t21   ; line 1454
	lw      $t0, -92($fp)
	lw      $t1, -96($fp)
	sw      $t1, 0($t0)
	# return %p   ; line 1455
	lw      $v0, -16($fp)
	b       __rt_malloc.ret
__rt_malloc.L917:
	# %prev = %p   ; line 1457
	lw      $t0, -16($fp)
	sw      $t0, -20($fp)
	# %t22 = load.w %p   ; line 1458
	lw      $t0, -16($fp)
	lw      $t1, 0($t0)
	sw      $t1, -100($fp)
	# %p = %t22   ; line 1458
	lw      $t0, -100($fp)
	sw      $t0, -16($fp)
	# goto .L913   ; line 1458
	b       __rt_malloc.L913
__rt_malloc.L915:
	# %t23 = %need + 8   ; line 1460
	lw      $t0, -28($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -104($fp)
	# param %t23 : int   ; line 1460
	lw      $t0, -104($fp)
	sw      $t0, 0($sp)
	# %t24 = call @sys_sbrk, 1   ; line 1460
	lw      $a0, 0($sp)
	jal     __rt_sys_sbrk
	sw      $v0, -108($fp)
	# %p = %t24   ; line 1460
	lw      $t0, -108($fp)
	sw      $t0, -16($fp)
	# %t25 = %p == 0   ; line 1461
	lw      $t0, -16($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -112($fp)
	# if %t25 goto .L921   ; line 1461
	lw      $t0, -112($fp)
	bne     $t0, $zero, __rt_malloc.L921
	# %t26 = %p == -1   ; line 1461
	lw      $t0, -16($fp)
	li      $t1, -1
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -116($fp)
	# ifFalse %t26 goto .L922   ; line 1461
	lw      $t0, -116($fp)
	beq     $t0, $zero, __rt_malloc.L922
__rt_malloc.L921:
	# %t27 = addr @.str8   ; line 1461
	la      $t0, __rtd.str8
	sw      $t0, -120($fp)
	# param %t27 : str   ; line 1461
	lw      $t0, -120($fp)
	sw      $t0, 0($sp)
	# call @rt_fatal, 1   ; line 1461
	lw      $a0, 0($sp)
	jal     __rt_rt_fatal
__rt_malloc.L922:
	# %t28 = addr @heap_lo   ; line 1462
	la      $t0, __rtg_heap_lo
	sw      $t0, -124($fp)
	# %t29 = load.w %t28   ; line 1462
	lw      $t0, -124($fp)
	lw      $t1, 0($t0)
	sw      $t1, -128($fp)
	# %t30 = %t29 == 0   ; line 1462
	lw      $t0, -128($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -132($fp)
	# ifFalse %t30 goto .L924   ; line 1462
	lw      $t0, -132($fp)
	beq     $t0, $zero, __rt_malloc.L924
	# %t31 = addr @heap_lo   ; line 1462
	la      $t0, __rtg_heap_lo
	sw      $t0, -136($fp)
	# store.w %t31, %p   ; line 1462
	lw      $t0, -136($fp)
	lw      $t1, -16($fp)
	sw      $t1, 0($t0)
__rt_malloc.L924:
	# %t32 = addr @heap_hi   ; line 1463
	la      $t0, __rtg_heap_hi
	sw      $t0, -140($fp)
	# %t33 = %p + %need   ; line 1463
	lw      $t0, -16($fp)
	lw      $t1, -28($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -144($fp)
	# %t34 = %t33 + 8   ; line 1463
	lw      $t0, -144($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -148($fp)
	# store.w %t32, %t34   ; line 1463
	lw      $t0, -140($fp)
	lw      $t1, -148($fp)
	sw      $t1, 0($t0)
	# %h = %p   ; line 1464
	lw      $t0, -16($fp)
	sw      $t0, -24($fp)
	# %t35 = %h + 0   ; line 1465
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -152($fp)
	# store.w %t35, %need   ; line 1465
	lw      $t0, -152($fp)
	lw      $t1, -28($fp)
	sw      $t1, 0($t0)
	# %t36 = %h + 4   ; line 1466
	lw      $t0, -24($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -156($fp)
	# %t37 = %p + 8   ; line 1466
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -160($fp)
	# %t38 = %t37 ^ 974917093   ; line 1466
	lw      $t0, -160($fp)
	li      $t1, 974917093
	xor     $t0, $t0, $t1
	sw      $t0, -164($fp)
	# store.w %t36, %t38   ; line 1466
	lw      $t0, -156($fp)
	lw      $t1, -164($fp)
	sw      $t1, 0($t0)
	# %t39 = %p + 8   ; line 1467
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 8
	sw      $t0, -168($fp)
	# return %t39   ; line 1467
	lw      $v0, -168($fp)
__rt_malloc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_free
	.text
# ---------------------------------------------------------------
# function free (line 1470), returns void
# frame 104 bytes ($fp = $sp at entry):
#   0($fp)	param p (str, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%p : str
#   -16($fp)	%h : ptr
#   -20($fp)	%q : str
#   -24($fp)	%prev : str
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : ptr
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : str
#   -44($fp)	%t8 : ptr
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : str
#   -64($fp)	%t13 : ptr
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : ptr
#   -76($fp)	%t16 : str
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : ptr
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_free
__rt_free:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -104
	sw      $a0, 0($fp)
	# param p : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t4 = %p == 0   ; line 1474
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L926   ; line 1474
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_free.L926
	# return   ; line 1474
	b       __rt_free.ret
__rt_free.L926:
	# param %p : str   ; line 1475
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t5 = call @heap_header, 1   ; line 1475
	lw      $a0, 0($sp)
	jal     __rt_heap_header
	sw      $v0, -32($fp)
	# %h = %t5   ; line 1475
	lw      $t0, -32($fp)
	sw      $t0, -16($fp)
	# %t6 = %h == 0   ; line 1476
	lw      $t0, -16($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -36($fp)
	# ifFalse %t6 goto .L928   ; line 1476
	lw      $t0, -36($fp)
	beq     $t0, $zero, __rt_free.L928
	# %t7 = addr @.str9   ; line 1476
	la      $t0, __rtd.str9
	sw      $t0, -40($fp)
	# param %t7 : str   ; line 1476
	lw      $t0, -40($fp)
	sw      $t0, 0($sp)
	# call @rt_fatal, 1   ; line 1476
	lw      $a0, 0($sp)
	jal     __rt_rt_fatal
__rt_free.L928:
	# %t8 = %h + 4   ; line 1477
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -44($fp)
	# %t9 = load.w %t8   ; line 1477
	lw      $t0, -44($fp)
	lw      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %t10 = %p ^ 256830224   ; line 1477
	lw      $t0, -12($fp)
	li      $t1, 256830224
	xor     $t0, $t0, $t1
	sw      $t0, -52($fp)
	# %t11 = %t9 == %t10   ; line 1477
	lw      $t0, -48($fp)
	lw      $t1, -52($fp)
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L930   ; line 1477
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_free.L930
	# %t12 = addr @.str10   ; line 1477
	la      $t0, __rtd.str10
	sw      $t0, -60($fp)
	# param %t12 : str   ; line 1477
	lw      $t0, -60($fp)
	sw      $t0, 0($sp)
	# call @rt_fatal, 1   ; line 1477
	lw      $a0, 0($sp)
	jal     __rt_rt_fatal
__rt_free.L930:
	# %t13 = %h + 4   ; line 1478
	lw      $t0, -16($fp)
	addiu   $t0, $t0, 4
	sw      $t0, -64($fp)
	# %t14 = %p ^ 256830224   ; line 1478
	lw      $t0, -12($fp)
	li      $t1, 256830224
	xor     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# store.w %t13, %t14   ; line 1478
	lw      $t0, -64($fp)
	lw      $t1, -68($fp)
	sw      $t1, 0($t0)
	# %prev = 0   ; line 1479
	move    $t0, $zero
	sw      $t0, -24($fp)
	# %t15 = addr @free_head   ; line 1480
	la      $t0, __rtg_free_head
	sw      $t0, -72($fp)
	# %t16 = load.w %t15   ; line 1480
	lw      $t0, -72($fp)
	lw      $t1, 0($t0)
	sw      $t1, -76($fp)
	# %q = %t16   ; line 1480
	lw      $t0, -76($fp)
	sw      $t0, -20($fp)
__rt_free.L931:
	# ifFalse %q goto .L933   ; line 1481
	lw      $t0, -20($fp)
	beq     $t0, $zero, __rt_free.L933
	# %t17 = %q < %p   ; line 1481
	lw      $t0, -20($fp)
	lw      $t1, -12($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L933   ; line 1481
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_free.L933
	# %prev = %q   ; line 1482
	lw      $t0, -20($fp)
	sw      $t0, -24($fp)
	# %t18 = load.w %q   ; line 1483
	lw      $t0, -20($fp)
	lw      $t1, 0($t0)
	sw      $t1, -84($fp)
	# %q = %t18   ; line 1483
	lw      $t0, -84($fp)
	sw      $t0, -20($fp)
	# goto .L931   ; line 1483
	b       __rt_free.L931
__rt_free.L933:
	# store.w %p, %q   ; line 1485
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	sw      $t1, 0($t0)
	# ifFalse %prev goto .L935   ; line 1486
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_free.L935
	# store.w %prev, %p   ; line 1486
	lw      $t0, -24($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
	# goto .L936   ; line 1486
	b       __rt_free.L936
__rt_free.L935:
	# %t19 = addr @free_head   ; line 1487
	la      $t0, __rtg_free_head
	sw      $t0, -88($fp)
	# store.w %t19, %p   ; line 1487
	lw      $t0, -88($fp)
	lw      $t1, -12($fp)
	sw      $t1, 0($t0)
__rt_free.L936:
	# return
__rt_free.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_calloc
	.text
# ---------------------------------------------------------------
# function calloc (line 1491), returns str
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param n (int, arrives in $a0)
#   4($fp)	param size (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%n : int
#   -16($fp)	%size : int
#   -20($fp)	%p : str
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : str
#   -32($fp)	%t5 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_calloc
__rt_calloc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param n : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param size : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t3 = %n * %size   ; line 1493
	lw      $t0, -12($fp)
	lw      $t1, -16($fp)
	mul     $t0, $t0, $t1
	sw      $t0, -24($fp)
	# %n = %t3   ; line 1493
	lw      $t0, -24($fp)
	sw      $t0, -12($fp)
	# param %n : int   ; line 1494
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t4 = call @malloc, 1   ; line 1494
	lw      $a0, 0($sp)
	jal     __rt_malloc
	sw      $v0, -28($fp)
	# %p = %t4   ; line 1494
	lw      $t0, -28($fp)
	sw      $t0, -20($fp)
	# %t5 = %n > 0   ; line 1495
	lw      $t0, -12($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -32($fp)
	# ifFalse %t5 goto .L938   ; line 1495
	lw      $t0, -32($fp)
	beq     $t0, $zero, __rt_calloc.L938
	# param %p : str   ; line 1495
	lw      $t0, -20($fp)
	sw      $t0, 0($sp)
	# param %n : int   ; line 1495
	lw      $t0, -12($fp)
	sw      $t0, 4($sp)
	# call @bzero, 2   ; line 1495
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_bzero
__rt_calloc.L938:
	# return %p   ; line 1496
	lw      $v0, -20($fp)
__rt_calloc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_realloc
	.text
# ---------------------------------------------------------------
# function realloc (line 1501), returns str
# frame 96 bytes ($fp = $sp at entry):
#   0($fp)	param p (str, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%p : str
#   -16($fp)	%n : int
#   -20($fp)	%h : ptr
#   -24($fp)	%q : str
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : str
#   -36($fp)	%t6 : ptr
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : int
#   -52($fp)	%t10 : ptr
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : str
#   -68($fp)	%t14 : ptr
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_realloc
__rt_realloc:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -96
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param p : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param n : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t4 = %p == 0   ; line 1504
	lw      $t0, -12($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L940   ; line 1504
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_realloc.L940
	# param %n : int   ; line 1504
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t5 = call @malloc, 1   ; line 1504
	lw      $a0, 0($sp)
	jal     __rt_malloc
	sw      $v0, -32($fp)
	# return %t5   ; line 1504
	lw      $v0, -32($fp)
	b       __rt_realloc.ret
__rt_realloc.L940:
	# param %p : str   ; line 1505
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t6 = call @heap_header, 1   ; line 1505
	lw      $a0, 0($sp)
	jal     __rt_heap_header
	sw      $v0, -36($fp)
	# %h = %t6   ; line 1505
	lw      $t0, -36($fp)
	sw      $t0, -20($fp)
	# %t7 = %h == 0   ; line 1506
	lw      $t0, -20($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L942   ; line 1506
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_realloc.L942
	# %t8 = addr @.str11   ; line 1506
	la      $t0, __rtd.str11
	sw      $t0, -44($fp)
	# param %t8 : str   ; line 1506
	lw      $t0, -44($fp)
	sw      $t0, 0($sp)
	# call @rt_fatal, 1   ; line 1506
	lw      $a0, 0($sp)
	jal     __rt_rt_fatal
__rt_realloc.L942:
	# %t9 = %n >= 0   ; line 1507
	lw      $t0, -16($fp)
	slti    $t0, $t0, 0
	xori    $t0, $t0, 1
	sw      $t0, -48($fp)
	# ifFalse %t9 goto .L944   ; line 1507
	lw      $t0, -48($fp)
	beq     $t0, $zero, __rt_realloc.L944
	# %t10 = %h + 0   ; line 1507
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -52($fp)
	# %t11 = load.w %t10   ; line 1507
	lw      $t0, -52($fp)
	lw      $t1, 0($t0)
	sw      $t1, -56($fp)
	# %t12 = %t11 >= %n   ; line 1507
	lw      $t0, -56($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	xori    $t0, $t0, 1
	sw      $t0, -60($fp)
	# ifFalse %t12 goto .L944   ; line 1507
	lw      $t0, -60($fp)
	beq     $t0, $zero, __rt_realloc.L944
	# return %p   ; line 1507
	lw      $v0, -12($fp)
	b       __rt_realloc.ret
__rt_realloc.L944:
	# param %n : int   ; line 1508
	lw      $t0, -16($fp)
	sw      $t0, 0($sp)
	# %t13 = call @malloc, 1   ; line 1508
	lw      $a0, 0($sp)
	jal     __rt_malloc
	sw      $v0, -64($fp)
	# %q = %t13   ; line 1508
	lw      $t0, -64($fp)
	sw      $t0, -24($fp)
	# %t14 = %h + 0   ; line 1509
	lw      $t0, -20($fp)
	addiu   $t0, $t0, 0
	sw      $t0, -68($fp)
	# %t15 = load.w %t14   ; line 1509
	lw      $t0, -68($fp)
	lw      $t1, 0($t0)
	sw      $t1, -72($fp)
	# param %q : str   ; line 1509
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %p : str   ; line 1509
	lw      $t0, -12($fp)
	sw      $t0, 4($sp)
	# param %t15 : int   ; line 1509
	lw      $t0, -72($fp)
	sw      $t0, 8($sp)
	# %t16 = call @memmove, 3   ; line 1509
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_memmove
	sw      $v0, -76($fp)
	# param %p : str   ; line 1510
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# call @free, 1   ; line 1510
	lw      $a0, 0($sp)
	jal     __rt_free
	# return %q   ; line 1511
	lw      $v0, -24($fp)
__rt_realloc.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strcpy
	.text
# ---------------------------------------------------------------
# function strcpy (line 1517), returns str
# frame 64 bytes ($fp = $sp at entry):
#   0($fp)	param d (str, arrives in $a0)
#   4($fp)	param s (str, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : str
#   -16($fp)	%s : str
#   -20($fp)	%i : int
#   -24($fp)	%t3 : str
#   -28($fp)	%t4 : str
#   -32($fp)	%t5 : char
#   -36($fp)	%t6 : char
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strcpy
__rt_strcpy:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param d : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param s : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %i = 0   ; line 1519
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_strcpy.L945:
	# %t3 = %d + %i   ; line 1520
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -24($fp)
	# %t4 = %s + %i   ; line 1520
	lw      $t0, -16($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -28($fp)
	# %t5 = load.b %t4   ; line 1520
	lw      $t0, -28($fp)
	lb      $t1, 0($t0)
	sw      $t1, -32($fp)
	# store.b %t3, %t5   ; line 1520
	lw      $t0, -24($fp)
	lw      $t1, -32($fp)
	sb      $t1, 0($t0)
	# %t6 = sext.b %t5   ; line 1520
	lw      $t0, -32($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -36($fp)
	# %t7 = %t6 != 0   ; line 1520
	lw      $t0, -36($fp)
	xori    $t0, $t0, 0
	sltu    $t0, $zero, $t0
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L947   ; line 1520
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_strcpy.L947
	# %t8 = %i   ; line 1520
	lw      $t0, -20($fp)
	sw      $t0, -44($fp)
	# %t9 = %t8 + 1   ; line 1520
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -48($fp)
	# %i = %t9   ; line 1520
	lw      $t0, -48($fp)
	sw      $t0, -20($fp)
	# goto .L945   ; line 1520
	b       __rt_strcpy.L945
__rt_strcpy.L947:
	# return %d   ; line 1521
	lw      $v0, -12($fp)
__rt_strcpy.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strncpy
	.text
# ---------------------------------------------------------------
# function strncpy (line 1524), returns str
# frame 96 bytes ($fp = $sp at entry):
#   0($fp)	param d (str, arrives in $a0)
#   4($fp)	param s (str, arrives in $a1)
#   8($fp)	param n (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : str
#   -16($fp)	%s : str
#   -20($fp)	%n : int
#   -24($fp)	%i : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : str
#   -36($fp)	%t6 : str
#   -40($fp)	%t7 : char
#   -44($fp)	%t8 : char
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : char
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : str
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strncpy
__rt_strncpy:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -96
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param d : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param s : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param n : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %i = 0   ; line 1526
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_strncpy.L948:
	# %t4 = %i < %n   ; line 1527
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L950   ; line 1527
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_strncpy.L950
	# %t5 = %d + %i   ; line 1528
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = %s + %i   ; line 1528
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -36($fp)
	# %t7 = load.b %t6   ; line 1528
	lw      $t0, -36($fp)
	lb      $t1, 0($t0)
	sw      $t1, -40($fp)
	# store.b %t5, %t7   ; line 1528
	lw      $t0, -32($fp)
	lw      $t1, -40($fp)
	sb      $t1, 0($t0)
	# %t8 = sext.b %t7   ; line 1528
	lw      $t0, -40($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -44($fp)
	# %t9 = %s + %i   ; line 1529
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# %t10 = load.b %t9   ; line 1529
	lw      $t0, -48($fp)
	lb      $t1, 0($t0)
	sw      $t1, -52($fp)
	# %t11 = %t10 == 0   ; line 1529
	lw      $t0, -52($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -56($fp)
	# ifFalse %t11 goto .L952   ; line 1529
	lw      $t0, -56($fp)
	beq     $t0, $zero, __rt_strncpy.L952
	# goto .L950   ; line 1529
	b       __rt_strncpy.L950
__rt_strncpy.L952:
	# %t12 = %i   ; line 1530
	lw      $t0, -24($fp)
	sw      $t0, -60($fp)
	# %t13 = %t12 + 1   ; line 1530
	lw      $t0, -60($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -64($fp)
	# %i = %t13   ; line 1530
	lw      $t0, -64($fp)
	sw      $t0, -24($fp)
	# goto .L948   ; line 1530
	b       __rt_strncpy.L948
__rt_strncpy.L950:
__rt_strncpy.L953:
	# %t14 = %i < %n   ; line 1532
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L955   ; line 1532
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_strncpy.L955
	# %t15 = %d + %i   ; line 1532
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -72($fp)
	# store.b %t15, 0   ; line 1532
	lw      $t0, -72($fp)
	sb      $zero, 0($t0)
	# %t16 = %i   ; line 1532
	lw      $t0, -24($fp)
	sw      $t0, -76($fp)
	# %t17 = %t16 + 1   ; line 1532
	lw      $t0, -76($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# %i = %t17   ; line 1532
	lw      $t0, -80($fp)
	sw      $t0, -24($fp)
	# goto .L953   ; line 1532
	b       __rt_strncpy.L953
__rt_strncpy.L955:
	# return %d   ; line 1533
	lw      $v0, -12($fp)
__rt_strncpy.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strcat
	.text
# ---------------------------------------------------------------
# function strcat (line 1536), returns str
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param d (str, arrives in $a0)
#   4($fp)	param s (str, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : str
#   -16($fp)	%s : str
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : str
#   -28($fp)	%t4 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strcat
__rt_strcat:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param d : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param s : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param %d : str   ; line 1537
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# %t2 = call @strlen, 1   ; line 1537
	lw      $a0, 0($sp)
	jal     __rt_strlen
	sw      $v0, -20($fp)
	# %t3 = %d + %t2   ; line 1537
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -24($fp)
	# param %t3 : str   ; line 1537
	lw      $t0, -24($fp)
	sw      $t0, 0($sp)
	# param %s : str   ; line 1537
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# %t4 = call @strcpy, 2   ; line 1537
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	jal     __rt_strcpy
	sw      $v0, -28($fp)
	# return %d   ; line 1538
	lw      $v0, -12($fp)
__rt_strcat.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strncmp
	.text
# ---------------------------------------------------------------
# function strncmp (line 1544), returns int
# frame 104 bytes ($fp = $sp at entry):
#   0($fp)	param a (str, arrives in $a0)
#   4($fp)	param b (str, arrives in $a1)
#   8($fp)	param n (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%a : str
#   -16($fp)	%b : str
#   -20($fp)	%n : int
#   -24($fp)	%i : int
#   -28($fp)	%x : int
#   -32($fp)	%y : int
#   -36($fp)	%t6 : int
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : str
#   -48($fp)	%t9 : char
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : str
#   -60($fp)	%t12 : char
#   -64($fp)	%t13 : int
#   -68($fp)	%t14 : int
#   -72($fp)	%t15 : int
#   -76($fp)	%t16 : int
#   -80($fp)	%t17 : int
#   -84($fp)	%t18 : int
#   -88($fp)	%t19 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strncmp
__rt_strncmp:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -104
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param a : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param b : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param n : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %i = 0   ; line 1546
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_strncmp.L956:
	# %t6 = %n < 0   ; line 1547
	lw      $t0, -20($fp)
	slti    $t0, $t0, 0
	sw      $t0, -36($fp)
	# if %t6 goto .L957   ; line 1547
	lw      $t0, -36($fp)
	bne     $t0, $zero, __rt_strncmp.L957
	# %t7 = %i < %n   ; line 1547
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -40($fp)
	# ifFalse %t7 goto .L958   ; line 1547
	lw      $t0, -40($fp)
	beq     $t0, $zero, __rt_strncmp.L958
__rt_strncmp.L957:
	# %t8 = %a + %i   ; line 1548
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -44($fp)
	# %t9 = load.b %t8   ; line 1548
	lw      $t0, -44($fp)
	lb      $t1, 0($t0)
	sw      $t1, -48($fp)
	# %t10 = %t9 & 255   ; line 1548
	lw      $t0, -48($fp)
	andi    $t0, $t0, 255
	sw      $t0, -52($fp)
	# %x = %t10   ; line 1548
	lw      $t0, -52($fp)
	sw      $t0, -28($fp)
	# %t11 = %b + %i   ; line 1549
	lw      $t0, -16($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -56($fp)
	# %t12 = load.b %t11   ; line 1549
	lw      $t0, -56($fp)
	lb      $t1, 0($t0)
	sw      $t1, -60($fp)
	# %t13 = %t12 & 255   ; line 1549
	lw      $t0, -60($fp)
	andi    $t0, $t0, 255
	sw      $t0, -64($fp)
	# %y = %t13   ; line 1549
	lw      $t0, -64($fp)
	sw      $t0, -32($fp)
	# %t14 = %x != %y   ; line 1550
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	xor     $t0, $t0, $t1
	sltu    $t0, $zero, $t0
	sw      $t0, -68($fp)
	# ifFalse %t14 goto .L960   ; line 1550
	lw      $t0, -68($fp)
	beq     $t0, $zero, __rt_strncmp.L960
	# %t16 = %x < %y   ; line 1550
	lw      $t0, -28($fp)
	lw      $t1, -32($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -76($fp)
	# ifFalse %t16 goto .L962   ; line 1550
	lw      $t0, -76($fp)
	beq     $t0, $zero, __rt_strncmp.L962
	# %t15 = -1   ; line 1550
	li      $t0, -1
	sw      $t0, -72($fp)
	# goto .L963   ; line 1550
	b       __rt_strncmp.L963
__rt_strncmp.L962:
	# %t15 = 1   ; line 1550
	li      $t0, 1
	sw      $t0, -72($fp)
__rt_strncmp.L963:
	# return %t15   ; line 1550
	lw      $v0, -72($fp)
	b       __rt_strncmp.ret
__rt_strncmp.L960:
	# %t17 = %x == 0   ; line 1551
	lw      $t0, -28($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -80($fp)
	# ifFalse %t17 goto .L965   ; line 1551
	lw      $t0, -80($fp)
	beq     $t0, $zero, __rt_strncmp.L965
	# return 0   ; line 1551
	move    $v0, $zero
	b       __rt_strncmp.ret
__rt_strncmp.L965:
	# %t18 = %i   ; line 1552
	lw      $t0, -24($fp)
	sw      $t0, -84($fp)
	# %t19 = %t18 + 1   ; line 1552
	lw      $t0, -84($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -88($fp)
	# %i = %t19   ; line 1552
	lw      $t0, -88($fp)
	sw      $t0, -24($fp)
	# goto .L956   ; line 1552
	b       __rt_strncmp.L956
__rt_strncmp.L958:
	# return 0   ; line 1554
	move    $v0, $zero
__rt_strncmp.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strcmp
	.text
# ---------------------------------------------------------------
# function strcmp (line 1557), returns int
# frame 40 bytes ($fp = $sp at entry):
#   0($fp)	param a (str, arrives in $a0)
#   4($fp)	param b (str, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%a : str
#   -16($fp)	%b : str
#   -20($fp)	%t2 : int
#   -24($fp)	%t3 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strcmp
__rt_strcmp:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param a : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param b : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t2 = -1   ; line 1558
	li      $t0, -1
	sw      $t0, -20($fp)
	# param %a : str   ; line 1558
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %b : str   ; line 1558
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# param %t2 : int   ; line 1558
	lw      $t0, -20($fp)
	sw      $t0, 8($sp)
	# %t3 = call @strncmp, 3   ; line 1558
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_strncmp
	sw      $v0, -24($fp)
	# return %t3   ; line 1558
	lw      $v0, -24($fp)
__rt_strcmp.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_strchr
	.text
# ---------------------------------------------------------------
# function strchr (line 1561), returns str
# frame 80 bytes ($fp = $sp at entry):
#   0($fp)	param s (str, arrives in $a0)
#   4($fp)	param c (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%s : str
#   -16($fp)	%c : int
#   -20($fp)	%i : int
#   -24($fp)	%x : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : str
#   -36($fp)	%t6 : char
#   -40($fp)	%t7 : int
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : str
#   -52($fp)	%t10 : int
#   -56($fp)	%t11 : int
#   -60($fp)	%t12 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_strchr
__rt_strchr:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -80
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param s : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param c : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# %t4 = %c & 255   ; line 1563
	lw      $t0, -16($fp)
	andi    $t0, $t0, 255
	sw      $t0, -28($fp)
	# %c = %t4   ; line 1563
	lw      $t0, -28($fp)
	sw      $t0, -16($fp)
	# %i = 0   ; line 1564
	move    $t0, $zero
	sw      $t0, -20($fp)
__rt_strchr.L966:
	# %t5 = %s + %i   ; line 1566
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = load.b %t5   ; line 1566
	lw      $t0, -32($fp)
	lb      $t1, 0($t0)
	sw      $t1, -36($fp)
	# %t7 = %t6 & 255   ; line 1566
	lw      $t0, -36($fp)
	andi    $t0, $t0, 255
	sw      $t0, -40($fp)
	# %x = %t7   ; line 1566
	lw      $t0, -40($fp)
	sw      $t0, -24($fp)
	# %t8 = %x == %c   ; line 1567
	lw      $t0, -24($fp)
	lw      $t1, -16($fp)
	xor     $t0, $t0, $t1
	sltiu   $t0, $t0, 1
	sw      $t0, -44($fp)
	# ifFalse %t8 goto .L970   ; line 1567
	lw      $t0, -44($fp)
	beq     $t0, $zero, __rt_strchr.L970
	# %t9 = %s + %i   ; line 1567
	lw      $t0, -12($fp)
	lw      $t1, -20($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -48($fp)
	# return %t9   ; line 1567
	lw      $v0, -48($fp)
	b       __rt_strchr.ret
__rt_strchr.L970:
	# %t10 = %x == 0   ; line 1568
	lw      $t0, -24($fp)
	xori    $t0, $t0, 0
	sltiu   $t0, $t0, 1
	sw      $t0, -52($fp)
	# ifFalse %t10 goto .L972   ; line 1568
	lw      $t0, -52($fp)
	beq     $t0, $zero, __rt_strchr.L972
	# return 0   ; line 1568
	move    $v0, $zero
	b       __rt_strchr.ret
__rt_strchr.L972:
	# %t11 = %i   ; line 1569
	lw      $t0, -20($fp)
	sw      $t0, -56($fp)
	# %t12 = %t11 + 1   ; line 1569
	lw      $t0, -56($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -60($fp)
	# %i = %t12   ; line 1569
	lw      $t0, -60($fp)
	sw      $t0, -20($fp)
	# goto .L966   ; line 1569
	b       __rt_strchr.L966
	# return 0   ; line 1571
	move    $v0, $zero
__rt_strchr.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_memset
	.text
# ---------------------------------------------------------------
# function memset (line 1574), returns str
# frame 64 bytes ($fp = $sp at entry):
#   0($fp)	param p (str, arrives in $a0)
#   4($fp)	param v (int, arrives in $a1)
#   8($fp)	param n (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%p : str
#   -16($fp)	%v : int
#   -20($fp)	%n : int
#   -24($fp)	%i : int
#   -28($fp)	%t4 : int
#   -32($fp)	%t5 : str
#   -36($fp)	%t6 : char
#   -40($fp)	%t7 : char
#   -44($fp)	%t8 : int
#   -48($fp)	%t9 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_memset
__rt_memset:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -64
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param p : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param v : int at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param n : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %i = 0   ; line 1576
	move    $t0, $zero
	sw      $t0, -24($fp)
__rt_memset.L973:
	# %t4 = %i < %n   ; line 1576
	lw      $t0, -24($fp)
	lw      $t1, -20($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -28($fp)
	# ifFalse %t4 goto .L976   ; line 1576
	lw      $t0, -28($fp)
	beq     $t0, $zero, __rt_memset.L976
	# %t5 = %p + %i   ; line 1576
	lw      $t0, -12($fp)
	lw      $t1, -24($fp)
	addu    $t0, $t0, $t1
	sw      $t0, -32($fp)
	# %t6 = sext.b %v   ; line 1576
	lw      $t0, -16($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -36($fp)
	# store.b %t5, %t6   ; line 1576
	lw      $t0, -32($fp)
	lw      $t1, -36($fp)
	sb      $t1, 0($t0)
	# %t7 = sext.b %t6   ; line 1576
	lw      $t0, -36($fp)
	sll     $t0, $t0, 24
	sra     $t0, $t0, 24
	sw      $t0, -40($fp)
	# %t8 = %i   ; line 1576
	lw      $t0, -24($fp)
	sw      $t0, -44($fp)
	# %t9 = %t8 + 1   ; line 1576
	lw      $t0, -44($fp)
	addiu   $t0, $t0, 1
	sw      $t0, -48($fp)
	# %i = %t9   ; line 1576
	lw      $t0, -48($fp)
	sw      $t0, -24($fp)
	# goto .L973   ; line 1576
	b       __rt_memset.L973
__rt_memset.L976:
	# return %p   ; line 1577
	lw      $v0, -12($fp)
__rt_memset.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_memcpy
	.text
# ---------------------------------------------------------------
# function memcpy (line 1580), returns str
# frame 48 bytes ($fp = $sp at entry):
#   0($fp)	param d (str, arrives in $a0)
#   4($fp)	param s (str, arrives in $a1)
#   8($fp)	param n (int, arrives in $a2)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%d : str
#   -16($fp)	%s : str
#   -20($fp)	%n : int
#   -24($fp)	%t3 : int
#   -28($fp)	%t4 : str
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_memcpy
__rt_memcpy:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -48
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	sw      $a2, 8($fp)
	# param d : str at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# param s : str at 4($fp)
	lw      $t0, 4($fp)
	sw      $t0, -16($fp)
	# param n : int at 8($fp)
	lw      $t0, 8($fp)
	sw      $t0, -20($fp)
	# %t3 = %n > 0   ; line 1581
	lw      $t0, -20($fp)
	slt     $t0, $zero, $t0
	sw      $t0, -24($fp)
	# ifFalse %t3 goto .L978   ; line 1581
	lw      $t0, -24($fp)
	beq     $t0, $zero, __rt_memcpy.L978
	# param %d : str   ; line 1581
	lw      $t0, -12($fp)
	sw      $t0, 0($sp)
	# param %s : str   ; line 1581
	lw      $t0, -16($fp)
	sw      $t0, 4($sp)
	# param %n : int   ; line 1581
	lw      $t0, -20($fp)
	sw      $t0, 8($sp)
	# %t4 = call @memmove, 3   ; line 1581
	lw      $a0, 0($sp)
	lw      $a1, 4($sp)
	lw      $a2, 8($sp)
	jal     __rt_memmove
	sw      $v0, -28($fp)
__rt_memcpy.L978:
	# return %d   ; line 1582
	lw      $v0, -12($fp)
__rt_memcpy.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra

# @unit __rt_abs
	.text
# ---------------------------------------------------------------
# function abs (line 1585), returns int
# frame 40 bytes ($fp = $sp at entry):
#   0($fp)	param v (int, arrives in $a0)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -12($fp)	%v : int
#   -16($fp)	%t1 : int
#   -20($fp)	%t2 : int
#   0($sp)	outgoing arguments (16 bytes)
# ---------------------------------------------------------------
	.globl __rt_abs
__rt_abs:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -40
	sw      $a0, 0($fp)
	# param v : int at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	# %t1 = %v < 0   ; line 1586
	lw      $t0, -12($fp)
	slti    $t0, $t0, 0
	sw      $t0, -16($fp)
	# ifFalse %t1 goto .L980   ; line 1586
	lw      $t0, -16($fp)
	beq     $t0, $zero, __rt_abs.L980
	# %t2 = - %v   ; line 1586
	lw      $t0, -12($fp)
	subu    $t0, $zero, $t0
	sw      $t0, -20($fp)
	# return %t2   ; line 1586
	lw      $v0, -20($fp)
	b       __rt_abs.ret
__rt_abs.L980:
	# return %v   ; line 1587
	lw      $v0, -12($fp)
__rt_abs.ret:
	move    $sp, $fp
	lw      $ra, -4($sp)
	lw      $fp, -8($sp)
	jr      $ra
