from typesAST import *
from itertools import chain
from itertools import tee
from error_print import *
import sys

error_none = "None"

class Parser:
    def __init__(self, it):
        self.it = it
    
    # Goes to the next token (try / except idiom)        
    def next_token(self):
        try:
            tok = next(self.it)
            return tok
        except StopIteration:
            return None

    def peek_list(self):
        try:
            peek = self.next_token()
            self.it = iter(list(chain([peek], self.it)))
            return peek
        except StopIteration:
            return None

    # Parses the first line of a function
    # Returns a Function node (error function node in
    # some cases)
    def parse_function_declaration(self):
        func_name = ""
        return_type = ""
        arg_list = [] # List of declarations

        # Return type
        try:
            tok = next(self.it) 
        except StopIteration:
            return Function(error_none, error_none)
        
        if (tok.token_type != "CHAR" and tok.token_type != "SHORT" and tok.token_type != "INT" and tok.token_type != "LONG"
                                     and tok.token_type != "VOID" and tok.token_type != "IDENTIFIER"):
            print_expected_return_type()
        return_type = tok.token_type

        # Check if return type is a pointer
        peek = self.peek_list()
        while peek.token_type == "MULTIPLICATION":
            self.next_token()
            return_type += "*"
            peek = self.peek_list()

        # Function name
        tok = self.next_token()  
        if tok.token_type != "IDENTIFIER":
            print_expected_function_name()
        func_name = tok.content

        # OPEN_PAREN
        tok = self.next_token() 
        if tok.token_type != "OPEN_PAREN":
            print_expected_parentheses(1)
        
        # PARAMETERS void func(int a, short b, int* c, void* gela)
        peek = self.peek_list()

        while peek.token_type != "CLOSE_PAREN":
            if peek.token_type == "STRUCT":
                self.next_token()
            
            # PARAMETER TYPE
            peek = self.peek_list()
            if (peek.token_type != "CHAR" and peek.token_type != "SHORT" and peek.token_type != "INT" and peek.token_type != "LONG"
                                          and peek.token_type != "VOID" and peek.token_type != "IDENTIFIER"):
                print_expected_var_type()

            var_type = self.next_token().content

            # CHECK IF POINTER
            peek = self.peek_list()
            while peek.token_type == "MULTIPLICATION":
                self.next_token()
                var_type += "*"
                peek = self.peek_list()

            # NAME
            tok = self.next_token()
              
            if tok.token_type != "IDENTIFIER":
                print_expected_var_name()

            var_node = Identifier(tok.content)
            peek = self.peek_list()

            if peek.token_type == "COMMA":
                tok = self.next_token()
                peek = self.peek_list()
            elif peek.token_type != "CLOSE_PAREN":
                print_expected_comma()
            
            param = Declaration(var_type, var_node)
            arg_list.append(param)

        # CLOSE_PAREN
        tok = self.next_token() 
        if tok.token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        # OPEN_BRACE | SEMI_COLON
        peek = self.peek_list()
        if peek.token_type != "OPEN_BRACE" and peek.token_type != "SEMI_COLON":
            print_illegal_statement()

        ret = Function(func_name, return_type)
        ret.args = arg_list
        ret.children.extend(ret.args)
        return ret

    # Parses a function call   Ex:  foo(bar, dev)
    def parse_function_call(self, name):
        func_name = name
        arg_list = [] 
        self.next_token()

        peek = self.peek_list()

        while peek.token_type != "CLOSE_PAREN":
            exp = self.parse_exp()
            arg_list.append(exp)

            peek = self.peek_list()            
            if peek.token_type == "COMMA":
                tok = self.next_token()
                peek = self.peek_list()
            elif peek.token_type != "CLOSE_PAREN":
                print_expected_comma()
        
        self.next_token()
        return FunctionCall(func_name, arg_list)

    # Parses a factor (left/right of "*"/"/")
    # <factor> ::= "(" <exp> ")" | <unary_op> <factor> | <int_literal> | <id> | <func_call>
    def parse_factor(self):
        def is_unary_op(char):
            if char == "-" or char == "~" or char == "!" or char == "*" or char == "&":
                return True
            
            return False
        
        tok = self.next_token()

        if tok.token_type == "OPEN_PAREN":
            exp = self.parse_exp()
            if self.next_token().token_type != "CLOSE_PAREN":
                print_expected_parentheses(2)
            return exp
        elif is_unary_op(tok.content):
            next_factor = self.parse_factor()
            un_op = UnaryOp(tok.content, next_factor)
            
            return un_op
        elif tok.token_type == "INT_LITERAL":
            const_num = int(tok.content)
            const_node = Constant(const_num)
            return const_node
        elif tok.token_type == "IDENTIFIER":
            peek = self.peek_list()
            if peek.token_type == "OPEN_PAREN":
                ret = self.parse_function_call(tok.content)
                return ret
            elif peek.token_type == "OPEN_SQUARE":
                var_id = tok.content
                indices = []

                while peek.token_type == "OPEN_SQUARE":
                    self.next_token()
                    exp = self.parse_exp()
                    indices.append(exp)

                    if self.next_token().token_type != "CLOSE_SQUARE":
                        print_expected_parentheses(6)

                    peek = self.peek_list()

                ret = ArrayRef(var_id, indices)

                if peek.token_type == "DOT":
                    self.next_token()
                    field = self.parse_factor()
                    ret = StructAccess(ret, field)

                return ret
            elif peek.token_type == "DOT" or peek.token_type == "ACCESS":
                struct_name = tok.content
                self.next_token() # pass dot
                
                field = self.parse_factor()
                ret = None
                
                if peek.token_type == "DOT":
                    ret = StructAccess(Identifier(struct_name), field)
                elif peek.token_type == "ACCESS":
                    ret = StructAccess(Identifier(struct_name), field, True)
                
                return ret
            else:
                return Identifier(tok.content)
        else:
            print_illegal_term()
            
    # Parses a term (left/right of "+"/"-"/"%")
    # <term> ::= <factor> { ("*" | "/" | "%") <factor> }
    def parse_term(self):
        factor = self.parse_factor()
        peek = self.peek_list()

        while peek.token_type == "MULTIPLICATION" or peek.token_type == "DIVISION" or peek.token_type == "MODULO":
            op = self.next_token().content
            next_factor = self.parse_factor()
            factor = BinaryOp(op, factor, next_factor)
            peek = self.peek_list()

        return factor

    # Parses the given additive expression and 
    # returns appropriate node
    # <additive-exp> ::= <term> { ("+" | "-") <term> }
    def parse_additive_exp(self):
        term = self.parse_term()
        peek = self.peek_list()

        while peek.token_type == "ADDITION" or peek.token_type == "NEGATION":
            op = self.next_token().content
            next_term = self.parse_term()
            term = BinaryOp(op, term, next_term)
            peek = self.peek_list()

        return term

    # Parses additive expression ("<" | ">" | "<=" | ">=")
    # <relational-exp> ::= <additive-exp> { ("<" | ">" | "<=" | ">=") <additive-exp> }
    def parse_relational_exp(self):
        additive_exp = self.parse_additive_exp()
        peek = self.peek_list()

        while (peek.token_type == "LESS_THAN" or peek.token_type == "LESS_OR_EQUAL"
            or peek.token_type == "GREATER_THAN" or peek.token_type == "GREATER_OR_EQUAL"):

            op = self.next_token().content
            next_additive_exp = self.parse_additive_exp()
            additive_exp = BinaryOp(op, additive_exp, next_additive_exp)
            peek = self.peek_list()

        return additive_exp

    # Parses equality expression ("=="/"!=")
    # <equality-exp> ::= <relational-exp> { ("!=" | "==") <relational-exp> }
    def parse_equality_exp(self):
        relational_exp = self.parse_relational_exp()
        peek = self.peek_list()

        while peek.token_type == "EQUAL" or peek.token_type == "NOT_EQUAL":
            op = self.next_token().content
            next_relational_exp = self.parse_relational_exp()
            relational_exp = BinaryOp(op, relational_exp, next_relational_exp)
            peek = self.peek_list()

        return relational_exp

    # Parses given logical AND expression
    # <logical-and-exp> ::= <equality-exp> { "&&" <equality-exp> }
    def parse_logical_and_exp(self):
        eq_exp = self.parse_equality_exp()
        peek = self.peek_list()

        while peek.token_type == "AND":
            op = self.next_token().content
            next_eq_exp = self.parse_equality_exp()
            eq_exp = BinaryOp(op, eq_exp, next_eq_exp)
            peek = self.peek_list()

        return eq_exp

    # Parses given expression and returns 
    # appropriate node
    # <logical-or-exp> ::= <logical-and-exp> { "||" <logical-and-exp> }
    def parse_logical_or_exp(self):
        log_and_exp = self.parse_logical_and_exp()
        peek = self.peek_list()

        while peek.token_type == "OR":
            op = self.next_token().content
            next_log_and_exp = self.parse_logical_and_exp()
            log_and_exp = BinaryOp(op, log_and_exp, next_log_and_exp)
            peek = self.peek_list()
        
        return log_and_exp

    # Parses assignment
    # <assn> ::= <factor{starting with *}> "=" <exp> | <id> "=" <exp> | <logical-or-exp>
    def parse_assignment(self):
        peek = self.peek_list()

        if peek.token_type == "IDENTIFIER":
            var_id = peek.content
            next_tok = self.next_token()
            next_peek = self.peek_list()
            if next_peek.token_type == "ASSIGNMENT":
                self.next_token()
                exp = self.parse_exp()
                ret = Assignment(Identifier(var_id), exp)

                return ret
            elif next_peek.token_type == "SEMI_COLON":
                return Identifier(var_id)
            elif next_peek.token_type == "OPEN_SQUARE" or next_peek.token_type == "DOT":
                self.it = iter(list(chain([peek], self.it)))
                self.it, tmp_it = tee(self.it, 2)
                deref = self.parse_factor()
                next_peek = self.peek_list()

                if next_peek.token_type == "ASSIGNMENT":
                    self.next_token()
                    exp = self.parse_exp()
                    ret = Assignment(None, exp, deref)
                    return ret
                elif next_peek.token_type == "SEMI_COLON":
                    return deref
                elif next_peek.token_type == "DOT":
                    self.next_token()
                    field = self.parse_factor()
                    ret = StructAccess(deref, field)

                    next_tok = self.next_token()
                    if next_tok.token_type == "SEMI_COLON":
                        return ret
                    else:
                        self.it = tmp_it
                        exp = self.parse_logical_or_exp()
                        return exp
                else:
                    self.it = tmp_it
                    exp = self.parse_logical_or_exp()
                    return exp
            elif next_peek.token_type == "DOT" or next_peek.token_type == "ACCESS":
                self.it = iter(list(chain([peek], self.it)))
                self.it, tmp_it = tee(self.it, 2)
                deref = self.parse_factor()
                next_peek = self.peek_list()

                if next_peek.token_type == "ASSIGNMENT":
                    self.next_token()
                    exp = self.parse_exp()
                    ret = Assignment(None, exp, deref)
                    return ret
                elif next_peek.token_type == "SEMI_COLON":
                    return deref
                else:
                    self.it = tmp_it
                    exp = self.parse_logical_or_exp()
                    return exp
            else:
                self.it = iter(list(chain([peek], self.it)))
                exp = self.parse_logical_or_exp()
                return exp
            
        elif peek.token_type == "MULTIPLICATION":
            self.it, tmp_it = tee(self.it, 2)
            deref = self.parse_factor()
            next_peek = self.peek_list()

            if next_peek.token_type == "ASSIGNMENT":
                self.next_token()
                exp = self.parse_exp()
                ret = Assignment(None, exp, deref)
                return ret
            elif next_peek.token_type == "SEMI_COLON":
                return deref
            else:
                self.it = tmp_it
                exp = self.parse_logical_or_exp()
                return exp
        else:
            exp = self.parse_logical_or_exp()
            return exp

    # Parses given expression
    # <exp> ::= <ass> | <logical-or-exp>
    def parse_exp(self):
        peek = self.peek_list()

        if peek.token_type == "IDENTIFIER" or peek.token_type == "MULTIPLICATION":
            assn = self.parse_assignment()
            return assn
        else:
            ret = self.parse_logical_or_exp()
            return ret

    # Parses declaration expression
    # <dec> ::= "*" <id> "=" <exp> | <id>
    def parse_var_declaration_or_array(self, var_type):
        next_tok = self.next_token()

        while next_tok.token_type == "MULTIPLICATION":
            next_tok = self.next_token()
            var_type += "*"

        var_id = next_tok.content

        peek = self.peek_list()
        if peek.token_type == "ASSIGNMENT":
            self.next_token()
            exp = self.parse_exp()
            ret = Declaration(var_type, Identifier(var_id), exp)

            return ret
        elif peek.token_type == "SEMI_COLON":
            ret = Declaration(var_type, Identifier(var_id))
            return ret
        elif peek.token_type == "OPEN_SQUARE":
            if var_type == "void":
                print_cant_declare_void()

            dim_list = []

            while peek.token_type == "OPEN_SQUARE":
                self.next_token()
                
                new_dim = self.parse_exp()
                dim_list.append(new_dim)

                next_tok = self.next_token()
                if next_tok.token_type != "CLOSE_SQUARE":
                    print_expected_parentheses(6)

                peek = self.peek_list()            

            if peek.token_type == "SEMI_COLON":
                ret = ArrayInit(var_id, var_type, dim_list)
                return ret
            elif peek.token_type == "ASSIGNMENT":
                self.next_token()
                
                if self.next_token().token_type != "OPEN_BRACE":
                    print_expected_parentheses(3)

                elems = []
                peek = self.peek_list()

                while peek.token_type != "CLOSE_BRACE": 
                    new_elem = self.parse_exp()
                    elems.append(new_elem)

                    peek = self.peek_list()
                    if peek.token_type == "COMMA":
                        self.next_token()
                        peek = self.peek_list()
                

                if self.next_token().token_type != "CLOSE_BRACE":
                    print_expected_parentheses(4)

                ret = ArrayInit(var_id, var_type, dim_list, elems)
                return ret

    # Parses code block
    # "{"
    #   ...statements...
    # "}"
    def parse_block(self, return_type):
        self.next_token()
        peek = self.peek_list()
        stmt_list = []

        while peek.token_type != "CLOSE_BRACE":
            stmt = self.parse_statement(True, return_type)
            stmt_list.append(stmt)
            peek = self.peek_list()

        self.next_token()
        return Block(stmt_list)

    # "if" "("<exp>")"
    #       statement
    # "else"
    #       other statement
    # "if" "("<exp>")" "{"
    #       block
    # "}" else "{"
    #       block2
    # "}"
    def parse_if_statement(self, return_type):
        self.next_token()

        exp = None
        body = None
        else_body = None
        ret = None
        tok = self.next_token()

        if tok.token_type != "OPEN_PAREN":
            print_expected_parentheses(1)

        exp = self.parse_exp()
        tok = self.next_token()

        if tok.token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        peek = self.peek_list()

        if peek.token_type == "OPEN_BRACE":
            body = self.parse_block(return_type)
        else:
            stmt = self.parse_statement(True, return_type)
            body = Block([stmt])

        peek = self.peek_list()

        if peek.token_type == "ELSE":
            self.next_token()
            peek = self.peek_list()
            if peek.token_type == "OPEN_BRACE":
                else_body = self.parse_block(return_type)
            else:
                stmt = self.parse_statement(True, return_type)
                else_body = Block([stmt])

            ret = IfStatement(exp, body, else_body)
        else:
            ret = IfStatement(exp, body)

        return ret

    # Parses for loop and returns its AST node
    def parse_for_loop(self, return_type):
        self.next_token()
        init = None
        test = None
        step = None
        body = None

        if self.next_token().token_type != "OPEN_PAREN":
            print_expected_parentheses(1)

        init = self.parse_statement(True, return_type)
        test = self.parse_statement(True, return_type)
        step = self.parse_statement(False, return_type)

        if self.next_token().token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        peek = self.peek_list()

        if peek.token_type == "SEMI_COLON":
            self.next_token()
            body = None
        elif peek.token_type == "OPEN_BRACE":
            body = self.parse_block(return_type)
        else:
            stmt = self.parse_statement(True, return_type)
            body = Block([stmt])

        ret = None

        if body == None:
            ret = ForLoop(init, test, step)
        else:
            ret = ForLoop(init, test, step, body)

        return ret

    # Parses a while loop and returns its' AST node
    def parse_while_loop(self, return_type):
        self.next_token()

        exp = None
        body = None

        if self.next_token().token_type != "OPEN_PAREN":
            print_expected_parentheses(1)

        exp = self.parse_exp()

        if self.next_token().token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        peek = self.peek_list()

        if peek.token_type == "SEMI_COLON":
            self.next_token()
            body = None
        elif peek.token_type == "OPEN_BRACE":
            body = self.parse_block(return_type)
        else:
            stmt = self.parse_statement(True, return_type)
            body = Block([stmt])

        ret = None

        if body == None:
            ret = WhileLoop(exp)
        else:
            ret = WhileLoop(exp, body)

        return ret

    # Parses do/while statement and returns its' AST node
    def parse_do_while_loop(self, return_type):
        self.next_token()

        body = None
        exp = None

        if self.peek_list().token_type != "OPEN_BRACE":
            print_expected_parentheses(3)

        body = self.parse_block(return_type)

        tok = self.next_token()
        if tok.token_type != "WHILE":
            print_expected_while()

        if self.next_token().token_type != "OPEN_PAREN":
            print_expected_parentheses(1)

        exp = self.parse_exp()

        if self.next_token().token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        if self.next_token().token_type != "SEMI_COLON":
            print_expected_semi_colon()

        ret = DoWhileLoop(body, exp)
        return ret

    # Parses a declaration/assignment of function pointer
    # Starting from int-> ( here example: int (*funcPtr) (int, int) = &addInts;
    def parse_function_pointer(self, return_type):
        return_type = return_type.upper()

        self.next_token()
        if self.next_token().token_type != "MULTIPLICATION":
            print_expected_multiplication()

        arg_list = []
        func_name = ""
        
        # Funnction name
        tok = self.next_token()
        if tok.token_type != "IDENTIFIER":
            print_expected_function_name()

        func_name = tok.content

        if self.next_token().token_type != "CLOSE_PAREN":
            print_expected_parentheses(2)

        if self.next_token().token_type != "OPEN_PAREN":
            print_expected_parentheses(1)

        peek = self.peek_list()
        while peek.token_type != "CLOSE_PAREN":
            # PARAMETER TYPE
            if (peek.token_type != "CHAR" and peek.token_type != "SHORT" and peek.token_type != "INT" and peek.token_type != "LONG"
                                          and peek.token_type != "VOID" and peek.token_type != "IDENTIFIER"):
                print_expected_var_type()

            var_type = self.next_token().content

            # CHECK IF POINTER
            peek = self.peek_list()
            while peek.token_type == "MULTIPLICATION":
                self.next_token()
                var_type += "*"
                peek = self.peek_list()

            # CHECK COMMAS
            if peek.token_type == "COMMA":
                tok = self.next_token()
                peek = self.peek_list()
            elif peek.token_type != "CLOSE_PAREN":
                print_expected_comma()
            
            param = Declaration(var_type, Identifier("NONAME"))
            arg_list.append(param)

        func_ptr = Function(func_name, return_type, None, True)
        func_ptr.args = arg_list
        func_ptr.children = arg_list    

        ### Continue from possible assignment
        self.next_token()
        peek = self.peek_list()

        if peek.token_type == "SEMI_COLON":
            return func_ptr
        elif peek.token_type == "ASSIGNMENT":
            self.next_token()
            peek = self.peek_list()

            if peek.token_type != "ADDRESS":
                print_cant_take_address()
            
            self.next_token()
            peek =self.peek_list()

            if peek.token_type != "IDENTIFIER":
                print_expected_function_name()

            self.next_token()
            pointee_name = peek.content
            func_ptr.pointee = pointee_name
            return func_ptr
        else:
            print_expected_semi_colon()

    # Parses return
    def parse_return(self, return_type):
        self.next_token()

        peek = self.peek_list()
        
        if peek.token_type == "SEMI_COLON":
            ret = Return()
        else:
            exp = self.parse_exp()
            ret = Return(exp, return_type)

        return ret

    # Parses given statement and returns appropriate node
    def parse_statement(self, check_semi_colon, return_type):
        def check_next_semi_colon():
            if self.next_token().token_type != "SEMI_COLON":
                print_expected_semi_colon()

        peek = self.peek_list()

        if peek.token_type == "RETURN":
            ret = self.parse_return(return_type)

            if check_semi_colon == True:
                check_next_semi_colon()

            return ret
        elif peek.token_type == "STRUCT":
            self.next_token()

            peek = self.peek_list()

            if (peek.token_type == "INT" or peek.token_type == "CHAR" or peek.token_type == "SHORT"
                or peek.token_type == "LONG" or peek.token_type == "VOID" or peek.token_type == "IDENTIFIER"):

                var_type = peek.content
                self.next_token()
                ret = self.parse_var_declaration_or_array(var_type)

                if check_semi_colon == True:
                    check_next_semi_colon()

                return ret
            else:
                print_expected_var_type()

        elif (peek.token_type == "INT" or peek.token_type == "CHAR" or peek.token_type == "SHORT" 
                    or peek.token_type == "LONG" or peek.token_type == "VOID"):
            var_type = peek.content
            tok = self.next_token()
            peek2 = self.peek_list()

            if peek2.token_type == "OPEN_PAREN":
                ret = self.parse_function_pointer(var_type)
            else:
                ret = self.parse_var_declaration_or_array(var_type)

            if check_semi_colon == True:
                check_next_semi_colon()
            
            return ret
        elif peek.token_type == "INT_LITERAL":
            ret = self.parse_exp()
            
            if check_semi_colon == True:
                check_next_semi_colon()
            
            return ret
        elif peek.token_type == "IDENTIFIER" or peek.token_type == "MULTIPLICATION":
            ret = self.parse_exp()
            if check_semi_colon == True:
                check_next_semi_colon()
            
            return ret
        elif peek.token_type == "IF":
            ret = self.parse_if_statement(return_type)
            return ret
        elif peek.token_type == "OPEN_BRACE":
            ret = self.parse_block(return_type)
            return ret
        elif peek.token_type == "FOR":
            ret = self.parse_for_loop(return_type)
            return ret
        elif peek.token_type == "WHILE":
            ret = self.parse_while_loop(return_type)
            return ret
        elif peek.token_type == "DO":
            ret = self.parse_do_while_loop(return_type)
            return ret
        elif peek.token_type == "BREAK":
            self.next_token()
            check_next_semi_colon()
            return Break()
        elif peek.token_type == "CONTINUE":
            self.next_token()
            check_next_semi_colon()
            return Continue()
        elif peek.token_type == "SEMI_COLON":
            if check_semi_colon == True:
                self.next_token()
            return Empty()
        elif check_semi_colon == False and peek.token_type == "CLOSE_PAREN":
            return Empty()
        else:
            exp = self.parse_exp()

            if check_semi_colon == True:
                check_next_semi_colon()

            return exp

    # Parses the whole function
    def parse_function(self):
        function = self.parse_function_declaration()

        if function.name == error_none:
            return function

        peek = self.peek_list()
        # Parse function block
        if peek.token_type == "OPEN_BRACE":
            function.body = self.parse_block(function.return_type)
            function.children.append(function.body)
        elif peek.token_type == "SEMI_COLON":
            self.next_token()

        return function

    # Parses struct declaration
    def parse_struct_declaration(self):
        if self.next_token().token_type != "TYPEDEF":
            print_expected_typedef()

        if self.next_token().token_type != "STRUCT":
            print_expected_struct()
        
        tok = self.next_token()

        if tok.token_type != "IDENTIFIER":
            print_expected_var_name()
        
        struct_name = tok.content
        members = []

        if self.next_token().token_type != "OPEN_BRACE":
            print_expected_parentheses(3)
        

        peek = self.peek_list()

        while peek.token_type != "CLOSE_BRACE":
            peek = self.peek_list()            

            if peek.token_type == "STRUCT":
                self.next_token()
                peek = self.peek_list()
            
            if (peek.token_type != "IDENTIFIER" and peek.token_type != "CHAR" and peek.token_type != "SHORT" 
                   and peek.token_type != "INT" and peek.token_type != "LONG"):
                print_expected_var_name()

            var_type = peek.content
            self.next_token()
            var = self.parse_var_declaration_or_array(var_type)

            members.append(var)

            if self.next_token().token_type != "SEMI_COLON":
                print_expected_semi_colon()
            
            peek = self.peek_list()

        self.next_token()
        if self.next_token().token_type != "SEMI_COLON":
            print_expected_semi_colon()

        ret = StructDecl(struct_name, members)
        return ret

    # MAIN PARSE FUNCTION
    def parse(self):  
        # Parse functions and structs, add them to program's children
        root = Program()
        
        while True:
            peek = self.peek_list()

            if peek == None:
                break

            to_add = None
            if peek.token_type == "TYPEDEF":
                to_add = self.parse_struct_declaration()
            else:
                to_add = self.parse_function()

            if to_add.name != "None":
                root.add_child(to_add)
            else:
                break

        return root
    
    
