# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 3

## ESTATÍSTICAS BÁSICAS
# Criando um vetor
x = c(1, 4, -5, 2, 8, -2, 4, 7, 8, 0, 2, 3, -5, 7, 4, -4, 2, 5, 2, -3)
x

# Valores absolutos
abs(x)

# Soma
sum(x)

# Média
mean(x)

# Desvio-padrão
sd(x)

# Quantis
quantile(x)
quantile(x, probs=c(0, 1))

# Máximo e Mínimo
max(x)
min(x)

# Obtendo os índices
?which
which(c(TRUE, T, F, F, T))

x == max(x)
which(x == max(x))
x[which(x == max(x))]
which(x == min(x))
which(x == mean(x))

x = matrix(1:6, nrow=2)
x

which(x == max(x), arr.ind = T)

x = c(1, 2, NA, 5)
mean(x, na.rm=T)
max(x, na.rm=T)


# Otimização de uma função univariada
x_grid = seq(-5, 5, length=1000)
x_grid

fx = x_grid^2 + 4*x_grid - 4

min(fx)
which(fx == min(fx))
x_grid[which(fx == min(fx))]


### ESTRUTURAS DE CONTROLE
## IF
x = 11

if (x > 10) {
  y = 10
} else if (x > 0) {
  y = 5
} else {
  y = 0
}


## FOR
x = c(1, 2, 4, 10)

for (i in x) {
  print(i^2)
}


## WHILE
num = 10

while (num > 1e-3) {
  print(num)
  num = num / 2
}


## EXEMPLO: Preenchendo uma matriz
X = seq(-5, 5, by=1)
Y = seq(0, 10, by=2)

fxy = matrix(NA, nrow=length(X), ncol=length(Y))

for (i in 1:length(X)) {

  for (j in 1:length(Y)) {
    fxy[i, j] = 2*X[i]^2 - Y[j]^2 + 3*X[i]*Y[j]
  }

}

fxy



### FUNÇÕES
soma = function(a, b) {
  a = a + 1
  b = b + 1
  a + b
}

soma(a=1, b=2)
soma(4, 5)

sum(1:5)

soma_vetor = function(vec_num) {
  sum(vec_num)
}

soma_vetor(c(1, 4, 7, 2, 9))

