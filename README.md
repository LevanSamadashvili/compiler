# Compiler
	= Basic C Compiler (written in python)

# Details
	- Python version:            	 3.8.5 x64
	- Assembly architecture: 	 x64
	- Assembly syntax:		 AT&T Syntax

# Run
    # Linux
      - chmod u+x ./compiler.py
      - ./compiler.py test.c       OR   python3 ./compiler.py test.c  (Generates test.s in the current directory)
      - gcc test.s
      - ./a.out
	  
    
    # Windows
      = Change the name of the module parser.py to something else (parser_w.py for example),
        then change "import Parser from parser" to "import Parser from parser_w" (in compiler.py)
	it should work normally after that.
    
      - python3.9.exe .\compiler.py .\test.c  (Generates test.s in the current directory)

    # To link with gcc
      = You'll need gcc x64 to make executable files from .s files.

# Sample programs 
	= You can find sample programs and their assembly files
	  in "examples" directory.

# Capabilities
	- Primitive types: char, short, int, long
	- Pointers, pointer arithmetic
	- Arithmetic operators
	- Logical operators
	- Some unary/binary operators
	- if/else operators
	- for/while/do-while loops
	- Declaring and using an array
	- Basic Struct functionality (such as defining and using ".", "->" operators)

# Available C symbols
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
