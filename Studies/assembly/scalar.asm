includelib kernel32.lib

ExitProcess proto

.data
VAR REAL4 12.0
VAR1 REAL4 3.5

.code

main proc
entry:
	movss XMM0, VAR ; move value of VAR (12.0 float 32)  to the lowest 32 bit of XMM0 register
	movss XMM1, VAR1 ; move value of VAR1 (3.5 float 32) to the lowest 32 bit of XMM1 register

	addss XMM0, XMM1 ; add the lowest 32 bit of both XMM0 and XMM1 registers and store the result back to XMM0 register
	mulss XMM0, XMM1 ; multiply the lowest 32 bit of both XMM0 and XMM1 registers and store the result back to XMM0 register

	subss XMM0, XMM1 ; subtract the lowest 32 bit of both XMM0 and XMM1 registers and store the result back to XMM0 register
	divss XMM0, XMM1 ; divide the lowest 32 bit of both XMM0 and XMM1 registers and store the result back to XMM0 register

CALL ExitProcess

main endp

end