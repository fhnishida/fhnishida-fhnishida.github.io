# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 3 ##

## Exemplo 7.5
data(wage1, package="wooldridge")

# Estimação do modelo
reg_7.5 = lm(wage ~ female + educ + exper + expersq + tenure + tenursq,
             data=wage1)
summary(reg_7.5)


## Variável com múltiplas categorias
# Exemplo Card & Krueger (1994)
card1994 = read.csv("https://fhnishida.netlify.app/project/rec2312/card1994.csv")
head(card1994)
str(card1994)

reg_errada = lm(diff_fte ~ nj + chain + hrsopen, data=card1994)
summary(reg_errada)


# Criando dummies de rede de fast food
card1994$bk = ifelse(card1994$chain==1, 1, 0)
card1994$kfc = ifelse(card1994$chain==2, 1, 0)
card1994$roys = ifelse(card1994$chain==3, 1, 0)
card1994$wendys = ifelse(card1994$chain==4, 1, 0)


# Estimação (não "omitindo" nenhuma dummy)
lm(diff_fte ~ nj + hrsopen + bk + kfc + roys + wendys, data=card1994)

lm(diff_fte ~ nj + hrsopen + bk + kfc + roys, data=card1994)

lm(diff_fte ~ nj + hrsopen + bk + roys + wendys, data=card1994)


# Estimando sem criar dummies das variáveis categóricas
str(card1994)
card1994$chain_txt = as.character(card1994$chain)

lm(diff_fte ~ nj + chain_txt + hrsopen, data=card1994)


card1994$chain_fct = factor(card1994$chain)
levels(card1994$chain_fct)

lm(diff_fte ~ nj + chain_fct + hrsopen, data=card1994)

card1994$chain_fct = relevel(card1994$chain_fct, ref="3")
lm(diff_fte ~ nj + chain_fct + hrsopen, data=card1994)


## Interações envolvendo dummies
reg_7.11 = lm(lwage ~ female + married + educ + exper + expersq +
                tenure + tenursq, data=wage1)
summary(reg_7.11)

# Com interação female*married
reg_7.14a = lm(lwage ~ female + married + female:married + educ +
                 exper + expersq + tenure + tenursq, data=wage1)
summary(reg_7.14a)

reg_7.14b = lm(lwage ~ female * married + educ +
                 exper + expersq + tenure + tenursq, data=wage1)
summary(reg_7.14b)


# Interação dummy variável contínua
reg_7.17 = lm(lwage ~ female * educ +
                 exper + expersq + tenure + tenursq, data=wage1)
summary(reg_7.17)


