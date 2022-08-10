includelib kernel32.lib

ExitProcess proto

.data
VAR DWORD 1, 2, 3, 4
VAR1 DWORD 1, 3, 5, 7
.code

main proc
entry:
	; there are timing differences due to "domain crossing penalties". 
	; For this reason, one should generally use movdqa when the data is being used with integer SSE instructions, and movaps when the data is being used with floating-point instructions


	movdqa XMM0, XMMWORD PTR [VAR] ; move VAR to XMM0. we must make VAR operand the same as xmm register thus XMMWORD PTR. note also that movdqa lhs operand must be a XMMWORD PTR type

	paddd XMM0, XMMWORD PTR [VAR1] ; packed add dword sse instruction add XMM0 register with VAR1 as a XMMWORD size and store the result back to XMM0 

CALL ExitProcess

main endp

end