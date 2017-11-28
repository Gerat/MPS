		org 0h
		ajmp init
		org 23h
		ajmp serint
init:
		clr psw.3
		clr psw.4
		mov R0, #3h
		
		mov IE, #10010000b
		mov IP, #00010000b
		
		mov SCON, #10010000b
		
		mov dptr, #8070h
		mov a, #0Bh
		movx @DPTR, a
		inc dptr
		mov a, #0Ch
		movx @DPTR, a
		inc dptr
		mov a, #0Fh
		movx @DPTR, a
		mov dptr, #8070h
		setb TI
		
main:
		acall calc
		mov 0C0h, a
		jnb TI, $
		clr TI
		mov sbuf, a
		acall jinc
		ajmp main // loop
		
calc:
		movx a, @DPTR
		mov b, a
		anl b, #1h
		mov c, acc.1
		orl c, acc.2
		anl c, /acc.3
		movx a, @DPTR
		swap a
		mov acc.3, c
		mov R1, a
		clr a
		rlc a
		xrl a, b
		rrc a
		mov a, R1
		mov acc.2, c
		ret
		
jinc:
		inc DPTR
		djnz R0, jinc1
		mov R0, #3h
		mov DPTR, #8070h
jinc1:
		ret
		
serint:
		jmp main
		reti
		
		end