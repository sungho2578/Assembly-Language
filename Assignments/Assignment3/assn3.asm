;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000            ; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr      ; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0         ; R1 <-- value to be displayed as binary
;-------------------------------
;INSERT CODE STARTING FROM HERE
;-------------------------------   
ADD R2, R2, #1         ; R2 holds number 1 for comparison purpose
ADD R3, R3, #0         ; R3 is OuterLoop counter
   
OuterLoop	       ; OuterLoop Begins
ADD R3, R3, #1         ; Increment loop counter by 1 every loop
AND R0, R0, #0         ; Clear R0 for next use
ADD R0, R1, #0         ; Compare MSB with 1
BRn isOne              ; If MSB is 1, go to branch isOne
   
isZero       	       ; BRANCH isZero
AND R0, R0, #0         ; Clear R0 for next use
LD R0, PrintZero       ; Load R0 with 0
OUT           	       ; Prints zero
ADD R1, R1, R1         ; Shift bits left
BR InnerLoop           ; Skip to InnerLoop
   
isOne 	               ; BRANCH isOne
AND R0, R0, #0         ; Clear R0 for next use
LD R0, PrintOne        ; Load R0 with 1
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
;---------------   
;Data
;---------------
Value_addr  .FILL xD100      ; The address of where to find the data
PrintZero   .FILL x0030      ; ASCII value 0
PrintOne    .FILL x0031      ; ASCII value 1
PrintSpace  .FILL x0020      ; Space
NEWLINE     .STRINGZ "\n"    ; New line

.ORIG xD100            ; Remote data
Value .FILL x4000      ; <----!!!NUMBER TO BE CONVERTED TO BINARY!!! Note: label is redundant.
;---------------   
;END of PROGRAM
;---------------   
.END