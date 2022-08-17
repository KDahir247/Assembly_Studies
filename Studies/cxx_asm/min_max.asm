.data


.code

; extern "C" int32_t signed_min(int32_t a, int32_t b, int32_t c)

; extern "C" uint32_t unsigned_max(uint32_t a, uint32_t b)

signed_min proc
entry:
	mov EAX, EDX ; EAX = b
	cmp ECX, EDX ; compare a with b
	cmovl EAX, ECX ; EAX = (a < b) ? a : b
	cmp EAX, R8D ; compare a or b with c
	cmovg EAX, R8D ; EAX = (a:b > c) ? c : a:b
	movsxd RAX, EAX ; signed extension double move RAX, EAX, since it maybe negative.

	ret
signed_min endp


unsigned_max proc
entry:
	mov EAX, EDX ; EAX = b
	cmp ECX, EDX ; compare a with b
	cmova EAX, ECX ; EAX = (b > a) ? b : a

	ret
unsigned_max endp

end