includelib kernel32.lib

ExitProcess proto

.data
SRC BYTE 'abc'
FOUND BYTE 0

.code

_scas proc

entry:
	xor RAX, RAX ; zeroing out the RAX register. RAX bits are zeroed
	mov AL, 'b' ; move ascii value of b to AL
	mov RCX, SIZEOF SRC ; move size of SRC (LENGTH OF * how many bytes per elem) to RCX register (counter)

	lea RDI, SRC ; load address from SRC and store it in RDI (destination index)

	cld ; clear direction flag, since we want to move forward in memory and not backward
	repne scasb ; repeat until either RCX is zero or one of the element in SRC matches the AL (accumalator). scasb does a & on each elem with the accumalator and set the zero flag to true if identical otherwise it is false 

	jnz not_found ; jump to label not_found if the zero flag is false (0)

	mov FOUND, 1 ; if the jump condition hasn't been satisfied then we know that we did find a match with on of the element in SRC with AL accumalator register


not_found:


CALL ExitProcess

_scas endp

end