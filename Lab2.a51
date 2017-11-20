		org 0h
		ajmp init
		org 03h
		ajmp inter0
init:
		clr psw.3
		clr psw.4
		mov R0, #8h
		mov IE, #10000001b
		mov IP, #00000001b
		mov TCON, #0h
		mov TMOD, #00000011b
		mov 0C0h, #0010000b
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
		mov c, b.0
		mov 0C0h.4, c
		mov b, #0h
		acall timertl // timer t
		mov 0C0h, #0h
		acall jinc
		ajmp main // loop
		
inter0:
		movx a, @DPTR
		mov c, 0C0h.5
		mov acc.0, c
		movx @DPTR, a
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
		mov R0, #8h
		mov DPTR, #8000h
jinc1:
		ret
		
timertl:
		mov R1, #130d
timertl1:
		mov TL0, #155d
		setb TR0
timertl2:
		jbc TF0, timertl3
		sjmp timertl2
timertl3:
		clr TR0
		djnz R1, timertl1
		ret
		
timertb:
		mov R2, #3d
timertb1:
		mov R1, #134d
timertb2:
		mov TL0, #155d
		setb TR0
timertb3:
		jbc TF0, timertb4
		sjmp timertb3
timertb4:
		clr TR0
		djnz R1, timertb2
		djnz R2, timertb1
		ret
		
		end
