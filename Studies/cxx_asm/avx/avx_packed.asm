.const
align 16
SIGNFLIPMASK DWORD 80000000h, 80000000h, 80000000h, 80000000h
.data

.code

avx_packed_math proc 
	;	Example of SIMD packed math operation (all done in one instruction)
	;	---------------------------------------
	
	;	[float_01, float_02, float_03, float_04]
	;	[float_11, float_12, float_13, float_14]
	;	+_______________________________________
	;	[float_01 + float11, float_02 + float12, float_03 + float13, float_04 + float_14]

	; add packed single
	vaddps XMM2, XMM0, XMM1 ; XMM2 = XMM0 + XMM1
	vmovaps [R8], XMM2 ; c[0] = XMM2

	; sub packed single
	vsubps XMM2, XMM0, XMM1 ; XMM2 = XMM0 - XMM1
	vmovaps [R8 + 16], XMM2 ; c[1] = XMM2

	; multiply packed single
	vmulps XMM2, XMM0, XMM1 ; XMM2 = XMM0 * XMM1
	vmovaps [R8 + 32], XMM2 ; c[2]  XMM2

	; divide packed single
	vdivps XMM2, XMM0, XMM1 ; XMM2 = XMM0 / XMM1
	vmovaps [R8 + 48], XMM2 ; c[3] = XMM2

	; sqrt packed single
	vsqrtps XMM2, XMM1 ; XMM2 = sqrt(XMM1)
	vmovaps [R8 + 64], XMM2 ; c[4] = XMM2

	; flip sign packed single
	vxorps XMM2, XMM1, XMMWORD PTR[SIGNFLIPMASK] ; XMM2 = XMM1 ^  XMMWORD[80000000h, 80000000h, 80000000h, 80000000h]
	vmovaps [R8 + 80], XMM2 ; c[5] = XMM2

	; max packed single
	vmaxps XMM2, XMM1, XMM0 ; XMM2 = max(xmm1, xmm0)
	vmovaps [R8 + 96], XMM2 ; c[6] = XMM2

	; min packed single
	vminps XMM2, XMM1, XMM0 ; XMM2 = min(xmm1, xmm0)
	vmovaps [R8 + 112], XMM2 ; c[7] = XMM2

	ret
avx_packed_math endp

end