
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,7 :: 		void interrupt ()
;MyProject.c,10 :: 		if(INTCON.TMR0IF==1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;MyProject.c,12 :: 		if(flag==1)
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt24
	MOVLW      1
	XORWF      _flag+0, 0
L__interrupt24:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;MyProject.c,14 :: 		contagem++;
	INCF       _contagem+0, 1
;MyProject.c,16 :: 		if(contagem==40)
	MOVF       _contagem+0, 0
	XORLW      40
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;MyProject.c,18 :: 		num--;
	MOVLW      1
	SUBWF      _num+0, 1
	BTFSS      STATUS+0, 0
	DECF       _num+1, 1
;MyProject.c,19 :: 		contagem =0;
	CLRF       _contagem+0
;MyProject.c,20 :: 		}
L_interrupt2:
;MyProject.c,21 :: 		}
L_interrupt1:
;MyProject.c,22 :: 		TMR0=61;
	MOVLW      61
	MOVWF      TMR0+0
;MyProject.c,23 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;MyProject.c,24 :: 		}
L_interrupt0:
;MyProject.c,25 :: 		}
L_end_interrupt:
L__interrupt23:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_display_dezenas:

;MyProject.c,27 :: 		display_dezenas()
;MyProject.c,29 :: 		portc.rc4=1;
	BSF        PORTC+0, 4
;MyProject.c,30 :: 		Dezenas=(num/10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _num+0, 0
	MOVWF      R0+0
	MOVF       _num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _Dezenas+0
;MyProject.c,31 :: 		portd=Display[Dezenas];
	MOVF       R0+0, 0
	ADDLW      _Display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,32 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_display_dezenas3:
	DECFSZ     R13+0, 1
	GOTO       L_display_dezenas3
	DECFSZ     R12+0, 1
	GOTO       L_display_dezenas3
	NOP
	NOP
;MyProject.c,33 :: 		portc.rc4=0;
	BCF        PORTC+0, 4
;MyProject.c,34 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,35 :: 		}
L_end_display_dezenas:
	RETURN
; end of _display_dezenas

_display_unidades:

;MyProject.c,37 :: 		display_unidades()
;MyProject.c,39 :: 		portc.rc5=1;
	BSF        PORTC+0, 5
;MyProject.c,40 :: 		Unidades=(num%10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _num+0, 0
	MOVWF      R0+0
	MOVF       _num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Unidades+0
;MyProject.c,41 :: 		portd=Display[Unidades];
	MOVF       R0+0, 0
	ADDLW      _Display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,42 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_display_unidades4:
	DECFSZ     R13+0, 1
	GOTO       L_display_unidades4
	DECFSZ     R12+0, 1
	GOTO       L_display_unidades4
	NOP
	NOP
;MyProject.c,43 :: 		portc.rc5=0;
	BCF        PORTC+0, 5
;MyProject.c,44 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,45 :: 		}
L_end_display_unidades:
	RETURN
; end of _display_unidades

_fim:

;MyProject.c,46 :: 		fim()
;MyProject.c,48 :: 		portd=63;
	MOVLW      63
	MOVWF      PORTD+0
;MyProject.c,49 :: 		portc.rc4=0;
	BCF        PORTC+0, 4
;MyProject.c,50 :: 		portc.rc5=0;
	BCF        PORTC+0, 5
;MyProject.c,51 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_fim5:
	DECFSZ     R13+0, 1
	GOTO       L_fim5
	DECFSZ     R12+0, 1
	GOTO       L_fim5
	DECFSZ     R11+0, 1
	GOTO       L_fim5
	NOP
	NOP
;MyProject.c,52 :: 		portc.rc4=1;
	BSF        PORTC+0, 4
;MyProject.c,53 :: 		portc.rc5=1;
	BSF        PORTC+0, 5
;MyProject.c,54 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_fim6:
	DECFSZ     R13+0, 1
	GOTO       L_fim6
	DECFSZ     R12+0, 1
	GOTO       L_fim6
	DECFSZ     R11+0, 1
	GOTO       L_fim6
	NOP
	NOP
;MyProject.c,55 :: 		}
L_end_fim:
	RETURN
; end of _fim

_main:

;MyProject.c,57 :: 		void main()
;MyProject.c,60 :: 		ADCON1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,61 :: 		TRISD=0;
	CLRF       TRISD+0
;MyProject.c,62 :: 		PORTD=0;
	CLRF       PORTD+0
;MyProject.c,63 :: 		TRISB=255;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,64 :: 		PORTB=255;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,65 :: 		TRISA.RA4=1;
	BSF        TRISA+0, 4
;MyProject.c,66 :: 		PORTA.RA4=1;
	BSF        PORTA+0, 4
;MyProject.c,67 :: 		TRISC=0;
	CLRF       TRISC+0
;MyProject.c,68 :: 		PORTC=0;
	CLRF       PORTC+0
;MyProject.c,69 :: 		INTCON.GIE=1;                               //HABILITA INTERRUPÇÃO GLOBAL
	BSF        INTCON+0, 7
;MyProject.c,70 :: 		INTCON.PEIE=0;
	BCF        INTCON+0, 6
;MyProject.c,71 :: 		INTCON.TMR0IE=1;                             //HABILITA TIMER 0
	BSF        INTCON+0, 5
;MyProject.c,72 :: 		TMR0=61;
	MOVLW      61
	MOVWF      TMR0+0
;MyProject.c,73 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;MyProject.c,74 :: 		OPTION_REG=0b10000111;                      //HABILITA PRE ESCALER PARA 256
	MOVLW      135
	MOVWF      OPTION_REG+0
;MyProject.c,77 :: 		while(1)
L_main7:
;MyProject.c,79 :: 		if(portb.rb1==0 || portb.rb2==0)
	BTFSS      PORTB+0, 1
	GOTO       L__main21
	BTFSS      PORTB+0, 2
	GOTO       L__main21
	GOTO       L_main11
L__main21:
;MyProject.c,80 :: 		{ flag=1;}
	MOVLW      1
	MOVWF      _flag+0
	MOVLW      0
	MOVWF      _flag+1
L_main11:
;MyProject.c,81 :: 		if(portb.rb2==0 && flag==1)
	BTFSC      PORTB+0, 2
	GOTO       L_main14
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main29
	MOVLW      1
	XORWF      _flag+0, 0
L__main29:
	BTFSS      STATUS+0, 2
	GOTO       L_main14
L__main20:
;MyProject.c,82 :: 		{ flag=0; }
	CLRF       _flag+0
	CLRF       _flag+1
L_main14:
;MyProject.c,84 :: 		if(portb.rb0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_main15
;MyProject.c,85 :: 		{ num++;
	INCF       _num+0, 1
	BTFSC      STATUS+0, 2
	INCF       _num+1, 1
;MyProject.c,86 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	NOP
;MyProject.c,87 :: 		}
L_main15:
;MyProject.c,88 :: 		if(num==100)
	MOVLW      0
	XORWF      _num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main30
	MOVLW      100
	XORWF      _num+0, 0
L__main30:
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;MyProject.c,89 :: 		{ num=0; }
	CLRF       _num+0
	CLRF       _num+1
L_main17:
;MyProject.c,90 :: 		if(num>=0)
	MOVLW      128
	XORWF      _num+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main31
	MOVLW      0
	SUBWF      _num+0, 0
L__main31:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
;MyProject.c,92 :: 		display_dezenas();
	CALL       _display_dezenas+0
;MyProject.c,93 :: 		display_unidades();
	CALL       _display_unidades+0
;MyProject.c,94 :: 		}
L_main18:
;MyProject.c,96 :: 		if(num<=0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _num+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVF       _num+0, 0
	SUBLW      0
L__main32:
	BTFSS      STATUS+0, 0
	GOTO       L_main19
;MyProject.c,98 :: 		flag=0;
	CLRF       _flag+0
	CLRF       _flag+1
;MyProject.c,99 :: 		num=0;
	CLRF       _num+0
	CLRF       _num+1
;MyProject.c,100 :: 		fim();
	CALL       _fim+0
;MyProject.c,101 :: 		}
L_main19:
;MyProject.c,102 :: 		}
	GOTO       L_main7
;MyProject.c,103 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
