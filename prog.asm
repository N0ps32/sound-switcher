; PIC16F1827
#include <p16f1827.inc>

; CONFIG1
; __config 0x3FE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _WRT_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LVP_ON
 
;*******************************************************************************
; CONSTANTS
;*******************************************************************************

IO_PORT EQU PORTA ; IO PORT
OUT0 EQU RA0 ; OUTPUT 0
INP0 EQU RA1 ; INPUT 0

;*******************************************************************************
; RESET VECTOR
;*******************************************************************************

RES_VECT  CODE    0x0000 ; processor reset vector
    GOTO    START ; go to beginning of program

;*******************************************************************************
; MAIN PROGRAM
;*******************************************************************************

MAIN_PROG CODE ; MAIN PROGRAM

CONFIGURE_IO_PORT ; CONFIGURE IO PINS ON IO_PORT
    BANKSEL IO_PORT
    CLRF IO_PORT ; RESET PORTA

    BANKSEL ANSELA
    CLRF ANSELA ; RESET DIGITAL IO

    BANKSEL LATA
    CLRF LATA ; RESET LATCH

    BANKSEL TRISA
    CLRF TRISA ; SET ALL PINS TO OUTPUT
    ;BSF IO_PORT, INP0 ; SET INPUT PIN
    
    RETURN
    
OUT0_HIGH ; SET OUT0 TO HIGH
    BANKSEL IO_PORT
    BSF IO_PORT, OUT0 ; SET OUT0 BIT ON IO_PORT
    RETURN
    
OUT0_LOW ; SET OUT0 TO LOW
    BANKSEL IO_PORT
    BCF IO_PORT, OUT0 ; CLEAR OUT0 BIT ON IO_PORT
    RETURN

START
    CALL CONFIGURE_IO_PORT
    CALL OUT0_HIGH
    GOTO $ ; LOOP
    END
