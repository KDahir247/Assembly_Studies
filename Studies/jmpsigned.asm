includelib kernel32.lib

ExitProcess proto

.data

.code

_jmpsigned proc
;	JG	Jump if left operand is greater than right operand
;	JNLE Jump if left operand is not less then or equal to the right operand
;	JGE	Jump if left operand is greater than or equal to the right operand
;	JNL	Jump if left operand is not less than the right operand
;	JL	Jump if left operand is less than right operand
;	JNGE	Jump if left operand is not greater then or equal to the right operand
;	JLE	Jump if left operand is less then or equal to the right operand
;	JNG	Jump is left operand is not greater then to the right operand

entry:
	xor RDX, RDX ; zeroing out RDX registry. RDX bits are set to zero
	
	mov RBX,  -4 ; moving -4 to RBX register
	mov RCX, -1 ; moving -1 to RCX register

	cmp RCX, RBX ; comparing RCX register with RBX register
	jg greater ; jump to label if RCX is greater then RBX
	
	mov RDX, 1 ; ignored


greater:
	mov RCX, -16 ; moving -16 to RCX register
	cmp RCX, RBX ; comparing RCX register with RBX register
	jl less ; jump to label if RCX is less then RBX

	mov RDX, 2 ; ignored


less:
	mov RCX, -4 ; moving -4 to RCX register
	cmp RCX, RBX ; comparing RCX register with RBX register
	jle equal ; jump to label if RCX is less then or equal to RBX

	mov RDX, 3 ; ignored


equal:
	cmp RCX, RBX ; comparing RCX register with RBX register
	jnle not_less_or_equal ; jump to label if RCX is not less then or equal to RBX ignored

	mov RDX, 4 ; moving 4 to RDX register



not_less_or_equal:

CALL ExitProcess

_jmpsigned endp

end