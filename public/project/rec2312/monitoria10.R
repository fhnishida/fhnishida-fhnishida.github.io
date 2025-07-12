# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## ESTIMADOR VI
data(mroz, package="wooldridge")
mroz = mroz[!is.na(mroz$wage),]

reg.ols = lm(lwage ~ educ + exper + expersq, mroz)
round(summary(reg.ols)$coef, 3)

library(ivreg)
reg.iv = ivreg(lwage ~ educ + exper + expersq |
                 fatheduc + exper + expersq, data=mroz)

stargazer::stargazer(reg.ols, reg.iv, type="text")

# Estimação analítica
y = as.matrix(mroz[,"lwage"])
X = as.matrix(cbind(1, mroz[,c("educ", "exper", "expersq")]))
Z = as.matrix(cbind(1, mroz[,c("fatheduc", "exper", "expersq")]))

N = nrow(X)
K = ncol(X) - 1

bhat = solve(t(Z) %*% X) %*% t(Z) %*% y

yhat = X %*% bhat
ehat = y - yhat

sig2hat = as.numeric(t(ehat) %*% ehat / (N-K-1))

Pz = Z %*% solve(t(Z) %*% Z) %*% t(Z)
Vbhat = sig2hat * solve(t(X) %*% Pz %*% X)

se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

data.frame(bhat, se, t, p)
summary(reg.iv)$coef


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## ESTIMADOR MQ2E
reg.2sls = ivreg(lwage ~ educ + exper + expersq |
                   fatheduc + motheduc + exper + expersq, data=mroz)
round(summary(reg.2sls)$coef, 4)

stargazer::stargazer(reg.ols, reg.iv, reg.2sls, type="text")


# 2 MQO's
#1o estágio
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, mroz)
xhat = fitted(reg.1st)

#2o estágio
reg.2nd = lm(lwage ~ xhat + exper + expersq, mroz)


stargazer::stargazer(reg.ols, reg.iv, reg.2sls, reg.2nd, type="text")


# Analítica
y = as.matrix(mroz[,"lwage"])
X = as.matrix(cbind(1, mroz[,c("educ", "exper", "expersq")]))
Z = as.matrix(cbind(1, mroz[,c("fatheduc", "motheduc", "exper", "expersq")]))
Pz = Z %*% solve(t(Z) %*% Z) %*% t(Z)

N = nrow(X)
K = ncol(X) - 1

bhat = solve(t(X) %*% Pz %*% X) %*% t(X) %*% Pz %*% y

yhat = X %*% bhat
ehat = y - yhat

sig2hat = as.numeric(t(ehat) %*% ehat / (N-K-1))

Vbhat = sig2hat * solve(t(X) %*% Pz %*% X)

se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

data.frame(bhat, se, t, p)
summary(reg.2sls)$coef

summary(reg.2sls)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTES DE ENDOGENEIDADE:
reg.ols = lm(lwage ~ educ + exper + expersq, mroz)
reg.2sls = ivreg(lwage ~ educ + exper + expersq |
                   fatheduc + motheduc + exper + expersq, data=mroz)

contrast = coef(reg.2sls) - coef(reg.ols)

w = t(contrast) %*% solve(vcov(reg.2sls) - vcov(reg.ols)) %*% contrast
w

1 - pchisq(abs(w), df=1)


# Hausman por regressão
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, mroz)
uhat = residuals(reg.1st)

reg.2nd.mod = lm(lwage ~ educ + exper + expersq + uhat, mroz)
summary(reg.2nd.mod)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTES DE INSTRUMENTOS FRACOS
reg.ur = lm(educ ~ fatheduc + motheduc + exper + expersq, mroz)
reg.r = lm(educ ~ exper + expersq, mroz)

r2.ur = summary(reg.ur)$r.squared
r2.r = summary(reg.r)$r.squared

N = nrow(mroz)
K = 4
G = 2

F = (r2.ur - r2.r) / (1 - r2.ur) * (N-K-1) / G
F

1 - pf(F, G, N-K-1)



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTES DE SOBREIDENTIFICAÇÃO

# Teste Hausman
reg.ur = ivreg(lwage ~ educ + exper + expersq |
                 fatheduc + motheduc + exper + expersq, data=mroz)
reg.r = ivreg(lwage ~ educ + exper + expersq |
                fatheduc + exper + expersq, data=mroz)

contrast = coef(reg.ur) - coef(reg.r)

w = t(contrast) %*% solve(vcov(reg.ur) - vcov(reg.r)) %*% contrast
w

1 - pchisq(abs(w), df=1)


# Teste de Sargan
N = nrow(mroz)
L = 2
J = 1

reg.2sls = ivreg(lwage ~ educ + exper + expersq |
                   fatheduc + motheduc + exper + expersq, data=mroz)

ehat = residuals(reg.2sls)

reg.aux = lm(ehat ~ fatheduc + motheduc + exper + expersq, mroz)

r2 = summary(reg.aux)$r.squared
sarg = N * r2
1 - pchisq(sarg, df=L-J)
