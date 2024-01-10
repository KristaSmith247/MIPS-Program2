# program2.asm
# Author: Krista Smith
# Date: 10/6/23
# Description: The program will print user information, receive an integer
#	input from the user, and receive string input.

.data
name: .asciiz "Krista Smith"
assignment: .asciiz "\nCS 2810: Program 2"
goodbye: .asciiz "\n\nBye."
prompt: .asciiz "\nPlease enter an integer greater than or equal to 10."
invalid: .asciiz "\nYou entered a number less than 10."
valid: .asciiz "\nYou entered a number greater than or equal to 10."
variable: .space 64
enterInput: .asciiz "Please enter a string."

.text

# TASK 1: Print user information
# Pseudocode:
#	print(name)
#	print(assignment)
#	print(goodbye)

#	print(name)
	li $v0, 4
	la $a0, name
	syscall
	
#	print(assignment)
	li $v0, 4
	la $a0, assignment
	syscall
#	print(goodbye)
	li $v0, 4
	la $a0, goodbye
	syscall

# TASK 2: Capture input as integer and test value
# Pseudocode:
#	print(prompt)
#	if(num < 10)
#		print(invalidInput)
#		break;  -- jump to end
#	else
#		print(validInput)

# Registers used (part 2):
# s0 - num (number entered by user)
# t0 - 10


	li $t0, 10 # hardcode t0 = 10

# print(prompt)
	li $v0, 4
	la $a0, prompt
	syscall
# enter input
	li $v0, 5
	syscall
	move $s0, $v0 # move input to s0
	
# if(num < 10)
	bge $s0, $t0, validPath

#	print(invalidInput)
	li $v0, 4
	la $a0, invalid
	syscall
	j end # jump to end

# else
#	print(validInput)

validPath:	
	li $v0, 4
	la $a0, valid
	syscall


# TASK 3: Capture input as a string and print it in a loop
# Pseudocode:
# print(enterInput)
# 	myString = readStr()
# while(s0 > 0) {
#	print(myString)
#	s0--;
# }

# Registers used: (part 3)
# s0 - previous input value
# a1 - input buffer

	li $a1, 256 # input buffer size for string

# print(enterInput)
	li $v0, 4
	la $a0, enterInput
	syscall
	
# variable = readStr()
	li $v0, 8
	la $a0, variable # store input in variable
	syscall
	
# while(s0 > 0) {
loop:
	beq $s0, $zero, endloop
#	print(variable)
	li $v0, 4
	la $a0, variable
	syscall
	
	addi $s0, $s0, -1 # s0--;
	j loop # continue looping
# }
endloop:
end:
#	print(goodbye)
	li $v0, 4
	la $a0, goodbye
	syscall
# clean exit 
	li $v0, 10
	syscall