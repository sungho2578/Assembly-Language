;=================================================
; Name: Ahn, Sungho
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 4
; Lab section: B21
; TA: Jason Gulding
; 
;=================================================
.ORIG x3000
;-------------
; Instructions
;-------------
	
;------------
; CODE BEGINS
;------------
LD R5, DATA_PTR			; Direct load the value of pointer into R5

LDR R3, R5, #0			; Relative memory addressing mode. Base R5
ADD R5, R5, 1			; Move to the next data
LDR R4, R5, #0			; Relative memory addressing mode. Base R5
	
ADD R3, R3, 1			; Increment the value by 1
ADD R4, R4, 1			; Increment the value by 1

STR R3, R5, #0			; Store incremented value back into x4000 
STR R4, R6, #0			; Store incremented value back into x4001
	
HALT				; Stop execution of program
;------
; Data
;------
DATA_PTR	.FILL x4000

;------------
; Remote data
;------------
.ORIG x4000
NEW_DEC_65	.FILL #65
NEW_HEX_41	.FILL x41
	
;---------------
; END of PROGRAM
;---------------
.END