includelib kernel32.lib

ExitProcess proto

.data

.code

total proc
entry:
	push RBP ; push the base pointer

	; stack so far 
	; base pointer [RSP]
	; address folloing call instuction in main [RSP + 8]
	; the pushed value 100 [RSP + 16]

	mov RBP, RSP ; saves the previous top of the stack to rbp

	sub RSP, 16 ; claim 16 bytes in the stack

	mov RAX, [RBP + 16] ; move the value stored in RBP with offset of 16 (100) to RAX 

	mov [RBP - 8], RAX ; move the value of RAX in the claimed byte space in the stack
	mov [RBP - 16], RAX ; move the value of RAX in the claimed byte space in the stack

	add RAX, [RBP - 8] ; add RAX with the claimed stack space at offset 8 and store it back to RAX register (accumalator)
	add RAX, [RBP - 16] ; add RAX with the claimed stack space at offset 16 and store it back to RAX register (accumalator)

	leave ; set rsp to rbp and pop rbp

	ret

total endp

_frame proc
entry:
	xor RAX, RAX ; zeroing out RAX register (accumalator). RAX bits are zeroed
	push 100 ; push 100 to the top of the stack
	call total ; pushes the address following this call instruction
	add RSP, 8 ; rebalance stack

CALL ExitProcess

_frame endp

end 