includelib kernel32.lib

ExitProcess proto

.data


; aligned
VAR DWORD 1, 2, 3, 4

A BYTE 20

ALIGN 16
VAR1 DWORD 5, 5, 5, 5

; unaligned
B WORD 13
VAR2 DWORD 2, 4, 6, 8

.code

main proc
	; there are timing differences due to "domain crossing penalties". 
	; For this reason, one should generally use movdqa when the data is being used with integer SSE instructions, and movaps when the data is being used with floating-point instructions

entry:
	movdqa XMM0, XMMWORD PTR [VAR] ; move VAR to XMM0 must be aligned.
	movdqa XMM1, XMMWORD PTR [VAR1] ; move VAR1 to XMM1 we use the align directive thus adding padding to be aligned.

	movdqu XMM2, XMMWORD PTR [VAR2] ; mov VAR2 to XMM2 we use the unaligned sse instruction.

	paddd XMM0, XMM1 ; packed add double sse instruction. add XMM0 register with XMM1 and store the result on XMM0 
	psubd XMM0, XMM2 ; packed sub double sse instruction. sub  XMM0 register with XMM1 and store the result on XMM0


CALL ExitProcess

main endp

end