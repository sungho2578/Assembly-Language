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
LD R1, ARRAY			; Load address of Array into R1

;------------
; CODE BEGINS
;------------
Loop				; BRANCH Loop
	
GETC				; Prompts user for character
ADD R3, R0, #-10
BRz InsertNULL
	
STR R0, R1, #0			; Stores the character into array
ADD R1, R1, #1			; Move to next data slot	
BR Loop		

InsertNULL
AND R0, R0, #0
STR R0, R1, #0
LoopEnd				; BRANCH LoopEnd
	

AND R0, R0, #0			; Clear R0 for next use
LD R2, ARRAY			; Copy array's contents into R2

	
PrintLoop			; BRANCH PrintLoop

LDR R0, R2, #0			; Load character in current data slot
BRz PrintLoopEnd
	
OUT				; Prints the character	
ADD R2, R2, #1			; Move to next data slot
LEA R0, NEWLINE			; Stores new line 
PUTS				; Prints new line
BR PrintLoop			; Back to top of the loop
	
PrintLoopEnd			; BRANCH PrintLoopEnd
	
HALT
;------
; Data
;------
ARRAY	.FILL x4000		; Array. Starting at x4000
NEWLINE	.STRINGZ "\n"		; New line
	
;---------------
; END of Program
;---------------
.END