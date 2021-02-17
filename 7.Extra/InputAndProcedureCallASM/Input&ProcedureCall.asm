.686
.model flat, c
;Implementation for this Assembly File
;Requires C.c file as well
;extern "C" void GetInput();

includelib msvcrt.lib ;C standard library for the visual c++ (MicroSoft Visual C Runtime)

.data
;10 is new line and 0 is null (ASCIITABLE DEC) prevent getting the full byte in the invocation. Must now specify the Text Offset
	
	;Initializing byte data (8 bit)
	Text db 'Hello enter a single signed digit number: ',10, 0 ; 44 byte
		 db 'Enter another signed single digit number: ',10, 0 ; 44 byte
		 db '--------Result--------',10,0 ; 24 byte

	Operation db 'Addition = ',0 ; 12 bytes
			  db 'Subtraction = ',0 ;15 bytes
			  db 'Multiplication = ',0 ;18 bytes
.code

printf PROTO C : VARARG ; Printf function prototype that take multiple args in C.c
RetrieveInput proto C ; RetrieveInput function prototype in C.c
exit proto C :DWORD	 ; Exit function prototype that take a dword (int) in C.c 
PrintResult proto C :VARARG ; PrintResult function prototype that take multiple args in C.c

;STARTING POINT
GetInput proc 
	
	push ebp ; push the 32 bit base pointer register
	mov ebp, esp ; move the 32 bit stack pointer register to ebp
	sub esp, 8 ; allocate 8 byte of stack space 
	
	xor eax, eax ; clearing out eax register value to 0

	invoke printf, offset Text ; invoking printf function and pass Text without offset so it will print till null value (0)
	invoke RetrieveInput ; invoke RetrieveInput function in C.c and store the return value in eax register
	mov [ebp - 4], eax ; moving the return value from RetreiveInput function call in eax to the first allocated space of the stack space

	invoke printf, offset [Text + 44] ; invoke printf function and pass Text with an offset of 44 byte on the address which will print till the null (0)
	invoke RetrieveInput ; invoke RetrieveInput function in C.c and store the return value in eax register
	mov [ebp - 8], eax ; moving the return value from RetreiveInput function call in eax to the second allocated of the stack space


	; Remember we allocated 8 byte and RetrieveInput return an dword (int) which is 4 byte so we can store two int in the allocated space of esp

	invoke printf, offset [Text + 88]; invoke printf function and pass Text with an offset of 88 byte on the address which will print till the null (0)

	call Calculate ; Call Calculate procedure from GetInput procedure
GetInput endp


Calculate proc

	call SetRegistry ; Call SetRegistry procedure from Calculate
	add eax, ecx ; We add eax and ecx  (first input + second input) and store it in eax

	invoke PrintResult, offset Operation, eax ; invoke PrintResult function that take a char const* and a int to print the operation and value
	
	call SetRegistry ;  Call SetRegistry procedure from Calculate		
	sub eax, ecx ; We subtract eax from ecx (first input - second input) and store it in eax

	invoke PrintResult, offset [Operation + 12], eax ; invoke PrintResult function that take a char const* and a int to print the operation and value

	call SetRegistry ; Call SetRegistry procedure from Calculate
	mul ecx ; We multiply eax with ecx (first input * second input) and store it in eax

	invoke PrintResult, offset [Operation + 27], eax ; invoke PrintResult function that take a char const* and a int to print the operation and value

	add esp,8 ; We de-allocated the 8 byte of stack space
	pop ebp ; We pop the pushed 32 bit base register 

	invoke exit, 0 ; We invoke exit function which take an dword (int) as the exit code
Calculate endp

SetRegistry PROC
	xor eax, eax ; clearing out the eax register value to 0
	xor ecx, ecx ; clearing out the ecx register value to 0

	mov eax, dword ptr [ebp -4] ;eax will have the value that is stored in the first allocated space of esp (first input)
	mov ecx, dword ptr[ebp -8] ;ecx will have the value that is stored in the second allocated space of esp (second input)
	
	ret ; exit out SetRegistry procedure and continue execution of the prodecdure that has called this procedure
SetRegistry endp
end
