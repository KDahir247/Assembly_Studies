includelib kernel32.lib

ExitProcess proto

.data
CON EQU 12

.code

_equ proc
	xor RCX, RCX ; Zeroing out RCX registry
	xor RDX, RDX ; Zeroing out RDX registry

	mov RCX, CON ; Moving CON (12) to RCX registry. RCX has the value of CON
	mov RDX, CON + 8 ; RDX have should be 20
	mov RCX, CON + 8 * 2 ; RCX should have 28
	mov RDX, (CON + 8) * 2 ; RDX should have 40
	mov RCX, CON MOD 5 ; RDX ; RCX should have 2
	mov RDX, (CON - 3) / 3 ; RDX should have 3


CALL ExitProcess

_equ endp

end