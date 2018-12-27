;=================================================
; Name: Ahn, Sungho
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 4
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================
.ORIG x3000
;-------------
; Instructions
;-------------
LEA R1, ARRAY1			; Load address of Array1 into R1
ADD R2, R2, #10			; R2 reserved for Loop Counter

;------------
; CODE BEGINS
;------------
Loop				; BRANCH Loop
	
GETC				; Prompts user for character
STR R0, R1, #0			; Stores the character into array
ADD R1, R1, #1			; Move to next data slot

ADD R2, R2, #-1			; Decrement loop counter by 1
BRp Loop			; If counter > 0, back to the loop
	
LoopEnd				; BRANCH LoopEnd

	
AND R0, R0, #0			; Clear R0 for next use
AND R2, R2, #0			; Clear R2 for next use
ADD R2, R2, #10			; Refill R2 with the counts
LEA R3, ARRAY1			; Copy array's contents into R3

	
PrintLoop			; BRANCH PrintLoop

LDR R0, R3, #0			; Load character in current data slot
OUT				; Prints the character
ADD R3, R3, #1			; Move to next data slot
LEA R0, NEWLINE			; Stores new line 
PUTS				; Prints new line
	
ADD R2, R2, #-1			; Decrement loop counter by 1
BRp PrintLoop			; If counter > 0, back to the loop
	
PrintLoopEnd			; BRANCH PrintLoopEnd
	
HALT
;------
; Data
;------
ARRAY1	.BLKW #10		; Array. Reserves 10 locations
NEWLINE	.STRINGZ "\n"		; New line
	
;---------------
; END of Program
;---------------
.END