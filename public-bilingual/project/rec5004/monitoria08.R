# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## Monitoria 8

## OPERAÇÕES MATRICIAIS
# Operações padrão
x = 1:4
x + x
x * x
4 * x

X = matrix(1:8, nrow=4, ncol=2)
X = matrix(1:8, nrow=4, ncol=2, byrow=T)

X + X
X * X
2 * X
X^2
sqrt(X)

# Operações vetoriais/matriciais
t(x)
t(X)

x %*% x
x %*% t(x)

x_col = matrix(1:4, ncol=1)
x_col %*% x_col
t(x_col) %*% x_col
x_col %*% t(x_col)

X
t(X)
t(X) %*% X
solve(t(X) %*% X)

diag(solve(t(X) %*% X))
diag(4)
diag(1:4)


## REGRESSÃO MÚLTIPLA
data(gpa1, package="wooldridge")
str(gpa1)

reg = lm(colGPA ~ hsGPA + ACT, gpa1)
summary(reg)

coef(summary(reg))
summary(reg)$coef

# valores preditos
fitted(reg)
vcov(reg)
confint(reg)

# Estimação Analítica
y = as.matrix(gpa1[,"colGPA"])
X = as.matrix(cbind(1, gpa1[,c("hsGPA","ACT")]))

N = nrow(X)
K = ncol(X)-1

bhat = solve(t(X) %*% X) %*% t(X) %*% y
yhat = X %*% bhat
ehat = y - yhat

sig2hat = as.numeric(t(ehat) %*% ehat / (N-K-1))
Vbhat = sig2hat * solve(t(X) %*% X)

se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

round(data.frame(bhat, se, t, p), 4)
round(coef(summary(reg)), 4)

