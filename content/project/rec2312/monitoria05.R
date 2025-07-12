# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 5

### MQE

## via plm()
data(TobinQ, package="pder")
str(TobinQ)

library(plm)

pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

Q.pooling = plm(ikn ~ qn, pTobinQ, model="pooling")
Q.ols = lm(ikn ~ qn, TobinQ)

stargazer::stargazer(Q.pooling, Q.ols, type="text")

summary(Q.pooling, vcov=vcovBK)


## Analítica
y = as.matrix(TobinQ[,"ikn"])
X = as.matrix(cbind(1,TobinQ[,"qn"]))

N = length(unique(TobinQ$cusip))
T = length(unique(TobinQ$year))
K = ncol(X) - 1


## Estimativas, valores preditos, resíduos
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
yhat = X %*% bhat
ehat = y - yhat

## matrizes between e within
iota_T = matrix(1, nrow=T, ncol=1)
I_N = diag(N)
I_NT = diag(N*T)

B = I_N %x% (iota_T %*% solve( t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B


## estimativas das variâncias
sig2v = as.numeric(t(ehat) %*% W %*% ehat / (N*(T-1)) )
sig2u = as.numeric((1/T) * ( t(ehat) %*% B %*% ehat / N - sig2v ))


## Matriz de variâncias-Covariâncias dos Erros
Sigma = sig2v * W + (sig2v + T*sig2u) * B


## Matriz de variâncias-Covariâncias do Estimador
bread = solve(t(X) %*% X)
meat = t(X) %*% Sigma %*% X
Vbhat = bread %*% meat %*% bread

# Erro padrão, estatística t e p-valor
se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N*T-K-1)

# Resumo
cbind(bhat, se, t, p)
summary(Q.pooling)$coef
summary(Q.pooling, vcov=vcovBK)$coef
