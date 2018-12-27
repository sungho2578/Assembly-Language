;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 6
; Lab section: B21
; TA: Jason Goulding
;=================================================
.ORIG x3000
;--------------
; Instructions
;--------------
LD R1, ARRAY_PTR		; Load address of Array into R1
ADD R0, R0, #1			; Put number 1 in R0
ADD R3, R3, #10			; R3 used for loop counter
	
;-------------
; CODE BEGINS			
;-------------
InputLoop			; BRANCH InputLoop/ Loop begins
	
STR R0, R1, #0			; Stores the number in R0 into the array
ADD R0, R0, R0			; Multiply the value in R0 by 2 (2^n)
ADD R1, R1, #1			; Move to next data slot
	
ADD R3, R3, #-1			; Decrement the loop counter
BRz InputLoopEnd		; If counter becomes 0, out the loop	
BR InputLoop			; Back to top of the loop
	
InputLoopEnd			; BRANCH InputLoopEnd
	
;---------------------------------------------------------------------------
AND R1, R1, #0			; Clear R1 for next use
ADD R1, R1, #1			; R1 holds number 1 for comparison purpose
ADD R3, R3, #10			; Loop counter for array loop
LD R6, ARRAY_PTR		; Load the address of the array into R6
	
ArrayLoop			; BRANCH ArrayLoop / Loop begins
LDR R2, R6, #0			; Load direct the value of the array into R2
AND R4, R4, #0			; Loop counter for Hex loop
AND R0, R0, #0			; Clear R0 for next use
LD R0, Printb			; Load R0 with b
OUT				; Print character b
	
HexLoop			  	; BRANCH HexLoop
ADD R4, R4, #1			; Increment hex-loop counter by 1 every loop
AND R0, R0, #0			; Clear R0 for next use
JSR SUB_PRINT_16BINARY		; Jump to subroutine SUB_PRINT_16BINARY
	
SpaceLoop			; BRANCH SpaceLoop
AND R5, R5, #0			; Clear R5 for next use
ADD R5, R4, #-4			; Check to see if the loop is 4th count
BRz isSpace			; Go to isSpace to print space out if sum = 0
ADD R5, R4, #-8			; Check to see if the loop is 8th count
BRz isSpace			; Go to isSpace to print space out if sum = 0
ADD R5, R4, #-12		; Check to see if the loop is 12th count
BRz isSpace			; Go to isSpace to print space out if sum = 0
BR HexLoopCheck			; Skip to BRANCH LoopCheck

isSpace				; BRANCH isSpace
AND R0, R0, #0			; Clear R0 for next use
LD R0, PrintSpace		; Load space character in R0
OUT				; Prints space

HexLoopCheck			; BRANCH LoopCheck
AND R0, R0, #0			; Clear R0 for next use
ADD R0, R4, #-16		; Loop continues until counter becomes zero
BRz HexLoopEnd
BR HexLoop

HexLoopEnd			; BRANCH HexLoopEnd
AND R0, R0, #0			; Clear R0 for next use
LEA R0, NEWLINE			; Load new line in R0
PUTS				; Prints new line
	
ADD R6, R6, #1			; Move to the next data in the array
ADD R3, R3, #-1			; Decrement the array-Loop counter
BRz ArrayLoopEnd		; Out the array-loop if zero
BR ArrayLoop			; Back to the top of the array-loop if positive

ArrayLoopEnd			; BRANCH ArrayLoopEnd

	
HALT
;------
; Data
;------
ARRAY_PTR .FILL x4000		; Address of the array
Printb .FILL x0062		; ASCII character b
PrintSpace .FILL x0020		; Space
NEWLINE .STRINGZ "\n"		; New line
	
;-------------
; Remote data
;-------------
.ORIG x4000
ARRAY .BLKW #10			; Array with 10 values


;---------------------------------------------------------
; Subroutine: PRINT_16BINARY
; Parameter: R0, R2
; Postcondition: The subroutine will take MSB and compare
; 		 with 1 and print its bin value. 0 or 1	
; Return value: None 
;---------------------------------------------------------
.ORIG x3200
	
SUB_PRINT_16BINARY		; BRANCH SUB_PRINT_16BINARY
ST R7, BACKUP_R7_3200		; Backup R7

	
ADD R0, R2, R1			; Compare MSB with 1
BRnz isOne			; If MSB is 1, go to branch isOne

isZero				; BRANCH isZero
AND R0, R0, #0			; Clear R0 for next use
LD R0, PrintZero		; Load R0 with 0
OUT				; Prints zero
ADD R2, R2, R2			; Shift bits left
BR EndSubroutine		; Skip to SpaceLoop

isOne				; BRANCH isOne
AND R0, R0, #0			; Clear R0 for next use
LD R0, PrintOne			; Load R0 with 1
OUT				; Prints one
ADD R2, R2, R2			; Shift bits left

EndSubroutine			; BRANCH EndSubroutine

	
LD R7, BACKUP_R7_3200		; Restore R7
RET				; Return to address R7

;-----------------
; Subroutine Data
;-----------------
BACKUP_R7_3200	.BLKW	#1
PrintZero .FILL x0030		; ASCII character 0
PrintOne .FILL x0031		; ASCII character 1
;----------------
; END of Program
;----------------
.END