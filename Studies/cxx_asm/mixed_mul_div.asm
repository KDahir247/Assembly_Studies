.data


.code

; extern "C" int64_t signed_mul(int8_t a, int16_t b, int32_t c, int16_t d, int64_t e, int8_t f);
; (a * b * c) + (d * e * f)

; extern "C" int unsigned_div(uint8_t a, uint16_t b, uint32_t c, uint16_t d, uint64_t e, uint8_t f, uint64_t * quo, uint64_t * rem);
; (a + b + c) / (d + e + f)

; excercise for tomorrow

unsigned_div proc


	movzx RAX, CL; RAX = a (fill the rest of the bits to zero)
	movzx RDX, DX ; RCX = b (fill the rest of the bits to zero) E.G so 11 will be 000000000000000B 
	add RAX, RDX ; RAX = a + b 

	mov ECX, R8D ; ECX = c
	add RAX, RCX ; RAX = a + b + c
	xor RDX, RDX ; zeroing out RDX
 
	movzx RBX, R9W ; RBX = d  (fill the rest of the bits to zero)
	add RBX, [RSP + 40] ; RBX = d + e 

	movzx RCX, BYTE PTR[RSP + 48] ;  RCX = f (fill the rest of the bits to zero)
	add RBX, RCX ; RBX = d + e + f

	test RBX, RBX ; does a & operation from dst and src and set the RFLAG then throws away result.
	jz zero_divsor ; jump to zero_divsor label if the zero flag is set

	div RBX ; divide RAX with RBX and store the quotent in RAX register and remainder in RDX

	mov RCX, [RSP + 56] ; RCX = quo (uint64 ptr)
	mov [RCX], RAX ; *quo = RAX (quotent result)   

	mov RCX, [RSP + 64] ; RCX = rem (uint64 ptr)
	mov [RCX], RDX ; *rem = RDX (remainder result)
	xor RAX, RAX ; zeroing out RAX 
	jmp done ; jmp to done label skip zero_divsor label error code.

zero_divsor:
	mov RAX, 1 ; move 1 to RAX if the divisor is zero
done:
	ret

unsigned_div endp


 signed_mul proc
	
	movsx RAX, CL ; RAX =  a (fill the rest to signed value in this case 0) 

	movsx RDX, DX ; RDX = b (fill the rest to signed value in this case F)
	imul  RDX ; RAX = a * b

	movsxd RCX, R8D ; RCX = c (fill the rest to signed value in this case 0)
	imul RCX ; RAX = a * b * c

	mov RBX, RAX ; RBX = a * b * c

	movsx RAX, R9W  ; RAX = d (fill the rest to signed value in this case 0)

	mov RCX, [RSP + 40] ; RCX = e ; RCX = e we use a move, since it a 64 int we don't fill the rest of the bytes in the register of RCX

	imul RCX ; RAX = d * e

	movsx R9, BYTE PTR [RSP + 48] ; R9 = f (we move a byte ptr since the parameter is of type int8_t)
	imul R9 ; RAX = d * e * f


	add RAX, RBX ; (d * e * f) + (a * b * c)

	ret

signed_mul endp

end