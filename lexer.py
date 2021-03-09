import re
import sys
from token import Token

class Lexer:
    def __init__(self, filepath):
        self.list = []
        self.filepath = filepath

    def lex_file(self):
        try:
            file = open(self.filepath, "r")
        except IOError:
            print("File doesn't exist")
            exit(1)
        
        regex = '\[|\]|{|}|\(|\)|;|\.|,|[a-zA-Z]\w*|[0-9]+|->|-|~|!=|!|\+|\*|/|==|\|\||&&|&|>=|<=|>|<|%|=|char|short|int|long|if|else|return|for|while|do|break|continue|typedef|struct'
        tokens = []
        
        for line in file.readlines():
            match = re.findall(regex, line)
            tokens.extend(match)
            
        for tok in tokens:
            new_token = Token(tok)
            new_token.get_token_type()
            self.list.append(new_token)

        file.close()
        return self.list