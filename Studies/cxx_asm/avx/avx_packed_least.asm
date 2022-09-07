.const 
	align 16
	abs_mask QWORD 7fffffffffffffffh, 7fffffffffffffffh
.data
	extern ls_epsilon:real8

.code

avx_calc_least_sqrs proc frame
	; extern "C" bool avx_calc_least_sqrs(const double* x, const double* y, int len, double* m, double* n);

	push RBP 
	.pushreg RBP
	mov RBP, RSP 
	and RSP, -16

	sub RSP, 30h ; 48

	.ENDPROLOG

	vmovapd REAL8 PTR [RBP - 16], XMM6
	vmovapd REAL8 PTR [RBP - 32], XMM7
	vmovapd REAL8 PTR [RBP - 48], XMM8

	xor RAX, RAX ; RAX = 0

	cmp R8D, 2 ; compare R8D(len) with 2
	jl epilog ; jump to epilog if less then 2

	test rcx, 0fh 
	jnz epilog

	test rdx, 0fh
	jnz epilog

	cvtsi2sd XMM2, R8D

	vxorpd XMM3, XMM3, XMM3 ; XMM3 = 0 (sum_x)
	vxorpd XMM4, XMM4, XMM4 ; XMM4 = 0 (sum_y)
	vxorpd XMM5, XMM5, XMM5 ; XMM5 = 0 (sum_xx)
	vxorpd XMM6, XMM6, XMM6 ; XMM6 = 0 (sum_xy)

inner_loop:
	vmovapd XMM0, XMMWORD PTR[RCX + RAX] ; XMM0 = x[0..2]
	vmovapd XMM1, XMMWORD PTR[RDX + RAX] ; XMM0 = y[0..2]

	vaddpd XMM3, XMM3, XMM0
	vaddpd XMM4, XMM4, XMM1
	
	vmulpd XMM8, XMM0, XMM0 ; x * x
	vaddpd XMM5,XMM5, XMM8

	vmulpd XMM8, XMM0, XMM1
	vaddpd XMM6, XMM6, XMM8

	add RAX, 16
	sub R8D, 2
	cmp R8D, 2                           
	jge inner_loop

	test R8D, R8D
	jz calc

unaligned:
	; do the non packed instruction for remaining element
	vmovsd XMM0, REAL8 PTR[RCX + RAX]
	vmovsd XMM1, REAL8 PTR[RDX + RAX]

	vaddsd XMM3, XMM3, XMM0
	vaddsd XMM4, XMM4, XMM1
	
	vmulsd XMM8, XMM0, XMM0 ; x * x
	vaddsd XMM5,XMM5, XMM8

	vmulsd XMM8, XMM0, XMM1
	vaddsd XMM6, XMM6, XMM8

	add RAX, 4
	dec R8D
	jnz unaligned

xor RAX, RAX


calc:
	vhaddpd XMM3, XMM3, XMM3 ;(sum_x) ; correct 455
	vhaddpd XMM4, XMM4, XMM4 ;(sum_y) ; correct 45.7999999999999999
	vhaddpd XMM5, XMM5, XMM5 ;(sum_xx) ; correct 31509
	vhaddpd XMM6, XMM6, XMM6 ;(sum_xy) ; correct 3204.5000000000000

	; denom calc
	vmulsd XMM8, XMM2, XMM5 ; XMM8 = n * sum_xx
	vmulsd XMM0, XMM3, XMM3 ; XMM0 = x * x
	vsubsd XMM8, XMM8, XMM0 ; XMM8 = (n * sum_xx) - (x * x)

	vandpd XMM8, XMM8, XMMWORD PTR [abs_mask]
	ucomisd XMM8, REAL8 PTR[ls_epsilon] ; 139,574
	jb below_val

	 vxorpd XMM1, XMM1, XMM1 ; XMM1 = 0
	 vxorpd XMM0, XMM0, XMM0 ; XMM0 = 0

	vmulsd XMM0, XMM2, XMM6
	vmulsd XMM1, XMM3, XMM4
	vsubsd XMM0, XMM0, XMM1
	vdivsd XMM0, XMM0, XMM8
	vmovsd REAL8 PTR[R9], XMM0


	vmulsd XMM0, XMM5, XMM4
	vmulsd XMM1, XMM3, XMM6
	vsubsd XMM0, XMM0, XMM1
	vdivsd XMM0, XMM0, XMM8
	vmovsd REAL8 PTR[RBP + 72], XMM0

	mov RAX, 1
	jmp epilog
	

	below_val:

	vxorpd XMM0, XMM0, XMM0

	vmovsd REAL8 PTR[R9], XMM0
	vmovsd REAL8 PTR[RBP + 72], XMM0


epilog:
	pop RBX

	movapd XMM6, REAL8 PTR [RBP - 16]
	movapd XMM7, REAL8 PTR [RBP - 32]
	movapd XMM8, REAL8 PTR [RBP - 48]

	leave
	ret
avx_calc_least_sqrs endp

end