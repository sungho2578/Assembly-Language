;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 6
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================
.ORIG x3000
;--------------
; Instructions
;--------------
AND R1, R1, #0		        ; Initialize R1
ADD R1, R1, #1			; Store #1 in R1 for comparison purpose
AND R2 ,R2, #0			; Stores the result
ADD R3, R3, #0			; R3 used for loop counter
LD R5, NEG48			; DEC -48

;-------------
; CODE BEGINS			
;-------------
LD R0, Printb			; Load R4 with ASCII b value
OUT
	
InputLoop			; BRANCH InputLoop
	GETC			; Prompt the user for input
	JSR SUB_TO_SINGLE_VALUE	; Jump to subroutine SUB_TO_SINGLE_VALUE

	ADD R3, R3, #1		; Increment the loop counter
	ADD R4, R3, #-16	; Check if the counter is 0
	BRz InputLoopEnd	; If counter becomes 0, out the loop	
	BR InputLoop		; Back to top of the loop
InputLoopEnd			; BRANCH InputLoopEnd

	AND R3, R3, #0		; Reset R3 for use in next loop
	
OutputLoop			; BRANCH OutputLoop
	JSR SUB_PRINT_16BINARY	; Jump to subroutine SUB_PRINT_16BINARY
	
	ADD R3, R3, #1		; Increment the loop counter
	ADD R4, R3, #-16	; Check if the counter is 0
	BRz OutputLoopEnd	; If counter becomes 0, out the loop
	BR OutputLoop		; Back to top of the loop
OutputLoopEnd			; BRANCH OutputLoopEnd

	
LEA R0, NEWLINE			; Load new line in R0
PUTS				; Prints new line

	
HALT
;------
; Data
;------
NEG48		.FILL xFFD0	; Decimal -48
Printb		.FILL x0062	; ASCII character b
NEWLINE		.STRINGZ "\n"	; New line

;---------------------------------------------------------
; Subroutine: TO_SINGLE_VALUE
; Parameter: R0, R2
; Postcondition: The subroutine will take input and 
; 		 transform it into a signle 16-bit value	
; Return value: None 
;---------------------------------------------------------
.ORIG x3200
	
SUB_TO_SINGLE_VALUE		; BRANCH SUB_TO_SINGLE_VALUE
	ST R7, BACKUP_R7_3200	; Backup R7

	ADD R0, R0, R5		; Input character to real value
	ADD R2, R2, R2		; Multiply the value in R2 by 2 (2^n)
	ADD R2, R2, R0		; Sum up into R2

END_SINGLE_VALUE		; BRANCH End_SINGLE_VALUE	
	LD R7, BACKUP_R7_3200	; Restore R7
	RET			; Return to address R7

;-----------------
; Subroutine Data
;-----------------
BACKUP_R7_3200	.BLKW	#1

	
;---------------------------------------------------------
; Subroutine: PRINT_16BINARY
; Parameter: R0, R2
; Postcondition: The subroutine will take MSB and compare
; 		 with 1 and print its bin value. 0 or 1	
; Return value: None 
;---------------------------------------------------------
.ORIG x3400
	
SUB_PRINT_16BINARY		; BRANCH SUB_PRINT_16BINARY
	ST R7, BACKUP_R7_3400	; Backup R7
	
	ADD R0, R2, R1		; Compare MSB with 1
	BRnz isOne		; If MSB is 1, go to branch isOne

isZero				; BRANCH isZero
	LD R0, PrintZero	; Load R0 with 0
	OUT			; Prints zero
	ADD R2, R2, R2		; Shift bits left
	BR END_PRINT_16BINARY	; Skip to SpaceLoop

isOne				; BRANCH isOne
	LD R0, PrintOne		; Load R0 with 1
	OUT			; Prints one
	ADD R2, R2, R2		; Shift bits left
	
END_PRINT_16BINARY		; BRANCH END_PRINT_16BINARY	
	LD R7, BACKUP_R7_3400	; Restore R7
	RET			; Return to address R7

;-----------------
; Subroutine Data
;-----------------
BACKUP_R7_3400	.BLKW	#1
PrintZero .FILL x0030		; ASCII character 0
PrintOne .FILL x0031		; ASCII character 1
	
;----------------
; END of Program
;----------------
.END