##James Marah
		.data
Prompt1:	.asciiz 	"\n Please enter a positive integer: "
Prompt2:	.asciiz 	"\n The value of the factorial of "
Bad:		.asciiz 	"\n Needs to be positive integer. Try again.\n"
Result:		.asciiz 	" is: "
		.text
		

main:
 # ask user for input
    la        $a0, Prompt1
    li        $v0, 4
    syscall
 
    li        $v0, 5
    syscall
    move      $t0, $v0
    
    add	      $t1, $t1, $t0	#to call initial number when displaying result
 
    # call factorial function with jal
    addi      $sp, $sp, -12  # alloc 12 bytes
    sw        $t0, 0($sp)    # user input
    sw        $ra, 8($sp)    # save return address
    jal       fact
    lw        $ra, 8($sp)    # restore return address
    lw        $s0, 4($sp)    # load the final return value
    addi      $sp, $sp, 12   # deallocate 12 bytes
    
    # print result
    la        $a0, Prompt2
    li        $v0, 4
    syscall
 
    move      $a0, $t0
    li        $v0, 1
    syscall
    
    la        $a0, Result
    li        $v0, 4
    syscall
    
    move      $a0, $s0
    li        $v0, 1
    syscall
 
    li        $v0, 10
    syscall
 
fact:
    # base case: if number entered is 0
    lw        $t0, 0($sp)
    beqz      $t0, return1
    bltz      $t0, redo
 
    addi      $t0, $t0, -1
    # call factorial recursively
    addi      $sp, $sp, -12
    sw        $t0, 0($sp)
    sw        $ra, 8($sp)
    jal       fact
    # load the return value
    lw        $t1, 4($sp)
    lw        $ra, 8($sp)
    addiu     $sp, $sp, 12
    # load n
    lw        $t0, 0($sp)
    # n * (n - 1)
    mult      $t1, $t0
    mflo      $t2
    sw        $t2, 4($sp)
 
    jr        $ra
 
return1:
    li        $t0, 1
    sw        $t0, 4($sp)
    jr        $ra
    
redo:
    la        $a0, Bad
    li        $v0, 4
    syscall
    
    b         main
#end of positive integer factorial calculator
	
