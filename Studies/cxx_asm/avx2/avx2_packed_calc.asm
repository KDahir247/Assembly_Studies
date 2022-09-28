.const
extern  PI : real4
extern QUIET_NAN_F32 : real4
FOUR  real4 4.0
THREE real4 3.0

.data

.code
avx2_calc_sphere_area_volume proc
	; extern "C" void avx2_calc_sphere_area_volume(float* surface_area, float* volume, const float* radius, size_t n);
	; RCX = surface area, RDX = volume, R8 = radius, R9 = n
	
	; YMM0 = PI
	; YMM1 = QUIET_NAN_F32
	; YMM2 = FOUR * PI
	; YMM3 = THREE
	; YMM4 = ZERO
	; YMM5 = radius 


	vbroadcastss YMM0, REAL4 PTR [PI]
	vbroadcastss YMM1, REAL4 PTR [QUIET_NAN_F32]
	vbroadcastss YMM2, REAL4 PTR [FOUR]
	vbroadcastss YMM3, REAL4 PTR [THREE]
	vxorps YMM4, YMM4, YMM4

	vmulps YMM2, YMM2, YMM0

	xor RAX, RAX

	cmp R9, 8
	jl scalar_loop

avx_loop:
	vmovaps YMM5, YMMWORD PTR [R8 + RAX]

	vcmpleps YMM6, YMM5, YMM4 
	
	vandps YMM7, YMM6, YMM1
	vandnps YMM8, YMM6, YMM5
	
	vorps YMM9, YMM7, YMM8

	vmulps YMM9, YMM9, YMM9 
	vmulps YMM9, YMM9, YMM2


	vmulps YMM0, YMM9, YMM5

	vdivps YMM0, YMM0, YMM3

	vmovaps YMMWORD PTR[RCX + RAX], YMM9
	vmovaps YMMWORD PTR[RDX + RAX], YMM0
 
	add RAX, 32
	sub R9, 8
	cmp R9, 8
	jge avx_loop




scalar_loop:
	jz done

	vmovss XMM5, REAL4 PTR [R8 + RAX]

	vcmpless XMM6, XMM5, XMM4 

	vandps XMM7, XMM6, XMM1
	vandnps XMM8, XMM6, XMM5

	vpor XMM9, XMM7, XMM8

	vmulss XMM9, XMM9, XMM9
	vmulss XMM9, XMM9, XMM2

	vmulss XMM0, XMM9, XMM5
	
	vdivss XMM0, XMM0, XMM3

	vmovss REAL4 PTR [RCX + RAX], XMM9
	vmovss REAL4 PTR [RDX + RAX], XMM0


	add RAX, 4
	dec R9
	jmp scalar_loop



done:
	vzeroupper
	ret
avx2_calc_sphere_area_volume endp

end 
