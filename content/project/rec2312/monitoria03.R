# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 3 ##

## Exemplo 7.5
data(wage1, package="wooldridge")

# Estimação do modelo
reg_7.5 = lm(wage ~ female + educ + exper + expersq + tenure + tenursq,
             data=wage1)
summary(reg_7.5)
