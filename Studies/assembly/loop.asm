includelib kernel32.lib

ExitProcess proto

.data

.code

_loop proc

entry:
	xor RDX, RDX ; zeroing out RDX register. RDX bits are zerod
	mov RCX, 0 ; moving 0 to RCX register

; loops 3 time
start:
	mov RDX, RCX ; moving RCX register content to RDX register 
	inc RCX ; increment RCX register content by 1
	cmp RCX, 3 ; compare RCX register with 3
	je finish ; jump to finish label if RCX is equal to 3 
	jmp start ; uncondition jump to start label


finish:


CALL ExitProcess

_loop endp

end