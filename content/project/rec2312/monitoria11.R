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


