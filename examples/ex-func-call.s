	.globl  printNum
	.globl  sumNumbers
	.globl  func
	.globl  abs
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
sumNumbers:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $4, %rsp
	movl    %edi, -4(%rbp)
	subq    $4, %rsp
	movl    %esi, -8(%rbp)
	subq    $4, %rsp
	movl    %edx, -12(%rbp)
	subq    $4, %rsp
	movl    %ecx, -16(%rbp)
	subq    $4, %rsp
	movl    %r8d, -20(%rbp)
	subq    $4, %rsp
	movl    %r9d, -24(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -4(%rbp), %rax
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
	movslq  -8(%rbp), %rax
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
	movslq  -12(%rbp), %rax
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
	movslq  -16(%rbp), %rax
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
	movslq  -20(%rbp), %rax
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
	movslq  -24(%rbp), %rax
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
	movslq  16(%rbp), %rax
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
	movslq  20(%rbp), %rax
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
	movslq  24(%rbp), %rax
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
	movslq  28(%rbp), %rax
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
	movslq  32(%rbp), %rax
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
	movslq  36(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movslq  -4(%rbp), %rax
	pushq   %rax
	movslq  -8(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  -12(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  -16(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  -20(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  -24(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  16(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  20(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  24(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  28(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  32(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	pushq   %rax
	movslq  36(%rbp), %rax
	popq    %rcx
	addq    %rcx, %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
func:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	movq    -8(%rbp), %rax
	movslq  (%rax), %rax
	movq    %rax, %rcx
	movsbq  %cl, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
abs:
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
	je      _L_8
	movslq  -4(%rbp), %rax
	neg     %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
_L_8:
	movslq  -4(%rbp), %rax
	movq    %rax, %rcx
	movslq  %ecx, %rax
	movq    %rbp, %rsp
	popq    %rbp
	ret
main:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $4, %rsp
	movq    $10, %rax
	movl    %eax, -4(%rbp)
	subq    $4, %rsp
	movq    $127, %rax
	movl    %eax, -8(%rbp)
	subq    $1, %rsp
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -8(%rbp), %rax
	leaq    -8(%rbp), %rax
	movq    %rax, %rdi
	callq   func
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movb    %al, -9(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movsbq  -9(%rbp), %rax
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
	movslq  -4(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   putchar
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    $12, %rax
	subq    $48, %rsp
	movq    $1, %rax
	movl    %eax, -57(%rbp)
	movq    $2, %rax
	neg     %rax
	movl    %eax, -53(%rbp)
	movq    $3, %rax
	neg     %rax
	movl    %eax, -49(%rbp)
	movq    $4, %rax
	movl    %eax, -45(%rbp)
	movq    $5, %rax
	movl    %eax, -41(%rbp)
	movq    $6, %rax
	neg     %rax
	movl    %eax, -37(%rbp)
	movq    $7, %rax
	movl    %eax, -33(%rbp)
	movq    $8, %rax
	neg     %rax
	movl    %eax, -29(%rbp)
	movq    $9, %rax
	neg     %rax
	movl    %eax, -25(%rbp)
	movq    $10, %rax
	neg     %rax
	movl    %eax, -21(%rbp)
	movq    $11, %rax
	movl    %eax, -17(%rbp)
	movq    $12, %rax
	movl    %eax, -13(%rbp)
	subq    $4, %rsp
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $0, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %rdi, %rdi
	movl    %eax, %edi
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $1, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %rsi, %rsi
	movl    %eax, %esi
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $2, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %rdx, %rdx
	movl    %eax, %edx
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $3, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %rcx, %rcx
	movl    %eax, %ecx
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $4, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %r8, %r8
	movl    %eax, %r8d
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $5, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	xorq    %r9, %r9
	movl    %eax, %r9d
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $11, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $10, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $9, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $8, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $7, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movq    $6, %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $4, %rax
	leaq    -57(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	movl    (%rcx), %eax
	popq    %r8
	popq    %rcx
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   abs
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	subq    $4, %rsp
	movl    %eax, (%rsp)
	callq   sumNumbers
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	addq    $24, %rsp
	movl    %eax, -61(%rbp)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movslq  -4(%rbp), %rax
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
	movslq  -61(%rbp), %rax
	xorq    %rdi, %rdi
	movl    %eax, %edi
	callq   printNum
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
