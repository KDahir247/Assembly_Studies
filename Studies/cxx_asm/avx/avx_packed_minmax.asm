.data
	extern min_val:real4
	extern max_val:real4

.code

calc_min_max proc 
	; extern "C" bool calc_min_max(float* min, float* max, const float* val, size_t len);
	; RCX = min, RDX = max, R8 = val, R9 = len
	xor RAX, RAX ; RAX = 0, return code (0 == false)
	
	test R8, 0Fh ; similar to R8 % (0fh + 1) which will check if the val array is aligned to 16 bytes
	jnz epilog ; jump to epilog if array isn't aligned


	test R9, R9 ; use an AND bitwise and set RFlag then discard result
	jz epilog ; jump to epilog if array isn't aligned 

	vbroadcastss XMM4, min_val ; XMM4 = [min_val, min_val, min_val, min_val]. store min_val to all element in XMM4
	vbroadcastss XMM5, max_val ; XMM5 = [max_val, max_val, max_val, max_val]. store max_val to all element in XMM5

	cmp R9, 4 ; compare R9 (len) to 4
	jb unaligned ; jump to unaligned label, since it is below (len < 4), thus mean it is unaligned (remember 4 * float(32 bits) = 128 bits (SSE))

	; if the above jump instruction has been ignored we know that the len is greater then or equal to 4 so we can do packed instruction.

aligned:
	vmovaps XMM0, XMMWORD PTR [R8 + RAX] ; XMM0 = (4 element of val array at a time),  XMM0 = [fst val elem, scnd val elem, thrd val elem, frth val elem]
	
	; remember XMM0 has [fst val elem, scnd val elem, thrd val elem, frth val elem]


	; remember XMM4 has [min_val, min_val, min_val, min_val]
	; XMM4 = min (XMM0,XMM4)
	vminps XMM4, XMM0, XMM4

	; remember XMM5 has [max_val, max_val, max_val, max_val]
	vmaxps XMM5, XMM0, XMM5

	add RAX, 16 ; RAX = RAX + 16, since val array is aligned to 16 bytes we offset the array be 16 since we want to skip through 4 element of val, since SSE does 4 float 
	sub R9, 4 ; R9 = R9(len) - 4, since we are using XMM register which does 4 float at a time
	cmp R9, 4 ; cmp R9(len) with 4
	jae aligned ; if R9(len) >= 4 then we still can use the packed instruction, since we can fill 4 float in a XMM register
	jnz unaligned ; other wise if the above jump does execute and R9(len) != 0 then we can't use packed instruction and will use ss (single scalar) instruction

unaligned:
	vminss XMM4, XMM4, REAL4 PTR[R8 + RAX] ; XMM4 = [min(XMM4 first elem, val elem), XMM4[1], XMM4[2], XMM4[3]]
	vmaxss XMM5, XMM5, REAL4 PTR[R8 + RAX] ; XMM5 = [max(XMM5 first elem, val elem), XMM5[1], XMM5[2], XMM5[3]]

	add RAX, 4 ; RAX = RAX + 4, since we are unaligned so we can't fill the whole XMM register, thus using ss (single scalar) which does one float at a time and store it in the first elem in XMM register
	dec R9 ; R9 = R9(len) - 1 we are just retrieving one element at a time.
	jnz unaligned ; if R9 != 0 then go back to unaligned label
	
	mov RAX, 1 ;return code (1 == true)

	; [0, 1, 2, 3]
	; [3, 2, 1, 0]
	; reverse order using bitmask 00011011b
	vshufps XMM0, XMM4, XMM4, 00011011b

	; [0, 1, 2, 3]
	; [3, 2, 1, 0]
	; compare are get the min and store.
	vminps XMM1,XMM0,XMM4

	; let say the result after vminps is 
	; [3, 2, 2, 3]
	; we then use vshufps with bit mask 01001110b
	; [2, 3, 3, 2]
	vshufps XMM2,XMM1,XMM1,01001110b

	; [3, 2, 2, 3]
	; [2, 3, 3, 2]
	; vminps which will either be 
	; [3, 3, 3, 3] or 
	; [2, 2, 2, 2]
	; this should work in all combination
	vminps XMM3,XMM2,XMM1 

	; we store the first SSE value back to *min (*min = SSE register [0])
	vmovss REAL4 PTR [RCX],XMM3 

	; look at above (min) to understand the idea behind instruction 
	vshufps XMM0, XMM5, XMM5, 00011011b
	vmaxps XMM1, XMM0, XMM5
	vshufps XMM2, XMM1, XMM1, 01001110b
	vmaxps XMM3, XMM2, XMM1
	vmovss REAL4 PTR [RDX], XMM3

epilog:
	ret
calc_min_max endp

end