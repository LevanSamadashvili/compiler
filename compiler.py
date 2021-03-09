#!/usr/bin/env python3

import sys
from lexer import Lexer
from parser import Parser
from code_generator import CodeGenerator

def print_tokens(tokens):
    for tok in tokens:
        print(tok.content + " " + " TYPE: " + tok.token_type)

def run():
    if len(sys.argv) != 2:
        print("Invalid Arguments...")
        exit(0)

    source_file = sys.argv[1]

    # Lex source file
    lexer = Lexer(source_file)
    tokens = lexer.lex_file()

    #print_tokens(tokens) # tokens debug
    #exit(0)

    # Parse tokens into AST
    parser = Parser(iter(tokens))
    root = parser.parse()
    
    #root.print_subtree() # AST debug
    #exit(0)

    # Generate ASM code and write it to the file: "source_file.s"
    source_file_trimmed = source_file[:len(source_file) - 2]
    generator = CodeGenerator()
    generator.generate_asm(root, source_file_trimmed)

run()

