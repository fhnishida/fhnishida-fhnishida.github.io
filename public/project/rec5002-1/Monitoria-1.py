# -*- coding: utf-8 -*-
"""
Monitoria 1 de Macroeconomia I (Parte 1) de 2021
20/04/2021 - author: Fábio Nishida

Baseado nos cursos "Introdução à Ciência da Computação com Python Parte 1"
de Fabio Kon (IME-USP) no Coursera (gratuitos para visualização)
https://www.coursera.org/learn/ciencia-computacao-python-conceitos

Caso tenha interesse, comunidade USP pode pegar o certificado sem pagar o curso:
https://jornal.usp.br/universidade/nova-parceria-oferece-mais-cursos-on-line-a-comunidade-usp-na-plataforma-coursera/
"""


##############################################################################
""" OPERAÇÕES BÁSICAS """
# Soma e Subtração
1 + 1
2 - 3

# Multiplicação e Divisão
2 * 3
6 / 4

# Divisão Inteira e Resto da Divisão
6 // 4
6 % 4

# Potenciação
2 ** 3
8 ** (1 / 3)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/N1e0Z/tipos-de-dados



##############################################################################
""" ALGUNS ATALHOS NO SPYDER """
# Rodar única linha: Selecionar a linha (ou realçá-la inteira) + F9
2 + 1*3 - 4**2
# É possível rodar apenas parte do código, selecionando parte da linha
# Teste na linha de código acima, rodar apenas "2 + 1*3 - 4" (igual a 1)

# Rodar várias linhas: Realçar várias linhas + F9
2 ** 3
8 ** (1 / 3)



##############################################################################
""" COMENTÁRIOS NO CÓDIGO """
# Para incluir comentário no código, é possível fazê-lo por
#   • 3 aspas de cada lado: comentário fica destacado em verde
#       (Ao digitar 4 aspas seguidas, aparecerá 6 aspas e cursor fica no meio)
#   • Incluir # antes do código (ou Ctrl + 1): pode ser depois de um comando
2 ** 3 # 2 ao cubo

# IMPORTANTE: Sempre deixe comentários para lembrar posteriormente o que feito
# e, caso o código seja compartilhado, outros possam entender.



##############################################################################
""" ATRIBUIÇÕES A VARIÁVEIS / OBJETOS """
# Criando novas variáveis / objetos
x = 5
x
type(x)  # Objeto "x" é um integer (inteiro)

y = 10 / 3
y  # Usa-se o ponto como separador decimal
type(y)  # Objeto "y" é um float (um dos tipos de números reais)


# Alterando valores
x = 345
x

# É possível atribuir novo valor alterando o antigo
x = x + 20
x

# Também pode ser escrito como:
x += 20  # Pode-se usar outros operadores: "-", "*", "/", "**"
x


# Soma de variáveis (seus tipos precisam ser consistentes entre si)
soma = x + y
soma
type(soma)


# NESTE CASO, ao alterarmos o valor de "x" após criar "soma", não altera "soma"
x
x *= 2
x
soma

# Quando lidarmos com listas/matrizes e fizermos uma cópia, se alterarmos os
# elementos de uma lista, também alteraremos o valor da cópia (e vice-versa)
# Neste caso, precisaremos copiar de outra forma.


# Variáveis com textos
palavra = "Olá"  # Também pode ser com aspas simples: 'Olá'
palavra
type(palavra)  # Objeto é um string (texto)
len(palavra)  # Tamanho do string

# Concatenação de texto com números
print("A soma é", round(soma, 1))  # Já inclui espaçamento entre os argumentos
# round() foi usado para arredondar "soma" com 1 casa decimal



##############################################################################
""" EXPRESSÕES BOOLEANAS """
2 < 20
5 <= 4
10 > 5
19 >= 19

100 == 10**2
100 != 10*5
not 100 == 10*5

type(100 == 10**2)  # Objeto boolean tem 2 valores: TRUE ou FALSE (1 ou 0)

# Erro! O símbolo de "=" é uma forma de ATRIBUIÇÃO de valor a uma variável
10 = 10

# Objeto boolean pode ser aplicado a uma variável também
idade = 15
maioridade = 18
pode_dirigir = idade >= maioridade
pode_dirigir
type(pode_dirigir)


# Expressões Compostas
x = 200
x < 0 or x**2 > 100
x < 0 and x**2 > 100


not x < 0 and x**2 > 100  # "not" nega apenas a primeira expressão
not (x < 0 and x**2 > 100)  # "not" nega tudo em parêntesis

# Mesmo que redundante, colocar parêntesis pode ajudar na leitura do código
(not x < 0) and x**2 > 100


""" Tabela de Precedência de Operadores """
# Nível 7 - exponenciação: **
# Nível 6 - multiplicação: *, /, //, %
# Nível 5 - adição: +, -
# Nível 4 - relacional: ==, !=, <=, >=, >, <
# Nível 3 - lógico: not
# Nível 2 - lógico: and
# Nível 1 - lógico: or


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/40vwN/expressoes-booleanas



##############################################################################
""" EXECUÇÃO CONDICIONAL """
x = -1
if x < 0:
    print("número negativo")
# ATENÇÃO: comando decorrente do "if" deve ter algum indentação (tabulação)
# em relação ao comando de execução condicional. O padrão são 4 espaços a mais.
# Para rodar com a condicional, precisa realçar as 2 linhas antes de executar.


# Incluindo comando "else", caso a condição seja falsa
x = 1
if x < 0:
    print("número negativo")
else:
    print("zero ou número positivo")
# Note que o "else" é escrito sem indentação


# Incluindo mais possíveis condições
x = 0
if x < 0:
    print("número negativo")
elif x == 0:  # elseif
    print("zero")
else:
    print("número positivo")
    
# ou também, pode incluir mais uma condicional dentro (cuidado com indentação!)
x = 0
if x < 0:
    print("número negativo")
else:
    if x > 0:
        print("número positivo")
    else:
        print("zero")
        
        
# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/1cG2Z/execucao-condicional



##############################################################################
""" CRIAÇÃO DE FUNÇÕES """
# Útil para evitar repetições de grandes blocos de comandos no programa

# Função simples de soma de dois inputs
def soma(a, b):  # Exigindo 2 argumentos
    return a + b

soma(15, 46)
soma(5, 82)


# Função não necessariamente precisa ter algum input
def mensagem():
    return print("Olá")

mensagem()


# Exemplo de cálculo de temperatura
temperaturaFarenheit = 68 
temperaturaCelsius = (temperaturaFarenheit - 32) * 5 / 9
temperaturaCelsius

# Criação de uma função com o cálculo anterior, com um parâmetro
def Calcular_Temperatura_Celsius(tempFarenheit):
    
    return (tempFarenheit - 32) * 5 / 9

# tempFarenheit é uma variável "temporária" que só funcionada dentro da função
# e o seu valor vai ser inserido ao digitar o comando (ver abaixo).
# "return" é o comando para dizer qual é o ouput desta função (graus Celsius)

Calcular_Temperatura_Celsius(68)
Calcular_Temperatura_Celsius(86)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/exam/mJrGn/funcoes



##############################################################################
""" REPETIÇÃO / LOOP USANDO WHILE """
# Na repetição utilizando "while", precisamos criar uma variável (indicador de 
# passagem) antes que servirá para criarmos as expressões condicionais.

i = 0 # indicador de passagem
while i <= 10:
    print(2 ** i)
    i += 1  # Equivalente a i = i + 1
# ATENÇÃO: não se esqueça de acrescentar unidades em cada loop


# No exemplo abaixo, a condição sempre será verdadeira: nunca terminará o loop
i = 0
while i > -1:
    print(2 + i)
    i += 1  # Equivalente a i = i + 1
# Para PARAR O LOOP, clique no quadrado do lado esquerdo -->


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/moDKn/repeticao-com-while


# Exemplo 1: achar a temperatura em Farenheit equivalente a 35ºC
# (usar a função Calcular_Temperatura_Celsius criada dentro de um loop)
temperaturaFarenheit = 0
while Calcular_Temperatura_Celsius(temperaturaFarenheit) < 35:
    temperaturaFarenheit += 1
    
print(temperaturaFarenheit, "graus Farenheit é equivalente a",
      Calcular_Temperatura_Celsius(temperaturaFarenheit), "graus Celsius")


# Exemplo 2: suponha que a vacinação começará agora e a cada mês é possível
# Vacinar 10% das pessoas ainda não vacinadas, em quantos meses é possível
# Vacinar toda população?
perc_pop_nao_vacinada = 1
meses = 1

while perc_pop_nao_vacinada > 0:
    perc_pop_nao_vacinada *= 0.9  # Equivalente a perc_pop_nao_vacinada = perc_pop_nao_vacinada * 0.9
    meses += 1
print(meses)

# Note que o percentual se aproxima de zero, mas nunca será zero, então podemos
# estabelecer % da população que seria razoável considerar como "toda população"
# Digamos que esse percentual seja 99,9%
perc_pop_nao_vacinada = 1
meses = 1
tolerancia = 0.01

while perc_pop_nao_vacinada > tolerancia:
    perc_pop_nao_vacinada = perc_pop_nao_vacinada * 0.9
    meses += 1
print("São necessários", meses, "meses para vacinar toda população")
