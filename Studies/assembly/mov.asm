includelib kernel32.lib

ExitProcess proto

.data
VAR QWORD 100 ;We are initalizing a variable to 100. 64 bit 

.code

_temp proc

	xor RCX, RCX ; zeroing out the RCX register
	xor RDX, RDX ; zeroing out the RDX register

	mov RCX, 33 ; moving 33 to the RCX register. RCX has 33 now
	mov RDX, RCX ; moving the content in the RCX register to the RDX

	mov RCX, VAR ; moving VAR (100) to the RCX registry

	mov VAR, RDX ; moving RDX (33) to VAR


CALL ExitProcess

_temp endp

end