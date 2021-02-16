.model flat, c
;Implementation for this Assembly File
;extern "C" int Max(int a, int b);

.code
	Max proc

	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	mov ecx, [ebp + 12]

	div ecx
	test edx, edx  ; performance and operation and set the ZF, SF, PF according to the result
	je FirstElement	 


	mov eax, [ebp + 12]
	pop ebp
	ret


	FirstElement:
	mov eax, [ebp + 8]
	pop ebp
	ret

	Max endp

end