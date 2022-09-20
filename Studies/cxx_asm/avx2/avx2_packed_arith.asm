.const
neg_mask_f32 dword 8 dup(80000000h)

.data


.code
avx_pck_math_f32 proc 
	; c  will store; add, sub, mul, div, flip, sqrt, min, max
	; extern "C" void avx_pck_math_f32(const YMMValue & a, const YMMValue & b, YMMValue c[8]);
	; RCX = a, RDX = b, R8 = c
	vmovaps YMM0, YMMWORD PTR [RCX]
	vmovaps YMM1, YMMWORD PTR [RDX]

	; add
	vaddps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8], YMM2

	; sub
	vsubps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8 + 32], YMM2

	; mul
	vmulps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8 + 64], YMM2


	; div
	vdivps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8 + 96], YMM2


	; flip first
	vxorps YMM2, YMM0, YMMWORD PTR[neg_mask_f32]
	vmovaps YMMWORD PTR [R8 + 128], YMM2


	; sqrt
	vsqrtps YMM2, YMM0
	vmovaps YMMWORD PTR [R8 + 160], YMM2

	; min
	vminps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8 + 192], YMM2

	; max
	vmaxps YMM2, YMM0, YMM1
	vmovaps YMMWORD PTR [R8 + 224], YMM2


	ret
avx_pck_math_f32 endp

end 
