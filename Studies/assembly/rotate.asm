includelib kernel32.lib

ExitProcess proto

.data

.code

_rotate proc
	xor RCX, RCX ; zeroing out RCX registry. RCX's bits are all zeroed out.

	mov CL, 65 ; move 65 to the low ECX byte
	mov CH, 90 ; move 90 to the high ECX byte

	rol CX, 8 ; shift each bit in CX registry by 8 to the left and move all bit and fill them to the right.
	rol CX, 8 ; shift each bit in CX registry by 8 to the left and move all bit and fill them to the right.

	shr CX, 8 ; shift each bit in CX registry by 8 to the right and move all bit and fill them to the left with the rotate carry flag.

CALL ExitProcess

_rotate endp

end