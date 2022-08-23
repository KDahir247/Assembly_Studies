.const
SCALAR_FARH_CEL REAL4  0.5555556
SCALAR_CEL_FARH REAL4  1.8000000

F_32 REAL4 32.0
.data

.code

farenheit_to_celcius proc 
	; extern "C" float farenheit_to_celcius(float farenheit);
	; XMM0 = farenheit 

	vmovss XMM1, [F_32] ; XMM1 (lower 4 bytes) = 32.0
	vsubss XMM0, XMM0, XMM1 ; XMM0 = XMM0 (farenheit) - 32.0
	vmovss XMM1, [SCALAR_FARH_CEL] ; XMM1 (lower 4 bytes) = 0.5555556
	vmulss XMM0, XMM0, XMM1 ; XMM0 = XMM0 ((farenheit - 32.0)) * XMM1 (0.5555556)
	; return XMM0
	ret
farenheit_to_celcius endp

celcius_to_farenheit proc
	; extern "C" float celcius_to_farenheit(float celcius);
	; XMM0 = celcius

	vmovss XMM1, [SCALAR_CEL_FARH] ; XMM1 (lower 4 bytes) = 1.8000000
	vmulss XMM0, XMM0, XMM1 ; XMM0 = XMM0 (celcius) * XMM1 (1.8000000)
	vmovss XMM1, [F_32] ; XMM1 (lower 4 bytes) = 32.0
	vaddss XMM0, XMM0, XMM1 ; XMM0 = XMM0 (celcius * 1.8000000) + XMM1 (32.0)
	ret
 celcius_to_farenheit endp

end