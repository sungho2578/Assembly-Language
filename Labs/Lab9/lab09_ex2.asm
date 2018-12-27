;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
;
; Lab: lab 9
; Lab section: B21
; TA: Jason Goulding
;=================================================
.ORIG x3000

LD R4, BASE
LD R5, TOS
LD R6, MAX

LD R1, PTR_STACK_PUSH
LD R0, TEST_VAL
JSRR R1
LD R0, TEST_VAL2
JSRR R1
LD R0, TEST_VAL3
JSRR R1

LD R1, PTR_STACK_POP
JSRR R1
OUT
JSRR R1
OUT
JSRR R1
OUT
;Extra call for underflow test
;JSRR R1

HALT

;------
; Data
;------
TEST_VAL .FILL 'a'
TEST_VAL2 .FILL 'b'
TEST_VAL3 .FILL 'c'
BASE .FILL x4000
TOS .FILL x4000
MAX .FILL #10
PTR_STACK_PUSH .FILL x3200
PTR_STACK_POP  .FILL x3400
	
.ORIG x4000
ARRAY .BLKW #10

;----------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH 
; Parameter (R0): The value to push onto the stack 
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;			address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack 
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack 
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
;		 If the stack was already full (TOS = MAX), the subroutine has printed an
;		 overflow error message and terminated.
; Return Value: R6 ← updated TOS  
;-----------------------------------------------------------------------------------------
.ORIG x3200
	
SUB_STACK_PUSH
	ST R7, R7_BACKUP_3200

	ADD R5, R5, #0
	BRz FULL_3200
	BR NOT_FULL_3200

FULL_3200
	LEA R0, MSG_OVERFLOW
	PUTS
	BR END_STACK_PUSH

NOT_FULL_3200
	STR R0, R6, #0
	ADD R6, R6, #1
	ADD R5, R5, #-1

END_STACK_PUSH
	LD R7, R7_BACKUP_3200
	RET

;----------------
; Subroutine Data
;----------------
R7_BACKUP_3200 .BLKW #1
MSG_OVERFLOW .STRINGZ "Overflow!\n"

;-----------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP 
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;			address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack. 
;                If the stack was already empty (TOS = BASE), the subroutine has printed
;                underflow error message and terminated. 
; Return Value: R0 ← value popped off of the stack 
;               R6 ← updated TOS
;-----------------------------------------------------------------------------------------
.ORIG x3400
	
SUB_STACK_POP
	ST R7,R7_BACKUP_3400

	NOT R0, R6
	ADD R0, R0, #1
	ADD R0, R4, R0
	BRz EMPTY_3400
	BR NOT_EMPTY_3400

EMPTY_3400
	LEA R0, MSG_UNDERFLOW
	PUTS
	BR END_STACK_POP
    
NOT_EMPTY_3400
	ADD R6, R6, #-1
	LDR R0, R6, #0
	ADD R5, R5, #1

END_STACK_POP
	LD R7, R7_BACKUP_3400
	RET

;----------------
; Subroutine Data
;----------------
R7_BACKUP_3400 .BLKW #1
MSG_UNDERFLOW .STRINGZ "Underflow!\n"

;----------------
; End of PROGRAM
; ---------------
.END