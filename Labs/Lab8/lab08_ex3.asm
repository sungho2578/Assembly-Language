;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
; 
; Lab: lab 8
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================
.ORIG x3000
;--------------
; Instructions
;--------------

;-------------------------------
; INSERT CODE STARTING FROM HERE
;-------------------------------
LEA R0,PROMPT
PUTS
    
LD R0,PTR_STRING
LD R1,PTR_GETSTR
JSRR R1

LD R0, PTR_STRING	
LD R1,PTR_UPPER
JSRR R1
PUTS
	
LD R0, PTR_STRING
LD R1, PTR_PALINDROME
JSRR R1
ADD R4, R4, #0
BRz NOT_PALIN
LEA R0, IS_PALINDROME
PUTS
BR END_PALIN

NOT_PALIN
LEA R0, NOT_PALINDROME
PUTS
END_PALIN
	
HALT
;------
; Data
;------ 
PTR_STRING .FILL x4000
PTR_UPPER .FILL x3400
PTR_GETSTR .FILL x3200
PTR_PALINDROME .FILL x3600
PROMPT .STRINGZ "Input a string for uppercase conversion:\n"
IS_PALINDROME .STRINGZ "\nThe string is a palindrome\n"
NOT_PALINDROME .STRINGZ "\nThe string is NOT a palindrome\n"
	
;------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
;                terminated by the [ENTER] key, and has stored it in an array
;                that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-------------------------------------------------------------------------------
.ORIG x3200
	
SUB_GET_STRING
	ST R0, R0_BACKUP_3200
	ST R1, R1_BACKUP_3200
	ST R2, R2_BACKUP_3200
	ST R7, R7_BACKUP_3200

	ADD R6, R6, R0
	AND R5, R5, #0

GETSTR_LOOP_3200
	LD R1, ENTERKEY_3200
	GETC
	OUT
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R0
	BRz ENTER_PRESSED_3200
	STR R0, R6, #0
	ADD R6, R6, #1
	ADD R5, R5, #1
	BR GETSTR_LOOP_3200
	
ENTER_PRESSED_3200
	AND R0, R0, #0
	STR R0, R6, #0

END_GET_STRING
	LD R0, R0_BACKUP_3200
	LD R1, R1_BACKUP_3200
	LD R2, R2_BACKUP_3200
	LD R7, R7_BACKUP_3200
	RET 

;----------------
; Subroutine Data
;----------------
R0_BACKUP_3200 .BLKW #1
R1_BACKUP_3200 .BLKW #1
R2_BACKUP_3200 .BLKW #1
R7_BACKUP_3200 .BLKW #1

ENTERKEY_3200 .FILL '\n'
PTR_REMOTE_STR_3200 .FILL #0

;------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
;		 a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------
.ORIG x3600

SUB_IS_A_PALINDROME
	ST R0, R0_BACKUP_3600
	ST R1, R1_BACKUP_3600
	ST R2, R2_BACKUP_3600
	ST R3, R3_BACKUP_3600
	ST R5, R5_BACKUP_3600
	ST R6, R6_BACKUP_3600
	ST R7, R7_BACKUP_3600

	ADD R6, R6, #-1
	ADD R1, R6, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	ADD R4, R4, #1
	
PALIN_LOOP
	ADD R5, R5, #-2
	BRn END_IS_A_PALINDROME
	
	LDR R2, R0, #0
	LDR R3, R1, #0
	NOT R3, R3
	ADD R3, R3, #1
	ADD R0, R0, #1
	ADD R1, R1, #-1
	ADD R6, R2, R3
	BRnp IS_NOT_PALIN	
	BR PALIN_LOOP		

IS_NOT_PALIN
	AND R4, R4, #0

END_IS_A_PALINDROME
	LD R0, R0_BACKUP_3600
	LD R1, R1_BACKUP_3600
	LD R2, R2_BACKUP_3600
	LD R3, R3_BACKUP_3600
	LD R5, R5_BACKUP_3600
	LD R6, R6_BACKUP_3600
	LD R7, R7_BACKUP_3600
	RET
	
;-----------------
; Subroutine Data
;-----------------
R0_BACKUP_3600 .BLKW #1
R1_BACKUP_3600 .BLKW #1
R2_BACKUP_3600 .BLKW #1
R3_BACKUP_3600 .BLKW #1
R5_BACKUP_3600 .BLKW #1
R6_BACKUP_3600 .BLKW #1
R7_BACKUP_3600 .BLKW #1	
	
;---------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R0): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case in-place
;		i.e. the upper-case string has replaced the original string
; No return value.
;---------------------------------------------------------------------------------
.ORIG x3400

SUB_TO_UPPER
	ST R0, R0_BACKUP_3400
	ST R1, R1_BACKUP_3400
	ST R2, R2_BACKUP_3400
	ST R7, R7_BACKUP_3400

WHILE_3400
	LDR R2, R0,#0
	LD R3, LOWLIMIT_3400
	ADD R3, R2, R3
	BRnz OUTOFRANGE_3400
	LD R3, HIGHLIMIT_3400
	ADD R3, R2, R3
	BRzp OUTOFRANGE_3400
	LD R1,CONVERT_MASK_3400
	AND R2, R2, R1
	STR R2, R0, #0
OUTOFRANGE_3400
	ADD R0, R0, #1
	ADD R2, R2, #0
	BRnp WHILE_3400
	
END_TO_UPPER
	LD R0, R0_BACKUP_3400
	LD R1, R1_BACKUP_3400
	LD R2, R2_BACKUP_3400
	LD R7, R7_BACKUP_3400
	RET

;----------------
; Subroutine Data
;----------------
R0_BACKUP_3400 .BLKW #1
R1_BACKUP_3400 .BLKW #1
R2_BACKUP_3400 .BLKW #1
R7_BACKUP_3400 .BLKW #1
CONVERT_MASK_3400 .FILL x5F  
LOWLIMIT_3400 .FILL -x60
HIGHLIMIT_3400 .FILL -x7B

.ORIG x4000
EXAMPLE_STR .STRINGZ "hi, how are you?"

.END