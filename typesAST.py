class Node(object):
    # Initializes the node
    def __init__(self):
        self.children = []

    # Returns list of children of the node
    def children(self):
        return self.children

    # Add child to children list
    def add_child(self, child):
        self.children.append(child)

    # Add children to self's children
    def add_children(self, children):
        self.children.extend(children)

    # Prints tabs for print_node
    def print_tabs(self, offset):
        offset_str = ""
        for i in range(offset):
            offset_str += "     "
        
        print(offset_str, end='')

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print(print_str)

    # Print AST in a readable format
    def print_subtree(self, offset=0):
        self.print_node(offset)

        for child in self.children:
            child.print_subtree(offset + 1)


class Program(Node):
    def __init__(self):
        super().__init__()

class Function(Node):
    def __init__(self, name, return_type, body=None, isPointer=False): # name - str    return_type - str (TOKEN_NAME)  body - (Block)
        super().__init__()
        self.name = name
        self.return_type = return_type
        self.args = [] # Declarations
        self.body = body
        self.pointee = "" # name of the pointee function
        self.isPointer = isPointer
        if body != None:
            self.children.append(body)

        for arg in self.args:
            self.children.append(arg)

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.return_type + " " + self.name
        if self.pointee != "":
            print_str += " Points to -> " + self.pointee
        
        print_str += " [args]: "               
        print(print_str)

class StructDecl(Node):
    def __init__(self, name, members): # name - str     members - list of (var_name - var_type)
        super().__init__()
        self.name = name
        self.members = members

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.name
        print(print_str)

        for memb in self.members:
            memb.print_subtree(offset + 1)

##### STATEMENTS #####
class Empty(Node):
    pass

class Return(Node):
    def __init__(self, exp=None, return_type=None): # exp - Node   ret_type - TOKEN_NAME
        super().__init__()
        self.exp = exp
        self.return_type = return_type

        if exp != None:
            self.children.append(exp)

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        
        if self.return_type != None:
            print_str += " " + self.return_type
        
        print(print_str)

class Declaration(Node):
    def __init__(self, type, var, exp=None): # type - str (int)   var - (Identifier)  exp - option initializer (Node)
        super().__init__()
        self.var = var
        self.type = type
        self.exp = exp

        if exp == None:
            self.children.append(var)
        else:
            self.children.extend((var, exp))

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.type
        print(print_str)

class Assignment(Node): 
    def __init__(self, var=None, exp=None, deref=None): # var - (Variable)      exp - option initializer (Node)   deref (dereference - UnaryOp)
        super().__init__()
        self.var = var
        self.exp = exp
        self.deref = deref

        if var != None:
            self.children.append(var)
        
        if deref != None:
            self.children.append(deref)
        
        if exp != None:
            self.children.append(exp)


class IfStatement(Node):
    def __init__(self, exp, body, else_body=None): # exp - (Node)  body/else_body - (Block)
        super().__init__()
        self.exp = exp
        self.body = body 
        self.else_body = else_body
        
        self.children.extend((exp, body))
        if else_body != None:
            self.children.append(else_body)

class Block(Node):
    def __init__(self, stmt_list): # stmt_list - (list) of statements
        self.children = stmt_list

class ForLoop(Node):
    def __init__(self, init, test, step, body=None): # init - (Node)  test - (Node)    step (Node)  body - (Block)
        super().__init__()
        self.init = init
        self.test = test
        self.step = step
        self.body = body
        self.children.extend((init, test, step))

        if body != None:
            self.children.append(body)

class WhileLoop(Node):
    def __init__(self, exp, body=None): # exp - (Node)   body - (Block)
        super().__init__()
        self.exp = exp
        self.body = body

        self.children.append(exp)
        if body != None:
            self.children.append(body)

class DoWhileLoop(Node):
    def __init__(self, body, exp): # body - (Block)   exp - (Node)
        super().__init__()
        self.exp = exp
        self.body = body
        self.children.extend((exp, body))

class Continue(Node):
    pass

class Break(Node):
    pass

class ArrayInit(Node):
    def __init__(self, name, elem_type, dimensions, elems=None): # elem_type - int, int*...  dimensions - list of expressions elems - list of expressions
        super().__init__()
        self.name = name
        self.elem_type = elem_type
        self.dimensions = dimensions
        self.elems = elems
        self.children.extend(dimensions)

        if elems != None:
            self.children.extend(elems)        

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " name: " + self.name
        print_str += " " + self.elem_type
        print(print_str)
        self.print_tabs(offset)
        print(" Dimensions and elements")

##### EXPRESSIONS #####
class FunctionCall(Node):
    def __init__(self, name, args): # name - str    args - list of (Node)s
        super().__init__()
        self.name = name
        self.args = args
        self.children = args

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.name
        print(print_str)

class UnaryOp(Node):
    def __init__(self, op, exp): # op - str     exp - (Node)
        super().__init__()
        self.op = op
        self.exp = exp
        self.children.append(exp)

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.op
        print(print_str)

class BinaryOp(Node):
    def __init__(self, op, lhs, rhs): # op - str (example: "==", "!=")   lhs - (Node)   rhs - (Node)
        super().__init__()
        self.op = op
        self.lhs = lhs
        self.rhs = rhs
        self.children.extend((lhs, rhs))

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.op
        print(print_str)

class StructAccess(Node):
    def __init__(self, struct_exp, field, pointer=False): # struct_exp - exp    field - exp     pointer-boolean
        super().__init__()
        self.struct_exp = struct_exp
        self.field = field
        self.pointer = pointer
        self.add_children([struct_exp, field])

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + str(self.pointer)
        print(print_str)    

class ArrayRef(Node):
    def __init__(self, arr_name, indices): # arr_name - str    indices - list of expressions
        super().__init__()
        self.arr_name = arr_name
        self.indices = indices
        self.children.extend(self.indices)

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.arr_name
        print(print_str)
        self.print_tabs(offset)
        print(" Indices..")

class Constant(Node):
    def __init__(self, value): # value - int
        super().__init__()
        self.value = value
    
    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + str(self.value)
        print(print_str)

# Is "NONAME" when it does nothing, used for dummy purposes
class Identifier(Node):
    def __init__(self, name): # type = str  name = str (var name)
        super().__init__()
        self.name = name

    def print_node(self, offset):
        self.print_tabs(offset)
        print_str = "<" + self.__class__.__name__ + ">"
        print_str += " " + self.name
        print(print_str)
