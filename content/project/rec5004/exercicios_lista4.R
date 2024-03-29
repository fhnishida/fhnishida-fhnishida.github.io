# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# ### C8.8
# data(gpa1, package="wooldridge")
# library(lmtest)
# library(sandwich)
#
# ## (a)
# reg.ols = lm(colGPA ~ hsGPA + ACT + skipped + PC, gpa1)
# summary(reg.ols)$coef
#
# ehat = resid(reg.ols)
# head(ehat)
#
# ## (b) - fazer com função skedastic (?) - faça test de white e aproveite a
# # Verifique se valores preditos são positivos - caso positivo,
# # usar como h(x) para criar matriz de pesos W
# reg.aux = lm(ehat^2 ~ fitted(reg.ols) + I(fitted(reg.ols)^2))
# summary(reg.aux)$coef
#
# ## (c)
# W = diag(fitted(reg.aux))
# round(W[1:7,1:7], 4)
#
# y = as.matrix(gpa1[,"colGPA"])
# X = as.matrix(cbind(1,gpa1[,c("hsGPA","ACT","skipped","PC")]))
# N = nrow(gpa1)
# K = ncol(X)-1
#
# bhat = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
# ehat = y - X %*% bhat
# sig2hat = as.numeric(t(ehat) %*% W %*% ehat / (N-K-1))
# Vbhat = sig2hat * solve(t(X) %*% W %*% X)
# se = sqrt(diag(Vbhat))
#
# ## (d)
# diff_bhat = bhat
# se_ini = se
# i = 1
# while (max(diff_bhat) > 1e-15) {
#   bhat_ini = bhat
#   reg.aux = lm(ehat^2 ~ fitted(reg.ols) + I(fitted(reg.ols)^2))
#   W = diag(fitted(reg.aux))
#   bhat = solve(t(X) %*% W %*% X) %*% t(X) %*% W %*% y
#   ehat = y - X %*% bhat
#   diff_bhat = bhat - bhat_ini
#   print(diff_bhat)
# }
#
# sig2hat = as.numeric(t(ehat) %*% W %*% ehat / (N-K-1))
# Vbhat = sig2hat * solve(t(X) %*% W %*% X)
# se = sqrt(diag(Vbhat))
#
#
# # # usando função
# # vcovHC(reg.ols, "HC0") # vcov robusto
# #
# # # "na mão"
# # y = as.matrix(hprice1[,"price"])
# # X = as.matrix(cbind(1,hprice1[,c("lotsize","sqrft","bdrms")]))
# #
# # Sigma = diag(residuals(reg.ols)^2)
# # round(Sigma[1:7,1:7], 3)
# #
# # bread = solve(t(X) %*% X)
# # meat = t(X) %*% Sigma %*% X
# # Vbhat = bread %*% meat %*% bread
# #
# # se_robust = sqrt(diag(Vbhat))
# # se_robust


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
### C8.12
## (a) MQO e MQO com erros padrão robustos
data(meap00_01, package="wooldridge")
library(lmtest)
library(sandwich)

## MQO
reg.ols = lm(math4 ~ lunch + lenroll + lexppp, meap00_01)
summary(reg.ols)$coef

## MQO com erros padrão robustos
# calculando matriz de vcov robusta
ehat = resid(reg.ols)
X = model.matrix(reg.ols)
Sigma = diag(ehat^2)
bread = solve(t(X) %*% X)
meat = t(X) %*% Sigma %*%  X
vcov_robust = bread %*% meat %*% bread
vcov_robust

reg.ols.rob = coeftest(reg.ols, vcov=vcov_robust)
# reg.ols.rob = coeftest(reg.ols, vcov=sandwich::vcovHC(reg.ols,"HC0"))

stargazer::stargazer(reg.ols, reg.ols.rob, type="text")
# erros padrão robustos são maiores do que do MQO


## (b) Teste de White
ehat = resid(reg.ols)
yhat = fitted(reg.ols)
reg.resid = lm(ehat^2 ~ yhat + I(yhat^2))
summary(reg.resid)

# reg.resid2 = lm(ehat^2 ~ lunch + lenroll + lexppp +
#                  I(lunch^2) + I(lenroll^2) + I(lexppp^2) +
#                  lunch:lenroll + lunch:lexppp + lenroll:lexppp,
#                meap00_01)
# summary(reg.resid2)
# Teste F 132.7, evidência forte contra H0 (homocedasticidade)
# quais dos termos de erro aparentam apresentar heterocedasticidade?


## (c) MQP/MQGF
reg.aux = lm(log(ehat^2) ~ yhat + I(yhat^2))
head(fitted(reg.aux))

# Note que gera valores preditos muito próximos
reg.aux2 = lm(log(ehat^2) ~ lunch + lenroll + lexppp +
                I(lunch^2) + I(lenroll^2) + I(lexppp^2) +
                lunch:lenroll + lunch:lexppp + lenroll:lexppp,
              meap00_01)
head(fitted(reg.aux2))

# summary(reg.aux)
w = 1 / exp(fitted(reg.aux))
reg.fgls = lm(math4 ~ lunch + lenroll + lexppp, meap00_01, weights=w)

# Comparativo
stargazer::stargazer(reg.ols, reg.ols.rob, reg.fgls, type="text")
# Há grande diferenças nos coeficientes


## (d) MQP/MQGF com iterações
bhat.ini = coef(reg.fgls) # estimativas iniciais do MQGF
diff_bhat = max(bhat.ini)
reg.fgls.it = reg.fgls
it=0

while (diff_bhat > 1e-15) {
  # print(it)
  ehat.it = resid(reg.fgls.it) # novos resíduos
  yhat.it = fitted(reg.fgls.it) # novos valores preditos
  reg.aux.it = lm(log(ehat.it^2) ~ yhat.it + I(yhat.it^2)) # nova reg auxiliar
  w.it = 1 / exp(fitted(reg.aux.it)) # novos pesos
  reg.fgls.it = lm(math4 ~ lunch + lenroll + lexppp, meap00_01, weights=w.it)
  bhat.it = coef(reg.fgls.it) # novas estimativas
  diff_bhat = max(bhat.it - bhat.ini) # máximo das diferenças de estimativas
  bhat.ini = bhat.it # atualização de valor inicial das estimativas
  it=it+1 # atualização da iteração
}

print(paste0("número de iterações: ", it)) # número de iterações
stargazer::stargazer(reg.ols, reg.ols.rob, reg.fgls, reg.fgls.it, type="text")
#


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
### C8.12
data(labsup, package="wooldridge")

## (a)
library(lmtest)
library(sandwich)

reg.ols = lm(hours ~ kids + nonmomi + educ + age + agesq + black + hispan,
         data=labsup)

reg.ols.rob = coeftest(reg.ols, vcov=vcovHC(reg.ols, "HC0"))

round(reg.ols.rob, 3)
stargazer::stargazer(reg.ols, reg.ols.rob, type="text", digits=3)


## (c) teste de instrumento fraco
reg.1st = lm(kids ~ samesex + nonmomi + educ + age + agesq + black + hispan,
             data=labsup)
round(coeftest(reg.1st), 3)

# Teste instrumento fraco > apenas teste t (única restrição/instrumento)


# (d)

## Estimação via ivreg()
library(ivreg)
reg.iv = ivreg(hours ~ kids + nonmomi + educ + age + agesq + black + hispan |
                 samesex + nonmomi + educ + age + agesq + black + hispan,
               data=labsup)

stargazer::stargazer(reg.ols.rob, reg.iv, type="text", digits=3)

## Estimação analítica
y = as.matrix(labsup[,"hours"])
X = as.matrix(cbind(1, labsup[,c("kids", "nonmomi", "educ", "age",
                                 "agesq", "black", "hispan")]))
Z = as.matrix(cbind(1, labsup[,c("samesex", "nonmomi", "educ", "age",
                                 "agesq", "black", "hispan")]))
Pz = Z %*% solve(t(Z) %*% Z) %*% t(Z)

N = nrow(X)
K = ncol(X) - 1

bhat.iv = solve(t(Z) %*% X) %*% t(Z) %*% y
yhat = X %*% bhat.iv
ehat = y - yhat

sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Vbhat = sig2hat * solve(t(X) %*% Pz %*% X)

se = sqrt(diag(Vbhat))
t = bhat.iv / se
p = 2 * pt(-abs(t), N-K-1)

round(data.frame(bhat.iv, se, t, p), 3)


# (e) Teste de endogeneidade: Hausman
bhat.ols = coef(reg.ols)
bhat.iv = coef(reg.iv)
Vbhat.ols = vcov(reg.ols)
Vbhat.iv = vcov(reg.iv)

contrast = bhat.iv - bhat.ols
w = t(contrast) %*% solve(Vbhat.iv - Vbhat.ols) %*% contrast
w
1 - pchisq(abs(w), 1)


# # # # SOBREIDENTIFICADO # # # # # # # # # # # # # # # # # #

## (c)' teste de instrumentos fracos
reg.1st = lm(kids ~ samesex + multi2nd + nonmomi + educ + age + agesq + black + hispan,
             data=labsup)
reg.1st.r = lm(kids ~ nonmomi + educ + age + agesq + black + hispan,
               data=labsup)
r2ur = summary(reg.1st)$r.squared
r2r = summary(reg.1st.r)$r.squared

F = (r2ur - r2r) / (1 - r2ur) * (N-K-1) / 2
1 - pf(F, 2, N-K-1)


# (d')

## Estimação via ivreg()
library(ivreg)
reg.2sls = ivreg(hours ~
                   kids + nonmomi + educ + age + agesq + black + hispan |
                   samesex + multi2nd + nonmomi + educ + age + agesq + black + hispan,
                 data=labsup)

stargazer::stargazer(reg.ols.rob, reg.iv, reg.2sls, type="text", digits=3)

## Estimação analítica
Z = as.matrix(cbind(1, labsup[,c("samesex", "multi2nd", "nonmomi", "educ", "age",
                                 "agesq", "black", "hispan")]))
Pz = Z %*% solve(t(Z) %*% Z) %*% t(Z)

bhat.2sls = solve(t(X) %*% Pz %*% X) %*% t(X) %*% Pz %*% y
yhat = X %*% bhat.2sls
ehat = y - yhat

sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Vbhat = sig2hat * solve(t(X) %*% Pz %*% X)

se = sqrt(diag(Vbhat))
t = bhat.2sls / se
p = 2 * pt(-abs(t), N-K-1)

round(data.frame(bhat.2sls, se, t, p), 3)



# (e') Teste de endogeneidade: Hausman
bhat.2sls = coef(reg.2sls)
Vbhat.2sls = vcov(reg.2sls)

contrast = bhat.2sls - bhat.ols
w = t(contrast) %*% solve(Vbhat.2sls - Vbhat.ols) %*% contrast
1 - pchisq(abs(w), 1)



# (f)
L = 2 # núm. instrumentos
J = 1 # núm. regressores endógenos

# Estimação nos resíduos
reg.resid = lm(resid(reg.2sls) ~ samesex + multi2nd + nonmomi + educ +
               age + agesq + black + hispan, data=labsup)
round(coeftest(reg.resid), 3)

# Estatística SARG
r2resid = summary(reg.resid)$r.squared
sarg = N * r2resid # sempre positivo
1 - pchisq(sarg, df=L-J) # p-valor


#
# # Equivalente:
# reg.resid.r = lm(resid(reg.2sls) ~ samesex + nonmomi + educ + age + agesq + black + hispan, data=labsup)
# r2ur = summary(reg.resid)$r.squared
# r2r = summary(reg.resid.r)$r.squared
#
# F = (r2ur - r2r) / (1 - r2ur) * (N-K-1) / (L-J)
# F
# pf(F, L-J, N-K-1)
#
#
# # (f') teste de Hausman para sobreidentificação
# contrast = bhat.2sls - bhat.iv
# w = t(contrast) %*% solve(Vbhat.2sls - Vbhat.iv) %*% contrast
# w
# 1 - pchisq(abs(w), 1)
#
#
# # ao contrário
# reg.iv2 = ivreg(hours ~ kids + nonmomi + educ + age + agesq + black + hispan |
#                   multi2nd + nonmomi + educ + age + agesq + black + hispan,
#                data=labsup)
#
# bhat.iv2 = coef(reg.iv2)
# Vbhat.iv2 = vcov(reg.iv2)
#
# contrast = bhat.2sls - bhat.iv2
# w = t(contrast) %*% solve(Vbhat.2sls - Vbhat.iv2) %*% contrast
# w
# 1 - pchisq(abs(w), 1)
