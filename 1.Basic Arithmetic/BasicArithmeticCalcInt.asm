.model flat, c

;Implementation for this Assembly File
;Addition,Subtraction,Multiplication,Division,Modulo
;extern "C" bool ArithmeticASM(int a, int b, int result[5]);

.code
ArithmeticASM proc

	push ebp	
	mov ebp, esp
	push ebx	

	mov ecx, [ebp + 8] ;ecx = a
	mov edx, [ebp + 12] ;edx = b
	mov ebx, [ebp + 16]	;ebx = pointer to result

	xor eax, eax	; zero out eax register
	cmp edx, 0	; compare b with zero
	jz InvalidDivisor	;Divisor can't be zero. Can't divide by zero.


	;Addition
	add ecx, edx ; ecx = a + b
	mov dword ptr [ebx],ecx ;dword(4 byte) ptr add an offset of (4*0) to retrieve next index in array result

	xor ecx, ecx	; clearing ecx to zero
	mov ecx, [ebp + 8] ;ecx = a
	
	;Subtraction
	sub ecx, edx ; ecx = a - b
	mov dword ptr [ebx + 4], ecx ;dword(4 byte) ptr add an offset of (4*1) to retrieve next index in array result

	xor ecx, ecx ; clearing ecx to zero
	mov ecx, [ebp + 8] ;ecx = a

	;Multiplication
	mov eax, ecx	; eax = ecx or eax = a
	mul edx	; multiply eax by edx and store least significant 32 bits of the operation in eax
			;EDX (most significant 32 bits of the operation) so we got to re intialize it
	mov dword ptr [ebx + 8], eax ;dword(4 byte) ptr add an offset of (4*2) to retrieve the next index in array result

	mov edx, [ebp + 12] ;edx = b

	;Division
	mov eax, ecx
	mov ecx, edx

	xor edx, edx ;zero out edx 
	div ecx ; divide eax by ecx and store it in eax and store the reminder in edx
	mov dword ptr [ebx + 12], eax ; dword(4 byte) ptr add an offset of (4*3) to retrieve the next index in array result

	;Modulo
	mov dword ptr [ebx + 16], edx ; dword(4 byte) ptr add an offset of (4*4) to retrieve the next index in array result


	mov eax, 1	;return true bool 

	InvalidDivisor:
	pop ebx 
	pop ebp
	ret

ArithmeticASM endp
end