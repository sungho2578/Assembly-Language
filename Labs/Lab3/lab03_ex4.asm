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
LD R0, val_x61			; Load x61(97) into R0
LD R1, val_x1A			; Load x1A(26) into R1

Alpha_loop			; Loop begins
ADD R0, R0, 0			; Print the value of R0
OUT				; Print out
ADD R0, R0, 1			; Increment value of R0 by 1
ADD R1, R1, -1			; Decrement value of R1 by 1 (Loop Counter)
BRp Alpha_loop			; If Loop counter > 0, back to the Loop
	
HALT				; Stop execution of program
;------
; Data
;------
val_x61 .FILL x61
val_x1A .FILL x1A
	
;----------------
; END of PROGRAM
;----------------
.END