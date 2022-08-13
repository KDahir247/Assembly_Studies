includelib kernel32.lib

ExitProcess proto

.data

.code

_flag proc
	xor RCX, RCX ; zeroing out the RCX registry. RCX bit are zero

	mov CL, 255 ; moving 255 the maximum unsigned byte value to CL 
	add CL, 1 ; adding 1 to CL. This will set the carry flag to true in this case CL will be zero 

	dec CL ; decrement CL which will set the carray flag to true and polarity flag to true and CL will be 255

	mov CL, 127 ; moving 127 the maximum signed byte value to CL
	add CL,  1 ; add 1 to CL. This will set the overflow flag to true


CALL ExitProcess

_flag endp

end