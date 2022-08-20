.data


.code

calc_sqr_matrix proc frame
; extern "C" void calc_sqr_matrix(int* y, const int* x, int nrows, int ncols);

prolog:
	; push non-volitale register to stack to persevere the old data 
	push RSI
	.pushreg RSI
	push RDI
	.pushreg RDI
	.endprolog

	; handle case where nrows and/or ncols is zero
	test R8D, R8D ; AND bitwise operation from src and dst and set the RFLAG then throw away result
	jz epilog ; jmp to epilog if zero flag is set

	test R9D, R9D ; AND bitwise operation from src and dst and set the RFLAG then throw away result
	jz epilog ; jmp to epilog if zero flag is set
	

	mov RSI, RDX ; rsi = x (const int*)
	mov RDI, RCX ; rdi = y (int*)
	xor RCX, RCX ; RCX = 0

	; loop and inner loop logic

; RDX is J inner loop counter
; RCX is I outer loop counter
outer_loop: 
	xor RDX, RDX ; RDX = 0. 
inner_loop: 
	mov RAX, RDX ; RAX = j
	imul RAX, R9 ; RAX = j * num_col
	add RAX, RCX ; RAX = j * num_col + i
	mov R10D, DWORD PTR[RSI+RAX *4] ; R10D = x[rax]
	imul R10D, R10D ; R10D = R10D * R10D
	
	mov RAX, RCX ; RAX = i
	imul RAX, R9 ; RAX = i * num_col
	add RAX, RDX ; RAX = i * num_col + j
	mov DWORD PTR[RDI + RAX * 4], R10D ; y[rax] = R10D

	inc RDX ; RDX = RDX + 1
	cmp RDX, R9 ; cmp RDX with num col
	jl inner_loop ; jmp to inner_loop if RDX < num_col 
	
	inc RCX ; RCX = RCX + 1
	cmp RCX, R8 ; cmp RCX with num row
	jl outer_loop ; jmp to outer_loop if RCX < num_row
	

epilog:
	; pop non-volitale register to restore data
	pop rdi
	pop rsi

	ret
calc_sqr_matrix endp

end
