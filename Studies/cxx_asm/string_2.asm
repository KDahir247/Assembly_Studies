.data

.code

cmp_array proc frame
	; extern "C" long long cmp_array(const int* a, const int* b, long long len);
	; RCX = const int*, RDX = const* b, R8 = len

prolog:
	; push non-volitale register to stack to persevere the old data
	push RSI
	.pushreg RSI
	push RDI
	.pushreg RDI
	.endprolog

entry:	
	; we need to check if len is valid
	cmp r8, 0 ; compare r8 with 0
	jle epilog ; jump to epilog if r8 <= 0 otherwise skip instruction


	mov RSI, RCX ; RSI = a
	mov RDI, RDX ; RDI = b

	cld ; clear direction flag increments rather then decrement R(S:D)I. used by string operation instruction.

	mov RCX, R8 ; RCX = len
	mov RAX, R8 ; RCX = len
	repe cmpsd ; repeating compare RDI and RSI elements and stop repeating if they are not equal. The repcc decrement counter register if counter register is zero it will also stop repeating.
	jz epilog ; jump epilog label if counter register (RCX) is zero and the zero flag is set (exactly same jecxz in this solution)

	sub EAX, ECX ; EAX = EAX - ECX
				 ; EAX = len - (len - how many repe decremented RCX)
				 ; Eg x = [1, 2, 3, 4]; y = [1, 3, 3, 4];
				 ; EAX = 4 - 2

	sub EAX, 1 ; EAX = EAX - 1 
			   ; we need to make it zero base rather then 1 base, since array are zero based not one based

epilog:
	; pop non-volitale register to restore data
	pop RDI
	pop RSI
	ret
cmp_array endp

end