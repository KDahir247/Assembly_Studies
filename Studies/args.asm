includelib kernel32.lib

ExitProcess proto

.data
ARR QWORD 100, 150, 250

.code

sum proc
entry:
	xor RAX, RAX ; zeroing out RAX register (accumalator). RAX bits are zeroed

start:
	add RAX, [RDX] ; we are adding the value that is stored in the address in RDX to RAX
	add RDX, 8 ; increment RDX by 8, since offseting 8 byte will retrieve then next element (QWORD) and storing it back to RDX to point to the next element
	dec RCX ; decrementing RCX register (counter) by 1 and storing it back to RCX
	jnz start ; jump back to start label if RCX register (counter) is not zero, otherwise continue with the instruction below

	ret  ;return from where the procedure was called.

sum endp

_args proc
entry:
	mov RCX, LENGTHOF ARR ; moving lenght of ARR (3) to RCX register (counter)
	lea RDX, ARR ; we are loading the address to ARR and storing it RDX register 

	call sum ; call sum procedure.


CALL ExitProcess

_args endp

end