.model flat, c
;Implementation for this Assembly File
;extern "C" MmxVal MmxAdd(MmxVal a, MmxVal b)

;See below for the cpp file

.code
MmxAdd proc
	push ebp
	mov ebp, esp
	
	movq mm0, [ebp+ 8] ;mm0 = a
	movq mm1, [ebp + 16] ;mm1 = b

	paddb mm0, mm1 ;packed byte addition using wraparound. since im using an int8 as an example

	movd eax, mm0 ; move the first value from mm0 to eax note that mm0 register size is 64 but eax is 32 so it will store only half of mm0
				  ; ex. MM0 = 1A18161412100E0C 
				  ;     EAX =         12100E0C

	pshufw mm2, mm0, 01001110b ; we shuffle mm0 and storing it to mm2 we are reversing each half of the register of mm0
	
	movd edx, mm2 ;we are storing the first half of mm2 to edx 
				  ; ex. MM2 = 12100E0C1A181614
				  ;	EDX =	      1A181614

	emms ;Clear the mmx register and set the value of the floating point tag word to empty. Reusing the mmx register without emptying will result in unexpected behaviour and slow performance
	
	pop ebp ; pop push register
	ret
MmxAdd endp
end


;#include <iostream>

;struct MmxVal
;{
;	__int8 i8[8]{}; //requires 64 bit for the mmx register to operate simd
;					//8 * int8, 4 * int16, 2 * int32, 1 * int64, etc...
;	
;};
;extern "C" MmxVal MmxAdd(MmxVal a, MmxVal b);
;
;int main()
;{
;
;	MmxVal a{}, b{};
;
;	//You can change the values of a and b 
;	a.i8[0] = 1; b.i8[0] = 11;
;	a.i8[1] = 2; b.i8[1] = 12;
;	a.i8[2] = 3; b.i8[2] = 13;
;	a.i8[3] = 4; b.i8[3] = 14;
;	a.i8[4] = 5; b.i8[4] = 15;
;	a.i8[5] = 6; b.i8[5] = 16;
;	a.i8[6] = 7; b.i8[6] = 17;
;	a.i8[7] = 8; b.i8[7] = 18;
;	
;	MmxVal c = MmxAdd(a, b);
;
;	for (int i = 0; i < 8; i++) {
;		printf("%4d + %4d = %4d \n", a.i8[i], b.i8[i], c.i8[i]);
;	}
;}

