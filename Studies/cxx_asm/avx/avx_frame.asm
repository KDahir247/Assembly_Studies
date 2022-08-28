.data

.code

add_all_frame proc frame
	
	push rbp
	.pushreg RBP
	mov RBP, RSP ; [parmeter........, RBP]
	.setframe rbp, 0
	sub RSP, 16 ;  [parameter...., RBP , local_var_8, local_var_8] 
	.allocstack 16
	.endprolog

	movsx RCX, CL ; RCX = a
	movsx RDX, DX ; RDX = b
	movsxd R8, R8D ; R8 = c

	add RCX, RDX ; RCX = a + b
	add RCX, R8 ; RCX = RCX (a + b) + c
	add RCX, R9 ; RCX = RCX(a + b + c) + d

	mov [rbp - 8], RCX ; store value to the local allocated stack space just below RBP. Not above that is why we are using - . If we use + 8 that will be the return address not the stack allocated space

	movsx RCX, BYTE PTR[RBP + 48] ; RCX = e
	movsx RDX, WORD PTR[RBP + 56] ; RDX = f
	movsxd R8, DWORD PTR[RBP + 64] ; R8 = g
	mov R9, [RBP + 72] ; R9 =  h

	add RCX, RDX ; e + f
	add RCX, R8 ; e + f + g
	add RCX, R9 ; e + f + g + h

	mov RAX, [RBP - 8] ; retrieve value from the local allocated stack space just below RBP. Not above that is why we are using - . If we use + 8 that will be the return address not the stack allocated space
	add RAX, RCX ; RAX = RAX(a + b + c + d) + RCX( e + f + g + h)



	; we can subsitute this with the leave instruction.
	mov rsp, rbp ; [parmeter........, RBP]
	pop rbp ; [parameters.........]

	ret

add_all_frame endp

end