.data

.code

count_char proc frame

; extern "C" long long count_char(const char* string, char locate_this);
; RCX = const char*
; RDX = char

prolog:
; We need RSI register as well for lodsb instruction 
	push RSI
	.pushreg RSI
	.endprolog


entry:
	mov RSI, RCX ; RSI = const char*
	xor R8, R8 ; R8 = 0
	xor RCX, RCX ; RCX = 0

	cld ; clear direction flag. incrementing string opertation instruction rather then possibility of decrementing (STD instruction will decrement string operation instruction)

loop_inner:
	lodsb ; load byte from RSI and then increment ESI register by 1, since the direction flag is set to zero prior (cld) otherwise decrement ESI register by 1
	test AL, AL ; AL & AL bitwise operation and set corresponding RFLAG then discard result
	jz epilog ; jmp to epilog if the zero flag is set
	cmp AL, DL ; cmp AL with locate_this 
	sete CL ; CL = (AL == DL) cast to int, so true : CL = 1 and false : CL  = 0
	add R8, RCX ; R8 = R8 + RCX (CL is the lower 8 bit of RCX)
	jmp loop_inner ; un-conditional jump back to loop_inner label

epilog:
	mov RAX, R8 ; RAX = R8

	; pop non-volitale register to restore data
	pop RSI
	ret
count_char endp

end