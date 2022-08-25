.data

.code


compare_single proc 
	; extern "C" void compare_single(float a, float b, bool* res);
	; R8 = res

	xor AL, AL	; AL (lower 8 bits of RAX) = 0
	; for compare double switch comiss (mnemonic ss (scalar single)) to comisd (mnemonics sd (scalar double))
	comiss XMM0, XMM1 ; compare lower single of XMM0, XMM1 and set RFLAGS

	; FP compares set PF when the result is unordered. (One or both operands are NaN)
	setp BYTE PTR [r8] ; set BYTE PTR [r8] (res[0]) = 1 if parity flag is set otherwise 0
	jpe @F ; jump to the closes @@ downward if the parity flag is even.
	
	setb BYTE PTR [R8 + 1] ; set BYTE PTR[R8 + 1] (res[1]) = 1 if XMM0 < XMM1 otherwise 0
	setbe BYTE PTR [R8 + 2] ; set BYTE PTR[R8 + 2] (res[2]) = 1 if XMM0 <= XMM1 otherwise 0
	sete BYTE PTR [R8 + 3] ; set BYTE PTR[R8 + 3] (res[3]) = 1 if XMM0 == XMM1 otherwise 0
	setne BYTE PTR [R8 + 4] ; set BYTE PTR[R8 + 4] (res[4]) = 1 if XMM0 != XMM1 otherwise 0
	seta BYTE PTR [R8 + 5] ; set BYTE PTR[R8 + 5] (res[5]) = 1 if XMM0 > XMM1 otherwise 0
	setae BYTE PTR [R8 + 6] ; set BYTE PTR[R8 + 6] (res[6]) = 1 if XMM0 >= XMM1 otherwise 0

	jmp epilog ; unconditional jump to epilog label

@@:
	; instruction calls when cmp result is unordered. (One or both operands are NaN)
	mov [R8 + 1], AL ; res[1] = 0
	mov [R8 + 2], AL ; res[2] = 0
	mov [R8 + 3], AL ; res[3] = 0
	mov [R8 + 4], AL ; res[4] = 0
	mov [R8 + 5], AL ; res[5] = 0
	mov [R8 + 6], AL ; res[6] = 0

epilog:
	
	ret
compare_single endp


end