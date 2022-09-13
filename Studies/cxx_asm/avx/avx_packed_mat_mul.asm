.const

.data

matrix4x4mul macro DISP

	vmovaps XMM5, XMMWORD PTR [RCX + DISP] 
	
	vmulps XMM0, XMM5, XMM4
	vhaddps XMM0, XMM0, XMM0
	vhaddps XMM7, XMM0, XMM0

	vmulps XMM0, XMM5, XMM6
	vhaddps XMM0, XMM0, XMM0
	vhaddps XMM0, XMM0, XMM0

	unpcklps XMM7, XMM0


	vmulps XMM0, XMM5, XMM2
	vhaddps XMM0, XMM0, XMM0
	vhaddps XMM8, XMM0, XMM0

	vmulps XMM0, XMM5, XMM1
	vhaddps XMM0, XMM0, XMM0
	vhaddps XMM0, XMM0, XMM0

	unpcklps XMM8, XMM0
	

	movlhps XMM7, XMM8
	vmovaps [R8 + DISP], XMM7
endm

.code

matrix_mul proc frame
	; extern "C" void matrix_mul(const float* mat_1, const float* mat_2, float* mat_res);
	; RCX = mat_1, RDX = mat_2,	R8 = mat_res

	; What i need to do is transpose the second matrix 
	; then what i can do is 

	push RBP
	.pushreg RBP
	mov RBP, RSP
	and RSP, -16

	sub RSP, 48
	.endprolog

	; xor EAX, EAX

	vmovaps REAL4 PTR [RBP - 16], XMM6
	vmovaps REAL4 PTR [RBP - 32], XMM7
	vmovaps REAL4 PTR [RBP - 48], XMM8

	vmovaps XMM1, XMMWORD PTR [RDX] ; row 1
	vmovaps XMM2, XMMWORD PTR [RDX + 16]
	vmovaps XMM3, XMMWORD PTR [RDX + 32]
	vmovaps XMM4, XMMWORD PTR [RDX + 48]


	vshufps XMM5, XMM1, XMM2, 01000100b
	vshufps XMM2, XMM1, XMM2, 11101110b  
	
	vshufps XMM1, XMM3, XMM4, 01000100b
	vshufps XMM3, XMM3, XMM4, 11101110b 

	
	vshufps XMM6, XMM5, XMM1, 11011101b ; mat_1 column 1
	vshufps XMM4, XMM5, XMM1,10001000b  ; mat_1 column 0

	vshufps XMM1, XMM2, XMM3, 11011101b  ; mat_1 column 3
	vshufps XMM2, XMM2, XMM3, 10001000b ; mat_1 column 2

	matrix4x4mul 0
	matrix4x4mul 16
	matrix4x4mul 32
	matrix4x4mul 48

	vmovaps XMM6, REAL4 PTR [RBP -16]
	vmovaps XMM7, REAL4 PTR [RBP -32]
	vmovaps XMM8, REAL4 PTR [RBP - 48]

	leave
	ret
matrix_mul endp

end