.const

.data


.code
avx_packed_muli16 proc 
	; extern "C" void avx_packed_muli16(XMMValue c[2], const XMMValue * a, const XMMValue * b);
	; RCX = c, RDX = a, R8 = b
	vmovdqa XMM0, XMMWORD PTR [RDX]
	vmovdqa XMM1, XMMWORD PTR [R8]

	vpmulhw XMM2, XMM0, XMM1
	vpmullw XMM3, XMM0, XMM1

	vmovdqa XMMWORD PTR [RCX], XMM3
	vmovdqa XMMWORD PTR [RCX + 16], XMM2

	ret

avx_packed_muli16 endp

avx_packed_muli32 proc
	; extern "C" void avx_packed_muli32(XMMValue * c, const XMMValue * a, const XMMValue * b);
	; RCX = c, RDX = a, R8 = b
	vmovdqa XMM0, XMMWORD PTR [RDX]
	vmovdqa XMM1, XMMWORD PTR [R8]

	vpmulld XMM2, XMM0, XMM1

	vmovdqa XMMWORD PTR [RCX], XMM2


	ret
avx_packed_muli32 endp


end 
