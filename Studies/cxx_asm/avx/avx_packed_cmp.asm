.data

.code

avx_compare_f32 proc 
	; using Pseudo-Op compare
	; Will return 0xFFFFFFFFFFFFFFFF if the condition is true otherwise 0x0000000000000000

	; Packed compare equal
	; vcmpps XMM2, XMM0, XMM1, 0
	vcmpeqps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8], XMM2

	; Packed compare less then
	; vcmpps XMM2, XMM0, XMM1, 1
	vcmpltps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [R8 + 16], XMM2

	; Packed compare less then or equal
	; vcmpps XMM2, XMM0, XMM1, 2
	vcmpleps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 32], XMM2

	; Packed compare unordered
	; vcmpps XMM2, XMM0, XMM1, 3
	vcmpunordps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 48], XMM2

	; Packed compare not equal
	; vcmpps XMM2, XMM0, XMM1, 4
	vcmpneqps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 64], XMM2

	; Packed compare greater then
	; vcmpss XMM2, XMM0, XMM1, 5
	vcmpnltps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 80], XMM2

	; Packed compare greater then or equal
	; vcmpss XMM2, XMM0, XMM1, 6
	vcmpnleps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 96], XMM2

	; Packed compare ordered
	; vcmpss XMM2, XMM0, XMM1, 7
	vcmpordps XMM2, XMM0, XMM1
	vmovdqa XMMWORD PTR [r8 + 112], XMM2

	ret
avx_compare_f32 endp

end