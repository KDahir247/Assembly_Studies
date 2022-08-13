includelib kernel32.lib

ExitProcess proto

.data

.code

_cmp proc

;	JE	Jump if left operand is == right operand
;	JNE Jump if left operand is != right operand
;	JA	Jump if left operand is above right operand
;	JNBE	Jump if left operand is below or equal right operand
;	JAE	Jump if left operand is above or equal right operand
;	JNB	Jump if left operand is not below right operand
;	JB	Jump if left operand is below right operand
;	JNAE	Jump if let operand is not above or equal to right operand
;	JBE	Jump if left operand is below or equal right operand


entry:
	xor RDX, RDX ; zeroing out RDX registry. RDX bits are set to zero
	mov RBX, 100 ; moving 100 to RBX registry (64h)
	mov RCX, 200 ; moving 200 to RCX registry (C8h)
	cmp RCX, RBX ; comparing RCX registry with RBX registry
	ja above ; jump if left operand is above right operand in this case it is true

	mov RDX, 1 ; ignored


above:
	mov RCX, 50	; moving 50 to the RCX registry (32h)

	cmp RCX, RBX ; comparing RCX registry with RBX registr
	jb equal ; jump if left operand is below right operand in this case it is true
	
	mov RDX, 2 ; ignored


equal:

CALL ExitProcess

_cmp endp

end