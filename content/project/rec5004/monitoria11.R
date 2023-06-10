# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## ESTIMADOR MQP

# Modelo real
b0til = 50
b1til = -5
N = 100

set.seed(123)
x = runif(N, 1, 9)
e_til = rnorm(N, 0, 10*x)
y = b0til + b1til * x + e_til
plot(x, y)


# Estimações
reg.ols = lm(y ~ x)
reg.wls = lm(y ~ x, weights=1/(10*x)^2)
stargazer::stargazer(reg.ols, reg.wls, type="text")

reg.wls2 = lm(y ~ x, weights=(10*x)^2)

stargazer::stargazer(reg.ols, reg.wls, reg.wls2, type="text")

# Analítica
y = as.matrix(y)
X = as.matrix(cbind(1, x))
N
K = ncol(X) - 1

W = diag(1/(10*x)^2)
round(W[1:7,1:7], 5)

bhat_wls = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
yhat = X %*% bhat_wls
ehat = y - yhat
sig2hat = as.numeric(t(ehat) %*% W %*% ehat / (N-K-1))

Vbhat_wls = sig2hat * solve(t(X) %*% W %*% X)

se_wls = sqrt(diag(Vbhat_wls))
t_wls = bhat_wls / se_wls
p_wls = 2 * pt(-abs(t), N-K-1)

data.frame(bhat_wls, se_wls, t_wls, p_wls)
summary(reg.wls)$coef


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## ESTIMADOR MQGF
data(smoke, package="wooldridge")

reg.ols = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
             smoke)

logu2 = log(resid(reg.ols)^2)

reg.var = lm(logu2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
             smoke)
w = 1 / exp(fitted(reg.var))

reg.fgls = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
              data=smoke, weights=w)

stargazer::stargazer(reg.ols, reg.fgls, type="text")


# Analiticamente
y = as.matrix(smoke[,"cigs"])
X = as.matrix(cbind(1, smoke[,c("lincome", "lcigpric", "educ",
                             "age", "agesq", "restaurn")]))

N = nrow(X)
K = ncol(X) - 1

# MQO
bhat_ols = solve( t(X) %*% X) %*% t(X) %*% y
yhat_ols = X %*% bhat_ols
ehat_ols = y - yhat_ols

# Reg Auxiliar nos resíduos
ghat = solve(t(X) %*% X) %*% t(X) %*% log(ehat_ols^2)

W = diag(as.numeric(1 / exp(X %*% ghat)))
round(W[1:7,1:7], 5)


bhat_fgls = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
yhat_fgls = X %*% bhat_fgls
ehat_fgls = y - yhat_fgls

sig2hat_fgls = as.numeric(t(ehat_fgls) %*% W %*% ehat_fgls / (N-K-1))
Vbhat_fgls = sig2hat_fgls * solve( t(X) %*% W %*% X)

se_fgls = sqrt(diag(Vbhat_fgls))
t_fgls = bhat_fgls / se_fgls
p_fgls = 2 * pt(-abs(t_fgls), N-K-1)

data.frame(bhat_fgls, se_fgls, t_fgls, p_fgls)
summary(reg.fgls)$coef
