# -*- coding: utf-8 -*-
"""
Monitoria 6 de Macroeconomia I (Parte 1) de 2021: Modelo com Incerteza
25/05/2021 - author: Fábio Nishida

Baseado nas notas de aula do prof. Jefferson Bertolai (2020)
"""

# Importação de módulo necessários
import numpy as np
from math import log as log
import matplotlib.pyplot as plt


""" Função enumerate() do NumPy: "junção de vetor de valores e range(len(vetor))" para loop """
k_grid = np.array([0.04, 0.08, 0.12, .16, .2])

# Loop dos valores dentro de uma lista/vetor
for valor in k_grid:
    print(valor)

# Loop com os índices - range(len(vetor))
for indice in range(len(k_grid)):
    print(indice, "-", k_grid[indice])

# Loop com os valores e índices - via enumerate(vetor)
for indice_valor in enumerate(k_grid):  # Criar 2 variáveis (índice, valor)
    print(indice_valor)

# Podemos dar um nome a cada uma das variáveis do enumerate()
for indice, valor in enumerate(k_grid):  # Criar 2 variáveis (índice, valor)
    print(indice, "-", valor)


""" Função dot() do NumPy: Produto de Vetores/Matrizes """
A = np.array([1, 2, 3])
B = np.array([4, 5, 6])
np.dot(A, B)  # 1º vetor é considerado linha e o 2º é considerado coluna

C = np.array([[0, 1, 2],
              [3, 4, 5],
              [6, 7, 8]])
np.dot(A, C)
np.dot(A, C[1,:])

# Para transpor uma matriz, podemos usar a função transpose() do NumPy
np.dot(A, np.transpose(C))


""" Trabalhando com diversas matrizes """
n_k = 5
n_kk = 5
n_z = 3

D = np.zeros((n_k, n_kk, n_z))  # Cria 5 matrizes 

# Preenchendo a matriz - cada elemento corresponde à junção de p, q, r
for p in range(n_k):
    for q in range(n_kk):
        for r in range(n_z):
            D[p, q, r] = 100*p + 10*q + r

D[0]  # 1ª matriz
D[:, 1, :]  # 2ª linha inteira de cada uma das 5 matrizes
D[:, :, 2]  # 3ª coluna de cada uma das 5 matrizes
D[4, :, 1]  # Toda 2ª coluna da 5ª matriz



##############################################################################
""" Modelo de Crescimento Neoclássico com Incerteza 

Diferente do modelo da Monitoria 4:
 • Usando "it" para nº de iterações (ao invés de "n")
 • Usando "v_it" para lista de funções valor calculadas (ao invés de "vn")
 • Usando "gk_it" para lista de funções política (de capital) calculadas (ao invés de "vn")
 • Usando "gk" p/ cálculo da função política (de capital) em cada iteração (ao invés de "Tg")
"""

# Definição dos parâmetros
k_grid = np.array([0.04, 0.08, 0.12, .16, .2])
# k_grid = np.linspace(0.0001, 0.3, 101)
n_k = len(k_grid)
alpha = 0.3
beta = 0.6
delta = 0.3

# Novos parâmetros
z_grid = np.array([-1/5, 0, 1/5])  # grid de estados/choques de produtividade
n_z = len(z_grid)  # nº de estados
pi = np.array([[3/5, 2/5, 0/5],
               [1/5, 3/5, 1/5],
               [0/5, 2/5, 3/5]])


# Criando lista para incluir funções valor e política para cada iteração
# Note que, diferente do modelo sem incerteza, teremos uma função para cada z
v_it = [np.zeros((n_k, n_z))]  # Lista de função valor com v_0(k) = 0
gk_it = [np.zeros((n_k, n_z))]  # Lista de função política com g_0(k) = 0 (apenas para usar índice 0)


# Estabelecendo variáveis para realizar os loops
tol_norma = 1e-5  # Distância entre funções máxima para considerar convergência
norma = np.inf  # Valor apenas para entrar no loop
it = 0  # Nº iterações (antes utilizamos n - agora usado para trabalho)


while norma > tol_norma:
    it += 1  # Atualizando o número da iteração
        
    # Criando objetos para preencher com funções objetivo, valor e política
    f_obj = np.zeros((n_k, n_k, n_z))  # Lista com n_k matrizes n_k x n_z
    Tv = np.zeros((n_k, n_z))
    gk = np.zeros((n_k, n_z))
    
    for i_z, z in enumerate(z_grid):
        for i_k, k in enumerate(k_grid):
            for i_kk, kk in enumerate(k_grid):
                
                # Ao invés de verificar kk < np.exp(z)*(k**alpha) +(1-delta)*k,
                # calculamos c e verificamos se c > 0
                c = np.exp(z)*(k**alpha) +(1-delta)*k - kk
                if c > 0:
                    # Cálculo do valor esperado dados k e z (somatório)
                    Ev = np.dot(pi[i_z,:], v_it[it - 1][i_kk,:])                    
                    f_obj[i_k, i_kk, i_z] = log(c) + beta*Ev
                else:
                    f_obj[i_k, i_kk, i_z] = -np.inf
            
            # Maximizando uma coluna de uma matriz, dado z e k
            # (após preencher uma coluna inteira)
            Tv[i_k,i_z] = np.max(f_obj[i_k,:,i_z])
            gk[i_k,i_z] = np.argmax(f_obj[i_k,:,i_z])
                        
    # Trocando índices de gk por valores de k em k_grid
    # (após preencher gk inteiro)
    for p in range(len(gk)):
        for q in range(len(gk[0])):
            gk[p, q] = k_grid[int(gk[p, q])]        
    
    v_it.append(Tv)
    gk_it.append(gk)

    norma = np.max(abs(v_it[it] - v_it[it - 1]))
    print('A iteração {} terminou com norma igual a {:.5f}'.format(it,norma))


""" Visualização Gráfica das Funções Políticas """
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, gk_it[it][:,0], label='$g_{converg} (z = -1/5)$')
ax.plot(k_grid, gk_it[it][:,1], label='$g_{converg} (z = 0)$')
ax.plot(k_grid, gk_it[it][:,2], label='$g_{converg} (z = 1/5)$')
ax.plot(k_grid, k_grid, '--', label='45 graus')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Política')
ax.set_title('Funções Políticas e Capitais Estacionários')
ax.legend()

plt.show()


""" Cálculo dos capitais estacionários """
# Agora, calculamos o capital estacionário para cada possível z
for i_z, z in enumerate(z_grid):
    i_k = int(np.round(np.random.uniform(0, n_k - 1, size = 1), 0))  # aleatório
    
    # Achar índice do capital estacionário
    while k_grid[i_k] != gk_it[it][i_k, i_z]:  # até termos k = k'
        i_k = np.where(k_grid == gk_it[it][i_k, i_z])[0][0]  # Aplica o índice de k' em k
    
    print('O capital estacionário para z = {} é {:.3f}'.format(z, k_grid[i_k]))

# Para o k_grid com limite superior em 0.2, vai ter solução de canto
# É um indicativo para aumentar esse limite
