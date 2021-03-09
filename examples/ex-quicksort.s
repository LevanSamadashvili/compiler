	.globl  printNum
	.globl  printArray
	.globl  swap
	.globl  partition
	.globl  quicksort
	.globl  main
printNum:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $4, %rsp
	movl    %edi, -4(%rbp)
	movslq  -4(%rbp), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_1
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    $69, %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	jmp     _L_0
_L_1:
	movslq  -4(%rbp), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	sete    %al
	cmpq    $0, %rax
	je      _L_2
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    $48, %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
_L_2:
_L_0:
	movq    $100, %rax
	subq    $100, %rsp
	subq    $4, %rsp
	movq    $0, %rax
	movl    %eax, -108(%rbp)
_L_3:
	movslq  -4(%rbp), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setg    %al
	cmpq    $0, %rax
	je      _L_4
	subq    $4, %rsp
	movslq  -4(%rbp), %rax
	pushq   %rax
	movq    $10, %rax
	popq    %rcx
	pushq   %rax
	movq    %rcx, %rax
	popq    %rcx
	cqo
	idivq   %rcx
	movq    %rdx, %rax
	movl    %eax, -112(%rbp)
	movslq  -4(%rbp), %rax
	pushq   %rax
	movq    $10, %rax
	popq    %rcx
	pushq   %rax
	movq    %rcx, %rax
	popq    %rcx
	cqo
	idivq   %rcx
	movl    %eax, -4(%rbp)
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -108(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $1, %rax
	leaq    -104(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rcx
	pushq   %rcx
	movslq  -112(%rbp), %rax
	pushq   %rax
	movq    $48, %rax
	popq    %rcx
	addq    %rcx, %rax
	popq    %rcx
	movb    %al, (%rcx)
	movslq  -108(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -108(%rbp)
	addq    $4, %rsp
	jmp     _L_3
_L_4:
	subq    $4, %rsp
	movslq  -108(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	movl    %eax, -112(%rbp)
_L_5:
	movslq  -112(%rbp), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setge   %al
	cmpq    $0, %rax
	je      _L_7
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -112(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $1, %rax
	leaq    -104(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
_L_6:
	movslq  -112(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	movl    %eax, -112(%rbp)
	jmp     _L_5
_L_7:
	addq    $4, %rsp
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    $10, %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    %rbp, %rsp
	popq    %rbp
	ret
printArray:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $4, %rsp
	movl    %esi, -12(%rbp)
	subq    $4, %rsp
	movq    $0, %rax
	movl    %eax, -16(%rbp)
_L_8:
	movslq  -16(%rbp), %rax
	pushq   %rax
	movslq  -12(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_10
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	movslq  -16(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
_L_9:
	movslq  -16(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -16(%rbp)
	jmp     _L_8
_L_10:
	addq    $4, %rsp
	movq    %rbp, %rsp
	popq    %rbp
	ret
swap:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $8, %rsp
	movq    %rsi, -16(%rbp)
	subq    $4, %rsp
	movq    -8(%rbp), %rax
	movslq  (%rax), %rax
	movl    %eax, -20(%rbp)
	movq    -8(%rbp), %rax
	pushq   %rax
	movq    -16(%rbp), %rax
	movslq  (%rax), %rax
	popq    %rcx
	movl    %eax, (%rcx)
	movq    -16(%rbp), %rax
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	movl    %eax, (%rcx)
	movq    %rbp, %rsp
	popq    %rbp
	ret
partition:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $4, %rsp
	movl    %esi, -12(%rbp)
	subq    $4, %rsp
	movl    %edx, -16(%rbp)
	subq    $4, %rsp
	pushq   %rcx
	pushq   %r8
	movslq  -12(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	movl    %eax, -20(%rbp)
	subq    $4, %rsp
	movslq  -12(%rbp), %rax
	movl    %eax, -24(%rbp)
	subq    $4, %rsp
	movslq  -12(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -28(%rbp)
	subq    $4, %rsp
	movslq  -16(%rbp), %rax
	movl    %eax, -32(%rbp)
_L_11:
	movslq  -28(%rbp), %rax
	pushq   %rax
	movslq  -32(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_12
_L_13:
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_14
	movslq  -28(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -28(%rbp)
	jmp     _L_13
_L_14:
_L_15:
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setg    %al
	cmpq    $0, %rax
	je      _L_16
	movslq  -32(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	movl    %eax, -32(%rbp)
	jmp     _L_15
_L_16:
	movslq  -28(%rbp), %rax
	pushq   %rax
	movslq  -32(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setge   %al
	cmpq    $0, %rax
	je      _L_17
	jmp     _L_12
_L_17:
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rdi
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rsi
	callq   swap
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movslq  -28(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -28(%rbp)
	movslq  -32(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	movl    %eax, -32(%rbp)
	jmp     _L_11
_L_12:
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_19
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	movslq  -24(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -24(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rdi
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -32(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rsi
	callq   swap
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movslq  -32(%rbp), %rax
	movl    %eax, -24(%rbp)
	jmp     _L_18
_L_19:
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setge   %al
	cmpq    $0, %rax
	je      _L_20
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	movslq  -24(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -24(%rbp), %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rdi
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	movslq  -28(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	imul    $4, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rsi
	callq   swap
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movslq  -28(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	movl    %eax, -24(%rbp)
_L_20:
_L_18:
	movslq  -24(%rbp), %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
quicksort:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $4, %rsp
	movl    %esi, -12(%rbp)
	subq    $4, %rsp
	movl    %edx, -16(%rbp)
	movslq  -12(%rbp), %rax
	pushq   %rax
	movslq  -16(%rbp), %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setge   %al
	cmpq    $0, %rax
	je      _L_21
	movq    %rbp, %rsp
	popq    %rbp
	ret
_L_21:
	subq    $4, %rsp
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -8(%rbp), %rax
	movq    %rax, %rdi
	movslq  -12(%rbp), %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	movslq  -16(%rbp), %rax
	xorq    %rdx, %rdx
	movl    %eax, %edx
	callq   partition
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movl    %eax, -20(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -8(%rbp), %rax
	movq    %rax, %rdi
	movslq  -12(%rbp), %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	movslq  -20(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	xorq    %rdx, %rdx
	movl    %eax, %edx
	callq   quicksort
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -8(%rbp), %rax
	movq    %rax, %rdi
	movslq  -20(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	movslq  -16(%rbp), %rax
	xorq    %rdx, %rdx
	movl    %eax, %edx
	callq   quicksort
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    %rbp, %rsp
	popq    %rbp
	ret
main:
	pushq   %rbp
	movq    %rsp, %rbp
	movq    $10, %rax
	subq    $40, %rsp
	movq    $10, %rax
	movl    %eax, -40(%rbp)
	movq    $8, %rax
	movl    %eax, -36(%rbp)
	movq    $9, %rax
	movl    %eax, -32(%rbp)
	movq    $1, %rax
	movl    %eax, -28(%rbp)
	movq    $5, %rax
	movl    %eax, -24(%rbp)
	movq    $2, %rax
	movl    %eax, -20(%rbp)
	movq    $2, %rax
	movl    %eax, -16(%rbp)
	movq    $3, %rax
	movl    %eax, -12(%rbp)
	movq    $4, %rax
	movl    %eax, -8(%rbp)
	movq    $4, %rax
	movl    %eax, -4(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -40(%rbp), %rax
	leaq    -40(%rbp), %rax
	movq    %rax, %rdi
	movq    $0, %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	movq    $9, %rax
	xorq    %rdx, %rdx
	movl    %eax, %edx
	callq   quicksort
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -40(%rbp), %rax
	leaq    -40(%rbp), %rax
	movq    %rax, %rdi
	movq    $10, %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	callq   printArray
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    $0, %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
