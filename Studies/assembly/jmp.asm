includelib kernel32.lib

ExitProcess proto

.data

.code

_jump proc
	xor R14, R14 ; zeroing out R14 registry. R14 bit are set to zero
	xor R15, R15 ; zeroing out R15 registry. R15 bit are set to zero
	jmp next ; unconditional jump to next
	mov R14, 100 ; ignored

next:
	mov R15, final ; move the final instruction address to R15 registry
	jmp R15 ; jump using the instruction stored in R15 registry
	mov R14, 100

final:  ; RIP is the same as R15 right here.
	xor R14, R14 ; zeroing out R14 registry. R14 bit are set to zero
	xor R15, R15 ; zeroing out R15 registry. R15 bit are set to zero

CALL ExitProcess

_jump endp

end