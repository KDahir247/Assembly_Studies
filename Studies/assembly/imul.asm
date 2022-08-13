includelib kernel32.lib

ExitProcess proto

.data
	VAR QWORD 4

.code

_imul proc
	xor RAX, RAX ; zeroing out the RAX registry. RAX's bits will be 0
	xor RBX, RBX ; zeroing out the RBX registry. RBX's bits will be 0

	mov RAX, 10 ; moving 10 to the RAX registry. RAX will be 10
	mov RBX, 2 ; moving 2 to the RBX registry. RBX will be 2
	
	imul RBX ; signed multiplying RAX content wil RBX content and storing it in the RAX registry
	imul RAX, VAR ; signed multiplying RAX with VAR and storinbg it in the RAX registry (imul multiplicand, multiplier)
	imul RAX, RBX, -3 ; signed multiplying RBX with -3 and storing it in the RAX registry (imul destination, multiplicand, multiplier)


CALL ExitProcess

_imul endp

end