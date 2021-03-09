# compiler
Basic C Compiler (written in python)

# Details
	- Python version:            3.8.5 x64
	- Assembly architecture: 	 x64
	- Assembly syntax:			 AT&T Syntax

# Run
    # Linux
    - chmod u+x ./compiler.py
	  ./compiler.py test.c       (Generates test.s in the current directory)
	  gcc test.s
	  ./a.out
	  
    
    python3 ./compiler.py test.c
    	
# Sample programs in "examples" directory

- სტრუქტურის გამოყენების დროს ბევრი "->" და "." თუ იქნება მიყოლებით არასწორად იმუშავებს სავარაუდოდ (მაგალითად ex-linked-list.c-ში ბევრი "->" არ მუშაობდა), კიდევ რაღაც ბაგები იქნება სხვა რამეებზეც ალბათ.
