.model flat, c
;Implementation for this Assembly File
;extern "C" int lerp(double a, double b, double t);
;extern "C" void lerpVector3(double a[3], double b[3], double t, double* result);

;Lerp Vector2 is very similar to lerpVector3

;Lerp formula a + (b -a) * t
.code

lerp proc
	push ebp 
	mov ebp, esp

	fld real8 ptr[ebp + 8]
	fld real8 ptr[ebp +16]

	fsubrp st(1), st(0)

	fld real8 ptr[ebp +24]

	fmulp st(1), st(0)

	fld real8 ptr[ebp + 8]
	faddp st(1), st(0)

	pop ebp
	ret
lerp endp

lerpVector3 proc
	push ebp
	mov ebp, esp

	mov edx, [ebp + 12]
	mov eax, [ebp + 8]
	mov ecx, 2

	l1:
	fld real8 ptr[edx + 8 * ecx]
	fld real8 ptr[eax + 8 * ecx]
	fsubp st(1), st(0)
	fmul real8 ptr [ebp + 16]
	fadd real8 ptr[eax + 8 * ecx]
	loop l1

	fld real8 ptr[edx]
	fld real8 ptr[eax]
	fsubp st(1), st(0)
	fmul real8 ptr [ebp + 16]
	fadd real8 ptr[eax]


	mov eax, [ebp + 24]
	fstp real8 ptr[eax]
	fstp real8 ptr [eax + 8]
	fstp real8 ptr [eax + 16]

	pop ebp
	ret
lerpVector3 endp
end