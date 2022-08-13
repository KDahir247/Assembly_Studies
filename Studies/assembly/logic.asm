includelib kernel32.lib

ExitProcess proto

.data

.code

_logic proc
	xor RCX, RCX ; zeroing out RCX registry.
	xor RDX, RDX ; zeroing out RDX registry

	mov RCX, 0101b ; move 5 to the RCX registry
	mov RDX, 0011b ; move 3 to the RDX registry

	xor RCX, RDX ; xor RCX and RDX registry together which will result in 0110b (6) and store it in RCX registry
	and RCX, RDX ; and RCX and RDX registry together (0110b & 0011b) which will result in 0010b (2) and store it in RCX registry
	or RCX, RDX ; or RCX and RDX registry together (0010b | 0011b) which will result in 0011b (3) and store it in RCX registry


CALL ExitProcess

_logic endp

end