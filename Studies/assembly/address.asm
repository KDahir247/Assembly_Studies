includelib kernel32.lib

ExitProcess proto

.data
A BYTE 10
B BYTE 20
C BYTE 30
D BYTE 40

.code

_address proc

entry:
	xor RDX, RDX ; zeroing out RDX register. RDX bits are zerod
	xor RAX, RAX ; zeroing out RAX register. RAX bits are zerod

	mov AL, A ; moving A intermediate value (10) to AL lower byte 
	mov AH, A + 3 ; moving A + 3 (13) to AL higher byte

	lea RCX, B ; we are loading the effective address of B so RCX will have the address to B


	mov DL, [RCX] ; we are getting B and store it to DL lower byte
	mov DH, [RCX + 1] ; we are getting and offset of 1 from B which will result to C and store it to DH lower byte

CALL ExitProcess

_address endp

end