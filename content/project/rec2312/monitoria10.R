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

