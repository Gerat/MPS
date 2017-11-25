		org 0h
		ajmp init
		org 03h
		ajmp inter0
		org 0Bh
		ajmp tc0
init:
		clr psw.3
		clr psw.4
		mov R0, #4h
		mov IE, #10000011b
		mov IP, #00000001b
		mov TCON, #0h
		mov TMOD, #00000011b
		mov 0C0h, #00100000b
		mov dptr, #8000h
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
		mov 0C0h, a
		mov c, b.0
		mov 0C0h.4, c
		mov b, #0h
		acall starttl
		setb TR0
		jb TR0, $
		mov 0C0h, #0h
		acall starttb
		setb TR0
		jb TR0, $
		acall jinc
		ajmp main // loop
		
inter0:
		mov R3, DPL
		cjne R3, #04h, inter01
		dec R3
		mov DPL, R3
inter01:
		movx a, @DPTR
		mov c, 0C0h.5
		mov acc.0, c
		movx @DPTR, a
		reti
		
tc0:
		mov Tl0, #10d
		djnz R2, tc01
		mov R2, #200d
		djnz R1, tc01
		clr TR0
tc01:
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
		mov b, #0h
		rrc a
		mov b.0, c
		movx a, @DPTR
calc1:
		ret
		
jinc:
		inc DPTR
		djnz R0, jinc1
		mov R0, #4h
		mov DPTR, #8000h
jinc1:
		ret
		
starttb:
		mov R1, #68d
		mov R2, #200d
		ret
		
starttl:
		mov R1, #22d
		mov R2, #200d
		ret
		
		end