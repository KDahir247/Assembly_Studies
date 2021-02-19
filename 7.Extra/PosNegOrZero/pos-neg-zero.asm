.686
.model flat, c
;Implementation for this Assembly File
;extern "C" void NumPosNegOrZero();

;We are including the microsoft visual c runtime standard library
includelib msvcrt.lib

;prototype function for printf that take var argument 
printf PROTO C, :VARARG
;prototype function for RecieveInput that take no argument but returns an integer
ReceiveInput PROTO C
;prototype function for exit that take a dword (int) as the exit code
exit PROTO C, :DWORD

.const
	introductionByte  db 'Enter a number: ',0
	formatByte db '%s',0

	resultByte 	db 'Negitive',0
				db 'Positive', 0
				db 'Zero',0
.code
NumPosNegOrZero proc
	
	push ebp ;push the 32 bit base pointer register
	mov ebp, esp ;move 32 bit stack pointer to the 32 bit base pointer 
	push ebx ;push the 32 base register
	sub esp, 12 ;allocated 12 byte in the stack space

	xor ecx, ecx ;clearing out the 32 bit count register to be 0

	mov [ebp -4], ecx ;populating the first 4 byte of the 12 byte allocated in the stack space 

	mov ecx, LENGTHOF resultByte ;ecx = the number of byte in result until it reaches the null value (0) (ecx = 9)
	mov [ebp -8], ecx ;populate the second space since the first 4 byte are already used 

	add ecx, ecx ;since 'Negitve',0 and 'Positive',0 has the same Length we can just add ecx with itself  which result in 18 (ecx = 9 + 9)
	mov [ebp -12] , ecx ;populate the last space since the first 4 byte are used and the other second 4 bytes are already used as weell


	;push follow stack orientation

	push offset introductionByte
	push offset formatByte
	
	call printf ;pop the pushed stack so this is equal to invoke printf, offset formatByte, offset introductionByte

	call ReceiveInput ;We get the user input which is handled in C.c. It will call the C.c function that matches the Name and the prototype defined above (ReceiveInput PROTO C)

	test eax, eax ;We preform an and bitwise operation and set the flag depending on the result
	;ZF = 1 (if eax is zero), ZF = 0 (if eax is not zero)
	;PF the parity flag which we are not using
	;SF = 1 (if eax is signed (negitive)), SF = 0 (if wax is not signed (positive))

	cmovns edx, [ebp - 8] ;we do a condition move to edx from what is stored in [ebp -8] which is LENGHTOF resultByte or 9 if and only if the SF = 0 

	cmovs edx, [ebp - 4] ;we do a condition move to edx from what is stored in [ebp -4] which is 0 if and only if the SF = 1

	cmovz edx, [ebp - 12];we preform the zero flag condition move last since it will get overwritten by the cmovs (condition move sign ) so we do this last 
						;we do a condition move to edx  from what is stored in [ebp -12] which is LENGHTOF resultByte + resultByte if and only if the ZF = 1

	lea ebx, [resultByte + edx] ;we load effective address of [resultByte + edx] it is similar to OFFSET [resultByte + edx_value] where it located the load address with an offset given in this example which is store in edx register

	invoke printf, ebx ;invoke printf with the address of ebx. So it will print resultByte string with the specified offset from edx register value

	pop ebx ; pop pushed 32 bit base register
	add esp, 12 ;de-allocated 12 byte from stack space
	pop ebp ; pop pushed 32 bit base pointer register

	invoke exit, 0 ;we invoke exit with the exit code 0 to signify that the program ran correctly
NumPosNegOrZero endp
end
