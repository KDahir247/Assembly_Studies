includelib kernel32.lib

ExitProcess proto

.data
ROWS  BYTE 0, 1, 2, 3, 10, 11, 12, 13, 20, 21, 22, 23
COLS  BYTE 0, 10, 20, 1, 11, 21, 2, 12, 22, 3, 13, 23

ARRA DWORD 0, 1, 2, 3, 10, 11, 12, 13, 20, 21, 22, 23
ARRB DWORD 0, 10, 20, 1, 11, 21, 2, 12, 22, 3, 13, 23

.code

_array2d proc

entry:
	xor RCX, RCX ; zeroing out the RCX register. RCX bits are zeroed
	xor R8, R8 ; zeroing out the R8 register. R8 bits are zeroed
	xor R9, R9 ; zeroing out R9 register. R9 bits are zeroed

	mov CL, ROWS ; move the ROWS at offset 0 which will be 0 to the CL register
	mov CH, COLS ; move the COLS at offset 0 which will be 0 to the CH register

	mov R8D, ARRA ; move the ARRA at offset 0 which will be 0 to R8D register
	mov R9D, ARRB ; move the ARRB at offset 0 which will be 0 to R9D register

	mov CL, ROWS + 4 ; move the ROWS at offset 4 which will be 10 to CL register
	mov CH, COLS + 3 ; move the COLS at offset 3 which will be 1 to CH register

	mov R8D, ARRA + (4 * 4) ; move ARRA at offset 16 (dword = 4 bytes + 4 offset) which will be 10 to R8D register 
	mov R9D, ARRB  + (4 * 3) ; move ARRB at offset 12 (dword = 4 bytes + 3 offset) which will be 1 to R9D register

CALL ExitProcess

_array2d endp

end