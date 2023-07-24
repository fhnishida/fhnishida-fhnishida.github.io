# -*- coding: utf-8 -*-
"""
Lista 4 de Macroeconomia I (Parte 1) de 2021
01/06/2021 - author: Fábio Nishida
"""

# Importando módulos necessários
import numpy as np
from math import log as log
import matplotlib.pyplot as plt


##############################################################################
""" Exercício 2 """
# Construindo a matriz de Makov e a distribuição inicial
P_it = [np.array([0.25, 0.25, 0.25, 0.25])]

pi = np.array([[0.200, 0.300, 0.400, 0.100],
               [0.100, 0.100, 0.700, 0.100],
               [0.950, 0.024, 0.025, 0.001],
               [0.250, 0.250, 0.250, 0.250]])

# Para multiplicarmos a matriz, podemos usar ambos:
np.dot(P_it[0], pi)
np.dot(np.transpose(pi), P_it[0])

# Para somarmos os elementos de uma matriz, usamos sum do NumPy
np.sum(pi)


# Estabelecendo parâmetros
tol_norma = 1e-7
norma = np.inf  # Apenas para entrar no loop
it = 0

# Realizando iterações até distância de P_t e P_{t+1} ser menor do que 10^{-7}
while norma > tol_norma:
    it += 1
    
    P = np.dot(P_it[it - 1], pi)
    P_it.append(P)
    
    norma = np.sum((P - P_it[it - 1]) ** 2)
    print("Iteração {}: com norma = {:.7f}".format(it, norma))
    
print("Distribuição estacionária:", np.round(P_it[it], 4))



# (Usando Teorema 2.2.1) Unicidade da distribuição estacionária

# Verificar se existe algum 0 na matriz de Markov
qtd_zeros = 0
for p in range(len(pi)):
    for q in range(len(pi[0])):
        if pi[p, q] == 0:
            qtd_zeros += 1

if qtd_zeros == 0:
    print("A distribuição estacionária é única, pois todos elemento na matriz",
          "de Markov é estritamente maior do que zero.")
else:
    print("A distribuição estacionária não é única, pois há", qtd_zeros,
          "elemento(s) igual(is) a zero na matriz de Markov.")


# (Usando Teorema 2.2.2) Ver Unicidade por n multiplicações da matriz de Markov
# Calculando a matriz de Markov elevada a n
pi_it = [pi]
tol_norma = 1e-7
norma = np.inf
it = 0

while norma > tol_norma:
    it += 1
    pi_novo = np.dot(pi_it[it - 1], pi)
    pi_it.append(pi_novo)
    norma = np.sum((pi_it[it] - pi_it[it - 1]) ** 2)
    print("Iteração {}: com norma = {:.7f}".format(it, norma))

print(np.round(pi_it[it], 4))

# Verificar se existe algum 0 na matriz de Markov iterada
qtd_zeros = 0
for p in range(len(pi_it[it])):
    for q in range(len(pi_it[it])):
        if pi[p, q] == 0:
            qtd_zeros += 1

if qtd_zeros == 0:
    print("A distribuição estacionária é única, pois todos elemento na matriz",
          "de Markov é estritamente maior do que zero.")
else:
    print("A distribuição estacionária não é única, pois há", qtd_zeros,
          "elemento(s) igual(is) a zero na matriz de Markov.")



##############################################################################
""" Exercício 4 item (d) """

# Definição dos parâmetros
k_grid = np.linspace(0.01, 6, 51)
n_k = len(k_grid)
alpha = 0.3
beta = 1 / 1.05
delta = 0.05
phi = 1
n_grid = np.linspace(0, 1, 11)
# n_grid = np.array([1/4, 2/4, 3/4, 1])
n_n = len(n_grid)
z_grid = np.array([0.8, 1.0, 1.2])
n_z = len(z_grid)
pi = np.array([[0.20, 0.50, 0.30],
               [0.10, 0.60, 0.30],
               [0.25, 0.25, 0.50]])


# Criando lista de listas para incluir funções valor e política
# Note que, num modelo que considera incerteza, teremos uma função para cada z
v_it = [np.zeros((n_k, n_z))]
gk_it = [np.zeros((n_k, n_z))]
gn_it = [np.zeros((n_k, n_z))]


# Estabelecendo variáveis para realizar os loops
tol_norma = 1e-5  # Distância entre funções máxima para considerar convergência
tol_it = 500  # Número máximo de iterações (caso não convirja antes)
norma = np.inf  # Valor apenas para entrar no loop
it = 0  # Nº iterações (antes utilizamos n - agora usado para trabalho)


while norma > tol_norma and it < tol_it:
    it += 1  # Atualizando o número da iteração
        
    # Criando objetos para preencher com funções objetivo, valor e política
    f_obj = np.zeros((n_k, n_z, n_k, n_n))  # Lista com n_k matrizes n_k x z
    Tv = np.zeros((n_k, n_z))
    gn = np.zeros((n_k, n_z))
    gk = np.zeros((n_k, n_z))
    
    for i_k, k in enumerate(k_grid):
        for i_z, z in enumerate(z_grid):
            for i_kk, kk in enumerate(k_grid):
                for i_n, n in enumerate(n_grid):
                    c = z*(k**alpha * n**(1 - alpha)) + (1 - delta)*k - kk
                    if c > 0:
                        Ev = np.dot(pi[i_z,:], v_it[it - 1][i_kk,:])
                        f_obj[i_k, i_z, i_kk, i_n] = log(c) - (n**(1 + phi) / 1 + phi) + beta*Ev
                    else:
                        f_obj[i_k, i_z, i_kk, i_n] = -np.inf
            
            # Preenchida uma matriz kk x n, encontrar elemento que maximiza
            indice_max = np.argmax(f_obj[i_k, i_z])  # Maximiza matriz definida por k e z (e de dimensão k' e n)
            indice_gk = indice_max // n_n  # Divisão Inteira - Índice de k'
            indice_gn = indice_max % n_n  # Resto da Divisão - Índice de n
            
            Tv[i_k, i_z] = np.max(f_obj[i_k, i_z])
            gk[i_k, i_z] = indice_gk
            gn[i_k, i_z] = indice_gn
            
    
    # Após preencher totalmente gk e gn, trocar índices pelos valores nos grids
    for p in range(len(gk)):
        for q in range(len(gk[0])):
            gk[p, q] = k_grid[int(gk[p, q])]  
            gn[p, q] = n_grid[int(gn[p, q])]

    v_it.append(Tv)
    gk_it.append(gk)
    gn_it.append(gn)

    norma = np.max(abs(v_it[it] - v_it[it - 1]))
    print('A iteração {} terminou com norma igual a {:.5f}'.format(it,norma))


""" Visualização Gráfica da Função Valor """
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, v_it[it][:,0], label='$g_k$ (para $z = 0.8$)')
ax.plot(k_grid, v_it[it][:,1], label='$g_k$ (para $z = 1.0$)')
ax.plot(k_grid, v_it[it][:,2], label='$g_k$ (para $z = 1.2$)')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Valor')
ax.set_title('Função Valor para cada estado $z$')
ax.legend()


""" Visualização Gráfica da Função Política do Capital """
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, gk_it[it][:,0], label='$g_k$ (para $z = 0.8$)')
ax.plot(k_grid, gk_it[it][:,1], label='$g_k$ (para $z = 1.0$)')
ax.plot(k_grid, gk_it[it][:,2], label='$g_k$ (para $z = 1.2$)')
ax.plot(k_grid, k_grid, '--', label='45 graus')

# Limites do gráfico
# ax.set_ylim([4.5, 6])  # tamanho mínimo e máximo vertical
# ax.set_xlim([4.5, 6])  # tamanho mínimo e máximo horizontal

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Política de Capital')
ax.set_title('Função Política de Capital e $g_k(k)$ estacionário')
ax.legend()

plt.show()


""" Visualização Gráfica da Função Política do Trabalho """
fig, ax = plt.subplots()

# Inclusão de cada função valor no gráfico
ax.plot(k_grid, gn_it[it][:,0], label='$g_n$ (para $z = 0.8$)')
ax.plot(k_grid, gn_it[it][:,1], label='$g_n$ (para $z = 1.0$)')
ax.plot(k_grid, gn_it[it][:,2], label='$g_n$ (para $z = 1.2$)')

# Legendas
ax.set_xlabel('Capital')
ax.set_ylabel('Função Política de Trabalho')
ax.set_title('Função Política de Trabalho para cada estado $z$')
ax.legend()


""" Cálculo dos capitais estocásticos """
for i_z, z in enumerate(z_grid):
    i_k = 0
    loop = 0
    # Achar índice do capital estacionário
    while k_grid[i_k] != gk_it[it][i_k, i_z] and loop < 100:  # até termos k = k'
        i_k = np.where(k_grid == gk_it[it][i_k, i_z])[0][0]  # Aplica o índice de k' em k
        loop += 1  # Inserido por loops infinitos próximo ao k estacionário
        
    print('O capital estacionário para z = {} é {:.3f}'.format(z, k_grid[i_k]))
