# Compiler
Basic C Compiler (written in python)

## Details
- Python version:            	 **3.8.5 x64**
- Assembly architecture: 	 **x64**
- Assembly syntax:		 **AT&T Syntax**

## Capabilities
- Primitive types: **char**, **short**, **int**, **long**
- Pointers, pointer arithmetic (**void*** too, NULL is not defined)
- Arithmetic operators
- Logical operators
- Some unary/binary operators
- **if/else** operators
- **for/while/do-while** loops
- Declaring and using an **array** (you can also initialize an array like this, int arr[3][4][5] = {1, 2, 3, 4, 5, 6, 7}, no need for inner braces)
- Basic **struct** functionality (such as defining and using structures, accessing elements via: ".", "->" operators)
- Defining **functions**, and calling them
- Defining **function pointers** and using them

## Sample programs 
- You can find sample programs and their assembly files
  in the "examples" directory.

## Run
#### Linux
```console
foo@bar:~$ chmod u+x ./compiler.py
foo@bar:~$ ./compiler.py test.c       
foo@bar:~$ python3 ./compiler.py test.c  
- (Both [last two] commands generate test.s in the current directory)
foo@bar:~$ gcc test.s
foo@bar:~$ ./a.out
```
    
#### Windows
```console
If it doesn't work straight away, change the name of the module parser.py
to something else (parser_w.py for example), 
then change "import Parser from parser" to 
"import Parser from parser_w" (in compiler.py:5)
it should work normally after that.

foo@bar:~$ python3.9.exe .\compiler.py .\test.c  
(Generates test.s in the current directory)
```
#### To link with gcc
```
You'll need gcc x64 to make executable files from .s files.
```
## Notes
- Compiler doesn't support many things, such as string/character literals, global variables, ++/-- operators and many more.
- Also, it is a little bit buggy if you use many "->" operators together, there might be some other bugs too.
- There's no type-casting.

## Available C symbols
```c
# OPEN_BRACE        {
# CLOSE_BRACE       }
# OPEN_PAREN        \(
# CLOSE_PAREN       \)
# SEMI_COLON        ;
# CHAR              char
# SHORT             short
# INT               int
# LONG              long
# RETURN            return
# IDENTIFIER        [a-zA-Z]\w*
# INT_LITERAL       [0-9]+
# NEGATION          -
# BITWISE_NEGATION  ~
# LOGICAL_NEGATION  !
# ADDITION          +
# MULTIPLICATION    *
# DIVISION          /
# AND               &&
# OR                ||
# EQUAL             ==
# NOT_EQUAL         !=
# LESS_THAN         <
# LESS_OR_EQUAL     <=
# GREATER_THAN      >
# GREATER_OR_EQUAL  >=
# MODULO            %
# ASSIGNMENT        =
# IF                if
# ELSE              else
# FOR               for
# WHILE             while
# DO                do
# BREAK             break
# CONTINUE          continue
# COMMA             ,
# VOID              void
# ADDRESS           &
# OPEN_SQUARE       [
# CLOSE_SQUARE      ]
# DOT               .
# TYPEDEF           typedef
# STRUCT            struct
# ACCESS            ->
```
