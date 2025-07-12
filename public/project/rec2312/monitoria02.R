### MONITORIA 2 - MQO

## MQO via lm()
data(gpa1, package="wooldridge")
View(gpa1)

# Estimação via lm()
GPAres = lm(colGPA ~ hsGPA + ACT, data=gpa1)
lm(colGPA ~ hsGPA + ACT + 0, data=gpa1)

coef(GPAres)

fitted(GPAres)
residuals(GPAres)

summary(GPAres)
summary(GPAres)$coef


## MQO na mão
# vetor y
y = matrix( gpa1[,"colGPA"] )
y

# matriz X
X = cbind(const=1, gpa1[,c("hsGPA", "ACT")])
class(X)
X = as.matrix(X) # transformando em matriz
class(X)

# nº de observações N e covariadas K
N = nrow(gpa1)
N

K = ncol(X) - 1
K


# (1) Estimativas Beta-hat
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
bhat


# (2) Valores ajutados/preditos
yhat = X %*% bhat
yhat


# (3) Resíduos
ehat = y - yhat
ehat


# (4) Variância do termo de erro/resíduo
s2 = t(ehat) %*% ehat / (N - K - 1)
s2 = as.numeric(s2)
s2


# (5) Matriz de variância-covariância do estimador
Vbhat = s2 * solve( t(X) %*% X )
Vbhat


# (6) Erro padrão das estimativas
se = sqrt( diag(Vbhat) )
se


# Comparativo
cbind(bhat, se)
summary(GPAres)$coef



# (7) Estatística t
t = (bhat - 0) / se
t


# (8) p-valor
p = 2 * pt(-abs(t), N-K-1)
p



# Comparativo
cbind(bhat, se, t, p)
summary(GPAres)$coef

round(summary(GPAres)$coef, 4)
