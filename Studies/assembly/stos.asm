includelib kernel32.lib

ExitProcess proto

.data
DST BYTE 3 DUP (?)

.code

_stos proc

entry:
	xor RAX, RAX ; zeroing out RAX register. RAX bits are zeroed
	xor RDX, RDX ; zeroing out RDX register. RDX bits are zeroed
	xor R8, R8 ; zeroing out R8 register. R8 bits are zeroed
	xor R9, R9 ; zeroing out R9 register. R9 bits are zeroed
	mov AL, 'A' ; moving ascii value of A (65) to the lower of the accumulator   
	lea RDI, DST ; loading the address to DST and storing it in RDI (destination index register)
	
	mov RCX, SIZEOF DST ; moving size of DST in this case (LENGHTOF * 1 (byte == 1)) to RCX register

	cld ; clear direction flag since we want to move forward in memory and not backward
	rep stosb ; repeat instruction using the counter register (RCX). stosb will use the accumulator and store one byte of content (that why we use AL) in the RDI register then increment

	mov DL, DST ; moving DST with the offset of 0 byte which is the first element on DST to DL
	mov R8B, DST[1] ; moving DST with the offset of 1 byte which is the second element on DST to R8B
	mov R9B, DST[2] ; moving DST with the offset of 2 byte which is the third element on DST to R9B

	; since we are storing AL in DST the DST will be 'A', 'A', 'A'


CALL ExitProcess

_stos endp

end