.686
.model flat, c
;Implementation for this Assembly File
;extern "C" void printhelloassembly();

includelib msvcrt.lib ;C standard library for the visual c++ (MicroSoft Visual C Runtime)

.data

mymsg BYTE "hello world from assembly",0 ; message
format byte "%s" ; format

.code
printf PROTO C, :VARARG ; printf prototype function
exit PROTO C, :DWORD ;exit prototype function. take a int 

printhelloassembly proc

	push offset mymsg ;pushes the offset address of mymsg to read from
	push offset format ;pushes the offset address of format to read from

	call printf ;Printf(format, mymsg)
	
	;return 1234 exit code
	invoke exit, 1234 ;invoking exit and explicitly passing the dword(int). using call will use pushed value while invoke require you to pass them with the instruction
	
printhelloassembly endp
end



