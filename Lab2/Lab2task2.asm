.data
A:		.word 7, 42, 0 , 27, 16, 8, 4, 15, 31, 45


.text
.globl main
	
	
main:
		subu $sp, $sp, 4		# Make room for 1 register
		sw $ra, 4($sp)			# sets the stack pointer
		
		la $a0, A
		li $a1, 10

		jal Sort 		# call the sort function
		
		lw $ra, 4($sp)
		addu $sp, $sp, 4
		
			
		li $v0, 10		# Load exit op
			syscall		# Exit
	
	Sort:
		addi $sp, $sp, -20 		# Make room for 5 reg
		sw $ra, 16($sp)			# save (& sws from below)
		sw $s3, 12($sp)
		sw $s2, 8($sp)
		sw $s1, 4($sp)
		sw $s0, 0($sp)
		
		move $s2, $a0 			# Copy parameter $a0 in $s2 (saves $a0)
		move $s3, $a1			# Copy the parameter $a1 in $s3 (saves $a1)
		
		move $s0, $zero		# i = 0
		addi $s0, $zero, 1	# i = 1 
		
			Loop1: 	slt  $t0, $s0, $s3		# $t0 = 1 if $s0 < $s3 (i < n)
					beq $t0, $zero, Exit1	# Exit1 if $s0 >= $s3 (i >= n) ($t0 = 0)
					addi $s1, $s0, -1 	# j = i - 1
					
					Loop2:	slti $t0, $s1, 0			# $t0 = 1 if $s1 < 0 (j < 0)
							bne $t0, $zero, Exit2		# Exit2 if $s1 < 0 (j < 0) ($t0 notequalto 0)
							sll $t1, $s1, 2			# $t1 = j * 4
							add $t2, $s2, $t1		# $t2 = v + (j * 4)
							lw $t3, 0($t2)			# $t3 = v[j]
							lw $t4, 4($t2)			# $t4 = v[j +1]
							slt $t0, $t4, $t3		# $t0 = 0 if $t4 >= $t3
							beq $t0, $zero, Exit2		# Exit2 if $t4 >= $t3 ($t0 = 0)
							
							move $a0, $s2			# 1st paramter of Swap is v
							move $a1, $s1			# 2nd paramtere of Swap is j
							jal Swap			# go to Swap code
							
							addi $s1, $s1, -1		# j -= 1
							j Loop2				# jump to inner loop test
							
					Exit2: 	addi $s0, $s0, 1		# i += 1
							j Loop1				# jump to outer test
							
			Exit1:	lw $s0, 0 ($sp)		# restore $s0 from stack
					lw $s1, 4($sp)
					lw $s2, 8($sp)
					lw $s3, 12($sp)
					lw $ra, 16($sp)
					addi $sp, $sp, 20
					
					jr $ra 	# return to calling routine
			
			
		Swap: 	sll $t1, $a1, 2		# $t1 = k *4
				add $t1, $a0, $t1	# $t1 = v + (K *4) (address of v[k])
				
				lw $t0, 0($t1)		# $t0 = v[k]
				lw $t2, 4($t1)		# $t2 = v[k + 1]
				
				sw $t2, 0($t1)		# v[k] = $t2
				sw $t0, 4($t1)		# v[k+1] = $t0
				
				jr $ra			# return to calling routine
	