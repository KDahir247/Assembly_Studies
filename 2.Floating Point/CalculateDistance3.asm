.686	
.model flat, c
;Implementation for this Assembly File
;extern  "C" void CalculateDistance3(float x, float y, float z, float* result);


;Distance Formula  fsqrt(a^2 + b^2 + c^2)

.code

CalculateDistance3 proc
	push ebp ;push the 32 bit pointer register (base pointer)
	mov ebp, esp ; move the 32 bit stack pointer register to the 32 bit base pointer register

	mov eax, [ebp + 20] ;eax = pointer to result
	mov ecx, 3 ;ecx = 3. This represent how many values the distance function will take in this case it a vector3 so 3
		   ;also the ecx register is the count register so we will loop 3 times and decrement ecx which will be done below
	
	mov edx, 8 ;edx = 8. this represent the first input variable from the function in this case it start with x

	l1:
		fld real4 ptr[ebp + edx]  ; load x,y,z argument to the ST register. ST(2) = x,  ST(1) = y, ST(0) = z
		fmul st(0), st(0) ; multiple each ST by itself to get the power.
				  ;remeber floating register operate in a stack fashion so what happens is  ST(0) = x *x then ST(0) = y*y, ST(1) = x*x, lastly ST(0) = z*z, ST(1) = y* y, ST(2) = x*x 
		
		add edx, 4 ;adding 4 to edx to get argument 
	loop l1 ;loop acoording to ecx register counter and decrement it by one once it hit zero exit the loop

	faddp st(1), st(0) 
	faddp st(1), st(0)

	fsqrt ;compute sqrt of st(0) and store it in st(0)

	fstp real4 ptr[eax] ;save result back to the parameter result

	pop ebp ; pop the push register ebp 
	ret
CalculateDistance3 endp 
end