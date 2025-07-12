# -*- coding: utf-8 -*-
"""
Monitoria 4 de Macroeconomia I (Parte 1) de 2021
11/05/2021 - author: Fábio Nishida

Baseado nas notas de aula do prof. Jefferson Bertolai (2020) e códigos de
monitoria de Bruno Caleman (2020)
"""

# Importando os módulos necessários
import numpy as np  # NumPy com o "apelido" np
from math import log as log  # Apenas função log do módulo math


# Fazendo as suposições iniciais 
k_grid = np.array([0.04, 0.08, 0.12, 0.16, 0.20])  # Possíveis valores de k e k'
beta = 0.6
alpha = 0.3

n_k = len(k_grid)  # Tamanho do vetor de valores de k e k'

# Construir função valor v0 com mesmo tamanho de k_grid e valores 0
v0 = np.zeros(n_k)
print('v0 =', v0)


##############################################################################
""" 1ª Iteração [Slides 4 e 5]  """

v1 = np.zeros(n_k)  # Criando vetor "vazio" de zeros
print('v1 = ', v1)

# Calculando v1 para cada k e com k' = 0.04 (maximiza o valor) [Slide 4 e 5]
v1[0] = log(0.04**alpha - 0.04) + beta*0  # k = 0.04 e k' = 0.04
v1[1] = log(0.08**alpha - 0.04) + beta*0  # k = 0.08 e k' = 0.04  
v1[2] = log(0.12**alpha - 0.04) + beta*0  # k = 0.12 e k' = 0.04
v1[3] = log(0.16**alpha - 0.04) + beta*0  # k = 0.16 e k' = 0.04
v1[4] = log(0.20**alpha - 0.04) + beta*0  # k = 0.20 e k' = 0.04
print('v1 =', v1)

norm = max(abs(v1 - v0)) # Maior distância entre as funções v0 e v1
print(norm)


# Tornando o código mais geral (ao invés de escrever os valores na mão)
# O índice de 0.04 é o 0, seguido pelo 0.08 que é o 1, e assim por diante.
v1[0] = log(k_grid[0]**alpha - k_grid[0]) + beta*v0[0]  # k = k_grid[0] e k' = k_grid[0]
v1[1] = log(k_grid[1]**alpha - k_grid[0]) + beta*v0[0]  # k = k_grid[1] e k' = k_grid[0]  
v1[2] = log(k_grid[2]**alpha - k_grid[0]) + beta*v0[0]  # k = k_grid[2] e k' = k_grid[0]
v1[3] = log(k_grid[3]**alpha - k_grid[0]) + beta*v0[0]  # k = k_grid[3] e k' = k_grid[0]
v1[4] = log(k_grid[4]**alpha - k_grid[0]) + beta*v0[0]  # k = k_grid[4] e k' = k_grid[0]
print('v1 =', v1)


##############################################################################
""" 2ª Iteração [Slides 6 e 7] """

v2 = np.zeros(n_k)  # Criando vetor "vazio" de zeros
print('v2 =', v2)

f_obj = np.zeros((n_k, n_k))  # Matriz 5x5 "vazia" de zeros
print('Função Objetivo = \n', f_obj)

# Construção da função objetivo na 1ª linha
# [Linha 0 de f_obj] Fixamos k = 0.04 (capital de hoje) e variamos k' (ou k-prime)
f_obj[0,0] = log(k_grid[0]**alpha - k_grid[0]) + beta*v1[0]  # k' = k_grid[0]
f_obj[0,1] = log(k_grid[0]**alpha - k_grid[1]) + beta*v1[1]  # k' = k_grid[1]
f_obj[0,2] = log(k_grid[0]**alpha - k_grid[2]) + beta*v1[2]  # k' = k_grid[2]
f_obj[0,3] = log(k_grid[0]**alpha - k_grid[3]) + beta*v1[3]  # k' = k_grid[3]
f_obj[0,4] = log(k_grid[0]**alpha - k_grid[4]) + beta*v1[4]  # k' = k_grid[4]

# [Linha 1 de f_obj] Fixamos k = 0.08 (capital de hoje) e variamos k' (ou k-prime)
f_obj[1,0] = log(k_grid[1]**alpha - k_grid[0]) + beta*v1[0]  # k' = k_grid[0]
f_obj[1,1] = log(k_grid[1]**alpha - k_grid[1]) + beta*v1[1]  # k' = k_grid[1]
f_obj[1,2] = log(k_grid[1]**alpha - k_grid[2]) + beta*v1[2]  # k' = k_grid[2]
f_obj[1,3] = log(k_grid[1]**alpha - k_grid[3]) + beta*v1[3]  # k' = k_grid[3]
f_obj[1,4] = log(k_grid[1]**alpha - k_grid[4]) + beta*v1[4]  # k' = k_grid[4]

# [Linha 2 de f_obj] Fixamos k = 0.12 (capital de hoje) e variamos k' (ou k-prime)
f_obj[2,0] = log(k_grid[2]**alpha - k_grid[0]) + beta*v1[0]  # k' = k_grid[0]
f_obj[2,1] = log(k_grid[2]**alpha - k_grid[1]) + beta*v1[1]  # k' = k_grid[1]
f_obj[2,2] = log(k_grid[2]**alpha - k_grid[2]) + beta*v1[2]  # k' = k_grid[2]
f_obj[2,3] = log(k_grid[2]**alpha - k_grid[3]) + beta*v1[3]  # k' = k_grid[3]
f_obj[2,4] = log(k_grid[2]**alpha - k_grid[4]) + beta*v1[4]  # k' = k_grid[4]

# [Linha 3 de f_obj] Fixamos k = 0.16 (capital de hoje) e variamos k' (ou k-prime)
f_obj[3,0] = log(k_grid[3]**alpha - k_grid[0]) + beta*v1[0]  # k' = k_grid[0]
f_obj[3,1] = log(k_grid[3]**alpha - k_grid[1]) + beta*v1[1]  # k' = k_grid[1]
f_obj[3,2] = log(k_grid[3]**alpha - k_grid[2]) + beta*v1[2]  # k' = k_grid[2]
f_obj[3,3] = log(k_grid[3]**alpha - k_grid[3]) + beta*v1[3]  # k' = k_grid[3]
f_obj[3,4] = log(k_grid[3]**alpha - k_grid[4]) + beta*v1[4]  # k' = k_grid[4]

# [Linha 4 de f_obj] Fixamos k = 0.16 (capital de hoje) e variamos k' (ou k-prime)
f_obj[4,0] = log(k_grid[4]**alpha - k_grid[0]) + beta*v1[0]  # k' = k_grid[0]
f_obj[4,1] = log(k_grid[4]**alpha - k_grid[1]) + beta*v1[1]  # k' = k_grid[1]
f_obj[4,2] = log(k_grid[4]**alpha - k_grid[2]) + beta*v1[2]  # k' = k_grid[2]
f_obj[4,3] = log(k_grid[4]**alpha - k_grid[3]) + beta*v1[3]  # k' = k_grid[3]
f_obj[4,4] = log(k_grid[4]**alpha - k_grid[4]) + beta*v1[4]  # k' = k_grid[4]


# Agora, maximizamos para cada k (maximizamos cada linha de f_obj)
# Preenchemos o vetor "vazio" v2 com os máximos
v2[0] = max(f_obj[0,:])
v2[1] = max(f_obj[1,:])
v2[2] = max(f_obj[2,:])
v2[3] = max(f_obj[3,:])
v2[4] = max(f_obj[4,:])

print('v2 =', v2)
norm = max(abs(v2 - v1))  # Maior distância entre as funções v1 e v2
print(norm)



##############################################################################
""" 3ª Iteração [via Repetições Encaixadas] """
# Adaptaremos o código acima e preencheremos a função objetivo por loops

v3 = np.zeros((n_k))
f_obj = np.zeros((n_k, n_k))
print('Função objetivo = \n', f_obj)

# Loop de i (linha - k) com loop de j (coluna - k') dentro
for i in range(n_k):  # Loop de k (i é índice de k)
    for j in range(n_k):  # Loop de k' (j é índice de j)
    	f_obj[i,j] = log(k_grid[i]**alpha - k_grid[j]) + beta*v2[j]    	
    v3[i] = max(f_obj[i,:])  # Pegando o maior valor da linha

print('Função Objetivo = \n', f_obj)
print('v3 =', v3)
norm = max(abs(v3 - v2))  # Maior distância entre as funções v1 e v2
print(norm)



##############################################################################
""" 4ª a 10ª Iterações [via lista de arrays] """

# Criando lista de arrays com funções valor já calculadas
vn = [v0, v1, v2, v3]
print(vn)
type(vn)
type(vn[1])
type(vn[1][0])


# Loop das iterações 4 a 10 com o código feito na 3ª iteração
for n in range(4, 11): 
    # criando função valor genérica para preencher em cada iteração
    Tv = np.zeros(n_k)
    
    for i in range(n_k):  # Loop de k (i é índice de k)
        for j in range(n_k):  # Loop de k (i é índice de k)
        	f_obj[i,j] = log(k_grid[i]**alpha - k_grid[j]) + beta*vn[n-1][j]
        Tv[i] = max(f_obj[i,:])  # Pegando o maior valor da linha
    
    # Quando terminar loop das linhas, jogar função valor em vn
    vn.append(Tv)
    norm = max(abs(vn[n] - vn[n-1]))
    print(norm)

print(vn)
len(vn)



##############################################################################
""" Cálculo da função valor real via "Guess and Verify" [para gráfico] """

A = (1/(1-beta)) * (alpha*beta/(1 - alpha*beta)*log(alpha*beta) + log(1 - alpha*beta))
B = alpha / (1 - alpha*beta)
v = np.zeros(n_k)
for i in range(n_k):
	v[i] = A + B*log(k_grid[i])



##############################################################################
""" Visualização da convergência da função valor [Slide 8] """

import matplotlib.pyplot as plt  # Módulo para fazer gráficos
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, vn[0], label='$v_0$')
ax.plot(k_grid, vn[1], label='$v_1$')
ax.plot(k_grid, vn[2], label='$v_2$')
ax.plot(k_grid, vn[3], label='$v_3$')
ax.plot(k_grid, vn[4], label='$v_4$')
ax.plot(k_grid, vn[5], label='$v_5$')
ax.plot(k_grid, vn[6], label='$v_6$')
ax.plot(k_grid, vn[7], label='$v_7$')
ax.plot(k_grid, vn[8], label='$v_8$')
ax.plot(k_grid, vn[9], label='$v_9$')
ax.plot(k_grid, vn[10], label='$v_{10}$')
ax.plot(k_grid, v, label='$v_{real}$')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Valor')
ax.set_title('Convergência da Função Valor')
ax.legend()

plt.show()

# Funções valor estão ficando cada vez mais negativas e a distância entre elas
# vai diminuindo e convergindo. 
# Usando cifrão ($) para código parecido com LaTeX



##############################################################################
""" Iterações até uma determinada distância entre funções valor """
# Incluiremos uma verificação para k' \in [0, f(k)] e criaremos uma função
# para retornar valor máximo e seu índice dentro do array


# Estabelecendo os parâmetros
k_grid = np.array([0.04, 0.08, 0.12, 0.16, 0.20])  # Possíveis valores de k e k'
# k_grid = np.linspace(0.001, 0.5, 201)
beta = 0.6
alpha = 0.3

n_k = len(k_grid)

# Criando lista de arrays de função valor e função política
v0 = np.zeros(n_k)
vn = [v0]
print(vn)

g0 = np.zeros(n_k)  # Não exite g0, é apenas para ocupar a posição 0
gn = [g0]
print(gn)


# Loop das iterações enquanto (while) é menor do que dada distância
tol_norma = 1e-5  # Tolerância de distância entre funções valor (0.00001)
norma = np.inf  # Valor inicial da norma = infinito
n = 0  # Contador de iterações

while norma > tol_norma: 
    # Aplicar a cada iteração Operador de Bellman em objetos genéricos Tv e Tg
    Tv = np.zeros(n_k)
    Tg = np.zeros(n_k)
    f_obj = np.zeros((n_k, n_k))
    n += 1
    
    for i in range(n_k):  # Loop de k (i é índice de k)
        for j in range(n_k):  # Loop de k (i é índice de k)
            if k_grid[j] >= 0 and k_grid[j] <= k_grid[i]**alpha:
                f_obj[i,j] = log(k_grid[i]**alpha - k_grid[j]) + beta*vn[n-1][j]
            else:
                f_obj[i,j] = - np.inf
        Tv[i] = np.max(f_obj[i,:])
        Tg[i] = np.argmax(f_obj[i,:])
        
    # Quando acabar loop de linha, jogar função valor em vn e política em gn
    vn.append(Tv)
    gn.append(Tg)
    norma = max(abs(vn[n] - vn[n-1]))

np.round(vn, 2)  # Convergência da função valor
gn  # Convergência da funçao política (desconsiderar o primeira)
n  # Número de iterações realizadas
norma  # norma da última com a penúltima iteração


# Trocando índice em gn por valores de k'
for funcao in gn:
    for i in range(len(funcao)):
        funcao[i] = k_grid[int(funcao[i])]

gn[n]  # Função política da última iteração com valores de k'


# Visualização gráfica da convergência da função valor [Slide 8] 
import matplotlib.pyplot as plt  # Módulo para fazer gráficos
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, vn[0], label='$v_0$')
ax.plot(k_grid, vn[1], label='$v_1$')
ax.plot(k_grid, vn[2], label='$v_2$')
ax.plot(k_grid, vn[4], label='$v_4$')
ax.plot(k_grid, vn[6], label='$v_6$')
ax.plot(k_grid, vn[8], label='$v_8$')
ax.plot(k_grid, vn[10], label='$v_{10}$')
ax.plot(k_grid, vn[15], label='$v_{15}$')
ax.plot(k_grid, vn[n], label='$v_{convergido}$')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Valor')
ax.set_title('Convergência da Função Valor')
ax.legend()

plt.show()


# Visualização gráfica da convergência da função política [Slide 9] 
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, gn[1], label='$g_1$')
ax.plot(k_grid, gn[2], label='$g_2$')
ax.plot(k_grid, gn[3], label='$g_5$')
ax.plot(k_grid, gn[10], label='$g_{10}$')
ax.plot(k_grid, gn[n], label='$g_{convergido}$')
ax.plot(k_grid, k_grid, '--', label='45 graus')

# Limites do gráfico
# ax.set_ylim([0, 0.15])  # tamanho mínimo e máximo vertical
# ax.set_xlim([0, 0.15])  # tamanho mínimo e máximo horizontal

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Política')
ax.set_title('Convergência da Função Política')
ax.legend()

plt.show()


# k estacionário teórico (apenas para comparação)
(alpha * beta) ** (1 / (1 - alpha))

# Encontrar numericamente o capital estacionário k* [Slide 10]
p = int(np.round(np.random.uniform(0, n_k - 1, size = 1), 0))  # aleatório
print("Índice inicial do capital (randomizado):", p)  # Índice randomizado

t = 0  # Contagem de períodos
while k_grid[p] != gn[n][p]:  # até termos k = k'
    p = np.where(k_grid == gn[n][p])[0][0]  # Aplica o índice de k' em k
    t += 1
print("Índice do capital estacionário:", p)  # Índice do capital estacionário
print("Capital estacionário k* =", np.round(k_grid[p], 4))
print("Foram necessários", t, "períodos para atingir o estado estacionário.")



# Calcular o consumo c = f(k) - k'
cn = k_grid**alpha - gn[n]

# Visualização gráfica da função política de consumo
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, cn, label='$c_{convergido}$')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Política de Consumo')
ax.set_title('Função Política de Consumo dado Capital')
ax.legend()

plt.show()
