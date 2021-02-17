.model flat, c
;Simple Advance Vector Extension example note that some variables are unaligned. 
;Implementation for this Assembly File
;extern "C" void AVXPackedInteger_64_Arithmetic(Ymm * a, Ymm * b,  Ymm * result);

;c++ file below commented
.code
AVXPackedInteger_64_Arithmetic proc
	push ebp ;push the 32 bit base pointer register
	mov ebp, esp ;mov 32 bit stack pointer to the 32 bit base pointer

	mov ecx, [ebp+ 8] ; ecx = pointer to a
	mov edx, [ebp + 12] ;edx = pointer to b
	mov eax, [ebp + 16] ;eax = pointer to result

	vmovdqa 
	vmovdqa ymm0, ymmword ptr[ecx] ;move aligned packed integer ymmword (256 bit) value of ecx to ymm0 
	vmovdqu ymm1, ymmword ptr [edx] ;move unaligned packed integer ymmword (256 bit) value of edx to ymm1

	vpaddd ymm2, ymm0, ymm1 ; add packed dword integer from ymm0 and ymm1 and store it in ymm2 with wrap around
	vpsubd ymm3, ymm0, ymm1 ; subtract packed dword integer ymm0 from ymm1 and store it in ymm3 with wrap around

	vpmulld ymm4, ymm0, ymm1 ; multiply packed dword integer ymm0 with ymm1 and store it in ymm4
	
	vpminsd ymm5, ymm0, ymm1 ; compare both AVX register ymm0 and ymm1 and store the lowest packed dword integer in ymm5
	
	vpmaxsd ymm6, ymm0, ymm1 ; compare both AVX register ymm0 and ymm1 and store the highest packed dword in ymm6

	vmovdqa	ymmword ptr[eax], ymm2 ;store ymm2 (addition) in the ymmword ptr (result.i64[0])
	vmovdqa ymmword ptr[eax + 32], ymm3 ;store ymm3 (subtraction) in the ymmword ptr (result.i64[1])
	vmovdqa ymmword ptr[eax + 64], ymm4 ;store ymm4 (multiplication) in the ymmword ptr (result.i64[2])
	vmovdqa ymmword ptr[eax + 96],ymm5 ;store ymm5 (minimum) in the ymmword ptr (result.i64[3])
	vmovdqa ymmword ptr[eax + 128],ymm6 ;store ymm6 (maximum) in the ymmword ptr (result.i64[4])

	vzeroall ;zero out all the AVX (ymm) register

	pop ebp ;we pop the pushed 32 bit base pointer register
	ret
AVXPackedInteger_64_Arithmetic endp

end



;#include <iostream>
;
;
;struct Ymm
;{
;	//ymm register can store 256 bit so that can be
;	/*an array of int8 that is 32 in length, array of int16 that is 16 in length show in the exercise,
;	  array of int32 that is 8 in length, array of int64 that is 4 in length, or an array of int128 that is 2 in length */ 
;	__int64 i64[4];
;};
;
;//We will preform add, sub, mul, min, max
;//Also let us say that b is unaligned for AVX since it is aligned to 8 and not 32
;extern "C" void AVXPackedInteger_64_Arithmetic(Ymm * a, Ymm * b,  Ymm  result[5]);
;void Print(int i, const Ymm* result);
;int main()
;{
;	__declspec(align(32)) Ymm a{13,2000,4532,456};
;	//Unaligned
;	__declspec(align(8)) Ymm b{11,34,231,123};
;	__declspec(align(32)) Ymm result[5]{};
;	AVXPackedInteger_64_Arithmetic(&a, &b, result);
;
;
;	printf("-----Addition-----\n");
;	Print(0, result);
;
;	printf("----Subtraction-----\n");
;	Print(1, result);
;
;	printf("----Multiplication-----\n");
;	Print(2, result);
;
;	printf("----Minimum-----\n");
;	Print(3, result);
;
;	printf("----Maximum-----\n");
;	Print(4, result);
;
;}
;
;void Print(int index, const Ymm * result)
;{
;	for (int i = 0; i < 4; i++)
;	{
;		printf("%lld \n", result[index].i64[i]);
;	}
;}