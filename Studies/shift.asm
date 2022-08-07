includelib kernel32.lib

ExitProcess proto

.data
UNUM BYTE 10011001b
SNEG SBYTE 10011001b
SNUM SBYTE 00110011b

.code

_shift proc
	xor RCX, RCX
	xor RDX, RDX
	xor R8, R8

	mov CL, UNUM
	mov DL, SNEG
	mov R8B, SNUM

	shr CL, 2
	sar DL, 2
	sar R8, 2


CALL ExitProcess

_shift endp

end