.model flat, c
;Implementation for this Assembly File
;extern "C" void AddingArraysTogether(int *a, int *b, int n, int *result);
.code
AddingArraysTogether proc
	push ebp	;push 32 bit pointer register(base pointer)
	mov ebp, esp ;move val from 32 bit stack pointer to base 32 bit base pointer

	push ebx 
	push edi

	mov ecx, [ebp + 8]	;ecx = pointer to a
	mov edx, [ebp + 12] ;edx = pointer to b
	mov eax, [ebp + 16] ;eax = n
	mov edi, [ebp + 20] ;edi = pointer to result
	test eax, eax ; bitwise AND on two operands and set the ZF (Zero Flag) to 1 if eax == 0. We don't need SF (Sign Flag) but test also set SF to one if eax < 0 (negitive)
	je InvalidArg ; Jump to InvalidArg label if the ZF == 1


	;Loop working from the back of the array to the front

	@@:
	dec eax ;decrement n by 1 because array start at zero not one
	mov ebx, dword ptr[ecx + eax * 4] ; move the value of 'a' array at index (n * 4) to ebx. Four represent the size of the type in bytes in the array
	add ebx, dword ptr[edx + eax * 4] ; add ebx  with 'b' array at index (n * 4) and store it in ebx. Four represent the size of the type in bytes in the array
	mov dword ptr[edi + eax * 4], ebx ; mov the addition sum stored in ebx to the result array at index (n * 4). Four represent the size of the type in bytes in the array
	;est eax, eax
	test eax, eax
	jne @B ; Jump back to the nearest @@ label if the ZF != 0 


	InvalidArg:
	;Poping register that were pushed
	pop edi 
	pop ebx
	pop ebp

	ret
AddingArraysTogether endp
end