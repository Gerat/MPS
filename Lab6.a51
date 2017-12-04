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
		acall reset
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
		
reset:
		mov R0, #0h
		mov R1, #0h
		mov R2, #0h
		mov R3, #0h
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
		
com:
		mov R4, a
		mov DPTR, #7FF6h
wbf:
		movx a, @DPTR
		anl a, #80h
		jnz BF
		mov DPTR, #7FF4h
		mov a, R4
		movx @DPTR, a
		reti
		
char:
		mov R0, a
		mov DPTR, #7FF6h
bf:
		movx a, @DPTR
		anl a, #80h
		jnz bf1
		mov DPTR, #7FF5h
		mov a, R4
		movx @DPTR, a
		ret
out:
		mov a, #38h
		acall com
		mov a, #0Ch
		acall com
		mov a, #06h
		acall com
		mov a, #02h
		acall com
		mov a, #01h
		acall com
		mov a, #31h
		acall char
		reti
		
		end