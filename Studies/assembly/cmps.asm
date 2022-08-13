includelib kernel32.lib

ExitProcess proto

.data
SRC BYTE 'abc'
DST BYTE 'abc'
DIFF BYTE 1
.code

main proc
entry:
	xor RCX, RCX ; zeroing out RCX register. RCX bits are zeroed
	
	mov RCX, SIZEOF SRC ; moving size of SRC (LENGTHOF * how many byte per elem) to RCX register (counter)

	lea RSI, SRC ; we are loading the address of SRC and storing it in RSI register (source index)
	lea RDI, DST ; we are loading the address of DST and storing it in RDI register (destination index)

	cld ; clearing direction flag, since we want to move forward in memory and not backward

	repe cmpsb ; repeat until the counter register (RCX) is zero or equal. cmpsb will compare each byte in memory between RSI and RDI and set the zero flag if they are all eq otherwise zero flag is 0


	jnz complete  ; jump if the zero flag is not set (0) to complete  

	mov DIFF, 0 ; if the conditional jump hasn't jumped we know that they are both the same and mov 0 to DIFF (DIFF = false) 


complete:


CALL ExitProcess

main endp

end