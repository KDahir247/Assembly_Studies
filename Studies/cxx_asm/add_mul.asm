.data


.code

 add_mul PROC
	mov RAX, RCX ; RAX = a
	add RAX, RDX ; RAX += RDX (b) or RAX = RAX (a) + RDX (b)
	add RAX, R8 ; RAX += R8 (c) or RAX = RAX (a + b) + R8 (c)
	mul R9 ; RAX *= R9 (d) or RAX = RAX (a + b + c) * R9 (d)

	ret

add_mul ENDP

end