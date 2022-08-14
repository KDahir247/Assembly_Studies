.data

	extern value : dword ; dword (32 bit)

.code

; (((a & b) | c) ^ d) + value
 int_logic PROC

	mov EAX, ECX ; EAX = ECX (a)
	and EAX, EDX ; EAX = EAX (a) & EDX (b)
	or EAX, R8D ; EAX = (EAX(a) & EDX (b)) | R8D (c)
	xor EAX, R9D ; EAX = ((EAX(a) & EDX(b)) | R8D(c)) ^ R9D (d)
	add EAX, value ; EAX (((EAX(a) & EDX(b)) | R8D(c) ) ^ R9D(d)) + value

	ret

int_logic ENDP

end