includelib kernel32.lib

ExitProcess proto

.data
ARR QWORD 0,0,0
CPY QWORD 3 DUP (0)

.code

_fill proc

entry:
	xor RCX, RCX ; zeroing out RCX register. RCX bits are zeroed
	lea RDI, ARR ; storing the address of ARR in RDI register
	
	mov RDX, 10 ; moving 10 to RDX register

start:
	mov [RDI + RCX * 8], RDX ; moving RDX register content to address at RDI with a offset of RCX * 8 (QWORD = 8 bytes)
	add RDX, 10 ; adding RDX with 10 and storing it back to RDX
	inc RCX ; incrementing RCX register and storing it back to RCX
	cmp RCX, LENGTHOF ARR ; comparing RCX with the length of ARR (3)
	jne start ; jumping back to start label if RCX is not equal to length of ARR (3)


	mov R10, ARR[0 * 8] ; moving ARR first element in R10 register
	mov R11, ARR[1 * 8] ; moving ARR second element in R11 register
	mov R12, ARR[2 * 8] ; moving ARR third element in R12 register

	lea RSI, ARR ; storing the address of ARR in RSI register
	lea RDI, CPY ; storing the address of CPY in RDI register
	mov RCX, LENGTHOF ARR ; moving lenght of ARR which is 3 to RCX
	cld ; clearing direction flag to ensure element will be incremented in memory not decremented 
	rep movsq ; repeat instruction count register time (RCX times). movsq will copy the value of RSI address and move them to RDI address value
	
	mov R10, CPY[0 * 8] ; move CPY first element in R10 register (10)
	mov R11, CPY[1 * 8] ; move CPY second element in R11 register (20)
	mov R12, CPY[2 * 8] ; move CPY third element in R12 register (30)


CALL ExitProcess

_fill endp

end