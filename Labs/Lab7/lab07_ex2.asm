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
	LEA R0, prompt_mes		; Load R0 with prompt message
	PUTS				; Prompts the user for input
	GETC				; Store the value of input in R0
	OUT				; Echo the character

	JSR SUB_CountOnes		; Invoke first subroutine
	
	LEA R0, output_mes		; Load R0 with output message
	PUTS				; Prints out the message
	ADD R0, R5, #0			; Copy value of R5 into R0
	OUT				; Prints out the result	
	LEA R0, NewLine
	PUTS

HALT					; End of code
;-----	
;Data
;-----
prompt_mes	.STRINGZ	"Input a single character\n"
output_mes	.STRINGZ	"\nThe number of 1's is: "
NewLine		.STRINGZ	"\n"

;---------------------------------------------------------
; Subroutine: CountOnes
; Parameter: R0
; Postcondition: The subroutine will take input of character 
; 		 and count the number of binary 1's of the
;		 input character 
; Return value: R5 (Stores the number of 1's)
;---------------------------------------------------------
.ORIG x3200
	
SUB_CountOnes				; Branch SUB_CountOnes
	ST R7, BACKUP_R7_3200		; Backup R7
	ADD R2, R0, #0	      		; Copies the value of R0 into R2
	ADD R3, R3, #1			; Stores #1 for comparison purpose
	AND R4, R4, #0			; Used as loop counter
	AND R5, R5, #0			; Stores the result to be returned
	LD R6, POS48		     	 	; Load R6 with x003

BinaryLoop				; BRANCH BinaryLoop
	ADD R0, R2, R3
	BRzp isZero			; If MSB is 0, go to branch isZero

	isOne				; BRANCH isOne
	ADD R5, R5, #1			; Increment the 1's count by 1

	isZero				; BRANCH isZero
	ADD R2, R2, R2			; Shift bits left
	ADD R4, R4, #1			; Increment the loop counter
	ADD R1, R4, #-16		; Check if loop counter is still valid
	BRz BinaryLoopEnd		; Break out of the loop if count = 0
	BR BinaryLoop			; Otherwise, go back to the top of loop
	
BinaryLoopEnd				; BRANCH BinaryLoopEnd
 	ADD R5, R5, R6			; Make the result a real number for print
 	NOT R6, R6
 	ADD R6, R6, #1
 	ADD R6, R6, R5
	
END_CountOnes				; BRANCH END_CountOnes	
	LD R7, BACKUP_R7_3200		; Restore R7
	RET				; Return to address R7

;-----------------
; Subroutine Data
;-----------------
BACKUP_R7_3200	.BLKW #1
POS48		.FILL x0030
	
;---------------
;END of PROGRAM
;---------------
.END