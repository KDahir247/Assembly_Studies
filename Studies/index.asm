includelib kernel32.lib

ExitProcess proto

.data
ARR QWORD 10, 20, 30
.code

_index proc

entry:
	xor RCX, RCX ; zeroing out RCX register. RCX bits are zero
	lea RSI, ARR ; store the address of ARR


start:
	mov RDX, [RSI + RCX * 8] ; getting the value from the address at RSI at offset RCX * 8 (QWORD = 8 bytes)
	inc RCX ; incrementing RCX register value
	cmp RCX, LENGTHOF ARR ; comparing RCX register with the length of the ARR which is 3
	jne start ; jump back to start label is RCX register is not equal to the length of ARR


CALL ExitProcess

_index endp

end