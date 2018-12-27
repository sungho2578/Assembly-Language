;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Assignment name: Assignment 2
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;outputs prompt
;----------------------------------------------
LD R5, POS48		        ; ASCII Hex value x30
LD R6, NEG48			; ASCII Hex value xFFD0
LEA R0, intro			; get starting address of prompt string
PUTS				; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE BELOW
;-------------------------------
LEA R0, NEWLINE			; Prints newline after the intro message
PUTS				; Print

GETC				; Get the first number as a character
OUT				; Print the number
ADD R1, R0, 0			; Save it in R1
LEA R0, NEWLINE			; Newline
PUTS				; Prints the new line
	
GETC				; Get the second number as a character
OUT				; Print the number
ADD R2, R0, 0			; Save it in R2
LEA R0, NEWLINE			; Newline
PUTS				; Prints the new line
	
ADD R0, R1, 0			; Move(Copy) the first number into R0
OUT				; Print the number
LEA R0, subSIGN			; Print the '-' symbol
PUTS				; Print
ADD R0, R2, 0			; Move(Copy) the second number into R0
OUT				; Print the number
LEA R0, eqlSIGN			; Print the '=' symbol
PUTS				; Print
	
ADD R1, R1, R6			; Convert first number to real value
ADD R2, R2, R6			; Convert second number to real value
ADD R3, R2, 0			; Back up R2 value into R3 temporarily
NOT R2, R2			; Negation of second value for subtraction
ADD R2, R2, 1			; Add 1 to make it 2's complement

ADD R4, R1, R2			; Compare two input numbers
BRp PosResult			; If the subtraction result is greater than zero, go to PosResult branch
BRn NegResult			; If the subtraction result is less than zero, go to NegResult branch

PosResult	     		; Positive Case
ADD R0, R1, R2			; Save the sum of first and second numbers into R0
ADD R0, R0, R5			; Add x30 to the result
OUT				; Print the final result
BR SkipEnd			; Skip to the program termination
	
NegResult			; Negative Case
ADD R2, R3, 0			; Restore original R2 value
NOT R1, R1			; This time, negate the first value since its smaller
ADD R1, R1, 1			; Add 1 to make it 2's complement
LEA R0, negSIGN			; Print the '-' symbol
PUTS				; Print
ADD R0, R2, R1			; Do the subtraction process
ADD R0, R0, R5			; Add x30 to the result
OUT				; Print the final result
BR SkipEnd			; Skip to the program termination

SkipEnd				; Branch to program execution
LEA R0, NEWLINE			; Prints the newline
PUTS				; Prints
	
HALT				; Stop execution of program
;------	
;Data
;------
; String to explain what to input 
intro .STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" ; prompt string - use with PUTS. Note: already includes terminating newline!
NEWLINE .STRINGZ  "\n"	; newline character - use with OUT
subSIGN .STRINGZ " - "
eqlSIGN .STRINGZ " = "
negSIGN .STRINGZ "-"
POS48 .fill x30
NEG48 .fill xFFD0
;---------------	
;END of PROGRAM
;---------------	
.END
