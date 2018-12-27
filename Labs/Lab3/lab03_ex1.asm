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
;--------------
; Instructions
;--------------
	
;-------------
; CODE BEGINS
;-------------
LD R3, DEC_65			; Load the pre-set value in DEC_65 memory loc. into R3
LD R4, HEX_41			; Load the pre-set value in HEX_41 memory loc. into R4
	
HALT				; Stop execution of program
;------
; Data
;------
DEC_65 .fill #65
HEX_41 .fill x41

;----------------
; END of PROGRAM
;----------------
.END