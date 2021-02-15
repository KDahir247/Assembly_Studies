.686
.model flat, c
;Implementation for this Assembly File
;extern "C" int CalculateAverageArray(int* array, int length);
.code

CalculateAverageArray proc
	push ebp ; push the 32 bit base pointer register
	mov ebp, esp ; move the 32 bit stack pointer register value to ebp

	mov ecx, [ebp + 8] ;ecx is equal to the pointer to array
	mov edx, [ebp + 12] ;edx is equal to length

	xor eax, eax	; performs an xor operation on eax making eax = 0

	test edx, edx ;bitwise AND on two operands and set zero flag and sign flag depending on value
	je LengthZero ;jump  to LengthZero if edx is zero


	@@:
	dec edx ;predecrement edx by 1 since array start at zero
	add eax, dword ptr[ecx + edx * 4] ;get the each element of the array and add it to eax
	test edx, edx ; bitwise AND on two operands and set zero flag and sign flag depending on value
	jne @B ; jump back to nearest @@ if the zero flag is not set for edx

	xor ecx, ecx ;performs an xor operation on ecx making ecx = 0
	mov ecx, [ebp + 12] ; ecx = to length

	div ecx ; divide eax by ecx ( eax = sum / length)

	;eax register value will get passed to the return type of the function

	LengthZero:
	;popped pushed register
	pop ebp 
	ret



CalculateAverageArray endp
end