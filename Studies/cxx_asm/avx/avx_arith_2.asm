.data

.code


calc_distance proc 
	; extern "C" double calc_distance(double x2, double y2, double z2, double x1, double y1, double z1);
	; XMM0 = x2, XMM1 = y2, XMM2 = z2, XMM3 = x1

	movlhps XMM0, XMM3 ; XMM0 lower bytes = x2, XMM0 higher bytes = x1
	; [x1, x2]

	vmovsd XMM4, REAL8 PTR [RSP + 40] ; xmm4 = y1

	movlhps XMM1, XMM4 ; XMM1 lower bytes = y2, XMM1 higher bytes = y1
	; [y1, y2]

	vmovsd XMM4, REAL8 PTR [RSP + 48] ; XMM4 lower bytes = z1
	vsubsd XMM2, XMM2, XMM4 ; XMM2 = z2 - z1
	vmulsd XMM2, XMM2, XMM2 ; XMM2 = (z2 - z1) * (z2 - z1)

	vhsubpd xmm5, xmm0, xmm1 ; XMM5 lower byte = [x2 - x1], XMM5 higher byte = [y2 - y1] 
	vmulpd xmm5, xmm5, xmm5 ; XMM5 = (lower [x2 - x1], higher [y2 - y1]) * (lower [x2 - x1], higher [y2 - y1])
	
	movhlps XMM4, XMM5 ; XMM4 lower bytes = XMM5 higher bytes ([y2 - y1]^2) 
	
	; uses all lower
	vaddsd XMM0, XMM5, XMM4 ; XMM0 = XMM5 ([x2 - x1]^2) + XMM4([y2 - y1]^2)
	vaddsd XMM0, XMM0, XMM2 ; XMM0 = XMM0 (XMM5 ([x2 - x1]^2) + XMM4([y2 - y1]^2)) + XMM2 ([z2 - z1]^2)

	vsqrtpd XMM0, XMM0 ; sqrt([x2 - x1]^2 + [y2 - y1]^2 + [z2 - z1]^2)

	ret
calc_distance endp


end