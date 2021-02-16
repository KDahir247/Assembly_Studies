.model flat, c
;Simple Streaming SIMD Extensions example note that variables are aligned
;Implementation for this Assembly File
;extern "C" void SsePackedInt_Average(const Xmm * a, const Xmm* b, Xmm* result);

;c++ file below commented
.code
SsePackedInt_Average proc
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]
	mov edx, [ebp + 16]

	movdqa xmm0, [eax]
	movdqa xmm1, [ecx]

	pavgw xmm0, xmm1

	movdqa [edx], xmm0
	
	pop ebp
	ret
SsePackedInt_Average endp
end


;#include <iostream>
;
;struct Xmm
;{
;	__int16 i16[8];
;};
;
;extern "C" void SsePackedInt_Average(const Xmm * a, const Xmm* b, Xmm* result);
;
;int main()
;{
;	
;__declspec(align(16)) Xmm a{5,20,30,1,-20,-25,-35, -20};
;__declspec(align(16)) Xmm a{5,20,30,1,-20,-25,-35, -20};
;	__declspec(align(16)) Xmm c{};
;
;
;	SsePackedInt_Average(&a, &b, &c);
;
;	for (int i = 0; i < 8; i++) {
;		printf("Result %i = %d \n",i, c.i16[i]);
;	}
;}

