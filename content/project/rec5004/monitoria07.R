# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 7

## Resultados via lm()
reg = lm(mpg ~ hp, mtcars)
reg


## MINIMIZAÇÃO DA FUNÇÃO PERDA
theta = c(30, -.05)
fn_args = list("mpg", "hp", mtcars)

resid_quad = function(theta, fn_args) {
  b0 = theta[1]
  b1 = theta[2]

  yname = fn_args[[1]]
  xname = fn_args[[2]]
  dta = fn_args[[3]]

  y = dta[,yname]
  x = dta[,xname]

  yhat = b0 + b1*x
  ehat = y - yhat
  sum(ehat^2)
}

resid_quad(c(30, -.05), list("mpg", "hp", mtcars))

library(optimx)

min_loss = opm(c(0,0), resid_quad, fn_args=list("mpg", "hp", mtcars),
               method=c("Nelder-Mead","BFGS","nlminb"))
round(min_loss,4)
reg


## MÉTODO DOS MOMENTOS
theta = c(30, -.05)
fn_args = list("mpg", "hp", mtcars)

mom_ols1 = function(theta, fn_args) {
  b0 = theta[1]
  b1 = theta[2]

  yname = fn_args[[1]]
  xname = fn_args[[2]]
  dta = fn_args[[3]]

  y = dta[,yname]
  x = dta[,xname]

  yhat = b0 + b1*x
  ehat = y - yhat

  m1 = sum(ehat)^2
  m2 = sum(x*ehat)^2

  m1 + m2
}

mom_ols1(c(30, -.05), list("mpg", "hp", mtcars))

gmm1 = opm(c(0,0), mom_ols1,
           fn_args=list("mpg", "hp", mtcars),
           method=c("Nelder-Mead", "BFGS", "nlminb"))
round(gmm1, 4)
reg



## MÁXIMA VEROSSIMILHANÇA
theta = c(30, -.05, 2)
fn_args = list("mpg", "hp", mtcars)

loglik1 = function(theta, fn_args) {
  b0 = theta[1]
  b1 = theta[2]
  sighat = theta[3]

  yname = fn_args[[1]]
  xname = fn_args[[2]]
  dta = fn_args[[3]]

  y = dta[,yname]
  x = dta[,xname]

  yhat = b0 + b1*x
  log_ypdf = dnorm(y, mean=yhat, sd=sighat, log=TRUE)
  cbind(y, yhat, round(ypdf,4))

  -sum(log_ypdf)
}

mle1 = opm(c(0, 0, 10), loglik1,
           fn_args = list("mpg", "hp", mtcars),
           method=c("Nelder-Mead", "BFGS", "nlminb"))
round(mle1, 4)
reg





