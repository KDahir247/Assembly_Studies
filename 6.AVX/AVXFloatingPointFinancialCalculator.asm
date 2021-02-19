.model flat, c
;Implementation for this Assembly File

;//ACCURED AMOUNT in principle + Interest
;extern "C" void AVX_Total_Accrued_Amount(double principle, double yearly_rate, double annual_time, double* accured_amount);
;extern "C" void AVX_Principal_Amount(double accured_amount, double yearly_rate, double annual_time, double* principal);
;extern "C" void AVX_Yearly_Rate_Amount(double accurred_amount, double principal, double annual_time, double* yearly_rate);
;extern "C" void AVX_Annual_Time(double accurred_amount, double principal, double yearly_rate, double* annual_time);
;
;
;//Interest Only
;extern "C" void AVX_Calculate_Interest(double principal, double yearly_rate, double annual_time, double* interest_paid);
;extern "C" void AVX_Calculate_Principal(double interest_paid, double yearly_rate, double annual_time, double* principal);
;extern "C" void AVX_Calculate_Rate(double principal, double interest_paid, double annual_time, double* yearly_rate);
;extern "C" void AVX_Calculate_Annual_Time(double principal, double interest_paid, double yearly_rate, double* annual_time);

.const
	TO_DECIMAL_R8 real8 100.00
	ONE_R8 REAL8 1.00
.code


AVX_Total_Accrued_Amount proc
;Accured Amount = P(1 + rt)

	push ebp 
	mov ebp,esp

	mov eax, [ebp + 32]
	
	vmovsd xmm0, real8 ptr[ebp + 8] ; principal amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; yearly interest rate
	vmovsd xmm2, real8 ptr[ebp + 24] ; annual time

	vdivsd xmm3, xmm1, [TO_DECIMAL_R8]
	vmulsd xmm4, xmm3, xmm2
	vaddsd xmm5,  xmm4, [ONE_R8]
	vmulsd xmm6, xmm0, xmm5


	vmovsd real8 ptr [eax], xmm6

	vzeroall

	pop ebp
	ret
AVX_Total_Accrued_Amount endp


AVX_Principal_Amount PROC
;Principle = A / (1 + rt)
	push ebp
	mov ebp ,esp
	
	mov eax, [ebp + 32]

	vmovsd xmm0, real8 ptr[ebp + 8] ; accured amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; yearly interest rate
	vmovsd xmm2, real8 ptr[ebp+ 24] ; annual time

	vdivsd xmm3, xmm1, [TO_DECIMAL_R8]
	vmulsd xmm4, xmm3, xmm2
	vaddsd xmm5, xmm4, [ONE_R8]
	vdivsd xmm6, xmm0, xmm5


	vmovsd real8 ptr [eax], xmm6

	vzeroall

	pop ebp
	ret
AVX_Principal_Amount endp


AVX_Yearly_Rate_Amount PROC
;Rate yearly = ((1/t)(A/P - 1)) * 100.00

	push ebp 
	mov ebp, esp


	mov eax, [ebp + 32]

	vmovsd xmm0, real8 ptr [ebp + 8] ; accured amount
	vmovsd xmm1, real8 ptr [ebp + 16] ; principal amount
	vmovsd xmm2, real8 ptr [ebp + 24] ; annual time

	vmovsd xmm3, [ONE_R8] ; xmm3 = 1 

	vdivsd xmm4, xmm3, xmm2
	vdivsd xmm5, xmm0, xmm1

	vsubsd  xmm6, xmm5, [ONE_R8]
	vmulsd xmm7, xmm4, xmm6
	vmovsd real8 ptr[eax], xmm7

	vzeroall	
	
	vmovsd xmm0, real8 ptr[eax]

	vmulsd xmm1, xmm0, [TO_DECIMAL_R8]

	vmovsd real8 ptr[eax], xmm1

	vzeroall	

	pop ebp
	ret
AVX_Yearly_Rate_Amount endp


AVX_Annual_Time proc
;Annual time = (1/r)(A/P - 1)

	push ebp
	mov ebp,esp

	mov eax, [ebp + 32]

	vmovsd xmm0, real8 ptr[ebp + 8] ; accured amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; principal amount

	vdivsd xmm3, xmm0, xmm1
	vsubsd xmm4, xmm3, [ONE_R8]


	vmovsd real8 ptr [eax] ,xmm4
	

	vmovsd xmm0, real8 ptr [eax] ; (A/P- 1)
	vmovsd xmm1, real8 ptr [ebp + 24] ; yearly_rate
	
	vdivsd xmm2, xmm1, [TO_DECIMAL_R8]

	vmovsd xmm3, [ONE_R8]

	vdivsd xmm4, xmm3, xmm2
	vmulsd xmm5, xmm4, xmm0

	vmovsd real8 ptr [eax] , xmm5

	pop ebp
	ret
AVX_Annual_Time endp





AVX_Calculate_Interest proc
	;Interest = Prt

	push ebp
	mov ebp, esp

	mov eax, [ebp + 32] ; intrest
	
	vmovsd xmm0, real8 ptr[ebp + 8] ; principal amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; yearly rate
	vmovsd xmm2, real8 ptr[ebp + 24] ; annual time

	vdivsd xmm3, xmm1, [TO_DECIMAL_R8] ; r

	vmulsd xmm4, xmm0, xmm3
	vmulsd xmm5, xmm4, xmm2

	vmovsd real8 ptr[eax], xmm5


	pop ebp
	ret
AVX_Calculate_Interest endp


AVX_Calculate_Principal proc
	;Principle = I / rt

	push ebp
	mov ebp, esp

	mov eax, [ebp + 32]
	
	vmovsd xmm0, real8 ptr [ebp + 8] ; interest 
	vmovsd xmm1, real8 ptr [ebp + 16] ; yearly rate
	vmovsd xmm2, real8 ptr[ebp + 24] ; annual time

	vdivsd xmm3, xmm1, [TO_DECIMAL_R8]
	vmulpd xmm4, xmm3, xmm2
	vdivpd xmm5, xmm0, xmm4

	vmovsd real8 ptr [eax], xmm5

	pop ebp
	ret
AVX_Calculate_Principal endp


AVX_Calculate_Rate proc 
	;Rate = (I / Pt) * 100

	push ebp 
	mov ebp, esp

	mov eax, [ebp+ 32]

	vmovsd xmm0, real8 ptr[ebp + 8] ; principal amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; interest
	vmovsd xmm2, real8 ptr[ebp + 24] ; annual time

	vmulsd xmm3, xmm0, xmm2
	vdivsd xmm4, xmm1, xmm3
	vmulsd xmm5, xmm4, [TO_DECIMAL_R8]

	vmovsd real8 ptr[eax], xmm5


	pop ebp
	ret
AVX_Calculate_Rate endp


AVX_Calculate_Annual_Time proc 
	;Annual time = I / Pr
	
	push ebp
	mov ebp, esp

	mov eax, [ebp + 32]

	vmovsd xmm0, real8 ptr[ebp + 8] ; principle amount
	vmovsd xmm1, real8 ptr[ebp + 16] ; interest 
	vmovsd xmm2, real8 ptr[ebp + 24] ; yearly rate


	vdivsd xmm3, xmm2, [TO_DECIMAL_R8]
	vmulsd xmm4, xmm3, xmm0
	vdivsd xmm5, xmm1, xmm4

	vmovsd real8 ptr[eax], xmm5

	pop ebp
	ret

AVX_Calculate_Annual_Time endp
end