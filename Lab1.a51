		org 0h
		ajmp init
		org 13h
		ajmp inter1
		org 23h
		ajmp serint
init:
		clr psw.3
		clr psw.4
		mov R0, #8h
		mov IE, #10010100b
		mov IP, #00010100b
		mov TCON, #0h
		mov 0C0h, 00000000b
		mov dptr, #8000h
		mov a, #0h
		movx @DPTR, a
		inc dptr
		mov a, #2h
		movx @DPTR, a
		inc dptr
		mov a, #5h
		movx @DPTR, a
		inc dptr
		mov a, #6h
		movx @DPTR, a
		inc dptr
		mov a, #8h
		movx @DPTR, a
		inc dptr
		mov a, #0Bh
		movx @DPTR, a
		inc dptr
		mov a, #0Ch
		movx @DPTR, a
		inc dptr
		mov a, #0Fh
		movx @DPTR, a
		mov dptr, #8000h
		
main:
		acall calc
		mov 0C0h, #0h
		acall timertb // timer T
		mov 0C0h, a
		mov 0C0h.4, c
		acall timertl // timer t
		mov 0C0h, #0h
		acall jinc
		ajmp main // loop
		
inter1:
		movx a, @DPTR
		setb acc.0
		movx @DPTR, a
		reti
		
	
serint:
		movx a, @DPTR
		clr acc.0
		movx @DPTR, a
		clr RI
		reti
		
calc:
		movx a, @DPTR
		mov b, a
		anl b, #1h
		mov c, acc.1
		orl c, acc.2
		anl c, /acc.3
		clr a
		rlc a
		xrl a, b
		rrc a
		movx a, @DPTR
calc1:
		ret
		
jinc:
		inc DPTR
		djnz R0, jinc1 
		mov R0, #8h
		mov DPTR, #8000h
jinc1:
		ret
		
		//timer t
timertl:
		mov R1, #8d
timertl1:
		mov R2, #250d
timertl2:
		mov R3, #250d
		djnz R3, $
		djnz R2, timertl2
		djnz R1, timertl1
		mov R2, #200d
timertl3:
		mov R3, 250d
		djnz R3, $
		djnz R2, timertl3
		ret
		
		//timer T
timertb:
		mov R1, #27d
timertb1:
		mov R2, #250d
timertb2:
		mov R3, #250d
		djnz R3, $
		djnz R2, timertb2
		djnz R1, timertb1
		ret
		
		end
		/*
		timertl:
		mov R3, #2d
timertl1:
		mov R4, #255d
		djnz R4, $
		djnz R3, timertl1
		mov R4, #40d
		djnz R4, $
		ret
		
		//timer T
timertb:
		mov R3, #13d
timertb1:
		mov R4, #255d
		djnz R4, $
		djnz R3, timertb1
		mov R4, #85d
		djnz R4, $
		ret
		*/
		
