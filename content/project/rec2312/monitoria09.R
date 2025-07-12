# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTE DE WALD

# Restrição única
data(wage1, package="wooldridge")

reg = lm(lwage ~ female*married + educ + exper + expersq +
           tenure + tenursq, wage1)
round(summary(reg)$coef, 4)

bhat = matrix(coef(reg), ncol=1)
Vbhat = vcov(reg)
N = nrow(wage1)
K = length(bhat) - 1
ehat = residuals(reg)

r1prime = matrix(c(0, 0, 1, 0, 0, 0, 0, 0, 1), nrow=1)
h1 = 0
G = 1

t = (r1prime %*% bhat - h1) / sqrt(r1prime %*% Vbhat %*% t(r1prime))
pt(-abs(t), N-K-1)


# Restrições múltiplas
data(mlb1, package="wooldridge")
reg = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, mlb1)
round(summary(reg)$coef, 4)

Vbhat = vcov(reg)

aod::wald.test(Sigma=Vbhat,
               b=coef(reg),
               Terms=4:6,
               H0 = c(0,0,0))

bhat = matrix(coef(reg), ncol=1)
G = 3
R = matrix(c(0,0,0,1,0,0,
             0,0,0,0,1,0,
             0,0,0,0,0,1),
           byrow=T, nrow=G)
h = matrix(c(0,0,0), ncol=1)

aux = R %*% bhat - h
w = t(aux) %*% solve(R %*% Vbhat %*% t(R)) %*% aux
1 - pchisq(w, df=G)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## TESTE F
reg.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, mlb1)
myH0 = c("bavg=0", "hrunsyr=0", "rbisyr=0")
N = nrow(mlb1)
K = 5

car::linearHypothesis(reg.ur, myH0)

reg.r = lm(log(salary) ~ years + gamesyr, mlb1)

r2.ur = summary(reg.ur)$r.squared
r2.r = summary(reg.r)$r.squared

F = (r2.ur - r2.r) / (1 - r2.ur) * (N-K-1) / G
F
1 - pf(F, G, N-K-1)



