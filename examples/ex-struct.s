	.globl  printNum
	.globl  alterCar
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
	movq    $30, %rax
alterCar:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $10, %rax
	popq    %rcx
	movb    %al, (%rcx)
	movq    -8(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $30, %rax
	popq    %rcx
	movb    %al, (%rcx)
	movq    %rbp, %rsp
	popq    %rbp
	ret
main:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $1, %rsp
	movq    $10, %rax
	movb    %al, -1(%rbp)
	subq    $56, %rsp
	subq    $56, %rsp
	leaq    -57(%rbp), %rax
	movq    %rax, %rcx
	movq    0(%rcx), %rax
	movq    %rax, -113(%rbp)
	movq    8(%rcx), %rax
	movq    %rax, -105(%rbp)
	movq    16(%rcx), %rax
	movq    %rax, -97(%rbp)
	movq    24(%rcx), %rax
	movq    %rax, -89(%rbp)
	movq    32(%rcx), %rax
	movq    %rax, -81(%rbp)
	movq    40(%rcx), %rax
	movq    %rax, -73(%rbp)
	movq    48(%rcx), %rax
	movq    %rax, -65(%rbp)
	movq    $30, %rax
	subq    $1680, %rsp
	leaq    -57(%rbp), %rax
	movq    %rax, %rcx
	movq    0(%rcx), %rax
	movq    %rax, -1793(%rbp)
	movq    8(%rcx), %rax
	movq    %rax, -1785(%rbp)
	movq    16(%rcx), %rax
	movq    %rax, -1777(%rbp)
	movq    24(%rcx), %rax
	movq    %rax, -1769(%rbp)
	movq    32(%rcx), %rax
	movq    %rax, -1761(%rbp)
	movq    40(%rcx), %rax
	movq    %rax, -1753(%rbp)
	movq    48(%rcx), %rax
	movq    %rax, -1745(%rbp)
	leaq    -57(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $3, %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	imul    %rcx, %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	imul    %rcx, %rax
	popq    %rcx
	movb    %al, (%rcx)
	leaq    -57(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $2, %rax
	pushq   %rax
	movq    $2, %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	popq    %rcx
	imul    %rcx, %rax
	popq    %rcx
	movb    %al, (%rcx)
	leaq    -57(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $1998, %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	imul    %rcx, %rax
	popq    %rcx
	movw    %ax, (%rcx)
	leaq    -57(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $242340, %rax
	pushq   %rax
	movq    $3, %rax
	pushq   %rax
	movq    $2, %rax
	pushq   %rax
	movq    $2, %rax
	popq    %rcx
	pushq   %rax
	movq    %rcx, %rax
	popq    %rcx
	cqo
	idivq   %rcx
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	popq    %rcx
	imul    %rcx, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	leaq    -57(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $3000, %rax
	popq    %rcx
	movl    %eax, (%rcx)
	leaq    -57(%rbp), %rax
	movq    %rax, %r9
	addq    $2, %r9
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $1, %rax
	leaq    2(%r9), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $25, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $0, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	addq    $42, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $5, %rax
	popq    %rcx
	movl    %eax, (%rcx)
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $0, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %r9
	addq    $2, %r9
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $1, %rax
	leaq    2(%r9), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $25, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -57(%rbp), %rax
	leaq    -57(%rbp), %rax
	movq    %rax, %rdi
	callq   alterCar
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
	leaq    -57(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -57(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -57(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
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
	leaq    -57(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
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
	leaq    -57(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
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
	leaq    -57(%rbp), %rax
	movq    %rax, %r9
	addq    $2, %r9
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $1, %rax
	leaq    2(%r9), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	movsbq  -1(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	leaq    -113(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $2, %rax
	popq    %rcx
	movb    %al, (%rcx)
	leaq    -113(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $3, %rax
	popq    %rcx
	movb    %al, (%rcx)
	leaq    -113(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $1968, %rax
	popq    %rcx
	movw    %ax, (%rcx)
	leaq    -113(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $24234023, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	leaq    -113(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $3250, %rax
	popq    %rcx
	movl    %eax, (%rcx)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -113(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -113(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -113(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
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
	leaq    -113(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
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
	leaq    -113(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
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
	movsbq  -1(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $0, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rcx
	pushq   %rcx
	leaq    -57(%rbp), %rax
	popq    %rcx
	movq    %rax, %rdx
	movq    0(%rdx), %rax
	movq    %rax, 0(%rcx)
	movq    8(%rdx), %rax
	movq    %rax, 8(%rcx)
	movq    16(%rdx), %rax
	movq    %rax, 16(%rcx)
	movq    24(%rdx), %rax
	movq    %rax, 24(%rcx)
	movq    32(%rdx), %rax
	movq    %rax, 32(%rcx)
	movq    40(%rdx), %rax
	movq    %rax, 40(%rcx)
	movq    48(%rdx), %rax
	movq    %rax, 48(%rcx)
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rcx
	pushq   %rcx
	leaq    -113(%rbp), %rax
	popq    %rcx
	movq    %rax, %rdx
	movq    0(%rdx), %rax
	movq    %rax, 0(%rcx)
	movq    8(%rdx), %rax
	movq    %rax, 8(%rcx)
	movq    16(%rdx), %rax
	movq    %rax, 16(%rcx)
	movq    24(%rdx), %rax
	movq    %rax, 24(%rcx)
	movq    32(%rdx), %rax
	movq    %rax, 32(%rcx)
	movq    40(%rdx), %rax
	movq    %rax, 40(%rcx)
	movq    48(%rdx), %rax
	movq    %rax, 48(%rcx)
	subq    $4, %rsp
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $0, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	movl    %eax, -1797(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -1797(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $56, %rax
	leaq    -1793(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	movl    %eax, -1797(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -1797(%rbp), %rax
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
	movsbq  -1(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $8, %rsp
	leaq    -57(%rbp), %rax
	leaq    -57(%rbp), %rax
	movq    %rax, -1805(%rbp)
	movq    -1805(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $4, %rax
	popq    %rcx
	movb    %al, (%rcx)
	movq    -1805(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -1805(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
	pushq   %rax
	movq    $2, %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	popq    %rcx
	movw    %ax, (%rcx)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -57(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -57(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -57(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
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
	leaq    -57(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
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
	leaq    -57(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
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
	movsbq  -1(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	leaq    -113(%rbp), %rax
	leaq    -113(%rbp), %rax
	movq    %rax, -1805(%rbp)
	movq    -1805(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $5000, %rax
	popq    %rcx
	movl    %eax, (%rcx)
	movq    -1805(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -1805(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	pushq   %rax
	movq    $2, %rax
	popq    %rcx
	imul    %rcx, %rax
	popq    %rcx
	movl    %eax, (%rcx)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -113(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -113(%rbp), %rax
	addq    $1, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movb    (%rcx), %al
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
	leaq    -113(%rbp), %rax
	addq    $32, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movw    (%rcx), %ax
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
	leaq    -113(%rbp), %rax
	addq    $34, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
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
	leaq    -113(%rbp), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
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
	movsbq  -1(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    -1805(%rbp), %rax
	addq    $46, %rax
	movq    %rax, %rcx
	pushq   %rcx
	leaq    -57(%rbp), %rax
	leaq    -57(%rbp), %rax
	popq    %rcx
	movq    %rax, (%rcx)
	subq    $4, %rsp
	movq    -1805(%rbp), %rax
	addq    $46, %rax
	movq    (%rax), %rax
	addq    $42, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	movl    %eax, -1809(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -1809(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    %rbp, %rsp
	popq    %rbp
	ret
