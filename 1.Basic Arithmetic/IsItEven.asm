.686	
.model flat, c
;Implementation for this Assembly File
;extern "C" bool IsItEven(int value);

; Branchless Assembly 
; 1 = True
; 0 = False

.const 
	dword_two DWORD 2
	dword_neg_one DWORD -1
.code

IsItEven proc

	push ebp ;push 32 bit pointer register(base pointer)
	mov ebp, esp ;move val from 32 bit stack pointer to base 32 bit base pointer
	
	mov eax,[ebp + 8] ; eax = value
	
	xor edx, edx ; Clearing out what ever value is in edx register
	div [dword_two] ; Will make the edx register contain one if it is not equally divisable by [dword_two] (2) otherwise it will return 0

	mov eax, edx ; eax will have what ever value is in edx either 0 for even or 1 for not even
	add eax, [dword_neg_one] ;we subtract 1 from eax. So if eax = 0 or even then eax will be -1 and if it is 1 or not even it will be 0. basically remapping

	neg eax ;we negate eax so if it contains 0 for not even it will still be zero otherwise if it contain -1 for even it will be 1

	pop ebp ; pop the 32 bit pointer register(base pointer) that was pushed 
		ret
	
IsItEven endp 
end