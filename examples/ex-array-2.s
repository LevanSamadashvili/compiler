	.globl  printNum
	.globl  printArray
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
	subq    $8, %rsp
	movq    -8(%rbp), %rax
	pushq   %rax
	movslq  -16(%rbp), %rax
	popq    %rcx
	imul    $2, %rax
	addq    %rcx, %rax
	movq    %rax, -24(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -24(%rbp), %rax
	movswq  (%rax), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
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
	pushq   %rcx
	pushq   %r8
	movslq  -16(%rbp), %rax
	imul    $2, %rax
	movq    -8(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
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
	addq    $8, %rsp
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
main:
	pushq   %rbp
	movq    %rsp, %rbp
	movq    $5, %rax
	subq    $10, %rsp
	movq    $1, %rax
	movw    %ax, -10(%rbp)
	movq    $2, %rax
	movw    %ax, -8(%rbp)
	movq    $3, %rax
	movw    %ax, -6(%rbp)
	movq    $4, %rax
	movw    %ax, -4(%rbp)
	movq    $5, %rax
	movw    %ax, -2(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -10(%rbp), %rax
	leaq    -10(%rbp), %rax
	movq    %rax, %rdi
	movq    $5, %rax
	xorq    %rsi, %rsi
	movl    %eax, %esi
	callq   printArray
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $2, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $2, %rax
	leaq    -10(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rcx
	pushq   %rcx
	movq    $4, %rax
	popq    %rcx
	movw    %ax, (%rcx)
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $2, %rax
	leaq    -10(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rcx
	pushq   %rcx
	movq    $4, %rax
	popq    %rcx
	movw    %ax, (%rcx)
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
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -10(%rbp), %rax
	leaq    -10(%rbp), %rax
	movq    %rax, %rdi
	movq    $5, %rax
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
