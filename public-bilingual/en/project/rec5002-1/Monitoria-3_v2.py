# -*- coding: utf-8 -*-
"""
Monitoria 3 de Macroeconomia I (Parte 1) de 2021
04/05/2021 - author: Fábio Nishida

Baseado no curso "Introdução à Ciência da Computação com Python Parte 2"
de Fabio Kon (IME-USP) no Coursera (gratuitos para visualização)
https://www.coursera.org/learn/ciencia-computacao-python-conceitos-2

Caso tenha interesse, comunidade USP pode pegar o certificado sem pagar os cursos:
https://jornal.usp.br/universidade/nova-parceria-oferece-mais-cursos-on-line-a-comunidade-usp-na-plataforma-coursera/
"""

# Carregamento do NumPy
import numpy as np  # NumPy com o "apelido" np


##############################################################################
""" MATRIZES (LISTA DE LISTAS) """

A = [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]  # Note que estamos criando listas dentro de uma lista
A

# Formas de "chamar" parte da matriz
A[0][0]  # 1ª linha e 1ª coluna
A[2][2]  # 3ª linha e 3ª coluna

A[0]  # 1ª linha da matriz
A[0][:]  # 1ª linha da matriz

[A[0][1]] + [A[1][1]] + [A[2][1]]  # 2ª coluna da matriz
# pega o 2ª elemento de cada linha, transforma em lista e "soma" (listas)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos-2/quiz/QUA4k/matrizes


# Uma outra forma de criar matriz é por meio do módulo NumPy
# Utiliza as listas no formato "array", que é mais eficiente e facilita operações
# https://www.geeksforgeeks.org/python-lists-vs-numpy-arrays/

# Para criar uma matriz no formato array usa-se a função "array" do NumPy
A = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]) 
A
print(A)  # Matriz em array é melhor visualizada usando print()
type(A)

# A sintaxe do array é diferente: apenas [,] (ao invés de [][])
A[0, 0]  # 1ª linha e 1ª coluna
A[2, 2]  # 3ª linha e 3ª coluna

A[0]  # 1ª linha da matriz
A[0, :]  # 1ª linha da matriz

A[:, 1]  # 2ª coluna da matriz


# Para criar uma matriz "vazia" (com zeros), usa-se a função zeros() do NumPy
B = np.zeros((5, 8))
print(B)
type(B)


# Para saber as dimensões de uma matrix usamos a função len()
len(B)  # Número de linhas de B
len(B[0])  # Número de elementos na 1ª linha de B (ou seja, número de colunas)


# Usando Módulo NumPy
# usando matriz (lista de listas) padrão
matriz_lista = [[1, 2, 3],
                [2, 3, 1]]
matriz_lista * 2  # Dobra a quantidade de objetos
matriz_lista + 2  # Erro

# usando matriz convertida para formato array
matriz_array = np.array(matriz_lista)
type(matriz_array)

matriz_array * 2  # Multiplica cada elemento por 2
matriz_array + 2  # Adiciona 2 a cada elemento
matriz_array + matriz_array  # Soma elemento a elemento

# Também posso fazer cálculos entre colunas (comum quando trabalha com bases)
(matriz_array[:, 1] + matriz_array[:, 1]**2) / 2

# Criar sequência de números usando linspace do NumPy
sequencia = np.linspace(0, 1, 10)
type(sequencia)

# Criar números aleatórios usando do NumPy
aleatorio = np.random.uniform(0, 1, size = 10)
type(aleatorio)

np.random.normal(0, 1, size = 10)



##############################################################################
""" REPETIÇÃO / LOOP USANDO FOR """
# Na repetição utilizando "for", criamos/atualizamos uma variável que percorre
# todos os elementos/objetos de uma lista.

# Repetição usando "for"
for i in [1, "oi", 7, 99.2]:
    print(i)

i  # Note que i se mantém no último valor após acabar o loop


# Criação de uma lista com sequência de números
help(range)  # Para visualizar ajuda do comando: range(start, stop[, step])
# Se preencher apenas um argumento de range(), começa no 0 e termina no nº - 1
# Se step for omitido, é igual a 1 (só pode ser um integer)

# função RANGE é importante para criar uma lista com números em sequência
for i in range(0, 10):
    print(i)
# Note que vai de 0 até 9 (ao invés de 10)


# Loop equivalente ao anterior, mas fazendo apenas 1 input
for i in range(10):
    print(i)
# Python adota como padrão o zero para iniciar as numerações


# Sequência de 2 em 2
for i in range(0, 10, 2):
    print(i)
# Note que não imprime o "último valor" (10)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/vPfhP/repeticao-com-for



##############################################################################
""" REPETIÇÕES ENCAIXADAS """
# Faremos um loop dentro de outro loop
# Preenchimento de uma matriz com a tabuada
i = 0
j = 0
while i <= 10:
    j = 0  # Precisa "resetar" a variável para o próximo loop de row
    while j <= 10:
        print(i, "-", j)
        j += 1  # Equivalente a j = j + 1
    i += 1  # Equivalente a i = i + 1 | Atenção à identação (no loop de i)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/QjXxx/repeticoes-encaixadas


# Exemplo de preenchimento de matrizes - Tabela da Tabuada
# Criação de uma matriz "vazia" (com zeros)
nrow = 9  # Número de Linhas
ncol = 10  # Número de Colunas
matrix = np.zeros((nrow, ncol))
print(matrix)

# Loops para preenchimento da matriz vazia usando FOR
for row in range(len(matrix)):
    for col in range(len(matrix[0])):
        matrix[row, col] = (row + 1) * (col + 1)
        
print(matrix)


# Preenchimento da matriz usando WHILE (mesma dimensão definida acima)
matrix_while = np.zeros((nrow, ncol))
print(matrix_while)

# Loops para preenchimento da matriz vazia
row = 0
col = 0
while row < nrow:
    col = 0  # Preciso "resetar" a variável para o próximo loop de row
    while col < ncol:
        matrix_while[row, col] = (row + 1) * (col + 1)
        col += 1  # Equivalente a col = col + 1
    row += 1  # Equivalente a row = row + 1 | Atenção à identação (no loop de row)
    
print(matrix_while)


# Comparando ambas matrizes
matrix_while == matrix  # Comparando cada elemento das matrizes
matrix_while.all() == matrix.all()  # Comparando as matrizes como um todo


# Lista 1 - Exercício 1, item (f) #
# É fácil ver que as sequências de consumo de equilíbrio são monótonas.
# Escreva um código que encontre o período $t^*(\beta_1, \beta_2)$ para o qual
# $\hat{c}^1_t - \hat{c}^2_t$ troca de sinal para $\beta$'s genéricos.
# Fixe $\beta_2 = 0.95$ e faça um gráfico para mostrar $t^*(\beta_1, \beta_2)$.

beta_2 = 0.95  # valor de beta_2 fixado

# Criando e preenchendo matriz com beta_1 e t*
tabela = np.zeros([18, 2])  # criando matriz de zeros 18 x 2 para preenchimento


# Loop para preenchimento de possíveis \beta_1 < \beta_2 e t* para c1_t - c2_t
# mudar de sinal (quando c2_t > 1, pois c2_t = 2 - c1_t, no equilíbrio)
for i in range(len(tabela)):
    tabela[i, 0] = beta_2 - (i + 1) * 0.05
    
    # Estabelecendo valores iniciais
    t = 0
    c2_t = -np.inf  # valor arbitrário apenas para ser TRUE ao entrar no loop
    
    while c2_t < 1:
        # Como c1_t + c2_t = 2, só precisamos verificar se c2_t > 1 ou c1_t < 1
        c2_t = 2 / (1 + ((1 - tabela[i, 0]) / (1 - beta_2)) * (tabela[i, 0] / beta_2)**t)
        t += 1
    tabela[i, 1] = t

print(tabela)

# Poderia ter usado linspace() do NumPy para preencher a 1ª coluna de uma vez
exemplo = np.zeros((18, 2))
exemplo[:, 0] = np.linspace(0.05, 0.90, 18)
exemplo



##############################################################################
""" GRÁFICOS """

# Importação do módulo para fazer gráfico
import matplotlib.pyplot as plt  # Módulo para fazer gráficos
# https://matplotlib.org/2.0.2/users/pyplot_tutorial.html

# Criação do gráfico do Exercício 1 item (f) [Lista 1]
fig, ax = plt.subplots()  # Cria a base (em branco) do gráfico
ax.plot(tabela[:, 0], tabela[:, 1],  # Coluna 0 no eixo x e coluna 1 no y
        '-o',  # Formato da linha e ponto do gráfico
        label='$t^*(\\beta_1, \\beta_2)$')  # Descrição da legenda
ax.legend()  # Faz aparecer a legenda
ax.set_ylim([0, 15])  # tamanho mínimo e máximo vertical
ax.set_xlim([0.00, 0.95])  # tamanho mínimo e máximo horizontal
ax.set_xlabel('$\\beta_1$')  # Descrição do eixo x
ax.set_ylabel('$t^*(\\beta_1, \\beta_2)$')  # Descrição do eixo y
ax.set_title('Gráfico de $t^*(\\beta_1, \\beta_2)$ por $\\beta_1$')  # Título
plt.show()  # Plot do gráfico com os comandos dados


# Exemplo 2 - Gráfico da função exponencial $y = 2^x$ e $y = 3^x$
tabela_exp = np.zeros([7, 3])  # Uma coluna para x e 2 colunas para y

# Vamos preencher a matriz
for i in range(len(tabela_exp)):
    tabela_exp[i, 0] = i - 3  # Preenchendo a coluna de x (de -3 a 3)
    tabela_exp[i, 1] = 2 ** tabela_exp[i, 0]  # cálculo de $y = 2^x$
    tabela_exp[i, 2] = 3 ** tabela_exp[i, 0]  # cálculo de $y = 3^x$

print(tabela_exp)

# Criação do gráfico
fig, ax = plt.subplots()  # Cria a base (em branco) do gráfico
ax.plot(tabela_exp[:, 0], tabela_exp[:, 1],  # Plot $y = 2^x$
        '-o',  # Formato da linha e ponto do gráfico
        label='$y = 2^x$')  # Descrição da legenda
ax.plot(tabela_exp[:, 0], tabela_exp[:, 2],  # Plot $y = 3^x$
        '-x',  # Formato da linha e ponto do gráfico
        label='$y = 3^x$')  # Descrição da legenda
ax.legend()  # Faz aparecer a legenda
# ax.set_ylim([0, 1])  # tamanho mínimo e máximo vertical (corte núm. neg.)
# ax.set_xlim([-4, 0])  # tamanho mínimo e máximo horizontal (corte núm. neg.)
ax.set_xlabel('$x$')  # Descrição do eixo x
ax.set_ylabel('$y$')  # Descrição do eixo y
ax.set_title('Gráfico de $y = 2^x$ e de $y = 3^x$')  # Título
plt.show()  # Plot do gráfico com os comandos dados



##############################################################################
""" ALGORITMOS RECURSIVOS """

# Fatorial
def fatorial(n):
    if n < 1:  # Base da recursão (caso trivial)
        return 1
    else:
        return n * fatorial(n-1)  # Chamada recursiva

fatorial(1)
fatorial(5)


# Fibonacci
def fibonacci(n):
    if n < 2:  # Base da recursão (caso trivial)
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)  # Chamada recursiva

fibonacci(0)
fibonacci(1)
fibonacci(4)


# Note que o uso de função para solucionar essas recursões pode não ser o mais
# eficiente, pois cada vez que a função é "chamada" parte-se do caso base para
# fazer o cálculo do n desejado. Durante o curso, vamos resolver por loops.


# Exemplo: Calcular o primeiro valor n cujo fibonacci ultrapassa 15 milhões
# Via função (~ 18 segundos de execução)
n = 1
while fibonacci(n) < 15_000_000:  # Cada loop calcula desde a base da recursão
    n += 1

print(n)


# Via loop (instantâneo)
n = 2  # Estabelecendo a base da recursão
fibonacci_n_1 = 1
fibonacci_n_2 = 1

while fibonacci_n_1 + fibonacci_n_2 < 15_000_000:  # Usa cálculos anteriores
    auxiliar = fibonacci_n_2
    fibonacci_n_2 = fibonacci_n_1
    fibonacci_n_1 = fibonacci_n_1 + auxiliar
    n += 1

print(n)



##############################################################################
""" BOAS PRÁTICAS DE PROGRAMAÇÃO EM PYTHON - PEP8 """
# https://www.coursera.org/learn/ciencia-computacao-python-conceitos/supplement/aUUua/pep8-uma-questao-de-estilo
# https://www.python.org/dev/peps/pep-0008/ (apertar Ctrl e clicar no link para acessar)

# Melhor já se acostumar a usar as boas práticas de programação enquanto está
# aprendendo a utilizar o Python.
