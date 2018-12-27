;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 5
; Lab section: B21
; TA: Jason Goulding
;=================================================
.ORIG x3000
;--------------
; Instructions
;--------------
LD R1, ARRAY_PTR		; Load address of Array into R1
ADD R0, R0, #0			; Put number 0 in R0
ADD R3, R3, #10			; R3 used for loop counter
ADD R4, R4, #7			; R4 used for secondary counter to grab 7th
	
;-------------
; CODE BEGINS			
;-------------
Loop				; BRANCH Loop/ Loop begins
	
ADD R3, R3, #-1			; Decrement the loop counter
BRz LoopEnd			; If counter becomes 0, out the loop

ADD R4, R4, #-1			; Check if current array is 7th slot
BRz GrabSeven			; If the secondary counter is 0, grab the value 
BR GrabSevenEnd			; Skip the steps if it is not yet 7th
	
GrabSeven			; BRANCH GrabSeven
ADD R2, R0, #0			; Grab the 7th array value into R2
GrabSevenEnd			; BRANCH GrabSevenEnd
	
STR R0, R1, #0			; Stores the number in R0 into the array
ADD R1, R1, #1			; Move to next data slot
ADD R0, R0, #1			; Increase the value in R0

BR Loop				; Backt to top of the loop
	
LoopEnd				; BRANCH LoopEnd

HALT
;------
; Data
;------
ARRAY_PTR .FILL x4000
	
;-------------
; Remote data
;-------------
.ORIG x4000
ARRAY .BLKW #10
	
;----------------
; END of Program
;----------------
.END