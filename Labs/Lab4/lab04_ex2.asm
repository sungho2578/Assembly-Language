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
ADD R2, R2, #9			; R2 reserved for Loop Counter

;------------
; CODE BEGINS
;------------
Loop				; BRANCH Loop
GETC				; Prompts user for character
STR R0, R1, #0			; Stores the character into array
ADD R1, R1, #1			; Move to next data slot

ADD R2, R2, #-1			; Decrement loop counter by 1
BRn LoopEnd			; If counter = 0, break out the loop
BR Loop				; If counter > 0, back to the loop
	
LoopEnd				; BRANCH LoopEnd

HALT
;------
; Data
;------
ARRAY1	.BLKW #10		; Array. Reserves 10 locations
	
;---------------
; END of Program
;---------------
.END