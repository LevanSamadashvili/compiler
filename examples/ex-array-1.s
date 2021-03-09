	.globl  printNum
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
main:
	pushq   %rbp
	movq    %rsp, %rbp
	movq    $3, %rax
	movq    $4, %rax
	subq    $48, %rsp
	movq    $1, %rax
	movl    %eax, -48(%rbp)
	movq    $2, %rax
	movl    %eax, -44(%rbp)
	movq    $3, %rax
	movl    %eax, -40(%rbp)
	movq    $4, %rax
	movl    %eax, -36(%rbp)
	movq    $5, %rax
	movl    %eax, -32(%rbp)
	movq    $6, %rax
	movl    %eax, -28(%rbp)
	movq    $7, %rax
	movl    %eax, -24(%rbp)
	movq    $8, %rax
	movl    %eax, -20(%rbp)
	movq    $9, %rax
	movl    %eax, -16(%rbp)
	movq    $10, %rax
	movl    %eax, -12(%rbp)
	movq    $11, %rax
	movl    %eax, -8(%rbp)
	movq    $12, %rax
	movl    %eax, -4(%rbp)
	subq    $4, %rsp
	movq    $0, %rax
	movl    %eax, -52(%rbp)
_L_8:
	movslq  -52(%rbp), %rax
	pushq   %rax
	movq    $3, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_10
	subq    $4, %rsp
	movq    $0, %rax
	movl    %eax, -56(%rbp)
_L_11:
	movslq  -56(%rbp), %rax
	pushq   %rax
	movq    $4, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_13
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -52(%rbp), %rax
	imul    $4, %rax
	addq    %rax, %r8
	movslq  -56(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -48(%rbp), %rcx
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
_L_12:
	movslq  -56(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -56(%rbp)
	jmp     _L_11
_L_13:
	addq    $4, %rsp
_L_9:
	movslq  -52(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -52(%rbp)
	jmp     _L_8
_L_10:
	addq    $4, %rsp
	movq    $0, %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
