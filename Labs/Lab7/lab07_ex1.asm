;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578 
;
; Lab: lab 7
; Lab section: B21
; TA: Jason Goulding
;=================================================
.ORIG x3000				; Program begins here
;-------------
;Instructions
;-------------

;------------------------------- 
;INSERT CODE STARTING FROM HERE 
;-------------------------------
JSR SUB_TO_REAL_VALUE			; Invoke first subroutine
; ADD R5, R5, #1				; Add 1 to the result from Sub 1
	
HALT					; End of code
;-----	
;Data
;-----

;---------------------------------------------------------
; Subroutine: TO_REAL_VALUE
; Parameter: R0, R1, R2, R3, R4, R5, R6
; Postcondition: The subroutine will take input and 
; 		 transform it into a signle 16-bit value
;		 and store it into R5
; Return value: None 
;---------------------------------------------------------
.ORIG x3200
	
SUB_TO_REAL_VALUE			; BRANCH SUB_TO_REAL_VALUE
	ST R7, BACKUP_R7_3200		; Backup R7
	LD R2, NEG48		       	; Load R2 with xFFD0 (#-48)
	
	MainBranch		       	; Outermost loop of the code
	AND R3, R3, #0			; Holds hex value of pos/neg signs
	AND R4, R4, #0			; Multiplication loop counter
	ADD R4, R4, #9			; Fill with 9 counts
	AND R5, R5, #0			; Stores the result / Initializing to 0
	AND R6, R6, #0			; Flag for negative sign input

	LD R0, introMessage		; Load intro message into R0
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
	LD R0, errorMessage		; Load R0 with errorMessage
	PUTS				; Print out the error message
	BR MainBranch			; Restart the program

EndProgram				; BRANCH EndProgram
	
END_REAL_VALUE				; BRANCH END_REAL_VALUE	
	LD R7, BACKUP_R7_3200		; Restore R7
	RET				; Return to address R7

;-----------------
; Subroutine Data
;-----------------
BACKUP_R7_3200	.BLKW	#1
NegSign		.FILL x002D
PosSign		.FILL x002B
NEG48		.FILL xFFD0
OtherChar	.FILL x003A	
introMessage	.FILL x6000
errorMessage	.FILL x6100
NewLine		.STRINGZ "\n"

;---------------------------------------------------------
; Subroutine: PRINT_REAL_VALUE
; Parameter: R5
; Postcondition: The subroutine will print the value of R5 
; Return value: None 
;---------------------------------------------------------
.ORIG x3400	
	
;---------------
;messages
;---------------
.ORIG x6000
	
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"

;---------------
;END of PROGRAM
;---------------
.END