.data

.code

avx_packed_convert_fp proc 
	; extern "C" bool avx_packed_convert_fp(const XMMValue & first, XMMValue & second, unsigned int type);
	; XMM0 = first, XMM1 = second, RDX = type

	xor RAX, RAX ; RAX = 0

	; we don't need to test for less then zero, since it is a unsigned type.
	cmp R8D, 1 ; compare unsigned int type with 1

	jg epilog ; jump to epilog label if  type > 1 otherwise continue

	mov RAX, 1 ; RAX = 1 , since we know the conversion int type is valid.
	; RAX is the return type of a function so we want the bool for the function to return true.

	test R8D, R8D ; Do an AND operation on src and dst and set RFlag and then discard the result.
	jz float_int ; jump to float_int label if zero flag is set otherwise continue


int_float:
	vcvtdq2ps XMM1, XMM0 ; convert double word (i32) to packed single (f32)
	vmovaps XMMWORD PTR [RDX], XMM1 ; move XMM1 to a pointer to RDX that is interperted as a XMMWORD.
									; the mnemonic (aps) signifies that we are moving an aligned (16 bytes) packed single (f32) to src from dst
	ret ; exit assembly procedure


float_int:
	vcvtps2dq XMM1, XMM0 ; convert packed single (f32) to double word (i32)
	vmovdqa XMMWORD PTR [RDX], XMM1 ; move XMM1 to a pointer to RDX that is interperted as a XMMWORD.
									; the mnemonic (dqa) signifies that we are moving and aligned (16 bytes) double word (i32) to src from dstr

epilog:
	ret
avx_packed_convert_fp endp

end