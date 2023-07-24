# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTES DE HETEROCEDASTICIDADE

# Teste de Breusch-Pagan
data(smoke, package="wooldridge")
library(lmtest)

reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, smoke)
round(summary(reg)$coef, 4)

bptest(reg)

# na mão
N = nrow(smoke)
K = 6

reg.resid = lm(resid(reg)^2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
               smoke)
round(summary(reg.resid)$coef, 4)

r2e = summary(reg.resid)$r.squared
LM = N * r2e
1 - pchisq(LM, df=K)

# Teste F
summary(reg.resid)

F = (r2e / K) / ((1 - r2e) / (N-K-1))
1 - pf(F, K, N-K-1)


# Teste de White
yhat = fitted(reg)

bptest(reg, ~ yhat + I(yhat^2))

reg.resid = lm(resid(reg)^2 ~ yhat + I(yhat^2),
               smoke)
r2e = summary(reg.resid)$r.squared
LM = N * r2e
LM
1 - pchisq(LM, df=2)


## ESTIMADOR MQO COM ERROS PADRÃO ROBUSTOS
library(sandwich)
library(lmtest)

reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, smoke)

round(summary(reg)$coef, 4)
round(coeftest(reg), 4)

vcov_sandwich = vcovHC(reg, type="HC0")

round(coeftest(reg, vcov=vcov_sandwich), 4)


# estimação analítica
y = as.matrix(smoke[,"cigs"])
X = as.matrix(cbind(1, smoke[,c("lincome", "lcigpric", "educ",
                             "age", "agesq", "restaurn")]))
N = nrow(X)
K = ncol(X) - 1

bhat = solve( t(X) %*% X ) %*% t(X) %*% y
yhat = X %*% bhat
ehat = y - yhat
ehat^2

Sigma = diag(as.numeric(ehat^2))
Sigma[1:7, 1:7]

bread = solve(t(X) %*% X)
meat = t(X) %*% Sigma %*% X
Vbhat = bread %*% meat %*% bread
round(Vbhat, 3)

se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

data.frame(bhat, se, t, p) # analiticamente
coeftest(reg, vcov=vcov_sandwich) # vcovHC()
