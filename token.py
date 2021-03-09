import re

### TOKEN TYPES

# UNKNOWN           
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

class Token:
    def __init__(self, content):
        self.content = content
        self.token_type = "UNKNOWN"
    
    def get_token_type(self):
        content = self.content

        ### LITERAL COMPARISONS ###
        if content == "{":
            self.token_type = "OPEN_BRACE"
        elif content == "}":
            self.token_type = "CLOSE_BRACE"
        elif content == "(":
            self.token_type = "OPEN_PAREN"
        elif content == ")":
            self.token_type = "CLOSE_PAREN"
        elif content == ";":
            self.token_type = "SEMI_COLON"
        elif content == "char":
            self.token_type = "CHAR"
        elif content == "short":
            self.token_type = "SHORT"
        elif content == "int":
            self.token_type = "INT"
        elif content == "long":
            self.token_type = "LONG"
        elif content == "return":
            self.token_type = "RETURN"
        elif content == "-":
            self.token_type = "NEGATION"
        elif content == "~":
            self.token_type = "BITWISE_NEGATION"
        elif content == "!":
            self.token_type = "LOGICAL_NEGATION"
        elif content == "+":
            self.token_type = "ADDITION"
        elif content == "*":
            self.token_type = "MULTIPLICATION"
        elif content == "/":
            self.token_type = "DIVISION"
        elif content == "&&":
            self.token_type = "AND"
        elif content == "||":
            self.token_type = "OR"
        elif content == "==":
            self.token_type = "EQUAL"
        elif content == "!=":
            self.token_type = "NOT_EQUAL"
        elif content == "<":
            self.token_type = "LESS_THAN"
        elif content == "<=":
            self.token_type = "LESS_OR_EQUAL"
        elif content == ">":
            self.token_type = "GREATER_THAN"
        elif content == ">=":
            self.token_type = "GREATER_OR_EQUAL"
        elif content == "%":
            self.token_type = "MODULO"
        elif content == "=":
            self.token_type = "ASSIGNMENT"
        elif content == "if":
            self.token_type = "IF"
        elif content == "else":
            self.token_type = "ELSE"
        elif content == "for":
            self.token_type = "FOR"
        elif content == "while":
            self.token_type = "WHILE"
        elif content == "do":
            self.token_type = "DO"
        elif content == "break":
            self.token_type = "BREAK"
        elif content == "continue":
            self.token_type = "CONTINUE"
        elif content == ",":
            self.token_type = "COMMA"
        elif content == "void":
            self.token_type = "VOID"
        elif content == "&":
            self.token_type = "ADDRESS"
        elif content == "[":
            self.token_type = "OPEN_SQUARE"
        elif content == "]":
            self.token_type = "CLOSE_SQUARE"
        elif content == ".":
            self.token_type = "DOT"
        elif content == "typedef":
            self.token_type = "TYPEDEF"
        elif content == "struct":
            self.token_type = "STRUCT"
        elif content == "->":
            self.token_type = "ACCESS"
        ### REGEX COMPARISONS ###
        else:
            match = re.search('[a-zA-Z]\w*', content)
            if match != None:
                self.token_type = "IDENTIFIER"
                return self.token_type

            match = re.search('[0-9]+', content)
            if match != None:
                self.token_type = "INT_LITERAL"

        return self.token_type