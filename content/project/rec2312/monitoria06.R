# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 6

## MQGF via plm()
library(plm)
data("TobinQ", package="pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimações MQGF
Q.walhus = plm(ikn ~ qn, pTobinQ, model="random", random.method="walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model="random", random.method="amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model="random", random.method="ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model="random", random.method="swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model="random", random.method="nerlove")

# Resumo as estimações
stargazer::stargazer(Q.walhus, Q.amemiya, Q.ht, Q.swar, Q.nerlove,
                     digits=5, type="text")


## MQGF "na mão"
# Vetor y e Matriz X
y = as.matrix( TobinQ[,"ikn"] )
X = as.matrix( cbind(1, TobinQ[,"qn"]) )

# Valores de N, T e K
N = length(unique(TobinQ$cusip))
T = length(unique(TobinQ$year))
K = ncol(X) - 1

# Estimativa de MQO
bhat_MQO = solve(t(X) %*% X) %*% t(X) %*% y

# Resíduos de MQO
yhat_MQO = X %*% bhat_MQO
ehat_MQO = y - yhat_MQO

# matrizes between e within
iota_T = matrix(1, nrow=T, ncol=1)
I_N = diag(N)
I_NT = diag(N*T)

B = I_N %x% (iota_T %*% solve( t(iota_T) %*% iota_T ) %*% t(iota_T) )
W = I_NT - B

# Variancias dos termos de erro
sig2v = as.numeric( (t(ehat_MQO) %*% W %*% ehat_MQO) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * (t(ehat_MQO) %*% B %*% ehat_MQO / N - sig2v))

# Inversa da Matriz de Variâncias-Covariâncias dos Erros
Sigma_1 = sig2v^(-1) * W + (sig2v + T*sig2u)^(-1) * B


# Estimativas MQGF
bhat_MQGF = solve( t(X) %*% Sigma_1 %*% X ) %*% ( t(X) %*% Sigma_1 %*% y )


# Matriz de Variâncias-Covariâncias do Estimador
Vbhat = solve( t(X) %*% Sigma_1 %*% X )


# Erro-padrão, estatística t e p-valor
se_bhat = sqrt( diag(Vbhat) )
t_bhat = bhat_MQGF / se_bhat
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)


# Resumo
cbind(bhat_MQGF, se_bhat, t_bhat, p_bhat)
summary(Q.walhus)$coef
