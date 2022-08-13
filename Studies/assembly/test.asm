includelib kernel32.lib

ExitProcess proto

.data

.code

_test proc
	xor RCX, RCX ; zeroing out RCX registry. RCX bits are set to zero
	mov RCX, 0111b ; moving 7 to RCX registry
	test RCX, 0001b ; do a AND bitwise comparision using RCX and 0001b and setting the zero flag if results in zero (doesn't change value in registry) zr = false
	
	mov RCX, 1000b ; moving 8 to RCX registry
	test RCX, 0001b ; do a AND bitwise comparision using RCX and 0001b and setting the zero flag if results in zero (doesn't change value in registry) zr = true

	mov RCX, 0111b ; moving 7 to RCX registry
	test RCX, 0100b ; do a AND bitwise comparision using RCX and 0100b and setting the zero flag if results in zero (doesn't change value in registry) zr = false

	mov RCX, 1000b ; moving 8 to RCX registry
	test RCX, 0100b ; do a AND bitwise comparision using RCX and 0100b and setting the zero flag if results in zero (doesn't change value in registry) zr = true


CALL ExitProcess

_test endp

end