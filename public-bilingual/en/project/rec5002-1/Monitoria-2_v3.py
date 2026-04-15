# -*- coding: utf-8 -*-
"""
Monitoria 2 de Macroeconomia I (Parte 1) de 2021
27/04/2021 - author: Fábio Nishida

Baseado no curso "Introdução à Ciência da Computação com Python Parte 1"
de Fabio Kon (IME-USP) no Coursera (gratuitos para visualização)
https://www.coursera.org/learn/ciencia-computacao-python-conceitos


Caso tenha interesse, comunidade USP pode pegar o certificado sem pagar os cursos:
https://jornal.usp.br/universidade/nova-parceria-oferece-mais-cursos-on-line-a-comunidade-usp-na-plataforma-coursera/
"""


##############################################################################
""" LISTAS """
# também chamado de coleção de objetos, vetor, array

lista = [1, 2, 3, 4, 5]
lista
len(lista)  # Comprimento (length) da lista

lista[0]  # Numeração começa no zero!
lista[4]  # 5º elemento da lista


# para acrescentar um novo elemento, usa-se ".append"
lista2 = []  # Lista vazia
lista2.append("oi")
len(lista2)  # Contém 1 elemento
lista2[0]  # 1º elemento


# Dentro de uma lista, pode ter elementos de tipos distintos
filme = ["O que é isso companheiro?", "Bruno Barreto", 1.83, 1997]
type(filme) # list
type(filme[0])  # string
type(filme[1])  # string
type(filme[2])  # float
type(filme[3])  # integer


# É possível alterar os valores dos objetos
filme[3] = 2001
filme

# É pouco usual, mas é possível utilizar valores negativos para se referir aos
# objetos do final para o início
filme[-1] = 1997
filme


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/ArJZT/listas



##############################################################################
""" MANIPULAÇÃO DE LISTAS """
primos = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61]
len(primos)

primos[1:2]  # Note que traz um único elemento (é subtraído 1 do último nº)
primos[1:4]  # Traz 3 elementos (é subtraído 1 do último nº)

# Dividindo pela metade
primos[0:int(len(primos)/2)]  # Aqui int() transforma número float em integer
primos[int(len(primos)/2):len(primos)]

# números iniciais e finais não precisavam ser informados
primos[:int(len(primos)/2)]
primos[int(len(primos)/2):]


# Clonando listas - CUIDADO!
# Ao clonar objetos e depois alterar um objeto original, não altera valor do clonado
a = 3
b = a
a
b

a = 5
a
b


# Isto NÃO É VÁLIDO para LISTAS - objetos dentro lista continuam referenciados
lista1 = ["vermelho", "verde", "azul"]
lista2 = lista1
lista1
lista2

lista1[0] = "rosa"
lista1
lista2  # lista2 também mudou ao alterar apenas a lista1!

lista2[1] = "roxo"
lista1  # Se altero lista2, também altero lista1!
lista2 


# Clonar listas corretamente (objeto por objeto) criando uma nova função
def clone(lista):
    clone = []
    for objeto in lista:
        clone.append(objeto)
    return clone

lista1 = ["vermelho", "verde", "azul"]
lista2 = clone(lista1)
lista1
lista2

lista1[0] = "rosa"
lista1
lista2  # Manteve-se no formato original


# Há uma maneira mais simples que é indicando todos elementos da lista 1
lista1 = ["vermelho", "verde", "azul"]
lista2 = lista1[:]  # Indicando todos elementos da lista1
lista1
lista2

lista1[0] = "rosa"
lista1
lista2  # Manteve-se no formato original


# Pertencimento a uma lista
"rosa" in lista1
"rosa" in lista2


# Repetição de Listas
primos
primos * 2  # Não multiplica por 2 os valores, duplica o tamanho da lista

lista1
lista1 * 3


# Soma de listas
carnes1 = ["picanha", "alcatra"]
carnes2 = ["filé mignon", "cupim", "ponta de alcatra"]
carnes3 = carnes2 + carnes1


# Remoção de objetos em listas
lista1
del lista1[1]
lista1


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos/quiz/Uw2C6/manipulacao-de-listas



##############################################################################
""" IMPORTAÇÃO DE MÓDULOS / PACOTES """
# Importação do pacote "math"
import math
# https://docs.python.org/3/library/math.html

# Para usar uma função, é necessário escrever o nome do módulo antes da função
math.exp(1)
exp(9)  # Erro!


# Importação do pacote "numpy": pacote que mais utilizado na disciplina
# https://medium.com/ensina-ai/entendendo-a-biblioteca-numpy-4858fde63355
import numpy as np # pode dar um apelido para não ter que escrever o nome inteiro

A = np.array([1, 5, 7, 4])
print(A)  # Para visualizar matrizes/vetores é melhor usar o print()
numpy.array([1, 5]) # Erro!


# Importação de apenas uma função de um módulo, sem ter que escrever o módulo
from math import log as log
log(math.exp(1))



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
# pega o elemento da 2ª coluna de cada linha, transforma em lista e "soma" (listas)


# Criação de matriz vazia [na prática, usaremos uma função do NumPy]
def cria_matriz(num_linhas, num_colunas, valor):
    """ (int, int, valor) -> matriz (lista de listas)
    Cria e retorna uma matriz com num_linhas linhas e num_coluna colunas
    em que cada elemento é igual ao valor dado.
    """
    matriz = []
    for i in range(num_linhas):
        # cria linha i
        linha = [] # lista vazia
        for j in range(num_colunas):
            linha.append(valor)
        
        # adiciona linha à matriz
        matriz.append(linha)
    
    return matriz

cria_matriz(5, 8, 0)


# PRACTICE QUIZ: https://www.coursera.org/learn/ciencia-computacao-python-conceitos-2/quiz/QUA4k/matrizes


##############################################################################
""" BOAS PRÁTICAS DE PROGRAMAÇÃO EM PYTHON - PEP8 """
# https://www.coursera.org/learn/ciencia-computacao-python-conceitos/supplement/aUUua/pep8-uma-questao-de-estilo
# https://pep8.org/ (apertar Ctrl e clicar no link para acessar)

# Melhor já se acostumar a usar as boas práticas de programação enquanto está
# aprendendo a utilizar o Python.
