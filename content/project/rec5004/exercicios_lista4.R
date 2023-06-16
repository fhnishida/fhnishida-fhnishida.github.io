# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
### C8.8
data(gpa1, package="wooldridge")
library(lmtest)
library(sandwich)

## (a)
reg.ols = lm(colGPA ~ hsGPA + ACT + skipped + PC, gpa1)
summary(reg.ols)$coef

ehat = resid(reg.ols)
head(ehat)

## (b) - fazer com função skedastic (?) - faça test de white e aproveite a
# Verifique se valores preditos são positivos - caso positivo,
# usar como h(x) para criar matriz de pesos W
reg.aux = lm(ehat^2 ~ fitted(reg.ols) + I(fitted(reg.ols)^2))
summary(reg.aux)$coef

## (c)
W = diag(fitted(reg.aux))
round(W[1:7,1:7], 4)

y = as.matrix(gpa1[,"colGPA"])
X = as.matrix(cbind(1,gpa1[,c("hsGPA","ACT","skipped","PC")]))
N = nrow(gpa1)
K = ncol(X)-1

bhat = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
ehat = y - X %*% bhat
sig2hat = as.numeric(t(ehat) %*% W %*% ehat / (N-K-1))
Vbhat = sig2hat * solve(t(X) %*% W %*% X)
se = sqrt(diag(Vbhat))

## (d)
diff_bhat = bhat
se_ini = se
i = 1
while (max(diff_bhat) > 1e-15) {
  bhat_ini = bhat
  reg.aux = lm(ehat^2 ~ fitted(reg.ols) + I(fitted(reg.ols)^2))
  W = diag(fitted(reg.aux))
  bhat = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
  ehat = y - X %*% bhat
  diff_bhat = bhat - bhat_ini
  print(diff_bhat)
}

sig2hat = as.numeric(t(ehat) %*% W %*% ehat / (N-K-1))
Vbhat = sig2hat * solve(t(X) %*% W %*% X)
se = sqrt(diag(Vbhat))


# # usando função
# vcovHC(reg.ols, "HC0") # vcov robusto
#
# # "na mão"
# y = as.matrix(hprice1[,"price"])
# X = as.matrix(cbind(1,hprice1[,c("lotsize","sqrft","bdrms")]))
#
# Sigma = diag(residuals(reg.ols)^2)
# round(Sigma[1:7,1:7], 3)
#
# bread = solve(t(X) %*% X)
# meat = t(X) %*% Sigma %*% X
# Vbhat = bread %*% meat %*% bread
#
# se_robust = sqrt(diag(Vbhat))
# se_robust


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
### C8.12
## (a) MQO e MQO com erros padrão robustos
data(meap00_01, package="wooldridge")
library(lmtest)
library(sandwich)

# MQO
reg.ols = lm(math4 ~ lunch + lenroll + lexppp, meap00_01)
summary(reg.ols)$coef

# MQO com erros padrão robustos
reg.ols.rob = coeftest(reg.ols, vcov=vcovHC(reg.ols,"HC0"))
stargazer::stargazer(reg.ols, reg.ols.rob, type="text")
# erros padrão robustos são maiores do que do MQO


## (b) Teste de White
ehat = resid(reg.ols)
yhat = fitted(reg.ols)
reg.resid = lm(ehat^2 ~ yhat + I(yhat^2))
summary(reg.resid)
# Teste F 132.7, evidência forte contra H0 (homocedasticidade)
# quais dos termos de erro aparentam apresentar heterocedasticidade?


## (c) MQP/MQGF
reg.aux = lm(log(ehat^2) ~ yhat + I(yhat^2))
summary(reg.aux)
w = 1 / exp(fitted(reg.aux))

reg.wls = lm(math4 ~ lunch + lenroll + lexppp, meap00_01, weights=w)

stargazer::stargazer(reg.ols, reg.ols.rob, reg.wls, type="text")
# Há grande diferenças nos coeficientes


## (d) MQP/MQGF com iterações
bhat.ini = coef(reg.wls)
diff_bhat = max(bhat.ini)
reg.wls.it = reg.wls
it=1
while (diff_bhat > 1e-15) {
  print(it)
  ehat.it = resid(reg.wls.it)
  yhat.it = fitted(reg.wls.it)
  reg.aux.it = lm(log(ehat.it^2) ~ yhat.it + I(yhat.it^2))
  w.it = 1 / exp(fitted(reg.aux.it))
  reg.wls.it = lm(math4 ~ lunch + lenroll + lexppp, meap00_01, weights=w.it)
  bhat.it = coef(reg.wls.it)
  diff_bhat = max(bhat.it - bhat.ini)
  bhat.ini = bhat.it
  it=it+1
}

stargazer::stargazer(reg.ols, reg.ols.rob, reg.wls, reg.wls.it, type="text")
#
