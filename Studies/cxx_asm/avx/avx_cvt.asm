.data

.code


get_mxcsr_rounding proc 
	; extern "C" int get_mxcsr_rounding()

	VSTMXCSR DWORD PTR [RSP + 8] ; store the content of in the stack (DWORD since the MSXCSR register has 32 bits (DWORD))
	mov EAX, [RSP + 8] ; load the stored mxcsr value stored in stack to eax.
	shr EAX, 13 ; shift EAX right, since RCC start at bit 13 to 14 so we will shift out the rest of the mask, exception bit till RCC is the first bit and move result to EAX
	ret
get_mxcsr_rounding endp

set_msxcr_rounding proc
	; extern "C" void set_msxcr_rounding(unsigned int id)
	; rcx = id
	; remember (10b == round positive, 01b == round negative, 11b == round to zero, 00b round to nearest)

	shl ECX, 13 ; we shift left, so ecx (13) is in the same bit space as RCC (starting from 13 to 14 bit)
	vstmxcsr DWORD PTR [RSP + 8] ; store the content of in the stack (DWORD since the MSXCSR register has 32 bits (DWORD))
	mov EAX, [RSP + 8] ; load the stored mxcsr value stored in stack to eax.  
	or EAX, ECX ; or operation with ecx and eax 
	; Eg. EAX = (RCC ocupy 13 and 14 bit) 00000000000000000010000000000000 | (id shift left 13) 00000000000000000110000000000000 = 00000000000000000110000000000000 = round to zero


	mov [RSP + 8], eax ; store the result back to the stack
	vldmxcsr DWORD PTR [RSP + 8] ; load the source (32 bit) back to the MXSCR control/status register 

	ret
set_msxcr_rounding endp


convert_float_to_int proc
	; extern "C" bool convert_scalar(float* a, float* b, int op)
	movss XMM0, real4 ptr [RDX] ; XMM0 = (float*)b
	vcvtss2si EAX, XMM0 ; convert scalar single (f32) to a integer (dword).
	mov [RCX], EAX ; *rcx (*a) = eax (convert float to int)
	mov EAX, 1 ; move 1 to eax as return type for function to signify the the function succeded

	ret
convert_float_to_int endp

end