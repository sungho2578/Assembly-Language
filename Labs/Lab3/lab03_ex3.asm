;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 3
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================
.ORIG x3000
;-------------
; Instructions
;--------------

;-------------
; CODE BEGINS
;-------------
LDI R3, DEC_65_PTR		; Load indirect DEC_65_PTR into R3
LDI R4, HEX_41_PTR		; Load indirect HEX_41_PTR into R4

ADD R3, R3, 1			; Increment the value by 1
ADD R4, R4, 1			; Increment the value by 1
	
STI R3, DEC_65_PTR		; Store incremented value back into address x4000
STI R4, HEX_41_PTR		; Store incremented value back into address x4001
	
HALT				; Stop execution of program
;------
; Data
;------
DEC_65_PTR .FILL x4000
HEX_41_PTR .FILL x4001

;-------------
; Remote data
;-------------
.ORIG x4000
NEW_DEC_65 .FILL #65
NEW_HEX_41 .FILL x41

;----------------
; END of program
;----------------
.END