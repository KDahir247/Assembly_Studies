includelib kernel32.lib

ExitProcess proto

.data

.code

_idiv proc
	xor RAX, RAX ; zeroing out RAX registry bits, RAX registry bits are all zero
	xor RBX, RBX ; zeroing out RBX registry bits, RBX registry bits are all zero
	xor RDX, RDX ; zeroing out RDX registry bits, RDX registry bits are all zero

	mov RAX, 100 ; moving 100 to the RAX registry. RAX is now 100
	mov RBX, 3 ; moving 3 to the RBX registry. RBX is now 3
	idiv RBX ;
	mov RAX, -100
	CQO
	idiv RBX


CALL ExitProcess

_idiv endp

end