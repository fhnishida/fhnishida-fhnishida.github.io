# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 6

## Exemplo 2.3
data(ceosal1, package="wooldridge")
str(ceosal1)

cov(ceosal1$salary, ceosal1$roe)
var(ceosal1$roe)
mean(ceosal1$salary)
mean(ceosal1$roe)

b1hat = cov(ceosal1$salary, ceosal1$roe) / var(ceosal1$roe)
b0hat = mean(ceosal1$salary) - mean(ceosal1$roe) * b1hat
salhat = b0hat + b1hat*ceosal1$roe
ehat = ceosal1$salary - salhat
cbind(ceosal1$salary, salhat, ehat)

# via lm()
lm(ceosal1$salary ~ ceosal1$roe)
reg = lm(salary ~ roe, data=ceosal1)
names(reg)

plot(ceosal1$roe, ceosal1$salary)
abline(lm(salary ~ roe, data=ceosal1), col="red")

reg$coefficients
coefficients(reg)
fitted(reg)
reg$fitted
resid(reg)
reg$resid

lm(salary ~ log(roe), data=ceosal1)
lm(log(salary) ~ roe, data=ceosal1)
lm(log(salary) ~ log(roe), data=ceosal1)

lm(salary ~ roe + sales, ceosal1)
lm(salary ~ 0 + roe + sales, ceosal1)
lm(salary ~ -1 + roe + sales, ceosal1)


## VIOLAÇÕES DE HIPÓTESES
# Exemplo 1 - sem violações de hipótese
b0til = 50
b1til = -5
N = 1000

set.seed(123)
etil = rnorm(N, 0, 4)
x = runif(N, 1, 9)
y = b0til + b1til * x + etil
y

plot(x, y)

lm(y ~ x)
abline(lm(y ~ x), col="red")
abline(a=50, b=-5, col="blue")
cor(x, etil)


# Exemplo 2 - sem violações de hipótese
b2til = 3
z = runif(N, 11, 15)
y = b0til + b1til * x + b2til * z + etil

lm(y ~ x)
cor(x, z)


# Exemplo 3 - violação de cov(e,x)
z = 2.5*x + rnorm(N, 0, 2)
cor(x, b2til*z + etil)

y = b0til + b1til * x + b2til * z + etil

lm(y ~ x)
lm(y ~ x + z)


# Exemplo 4 - violação de E(e) = 0, mas constante
set.seed(123)
etil = rnorm(N, 100, 4)
x = runif(N, 1, 9)
y = b0til + b1til * x + etil

lm(y ~ x)


# Exemplo 5 - violação de homocedasticidade
etil = rnorm(N, 0, 5*x)
y = b0til + b1til * x + etil

plot(x, etil)

lm(y ~ x)








