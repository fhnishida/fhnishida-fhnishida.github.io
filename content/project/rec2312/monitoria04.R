# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 04

## Matriz de covariâncias dos erros

# Definindo variáveis
N = 2 # nº indivíduos
T = 3 # nº períodos
sig2u = 2 # variância termo de erro do indivíduo
sig2v = 3 # variância termo de erro idiossincrático

I_NT = diag(N*T)
I_N = diag(N)
iota_T = matrix(1, nrow=T, ncol=1)

termo1 = sig2v * I_NT

iota_T %*% solve( t(iota_T) %*% iota_T ) %*% t(iota_T)

B = I_N %x% ( iota_T %*% solve( t(iota_T) %*% iota_T ) %*% t(iota_T) )
B

termo2 = T * sig2u * B

Sigma = termo1 + termo2
Sigma
