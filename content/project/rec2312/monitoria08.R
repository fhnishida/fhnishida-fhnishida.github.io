# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 08
data(TobinQ, package="pder")

### WITHIN
library(plm)

## plm()
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimação within
Q.within = plm(ikn ~ qn, pTobinQ, model="within")
summary(Q.within)

## Analítica
y = as.matrix(TobinQ[,"ikn"])
Xt = as.matrix(TobinQ[,"qn"])

# N, T, K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(Xt)

# Matriz Between e Within
iota_T = matrix(1, T, 1)
I_N = diag(N)
I_NT = diag(N*T)

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Estimativas
dhat_W = solve(t(Xt) %*% W %*% Xt) %*% t(Xt) %*% W %*% y
dhat_W

# valores ajustados e resíduos
yhat_W = Xt %*% dhat_W
ehat_W = yhat_W - y

sig2v = as.numeric((t(ehat_W) %*% W %*% ehat_W) / (N*T - K - N))

Vdhat_W = sig2v * solve(t(Xt) %*% W %*% Xt)
se_dhat_W = sqrt(diag(Vdhat_W))
t_dhat_W = dhat_W / se_dhat_W
p_dhat_W = 2 * pt(-abs(t_dhat_W), N*T-K-N)

cbind(dhat_W, se_dhat_W, t_dhat_W, p_dhat_W)
summary(Q.within)$coef

# Efeitos fixos
Q.dummies = lm(ikn ~ 0 + qn + factor(cusip), TobinQ)
summary(Q.dummies)$coef




### 1D / FD

## via lm()
Q.fd = plm(ikn ~ -1 + qn, pTobinQ, model="fd")
summary(Q.fd)$coef
summary(Q.within)$coef

## Estimação Analítica
head(y)
head(Xt)
N
T
K

# Criar matriz de primeiras diferenças
Di = -diag(T)
diag(Di[-nrow(Di), -1]) = 1 # supradiagonal
Di[1:10, 1:10]

Di = Di[-nrow(Di),]
dim(Di)

D = I_N %x% Di
D[1:10, 1:10]

dhat_FD = solve(t(Xt) %*% t(D) %*% D %*% Xt) %*% t(Xt) %*% t(D) %*% D %*% y
dhat_FD

yhat_FD = Xt %*% dhat_FD
ehat_FD = y - yhat_FD

sig2v = as.numeric((t(ehat_FD) %*% t(D) %*% D %*% ehat_FD) / (N*T-K-N))

bread = solve(t(Xt) %*% t(D) %*% D %*% Xt)
meat = t(Xt) %*% t(D) %*% D %*% Xt
Vdhat_FD = sig2v * (bread %*% meat %*% bread)

se_dhat_FD = sqrt(diag(Vdhat_FD))
t_dhat_FD = dhat_FD / se_dhat_FD
p_dhat_FD = 2 * pt(-abs(t_dhat_FD), N*T-K-N)

cbind(dhat_FD, se_dhat_FD, t_dhat_FD, p_dhat_FD)
summary(Q.fd)$coef






