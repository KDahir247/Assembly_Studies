includelib kernel32.lib

ExitProcess proto

.data
VAR WORD 256

.code

_stack proc
entry:
	mov RAX, 64 ; move 64 to the RAX register (accumalator).

	push RAX ; push rax register assigned value on the stack
	; RSP decreases by 8 bytes because it store the value in RAX register (64 bits register)

	mov RAX, 25 ; move 25 to the RAX register (accumalator)


	push VAR ; push VAR in the stack
	; RSP decreases by 2 bytes because it store VAR which is a WORD (16 bits)

	; Stack Order. VAR -> 64

	pop VAR ; pop the top of the stack into VAR
	; RSP increases by 2 bytes because it pop VAR of the stack (16 bits)

	pop R10 ; pop the top of the stack into R10 register. R10 register will have 64
	; RSP increases by 8 bytes because it pop the previous value from RAX register (64 bit accumalator)

CALL ExitProcess

_stack endp

end