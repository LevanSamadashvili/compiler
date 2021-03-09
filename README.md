# Compiler
	- Basic C Compiler (written in python)

# Details
	- Python version:            3.8.5 x64
	- Assembly architecture: 	 x64
	- Assembly syntax:			 AT&T Syntax

# Run
    # Linux
      - chmod u+x ./compiler.py
	  ./compiler.py test.c       OR   python3 ./compiler.py test.c  (Generates test.s in the current directory)
	  gcc test.s
	  ./a.out
	  
    
	# Windows
	  - Change the name of the module parser.py to something else, it should
	  	work normally after that.
    	

	# To link with gcc
	  - You'll need gcc x64 to make executable files from .s files.

# Sample programs 
	- You can find sample programs and their assembly files
	  in "examples" directory.

# Capabilities
	- Primitive types: char, short, int, long
	- Arithmetic operators
	- Logical operators
	- Some unary/binary operators
	- if/else operators
	- for/while/do-while loops
	- Declaring and using an array
	- Basic Struct functionality (such as defining and using ".", "->" operators)

