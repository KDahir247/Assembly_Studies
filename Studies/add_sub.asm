includelib kernel32.lib

ExitProcess proto

.data
VAR DQ 64

.code

_add_sub proc
	xor RCX, RCX ; zeroing out the RCX registry
	xor RDX, RDX ; zeroing out the RDX registry

	mov RCX, 36 ; moving 36 to RCX registry. RCX now has 36
	add RCX, VAR ; moving the result of RCX + VAR to the RCX registry 64 + 36 == 100
	; RCX registry is 100 

	mov RDX, 400 ; moving 400 to the RDX registry. RDX now has 400
	add RDX, RCX ; moving the result of RDX + RCX to the RDX registry  400 + 100 == 500
	; RDX registry is 500

	sub RCX, 100 ; moving the result of RCX - 100 to the RCX registry 100 - 100 == 0
	; RCX registry is 0


CALL ExitProcess

_add_sub endp

end