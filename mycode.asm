                                       .MODEL SMALL
.STACK 100H
.DATA
    ; Enhanced Interface Messages with Colors and Borders
    CLEAR_SCREEN DB 27,'[2J',27,'[H$'  ; Clear screen ANSI code
    
    HEADER1 DB 10,13,'        +---------------------------------------------------+$'
    HEADER2 DB 10,13,'        ¦                                                   ¦$'
    HEADER3 DB 10,13,'        ¦        ?  ADVANCED CALCULATOR v2.0  ?           ¦$'
    HEADER4 DB 10,13,'        ¦           Signed Number Support                  ¦$'
    HEADER5 DB 10,13,'        ¦                                                   ¦$'
    HEADER6 DB 10,13,'        +---------------------------------------------------+$'
    
    SEPARATOR DB 10,13,'        ????????????????????????????????????????????????$'
    
    MENU_TOP DB 10,13,10,13,'        ?-----------------------------------------------?$'
    MENU1 DB 10,13,'        ¦                                                   ¦$'
    MENU2 DB 10,13,'        ¦          +--- OPERATIONS MENU ---+              ¦$'
    MENU3 DB 10,13,'        ¦          ¦                        ¦              ¦$'
    MENU4 DB 10,13,'        ¦          ¦  ?  Addition      [+] ¦              ¦$'
    MENU5 DB 10,13,'        ¦          ¦  ?  Subtraction   [-] ¦              ¦$'
    MENU6 DB 10,13,'        ¦          ¦  ?  Multiply      [×] ¦              ¦$'
    MENU7 DB 10,13,'        ¦          ¦  ?  Division      [÷] ¦              ¦$'
    MENU8 DB 10,13,'        ¦          ¦  ?  Exit Program      ¦              ¦$'
    MENU9 DB 10,13,'        ¦          ¦                        ¦              ¦$'
    MENU10 DB 10,13,'        ¦          +------------------------+              ¦$'
    MENU11 DB 10,13,'        ¦                                                   ¦$'
    MENU_BTM DB 10,13,'        ?-----------------------------------------------?$'
    
    PROMPT1 DB 10,13,10,13,'        +-----------------------------------------+$'
    PROMPT2 DB 10,13,'        ¦  ? Enter your choice (1-5): $'
    
    INPUT1 DB 10,13,10,13,'        +---------------------------------------------------+$'
    INPUT2 DB 10,13,'        ¦               INPUT SECTION                       ¦$'
    INPUT3 DB 10,13,'        +---------------------------------------------------+$'
    
    MSG6 DB 10,13,'        ¦  ? Enter 1st Number: $'
    MSG7 DB 10,13,'        ¦  ? Enter 2nd Number: $'
    
    RESULT_TOP DB 10,13,10,13,'        +---------------------------------------------------+$'
    RESULT1 DB 10,13,'        ¦                    RESULT                         ¦$'
    RESULT2 DB 10,13,'        ¦---------------------------------------------------¦$'
    RESULT3 DB 10,13,'        ¦                                                   ¦$'
    RESULT4 DB 10,13,'        ¦           ?  Answer: $'
    RESULT5 DB 10,13,'        ¦                                                   ¦$'
    RESULT_BTM DB 10,13,'        +---------------------------------------------------+$'
    
    ERROR_TOP DB 10,13,10,13,'        +---------------------------------------------------+$'
    ERROR1 DB 10,13,'        ¦                    ? ERROR ?                      ¦$'
    ERROR2 DB 10,13,'        ¦---------------------------------------------------¦$'
    ERROR3 DB 10,13,'        ¦                                                   ¦$'
    MSG9 DB 10,13,'        ¦     ? Division by zero is not allowed!           ¦$'
    MSG10 DB 10,13,'        ¦     ? Invalid choice! Select 1-5 only.           ¦$'
    ERROR4 DB 10,13,'        ¦                                                   ¦$'
    ERROR_BTM DB 10,13,'        +---------------------------------------------------+$'
    
    EXIT_TOP DB 10,13,10,13,'        +---------------------------------------------------+$'
    EXIT1 DB 10,13,'        ¦                                                   ¦$'
    EXIT2 DB 10,13,'        ¦              ? THANK YOU! ?                      ¦$'
    EXIT3 DB 10,13,'        ¦                                                   ¦$'
    EXIT4 DB 10,13,'        ¦        Thanks for using Advanced Calculator       ¦$'
    EXIT5 DB 10,13,'        ¦              Have a great day! ??                ¦$'
    EXIT6 DB 10,13,'        ¦                                                   ¦$'
    EXIT_BTM DB 10,13,'        +---------------------------------------------------+$'
    
    CONTINUE_MSG DB 10,13,10,13,'        Press any key to continue...$'
    
    NEWLINE DB 10,13,'$'
    
    ; Variables
    NUM1 DW 0
    NUM2 DW 0
    RESULT DW 0
    SIGN_FLAG DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MAIN_LOOP:
    ; Display Interface
    CALL DISPLAY_INTERFACE
    
    ; Get user choice
    MOV AH, 1
    INT 21H
    MOV BH, AL
    SUB BH, 48
    
    ; Check choice
    CMP BH, 1
    JE ADDITION
    CMP BH, 2
    JE SUBTRACTION
    CMP BH, 3
    JE MULTIPLICATION
    CMP BH, 4
    JE DIVISION
    CMP BH, 5
    JE EXIT_PROGRAM
    
    ; Invalid input
    CALL SHOW_INVALID_ERROR
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

ADDITION:
    CALL GET_NUMBERS
    MOV AX, NUM1
    ADD AX, NUM2
    MOV RESULT, AX
    CALL DISPLAY_RESULT
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

SUBTRACTION:
    CALL GET_NUMBERS
    MOV AX, NUM1
    SUB AX, NUM2
    MOV RESULT, AX
    CALL DISPLAY_RESULT
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

MULTIPLICATION:
    CALL GET_NUMBERS
    MOV AX, NUM1
    IMUL NUM2
    MOV RESULT, AX
    CALL DISPLAY_RESULT
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

DIVISION:
    CALL GET_NUMBERS
    
    CMP NUM2, 0
    JE DIV_BY_ZERO
    
    MOV AX, NUM1
    CWD
    IDIV NUM2
    MOV RESULT, AX
    CALL DISPLAY_RESULT
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

DIV_BY_ZERO:
    CALL SHOW_DIV_ERROR
    CALL PAUSE_SCREEN
    JMP MAIN_LOOP

EXIT_PROGRAM:
    CALL SHOW_EXIT_MESSAGE
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; -----------------------------------------------------------
; PROCEDURE: DISPLAY_INTERFACE
; -----------------------------------------------------------
DISPLAY_INTERFACE PROC
    ; Display Header
    LEA DX, HEADER1
    MOV AH, 9
    INT 21H
    
    LEA DX, HEADER2
    MOV AH, 9
    INT 21H
    
    LEA DX, HEADER3
    MOV AH, 9
    INT 21H
    
    LEA DX, HEADER4
    MOV AH, 9
    INT 21H
    
    LEA DX, HEADER5
    MOV AH, 9
    INT 21H
    
    LEA DX, HEADER6
    MOV AH, 9
    INT 21H
    
    ; Display Menu
    LEA DX, MENU_TOP
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU1
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU2
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU3
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU4
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU5
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU6
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU7
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU8
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU9
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU10
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU11
    MOV AH, 9
    INT 21H
    
    LEA DX, MENU_BTM
    MOV AH, 9
    INT 21H
    
    ; Display Prompt
    LEA DX, PROMPT1
    MOV AH, 9
    INT 21H
    
    LEA DX, PROMPT2
    MOV AH, 9
    INT 21H
    
    RET
DISPLAY_INTERFACE ENDP

; -----------------------------------------------------------
; PROCEDURE: GET_NUMBERS
; -----------------------------------------------------------
GET_NUMBERS PROC
    ; Display Input Section Header
    LEA DX, INPUT1
    MOV AH, 9
    INT 21H
    
    LEA DX, INPUT2
    MOV AH, 9
    INT 21H
    
    LEA DX, INPUT3
    MOV AH, 9
    INT 21H
    
    ; Get first number
    LEA DX, MSG6
    MOV AH, 9
    INT 21H
    CALL READ_SIGNED_NUMBER
    MOV NUM1, AX
    
    ; Get second number
    LEA DX, MSG7
    MOV AH, 9
    INT 21H
    CALL READ_SIGNED_NUMBER
    MOV NUM2, AX
    
    RET
GET_NUMBERS ENDP

; -----------------------------------------------------------
; PROCEDURE: READ_SIGNED_NUMBER
; -----------------------------------------------------------
READ_SIGNED_NUMBER PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR BX, BX
    XOR CX, CX
    MOV SIGN_FLAG, 0
    
    MOV AH, 1
    INT 21H
    
    CMP AL, '-'
    JE SET_NEGATIVE
    CMP AL, '+'
    JE READ_NEXT
    
    CMP AL, 13
    JE DONE_READING
    SUB AL, '0'
    CBW
    MOV BX, AX
    JMP READ_LOOP

SET_NEGATIVE:
    MOV SIGN_FLAG, 1
    JMP READ_NEXT

READ_NEXT:

READ_LOOP:
    MOV AH, 1
    INT 21H
    
    CMP AL, 13
    JE DONE_READING
    
    SUB AL, '0'
    
    PUSH AX
    MOV AX, BX
    MOV CX, 10
    MUL CX
    MOV BX, AX
    POP AX
    
    CBW
    ADD BX, AX
    
    JMP READ_LOOP

DONE_READING:
    MOV AX, BX
    
    CMP SIGN_FLAG, 1
    JNE FINISH_READ
    NEG AX

FINISH_READ:
    POP DX
    POP CX
    POP BX
    RET
READ_SIGNED_NUMBER ENDP

; -----------------------------------------------------------
; PROCEDURE: DISPLAY_RESULT
; -----------------------------------------------------------
DISPLAY_RESULT PROC
    LEA DX, RESULT_TOP
    MOV AH, 9
    INT 21H
    
    LEA DX, RESULT1
    MOV AH, 9
    INT 21H
    
    LEA DX, RESULT2
    MOV AH, 9
    INT 21H
    
    LEA DX, RESULT3
    MOV AH, 9
    INT 21H
    
    LEA DX, RESULT4
    MOV AH, 9
    INT 21H
    
    MOV AX, RESULT
    CALL PRINT_SIGNED_NUMBER
    
    LEA DX, RESULT5
    MOV AH, 9
    INT 21H
    
    LEA DX, RESULT_BTM
    MOV AH, 9
    INT 21H
    
    RET
DISPLAY_RESULT ENDP

; -----------------------------------------------------------
; PROCEDURE: SHOW_DIV_ERROR
; -----------------------------------------------------------
SHOW_DIV_ERROR PROC
    LEA DX, ERROR_TOP
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR1
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR2
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR3
    MOV AH, 9
    INT 21H
    
    LEA DX, MSG9
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR4
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR_BTM
    MOV AH, 9
    INT 21H
    
    RET
SHOW_DIV_ERROR ENDP

; -----------------------------------------------------------
; PROCEDURE: SHOW_INVALID_ERROR
; -----------------------------------------------------------
SHOW_INVALID_ERROR PROC
    LEA DX, ERROR_TOP
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR1
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR2
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR3
    MOV AH, 9
    INT 21H
    
    LEA DX, MSG10
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR4
    MOV AH, 9
    INT 21H
    
    LEA DX, ERROR_BTM
    MOV AH, 9
    INT 21H
    
    RET
SHOW_INVALID_ERROR ENDP

; -----------------------------------------------------------
; PROCEDURE: SHOW_EXIT_MESSAGE
; -----------------------------------------------------------
SHOW_EXIT_MESSAGE PROC
    LEA DX, EXIT_TOP
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT1
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT2
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT3
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT4
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT5
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT6
    MOV AH, 9
    INT 21H
    
    LEA DX, EXIT_BTM
    MOV AH, 9
    INT 21H
    
    RET
SHOW_EXIT_MESSAGE ENDP

; -----------------------------------------------------------
; PROCEDURE: PAUSE_SCREEN
; -----------------------------------------------------------
PAUSE_SCREEN PROC
    LEA DX, CONTINUE_MSG
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    
    RET
PAUSE_SCREEN ENDP

; -----------------------------------------------------------
; PROCEDURE: PRINT_SIGNED_NUMBER
; -----------------------------------------------------------
PRINT_SIGNED_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    TEST AX, AX
    JZ PRINT_ZERO
    
    TEST AX, AX
    JNS PRINT_POSITIVE
    
    PUSH AX
    MOV DL, '-'
    MOV AH, 2
    INT 21H
    POP AX
    
    NEG AX

PRINT_POSITIVE:
    XOR CX, CX
    MOV BX, 10

EXTRACT_DIGITS:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    TEST AX, AX
    JNZ EXTRACT_DIGITS

PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP PRINT_DIGITS
    JMP PRINT_END

PRINT_ZERO:
    MOV DL, '0'
    MOV AH, 2
    INT 21H
    
PRINT_END:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_SIGNED_NUMBER ENDP

END MAIN           

