.data


.code

; extern "C" int int_mul_div(int a, int b, int* product, int* quo, int* rem);
; excercise for tomorrow

 int_mul_div PROC
entry:	
	mov EAX, EDX ; EAX = b
	test EAX, EAX ; logical operation. uses & and set the flag then discard
	jz invalid_res ; jump to label invalid if zero flag has been set

	mov R10D, EDX ; R10D = b

	imul ECX ; EAX:EDX = EAX * ECX
	mov [R8], EAX ; *product = EAX

	mov EAX, ECX ; EAX = a

	cdq ; convert double to quadword
	idiv R10D ; EAX:EDX = a / b. EAX has quo, EDX has rem

	mov [R9], EAX ; *quo = quotent

	mov RAX, [RSP + 40] ; rem is in the stack. bottom contains return address follow 8 byte per arg (8 a,16  b, 24  prodt, 32  quo, 40 rem)
	mov [RAX], EDX ; *rem = EDX


invalid_res:
	ret

int_mul_div ENDP

end