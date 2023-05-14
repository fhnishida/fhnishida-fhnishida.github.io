# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 6

## Exemplo 2.3
data(ceosal1, package="wooldridge")
str(ceosal1)

cov(ceosal1$salary, ceosal1$roe)
cor(ceosal1$salary, ceosal1$roe)
var(ceosal1$roe)
mean(ceosal1$roe)
mean(ceosal1$salary)

b1hat = cov(ceosal1$salary, ceosal1$roe) / var(ceosal1$roe)
b0hat = mean(ceosal1$salary) - b1hat*mean(ceosal1$roe)

sal_hat = b0hat + b1hat*ceosal1$roe
ehat = ceosal1$salary - sal_hat

head(cbind(ceosal1$salary, sal_hat, ehat))

# via lm()
lm(ceosal1$salary ~ ceosal1$roe)
reg = lm(salary ~ roe, data=ceosal1)

names(reg)
reg$coef
coef(reg)
reg$resid
residuals(reg)


