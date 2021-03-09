from error_print import *

class CodeGenerator:
    def __init__(self):
        self.counter = 0
        self.label = "_L_"
        self.outer_scope = {} # (Variables : (offsets from rbp, var_type)) /// (global scope) var_type can be "FUNC_PTR"
        self.stack_index = 0 # Stack pointer offset from rbp
        self.end_of_loop_labels = [] # End of loop labels for BREAK
        self.jump_to_step_labels = [] # Jump to step labels for CONTINUE
        self.functions = {} # Dictionary of functions - (func_name : [arg_types])
        self.func_ptrs = {} # Dictionary of function pointers - (func_pointer : pointee)
        self.type_control = "" # Current type processed (for pointers)
        self.types_dict = {"char": 1, "short": 2, "int": 4, "long": 8} # Dictionary of types and their sizes (in bytes) ("char" : 1, "short": 2)
        self.structs = {}   # Dictionary of (struct_name: {(field_name: (offset from struct start, type))})

    # Generates unique label
    def generate_label(self):
        uniq_label = self.label + str(self.counter)            
        self.counter += 1
        return uniq_label

    def generate_asm(self, root, source_file):

        def save_general_purpose_regs():
            file.write("\tpushq   %rdi\n")
            file.write("\tpushq   %rsi\n")
            file.write("\tpushq   %rdx\n")
            file.write("\tpushq   %rcx\n")
            file.write("\tpushq   %r8\n")
            file.write("\tpushq   %r9\n")
            
        def pop_general_purpose_regs():
            file.write("\tpopq    %r9\n")
            file.write("\tpopq    %r8\n")
            file.write("\tpopq    %rcx\n")
            file.write("\tpopq    %rdx\n")
            file.write("\tpopq    %rsi\n")  
            file.write("\tpopq    %rdi\n")

        # Moves constant value to %eax
        def generate_constant(const_node, file):
            val = const_node.value
            file.write("\tmovq    ${0}, %rax\n".format(val))
            return val

        def isPointer(var_type):
            return (var_type[len(var_type) - 1] == "*")
        
        def isEightByte(var_type):
            return (var_type == "long" or isPointer(var_type))

        def removePointer(var_type):
            result = var_type

            for i in range(len(result)):
                if result[i] == "*":
                    result = result[:i]
                    break

            return result

        def isPrimitive(var_type):
            return (isPointer(var_type) or (var_type == "char") or (var_type == "short") or 
                    (var_type == "int") or (var_type == "long"))

        # Moves value of var to %rax
        def generate_variable(var_node, file):
            var_name = var_node.name

            if var_name not in self.outer_scope:
                print_var_not_declared()

            var_offset = self.outer_scope[var_name][0]
            var_type = self.outer_scope[var_name][1]

            if isPrimitive(var_type):
                if var_type == "char":
                    file.write("\tmovsbq  {}(%rbp), %rax\n".format(var_offset))
                elif var_type == "short":
                    file.write("\tmovswq  {}(%rbp), %rax\n".format(var_offset))
                elif var_type == "int":
                    file.write("\tmovslq  {}(%rbp), %rax\n".format(var_offset))
                elif isEightByte(var_type):
                    file.write("\tmovq    {}(%rbp), %rax\n".format(var_offset))
            else:
                file.write("\tleaq    {}(%rbp), %rax\n".format(var_offset))

            self.type_control = var_type
            return None

        # Generates unary operation's asm code
        def generate_unary_op(unary_op_node, file):
            unary_op_type = unary_op_node.__class__.__name__

            exp = unary_op_node.exp
            exp_type = exp.__class__.__name__
            operation = unary_op_node.op 

            exp_val = calculate_exp(exp, file)

            if operation == "-":
                file.write("\tneg     %rax\n")
                
                if exp_val != None:
                    return -exp_val
                else:
                    return None
            elif operation == "!":
                file.write("\tcmpq    $0, %rax\n")
                file.write("\txorq    %rax, %rax\n")
                file.write("\tsete    %al\n")

                if exp_val != None:
                    return (not exp_val)
                else:
                    return None
            elif operation == "~":
                file.write("\tnot     %rax\n")

                if exp_val != None:
                    return ~exp_val
                else:
                    return None
            elif operation == "*":
                if (exp_type != "UnaryOp" and exp_type != "Identifier") or (not isPointer(self.type_control)):
                    print_invalid_dereference()

                if self.type_control == "void*":
                    print_invalid_dereference()

                self.type_control = self.type_control[:len(self.type_control) - 1]

                if self.type_control == "char":
                    file.write("\tmovsbq  (%rax), %rax\n")
                elif self.type_control == "short":
                    file.write("\tmovswq  (%rax), %rax\n")
                elif self.type_control == "int":
                    file.write("\tmovslq  (%rax), %rax\n")
                elif isEightByte(self.type_control):
                    file.write("\tmovq    (%rax), %rax\n")  

                return None          
            elif operation == "&":
                if exp_type == "Identifier":
                    offset = self.outer_scope[exp.name][0]
                    self.type_control += "*"

                    file.write("\tleaq    {}(%rbp), %rax\n".format(offset))
                elif exp_type == "ArrayRef":
                    generate_array_ref(exp, file, True)
                else:
                    print_cant_take_address()

                return None

         # Generates binary operation's asm code
        def generate_binary_op(bin_op_node, file):
            def generate_and_op(lhs, rhs, file):
                left_val = calculate_exp(lhs, file)
                file.write("\tcmpq    $0, %rax\n")
                jne_to = self.generate_label()
                file.write("\tjne     " + jne_to + "\n")
                jmp_to = self.generate_label()
                file.write("\tjmp     " + jmp_to + "\n")
                file.write(jne_to + ":\n")
                right_val = calculate_exp(rhs, file)
                file.write("\tcmpq    $0, %rax\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetne   %al\n")
                file.write(jmp_to + ":\n")

                if left_val != None and right_val != None:
                    return (not not left_val) and (not not right_val)
                else:
                    return None

            def generate_or_op(lhs, rhs, file):
                left_val = calculate_exp(lhs, file)
                file.write("\tcmpq    $0, %rax\n")
                je_to = self.generate_label()
                file.write("\tje      " + je_to + "\n")
                file.write("\tmovq    $1, %rax\n")
                jmp_to = self.generate_label()
                file.write("\tjmp     " + jmp_to + "\n")              
                file.write(je_to + ":\n")
                right_val = calculate_exp(rhs, file)
                file.write("\tcmpq    $0, %rax\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetne   %al\n")
                file.write(jmp_to + ":\n")

                if left_val != None and right_val != None:
                    return (not not left_val) or (not not right_val)
                else:
                    return None

            ret = None

            lhs = bin_op_node.lhs
            rhs = bin_op_node.rhs
            op = bin_op_node.op

            lhs_name = lhs.__class__.__name__
            rhs_name = rhs.__class__.__name__

            if op == "&&":
                return generate_and_op(lhs, rhs, file)
            elif op == "||":
                return generate_or_op(lhs, rhs, file)

            left_val = calculate_exp(lhs, file)
            file.write("\tpushq   %rax\n")
            right_val = calculate_exp(rhs, file)
            file.write("\tpopq    %rcx\n") 
            
            # %rcx - lhs
            # %rax - rhs

            if op == "+":
                if lhs_name == "Identifier" and isPointer(self.outer_scope[lhs.name][1]):
                    if lhs.name not in self.outer_scope:
                        print_var_not_declared()
                    
                    var_type = self.outer_scope[lhs.name][1]
                    one_less_type = var_type[:len(var_type) - 1]
                    self.type_control = var_type

                    if one_less_type in self.types_dict:
                        file.write("\timul    ${}, %rax\n".format(self.types_dict[one_less_type]))
                    elif isPointer(one_less_type):
                        file.write("\timul    $8, %rax\n")

                    ret = None

                file.write("\taddq    %rcx, %rax\n")

                if left_val != None and right_val != None:
                    if ret != None:
                        return left_val + right_val
                    else:
                        return None
                else:
                    return None
            elif op == "*":
                file.write("\timul    %rcx, %rax\n")

                if left_val != None and right_val != None:
                    return left_val * right_val
                else:
                    return None
            elif op == "-":
                if lhs_name == "Identifier" and isPointer(self.outer_scope[lhs.name][1]):
                    if lhs.name not in self.outer_scope:
                        print_var_not_declared()
                    
                    var_type = self.outer_scope[lhs.name][1]
                    one_less_type = var_type[:len(var_type) - 1]
                    self.type_control = var_type

                    if one_less_type in self.types_dict:
                        file.write("\timul    ${}, %rax\n".format(self.types_dict[one_less_type]))
                    elif isPointer(one_less_type):
                        file.write("\timul    $8, %rax\n")
                    
                    ret = None

                file.write("\tsubq    %rcx, %rax\n")
                file.write("\tneg     %rax\n")

                if left_val != None and right_val != None:
                    if ret != None:
                        return left_val - right_val
                    else:
                        return None
                else:
                    return None
            elif op == "/":
                # push rax
                # move rcx rax
                # pop rcx
                file.write("\tpushq   %rax\n")
                file.write("\tmovq    %rcx, %rax\n")
                file.write("\tpopq    %rcx\n")
                file.write("\tcqo\n")
                file.write("\tidivq   %rcx\n")

                if left_val != None and right_val != None:
                    return left_val / right_val
                else:
                    return None
            elif op == "==":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsete    %al\n")

                if left_val != None and right_val != None:
                    return (left_val == right_val)
                else:
                    return None

            elif op == "!=":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetne   %al\n")

                if left_val != None and right_val != None:
                    return left_val != right_val
                else:
                    return None
            elif op == "<":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetl    %al\n")

                if left_val != None and right_val != None:
                    return left_val < right_val
                else:
                    return None
            elif op == "<=":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetle   %al\n")

                if left_val != None and right_val != None:
                    return left_val <= right_val
                else:
                    return None
            elif op == ">":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetg    %al\n")

                if left_val != None and right_val != None:
                    return left_val > right_val
                else:
                    return None
            elif op == ">=":
                file.write("\tcmpq    %rax, %rcx\n")
                file.write("\tmovq    $0, %rax\n")
                file.write("\tsetge   %al\n")

                if left_val != None and right_val != None:
                    return left_val >= right_val
                else:
                    return None
            elif op == "%":
                # Same as division
                file.write("\tpushq   %rax\n")
                file.write("\tmovq    %rcx, %rax\n")
                file.write("\tpopq    %rcx\n")
                file.write("\tcqo\n")
                file.write("\tidivq   %rcx\n")
                file.write("\tmovq    %rdx, %rax\n")

                if left_val != None and right_val != None:
                    return left_val % right_val
                else:
                    return None

        # Generate function call code
        def generate_function_call(func_call, file):
            func_name = func_call.name

            if (func_name not in self.func_ptrs) and (func_name not in self.functions):
                print_no_such_function_defined()
            elif func_name in self.func_ptrs:
                func_name = self.func_ptrs[func_name]

            args = func_call.args 
            arg_types = self.functions[func_name]
            
            first_six = args[:6]
            first_six_types = arg_types[:6]

            stack_args = args[6:]
            stack_arg_types = arg_types[6:]

            ### Save registers to restore them later
            save_general_purpose_regs()
            
            # Save first six args in the following registers
            # 1. %rdi
            # 2. %rsi
            # 3. %rdx
            # 4. %rcx
            # 5. %r8
            # 6. %r9
            # 7-... stack (but reversed)
            i = 0
            
            for arg in first_six:
                calculate_exp(arg, file)
                cur_type = first_six_types[i]

                if cur_type == "char":
                    if i == 0:
                        file.write("\txorq    %rdi, %rdi\n")
                        file.write("\tmovb    %al, %dil\n")
                    elif i == 1:
                        file.write("\txorq    %rsi, %rsi\n")
                        file.write("\tmovb    %al, %sil\n")
                    elif i == 2:
                        file.write("\txorq    %rdx, %rdx\n")
                        file.write("\tmovb    %al, %dl\n")
                    elif i == 3:
                        file.write("\txorq    %rcx, %rcx\n")
                        file.write("\tmovb    %al, %cl\n")
                    elif i == 4:
                        file.write("\txorq    %r8, %r8\n")
                        file.write("\tmovb    %al, %r8b\n")
                    elif i == 5:
                        file.write("\txorq    %r9, %r9\n")
                        file.write("\tmovb    %al, %r9b\n")
                elif cur_type == "short":
                    if i == 0:
                        file.write("\txorq    %rdi, %rdi\n")
                        file.write("\tmovw    %ax, %di\n")
                    elif i == 1:
                        file.write("\txorq    %rsi, %rsi\n")
                        file.write("\tmovw    %ax, %si\n")
                    elif i == 2:
                        file.write("\txorq    %rdx, %rdx\n")
                        file.write("\tmovw    %ax, %dx\n")
                    elif i == 3:
                        file.write("\txorq    %rcx, %rcx\n")
                        file.write("\tmovw    %ax, %cx\n")
                    elif i == 4:
                        file.write("\txorq    %r8, %r8\n")
                        file.write("\tmovw    %ax, %r8w\n")
                    elif i == 5:
                        file.write("\txorq    %r9, %r9\n")
                        file.write("\tmovw    %ax, %r9w\n")
                elif cur_type == "int":
                    if i == 0:
                        file.write("\txorq    %rdi, %rdi\n")
                        file.write("\tmovl    %eax, %edi\n")
                    elif i == 1:
                        file.write("\txorq    %rsi, %rsi\n")
                        file.write("\tmovl    %eax, %esi\n")
                    elif i == 2:
                        file.write("\txorq    %rdx, %rdx\n")
                        file.write("\tmovl    %eax, %edx\n")
                    elif i == 3:
                        file.write("\txorq    %rcx, %rcx\n")
                        file.write("\tmovl    %eax, %ecx\n")
                    elif i == 4:
                        file.write("\txorq    %r8, %r8\n")
                        file.write("\tmovl    %eax, %r8d\n")
                    elif i == 5:
                        file.write("\txorq    %r9, %r9\n")
                        file.write("\tmovl    %eax, %r9d\n")
                elif isEightByte(cur_type):
                    if i == 0:
                        file.write("\tmovq    %rax, %rdi\n")
                    elif i == 1:
                        file.write("\tmovq    %rax, %rsi\n")
                    elif i == 2:
                        file.write("\tmovq    %rax, %rdx\n")
                    elif i == 3:
                        file.write("\tmovq    %rax, %rcx\n")
                    elif i == 4:
                        file.write("\tmovq    %rax, %r8\n")
                    elif i == 5:
                        file.write("\tmovq    %rax, %r9\n")

                i += 1

            ### Save stack arguments in stack (for function call)
            stack_args.reverse()
            stack_arg_types.reverse()
            deallocate_bytes = 0
            i = 0

            for arg in stack_args:
                calculate_exp(arg, file)
                var_type = stack_arg_types[i]

                if var_type in self.types_dict:
                    file.write("\tsubq    ${}, %rsp\n".format(self.types_dict[var_type]))
                    deallocate_bytes += self.types_dict[var_type]
                else:
                    file.write("\tsubq    $8, %rsp\n")
                    deallocate_bytes += 8

                if var_type == "char":
                    file.write("\tmovb    %al, (%rsp)\n")
                elif var_type == "short":
                    file.write("\tmovw    %ax, (%rsp)\n")
                elif var_type == "int":
                    file.write("\tmovl    %eax, (%rsp)\n")
                elif isEightByte(var_type):
                    file.write("\tmovq    %rax, (%rsp)\n")

                i += 1

            ### Call the function, arguments are ready, initialized
            file.write("\tcallq   {}\n".format(func_name))

            ### Restore saved registers (as was before function call)
            pop_general_purpose_regs()

            ### Deallocate allocated bytes for function call
            if deallocate_bytes != 0:
                file.write("\taddq    ${}, %rsp\n".format(deallocate_bytes))

            return None

        # Generates array reference assembly code -> arr[0] arr[1] ...
        def generate_array_ref(exp, file, ret_address=False):
            file.write("\tpushq   %rcx\n")
            file.write("\tpushq   %r8\n")

            arr_name = exp.arr_name

            if arr_name not in self.outer_scope:
                print_var_not_declared()

            indices = exp.indices
            arr_offset = self.outer_scope[arr_name][0]
            elem_type = self.outer_scope[arr_name][1]
            
            dimensions = []
            normal = False
            if len(self.outer_scope[arr_name]) == 3:
                dimensions = self.outer_scope[arr_name][2]
                mult = 1

                dim_len = len(dimensions)
                elem_type = elem_type[:len(elem_type) - dim_len]

            if len(dimensions) == 0:
                if len(indices) != 1:
                    print_expected_comma()

                index = indices[0]
                calculate_exp(index, file)
                elem_type = elem_type[:len(elem_type) - 1]
            else:
                normal = True
                for dim in dimensions:
                    mult *= dim

                if len(indices) != len(dimensions):
                    print_invalid_array_reference()

                left_mult = mult
                elems_offset = indices[0]

                file.write("\txorq    %r8, %r8\n")

                for i in range(len(indices)):
                    index = indices[i]
                    calculate_exp(index, file) # index in %rax
                    dim = dimensions[i]
                    left_mult = left_mult / dim

                    file.write("\timul    ${}, %rax\n".format(int(left_mult)))
                    file.write("\taddq    %rax, %r8\n")

                file.write("\tmovq    %r8, %rax\n") # %rax contains num elems offset from arr start

            if elem_type in self.types_dict:
                file.write("\timul    ${}, %rax\n".format(self.types_dict[elem_type]))
            elif isPointer(elem_type):
                file.write("\timul    $8, %rax\n")

            if normal:
                file.write("\tleaq    {}(%rbp), %rcx\n".format(int(arr_offset)))
            else:
                file.write("\tmovq    {}(%rbp), %rcx\n".format(int(arr_offset)))   

            file.write("\taddq    %rax, %rcx\n")
            
            if ret_address:
                file.write("\tmovq    %rcx, %rax\n")
            else:
                file.write("\txorq    %rax, %rax\n")
                if elem_type == "char":
                    file.write("\tmovb    (%rcx), %al\n")
                elif elem_type == "short":
                    file.write("\tmovw    (%rcx), %ax\n")
                elif elem_type == "int":
                    file.write("\tmovl    (%rcx), %eax\n")
                elif isEightByte(elem_type):
                    file.write("\tmovq    (%rcx), %rax\n")

            file.write("\tpopq    %r8\n")
            file.write("\tpopq    %rcx\n")
            return None

        # Write expression's value to %rax
        def calculate_exp(exp, file, ret_address=False):
            exp_type = exp.__class__.__name__
            self.type_control = ""

            if exp_type == "Constant":
                return generate_constant(exp, file)
            elif exp_type == "Identifier":
                return generate_variable(exp, file)
            elif exp_type == "UnaryOp":
                return generate_unary_op(exp, file)
            elif exp_type == "BinaryOp":
                return generate_binary_op(exp, file)
            elif exp_type == "Assignment":
                return generate_var_assignment(exp, file)
            elif exp_type == "FunctionCall":
                return generate_function_call(exp, file)
            elif exp_type == "ArrayRef":
                return generate_array_ref(exp, file, ret_address)
            elif exp_type == "StructAccess":
                generate_struct_access(exp, file)
                return None

        # Generates asm code for return statement
        def generate_return(ret_node, file):
            exp = ret_node.exp
            exp_type = exp.__class__.__name__
            return_type = ret_node.return_type

            if return_type != None:
                ret_type_lower = return_type.lower()

                calculate_exp(exp, file)
                file.write("\tmovq    %rax, %rcx\n")

                if ret_type_lower == "char":
                    file.write("\tmovsbq  %cl, %rax\n")
                elif ret_type_lower == "short":
                    file.write("\tmovswq  %cx, %rax\n")
                elif ret_type_lower == "int":
                    file.write("\tmovslq  %ecx, %rax\n")
                elif isEightByte(ret_type_lower):
                    file.write("\tmovq    %rcx, %rax\n")

            generate_function_epilogue()
            file.write("\tret\n")

        # Generates asm code for variable declaration
        def generate_var_declaration(node, func_map, file):
            if node.var.name in self.outer_scope:
                print_var_already_declared()
            
            if node.type == "void":
                print_cant_declare_void()

            raw_type = removePointer(node.type)

            if (raw_type not in self.types_dict) and (raw_type != "void"):
                print_invalid_type()

            if node.type in self.types_dict:
                file.write("\tsubq    ${}, %rsp\n".format(self.types_dict[node.type]))
                self.stack_index -= self.types_dict[node.type]
            else:
                file.write("\tsubq    $8, %rsp\n")
                self.stack_index -= 8

            self.outer_scope[node.var.name] = (self.stack_index, node.type)
            func_map[node.var.name] = (self.stack_index, node.type)

            if node.exp != None:
                calculate_exp(node.exp, file)
                var_offset = self.outer_scope[node.var.name][0]
                
                if isPrimitive(node.type):
                    if node.type == "char":
                        file.write("\tmovb    %al, {}(%rbp)\n".format(var_offset))
                    elif node.type == "short":
                        file.write("\tmovw    %ax, {}(%rbp)\n".format(var_offset))
                    elif node.type == "int":
                        file.write("\tmovl    %eax, {}(%rbp)\n".format(var_offset)) 
                    elif isEightByte(node.type):
                        file.write("\tmovq    %rax, {}(%rbp)\n".format(var_offset))
                else:
                    if node.exp.__class__.__name__ == "Identifier":
                        assignee_type = self.outer_scope[node.exp.name][1]

                        if assignee_type != node.type:
                            print_invalid_assignment_statement()

                        num_bytes = self.types_dict[node.type]
                        dest_offset = self.outer_scope[node.var.name][0]
                        # source address is in the %rcx
                        file.write("\tmovq    %rax, %rcx\n")

                        cur_offset = dest_offset

                        for i in range(int(num_bytes / 8)):
                            file.write("\tmovq    {}(%rcx), %rax\n".format(i * 8))
                            file.write("\tmovq    %rax, {}(%rbp)\n".format(dest_offset))
                            dest_offset += 8

        # Generates struct access (saves field in %rax)
        def generate_struct_access(node, file, ret_address=False, father_members=self.outer_scope):
            str_exp = node.struct_exp
            field_exp = node.field
            str_exp_name = str_exp.__class__.__name__
            field_exp_name = field_exp.__class__.__name__
            is_pointer = node.pointer
            str_type = ""

            if str_exp_name == "Identifier":
                str_type = father_members[str_exp.name][1]

                if father_members == self.outer_scope:
                    generate_variable(str_exp, file)
                else:
                    offset = father_members[str_exp.name][0]
                    file.write("\taddq    ${}, %rax\n".format(offset))

                    if ret_address == False:
                        file.write("\tmovq    (%rax), %rax\n")
            elif str_exp_name == "ArrayRef":
                str_type = father_members[str_exp.arr_name][1]
                str_type = str_type[:-1]

                if father_members == self.outer_scope:
                    generate_array_ref(str_exp, file, True)
                else:
                    print_cant_do_that()

            if is_pointer and (not isPointer(str_type)):
                print_invalid_dereference()

            str_type = removePointer(str_type)
            members = self.structs[str_type]
            field_type = ""            

            if field_exp_name == "Identifier":
                field_name = field_exp.name
                if field_name not in members:
                    print_var_not_declared()
                
                field_offset = members[field_name][0]
                field_type = members[field_name][1]

                file.write("\taddq    ${}, %rax\n".format(field_offset))
    
                if ret_address == False:
                    file.write("\tmovq    %rax, %rcx\n")
    
                    if isPrimitive(field_type):
                        file.write("\txorq    %rax, %rax\n")
                        if field_type == "char":
                            file.write("\tmovb    (%rcx), %al\n")
                        elif field_type == "short":
                            file.write("\tmovw    (%rcx), %ax\n")
                        elif field_type == "int":
                            file.write("\tmovl    (%rcx), %eax\n")
                        elif isEightByte(field_type):
                            file.write("\tmovq    (%rcx), %rax\n")

            elif field_exp_name == "ArrayRef":
                file.write("\tmovq    %rax, %r9\n") # struct start

                field_name = field_exp.arr_name
                if field_name not in members:
                    print_var_not_declared()
                
                field_offset = members[field_name][0] # Field offset from struct start
                elem_type = members[field_name][1]
                field_type = elem_type
                dimensions = [] 
                indices = field_exp.indices
                normal = False
                mult = 1

                file.write("\taddq    ${}, %r9\n".format(field_offset)) # start of field
                # need to calculate elem offset from arr start

                if len(members[field_name]) == 3:
                    dimensions = members[field_name][2]
                    mult = 1

                    dim_len = len(dimensions)
                    elem_type = elem_type[:-dim_len]

                if len(dimensions) == 0:
                    if len(indices) != 1:
                        print_expected_comma()

                    index = indices[0]
                    calculate_exp(index, file)
                    
                    elem_type = elem_type[:-1]
                else:
                    normal = True

                    for dim in dimensions:
                        mult *= dim

                    if len(indices) != len(dimensions):
                        print_invalid_array_reference()

                    left_mult = mult
                    elems_offset = indices[0]

                    file.write("\txorq    %r8, %r8\n")

                    for i in range(len(indices)):
                        index = indices[i]
                        calculate_exp(index, file) # index in %rax
                        dim = dimensions[i]
                        left_mult = left_mult / dim

                        file.write("\timul    ${}, %rax\n".format(int(left_mult)))
                        file.write("\taddq    %rax, %r8\n")

                    file.write("\tmovq    %r8, %rax\n") # num elems offset from arr start

                if elem_type in self.types_dict:
                    file.write("\timul    ${}, %rax\n".format(self.types_dict[elem_type]))
                elif isPointer(elem_type):
                    file.write("\timul    $8, %rax\n")

                # %rax contains num bytes offset from arr
                if normal:
                    file.write("\tleaq    {}(%r9), %rcx\n".format(field_offset))
                else:
                    file.write("\tmovq    {}(%r9), %rcx\n".format(field_offset))
                
                file.write("\taddq    %rax, %rcx\n")

                if ret_address:
                    file.write("\tmovq    %rcx, %rax\n")
                else:
                    if isPrimitive(elem_type):
                        file.write("\txorq    %rax, %rax\n")
                        if elem_type == "char":
                            file.write("\tmovb    (%rcx), %al\n")
                        elif elem_type == "short":
                            file.write("\tmovw    (%rcx), %ax\n")
                        elif elem_type == "int":
                            file.write("\tmovl    (%rcx), %eax\n")
                        elif isEightByte(elem_type):
                            file.write("\tmovq    (%rcx), %rax\n")
            elif field_exp_name == "StructAccess":
                inner_field_name = field_exp.field.__class__.__name__

                if inner_field_name == "StructAccess":
                    field_type = generate_struct_access(field_exp, file, True, members)
                else:
                    field_type = generate_struct_access(field_exp, file, ret_address, members)


            return field_type    
            
        # Generates asm code for variable assignment
        def generate_var_assignment(node, file):
            if (node.var != None):
                if (node.var.name not in self.outer_scope):
                    print_var_not_declared()

            if node.exp != None:
                if node.deref != None:
                    node_deref_name = node.deref.__class__.__name__

                    if node_deref_name == "UnaryOp":
                        calculate_exp(node.deref.exp, file) # this is where we save var 
                        var_type = self.type_control[:len(self.type_control) - 1]

                        if (not isPointer(self.type_control)) or (self.type_control == "void*"):
                            print_invalid_dereference()
                        
                        file.write("\tpushq   %rax\n") # save it in stack
                        calculate_exp(node.exp, file)
                        file.write("\tpopq    %rcx\n") # pop address from stack

                        if var_type == "char":
                            file.write("\tmovb    %al, (%rcx)\n")
                        elif var_type == "short":
                            file.write("\tmovw    %ax, (%rcx)\n")
                        elif var_type == "int":
                            file.write("\tmovl    %eax, (%rcx)\n")
                        elif isEightByte(var_type):
                            file.write("\tmovq    %rax, (%rcx)\n")
                    elif node_deref_name == "ArrayRef":
                        arr_name = node.deref.arr_name
                        generate_array_ref(node.deref, file, True)
                        file.write("\tmovq    %rax, %rcx\n")

                        if arr_name not in self.outer_scope:
                            print_var_not_declared()
                        
                        file.write("\tpushq   %rcx\n")
                        calculate_exp(node.exp, file)
                        file.write("\tpopq    %rcx\n")

                        dim_len = 1
                        if len(self.outer_scope[arr_name]) == 3:
                            dim_len = len(self.outer_scope[arr_name][2])

                        elem_type = self.outer_scope[arr_name][1]
                        elem_type = elem_type[:len(elem_type) - dim_len]
                        
                        if isPrimitive(elem_type):
                            if elem_type == "char":
                                file.write("\tmovb    %al, (%rcx)\n")
                            elif elem_type == "short":
                                file.write("\tmovw    %ax, (%rcx)\n")
                            elif elem_type == "int":
                                file.write("\tmovl    %eax, (%rcx)\n")
                            elif isEightByte(elem_type):
                                file.write("\tmovq    %rax, (%rcx)\n")
                        else:
                            # Should write from %rdx to %rcx
                            num_bytes = self.types_dict[elem_type]
                            dest_offset = 0
                            file.write("\tmovq    %rax, %rdx\n")

                            for i in range(int(num_bytes / 8)):
                                file.write("\tmovq    {}(%rdx), %rax\n".format(dest_offset))
                                file.write("\tmovq    %rax, {}(%rcx)\n".format(dest_offset))
                                dest_offset += 8

                    elif node_deref_name == "StructAccess":
                        str_access = node.deref
                        field_type = generate_struct_access(str_access, file, True)

                        file.write("\tmovq    %rax, %rcx\n")
                        file.write("\tpushq   %rcx\n")
                        calculate_exp(node.exp, file)
                        file.write("\tpopq    %rcx\n")

                        if isPrimitive(field_type):
                            if field_type == "char":
                                file.write("\tmovb    %al, (%rcx)\n")
                            elif field_type == "short":
                                file.write("\tmovw    %ax, (%rcx)\n")
                            elif field_type == "int":
                                file.write("\tmovl    %eax, (%rcx)\n")
                            elif isEightByte(field_type):
                                file.write("\tmovq    %rax, (%rcx)\n")
                        else:
                            num_bytes = self.types_dict[field_type]
                            dest_offset = 0
                            cur_offset = dest_offset

                            file.write("\tmovq    %rax, %rdx\n")
                            for i in range(int(num_bytes / 8)):
                                file.write("\tmovq    {}(%rdx), %rax\n".format(i * 8))
                                file.write("\tmovq    %rax, {}(%rcx)\n".format(dest_offset))
                                dest_offset += 8
                else:
                    if self.func_ptrs.get(node.var.name) == None:
                        calculate_exp(node.exp, file)
                        var_offset = self.outer_scope[node.var.name][0]
                        var_type = self.outer_scope[node.var.name][1]

                        if var_type == "char":
                            file.write("\tmovb    %al, {}(%rbp)\n".format(var_offset))
                        elif var_type == "short":
                            file.write("\tmovw    %ax, {}(%rbp)\n".format(var_offset))
                        elif var_type == "int":
                            file.write("\tmovl    %eax, {}(%rbp)\n".format(var_offset)) 
                        elif isEightByte(var_type):
                            file.write("\tmovq    %rax, {}(%rbp)\n".format(var_offset))
                    else:
                        pointee = node.exp.exp.name

                        if self.functions.get(pointee) == None:
                            print_no_such_function_defined()

                        arg_types = self.functions[node.var.name]

                        if arg_types != self.functions[pointee]:
                            print_nonmatching_parameter_types()

                        self.func_ptrs[node.var.name] = pointee

            return None

        # Generates asm code for a block of statements
        def generate_block(node, file): # node - (Block)
            block_var_map = {}

            for stmt in node.children:
                generate_statement_asm(stmt, block_var_map, file)

            deallocate_bytes = 0

            for var in block_var_map:
                var_type = block_var_map[var][1]
                self.outer_scope.pop(var)

                if var_type in self.types_dict:
                    deallocate_bytes += self.types_dict[var_type]
                else:
                    deallocate_bytes += 8

            if deallocate_bytes != 0:
                file.write("\taddq    ${}, %rsp\n".format(deallocate_bytes))
                self.stack_index += deallocate_bytes

        # Generates if_statement's asm code
        def generate_if_statement(node, file):
            post_label = self.generate_label()

            calculate_exp(node.exp, file)
            file.write("\tcmpq    $0, %rax\n")
            
            if node.else_body == None:
                file.write("\tje      " + post_label + "\n")
                generate_block(node.body, file)
                file.write(post_label + ":\n")
            else:
                else_label = self.generate_label()
                file.write("\tje      " + else_label + "\n")
                generate_block(node.body, file)
                file.write("\tjmp     " + post_label + "\n")
                file.write(else_label + ":\n")
                generate_block(node.else_body, file)
                file.write(post_label + ":\n")
            
        # Generates for-loop's assembly code
        def generate_for_loop(node, file):
            body_scope = {}
            generate_statement_asm(node.init, body_scope, file)
            
            test_label = self.generate_label()
            step_label = self.generate_label()
            self.jump_to_step_labels.append(step_label)

            file.write(test_label + ":\n")
            if node.test.__class__.__name__ == "Empty":
                file.write("\tmovq    $1, %rax\n")
            else:
                calculate_exp(node.test, file)

            finish_label = self.generate_label()
            self.end_of_loop_labels.append(finish_label)

            file.write("\tcmpq    $0, %rax\n")
            file.write("\tje      " + finish_label + "\n")
            
            if node.body != None:
                generate_block(node.body, file)
            
            file.write(step_label + ":\n")
            generate_statement_asm(node.step, body_scope, file)
            file.write("\tjmp     " + test_label + "\n")

            file.write(finish_label + ":\n")

            deallocate_bytes = 0

            for var in body_scope:
                var_type = body_scope[var][1]
                self.outer_scope.pop(var)

                if var_type in self.types_dict:
                    deallocate_bytes += self.types_dict[var_type]
                else:
                    deallocate_bytes += 8

            if deallocate_bytes != 0:
                self.stack_index += deallocate_bytes
                file.write("\taddq    ${}, %rsp\n".format(deallocate_bytes))

            self.jump_to_step_labels.pop()
            self.end_of_loop_labels.pop()

        # Generates while-loop's assembly code
        def generate_while_loop(node, file):
            test_label = self.generate_label()
            self.jump_to_step_labels.append(test_label)

            file.write(test_label + ":\n")
            if node.exp.__class__.__name__ == "Empty":
                print_no_test_while()
            else:
                calculate_exp(node.exp, file)

            finish_label = self.generate_label()
            self.end_of_loop_labels.append(finish_label)
            
            file.write("\tcmpq    $0, %rax\n")
            file.write("\tje      " + finish_label + "\n")
            
            if node.body != None:
                generate_block(node.body, file)

            file.write("\tjmp     " + test_label + "\n")
            file.write(finish_label + ":\n")

            self.jump_to_step_labels.pop()
            self.end_of_loop_labels.pop()

        # Generates do-while-loop's assembly code
        def generate_do_while_loop(node, file):
            generate_block(node.body, file)
            
            test_label = self.generate_label()
            self.jump_to_step_labels.append(test_label)

            file.write(test_label + ":\n")
            if node.exp.__class__.__name__ == "Empty":
                print_no_test_while()
            else:
                calculate_exp(node.exp, file)

            finish_label = self.generate_label()
            self.end_of_loop_labels.append(finish_label)

            file.write("\tcmpq    $0, %rax\n")
            file.write("\tje      " + finish_label + "\n")
            
            generate_block(node.body, file)

            file.write("\tjmp     " + test_label + "\n")
            file.write(finish_label + ":\n")

            self.jump_to_step_labels.pop()
            self.end_of_loop_labels.pop()


        # Generates continue statement's assembly code
        def generate_continue(file):
            length = len(self.jump_to_step_labels)
            
            if length == 0:
                print_not_in_loop()

            last_label = self.jump_to_step_labels[length - 1]
            file.write("\tjmp     " + last_label + "\n")
    
        # Generates break statement's assembly code
        def generate_break(file):
            length = len(self.end_of_loop_labels)
            if length == 0:
                print_not_in_loop()

            last_label = self.end_of_loop_labels[length - 1]
            file.write("\tjmp     " + last_label + "\n")

        # Generates function pointer logic 
        def generate_function_pointer(func, func_map, file):
            arg_types = []

            for arg in func.args:
                arg_types.append(arg.type)

            if (func.pointee in self.functions) and (arg_types != self.functions[func.pointee]):
                print_nonmatching_parameter_types()

            self.outer_scope[func.name] = (-1, "FUNC_PTR")
            func_map[func.name] = (-1, "FUNC_PTR")
            self.functions[func.name] = arg_types
            self.func_ptrs[func.name] = func.pointee

        # Generates assembly code for array initialization
        def generate_array_init(node, func_map, file):
            #       ...
            #       arr[2]
            #       arr[1]
            #       arr[0]  -- Array start (saved in scopes)  

            name = node.name
            arr_elem_type = node.elem_type
            dimensions = node.dimensions
            dimensions_literal = []
            elems = node.elems 
            arr_type = arr_elem_type
            single_elem_size = 1
            num_elems = 1
            num_bytes = 1

            for i in range(len(dimensions)):
                arr_type += "*"

            for dim in dimensions:
                dim_val = calculate_exp(dim, file)
    
                if dim_val == None:
                    print_var_sized_array()

                num_elems *= dim_val
                dimensions_literal.append(dim_val)

            num_bytes = num_elems

            raw_type = removePointer(arr_elem_type)
            if raw_type not in self.types_dict:
                print_invalid_type()

            if arr_elem_type in self.types_dict:
                single_elem_size = self.types_dict[arr_elem_type]
            else:
                single_elem_size = 8
            
            num_bytes *= single_elem_size
            
            self.stack_index -= num_bytes
            file.write("\tsubq    ${}, %rsp\n".format(num_bytes))

            func_map[name] = (self.stack_index, arr_type, dimensions_literal)
            self.outer_scope[name] = (self.stack_index, arr_type, dimensions_literal)

            if elems != None:
                for i in range(len(elems)):
                    # rbp - (i * single_elem_size)
                    cur_elem = elems[i]
                    calculate_exp(cur_elem, file)
                    up_from_sp_bytes = i * single_elem_size
                    offset_from_rbp = self.stack_index + up_from_sp_bytes

                    if isPrimitive(arr_elem_type):
                        if arr_elem_type == "char":
                            file.write("\tmovb    %al, {}(%rbp)\n".format(offset_from_rbp))
                        elif arr_elem_type == "short":
                            file.write("\tmovw    %ax, {}(%rbp)\n".format(offset_from_rbp))
                        elif arr_elem_type == "int":
                            file.write("\tmovl    %eax, {}(%rbp)\n".format(offset_from_rbp))
                        elif isEightByte(arr_elem_type):
                            file.write("\tmovq    %rax, {}(%rbp)\n".format(offset_from_rbp))
                    else:
                        if cur_elem.__class__.__name__ == "Identifier":
                            assignee_type = self.outer_scope[cur_elem.name][1]

                            if assignee_type != arr_elem_type:
                                print_invalid_assignment_statement()

                            num_bytes = self.types_dict[arr_elem_type]
                            dest_offset = offset_from_rbp
                            # source address is in the %rcx
                            file.write("\tmovq    %rax, %rcx\n")

                            cur_offset = dest_offset

                            for i in range(int(num_bytes / 8)):
                                file.write("\tmovq    {}(%rcx), %rax\n".format(i * 8))
                                file.write("\tmovq    %rax, {}(%rbp)\n".format(dest_offset))
                                dest_offset += 8
                        

        # Generates statement's asm code
        def generate_statement_asm(node, func_map, file):
            node_class_name = node.__class__.__name__

            if node_class_name == "Return":
                generate_return(node, file)
            elif node_class_name == "Declaration":
                generate_var_declaration(node, func_map, file)
            elif node_class_name == "ArrayInit":
                generate_array_init(node, func_map, file)
            elif node_class_name == "Assignment":
                generate_var_assignment(node, file)
            elif node_class_name == "IfStatement":
                generate_if_statement(node, file)
            elif node_class_name == "Block":
                generate_block(node, file)
            elif node_class_name == "ForLoop":
                generate_for_loop(node, file)
            elif node_class_name == "WhileLoop":
                generate_while_loop(node, file)
            elif node_class_name == "DoWhileLoop":
                generate_do_while_loop(node, file)
            elif node_class_name == "Function":
                generate_function_pointer(node, func_map, file)
            elif node_class_name == "Continue":
                generate_continue(file)
            elif node_class_name == "Break":
                generate_break(file)
            elif node_class_name == "FunctionCall":
                generate_function_call(node, file)
            else:
                calculate_exp(node, file)

        # Generate function prologue (set %rsp and save %rbp)
        def generate_function_prologue():
            file.write("\tpushq   %rbp\n")
            file.write("\tmovq    %rsp, %rbp\n")

        # Generate function epilogue (set restore %rsp and %rbp to initial state)
        def generate_function_epilogue():
            file.write("\tmovq    %rbp, %rsp\n")
            file.write("\tpopq    %rbp\n")

        # Generates every function definition's asm code      
        def generate_function_asm(node, file):
            func_name = node.name 
            type_list = []
            func_map = {}

            for arg in node.args:
                type_list.append(arg.type)

            self.functions[func_name] = type_list

            if node.body == None:
                return

            file.write(func_name + ":\n")
            generate_function_prologue()
            self.stack_index = 0
            
            ### SAVE ARGS

            # 1. %rdi
            # 2. %rsi
            # 3. %rdx
            # 4. %rcx
            # 5. %r8
            # 6. %r9
            # 7-... stack (but reversed)

            ### SAVE PARAMETERS IN STACK AND SET THEIR STACK_INDEXES IN MAP
            first_six_args = node.args[:6]
            other_args = node.args[6:]

            for i in range(len(first_six_args)):
                var_type = first_six_args[i].type
                var_name = first_six_args[i].var.name

                if var_type in self.types_dict:
                    file.write("\tsubq    ${}, %rsp\n".format(self.types_dict[var_type]))
                    self.stack_index -= self.types_dict[var_type]
                else:
                    file.write("\tsubq    $8, %rsp\n")
                    self.stack_index -= 8

                if i == 0:
                    if var_type == "char":
                        file.write("\tmovb    %dil, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %di, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %edi, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %rdi, {}(%rbp)\n".format(self.stack_index))
                elif i == 1:
                    if var_type == "char":
                        file.write("\tmovb    %sil, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %si, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %esi, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %rsi, {}(%rbp)\n".format(self.stack_index))
                elif i == 2:
                    if var_type == "char":
                        file.write("\tmovb    %dl, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %dx, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %edx, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %rdx, {}(%rbp)\n".format(self.stack_index))
                elif i == 3:
                    if var_type == "char":
                        file.write("\tmovb    %cl, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %cx, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %ecx, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %rcx, {}(%rbp)\n".format(self.stack_index))
                elif i == 4:
                    if var_type == "char":
                        file.write("\tmovb    %r8b, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %r8w, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %r8d, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %r8, {}(%rbp)\n".format(self.stack_index)) 
                elif i == 5:
                    if var_type == "char":
                        file.write("\tmovb    %r9b, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "short":
                        file.write("\tmovw    %r9w, {}(%rbp)\n".format(self.stack_index))
                    elif var_type == "int":
                        file.write("\tmovl    %r9d, {}(%rbp)\n".format(self.stack_index))
                    elif isEightByte(var_type):
                        file.write("\tmovq    %r9, {}(%rbp)\n".format(self.stack_index))

                func_map[var_name] = (self.stack_index, var_type)
                self.outer_scope[var_name] = (self.stack_index, var_type)
            ###

            ### SAVE PARAMETERS PASSED FROM STACK (7th and after)
            param_offset = 16

            for param in other_args:
                self.outer_scope[param.var.name] = (param_offset, param.type)
                func_map[param.var.name] = (param_offset, param.type)
                
                if param.type in self.types_dict:
                    param_offset += self.types_dict[param.type]
                else:
                    param_offset += 8

            ### END OF ARGS

            i = 0
            func_body = node.body
            num_children = len(func_body.children)

            for stmt in func_body.children:
                generate_statement_asm(stmt, func_map, file)
                i += 1

                if i == num_children and stmt.__class__.__name__ != "Return":
                    generate_function_epilogue() # Return has its' own epilogue
                    file.write("\tret\n")

            # Remove func_dict variables from global map
            for key in func_map:
                self.outer_scope.pop(key)

                if self.func_ptrs.get(key) != None:
                    self.func_ptrs.pop(key)

                if self.functions.get(key) != None:
                    self.functions.pop(key)

            func_map = {}


        # Generates asm code for structure declaration
        def generate_struct_decl(struct_decl_node, file):
            struct_name = struct_decl_node.name
            struct_members = struct_decl_node.members

            if (struct_name in self.structs) or (struct_name in self.types_dict):
                print_struct_already_declared()

            self.structs[struct_name] = {}
            self.types_dict[struct_name] = 0

            cur_offset = 0

            for member in struct_members:
                member_class = member.__class__.__name__
                
                if member_class == "Declaration":
                    memb_name = member.var.name
                    memb_type = member.type

                    raw_type = removePointer(memb_type)

                    if raw_type not in self.types_dict:
                        print_invalid_type()

                    if memb_name in self.structs[struct_name]:
                        print_var_already_declared()

                    self.structs[struct_name][memb_name] = (cur_offset, memb_type)

                    if isPointer(memb_type):
                        cur_offset += 8
                    else:
                        cur_offset += self.types_dict[memb_type]
                elif member_class == "ArrayInit":
                    memb_name = member.name
                    elem_type = member.elem_type
                    arr_type = elem_type
                    dimensions = member.dimensions
                    dimensions_literal = []

                    num_elems = 1
                    num_bytes = 1
                    single_elem_size = 0

                    for i in range(len(dimensions)):
                        arr_type += "*"

                    raw_type = removePointer(elem_type)

                    if raw_type not in self.types_dict:
                        print_invalid_type()

                    if memb_name in self.structs[struct_name]:
                        print_var_already_declared()
                    
                    for dim in dimensions:
                        dim_val = calculate_exp(dim, file)
            
                        if dim_val == None:
                            print_var_sized_array()

                        num_elems *= dim_val
                        dimensions_literal.append(dim_val)

                    num_bytes = num_elems

                    if elem_type in self.types_dict:
                        single_elem_size = self.types_dict[elem_type]
                    else:
                        single_elem_size = 8
                    
                    num_bytes *= single_elem_size

                    self.structs[struct_name][memb_name] = (cur_offset, arr_type, dimensions_literal)
                    cur_offset += num_bytes

            if cur_offset % 8 != 0:
                cur_offset += (8 - cur_offset % 8)

            self.types_dict[struct_name] = cur_offset

        ############# MAIN CODE #############
      
        file_name = source_file + ".s"
        file = open(file_name, "a")
        file.truncate(0)

        children = root.children

        # we assume children are functions (for now)
        for child in children:
            child_name = child.__class__.__name__
            
            if child_name == "Function":
                if child.body != None:
                    file.write("\t.globl  " + child.name + "\n")

        for child in children:
            child_name = child.__class__.__name__

            if child_name == "Function":
                generate_function_asm(child, file)
            elif child_name == "StructDecl":
                generate_struct_decl(child, file)

        file.close()