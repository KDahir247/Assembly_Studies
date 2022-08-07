includelib kernel32.lib

ExitProcess proto

.data
SRC BYTE 'abc'
.code

main proc
entry:
	xor RAX, RAX ; zeroing out RAX register. RAX bits are zeroed
	xor RCX, RCX ; zeroing out RCX register. RCX bits are zeroed
	xor RDX, RDX ; zeroing out RDX register. RDX bits are zeroed
	xor R8, R8 ; zeroing out R8 register. R8 bits are zeroed
	xor R9, R9 ; zeroing out R9 register. R9 bits are zeroed

	lea RSI, SRC ; load the address to SRC and store in in RSI register (source index)
	mov RDI, RSI ; moving the content of RSI register (source index) to RDI register (destination index)

	mov RCX, SIZEOF SRC ; moving the size of SRC (LENGTHOF SRC * how many bytes) to the RCX register (counter register) 

	cld ; clearing direction flag (0) since we want to move forward in memory and not backward

start:
	lodsb ; load string byte from RSI register (source index) using RCX register (counter) to point to the memory location offset and store in in the RAX register (accumulator)  
	sub AL, 32 ; converting ascii lowercase to upper case by subtracting the store value in RAX (AL since we are working with BYTE) and storing it back to AL (accumulator lower byte)
	stosb ; we are storing the accumulator register to RDI register (destination index) using RCX register (counter) to point to the memory location offset
	dec RCX ; we are decrementing the RCX register (counter) and store it back to RCX register (counter)
	jnz start ; then we are jumping back to start label in RCX is not zero otherwise continue to the body below



	mov DL, SRC  ; move SRC with a offset of 0 which is the first element in SRC to DL. it should be A
	mov R8B, SRC[1] ; move SRC with a offset of 1 which is the second element in SRC to R8B. it should be B
	mov R9B, SRC[2] ; move SRC with a offset of 2 which is the third element in SRC to R9B. it should C




CALL ExitProcess

main endp

end