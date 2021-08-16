## James Marah
## Find the sum of the integers from 1 to N,
## with  N being the user input
	.data 
Prompt1:	.asciiz 	"\n Please input a value for N: "
Result:		.asciiz 	"\n The sum of the integers from 1 to N is: "
Bye:		.asciiz		"\n\n ***Have a nice day****"

	.text 
main:
	li	$v0, 4		#load $v0 with the print_string code
	la	$a0, Prompt1	#load $a0 with the message to be displayed
	syscall 
	
	# Get the user input N
	li	$v0, 5		#load $v0 with the read_int code
	syscall 		#read an integer
	move	$t0, $v0	# move the number read from $v0 to $t0
	
	bltz	$t0, else	# go to else if $v0 < 0
	li 	$t0, 0
	
	while:
	bltz	$t0, done
	addi	$t0, $t0, $v0
	subi	$v0, $v0, -1
	