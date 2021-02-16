.model flat, c
;Implementation for this Assembly File
;extern "C" void FillArray(int amt, int* array);

.code

FillArray proc
	push ebp ;push the 32 bit base pointer register 
	mov ebp, esp 

	mov eax, [ebp + 12] ;eax = 'array'
	mov ecx, [ebp + 8] ;ecx  = amt

	test ecx, ecx ;we are doing a and setting SF, ZF, PF flag depending on result
	je ZeroArray ; jump if the zero flat is 1 (true)

	dec ecx ;decrement ecx since array are zero base
	
	l1:

	mov dword ptr [eax + ecx * 4], ecx ; storing the value of ecx in the array element offset
	loop l1 ;loop and decrement ecx break when ecx == 0

	mov dword ptr [eax], ecx ; store array[0] = ecx(0)


	ZeroArray:
	pop ebp ; popped push register ebp 
	ret
FillArray endp
end