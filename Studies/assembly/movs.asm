includelib kernel32.lib

ExitProcess proto

.data
SRC BYTE 'abc'
DST BYTE 3 DUP (?)
.code

_movs proc

entry:
	xor RDX, RDX ; zeroing out RDX register. RDX bits are zeroed
	xor R8, R8 ; zeroing out R8 register. R8 bits are zeroed
	xor R9, R9 ; zeroing out R9 register. R9 bits are zeroed

	lea RSI, SRC ; we are loading the address of SRC and moving it to the RSI register (Source index)
	lea RDI, DST ; we are loading the address of DST and moving it to the RDI register (Destination index)

	mov RCX, SIZEOF SRC ; we are moving the amount of byte SRC has in this case 3 to RCX register
	cld ; we are clearing the direction flag since we want to move forward in memory and not backward 
	rep movsb ; repeat instruction RCX times. The instruction is mov string byte from RSI to RDI and increment one byte in memory at a time

	mov DL, DST ; we are getting the value from the address DST with no byte offset (a)
	mov R8B, DST[1] ; we are getting the value from the address DST with 1 byte offset (b)
	mov R9B, DST[2] ; we are getting the value from the address DST with 2 byte offset (c)


CALL ExitProcess

_movs endp

end