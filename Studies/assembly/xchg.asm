includelib kernel32.lib

ExitProcess proto

.data
VAR DQ ?

.code

_xchg proc

	xor RCX, RCX ; zeroing out the RCX registry
	xor RDX, RDX ; zeroing out the RDX registry

	mov RCX, 5 ; moving 5 to the RCX registry
	xchg RCX, VAR ; swapping the src and dst of xchg 
	; VAR is 5 and RCX is zero
	
	mov DL, 3 ; moving 3 to the lower half of RDX registry
	xchg DH, DL ; swapping lower half of RDX registry with the upper half
	; the higher bits of RDX is 3 while the lower will be zero

CALL ExitProcess

_xchg endp

end