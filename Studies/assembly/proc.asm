includelib kernel32.lib

ExitProcess proto

.data

.code

; values in volatile register will not be automatically perserved on procedure call

zero_rax proc
entry:
	xor RAX, RAX ; zeroing out RAX register. RAX bits are zeroed
	ret ; return from where the procedure was called. pop the address off the stack and passes it to instruction pointer. Branches to resume normal program flow

zero_rax endp


_proc proc
	mov RAX, 5 ; move 5 to RAX register (accumalator)
	call zero_rax ; call procedure. pushes the address following the call instruction in the stack then branches to custom procedure.


call ExitProcess

_proc endp

end