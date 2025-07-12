# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 7

## Matriz de transformação between
N = 2
T = 3
K = 4

iota_T = matrix(1, nrow=T, ncol=1)
I_N = diag(N)

B = I_N %x% (iota_T %*% solve( t(iota_T) %*% iota_T) %*% t(iota_T))

X = matrix(
  c(rep(1,6),
    rep(3,3), rep(7,3),
    1:18),
  ncol=K+1
)

B %*% X


## Matriz de transformação within
I_NT = diag(N*T)
W = I_NT - B

round(W %*% X, 10)


### Estimação Between
## via plm()
library(plm)
data(TobinQ, package="pder")

pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# estimação between
Q.between = plm(ikn ~ qn, pTobinQ, model="between")
summary(Q.between)

## via lm()
library(dplyr)

TobinQ = TobinQ %>% group_by(cusip) %>%
  mutate(
    ikn_bar = mean(ikn),
    qn_bar = mean(qn)
  ) %>% ungroup()

# estimação MQO
Q.between.ols = lm(ikn_bar ~ qn_bar, TobinQ)
summary(Q.between.ols)$coef
summary(Q.between)$coef

N = 188
T = 35
K = 1
vcov.ols = vcov(Q.between.ols)
vcov.between = vcov(Q.between.ols) * (N*T - K - 1) / (N - K - 1)
se.between = sqrt(diag(vcov.between))


## Estimação Analítica
y = as.matrix(TobinQ[,"ikn"])
X = as.matrix(cbind(1, TobinQ[,"qn"]))
N = length(unique(TobinQ$cusip))
T = length(unique(TobinQ$year))
K = ncol(X) - 1

iota_T = matrix(1, ncol=1, nrow=T)
I_N = diag(N)
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))

bhat_B = solve(t(X) %*% B %*% X) %*% t(X) %*% B %*% y

yhat_B = X %*% bhat_B

ehat_B = y - yhat_B

sig2l = as.numeric((t(ehat_B) %*% B %*% ehat_B) / (N - K - 1))

Vbhat_B = sig2l * solve(t(X) %*% B %*% X)

se_B = sqrt(diag(Vbhat_B))
t_B = bhat_B / se_B
p_B = 2 * pt(-abs(t_B), N-K-1)

cbind(bhat_B, se_B, t_B, p_B)
summary(Q.between)$coef


# Estimação Analítica Between via MQO
X_til = B %*% X
y_til = B %*% y

bhat_ols = solve(t(X_til) %*% X_til) %*% t(X_til) %*% y_til

yhat_ols = X_til %*% bhat_ols
ehat_ols = y_til - yhat_ols

sig2hat = as.numeric((t(ehat_ols) %*% ehat_ols) / (N-K-1))
Vbhat_ols = sig2hat * solve(t(X_til) %*% X_til)

se_ols = sqrt(diag(Vbhat_ols))
t_ols = bhat_ols / se_ols
p_ols = 2 * pt(-abs(t_ols), N-K-1)

cbind(bhat_ols, se_ols, t_ols, p_ols)
summary(Q.between)$coef



