.const
PI_R8 REAL8 3.141592653589793238 ; PI
FOUR_R8 REAL8 4.0
FOUR_DIV_THREE_REAL8 REAL8 1.333333333333333 ; 4/3
.data

.code

calc_sphere_area_vol proc 
	; extern "C" void calc_sphere_area_vol(double radius, double* surface_area, double* volume);
	; xmm0 = radius
	
	vmovsd XMM1, [FOUR_R8] ; XMM1 (lower 8 bytes) = 4.0
	vmovsd XMM2, [PI_R8] ; XMM2 (lower 8 bytes) = 3.141592653589793238

	vmulsd XMM3, XMM0, XMM2 ; XMM3 = r * 3.14...
	vmulsd XMM3, XMM3, XMM0 ; XMM3 = r * 3.14... * r
	vmulsd XMM1, XMM3, XMM1 ; XMM1 = r * 3.14... * r * 4
	; or re-written as 4*PI*r*r

	vmovsd XMM2, [FOUR_DIV_THREE_REAL8] ; XMM2 = 1.333333333333333
	vmulsd XMM2, XMM3, XMM2 ;  XMM2 = r * 3.14... * r * 1.33333333
	vmulsd XMM2, XMM2, XMM0 ; XMM0 = r * 3.14... * r * 1.33333333 * r
	; or re-written as 4/3*PI*r*r*r

	vmovsd real8 ptr[RDX], XMM1 ; real8 ptr of RDX = XMM1 (lower 4 bytes)
	vmovsd real8 ptr[R8], XMM2 ; real8 ptr of R8 = XMM2 (lower 4 bytes)

	ret
calc_sphere_area_vol endp


end
