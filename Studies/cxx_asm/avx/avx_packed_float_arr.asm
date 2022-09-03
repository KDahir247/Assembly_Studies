.data

.code

avx_calc_sqrt proc 
	; extern "C" bool avx_calc_sqrt(float* dst, const float* src, size_t len);
	; RCX = dst, RDX = src, R8 = len

	xor EAX, EAX ; EAX = 0
	test r8, r8 ; R8 & R8 and set RFlag then discard result
	jz epilog ; jump if zero flag is set R8 == 0

	test RCX, 0fh ; similar to RCX % (0fh + 1) which will check if the src array is aligned to 16 bytes
	jnz epilog ; jump to epilog label if the array isn't aligned


	test RDX, 0fh ; similar to RDX % (0fh + 1) which will check if the dst array is aligned to 16 bytes
	jnz epilog ; jump to epilog label if the array isn't aligned

	cmp R8, 4 ; compare R8 (len) with 4, since XMM register can store 4 float32 (4 * 32 == 128bytes)
	jb unaligned ; jump to unaligned, since len is less then 4 


aligned:
	vsqrtps XMM0, XMMWORD PTR[RDX+ RAX] ; simd sqrt on 4 multiple data. 
	vmovaps XMMWORD PTR[ RCX + RAX], XMM0  ; move the 4 sqrt data in the 4 elements of the array in dst
	add RAX, 16 ; RAX = RAX + 16, offset array src
	sub R8,4 ; R8 = len - 4 (XMM can store 4 float)
	cmp R8, 4 ; compare R8 (len) with 4
	jae aligned ; if R8(len) >= 4 then go back to align label, since we can store it as a packed aligned on the XMM register
	jnz unaligned ; otherwise if the above jmp get ignored and R8 (len) != 0 then it is not aligned and do the scalar single instead of packed

unaligned:
	vsqrtss XMM0, XMM0, REAL4 PTR[RDX + RAX] ; vsqrt scalar single (one element at a time) in the XMM register
	vmovss REAL4 PTR[RCX + RAX], XMM0 ; move scalar single (one element at a time) from XMM0 (0) to dst array
	add RAX, 4 ; RAX = RAX(offset to array) + 4
	dec R8 ; R8 = R8(len) - 1
	jnz unaligned ; jump back to unaligned if R8 is not zero


	mov RAX, 1 ; RAX = 1


epilog:
	ret
avx_calc_sqrt endp

end