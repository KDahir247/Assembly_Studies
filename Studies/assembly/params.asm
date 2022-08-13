includelib kernel32.lib

ExitProcess proto

.data

.code

max proc

; stack so far [rsp] = address following the call instruction in main proc
;			   [rsp + 8] = 500
;			   [rsp + 16] = 100

entry:
	mov RCX, [RSP + 16] ; move the value from the stack with offset of 16 bytes to RCX register (counter register)
	mov RDX, [RSP + 8] ; move the value from the stack with offset of 8 byte to RDX register
	cmp RCX, RDX ; compare RCX register  with RDX register
	jg large ; jump cmp resulted in RCX register value > RDX register value
	
	mov RAX, RDX ; move RDX register value to RAX register (accumalator). Note RAX is always used as the return.

	jmp finish ; uncoditional jump to finish label

large:
	mov RAX, RCX ; move RCX register value to RAX register (accumalator)



finish:
	ret ; return from where the procedure was called. pop the address off the stack and passes it to instruction pointer

max endp


main proc

entry:
	xor RAX, RAX ; zeroing out RAX register (accumalator). RAX bits are zeroed
	push 100 ; pushes 100 to the stack 
	push 500 ; pushes 500 to the stack

	; stack so far [rsp] == 500
	;			   [rsp + 8] = 100

	call max ; pushes the address following the call instruction

	add rsp, 16 ; rebalancing stack. similar to pop instruction without mov data from [rsp] to target register

CALL ExitProcess

main endp

end