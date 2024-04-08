.data
A: .word 21, 50, 63, 72, 0, 95, 11, 28, 4, 5, 16, 7

.text 
.globl main

main:
	la $s0,A   # array A
	li $s1,12  # Length of array A
	li $s2,1   # var i (initialized at 1)
	li $s3,0   # var j
	li $s4,0   # var v
	li $t0,0   # address of A[i]
	li $t1,0   # addres of A[j]
	li $t2,0   # value of A[i]
	li $t3,0   # value of A[j]
	
	
Loop1:
	sll $t0, $s2, 2    # shift left obj in $s2 left by 2, puts result into $t0
	add $t0, $t0, $s0  # adds $t0 to $s0
	lw $s4, 0($t0)     # loads A[i] into v
	addi $s3, $s2, -1  # j = i-1
	sll $t1, $s3, 2    # shifts object in $s3 left by 2, puts result into $t1
	add $t1, $t1, $s0  # Adds $t1 to $s0 to get A[j] in $t1
	
Loop2:
	lw $t3, 0($t1)          # Adds 0 to $t1 to get an addy, puts val of A[j] -> $t3
	blt $t3, $s4, Break     # Branches to break if $t3 < $s4
	sw $t3, 4($t1)          # Adds 4 to $t1 to get addy of A[j+1] and stores in $t3
	addi $s3, $s3, -1       # --j
	addi $t1, $t1, -4       # keeps mem access consistent to j
	bge $s3, $zero, Loop2	# conditional branch to loop2 if $s3 >= 0
	
Break:
	sw $s4, 4($t1)       # A[j+1] = v
	addi $s2, $s2, 1     # ++i
	blt $s2, $s1, Loop1  # Branches to loop1 if $s2 < $s1
	
Exit:
	li $v0,10   # load exit op
	syscall     # exit
	
	
	
	
	