	.globl  printNum
	.globl  addNode
	.globl  printList
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
addNode:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $8, %rsp
	movq    %rsi, -16(%rbp)
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	sete    %al
	cmpq    $0, %rax
	je      _L_9
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -16(%rbp), %rax
	popq    %rcx
	movq    %rax, (%rcx)
	movq    -8(%rbp), %rax
	addq    $8, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -16(%rbp), %rax
	popq    %rcx
	movq    %rax, (%rcx)
	subq    $8, %rsp
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
	movq    %rax, -24(%rbp)
	movq    -24(%rbp), %rax
	addq    $8, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $0, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	addq    $8, %rsp
	jmp     _L_8
_L_9:
	movq    -16(%rbp), %rax
	addq    $8, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
	popq    %rcx
	movq    %rax, (%rcx)
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    -16(%rbp), %rax
	popq    %rcx
	movq    %rax, (%rcx)
_L_8:
	movq    %rbp, %rsp
	popq    %rbp
	ret
printList:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $8, %rsp
	movq    %rdi, -8(%rbp)
	subq    $8, %rsp
	movq    -8(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
	movq    %rax, -16(%rbp)
_L_10:
	movq    -16(%rbp), %rax
	pushq   %rax
	movq    $0, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setne   %al
	cmpq    $0, %rax
	je      _L_11
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	movq    -16(%rbp), %rax
	addq    $0, %rax
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
	movq    -16(%rbp), %rax
	addq    $8, %rax
	movq    %rax, %rcx
	xorq    %rax, %rax
	movq    (%rcx), %rax
	movq    %rax, -16(%rbp)
	jmp     _L_10
_L_11:
	movq    %rbp, %rsp
	popq    %rbp
	ret
main:
	pushq   %rbp
	movq    %rsp, %rbp
	subq    $16, %rsp
	leaq    -16(%rbp), %rax
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $0, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	leaq    -16(%rbp), %rax
	addq    $8, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $0, %rax
	popq    %rcx
	movq    %rax, (%rcx)
	movq    $10, %rax
	subq    $160, %rsp
	subq    $4, %rsp
	movq    $0, %rax
	movl    %eax, -180(%rbp)
_L_12:
	movslq  -180(%rbp), %rax
	pushq   %rax
	movq    $10, %rax
	popq    %rcx
	cmpq    %rax, %rcx
	movq    $0, %rax
	setl    %al
	cmpq    $0, %rax
	je      _L_14
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -180(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $16, %rax
	leaq    -176(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	addq    $0, %rax
	movq    %rax, %rcx
	pushq   %rcx
	movq    $10, %rax
	pushq   %rax
	movslq  -180(%rbp), %rax
	popq    %rcx
	subq    %rcx, %rax
	neg     %rax
	popq    %rcx
	movq    %rax, (%rcx)
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -16(%rbp), %rax
	leaq    -16(%rbp), %rax
	movq    %rax, %rdi
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -180(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $16, %rax
	leaq    -176(%rbp), %rcx
	addq    %rax, %rcx
	xorq    %rax, %rax
	popq    %r8
	popq    %rcx
	pushq   %rcx
	pushq   %r8
	xorq    %r8, %r8
	movslq  -180(%rbp), %rax
	imul    $1, %rax
	addq    %rax, %r8
	movq    %r8, %rax
	imul    $16, %rax
	leaq    -176(%rbp), %rcx
	addq    %rax, %rcx
	movq    %rcx, %rax
	popq    %r8
	popq    %rcx
	movq    %rax, %rsi
	callq   addNode
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
_L_13:
	movslq  -180(%rbp), %rax
	pushq   %rax
	movq    $1, %rax
	popq    %rcx
	addq    %rcx, %rax
	movl    %eax, -180(%rbp)
	jmp     _L_12
_L_14:
	addq    $4, %rsp
	pushq   %rdi
	pushq   %rsi
	pushq   %rdx
	pushq   %rcx
	pushq   %r8
	pushq   %r9
	leaq    -16(%rbp), %rax
	leaq    -16(%rbp), %rax
	movq    %rax, %rdi
	callq   printList
	popq    %r9
	popq    %r8
	popq    %rcx
	popq    %rdx
	popq    %rsi
	popq    %rdi
	movq    %rbp, %rsp
	popq    %rbp
	ret
