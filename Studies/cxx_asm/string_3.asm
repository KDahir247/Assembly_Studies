.data

.code

; not really performant, since we are doing a cld and std every loop and this goes array lenght times, but solution works :).

reverse_array proc frame
	;extern "C" int reverse_array(int* dst, const int* src, int len);
	; RCX = dst (int* dst), RDX = src (const int*), R8 = len 

prolog:
	; push non-volitale register to stack to persevere the old data
	push RSI
	.pushreg RSI
	push RDI
	.pushreg RDI
	.endprolog

	xor RAX, RAX
	cmp R8, 0
	jle epilog

	xor R9, R9 ; R9 = 0

	mov R9, R8 ; R8 = len
	sub R9, 1 ; R8 = len - 1, since array is 0 based and not 1 based
	imul R9, 4 ; R8 = R8(len - 1)  * 4. int is 4 bytes

	add RDX, R9 ; we add the offset to RDX. now RDX will be at the end of the array rather then the beginning

	mov RSI, RDX ; RSI = RDX (end of the array of src)
	mov RDI, RCX ; RDI = RCX (start of the array of dst)

	mov RCX, R8 ; RCX = len

inner_loop:
	std ; set direction flag so string operation will decrement rather then increment
	lodsd ; load RSI at the end of the array in the start and save it to RAX register then decrement RSI by SIZEOF DWORD (4 bytes) each time  
		  ; E.G RAX = src[4], RAX = src[3], RAX = src[2], RAX = src[1], RAX = src[0]

	cld ; clear direction flag so string operation will increment rather then decrement
	stosd ; store RAX register value in the start of the array in the start in the start then increment RDI by SIZEOF DWORD (4 bytes ) each time 
		  ; E.G dst[0] = RAX, dst[1] = RAX, dst[2] = RAX, dst[3] = RAX, dst[4] = RAX

	dec RCX ; RCX = RCX - 1
	jnz inner_loop ; jump to inner_loop if the zero flag is not set. It will set when RCX reaches 0

	mov RAX, 1

epilog:
	; pop non-volitale register to restore data
	pop RDI
	pop RSI
	ret
reverse_array endp

end