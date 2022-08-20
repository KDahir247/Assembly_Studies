.data


.code

calc_matrix_row_col_sums proc frame
; extern "C" int calc_matrix_row_col_sums(int* row_sums, int* col_sums, const int* x, int nrows, int ncols);
; RCX = int* row_sums
; RDX = int* col_sums
; R8 = const int* x
; R9 = nrows
; [RSP + 64] = ncols


prolog:
	; push non-volitale register to stack to persevere the old data
	push RSI
	.pushreg RSI
	push RDI
	.pushreg RDI
	push RBX
	.pushreg RBX
	.endprolog

entry:
	xor RAX, RAX ; RAX = 0

	cmp R9, 0 ; wanted to use test, but thought about the data we are using a int and we need to handle if nrows is negative not just zero. 
	jle epilog ; jump to label epilog if R9 < 0

	movsxd R10, DWORD PTR [RSP + 64] ; move ncols to R10 and set the rest of the bits to the signed value of ncols 
									 ; Eg. ncols = 5, R10(HEX) = 0000000000000005, ncols = -5, R10(HEX) = FFFFFFFFFFFFFFFB
									 
	cmp R10, 0 ; compare R10 with 0
	jle epilog ; jump to label epilog if R10 < 0

	cld ; clear direction flag increment RDI by 4 bytes rather then potentially decrementing.

	mov RSI, RCX ; RSI = row_sums (int*)
	mov RDI, RDX ; RDI = col_sums (int*)
	mov ECX, R10D ; ECX = ncols
	rep stosd ; RDI (col_sums) = RAX. increment it by RCX times and move RDI by 4 bytes offset for next value for RCX times 
	
	mov RDI, RDX ; reset RDI to RDX col_sum (int*), since rep stosd increment RDI by 4 bytes we reset it to the init array pos

	xor RDX, RDX ; RDX = 0

	; RCX to be the loop for inner
	; RDX to be the loop for outer
	
outer_loop:
	mov DWORD PTR[RSI + RCX * 4], 0 ; row_sums[RCX (i)] = 0

	xor RDX, RDX ; j = 0. inner loop var counter

	mov RBX, RCX ; RBX = i
	imul RBX, R10 ; RBX = i * ncols

inner_loop:
	mov RAX, RBX ;  RAX = i * ncols
	add RAX, RDX ; RAX = (i * ncols) + RDX (j)	
	mov EAX, DWORD PTR[R8 + RAX * 4] ; EAX = x[RAX ((i * ncols) + RDX (j))] 

	add [RSI + RCX * 4], RAX ; row_sums[RCX (i)] = EAX
	add [RDI + RDX * 4], RAX ; col_sum[RDX (j)] = EAX

	inc RDX ; RDX = RDX + 1
	cmp RDX, R10 ; compare RDX to ncols
	jl inner_loop ; jump to inner_loop if RDX < numcols

	inc RCX ; RCX = RCX + 1
	cmp RCX, R9 ; compare RCX to nrows
	jl outer_loop ; jump to outer_loop if RCX < numrows


mov RAX, 1 ; RAX = 1. RAX is the accumalator and return value for function.

epilog:
	; pop non-volitale register to restore data
	pop RBX
	pop RDI
	pop RSI
	ret
calc_matrix_row_col_sums endp

end
