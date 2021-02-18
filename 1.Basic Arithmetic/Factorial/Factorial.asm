.686	
.model flat, stdcall, c
;Implementation for this Assembly File
;Requires C.c file as well
;extern  "C" void Factorial();

; C standarad library for the visual c++ (MicroSoft Visual C Runtime) which we are including
includelib msvcrt.lib

printf PROTO C,  :VARARG ; printf function prototype that take multiple args in C.c
exit PROTO	C, :DWORD	; exit function prototype that take a dword (int) for the exit code in C.c
GetNumber PROTO C ; GetNumber function prototype that has no argument in C.c

.const
	;10 is new line an 0 is null (ASCII TABLE DEC) prevent getting the full byte in invocation of printf. Must specify the offset of description_byte
	description_byte db 'Enter a unsigned number (1 TO 10) to get the factorial value of:',10,0 ; 66 bytes
					 db 'The Factorial of ', 0 ; 18 bytes

	format db '%s %i is %i' ; format style for printf 

.data
	 ; a data that is of type dword (int) with no specified value
	factorial_dword DWORD ?

.code

Factorial proc
	push ebp ; push the 32 bit base pointer register
	mov ebp, esp ; move the 32 bit stack pointer register to ebp

	invoke printf, offset description_byte ; invoke printf function and passing description_byte without offset so it will print till null value(0)
	invoke GetNumber ; invoke GetNumber function and return an input from 1 to 10
	
	mov [factorial_dword], eax ; moving the return value for GetNumber which is located in eax register to the data 'factorial_dword'

	xor	eax, eax ; clearing out eax register to 0
	mov eax, 1 ; setting eax to be equal to 1

	mov ecx, [factorial_dword] ; setting ecx to be equal to the return value stored in 'factorial_dword' for looping

	l1:
	
	mul	ecx ; multiply eax by ecx  ((1 * eax) * (factorial_dword - howmanytimeslooped)) and store it in eax register
	loop l1 ;loop l1 tag until ecx is equal to zero. Also decrement ecx register value by one

	
	;invoke printf function and pass the format data as well as the arguments for the forma 
	; (printf("%s %i is %i", "The Factorial of ", [factorial_dword], eax))
	invoke printf, offset format, offset [description_byte + 66], [factorial_dword], eax 

	pop ebp ; We pop the pushed 32 bit base register 
	invoke	exit, 0 ;invoke exit function with the argument 0 as the exit code to signify the program ran correctly
Factorial endp
end