.data

.code

calc_matrix_squares proc frame
	; extern "C" void calc_matrix_squares(float* y, const float* x, float offset, int nrows, int ncols);
	
	; push non-volatile register
prolog:
	push RSI
	.pushreg RSI
	push RDI
	.pushreg RDI
	.endprolog

	cmp R9D, 0 ; compare R9D (nrows) with 0
	jle epilog ; jump to epilog label if (nrows <= 0) otherwise continue

	mov R10D, DWORD PTR [RSP + 56] ; R10D = ncols

	cmp R10D, 0 ; compare R10D (ncols) with 0
	jle epilog ; jump to epilog label if (ncols <= 0) otherwise continue


	mov RDI, RCX ; RDI = y
	mov RSI, RDX ; RSI = x

	xor RAX, RAX ; RAX = 0

outer_loop:
	; RAX for i
		xor RCX, RCX ; RCX = 0


	inner_loop:
	; RCX for j

	mov RDX, RCX ; RDX = j
	imul EDX, R10D ; EDX = EDX(j) * ncols
	add EDX, EAX ; EDX = EDX (j * ncols) + i

	movss XMM0, REAL4 PTR [RSI + RDX * 4] ; XMM0 = x[j * ncols + i]
	vmulss XMM0, XMM0, XMM0 ; XMM0 = x[j * ncols + i] * x[j * ncols + i]
	vaddss XMM0, XMM0, XMM2 ; XMM0 = x[j * ncols + i] * x[j * ncols + i] + offset

	mov RDX, RAX ; RDX = i
	imul EDX, R10D ; EDX = EDX(i) * ncols
	add EDX, ECX ; EDX = EDX(i * ncols) + j


	movss REAL4 PTR [RDI + RDX * 4], XMM0 ; y[i * ncols + j] = XMM0(x[j * ncols + i] * x[j * ncols + i] + offset)


	inc ECX ; ECX = ECX + 1. Increment j index for loop (inner loop)
	cmp ECX, R10D ; cmp ECX(j) with ncols
	jl inner_loop ; if ECX(j) < ncols then go back to inner_loop label

	inc EAX ; EAX = EAX + 1. increment ik index for loop (outer loop)
	cmp EAX, R9D ; cmp EAX(i) with nrows 
	jl outer_loop ; if EAX(i) < nrows then go back to outer_loop label



epilog:
	; pop non-volitale register to restore data
	pop RDI
	pop RSI
	ret

calc_matrix_squares endp

end