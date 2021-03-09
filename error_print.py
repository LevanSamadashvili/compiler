def print_parse_error_msg_and_exit():
    print("Program ended working in parsing stage")
    exit(1)

def print_expected_return_type():
    print("Syntax error: Expected valid function return type.")
    exit(1)

def print_expected_var_type():
    print("Syntax error: Expected variable type.")
    exit(1)

def print_expected_function_name():
    print("Syntax error: Expected function name.")
    exit(1)

def print_expected_parentheses(open):
    if open == 1:
        print("Syntax error: Parentheses were never opened.")
    elif open == 2:
        print("Syntax error: Parentheses were never closed.")
    elif open == 3:
        print("Syntax error: Expected open braces.")
    elif open == 4:
        print("Syntax error: Expected closed braces.")
    elif open == 5:
        print("Syntax error: Expected open square brackets.")
    elif open == 6:
        print("Syntax error: Expected closed square brackets.")
    exit(1)

def print_illegal_statement():
    print("Syntax error: Illegal statement.")
    exit(1)

def print_illegal_term():
    print("Syntax error: Illegal term in expressions.")
    exit(1)

def print_expected_semi_colon():
    print("Syntax error.")
    exit(1)

def print_var_already_declared():
    print("Variable is already declared, can't declare twice.")
    exit(1)

def print_var_not_declared():
    print("Variable hasn't yet been declared.")
    exit(1)

def print_expected_while():
    print("Syntax error: Expected \"while\" keyword.")
    exit(1)

def print_not_in_loop():
    print("You can't use break/continue statements outside of a loop.")
    exit(1)

def print_no_test_while():
    print("Syntax error: No test in while loop.")
    exit(1)

def print_expected_var_name():
    print("Syntax error: Expected variable/type name.")
    exit(1)

def print_expected_comma():
    print("Syntax error: Expected comma.")
    exit(1)

def print_no_such_function_defined():
    print("No such function defined")
    exit(1)

def print_invalid_assignment_statement():
    print("Syntax error: Invalid assignment statement.")
    exit(1)

def print_invalid_dereference():
    print("Syntax error: Invalid dereference.")
    exit(1)

def print_cant_take_address():
    print("Can not take address of that.")
    exit(1)

def print_cant_declare_void():
    print("Can not declare a void variable.")
    exit(1)

def print_expected_multiplication():
    print("Syntax error: Expected multiplication mark (for function pointers).")
    exit(1)

def print_nonmatching_parameter_types():
    print("Parameter types don't match.")
    exit(1)

def print_expected_int_literal():
    print("Syntax error: Expected int literal.")
    exit(1)

def print_cant_be_zero():
    print("Size can not be zero.")
    exit(1)

def print_var_sized_array():
    print("Can't declare variable-sized array.")
    exit(1)

def print_invalid_array_reference():
    print("Invalid array reference.")
    exit(1)

def print_expected_typedef():
    print("Syntax error: Expected typedef.")
    exit(1)

def print_expected_struct():   
    print("Syntax error: Expected struct.")
    exit(1)

def print_invalid_type():
    print("Invalid variable type.")
    exit(1)

def print_struct_already_declared():
    print("Struct already declared.")
    exit(1)

def print_cant_do_that():
    print("Can not do that.")
    exit(1)
