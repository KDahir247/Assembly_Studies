includelib kernel32.lib

ExitProcess proto

.data
	VAR QWORD 2
.code

_muldiv proc
	xor RDX, RDX ; zeroing out the RDX registry. The RDX registry bits will be zeroed out.
	mov RAX, 10 ; we are moving 10 to the RAX registry. RAX will have 10 
	mov RBX, 5 ; we are moving 5 to the RBX registry. RBX will have 5

	mul RBX ; we are multiplying RAX with RBX we will store the upper half in RDX and the lower back into RAX
	mul VAR ; we are multiplying RAX with VAR we will store the upper half in RDX and the lower back into RAX

	mov RBX, 8 ; we are moving 8 to the RBX registry. RBX will have 8
	div RBX ;  we are dividing RAX with RBX we will store the quotent in RAX and the remainder in RDX

CALL ExitProcess

_muldiv endp

end