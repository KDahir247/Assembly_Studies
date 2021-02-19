.686	
.model flat, c

;use microsoft visual c runtime library
includelib	msvcrt.lib

;Prevent use o jump instruction (JZ, JNZ, etc...) to have a clean control flow.
;Implementation for this Assembly File
;extern "C" void Print0ToNum();

printf PROTO C, :VARARG
ReceiveInput PROTO C
exit PROTO C, :DWORD

.const
	;If you pass a value that is negitive it will be converted to the absolute value
	introduction_Byte db 'Enter a unsigned integer to print from 0 to n-1: ',10,0
	format_Byte db '%i ',0

.data
	currentIndex_DWORD DWORD ?

.code

Print0ToNum proc
	push ebp
	mov ebp, esp
	push ebx

	invoke printf, offset [introduction_Byte]

	invoke ReceiveInput
	
	;get the absoulte value of abs if negitve
	mov edx, eax
	neg eax
	test eax, eax
	cmovs eax, edx

	mov ecx, eax
	mov ebx,ecx

	mov [currentIndex_DWORD], 0

 	l1:

	invoke printf, offset [format_Byte], currentIndex_DWORD
	
	mov ecx, ebx
	
	dec ebx
	inc	[currentIndex_DWORD]
	
	loop l1


	pop ebx
	pop ebp
	invoke exit, 0
Print0ToNum endp


end