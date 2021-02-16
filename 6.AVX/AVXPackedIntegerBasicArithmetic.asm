.model flat, c
;Simple Advance Vector Extension example note that variables are aligned. 
;Implementation for this Assembly File
;extern "C" void AVXPackedInteger_16_Add_Multiply(Ymm * a, Ymm * b, Ymm * c, Ymm * result);

;c++ file below commented
.code
AVXPackedInteger_16_Add_Multiply proc
	push ebp ;push the 32 bit base pointer register
	mov ebp, esp;mov 32 bit stack pointer to the 32 bit base pointer 

	mov eax, [ebp + 8] ;eax = pointer to 'a'
	mov ecx, [ebp + 12] ;ecx = pointer to 'b'
	mov edx, [ebp + 20] ;edx = pointer 'result'

	; move the aligned packed variable to ymm0. Not that we are using ymmword which is 256 bit
	;  since ymm has i16[16] which is 16 * 16 = 256 and moving it to the AVX register which are 256 bit 
	vmovdqa ymm0, ymmword ptr[eax] ;ymm0 = a
	vmovdqa ymm1, ymmword ptr[ecx] ; ymm1 = b
	
	vpaddw ymm2, ymm0, ymm1 ;we add pack word (16 bit) which are struct contains I16[16] from ymm0 with ymm1 and store it in ymm2
	mov eax, [ebp + 16] ; eax = pointer to 'c'

	vmovdqa ymm3, ymmword ptr[eax] ; ymm3 = c

	vpmullw ymm4, ymm2, ymm3 ; we multiply packed word from AVX register ymm2 and ymm3 and store it to ymm4

	vmovdqa ymmword ptr [edx], ymm4 ;we store ymm4 ((ymm0 + ymm1) * ymm3) the result to the ymmword ptr [result] which is the i16[16]

	vzeroall ; we zero out all ymm register. 

	pop ebp ; we pop the pushed 32 bit base pointer register
	ret ;end
AVXPackedInteger_16_Add_Multiply endp

end



;#include <iostream>

;struct Ymm
;{
;	//ymm register can store 256 bit so that can be
;	/*an array of int8 that is 32 in length, array of int16 that is 16 in length show in the exercise,
;	  array of int32 that is 8 in length, array of int64 that is 4 in length, or an array of int128 that is 2 in length */ 
;	__int16 i16[16];
;};
;
;//We will Added element a with b then multiply it by element c and it will be stored in result
;extern "C" void AVXPackedInteger_16_Add_Multiply(Ymm * a, Ymm * b, Ymm * c, Ymm * result);
;int main()
;{
;	//The AVX requires the load address to be aligned to multiple of 32 if using dedicated align load instruction
;	//which is currently used for this exercise. I'll will also be doing unaligned AVX instruction in a separate exercise 
;	__declspec(align(32)) Ymm a{3,10,20,34,11,3,24,35,10,25, 42, 23, 13, 0, 14, 8};
;	__declspec(align(32)) Ymm b{90, 46, 300, 43, 12, 3, 0, 35, 23, 34, 4, 0, 11, 22, 34, 100};
;	__declspec(align(32)) Ymm c{2, 1, 2, 3, 4, 5, 2, 3, 1,3,5, 6,4,2, 1,3};
;	_declspec(align(32)) Ymm result{};
;
;
;
;	AVXPackedInteger_16_Add_Multiply(&a, &b, &c, &result);
;
;
;	for (int i = 0; i < 16; i++)
;	{
;		printf("%i + %i  * %i = %i \n", a.i16[i], b.i16[i], c.i16[i], result.i16[i]);
;	}
;}

