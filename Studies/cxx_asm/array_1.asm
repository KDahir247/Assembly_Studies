.data


.code

; extern "C" long long CalcArrayVals(long long* y, const int* x, int src, int dst, int8_t lenght);
; y[i] = x[i] * src + dst1
; sum += y[i]

CalcArrayVals proc frame

; non-volatile register are push to the stack to preserve value when non-volatile register is manipulated
prolog:
	push rsi
	.pushreg rsi
	push rdi
	.pushreg rdi
	.endprolog

entry:
	xor RAX, RAX ; zeroing out RAX. RAX = 0

	mov rdi, RCX ; rdi = y (long long*)
	mov rsi, RDX ; rsi = x (const int*)
	movzx ECX, BYTE PTR [RSP + 56] ; ECX = lenght (and zero the rest of the byte except the moved content)
	
	
	cld ; clear direction flag. string operation increment index registers (ESI and EDI) rather then decrementing
start:
	lodsd ; load dword from rsi into RAX register then increment (since we use cld) rsi by dword size 4 byte. RAX = x[i] 
	; R8 = src
	mul R8 ; RAX = RAX (x[i]) * src
	; R9 = dst
	add RAX, R9 ; RAX = RAX (x[i] * src) + dst
	stosq ; store RAX to RDi register then increment  (since we use cld) rdi by qword size 8 byte. RDI (y[i]) = RAX (x[i] * src + dst)
	dec RCX ; decrement RCX register. used as a counter for loop 
	jnz start ; jump back to start label if the zero flag is not set

	
 ; restore the old value of non-volatile register
epilog:
	pop rdi
	pop rsi

	ret
CalcArrayVals endp

end