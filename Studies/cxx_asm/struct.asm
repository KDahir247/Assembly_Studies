.data
MyStruct struct
	a BYTE ?
	padding BYTE ?
	b WORD ?
	c DWORD ?
	d QWORD ?
MyStruct ends
	
.code

sum_struct proc 

	; extern "C" int sum_struct(const MyStruct* structure);
	; RCX = const MyStruct*

	xor RAX, RAX ; RAX = 0

	mov RDX, MYSTRUCT.c

	; movsx RAX, BYTE PTR [RCX + MYSTRUCT.a]
	; or we can do BYTE PTR [RCX + 0], but the zero is redundent
	movsx RAX, BYTE PTR[RCX] ; since offset of zero will point always point to the first elem 
	
	;add AX, WORD PTR [RCX + MYSTRUCT.b]
	; or
	add AX, WORD PTR [RCX + 2] ; offset is by 2 bytes (a == 1 byte and padding == 1 byte)

	;add EAX, DWORD PTR [RCX + MYSTRUCT.c]
	; or
	add EAX, DWORD PTR [RCX + 4] ; offset is by 4 bytes (a == 1 byte, padding == 1 byte, and b == 2 bytes)

	; add RAX, QWORD PTR [RCX + MYSTRUCT.d]
	; or
	add RAX, QWORD PTR [RCX + 8] ; set is by 8 bytes (a == 1 byte, padding == 1 byte, b == 2 bytes, and c == 4 bytes)

	ret
sum_struct endp

end