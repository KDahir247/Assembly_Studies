includelib kernel32.lib

ExitProcess proto

.data

.code

_jcond proc

;	JZ	Jump if zero flag is set ZR = 1
;	JNZ Jump if zero flag is not set ZR = 0
;	JC	Jump if carry flag is set CY = 1
;	JNC Jump if carry flag is not set CY = 0
;	JO	Jump if overflow flag is set OV = 1
;	JNO	Jump if overflow flag is not set OV = 0
;	JS	Jump if sign flag is set PL = 1
;	JNS Jump if sign flag is not set PL = 0

	entry:
		xor RDX, RDX ; zeroing out RDX registry. RDX bits are set to zero
		mov CL, 255 ; setting the lower byte of RCX to 255
		add CL, 1 ; adding 1 to the lower byte of RCX which should carry since a max value for a byte is 255
		jc carry ; jump to the label carray if the carry flag is set to true
		mov RDX, 1 ; ignored


	carry:
		mov CL, -128 ; moving -128 to the lower byte of RCX which will treat is as signed
		sub CL, 1 ; subtract 1 with the content with CL which will cause a overflow.
		jo overflow ; jump to the label overflow if the overflow flag is set true
		mov RDX, 2 ; ignored



	overflow:
		mov CL, 255	; move 255 to the lower RCX registry byte
		and CL, 10000000b ; do a & bitwise on CL (255) and 10000000b (11111111b & 10000000b)  CL is 128
		js sign ; jump to the label sign if the sign flag is set true
		mov RDX, 3 ; ignored

	sign:
		JNZ notzero ; jump to to the label if the zero flag is set false
		mov RDX, 4 ; ignored


	notzero:

CALL ExitProcess

_jcond endp

end