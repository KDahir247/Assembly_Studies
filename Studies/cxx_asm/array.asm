.data


.code

CalcArraySum proc
entry:
	xor RAX, RAX ; zeroing out RAX. RAX = 0
	test EDX, EDX ; use & bitwise operation on src and dst and set the RFLAG and then discard
	jz invalid_count ; jump to invalid_count label if the zero flag is set

array_loop:
	add RAX, [RCX] ; RAX = RAX + *x( offset )
	add RCX, 4 ; RCX (int ptr) = RCX + 4 (offset the pointer to next element since the size of int in array x is 4 bytes )
	dec RDX ; decrement RDX by 1
	jnz array_loop ; jump to array_loop label if the zero flag is not set 


invalid_count:
	ret
CalcArraySum endp

end