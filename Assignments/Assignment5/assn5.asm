;=================================================
; Name: Sungho Ahn
; Email: sahn025@ucr.edu
; GitHub username: ptr2578 
;
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
MAIN
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0

	LD R6, MENU
	JSRR R6

	ADD R5, R1, #-1
	BRz Choice1
	ADD R5, R1, #-2
	BRz Choice2
	ADD R5, R1, #-3
	BRz Choice3
	ADD R5, R1, #-4
	BRz Choice4
	ADD R5, R1, #-5
	BRz Choice5
	ADD R5, R1, #-6
	BRz Choice6
	ADD R5, R1, #-7
	BRz Choice7

Choice1
	LD R6, ALL_MACHINES_BUSY
	JSRR R6
	
	ADD R2, R2, #0
	BRp Print_ALL_BUSY
	LEA R0, ALLNOTBUSY
	PUTS
	BR MAIN

	Print_ALL_BUSY
	LEA R0, ALLBUSY
	PUTS
	BR MAIN
	
Choice2
	LD R6, ALL_MACHINES_FREE
	JSRR R6
	
	ADD R2, R2, #0
	BRp Print_ALL_FREE
	LEA R0, NOTFREE
	PUTS
	BR MAIN

	Print_ALL_FREE
	LEA R0, FREE
	PUTS
	BR MAIN
	
Choice3
	LD R6, NUM_BUSY_MACHINES
	JSRR R6
	
	LEA R0, BUSYMACHINE1
	PUTS
	
	ADD R1, R2, #0
	LD R6, PRINT_NUMBER
	JSRR R6
	
	LEA R0, BUSYMACHINE2
	PUTS
	BR MAIN
	
Choice4
	LD R6, NUM_FREE_MACHINES
	JSRR R6
	
	LEA R0, FREEMACHINE1
	PUTS
	
	ADD R1, R2, #0
	LD R6, PRINT_NUMBER
	JSRR R6
	
	LEA R0, FREEMACHINE2
	PUTS
	BR MAIN
	
Choice5
	LD R6, GET_INPUT
	JSRR R6

	LD R6, MACHINE_STATUS
	JSRR R6

	ADD R3, R2, #0
	BRp THIS_MACHINE_FREE
	
	LEA R0, STATUS1
	PUTS
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, STATUS2
	PUTS
	BR MAIN

	THIS_MACHINE_FREE
	LEA R0, STATUS1
	PUTS
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, STATUS3
	PUTS
	BR MAIN	
	
Choice6
	LD R6, FIRST_FREE
	JSRR R6

	ADD R3, R2, #-15
	BRp NOFREE
	
	LEA R0, FIRSTFREE
	PUTS
	ADD R1, R2, #0
	LD R6, PRINT_NUMBER
	JSRR R6
	LEA R0, FIRSTFREE2
	PUTS
	BR MAIN
	
	NOFREE
	LEA R0, FIRSTFREE3
	PUTS
	
	BR MAIN
	
Choice7
	LEA R0, Goodbye	
	PUTS

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU .FILL x3200
ALL_MACHINES_BUSY .FILL x3400
ALL_MACHINES_FREE .FILL x3600
NUM_BUSY_MACHINES .FILL x3800
NUM_FREE_MACHINES .FILL x4000
MACHINE_STATUS .FILL x4200
FIRST_FREE .FILL x4400
GET_INPUT .FILL x4600
PRINT_NUMBER .FILL x4800
;Other data 
Main_pos48 .FILL #48
;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200
	
SUB_MENU
	ST R0, BACKUP_R0_3200
	ST R2, BACKUP_R2_3200
	ST R3, BACKUP_R3_3200
	ST R7, BACKUP_R7_3200
	
	LD R2, Menu_neg48
LOOP
	LD R0, Menu_string_addr
	PUTS
	GETC
	OUT
	ADD R1, R0, #0
	LEA R0, Menu_enter
	PUTS

	ADD R1, R1, R2
	BRnz Menu_error
	ADD R3, R1, #-7
	BRp Menu_error	
	BR END_MENU
	
Menu_error
	LEA R0, Error_message_1
	PUTS
	BR LOOP
	
END_MENU
	LD R0, BACKUP_R0_3200
	LD R2, BACKUP_R2_3200
	LD R3, BACKUP_R3_3200
	LD R7, BACKUP_R7_3200
	RET
	
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000
Menu_enter .STRINGZ "\n"
Menu_neg48 .FILL xFFD0
BACKUP_R0_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400
	
SUB_ALL_MACHINES_BUSY
	ST R1, BACKUP_R1_3400
	ST R3, BACKUP_R3_3400
	ST R4, BACKUP_R4_3400
	ST R7, BACKUP_R7_3400

	LD R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
	LDR R5, R1, #0
	ADD R5, R5, #0
	BRz ALL_BUSY
	
	LD R3, MASK_1s_3400
	AND R4, R1, R3
	BRz ALL_BUSY
	BR END_ALL_MACHINES_BUSY

ALL_BUSY
	ADD R2, R2, #1
	
END_ALL_MACHINES_BUSY
	LD R1, BACKUP_R1_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
	LD R7, BACKUP_R7_3400
	RET
	
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD200
MASK_1s_3400 .FILL xFFFF
BACKUP_R1_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3600
	
SUB_ALL_MACHINES_FREE
	ST R1, BACKUP_R1_3600
	ST R3, BACKUP_R3_3600
	ST R7, BACKUP_R7_3600

	LD R1, BUSYNESS_ADDR_ALL_MACHINES_FREE
	LDR R4, R1, #0
	LD R5, MASK_1s_3600
	NOT R5, R5
	ADD R5, R5, #1
	ADD R4, R4, R5
	BRz ALL_FREE
	
	NOT R3, R1
	BRz ALL_FREE
	BR END_ALL_MACHINES_FREE

ALL_FREE
	ADD R2, R2, #1
	
END_ALL_MACHINES_FREE
	LD R1, BACKUP_R1_3600
	LD R3, BACKUP_R3_3600
	LD R7, BACKUP_R7_3600
	RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD200
MASK_1s_3600 .FILL xFFFF
BACKUP_R1_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x3800

SUB_NUM_BUSY_MACHINES
	ST R1, BACKUP_R1_3800
	ST R3, BACKUP_R3_3800
	ST R7, BACKUP_R7_3800

	LD R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES
	LDR R1, R1, #0
	AND R2, R2, #0
	LD R3, LoopCounter_3800
	
NUM_BUSY
	ADD R1, R1, #0
	BRn NOT_BUSY
	ADD R2, R2, #1

	NOT_BUSY
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRp NUM_BUSY
	
END_NUM_BUSY_MACHINES
	LD R1, BACKUP_R1_3800
	LD R3, BACKUP_R3_3800
	LD R7, BACKUP_R7_3800
	RET
	
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD200
LoopCounter_3800 .FILL #16
BACKUP_R1_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x4000
	
SUB_NUM_FREE_MACHINES
	ST R1, BACKUP_R1_4000
	ST R3, BACKUP_R3_4000
	ST R7, BACKUP_R7_4000

	LD R1, BUSYNESS_ADDR_NUM_FREE_MACHINES
	LDR R1, R1, #0
	AND R2, R2, #0
	LD R3, LoopCounter_4000

NUM_FREE
	ADD R1, R1, #0
	BRzp NOT_FREE
	ADD R2, R2, #1

	NOT_FREE
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRp NUM_FREE	
	
END_NUM_FREE_MACHINES
	LD R1, BACKUP_R1_4000
	LD R3, BACKUP_R3_4000
	LD R7, BACKUP_R7_4000
	RET

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD200
LoopCounter_4000 .FILL #16	
BACKUP_R1_4000 .BLKW #1
BACKUP_R3_4000 .BLKW #1
BACKUP_R7_4000 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4200
	
SUB_MACHINE_STATUS
	ST R1, BACKUP_R1_4200
	ST R3, BACKUP_R3_4200
	ST R4, BACKUP_R4_4200
	ST R7, BACKUP_R7_4200

	LD R4, BUSYNESS_ADDR_MACHINE_STATUS
	LDR R4, R4, #0
						
	LD R2, ZERO_4200
	LD R3, COUNTER_4200
			
FIND_MACHINE			
	ADD R2,	R3, R1	
	BRnp NOT_CORRECT
					
	ADD R4, R4, #0			
	BRzp IS_BUSY
	ADD R2, R2, #1
	BR END_MACHINE_STATUS			

IS_BUSY
	ADD R2, R2, #0
	BR END_MACHINE_STATUS

NOT_CORRECT
	ADD R4, R4, R4	
	ADD R3, R3, #1		
	BR FIND_MACHINE
	
END_MACHINE_STATUS
	LD R1, BACKUP_R1_4200
	LD R3, BACKUP_R3_4200
	LD R4, BACKUP_R4_4200
	LD R7, BACKUP_R7_4200
	RET
	
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS .Fill xD200
ZERO_4200 .FILL	#0
ONE_4200 .FILL #1
COUNTER_4200 .FILL #-15
BACKUP_R1_4200 .BLKW #1
BACKUP_R3_4200 .BLKW #1
BACKUP_R4_4200 .BLKW #1
BACKUP_R7_4200 .BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x4400

SUB_FIRST_FREE
	ST R1, BACKUP_R1_4400
	ST R3, BACKUP_R3_4400
	ST R5, BACKUP_R5_4400
	ST R7, BACKUP_R7_4400

	LD R1, BUSYNESS_ADDR_FIRST_FREE
	LDR R1, R1, #0
	ADD R4, R1, #0
	BRz ZEROS
	ADD R2, R2, #1
	ST R2, TempStorage
	LD R3, LoopCounter_4400
	LD R5, First_Counter

FIND_FIRST
	ADD R1, R1, #0
	BRzp CURRENT_BUSY
	ST R3, TempStorage

CURRENT_BUSY
	ADD R1, R1, R1
	ADD R3, R3, #1

	ADD R5, R5, #-1
	BRp FIND_FIRST

	LD R2, TempStorage
	NOT R2, R2
	ADD R2, R2, #1
	BR END_FIRST_FREE

ZEROS
	LD R2, First_Counter
	
END_FIRST_FREE
	LD R1, BACKUP_R1_4400
	LD R3, BACKUP_R3_4400
	LD R5, BACKUP_R5_4400
	LD R7, BACKUP_R7_4400
	RET	

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xD200
LoopCounter_4400 .FILL #-15
First_Counter .FILL #16
TempStorage .BLKW #1
BACKUP_R1_4400 .BLKW #1
BACKUP_R3_4400 .BLKW #1
BACKUP_R5_4400 .BLKW #1
BACKUP_R7_4400 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4600
	
SUB_GET_INPUT
	ST R0, BACKUP_R0_4600
	ST R2, BACKUP_R2_4600
	ST R3, BACKUP_R3_4600
	ST R4, BACKUP_R4_4600
	ST R5, BACKUP_R4_4600
	ST R6, BACKUP_R6_4600
	ST R7, BACKUP_R7_4600

MainBranch		       		; Outermost loop of the code
	AND R1, R1, #0
	AND R2, R2, #0
	LD R2, NEG48
	AND R3, R3, #0			; Holds hex value of pos/neg signs
	AND R4, R4, #0			; Multiplication loop counter
	ADD R4, R4, #9			; Fill with 9 counts
	AND R5, R5, #0			; Stores the result / Initializing to 0
	AND R6, R6, #0			; Flag for negative sign input

	LEA R0, prompt			; Load intro message into R0
	PUTS				; Print out the message
	
InputLoop				; BRANCH InputLoop	
	GETC				; Prompts the user for input
	OUT				; Print out the input value

isEnter					; BRANCH isEnter
	ADD R1, R0, #-10		; Compare input if it is Enter character
	BRz InputLoopEnd		; End the loop if enter was typed

isPosSign				; BRANCH isPosSign
	LD R3, PosSign			; Load Hex value of + sign into R3
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare input if it is + sign character
	BRnp isNegSign			; If not, skip the branch
	BR InputLoop			; Back to the loop
	
isNegSign				; BRANCH isNegSign
	LD R3, NegSign			; Load Hex value of - sign into R3
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare input if it is - sign character
	BRnp isCharacter		; If not, skip the branch
	ADD R6, R6, #-1			; If it is, flag R6 with #-1 for later use
	BR InputLoop			; Back to loop. No need to add it into R5

isCharacter				; BRANCH isCharacter
	LD R3, OtherChar		; Load Hex value of first special character
	NOT R3, R3			; Negate R3
	ADD R3, R3, #1			; Add 1 to make it 2's complement
	ADD R1, R0, R3			; Compare if input is character 
	BRzp CharError			; Go to print error message
	
MultLoop				; BRANCH MultLoop
	ADD R1, R5, #0			; Temporarily copy R5 value into R1
InnerLoop
	ADD R5, R5, R1			; Add up into R5	
	ADD R4, R4, #-1			; Decrement counter by 1
	BRz toRealValue			; If counter = 0, end the loop
	BR InnerLoop			; Otherwise, back to the top of the loop 
	
toRealValue				; BRANCH toRealValue
	ADD R0, R0, R2			; Convert the number to real value
	ADD R5, R5, R0			; Add the R0 value into R5
	ADD R4, R4, #9			; Refill #9 for MultLoop counter
	BR InputLoop			; Back to the loop
	
InputLoopEnd				; BRANCH InputLoopEnd 
	ADD R5, R5, #0			; Check if only sign or nothing was entered
	BRz PrintError			; Branch to print error message and restart
	
	ADD R1, R6, #1	      		; Check negative sign flag
	BRnp END_GET_INPUT		; If no -sign was found, skip the code
	NOT R5, R5			; If -sign was found, negate the result
	ADD R5, R5, #1			; Add 1 to make it 2's complement
	BR END_GET_INPUT

CharError
	LEA R0, Error_message_3
	PUTS
	BR MainBranch
	
PrintError				; BRANCH PrintError
	LEA R0, Error_message_2		; Load R0 with errorMessage
	PUTS				; Print out the error message
	BR MainBranch			; Restart the program	
	
END_GET_INPUT
	ADD R1, R5, #0
	BRn PrintError
	ADD R2, R1, #-15
	BRp PrintError
	
	LD R0, BACKUP_R0_4600
	LD R2, BACKUP_R2_4600
	LD R3, BACKUP_R3_4600
	LD R4, BACKUP_R4_4600
	LD R5, BACKUP_R5_4600
	LD R6, BACKUP_R6_4600
	LD R7, BACKUP_R7_4600
	RET

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
Error_message_3 .STRINGZ "\nERROR INVALID INPUT\n"
NegSign	.FILL x002D
PosSign	.FILL x002B
NEG48 .FILL xFFD0
OtherChar .FILL x003A
BACKUP_R0_4600 .BLKW #1
BACKUP_R2_4600 .BLKW #1
BACKUP_R3_4600 .BLKW #1
BACKUP_R4_4600 .BLKW #1
BACKUP_R5_4600 .BLKW #1
BACKUP_R6_4600 .BLKW #1
BACKUP_R7_4600 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4800
	
SUB_PRINT_NUMBER
	ST R0, BACKUP_R0_4800
	ST R2, BACKUP_R2_4800
	ST R3, BACKUP_R3_4800
	ST R4, BACKUP_R4_4800
	ST R5, BACKUP_R5_4800
	ST R6, BACKUP_R6_4800
	ST R7, BACKUP_R7_4800


	ADD R2, R1, #0
	LD R3, DEC_COUNTER		
	LD R4, NDEC_10000			
	LD R5, ASCII_4800		
	LD R6, ZERO_4800					

AGAIN1
	ADD R2, R2, R4				
	BRn IS_NEGATIVE1
							
	ADD R3, R3, #1
	ADD R6, R6, #1				
	BRnzp AGAIN1
	
IS_NEGATIVE1
	ADD R6, R6, #0			
	BRnp PRINT_ZERO1
							
	ADD R3, R3, #0			
	BRz NEXTONE1
	
PRINT_ZERO1
	ADD R0, R3, #0
	ADD R0, R0, R5			
	OUT
	
NEXTONE1			
	LD R4, PDEC_10000
	LD R3, DEC_COUNTER		
	ADD R2, R2, R4				
													
AGAIN2
	LD R4, NDEC_1000			
	ADD R2, R2, R4				
	BRn IS_NEGATIVE2
	ADD R6, R6, #1			
	ADD R3, R3, #1
	BRnzp AGAIN2
	
IS_NEGATIVE2
	ADD R6, R6, #0			
	BRnp PRINT_ZERO2
	ADD R3, R3, #0		
	BRz NEXTONE2
	
PRINT_ZERO2
	ADD R0, R3, #0
	ADD R0, R0, R5			
	OUT
	
NEXTONE2
	LD R4, PDEC_1000
	LD R3, DEC_COUNTER		
	ADD R2, R2, R4			

AGAIN3
	LD R4, NDEC_100
	ADD R2, R2, R4				
	BRn IS_NEGATIVE3
	ADD R6, R6, #1	
	ADD R3, R3, #1
	BRnzp AGAIN3
	
IS_NEGATIVE3
	ADD R6, R6, #0				
	BRnp PRINT_ZERO3

	ADD R3, R3, #0			
	BRz NEXTONE3
	
PRINT_ZERO3							
	ADD R0, R3, #0
	ADD R0, R0, R5			
	OUT
	
NEXTONE3
	LD R4, PDEC_100
	LD R3, DEC_COUNTER		
	ADD R2, R2, R4			

AGAIN4
	LD R4, NDEC_10
	ADD R2, R2, R4				
	BRn IS_NEGATIVE4
	ADD R6, R6, #1			
	ADD R3, R3, #1
	BRnzp AGAIN4
	
IS_NEGATIVE4
	ADD R6, R6, #0			
	BRnp PRINT_ZERO4

	ADD R3, R3, #0		
	BRz NEXTONE4
	
PRINT_ZERO4	
	ADD R0, R3, #0
	ADD R0, R0, R5			
	OUT
	
NEXTONE4
	LD R4, PDEC_10
	LD R3, DEC_COUNTER		
	ADD R2, R2, R4			
	
AGAIN5
	LD R4, NDEC_1
	ADD R2, R2, R4				
	BRn IS_NEGATIVE5
	ADD R6, R6, #1			
	ADD R3, R3, #1
	BRnzp AGAIN5
	
IS_NEGATIVE5	
	ADD R0, R3, #0
	ADD R0, R0, R5			
	OUT
	LD R4, PDEC_1
	LD R3, DEC_COUNTER		
	ADD R2, R2, R4			

END_PRINT_NUMBER
	LD R0, BACKUP_R0_4800
	LD R2, BACKUP_R2_4800
	LD R3, BACKUP_R3_4800
	LD R4, BACKUP_R4_4800
	LD R5, BACKUP_R5_4800
	LD R6, BACKUP_R6_4800
	LD R7, BACKUP_R7_4800
	RET
	
;--------------------------------
;Data for subroutine print number
;--------------------------------
NDEC_10000 .FILL #-10000
NDEC_1000 .FILL #-1000
NDEC_100 .FILL #-100
NDEC_10 .FILL #-10
NDEC_1 .FILL #-1
PDEC_10000 .FILL #10000
PDEC_1000 .FILL #1000
PDEC_100 .FILL #100
PDEC_10 .FILL #10
PDEC_1 .FILL #1
ZERO_4800 .FILL #0
ASCII_4800 .FILL #48
DEC_COUNTER .FILL #0
BACKUP_R0_4800 .BLKW #1
BACKUP_R2_4800 .BLKW #1
BACKUP_R3_4800 .BLKW #1
BACKUP_R4_4800 .BLKW #1
BACKUP_R5_4800 .BLKW #1 
BACKUP_R6_4800 .BLKW #1
BACKUP_R7_4800 .BLKW #1

	
.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD200			; Remote data
BUSYNESS .FILL xABCD		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END