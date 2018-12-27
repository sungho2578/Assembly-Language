;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578 
;
; Assignment name: Assignment 4
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000				; Program begins here
;-------------
;Instructions
;-------------
LD R2, NEG48		       		; Load R2 with xFFD0 (#-48)
;------------------------------- 
;INSERT CODE STARTING FROM HERE 
;-------------------------------
MainBranch		       		; Outermost loop of the code
	AND R3, R3, #0			; Holds hex value of pos/neg signs
	AND R4, R4, #0			; Multiplication loop counter
	ADD R4, R4, #9			; Fill with 9 counts
	AND R5, R5, #0			; Stores the result / Initializing to 0
	AND R6, R6, #0			; Flag for negative sign input

	LD R0, introMessagePtr		; Load intro message into R0
	PUTS				; Print out the message
	
InputLoop				; BRANCH InputLoop	
	GETC				; Prompts the user for input
	OUT				; Print out the input value

isEnter					; BRANCH isEnter
	ADD R1, R0, #-10		; Compare input if it is Enter character
	BRz InputLoopEnd		; End the loop if enter was typed

isPosSign				; BRANCH isPosSign
	LD R3, PosSign			; Load Hex value of + sign into R3
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare input if it is + sign character
	BRnp isNegSign			; If not, skip the branch
	BR InputLoop			; Back to the loop
	
isNegSign				; BRANCH isNegSign
	LD R3, NegSign			; Load Hex value of - sign into R3
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare input if it is - sign character
	BRnp isCharacter		; If not, skip the branch
	ADD R6, R6, #-1			; If it is, flag R6 with #-1 for later use
	BR InputLoop			; Back to loop. No need to add it into R5

isCharacter				; BRANCH isCharacter
	LD R3, OtherChar		; Load Hex value of first special character
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare if input is character 
	BRzp PrintError			; Go to print error message
	
MultLoop				; BRANCH MultLoop
	ADD R1, R5, #0			; Temporarily copy R5 value into R1
InnerLoop
	ADD R5, R5, R1			; Add up into R5	
	ADD R4, R4, #-1			; Decrement counter by 1
	BRz toRealValue			; If counter = 0, end the loop
	BR InnerLoop			; Otherwise, back to the top of the loop 
	
toRealValue				; BRANCH toRealValue
	ADD R0, R0, R2			; Convert the number to real value
	ADD R5, R5, R0			; Add the R0 value into R5
	ADD R4, R4, #9			; Refill #9 for MultLoop counter
	BR InputLoop			; Back to the loop
	
InputLoopEnd				; BRANCH InputLoopEnd 
	ADD R5, R5, #0			; Check if only sign or nothing was entered
	BRz PrintError			; Branch to print error message and restart
	
	ADD R1, R6, #1	      		; Check negative sign flag
	BRnp EndProgram			; If no -sign was found, skip the code
	NOT R5, R5			; If -sign was found, negate the result
	ADD R5, R5, #1			; Add 1 to make it 2's complement
	BR EndProgram
	
PrintError				; BRANCH PrintError
	LEA R0, NewLine			; Load R0 with NewLine
	PUTS				; Print out the new line
	LD R0, errorMessagePtr		; Load R0 with errorMessage
	PUTS				; Print out the error message
	BR MainBranch			; Restart the program
	
EndProgram				; BRANCH EndProgram
	AND R1, R1, #0			; Reset R1 
	ADD R1, R5, #0			; Copy the result to R1
	
HALT					; End of code
;---------------	
;Data
;---------------
NegSign		.FILL x002D
PosSign		.FILL x002B
NEG48		.FILL xFFD0
OtherChar	.FILL x003A	
introMessagePtr	.FILL x6000
errorMessagePtr	.FILL x6100
NewLine		.STRINGZ "\n"

;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_msg1 .STRINGZ	"ERROR INVALID INPUT\n"

;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------
; The objective of this program is to illustrate how the .FILL pseudo-op
; does its role of translating text numbers (digit characters input)
; into actual numbers represented in 16-bit two's complement binary value.
	