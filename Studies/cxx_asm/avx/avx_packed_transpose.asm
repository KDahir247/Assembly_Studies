.const

.data

.code

transpose proc frame
	
	push RBP
	.pushreg RBP
	mov RBP, RSP
	and RSP, -16

	sub RSP, 30h

	.ENDPROLOG


	vmovaps REAL4 PTR [RBP - 16], XMM6
	vmovaps REAL4 PTR [RBP - 32], XMM7
	vmovaps REAL4 PTR [RBP - 48], XMM8


	vmovaps XMM0, XMMWORD PTR[RCX] ; row 1		[1,  2,  3,	  4 ]
	vmovaps XMM1, XMMWORD PTR[RCX + 16] ; row 2	[5,  6,  7,   8 ]
	vmovaps XMM2, XMMWORD PTR[RCX + 32] ; row 3	[9,  10, 11,  12]
	vmovaps XMM3, XMMWORD PTR[RCX + 48] ; row 4	[13, 14, 15,  16]

	
	vshufps XMM4, XMM0, XMM1, 01000100b ; 1,  2,  5,  6
	vshufps XMM5, XMM2, XMM3, 01000100b ; 9,  10, 13, 14
	vshufps XMM6, XMM0, XMM1, 11101110b ; 3,  4,  7,  8
	vshufps XMM7, XMM2, XMM3, 11101110b ; 11, 12, 15, 16

	
	vshufps XMM8, XMM4, XMM5, 10001000b ; 1, 5, 9, 13
	vshufps XMM5, XMM4, XMM5, 11011101b ; 2, 6, 10, 14
	vshufps XMM4, XMM6, XMM7, 10001000b ; 3, 7, 11, 15
	vshufps XMM3, XMM6, XMM7, 11011101b ; 4, 8, 12, 16

	vmovaps [RDX], XMM8
	vmovaps [RDX + 16], XMM5
	vmovaps [RDX + 32], XMM4
	vmovaps [RDX + 48], XMM3


	vmovaps XMM6, REAL4 PTR [RBP - 16]
	vmovaps XMM7, REAL4 PTR [RBP - 32]
	vmovaps XMM8, REAL4 PTR [RBP - 48]


	leave

	ret
transpose endp

end