.data

.code

calc_standard_deviation proc
	; extern "C" bool calc_standard_deviation(double* mean, double* standard_deviation, const double* x, int len);
	; RCX = mean, RDX = standard_deviation, R8 = x, R9 = len

	xor RAX, RAX ; RAX = 0
	cmp R9D, 0 ; compare len with 0
	jle epilog ; jump to label epilog if len <= 0 otherwise continue

	xorpd XMM0, XMM0 ; zeroing out XMM0 register. 
@@:
	vaddsd XMM0, XMM0, real8 ptr[R8 + RAX * 8]; XMM0 += x[i] where I goes from 0 to len
	inc EAX ; increment i
	cmp EAX, R9D ; compare EAX (i) to len
	jl @B ; jump back to the upper @@ label if i < len


	cvtsi2sd XMM1, R9D ; convert len from int to double and store it in XMM1

	vdivsd XMM0, XMM0, XMM1 ; XMM0 = (sum of all x[i]) / len

	movsd REAL8 PTR [RCX], XMM0 ; *mean = XMM0 ((sum of all x[i]) / len)

	movsd XMM3, XMM0 ; XMM3 = mean ((sum of all x[i]) / len)
	xorpd XMM0, XMM0 ; zeroing out XMM0 register. 


	; we know that RCX = len so we can do a loop decrement to zero.
@@:
	dec EAX ; EAX = EAX - 1
	vmovsd XMM2, REAL8 PTR [R8 + RAX * 8] ; XMM2 = x[i] where I goes from n to 0
	vsubsd XMM4, XMM2, XMM3 ; XMM4 = x[i] - mean ((sum of all x[i]) / len)
	vmulsd XMM4, XMM4, XMM4 ; XMM4 = (x[i] - mean) * (x[i] - mean)
	vaddsd XMM0, XMM0, XMM4 ; XMM0 = XMM0 + ((x[i] - mean) * (x[i] - mean))
	jnz @B ; jump back to the recent upper @@ label if i != 0 otherwise continue

	dec R9D ; R8D = len - 1

	cvtsi2sd XMM1, R9D ; convert (len - 1) from int to double

	vdivsd XMM0, XMM0, XMM1 ; XMM0 = XMM0 / (len - 1)

	sqrtsd XMM0, XMM0 ; sqrt(XMM0)

	movsd REAL8 PTR[RDX], XMM0 ; *standard_deviation = XMM0

	mov RAX, 1

epilog:
	ret

calc_standard_deviation endp

end