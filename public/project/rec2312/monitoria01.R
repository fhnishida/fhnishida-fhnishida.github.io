### REVISÃO DE PROGRAMAÇÃO EM R

## Operações Básicas
1 + 1 # soma
2 - 3 # subtração
2 * 3 # multiplicação
6 / 4 # divisão


## Objetos básicos
var <- 5
var

var2 = 3
var2

var = 6
var = 6 + var2
var
var = var + 1
var

class(var)
class(10)

class(10L)
10L

"Oi"
'tchau'
class('tchau')

TRUE
T
class(TRUE)
FALSE
F


## Expressões lógicas
2 > 1
2 > 3

1 < 4
1 <= 1

3 == 5
3 == 3

10 != 5
10^2 != 100

10^2 != 100 | 10 != 5
10^2 != 100 & 10 != 5



### Vetores e Matrizes
c(1, 2, 3, 4)
class(c(1, 2, 3, 4))

class(1:4)
c(1L, 2L, 3L, 4L)

c("oi", 'tchau')


?matrix

matrix()
matrix(nrow=2, ncol=3)

matrix(0, nrow=2, ncol=3)

1:6

matrix(1:6, nrow=2, ncol=3)

matrix(1:6, nrow=2, ncol=3, byrow=T)
matrix(1:6, nrow=2, byrow=T)


matrix(1:3, ncol=1)
matrix(1:3, nrow=1)

diag(2)
diag(3)


cbind() # juntar colunas
rbind() # juntar linhas

cbind(1:3, 6:8)
rbind(1:3, 6:8)


cbind(1, matrix(1:6, nrow=2, byrow=T))


## Operações matriciais
x = matrix(1:4, ncol=1) # vetor-coluna
y = matrix(6:9, ncol=1) # vetor-coluna

x + y
x - y
x * y
x / y


t(x)

t(x) %*% y # produto interno
x %*% t(y) # produto externo


X = matrix(6:1, nrow=3, ncol=2)
Y = matrix(10, nrow=3, ncol=2)

X + Y
X * Y

t(X) %*% Y

solve(t(X) %*% X) # matriz inversa


### Data Frames

## Carregando base de dados de arquivos
# read.csv()
# read.txt()


## Base de dados em pacotes no R
# install.packages("wooldridge")
data(gpa1, package="wooldridge")
gpa1
head(gpa1, 10)



## Extraindo subconjuntos
View(mtcars)

mtcars[1, 1]
mtcars[1, c(1, 2)]
mtcars[1, 1:2]

mtcars[2,]
mtcars[,1]

mtcars["Mazda RX4",]
mtcars[,c("mpg", "hp", "wt")]

mtcars$mpg




##  Criando variáveis
mtcars$mpg2 = mtcars$mpg ^ 2
mtcars$mpg2_sqrt = sqrt(mtcars$mpg2)
mtcars$mpg_neg = mtcars$mpg * (-1)
mtcars$mpg_neg_bs = abs(mtcars$mpg_neg)
mtcars$mpg_am = mtcars$mpg * mtcars$am
mtcars$mpg_am = mtcars$mpg_am * 20

