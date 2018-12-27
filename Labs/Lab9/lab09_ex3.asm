;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578
;
; Lab: lab 9
; Lab section: B21
; TA: Jason Goulding
;=================================================
;--------------
; Instructions
;--------------
	
;-------------------------------
; INSERT CODE STARTING FROM HERE
;-------------------------------
.ORIG x3000

LD R4, BASE
LD R5, TOS
LD R6, MAX

LEA R0, MSG_PROMPT
PUTS
	
LD R3, ASCII_OFFSET_MAIN
GETC
OUT	
ADD R0, R0, R3
LD R1, PTR_STACK_PUSH
JSRR R1

GETC
OUT

GETC
OUT
ADD R0, R0, R3
LD R1, PTR_STACK_PUSH
JSRR R1

GETC
OUT

GETC
OUT
LD R1, PTR_STACK_PUSH
JSRR R1


LD R0,ENTER_MAIN
OUT

LD R1, PTR_MULT
JSRR R1

LD R1, PTR_STACK_POP
JSRR R1
ADD R6, R0, #0

LD R1, PTR_PRINT
JSRR R1
	
HALT
;------
; Data
;------
TEST_VAL .FILL #3
TEST_VAL2 .FILL #4
TEST_VAL3 .FILL '*'
BASE .FILL x4000
TOS .FILL x4000
MAX .FILL #10
PTR_STACK_PUSH .FILL x3200
PTR_STACK_POP .FILL x3400
PTR_MULT .FILL x3600
PTR_PRINT .FILL x4800

ENTER_MAIN .FILL '\n'
ASCII_OFFSET_MAIN .FILL -x30
MSG_PROMPT .STRINGZ "Insert two single-digit numbers with operation symbol '*', following the format: (2 3 *)\n"
	
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

;----------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY 
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;			address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack 
; Postcondition: The subroutine has popped off the top two values of the stack, 
;                multiplied them together, and pushed the resulting value back 
;                onto the stack. 
; Return Value: R6 ← updated top value
;----------------------------------------------------------------------------------
.ORIG x3600
	
SUB_RPN_MULTIPLY
	ST R0, R0_BACKUP_3600
	ST R4, R4_BACKUP_3600
	ST R7, R7_BACKUP_3600

	LD R1, PTR_POP_3600
	JSRR R1
	JSRR R1
	ADD R2, R0, #0
	JSRR R1
	ADD R3, R0, #0

	LD R1, PTR_MULT_3600
	JSRR R1

	ADD R0, R6, #0
	LD R1, PTR_PUSH_3600
	JSRR R1

END_RPN_MULTIPLY
	LD R0, R0_BACKUP_3600
	LD R4, R4_BACKUP_3600
	LD R7, R7_BACKUP_3600
	RET

;-----------------
; Subroutine Data
;-----------------
R0_BACKUP_3600 .BLKW #1
R4_BACKUP_3600 .BLKW #1
R7_BACKUP_3600 .BLKW #1
PTR_PUSH_3600 .FILL x3200
PTR_POP_3600 .FILL x3400
PTR_MULT_3600 .FILL x4400
PTR_PRINT_3600 .FILL x4800
	
;-----------------------------------------
; Subroutine: SUB_MULTIPLY
; Parameter (R1): Input 1
; Parameter (R2): Input 2 
; Postcondition: Multiply R1 and R2
; Return value: R6
;-----------------------------------------
.ORIG x4400
	
SUB_MULTIPLY
	ST R0, R0_BACKUP_4400
	ST R2, R2_BACKUP_4400
	ST R3, R3_BACKUP_4400
	ST R4, R4_BACKUP_4400
	ST R5, R5_BACKUP_4400
	ST R7, R7_BACKUP_4400

	ADD R1, R2, #0
	ADD R2, R3, #0
	AND R3, R3, #0
	AND R6, R6, #0
	LD R5, FRONT_BIT_4400

	ADD R2, R2, #0
	BRz END_WHILE_4400
	BR WHILE_4400

WHILE_4400
	ADD R6, R6, R1
	ADD R2, R2, #-1
	AND R4, R6, R5
	BRnp OVERFLOW_4400
	ADD R2, R2, #0
	BRp WHILE_4400
	
END_WHILE_4400
	ADD R3, R3, #0
	BRz NORMALCASE_4400
	BR NEGCASE_4400

NEGCASE_4400
	NOT R6, R6
	ADD R6, R6, #1
	
NORMALCASE_4400
	BR END_MULTIPLY

OVERFLOW_4400
	LEA R0, OVERFLOW_NOTICE
	PUTS

END_MULTIPLY
	ADD R1, R4, #0
	LD R0, R0_BACKUP_4400
	LD R2, R2_BACKUP_4400
	LD R3, R3_BACKUP_4400
	LD R4, R4_BACKUP_4400
	LD R5, R5_BACKUP_4400
	LD R7, R7_BACKUP_4400
	RET

;-----------------
; Subroutine Data
;-----------------
R0_BACKUP_4400 .BLKW #1
R2_BACKUP_4400 .BLKW #1
R3_BACKUP_4400 .BLKW #1
R4_BACKUP_4400 .BLKW #1
R5_BACKUP_4400 .BLKW #1
R7_BACKUP_4400 .BLKW #1
FRONT_BIT_4400 .FILL x8000
OVERFLOW_NOTICE .STRINGZ " = Overflow!\n"

;-------------------------------------------
; Subroutine: SUB_PRINT_DECIMAL
; Parameter (R6): Number to be printed out
; Return value: None
;-------------------------------------------	
.ORIG x4800
SUB_PRINT_DECIMAL
	ST R0, R0_BACKUP_4800
	ST R1, R1_BACKUP_4800
	ST R6, R6_BACKUP_4800
	ST R2, R2_BACKUP_4800
	ST R3, R3_BACKUP_4800
	ST R4, R4_BACKUP_4800
	ST R7, R7_BACKUP_4800

	ADD R6, R6, #0
	BRz ZERO_CASE_4800
	BRn NEG_CASE_4800
	BR NORM_CASE_4800

ZERO_CASE_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R6, R4
	OUT
	BR SKIP_4800_5
	
NEG_CASE_4800
	LD R0,MINUSCHAR_4800
	OUT
	NOT R6, R6
	ADD R6, R6, #1
	
NORM_CASE_4800
	LD R0, DEC_10000_4800
	AND R3, R3, #0

	AND R1, R1, #0

DECR_10000_4800
	ADD R2, R6, #0
	ADD R2, R2, R0
	BRn DONE_10000_4800
	ADD R3, R3, #1
	ADD R6, R2, #0
	BR DECR_10000_4800
	
DONE_10000_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R3, R4
	LD R5, ASCII_TONUM_4800
	ADD R5, R5, R0
	ADD R5, R5, R1
	BRz SKIP_4800_1
	ADD R1, R1, #1
	OUT
	
SKIP_4800_1
	LD R0,DEC_1000_4800
	AND R3, R3, #0
	
DECR_1000_4800
	ADD R2, R6, #0
	ADD R2, R2, R0
	BRn DONE_1000_4800
	ADD R3, R3, #1
	ADD R6, R2, #0
	BR DECR_1000_4800
	
DONE_1000_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R3, R4
	LD R5,ASCII_TONUM_4800
	ADD R5, R5, R0
	ADD R5, R5, R1
	BRz SKIP_4800_2
	ADD R1, R1, #1
	OUT

SKIP_4800_2
	LD R0, DEC_100_4800
	AND R3, R3, #0
	
DECR_100_4800
	ADD R2, R6, #0
	ADD R2, R2, R0
	BRn DONE_100_4800
	ADD R3, R3, #1
	ADD R6, R2, #0
	BR DECR_100_4800
	
DONE_100_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R3, R4
	LD R5, ASCII_TONUM_4800
	ADD R5, R5, R0
	ADD R5, R5, R1
	BRz SKIP_4800_3
	ADD R1, R1, #1
	OUT

SKIP_4800_3
	LD R0, DEC_10_4800
	AND R3, R3, #0
	
DECR_10_4800
	ADD R2, R6, #0
	ADD R2, R2, R0
	BRn DONE_10_4800
	ADD R3, R3, #1
	ADD R6, R2, #0
	BR DECR_10_4800
	
DONE_10_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R3, R4
	LD R5, ASCII_TONUM_4800
	ADD R5, R5, R0
	ADD R5, R5, R1
	BRz SKIP_4800_4
	ADD R1, R1, #1
	OUT

SKIP_4800_4
	LD R0, DEC_1_4800
	AND R3, R3, #0
	
DECR_1_4800
	ADD R2, R6, #0
	ADD R2, R2, R0
	BRn DONE_1_4800
	ADD R3, R3, #1
	ADD R6, R2, #0
	BR DECR_1_4800
	
DONE_1_4800
	LD R4, ASCII_TOCHAR_4800
	ADD R0, R3, R4
	LD R5, ASCII_TONUM_4800
	ADD R5, R5, R0
	ADD R5, R5, R1
	BRz SKIP_4800_5
	ADD R1, R1, #1
	OUT
	
SKIP_4800_5

END_PRINT_DECIMAL
	LD R0, R0_BACKUP_4800
	LD R1, R1_BACKUP_4800
	LD R6, R6_BACKUP_4800
	LD R2, R2_BACKUP_4800
	LD R3, R3_BACKUP_4800
	LD R4, R4_BACKUP_4800
	LD R7, R7_BACKUP_4800
	RET

;-----------------
; Subroutine Data
;-----------------
R0_BACKUP_4800 .BLKW #1
R1_BACKUP_4800 .BLKW #1
R6_BACKUP_4800 .BLKW #1
R2_BACKUP_4800 .BLKW #1
R3_BACKUP_4800 .BLKW #1
R4_BACKUP_4800 .BLKW #1
R7_BACKUP_4800 .BLKW #1

ASCII_TOCHAR_4800 .FILL x30
ASCII_TONUM_4800 .FILL -x30
MINUSCHAR_4800 .FILL '-'
DEC_10000_4800 .FILL #-10000
DEC_1000_4800 .FILL #-1000
DEC_100_4800 .FILL #-100
DEC_10_4800 .FILL #-10
DEC_1_4800 .FILL #-1

;----------------
; End of PROGRAM
;----------------
.END