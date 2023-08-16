.data 0x10010000
parola: .asciiz "ana"
fine:
scritta: .asciiz "pal"
.data 0x10010128
scrittura:

.text
la $t4, scritta
la $t5, scrittura
la $t0, parola
la $t1, fine
addi $t1, $t1, -2
loop: lbu $s1, ($t0)
lbu $s0, ($t1)
bne $s0, $s1, no_pal
addi $t1, $t1, -1
addi $t0, $t0, 1
xor $t3, $t0, $t1
beq $t3, $zero, exit
slt $t3, $t1, $t0
bne $t3, $zero, exit
j loop

exit:lbu $s2, ($t4)
beq $s2, $zero, finee
sb $s2, ($t5)
addi $t5,$t5,1
addi $t4, $t4, 1
j exit

finee: j finee
no_pal: j no_pal
