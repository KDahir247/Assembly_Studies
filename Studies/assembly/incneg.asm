includelib kernel32.lib

ExitProcess proto

.data
	var QWORD 99

.code

_incneg proc
	xor RCX, RCX ; we are zeroing out the RCX registry. RCX has zero filled bits
	inc VAR ; incrementing the VAR data by 1 and storing it back to VAR (100)
	mov RCX, 51 ; we are moving 51 to the RCX registry. RCX now has 51
	dec RCX ; we are decrementing the RCX registry by 1 and storing it back to RCX registry (50)
	neg RCX ; we are reversing the sign of the content in RCX registry and storing it back to RCX registry
CALL ExitProcess

_incneg endp

end