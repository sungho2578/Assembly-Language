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
PUTS

HALT
;------
; Data
;------ 
PTR_STRING .FILL x4000
PTR_GETSTR .FILL x3200
PROMPT .STRINGZ "Input a string:\n"

;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
;                terminated by the [ENTER] key, and has stored it in an array
;                that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200
	
SUB_GET_STRING
	ST R0,R0_BACKUP_3200
	ST R1,R1_BACKUP_3200
	ST R2,R2_BACKUP_3200
	ST R7,R7_BACKUP_3200

	ADD R6,R6,R0
	AND R5,R5,#0

GETSTR_LOOP_3200
	LD R1, ENTERKEY_3200
	GETC
	OUT
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R0
	BRz ENTER_PRESSED_3200
	STR R0,R6,#0
	ADD R6,R6,#1
	ADD R5,R5,#1
	BR GETSTR_LOOP_3200
	
ENTER_PRESSED_3200
	AND R0,R0,#0
	STR R0,R6,#0

END_GET_STRING
	LD R0,R0_BACKUP_3200
	LD R1,R1_BACKUP_3200
	LD R2,R2_BACKUP_3200
	LD R7,R7_BACKUP_3200
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

.ORIG x4000
EXAMPLE_STR .STRINGZ "hi, how are you?"

.END