lw $t0, 0x900($0) # read gpI1
lw $t1, 0x904($0) #read gpI2
add $t2, $t0, $t1
sw $t2, 0x005($0) # stor to mem
lw $t3, 0x005($0) # load from mem
sw $t3, 0x800($0) # set factorial n
addi $t0, $0, 0x1
sw $t0, 0x804($0) # set factorial go
jal factorial
j display

factorial:
lw $t0, 0x808($0) # get done/error
beq $t0, $0, factorial # continue while not done/error
jr $ra

display:
lw $s0, 0x80C($0) # read factorial result
sw $s0, 0x908($0) # save factorial result in gpO1
sw $t0, 0x90C($0) # save done/error result in gpO2

 