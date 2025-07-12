# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 2

## Operações Básicas
1 + 1
2 - 3
3 * 4
3 / 2
6 %/% 4
6 %% 4
8 ^ 2
8 ^ (1/3)
sqrt(4)


## Objetos <- ou =
obj1 <- 5
obj1

obj2 = 5 + 2
obj2

obj1 = obj2
obj1

obj1 = obj1 + 1
obj1


## Classes de objetos
num_real = 3
class(num_real)
class(3)

num_inteiro = 3L
class(num_inteiro)

texto = "oi"
class(texto)

logica1 = T
class(logica1)
logica2 = F
class(logica2)


## Expressões lógicas/booleanas
3 > 2
4 >= 4
5 == 3
6 != 6
6 != num_real + num_inteiro

3 > 2 & 4 >= 4
3 > 2 & 4 < 4

3 > 2 | 4 < 4


## Vetores
x = c(1, 2, 0.5)
class(x)

x = c(TRUE, FALSE, F, T)
x = c("a", 'b', "c")
class(x)

x = 1:8
x
class(x)


# Coerção de classes distintas
y = c(1.7, "a")
y
class(y)
as.numeric(y)
as.numeric("1.7")

y = c(FALSE, 0.75)
y
class(y)

y = c(TRUE, "a")
y
class(y)


# Vetor de sequência
seq(from=0, to=11, by=2)

seq(10, 15, length=50)


# Vetor com repetições
rep(NA, 10)
rep(c(1, 2), 3)
rep(c("a", "b", "c"), 5)


## Matrizes
m = matrix(nrow = 2, ncol = 3)
m

m = matrix(data=1, nrow = 2, ncol = 3)
m


m = matrix(1:6, nrow = 2, ncol = 3)
m

m = matrix(1:6, nrow = 2, ncol = 3, byrow=T)
m

x = 2:4
y = 7:9

m = cbind(x, y)
m

m = rbind(x, y)
m


# Arrays
a = array(1, c(2, 2))
a

a = array(1, c(2, 2, 2))
a

a = array(1:8, c(2, 2, 2))
a


## Listas - elementos com classes distintas
x = list(1, "a", TRUE, c(0.5, 0.6))
x


## Data Frames
x = data.frame(foo=1:4, bar=c(T, T, F, T))
x
nrow(x)
ncol(x)


# Carregando base de dados
db_txt = read.table("mtcars.txt")
db_csv = read.csv("mtcars.csv")
db_xlsx = xlsx::read.xlsx("mtcars.xlsx", 1)

db_csv_br = read.csv2("mtcars_br.csv")
db_xlsx_br = xlsx::read.xlsx2("mtcars_br.xlsx", 1)

data(ArgentinaCPI, package="AER")
ArgentinaCPI

data()



## Extraindo Subconjuntos (Subsetting)
x = c(1, 2, 5, 6, 8, 3, 21)

x[7]
x[1:3]
x[c(1, 3, 4)]
x[c(T, T, F, F, F, T, T)]

x > 5
x[x > 5]


# Extraindo de listas
x = list(foo=1:4, bar=0.6)

x[1]
class(x[1]) # continua lista

x[[1]]
class(x[[1]])

x$foo
class(x$foo)


# Extraindo de data frames ou matrizes
x = matrix(1:6, 2, 3)
x[1, 2]
x[1:2, 2]
x[, 2]
x[2,]


# Retirando missing values (NA's)
x = c(1, 6, 3, NA, NA, 4)

is.na(x)
sum(is.na(x))

x[!is.na(x)] # retorna valores não NA's






