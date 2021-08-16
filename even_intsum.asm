##James Marah
.data
Prompt1: .asciiz "\n Please input a value for X: "
Prompt2: .asciiz "\n Please input a value for Y: "
 Bad:    .asciiz "\n X can't be greater/equal to Y, try again\n"
 Result: .asciiz "\n The sum of the even integers between X and Y is: "
.text

addi $s0, $zero, 2
#will determine wheter an integer is even or not
main:

li $v0, 4
#load $v0 with the print_string code

la $a0, Prompt1
#load $a0 with the message to be displayed

syscall

# Get the user input X and Y

li $v0, 5
#load $v0 with the read_int code

syscall
#for X

move $t0, $v0
# move the number read from $v0 to $t0

li $v0, 4
#load $v0 with the print_string code

la $a0, Prompt2
#load $a0 with the message to be displayed

syscall

li $v0, 5
#load $v0 with the read_int code

syscall
#for Y

move $t1, $v0
# move the number read from $v0 to $t1

#check if t0 (X) is less than $t1 (Y)

slt $s1, $t0, $t1

beq $s1, $zero, redo

do:

div $t0, $s0
#divide X by 2

mfhi
$s2
#s2 is the remainder

beqz
$s2, sum
#branch to sum if s2 != 0

#or increase X by 1 otherwise and go back to do

addi $t0, $t0, 1

b
do

sum:

add $t3, $t3, $t0
#add value of X to $t3

addi $t0, $t0, 1 # increase X by 1

b
while

while:

ble $t0, $t1, do

b end
#if X >= Y branch to end

#re-enter numbers that meet the condition instead of

#ending the programJamesMarah_Lab2.asm
- 2 -

redo:

li $v0, 4

la $a0, Bad

syscall

b main
#lets user automatically start over

#print out the sum

end:

li $v0, 4

la $a0, Result

syscall

li $v0, 1

move $a0, $t3
#sum to be displayed

syscall

li $v0, 10

syscall
 #end of even integer sum calculator
