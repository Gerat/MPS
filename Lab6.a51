		org 0h
		ajmp init
		org 13h
		ajmp inter1
init:
		clr psw.3
		clr psw.4
		mov R0, #0h //set x, y, z, f
		mov R1, #0h //x
		mov R2, #0h //y
		mov R3, #0h //z
		
		mov IE, #10000100b //allow int1
		
		mov DPTR, #7FFFh
		mov a, #01h
		movx @DPTR, a //keyboard mode
		
		mov DPTR, #7FFFh
		mov a, #40h
		movx @DPTR, a //allow read from keyboard
		
main:
		jb EA, $
		acall kit
		acall calc
		ajmp main // loop
		
calc:
		mov c, acc.1
		orl c, acc.2
		anl c, /acc.3
		mov acc.0, c
		mov R0, a
		mov 0C0h, a
		setb EA
		ret
		
kit:
		mov b, R1
		mov c, b.0
		mov acc.3, c
		mov b, R2
		mov c, b.0
		mov acc.2, c
		mov b, R3
		mov c, b.0
		mov acc.1, c
		ret
		
inter1:
		mov DPTR, #7FFEh
		movx a, @DPTR
k1:
		cjne a, #11000000b, k2
		inc R1
		jmp exit
k2:
		cjne a, #11000001b, k3
		inc R2
		jmp exit
k3:
		cjne a, #11000010b, ksh
		inc R3
		jmp exit
ksh:
		cjne a, #11011010b, exit
		clr EA
exit:
		reti
		
		end