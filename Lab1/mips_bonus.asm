.text
# load the 1st operand
li $t1, -21474837 # Please change the value here
# load the 2nd operand
li $t2, 2 # Please change the value here
add $t0, $t1, $t2
# print the result
li $v0, 1 #Place 1 in $v0 in order to print an integer
addi $a0, $t0, 0 #Load the integer from memory into $a0
syscall #syscall to print the integer # print the result
