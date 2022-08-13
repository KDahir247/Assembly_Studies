includelib kernel32.lib

ExitProcess proto

.data
ARRA BYTE 1, 2, 3
ARRB WORD 10, 20, 30
ARRC DWORD 100, 200, 300
ARRD QWORD 1000, 2000, 3000

.code

_array proc

entry:
	xor RCX, RCX ; zeroing out RCX register. RCX bits are zeroed
	xor RDX, RDX ; zeroing out RDX reigster. RDX bits are zeroed
	xor R8, R8 ; zeroing out R8 register. R8 bits are zeroed
	xor R9, R9 ; zeroing out R9 register. R9 bits are zeroed

	mov CL, ARRA ; moving ARRA at offset 0 which is 1 to CL register
	mov DX, ARRB ; moving ARRB at offset 0 which is 10 to DX register
	mov R8D, ARRC ; moving ARRC at offset 0 which is 100 to R8D register
	mov R9, ARRD ; moving ARRD at offset 0 which is 1000 to R9 register

	mov CL, ARRA + 1 ; moving ARRA at offset of 1 byte which is 2 to CL register
	mov DX, ARRB + 2 ; moving ARRB at offset of 2 bytes (word = 2 byte) which is 20 to DX register
	mov R8D, ARRC + 4 ; moving ARRC at offset of 4 bytes (dword = 4 byte) which is 200 to R8D register
	mov R9, ARRD + 8 ; moving ARRD at offset of 8 bytes (qword = 8 byte) which is 2000 to R9 register

	mov CL, ARRA + (2 * 1) ; moving ARRA at offset of 2 bytes which is 3 to CL register 
	mov DX, ARRB + (2 * 2) ; moving ARRB at offset of 4 bytes which is 30 to DX register
	mov R8D, ARRC + (2 * 4) ; moving ARRC at offset of 8 bytes which is 300 to R8D register
	mov R9, ARRD + (2 * 8) ; moving ARRD at offset of 16 bytes which is 3000 to R9 register

CALL ExitProcess

_array endp

end