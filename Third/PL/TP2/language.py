import sys
import ply.yacc as yacc
from toks_file import tokens

def p_Programa(p): 
    "Program : Commands "
    parser.assembly = f'START\n{p[1]}STOP\n'

def p_Commands_empty(p):
    "Commands : "
    p[0] = f''

def p_Commands_Various(p):
    "Commands : Command Commands"
    p[0] = f'{p[1]}{p[2]}'

def p_Command_Declaration(p):
    "Command : Declaration"
    p[0] = p[1]

def p_Declaration_Int(p):
    "Declaration : INT NOME"
    if p[2] not in p.parser.registers:
        p.parser.registers.update({p[2] : p.parser.gp})
        p[0] = f'PUSH 0\n'
        p.parser.ints.append(p[2])
        p.parser.gp += 1
    else:
        print("ERROR : A variavel já existe")
        parser.success = False


def p_Declaration_Array(p):
    "Declaration : ARRAY NOME PAA NUMBER PAF"
    if p[2] not in p.parser.registers:
        p.parser.registers.update({p[2] : (p.parser.gp, int(p[4]))})
        p[0] = f'PUSHN {p[4]}\n'
        p.parser.gp += int(p[4])
    else:
        print("Erro: Variável já existe.")
        parser.success = False

def p_Declaration_Matriz(p):
    "Declaration : MATRIZ NOME PAA NUMBER PAF PAA NUMBER PAF"
    if p[2] not in p.parser.registers:
        p.parser.registers.update({p[2] : (p.parser.gp, int(p[4]), int(p[7]))})
        size = int(p[4])*int(p[7])
        p[0] = f'PUSHN {str(size)}\n'
        p.parser.gp += size
    else:
        print("Erro: Variável já existe.")
        parser.success = False

def p_Commad_Assign(p):
    "Command : Assign"
    p[0] = p[1]

def p_Assign_Int(p):
    "Assign : INT NOME EQUALS NUMBER "
    if p[2] not in p.parser.registers:
        p.parser.registers.update({p[2] : p.parser.gp})
        p[0] = f'PUSH {p[4]}\n'
        p.parser.ints.append(p[2])
        p.parser.gp += 1
    else:
        print("ERROR : A variavel já existe")
        parser.success = False


def p_Assign_Expression_Int(p):
    "Assign : NOME EQUALS Expression"
    if p[1] in p.parser.registers:
        if p[1] in p.parser.ints:
            p[0] = f'{p[3]}STOREG {p.parser.registers.get(p[1])}\n'
        else:
            print("Erro: Variável não é de tipo inteiro.")
            parser.success = False

    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Assign_Array(p):
    "Assign : NOME PAA Expression PAF EQUALS Expression"
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 2:
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}{p[6]}STOREN\n'
        else:
            print(f"Erro: Variável {p[1]} não é um array.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Assign_Matriz(p):
    "Assign : NOME PAA Expression PAF PAA Expression PAF EQUALS Expression"
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 3:
            c = p.parser.registers.get(p[1])[2]
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}PUSHI {c}\nMUL\n{p[6]}ADD\n{p[9]}STOREN\n'
        else:
            print(f"Erro: Variável {p[1]} não é uma matriz.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Assign_Ler(p):
    "Assign : NOME EQUALS LER"
    if p[1] in p.parser.registers:
        p[0] = f'READ\nATOI\nSTOREG {p.parser.registers.get(p[1])}\n'
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Assign_Ler_ARRAY(p):
    "Assign : NOME PAA Expression PAF EQUALS LER" 
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 2:
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}READ\nATOI\nSTOREN\n'
        else:
            print(f"Erro: Variável {p[1]} não é um array.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Assign_Ler_MATRIZ(p):
    "Assign : NOME PAA Expression PAF PAA Expression PAF EQUALS LER"
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 3:
            c = p.parser.registers.get(p[1])[2]
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}PUSHI {c}\nMUL\n{p[6]}ADD\nREAD\nATOI\nSTOREN\n'
        else:
            print(f"Erro: Variável {p[1]} não é uma matriz.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Commad_Write(p):
    "Command : Write"
    p[0] = p[1]

def p_Write(p):
    "Write : ESCREVER Expression"
    p[0] = f'{p[2]}WRITEI\nPUSHS "\\n"\nWRITES\n'

def p_Commad_Enq(p):
    "Command : Enq"
    p[0] = p[1]

def p_Enq(p):
    "Enq : ENQUANTO Condition FAZ Commands STOPCOM"
    p[0] = f'l{p.parser.labels}c: NOP\n{p[2]}JZ l.{p.parser.labels}f\n{p[4]}JUMP l{p.parser.labels}c\nl{p.parser.labels}f: NOP\n'
    p.parser.labels += 1

def p_Commad_Se(p):
    "Command : Se"
    p[0] = p[1]

def p_Se(p):
    "Se : SE Condition FAZ Commands STOPCOM"
    p[0] = f'{p[2]}JZ l.{p.parser.labels}\n{p[4]}l.{p.parser.labels}: NOP\n'
    p.parser.labels += 1

def p_Se_Senao(p):
    "Se : SE Condition FAZ Commands SENAO FAZ Commands STOPCOM"
    p[0] = f'{p[2]}JZ l.{p.parser.labels}\n{p[4]}JUMP l.{p.parser.labels}f\n NOP\n{p[7]}l{p.parser.labels}f: NOP\n'
    p.parser.labels += 1

#expressoes aritemetricas e condiçoes logicas
def p_Expression_Empty(p):
    "Expression : "
    p[0] = f''

def p_Expression_num(p):
    "Expression : NUMBER"
    p[0] = f'PUSHI {p[1]}\n'

def p_Expression_P(p):
    "Expression : PCA Expression PCF"
    p[0] = p[2]

def p_Expression_SOMA(p):
    "Expression : PLUS PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}ADD\n'

def p_Expression_DIF(p):
    "Expression : MINUS PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}SUB\n'

def p_Expression_MUL(p):
    "Expression : TIMES PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}MUL\n'

def p_Expression_DIV(p):
    "Expression : DIVIDE PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}DIV\n'

def p_Expression_Condition(p):
    "Expression : Condition"
    p[0] = p[1]

def p_Condition_P(p):
    "Condition : PCA Condition PCF"

def p_Condition_II(p):
    "Condition : EQEQ PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}EQUAL\n'

def p_Condition_D(p):
    "Condition : NEQ PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}ADD\nNOT\n'

def p_Condition_MaI(p):
    "Condition : GEQ PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}SUPEQ\n'

def p_Condition_MeI(p):
    "Condition : LEQ PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}INFEQ\n'

def p_Condition_B(p):
    "Condition : BIGGER PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}SUP\n'

def p_Condition_M(p):
    "Condition : MINOR PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}INF\n'

def p_Condition_E(p):
    "Condition : E PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}ADD\nPUSHI 2\nSUPEQ\n'

def p_Condition_OU(p):
    "Condition : OU PCA Expression VIRG Expression PCF"
    p[0] = f'{p[3]}{p[5]}ADD\nPUSHI 1\nSUPEQ\n'

def p_Expression_Var(p):
    "Expression : Var"
    p[0] = p[1]

def p_Var_nome(p):
    "Var : NOME"
    if p[1] in p.parser.registers:
        if p[1] in p.parser.ints:
            p[0] = f'PUSHG {p.parser.registers.get(p[1])}\n'
        else:
            print("Erro: Variável não é de tipo inteiro.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Var_ARRAY(p):
    "Var : NOME PAA Expression PAF"
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 2:
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}LOADN\n'
        else:
            print(f"Erro: Variável {p[1]} não é um array.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_Var_MATRIZ(p):
    "Var : NOME PAA Expression PAF PAA Expression PAF"
    if p[1] in p.parser.registers:
        if p[1] not in p.parser.ints and len(p.parser.registers.get(p[1])) == 3:
            c = p.parser.registers.get(p[1])[2]
            p[0] = f'PUSHGP\nPUSHI {p.parser.registers.get(p[1])[0]}\nPADD\n{p[3]}PUSHI {c}\nMUL\n{p[6]}ADD\nLOADN\n'
        else:
            print(f"Erro: Variável {p[1]} não é uma matriz.")
            parser.success = False
    else:
        print("Erro: Variável não definida.")
        parser.success = False

def p_error(p):
    print('Syntax error: ', p)
    parser.success = False

parser = yacc.yacc()

parser.success = True
parser.registers = {}
parser.labels = 0
parser.gp = 0
parser.ints = []
parser.assembly = ""


try:
    with open("testes/teste.txt",'r') as file:
        inp = file.read()
        parser.parse(inp)
        if parser.success:
            with open("testes/teste.vm", 'w') as output:
                output.write(parser.assembly)
                print("--------------------------------------")
                #print(f"Ficheiro  compilado com sucesso.\nOutput guardado em {sys.argv[2]}.")
                print("--------------------------------------")
                print(parser.assembly)
        else:
            print("--------------------------------------")
            print("Erro ao compilar.")
            print("--------------------------------------")
except KeyboardInterrupt:
    print()

'''
f = open("teste.txt", 'r')
for line in f:
    res = parser.parse(line)
'''