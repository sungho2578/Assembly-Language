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
AND R3, R3, #0			; R3 used for loop counter
LD R5, NEG48			; Stores #-48
	
;-------------
; CODE BEGINS			
;-------------
CheckInitialInput		; BRANCH CheckInitialInput
	LD R4, Printb		; Load R4 with ASCII b value
	NOT R4, R4		; Negate the value
	ADD R4, R4, #1		; Add 1 to make it 2's comp.
	
	GETC			; Prompt the user for initial input
	ADD R4, R4, R0		; Check if it is 'b' character
	BRnp InitialErrorMSG	; Go to print Error message if not
	LD R0, Printb		; Load character b into R0
	OUT			; Prints out 'b'
	AND R4, R4, #0		; Reset R4 for next use
	
	BR InputLoop		; Jump to main loop

InitialErrorMSG			; BRANCH InitialErrorMSG
	LEA R0, InitialError	; Load R0 with error message
	PUTS			; Prints out the message
	BR CheckInitialInput	; Restart from the beginning

ValidErrorMSG			; BRANCH ValidErrorMSG
	LEA R0, ValidError	; Load R0 with error message
	PUTS			; Prints out the message
	
InputLoop			; BRANCH InputLoop
	LD R4, PrintSpace	; Load R4 with ASCII space character
	NOT R4, R4		; Negate the value
	ADD R4, R4, #1		; Add 1 to make it 2's comp.
	
	GETC			; Prompt the user for input
	ADD R6, R4, R0		; Check if inupt is space
	BRnp CheckZero		; Jump branch if not

EchoSpace			; BRANCH EchoSpace
	OUT			; Prints space
	BR InputLoop		; Back to the loop

CheckZero			; BRANCH CheckZero
	ADD R6, R0, R5		; Sub #48 to make it real number
	ADD R6, R6, #0		; Check if the input is 0
	BRz ValidInput		; Skip the branch if true

CheckOne			; BRANCH CheckOne
	ADD R6, R0, R5		; Sub #48 to make it real number
	ADD R6, R6, #-1		; Check if the input is 1
	BRz ValidInput		; Skip the branch if true
	BR ValidErrorMSG	; Go print error message otherwise

ValidInput	
	JSR SUB_TO_SINGLE_VALUE	; Jump to subroutine SUB_TO_SINGLE_VALUE
	JSR SUB_PRINT_16BINARY	; Jump to subroutine SUB_PRINT_16BINARY
	
	ADD R3, R3, #1		; Increment the loop counter
	ADD R4, R3, #-16	; Check if the counter is 0
	BRz InputLoopEnd	; If counter becomes 0, out the loop	
	BR InputLoop		; Back to top of the loop
InputLoopEnd			; BRANCH InputLoopEnd
	
	LEA R0, NEWLINE		; Load new line in R0
	PUTS			; Prints new line
	
FinalOutput
ADD R1, R2, #0
ADD R5, R2, #0
AND R2, R2, #0
ADD R2, R2, #1         ; R2 holds number 1 for comparison purpose
AND R3, R3, #0         ; R3 is OuterLoop counter
LD R0, Printb
OUT

OuterLoop	       ; OuterLoop Begins
ADD R3, R3, #1         ; Increment loop counter by 1 every loop
AND R0, R0, #0         ; Clear R0 for next use
ADD R0, R1, #0         ; Compare MSB with 1
BRn isOne2              ; If MSB is 1, go to branch isOne
   
isZero2       	       ; BRANCH isZero
AND R0, R0, #0         ; Clear R0 for next use
LD R0, PrintZero_0       ; Load R0 with 0
OUT           	       ; Prints zero
ADD R1, R1, R1         ; Shift bits left
BR InnerLoop           ; Skip to InnerLoop
   
isOne2 	               ; BRANCH isOne
AND R0, R0, #0         ; Clear R0 for next use
LD R0, PrintOne_0        ; Load R0 with 1
OUT         	       ; Prints one
ADD R1, R1, R1         ; Shift bits left
   
InnerLoop              ; BRANCH InnerLoop
AND R4, R4, #0         ; Clear R4 for next use
ADD R4, R3, #-4        ; Check to see if the loop is 4th count
BRz isSpace            ; Go to BRANCH isSpace if the sum is 0
ADD R4, R3, #-8        ; Check to see if the loop is 8th cotunt
BRz isSpace            ; Go to BRANCH isSpace if the sum is 0
ADD R4, R3, #-12       ; Check to see if the loop is 12th count
BRz isSpace            ; Go to BRANCH isSpace if the sum is 0
BR LoopCheck           ; Skip to BRANCH LoopCheck
   
isSpace                ; BRANCH isSpace
AND R0, R0, #0         ; Clear R0 for next use
LD R0, PrintSpace      ; Load space character in R0
OUT            	       ; Prints space

LoopCheck              ; BRANCH LoopCheck 
AND R0, R0, #0         ; Clear R0 for next use
ADD R0, R3, #-16       ; Loop continues until counter becomes zero
BRz LoopEnd            ; Out the loop, if zero.
BR OuterLoop           ; Back to the top of the loop
   
LoopEnd                ; BRANCH LoopEnd
AND R0, R0, #0         ; Clear R0 for next use
LEA R0, NEWLINE        ; Load new line in R0
PUTS                   ; Prints new line
	
	
HALT
;------
; Data
;------
NEG48		.FILL xFFD0	; Decimal -48
Printb		.FILL x0062	; ASCII character b
PrintSpace	.FILL x0020	; Space
InitialError	.STRINGZ "Initial input must be a character 'b'\n"
ValidError	.STRINGZ "\nPlease enter a valid character\n"
NEWLINE		.STRINGZ "\n"	; New line
PrintZero_0 	.FILL x0030	; ASCII character 0
PrintOne_0 	.FILL x0031	; ASCII character 1

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
	
	AND R0, R2, R1		; Compare MSB with 0
	BRnp isOne		; If MSB is 1, go to branch isOne

isZero				; BRANCH isZero
	LD R0, PrintZero	; Load R0 with 0
	OUT			; Prints zero
	BR END_PRINT_16BINARY	; Skip to SpaceLoop

isOne				; BRANCH isOne
	LD R0, PrintOne		; Load R0 with 1
	OUT			; Prints one
	
END_PRINT_16BINARY		; BRANCH END_PRINT_16BINARY
	LD R7, BACKUP_R7_3400	; Restore R7
	RET			; Retrun to address R7

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