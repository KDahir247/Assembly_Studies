.const

.data


.code
avx_packed_add_i16 proc 
	;extern "C" void avx_packed_add_i16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
	; RCX = a, RDX = b, R8 = c

	vmovdqa XMM0, XMMWORD PTR [RCX]
	vmovdqa XMM1, XMMWORD PTR [RDX]

	vpaddw XMM2, XMM0, XMM1
	vpaddsw XMM3, XMM0, XMM1

	vmovdqa XMMWORD PTR [R8], XMM2
	vmovdqa XMMWORD PTR [R8 + 16], XMM3
	ret
avx_packed_add_i16 endp



avx_packed_sub_i16 proc 
	;extern "C" void avx_packed_sub_i16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
	; RCX = a, RDX = b, R8 = c

	vmovdqa XMM0, XMMWORD PTR [RCX]
	vmovdqa XMM1, XMMWORD PTR [RDX]

	vpsubw XMM2, XMM0, XMM1
	vpsubsw XMM3, XMM0, XMM1


	vmovdqa XMMWORD PTR [R8], XMM2
	vmovdqa XMMWORD PTR [R8 + 16], XMM3

	ret
avx_packed_sub_i16 endp


avx_packed_add_u16 proc 
	;extern "C" void avx_packed_add_u16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
	; RCX = a, RDX = b, R8 = c

	vmovdqa XMM0, XMMWORD PTR [RCX]
	vmovdqa XMM1, XMMWORD PTR [RDX]

	vpaddw XMM2, XMM0, XMM1
	vpaddsw XMM3, XMM0, XMM1

	vmovdqa XMMWORD PTR [R8], XMM2
	vmovdqa XMMWORD PTR [R8 + 16], XMM3

	ret
avx_packed_add_u16 endp

avx_packed_sub_u16 proc 
	;extern "C" void avx_packed_sub_u16(const XMMValue & a, const XMMValue & b, XMMValue c[2]);
	; RCX = a, RDX = b, R8 = c

	vmovdqa XMM0, XMMWORD PTR [RCX]
	vmovdqa XMM1, XMMWORD PTR [RDX]

	vpsubw XMM2, XMM0, XMM1
	vpsubsw XMM3, XMM0, XMM1

	vmovdqa XMMWORD PTR [R8], XMM2
	vmovdqa XMMWORD PTR [R8 + 16], XMM3

	ret
avx_packed_sub_u16 endp

end