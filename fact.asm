main:
addi $s0, $0, 0x0F
addi $s1, $0, 1
sll $s2, $t1, 4
addi $s3, $0, 0xB

fact:
lw $t2, 0x0900($0)
and $a0, $t2, $s0
slt $t5, $s3, $a0
beq $t5, $s1, end
jal cal
nop

end:
and $t3, $t2, $s2
or $t3, $t3, $t5
sw $t3, 0x0908($0)
sw $v0, 0x090C($0)
j fact
nop

cal:
addi $sp, $sp, -8 
sw $a0, 4($sp) 
sw $ra, 0($sp) 
addi $t0, $0, 2
slt $t0, $a0, $t0 
beq $t0, $0, else 
addi $v0, $0, 1 # yes - return 1
addi $sp, $sp, 8 # restore $sp
jr $ra # return
nop

else:
addi $a0, $a0, -1 
jal cal
lw $ra, 0($sp)
lw $a0, 4($sp) 
addi $sp, $sp, 8 
multu $a0, $v0
mflo $v0 
jr $ra
nop
