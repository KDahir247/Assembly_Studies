.data


.code

; extern "C" int32_t signed_min(int32_t a, int32_t b, int32_t c)

; extern "C" uint32_t unsigned_max(uint32_t a, uint32_t b)

signed_min proc
entry:
	mov EAX, EDX 
	cmp ECX, EDX
	cmovl EAX, ECX
	cmp EAX, R8D
	cmovg EAX, R8D
	movsxd RAX, EAX

	ret
signed_min endp


unsigned_max proc
entry:
	mov EAX, EDX
	cmp ECX, EDX
	cmova EAX, ECX

	ret
unsigned_max endp

end