##James Marah
		.data
Prompt1:	.asciiz 	"\n Please enter a positive integer: "
Prompt2:	.asciiz 	"\n The number of 1's in "
Bad:		.asciiz 	"\n Needs to be positive integer. Try again.\n"
Result:		.asciiz 	" is: "
		
		.text
main:
    # prompt user input
    la        $a0, Prompt1
    li        $v0, 4
    syscall
 
    li        $v0, 5
    syscall
    move      $t0, $v0	
    
    blez      $t0, redo
    add	      $t1, $zero, $t0	 #original number
    addi      $s0, $zero, 2	 #binary dividend
    b         convert
    
convert: 
   # when the original number is divided down to 1
   beq	$t0, 1, extraOne
   
   div	$t0, $s0
   mfhi	$t2		# remainder (either 1 or 0)
   mflo	$t0		# quotient
   bgtz	$t2, one	# if remainder is one
   b	convert
   
one:
   #keep track of ones
   addi $t3, $t3, 1
   b convert

extraOne:
  addi $t3, $t3, 1
  b	end
  
end:     
    # print result
    la        $a0, Prompt2
    li        $v0, 4
    syscall
 
    move      $a0, $t1
    li        $v0, 1
    syscall
    
    la        $a0, Result
    li        $v0, 4
    syscall
    
    move      $a0, $t3
    li        $v0, 1
    syscall
 
    li        $v0, 10
    syscall
    
redo:
    la        $a0, Bad
    li        $v0, 4
    syscall
    
    b         main
#end of positive integer binary ones calculator
	
