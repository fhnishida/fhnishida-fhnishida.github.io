---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "GLS/WLS/FGLS"
summary: "Heteroskedasticity notes covering error variance matrices, Breusch-Pagan and White tests, robust standard errors, GLS, WLS, and feasible GLS in R."
title: "Heteroskedasticity, GLS, WLS, and FGLS"
weight: 10
output: md_document
type: book
---



- [Sections 8.2 and 8.3 of Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- Sections 5.5 and 7.1 to 7.4 of Davidson and MacKinnon (1999)
- Sections 4.2.3 and 4.2.4 of Wooldridge


## Error variance-covariance matrix

Recall that the error variance-covariance matrix is given by:

{{<math>}}$$ cov(\boldsymbol{\varepsilon}) = \underset{N \times N}{\boldsymbol{\Sigma}} = 
\left[ \begin{array}{cccc}
var(\varepsilon_{1}) & cov(\varepsilon_{1}, \varepsilon_{2}) & \cdots & cov(\varepsilon_{1}, \varepsilon_{N}) \\
cov(\varepsilon_{2}, \varepsilon_{1}) & var(\varepsilon_{2}) & \cdots & cov(\varepsilon_{2}, \varepsilon_{N}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{N}, \varepsilon_{1}) & cov(\varepsilon_{N}, \varepsilon_{2}) & \cdots & var(\varepsilon_{N}) 
\end{array} \right]$${{</math>}}

Because we assume random sampling, the covariance between two distinct individuals {{<math>}}$(i \neq j)${{</math>}} is  
{{<math>}}$$ cov(\varepsilon_{i}, \varepsilon_{j}) = 0,  \qquad \text{for all } i \neq j.$${{</math>}}

Therefore, 
{{<math>}}$$ \boldsymbol{\Sigma} = 
\left[ \begin{array}{cccc}
var(\varepsilon_{1}) & 0 & \cdots & 0 \\
0 & var(\varepsilon_{2}) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & var(\varepsilon_{N}) 
\end{array} \right]$${{</math>}}


Under OLS, we assume homoskedasticity, so the main diagonal is filled by a common {{<math>}}$ var(\varepsilon_i) = \sigma^2,\ \forall i${{</math>}}.
In the presence of **heteroskedasticity**, it follows that {{<math>}}$ var(\varepsilon_i) = \sigma^2_i,\ \forall i${{</math>}} and therefore:

{{<math>}}$$ \boldsymbol{\Sigma} = 
\left[ \begin{array}{cccc}
\sigma^2_1 & 0 & \cdots & 0 \\
0 & \sigma^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2_N 
\end{array} \right] \ \neq\ \sigma^2 I_N $${{</math>}}

Because this is a diagonal matrix, its inverse is straightforward to compute:

{{<math>}}$$ \boldsymbol{\Sigma}^{-1} = 
\left[ \begin{array}{cccc}
1/\sigma^2_1 & 0 & \cdots & 0 \\
0 & 1/\sigma^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1/\sigma^2_N 
\end{array} \right]$${{</math>}}
and
{{<math>}}$$\boldsymbol{\Sigma}^{-0.5} = 
\left[ \begin{array}{cccc}
1/\sigma_1 & 0 & \cdots & 0 \\
0 & 1/\sigma_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1/\sigma_N 
\end{array} \right]$${{</math>}}


<br>



## Heteroskedasticity Tests

- The idea behind heteroskedasticity tests is to take the OLS residuals, {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}, and check whether they are correlated with the explanatory variables, {{<math>}}$\boldsymbol{X}${{</math>}}. Under homoskedasticity, this correlation should be statistically zero.
- We can test this using either the Breusch-Pagan test or the White test.


### Breusch-Pagan Test

- First, consider the following linear model:
{{<math>}}$$\boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}_{1} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} $${{</math>}}
- After estimating it by OLS, we obtain the residuals
{{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}} = \boldsymbol{y} - \boldsymbol{X} \hat{\boldsymbol{\beta}}${{</math>}}
- Next, we regress the squared residuals on the covariates:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + \gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} = \boldsymbol{X} \boldsymbol{\gamma} + \boldsymbol{u} $${{</math>}}
- Breusch-Pagan (1979) and Koenker (1981) proposed testing the **joint** null hypothesis that all coefficients are equal to zero:
{{<math>}}$$H_0: \quad \boldsymbol{\gamma} = \boldsymbol{0} \iff \begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots \\ \gamma_K \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} $${{</math>}}

- This hypothesis can be evaluated using the LM statistic:

{{<math>}}$$ LM = N. R^2_{\scriptstyle{\hat{\varepsilon}}}\ \sim\ \chi^2_K $${{</math>}}


#### Example 8.7: Cigarette Demand (Wooldridge)
- In this section, we use the `smoke` dataset from the `wooldridge` package to estimate the following model:
{{<math>}}\begin{align}\text{cigs} = &\beta_0 + \beta_1 \text{lincome} + \beta_2 \text{lcigpric} + \beta_3 \text{educ} + \beta_4 \text{age}\\ &+ \beta_5 \text{agesq} + \beta_6 \text{restaurn} + \varepsilon \end{align}{{</math>}}
where:

- _cigs_: cigarettes smoked per day
- _lincome_: log income
- _lcigpric_: log cigarette price
- _educ_: years of schooling
- _age_: age
- _agesq_: age squared
- _restaurn_: indicator for whether restaurants have smoking restrictions


```r
library(lmtest) # needs to be installed
data(smoke, package="wooldridge")

# Estimate the model
reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke)
bptest(reg)
```

```
## 
## 	studentized Breusch-Pagan test
## 
## data:  reg
## BP = 32.258, df = 6, p-value = 1.456e-05
```

```r
# Manual BP test
N = nrow(smoke)
K = ncol(model.matrix(reg)) - 1

reg.resid = lm(resid(reg)^2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
               data=smoke)
r2e = summary(reg.resid)$r.squared
LM = N * r2e
1 - pchisq(LM, K)
```

```
## [1] 1.455779e-05
```

- Alternatively, the test can also be computed using the F statistic (or, equivalently, a Wald test):
{{<math>}}$$ F_{\scriptscriptstyle{K, (N-K-1)}} = \frac{R^2_{\scriptstyle{\hat{\varepsilon}}}/K}{(1 - R^2_{\scriptstyle{\hat{\varepsilon}}}) / (N-K-1)} $${{</math>}}


```r
# The F test is already reported by summary(lm())
summary(reg.resid)
```

```
## 
## Call:
## lm(formula = resid(reg)^2 ~ lincome + lcigpric + educ + age + 
##     agesq + restaurn, data = smoke)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -270.1 -127.5  -94.0  -39.1 4667.8 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -636.30306  652.49456  -0.975   0.3298    
## lincome       24.63848   19.72180   1.249   0.2119    
## lcigpric      60.97655  156.44869   0.390   0.6968    
## educ          -2.38423    4.52753  -0.527   0.5986    
## age           19.41748    4.33907   4.475 8.75e-06 ***
## agesq         -0.21479    0.04723  -4.547 6.27e-06 ***
## restaurn     -71.18138   30.12789  -2.363   0.0184 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 363.2 on 800 degrees of freedom
## Multiple R-squared:  0.03997,	Adjusted R-squared:  0.03277 
## F-statistic: 5.552 on 6 and 800 DF,  p-value: 1.189e-05
```

```r
# Manual F test
F = (r2e / K) / ((1-r2e) / (N-K-1))
F
```

```
## [1] 5.551687
```

```r
1 - pf(F, K, N-K-1)
```

```
## [1] 1.188811e-05
```

- Note that these tests detect whether heteroskedasticity is present, but they do not identify which variables are driving it.
- For that reason, it is often useful to inspect the individual t tests from the auxiliary regression of squared residuals. In this example, the evidence points to _age_, _agesq_, and _restaurn_.



### White Test

- Although the Breusch-Pagan test is useful, it only evaluates the errors as a linear function of the explanatory variables:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + \gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u}$${{</math>}}
- To capture richer forms of heteroskedasticity, it is useful to include **regressor interactions and squared terms** in the auxiliary regression:
{{<math>}}\begin{align} \hat{\boldsymbol{\varepsilon}}^2 = & \alpha + {\color{blue}\gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K}} + {\color{red}\delta_{11} \boldsymbol{x}^2_{1} + \delta_{12} (\boldsymbol{x}_{1}\boldsymbol{x}_{2}) + ... + \delta_{1K} (\boldsymbol{x}_{1}\boldsymbol{x}_{K})}\\
& {\color{red}+ \delta_{22} \boldsymbol{x}^2_{2} + \delta_{23} (\boldsymbol{x}_{2}\boldsymbol{x}_{3}) + ... + \delta_{KK}\boldsymbol{x}^2_{K}} + \boldsymbol{u} \end{align}{{</math>}}
- The corresponding hypothesis test is then:
{{<math>}}$$H_0: \quad \begin{bmatrix}\boldsymbol{\gamma} \\ \boldsymbol{\delta} \end{bmatrix} = \boldsymbol{0} \iff \begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots \\ \gamma_K \\ \delta_{11} \\ \delta_{12} \\ \vdots \\ \delta_{KK} \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \\ 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} $${{</math>}}
- The problem is that we lose many degrees of freedom when we include all interaction and squared terms explicitly.
- White (1980) showed that an equivalent test can be implemented by including only {{<math>}}$\hat{\boldsymbol{y}}${{</math>}} and {{<math>}}$\hat{\boldsymbol{y}}^2${{</math>}} as regressors in the squared-residual regression:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + {\color{blue}\gamma \hat{\boldsymbol{y}}} + {\color{red}\delta \hat{\boldsymbol{y}}^2} + \boldsymbol{u}$${{</math>}}
- The hypothesis test then becomes simply
{{<math>}}$$H_0: \quad \begin{bmatrix}\gamma \\ \delta \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} $${{</math>}}
which can again be tested using either the LM (Breusch-Pagan) or F statistic.


```r
# Fitted values
yhat = fitted(reg)

# Test via bptest()
bptest(reg, ~ yhat + I(yhat^2))
```

```
## 
## 	studentized Breusch-Pagan test
## 
## data:  reg
## BP = 26.573, df = 2, p-value = 1.698e-06
```

```r
# Manual BP/LM test
reg.resid = lm(resid(reg)^2 ~ yhat + I(yhat^2), data=smoke)
r2e = summary(reg.resid)$r.squared
LM = N * r2e
1 - pchisq(LM, 2)
```

```
## [1] 1.697606e-06
```



<br>


## OLS with Heteroskedasticity-Robust Standard Errors

- The OLS estimator remains unbiased and consistent under heteroskedasticity, but it is no longer efficient.
- One way to deal with this problem is to model the **error** variance-covariance matrix {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- First, recall that the variance-covariance matrix of the **OLS estimator** is given by
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}
- Under heteroskedasticity, this matrix does not simplify to {{<math>}}$V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}) = \sigma^2 (\boldsymbol{X}' \boldsymbol{X})^{-1}${{</math>}}. At the same time, {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is unknown and must be estimated.
- The simplest way to obtain {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}, suggested by White (1980), is to fill its diagonal with the squared OLS residual for each individual:
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = \begin{bmatrix}
\hat{\varepsilon}^2_1 & 0 & \cdots & 0 \\
0 & \hat{\varepsilon}^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \hat{\varepsilon}^2_N \end{bmatrix}$${{</math>}}
- Therefore, we obtain the heteroskedasticity-consistent covariance matrix estimator (HCCME)
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}
which is also known as the sandwich estimator, because {{<math>}}$(\boldsymbol{X}' \boldsymbol{X})^{-1}${{</math>}} appears on both ends of the formula (the _bread_), sandwiching the term {{<math>}}$\boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X}${{</math>}} (the _meat_).

### Estimation via lm() and vcovHC()


```r
# Using vcovHC() from the sandwich package
library(lmtest)
library(sandwich) # needs to be installed

# Estimate the model
reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke)

# Build the heteroskedasticity-adjusted covariance matrix
vcov_sandwich = vcovHC(reg, type="HC0")
round(vcov_sandwich, 3)
```

```
##             (Intercept) lincome lcigpric   educ    age  agesq restaurn
## (Intercept)     650.511  -2.642 -149.814 -0.240 -0.489  0.005    3.823
## lincome          -2.642   0.352    0.009 -0.029 -0.019  0.000   -0.077
## lcigpric       -149.814   0.009   36.110  0.048  0.078 -0.001   -0.783
## educ             -0.240  -0.029    0.048  0.026 -0.001  0.000   -0.012
## age              -0.489  -0.019    0.078 -0.001  0.019  0.000   -0.002
## agesq             0.005   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn          3.823  -0.077   -0.783 -0.012 -0.002  0.000    1.007
```

```r
# Results
round(coeftest(reg), 3) # standard OLS output
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     24.079  -0.151    0.880    
## lincome        0.880      0.728   1.210    0.227    
## lcigpric      -0.751      5.773  -0.130    0.897    
## educ          -0.501      0.167  -3.002    0.003 ** 
## age            0.771      0.160   4.813   <2e-16 ***
## agesq         -0.009      0.002  -5.176   <2e-16 ***
## restaurn      -2.825      1.112  -2.541    0.011 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
round(coeftest(reg, vcov=vcov_sandwich), 3) # results with the correction
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     25.505  -0.143    0.887    
## lincome        0.880      0.593   1.483    0.138    
## lcigpric      -0.751      6.009  -0.125    0.901    
## educ          -0.501      0.162  -3.102    0.002 ** 
## age            0.771      0.138   5.598   <2e-16 ***
## agesq         -0.009      0.001  -6.198   <2e-16 ***
## restaurn      -2.825      1.004  -2.815    0.005 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

- Note that, in this example, the standard errors change only modestly after the correction.
- To gain efficiency, {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}} must be well specified. The `vcovHC()` function also offers alternative ways of modeling {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}.


### Analytical Estimation
- We can also carry out heteroskedasticity-robust inference analytically:


```r
# Create the y vector
y = as.matrix(smoke[,"cigs"]) # convert the data-frame column to a matrix

# Create the covariate matrix X with a leading column of ones
X = as.matrix( cbind(1, smoke[,c("lincome", "lcigpric", "educ", "age", "agesq",
                                 "restaurn")]) ) # bind the column of ones to x

# Store the values of N and K
N = nrow(X)
K = ncol(X) - 1

# OLS estimates, fitted values, and residuals
bhat = solve(t(X) %*% X) %*% t(X) %*% y
yhat = X %*% bhat
ehat = y - yhat
head(ehat^2)
```

```
##         [,1]
## 1 106.770712
## 2 115.665513
## 3  59.596771
## 4 105.280775
## 5  56.312306
## 6   5.950747
```

- We now estimate the error variance-covariance matrix using White's method, filling the diagonal with the squared residual for each individual:
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = diag(\hat{\varepsilon}_1, \hat{\varepsilon}_2, ..., \hat{\varepsilon}_N)  = \begin{bmatrix}
\hat{\varepsilon}^2_1 & 0 & \cdots & 0 \\
0 & \hat{\varepsilon}^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \hat{\varepsilon}^2_N \end{bmatrix}$${{</math>}}


```r
# Estimate the error vcov matrix (diagonal filled with each residual squared)
Sigma = diag(as.numeric(ehat^2)) # convert to numeric before filling the diagonal
round(Sigma[1:7, 1:7], 3)
```

```
##         [,1]    [,2]   [,3]    [,4]   [,5]  [,6]    [,7]
## [1,] 106.771   0.000  0.000   0.000  0.000 0.000   0.000
## [2,]   0.000 115.666  0.000   0.000  0.000 0.000   0.000
## [3,]   0.000   0.000 59.597   0.000  0.000 0.000   0.000
## [4,]   0.000   0.000  0.000 105.281  0.000 0.000   0.000
## [5,]   0.000   0.000  0.000   0.000 56.312 0.000   0.000
## [6,]   0.000   0.000  0.000   0.000  0.000 5.951   0.000
## [7,]   0.000   0.000  0.000   0.000  0.000 0.000 142.419
```
- Note that `ehat^2` must be converted to numeric in order to apply `diag()`. Otherwise, R would return a scalar instead of building a diagonal matrix filled with squared residuals.
- Now we can estimate the heteroskedasticity-robust variance-covariance matrix of the estimator:
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}


```r
# Variance-covariance matrix of the estimator
bread = solve(t(X) %*% X)
meat = t(X) %*% Sigma %*% X
Vbhat = bread %*% meat %*% bread
round(Vbhat, 3)
```

```
##                 1 lincome lcigpric   educ    age  agesq restaurn
## 1         650.511  -2.642 -149.814 -0.240 -0.489  0.005    3.823
## lincome    -2.642   0.352    0.009 -0.029 -0.019  0.000   -0.077
## lcigpric -149.814   0.009   36.110  0.048  0.078 -0.001   -0.783
## educ       -0.240  -0.029    0.048  0.026 -0.001  0.000   -0.012
## age        -0.489  -0.019    0.078 -0.001  0.019  0.000   -0.002
## agesq       0.005   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn    3.823  -0.077   -0.783 -0.012 -0.002  0.000    1.007
```
- We only need to compute the standard errors, t statistics, and p-values:

```r
# Robust standard errors, t statistics, and p-values
se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Results
round(data.frame(bhat, se, t, p), 3) # analytical results
```

```
##            bhat     se      t     p
## 1        -3.640 25.505 -0.143 0.887
## lincome   0.880  0.593  1.483 0.138
## lcigpric -0.751  6.009 -0.125 0.901
## educ     -0.501  0.162 -3.102 0.002
## age       0.771  0.138  5.598 0.000
## agesq    -0.009  0.001 -6.198 0.000
## restaurn -2.825  1.004 -2.815 0.005
```

```r
round(coeftest(reg, vcov=vcov_sandwich), 3) # obtained using the built-in functions
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     25.505  -0.143    0.887    
## lincome        0.880      0.593   1.483    0.138    
## lcigpric      -0.751      6.009  -0.125    0.901    
## educ          -0.501      0.162  -3.102    0.002 ** 
## age            0.771      0.138   5.598   <2e-16 ***
## agesq         -0.009      0.001  -6.198   <2e-16 ***
## restaurn      -2.825      1.004  -2.815    0.005 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



<br>

## GLS Estimator

- Alternatively, we can perform estimation and inference by modeling the error variance-covariance matrix, {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- The Generalized Least Squares (GLS) estimator, assuming cross-sectional data, is given by
{{<math>}}$$ {\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{GLS}} = (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) $${{</math>}}

- The variance-covariance matrix of the estimator is given by
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} $${{</math>}}

- The problem is that {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is unknown, so we need additional assumptions about the structure of the error variance-covariance matrix (and its inverse) in order to estimate {{<math>}}$\boldsymbol{\hat{\Sigma}}${{</math>}}.



<br>

## WLS Estimator

- [Section 4.1 of Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- [Weighted Least Squares (Yibi Huang)](https://www.stat.uchicago.edu/~yibi/teaching/stat224/L14.pdf)

- A special case of GLS is the Weighted Least Squares (WLS) estimator, which assumes that each observation's error variance is known up to proportionality.
- The individual error variance is modeled as a function of the explanatory variables, {{<math>}}$h(\boldsymbol{x}'_i)${{</math>}}:
{{<math>}}$$ Var(\varepsilon_i | \boldsymbol{x}'_i) = \sigma^2.h(\boldsymbol{x}'_i), $${{</math>}}
that is,
{{<math>}}\begin{align} \boldsymbol{\Sigma} &= 
\left[ \begin{array}{cccc}
\sigma^2 h(\boldsymbol{x}'_1) & 0 & \cdots & 0 \\
0 & \sigma^2 h(\boldsymbol{x}'_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2 h(\boldsymbol{x}'_1) 
\end{array} \right] \\
&= \sigma^2 \left[ \begin{array}{cccc}
h(\boldsymbol{x}'_1) & 0 & \cdots & 0 \\
0 & h(\boldsymbol{x}'_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & h(\boldsymbol{x}'_N) 
\end{array} \right] \\
&\equiv \sigma^2 \boldsymbol{W}^{-1}
\end{align}{{</math>}}
where {{<math>}}$\boldsymbol{W}${{</math>}} is a weight matrix:
{{<math>}}$$ \boldsymbol{W} = \left[ \begin{array}{cccc}
\frac{1}{h(\boldsymbol{x}'_1)} & 0 & \cdots & 0 \\
0 & \frac{1}{h(\boldsymbol{x}'_2)} & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \frac{1}{h(\boldsymbol{x}'_N)}
\end{array} \right] \equiv \left[ \begin{array}{cccc}
w_1 & 0 & \cdots & 0 \\
0 & w_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & w_N
\end{array} \right] $${{</math>}}
where {{<math>}}$w_i${{</math>}} are the estimation weights.

<br>

- For example, suppose the error variance for women is twice the error variance for men ({{<math>}}$\sigma^2_M = 2.\sigma^2_H ${{</math>}}). Then:
{{<math>}}$$ h(\text{female}_i) = \left\{ \begin{matrix} 
2, &\text{if female}_i = 1 \\
1, &\text{if female}_i = 0
\end{matrix} \right. $${{</math>}}

- If the first {{<math>}}$M${{</math>}} rows correspond to women, the error variance-covariance matrix can be simplified to:
{{<math>}}\begin{align} \boldsymbol{\Sigma} &= 
\left[ \begin{array}{cccc}
\sigma^2_M & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \sigma^2_M & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2_H & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2_H \\
\end{array} \right] \\
&= \left[ \begin{array}{cccc}
2\sigma^2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2\sigma^2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2 \\
\end{array} \right] \\ 
&= \left[ \begin{array}{cccc}
2\sigma^2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2\sigma^2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2 \\
\end{array} \right] \\
&= \sigma^2 \left[ \begin{array}{cccc}
2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & 1 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & 1 \\
\end{array} \right] 
\end{align}{{</math>}}


- Because this matrix is diagonal, the following matrices are easy to compute:
{{<math>}}$$ \boldsymbol{\Sigma}^{-1} = 
\frac{1}{\sigma^2} \left[ \begin{array}{cccc}
\frac{1}{2} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{2} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{1} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{1} \\
\end{array} \right] \equiv 
\frac{1}{\sigma^2} \boldsymbol{W}, $${{</math>}}
and
{{<math>}}$$ \boldsymbol{\Sigma}^{-0.5} = 
\frac{1}{\sigma} \left[ \begin{array}{cccc}
\frac{1}{\sqrt{2}} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{\sqrt{2}} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{\sqrt{1}} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{\sqrt{1}} \\
\end{array} \right] \equiv 
\frac{1}{\sigma} \boldsymbol{W}^{0.5} $${{</math>}}


<br>

- From this, we obtain the {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}${{</math>}} estimator:

{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}} &= (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) \\
&= \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{y} \right) \\
&= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \frac{1}{\sigma^2} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}
\end{align}{{</math>}}


- The variance-covariance matrix of the WLS estimator is given by

{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}}) &= \left(\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X} \right)^{-1} \\
&= \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} = V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}) \end{align}{{</math>}}


<!-- To compute {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}${{</math>}}, we need an estimate of {{<math>}}$\sigma^2${{</math>}}. However, the error variance is itself estimated from residuals, {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}, which in turn depend on {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}}. -->

- The error variance, {{<math>}}$\sigma^2${{</math>}}, can be estimated by
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


<br>

- We can also transform the variables and solve by OLS, pre-multiplying {{<math>}}$\boldsymbol{X}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$ \boldsymbol{W}^{0.5}${{</math>}}, and defining:
{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{y}$${{</math>}}

- In the example where the variance for women is twice the variance for men, we have:
{{<math>}}\begin{align} \boldsymbol{W}^{0.5} \boldsymbol{y} &= \begin{bmatrix}
2^{0.5} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2^{0.5} & 0 & \cdots & 0 \\
0 & \cdots & 0 & 1^{0.5} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & 1^{0.5} \\
\end{bmatrix} \begin{bmatrix} y_1 \\ \vdots \\ y_M \\ y_{M+1} \\ \vdots \\ y_N \end{bmatrix}\\
&= \begin{bmatrix}
\frac{1}{\sqrt{2}} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{\sqrt{2}} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{\sqrt{1}} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{\sqrt{1}} \\
\end{bmatrix} \begin{bmatrix}  y_1 \\ \vdots \\ y_M \\ y_{M+1} \\ \vdots \\ y_N \end{bmatrix} \\
&= \begin{bmatrix} \frac{1}{\sqrt{2}} y_1 \\ \vdots \\ \frac{1}{\sqrt{2}}  y_M \\ \frac{1}{\sqrt{1}}  y_{M+1} \\ \vdots \\ \frac{1}{\sqrt{1}} y_N \end{bmatrix} \end{align}{{</math>}}
where {{<math>}}$M${{</math>}} is the number of women in the sample.

- Note that {{<math>}}$\boldsymbol{y}${{</math>}} and {{<math>}}$\boldsymbol{X}${{</math>}} are multiplied by the inverse square root of their corresponding weights when we pre-multiply them by {{<math>}}$\boldsymbol{W}${{</math>}}.


- Note also that the estimators are equivalent:
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}} &= \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' \boldsymbol{W}^{0.5} \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W}^{0.5} \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= \left( \left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} ) \equiv \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} \end{align}{{</math>}}
e
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}) &= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}} \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
V(\tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}}) &= \sigma^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1}
\end{align}{{</math>}}

where we use {{<math>}}$\boldsymbol{W}^{0.5} = {\boldsymbol{W}^{0.5}}^{\prime}${{</math>}} (a symmetric matrix).



### Estimation via `lm()`

- Here we use an example similar to the one simulated in an earlier section, since it is hard to find a case where the exact form of heteroskedasticity is known a priori.
- We generate observations from the following data-generating process with heteroskedasticity:
{{<math>}}$$ y = \tilde{\beta}_0 + \tilde{\beta}_1 x + \tilde{\varepsilon}, \qquad \tilde{\varepsilon} \sim N(0, (10x)^2) $${{</math>}}
therefore
{{<math>}}$$ Var(\tilde{\varepsilon}_i | x_i) = \sigma^2 (10x_i)^2 \quad \implies\quad sd(\tilde{\varepsilon}_i | x_i) = \sigma (10x_i) $${{</math>}}
- To estimate WLS with `lm()`, we need to provide the weights in the `weights` argument.


```r
# Set the parameters
b0til = 50
b1til = -5
N = 100

# Generate x and y by simulation
set.seed(123)
x = runif(N, 1, 9) # generate 100 observations of x
e_til = rnorm(N, 0, 10*x) # errors: 100 observations with mean 0 and sd 10x
y = b0til + b1til*x + e_til # compute y observations
plot(x, y)
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-9-1.png" width="672" />

- Now let us estimate by OLS and WLS the following empirical model:
{{<math>}}$$ y = \beta_0 + \beta_1 x + \varepsilon $${{</math>}}


```r
# Estimation
reg.ols = lm(y ~ x) # OLS estimation
reg.wls = lm(y ~ x, weights=1/(10*x)^2) # WLS estimation
stargazer::stargazer(reg.ols, reg.wls, digits=2, type="text", omit.stat="f")
```

```
## 
## ==========================================================
##                                   Dependent variable:     
##                               ----------------------------
##                                            y              
##                                    (1)            (2)     
## ----------------------------------------------------------
## x                                -5.51**       -5.92***   
##                                   (2.35)        (1.77)    
##                                                           
## Constant                         49.27***      51.43***   
##                                  (12.87)        (5.50)    
##                                                           
## ----------------------------------------------------------
## Observations                       100            100     
## R2                                 0.05          0.10     
## Adjusted R2                        0.04          0.09     
## Residual Std. Error (df = 98)     53.30          0.97     
## ==========================================================
## Note:                          *p<0.1; **p<0.05; ***p<0.01
```

- WLS is more efficient here, producing smaller standard errors because **we already know that the error variance is proportional to _x_**.
- In practice, it is difficult to know or justify the exact form of heteroskedasticity because we do not observe the true variance model.
- Below we estimate the model with incorrect weights, {{<math>}}$ Var(\tilde{\varepsilon}_i | x_i) = \sigma^2 \left(\frac{1}{10 x_i}\right)^2${{</math>}}. Note that this even affects the coefficient estimates, in addition to worsening the standard errors:

```r
# Estimation
reg.wls2 = lm(y ~ x, weights=x^2) # WLS estimation
stargazer::stargazer(reg.ols, reg.wls, reg.wls2, digits=2, type="text", omit.stat="f")
```

```
## 
## ===========================================================
##                                    Dependent variable:     
##                               -----------------------------
##                                             y              
##                                  (1)        (2)      (3)   
## -----------------------------------------------------------
## x                              -5.51**   -5.92***   -2.60  
##                                 (2.35)    (1.77)    (3.88) 
##                                                            
## Constant                       49.27***  51.43***   30.54  
##                                (12.87)    (5.50)   (26.90) 
##                                                            
## -----------------------------------------------------------
## Observations                     100        100      100   
## R2                               0.05      0.10     0.005  
## Adjusted R2                      0.04      0.09     -0.01  
## Residual Std. Error (df = 98)   53.30      0.97     368.51 
## ===========================================================
## Note:                           *p<0.1; **p<0.05; ***p<0.01
```


<!-- - Vamos continuar com a base de dados de cigarros -->
<!-- Here, we would continue with the cigarette dataset. -->
<!-- {{<math>}}$$ Var(\varepsilon_i | \text{age}_i) = \sigma^2 (\text{age}_i + \text{age}^2_i)$${{</math>}} -->
<!-- Here, we would assume a specific form for the error variance. -->

<!-- ```{r warning=FALSE} -->
<!-- data(smoke, package="wooldridge") -->

<!-- Estimate the model. -->
<!-- reg.ols = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke) -->
<!-- reg.wls = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, -->
<!--              weights=1/(age + agesq), data=smoke) -->

<!-- stargazer::stargazer(reg.ols, reg.wls, digits=4, type="text") -->
<!-- ``` -->



### Analytical Estimation

**a)** Create the vectors/matrices and define _N_ and _K_

```r
# Create the y vector
y = as.matrix(y) # convert the data-frame column to a matrix

# Create the covariate matrix X with a leading column of ones
X = as.matrix( cbind(1, x) ) # bind the column of ones to x

# Store the values of N and K
N = nrow(X)
K = ncol(X) - 1
```


**b)** Weight matrix {{<math>}}$\boldsymbol{W}${{</math>}}

- This is the matrix whose main diagonal is filled with the weights, {{<math>}}$w_i = 1/x^2_i${{</math>}} 


```r
W = diag(1/x^2)
round(W[1:10,1:10], 2)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,] 0.09 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [2,] 0.00 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [3,] 0.00 0.00 0.05 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [4,] 0.00 0.00 0.00 0.02 0.00 0.00 0.00 0.00 0.00  0.00
##  [5,] 0.00 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00  0.00
##  [6,] 0.00 0.00 0.00 0.00 0.00 0.54 0.00 0.00 0.00  0.00
##  [7,] 0.00 0.00 0.00 0.00 0.00 0.00 0.04 0.00 0.00  0.00
##  [8,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.00  0.00
##  [9,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.03  0.00
## [10,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.05
```

**c)** WLS estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}} = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} $${{</math>}}


```r
bhat_wls = solve( t(X) %*% W %*% X ) %*% t(X) %*% W %*% y
bhat_wls
```

```
##        [,1]
##   51.433290
## x -5.923353
```

**d)** Fitted values {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{WLS}}${{</math>}}

```r
yhat_wls = X %*% bhat_wls
head(yhat_wls)
```

```
##            [,1]
## [1,] 31.8825514
## [2,]  8.1546597
## [3,] 26.1298192
## [4,]  3.6665460
## [5,]  0.9441786
## [6,] 43.3511590
```


**e)** Residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{WLS}}${{</math>}}

```r
ehat_wls = y - yhat_wls
head(ehat_wls)
```

```
##             [,1]
## [1,]   9.9754298
## [2,]   3.2273830
## [3,]   0.6797571
## [4,] 116.3787515
## [5,] -12.8069979
## [6,]  20.5180944
```

**f)** Error variance estimate {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{WLS}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat_wls = as.numeric( t(ehat_wls) %*% W %*% ehat_wls / (N-K-1) )
sig2hat_wls
```

```
## [1] 93.95364
```

**h)** Variance-Covariance Matrix of the Estimator

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{WLS}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} $${{</math>}}


```r
Vbhat_wls = sig2hat_wls * solve( t(X) %*% W %*% X )
round(Vbhat_wls, 3)
```

```
##               x
##   30.248 -8.144
## x -8.144  3.132
```


**i)** Standard Errors, t Statistics, and p-values

```r
se_wls = sqrt( diag(Vbhat_wls) )
t_wls = bhat_wls / se_wls
p_wls = 2 * pt(-abs(t_wls), N-K-1)

# Results
data.frame(bhat_wls, se_wls, t_wls, p_wls) # WLS results
```

```
##    bhat_wls   se_wls     t_wls        p_wls
##   51.433290 5.499861  9.351743 3.090884e-15
## x -5.923353 1.769796 -3.346913 1.159943e-03
```

```r
summary(reg.wls)$coef # WLS results via lm()
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 51.433290   5.499861  9.351743 3.090884e-15
## x           -5.923353   1.769796 -3.346913 1.159943e-03
```



#### Transforming and Estimating by OLS
- We can now transform the variables and solve by OLS, pre-multiplying {{<math>}}$\boldsymbol{X}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$ \boldsymbol{W}^{0.5}${{</math>}}, and defining:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{y}$${{</math>}}


**b')** Weight matrix {{<math>}}$\boldsymbol{W}^{0.5}${{</math>}}

- This is the matrix whose main diagonal is filled with the square roots of the weights.


```r
W_0.5 = diag(1/(10*x))
round(W_0.5[1:10,1:10], 2)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,] 0.03 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [2,] 0.00 0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [3,] 0.00 0.00 0.02 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [4,] 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00 0.00  0.00
##  [5,] 0.00 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00  0.00
##  [6,] 0.00 0.00 0.00 0.00 0.00 0.07 0.00 0.00 0.00  0.00
##  [7,] 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.00 0.00  0.00
##  [8,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.01 0.00  0.00
##  [9,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02  0.00
## [10,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.02
```

**b'')** Transformed variables {{<math>}}$\tilde{\boldsymbol{y}}${{</math>}} and {{<math>}}$\tilde{\boldsymbol{X}}${{</math>}}

```r
ytil = W_0.5 %*% y
Xtil = W_0.5 %*% X
# Plots
plot(x, ytil, ylim=c(-125,175), 
     main=expression(paste("Plot ", x ," \u00D7 ", tilde(y))),
     xlab=expression(x), ylab=expression(tilde(y))) # plot x_tilde and y_tilde
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-21-1.png" width="672" />

```r
plot(x, y, ylim=c(-125,175), 
     main=expression(paste("Plot ", x ," \u00D7 ", y)),
     xlab=expression(x), ylab=expression(y)) # plot x and y
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-21-2.png" width="672" />


**c')** OLS estimates {{<math>}}$\tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}}${{</math>}}

{{<math>}}$$ \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} = (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}


```r
bhat_ols = solve( t(Xtil) %*% Xtil ) %*% t(Xtil) %*% ytil
bhat_ols
```

```
##        [,1]
##   51.433290
## x -5.923353
```

**d')** Fitted values {{<math>}}$\tilde{\hat{\boldsymbol{y}}}_{\scriptscriptstyle{OLS}}${{</math>}}

```r
yhat_ols = Xtil %*% bhat_ols
head(yhat_ols)
```

```
##            [,1]
## [1,] 0.96595639
## [2,] 0.11160919
## [3,] 0.61167951
## [4,] 0.04546730
## [5,] 0.01107705
## [6,] 3.17718463
```


**e')** Residuals {{<math>}}$\tilde{\hat{\boldsymbol{\varepsilon}}}_{\scriptscriptstyle{OLS}}${{</math>}}

```r
ehat_ols = ytil - yhat_ols
head(ehat_ols)
```

```
##             [,1]
## [1,]  0.30222895
## [2,]  0.04417175
## [3,]  0.01591261
## [4,]  1.44316397
## [5,] -0.15025095
## [6,]  1.50376081
```

**f')** Error variance estimate {{<math>}}$\tilde{\hat{\sigma}}^2_{\scriptscriptstyle{OLS}}${{</math>}}
{{<math>}}$$\tilde{\hat{\sigma}}^2 =  \frac{\tilde{\hat{\boldsymbol{\varepsilon}}}' \tilde{\hat{\boldsymbol{\varepsilon}}}}{N - K - 1} $${{</math>}}


```r
sig2hat_ols = as.numeric( t(ehat_ols) %*% ehat_ols / (N-K-1) )
sig2hat_ols
```

```
## [1] 0.9395364
```

**h')** Variance-Covariance Matrix of the Estimator

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}) = \tilde{\hat{\sigma}}^2(\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
Vbhat_ols = sig2hat_ols * solve( t(Xtil) %*% Xtil )
round(Vbhat_ols, 3)
```

```
##               x
##   30.248 -8.144
## x -8.144  3.132
```


**i')** Standard Errors, t Statistics, and p-values

```r
se_ols = sqrt( diag(Vbhat_ols) )
t_ols = bhat_ols / se_ols
p_ols = 2 * pt(-abs(t_ols), N-K-1)

# Results
data.frame(bhat_ols, se_ols, t_ols, p_ols) # transformed OLS results
```

```
##    bhat_ols   se_ols     t_ols        p_ols
##   51.433290 5.499861  9.351743 3.090884e-15
## x -5.923353 1.769796 -3.346913 1.159943e-03
```

```r
summary(reg.wls)$coef # WLS results via lm()
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 51.433290   5.499861  9.351743 3.090884e-15
## x           -5.923353   1.769796 -3.346913 1.159943e-03
```


<br>

## FGLS Estimator

- In practice, it is difficult to know the error variance-covariance matrix a priori.
- A reasonable approach is to assume that {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is a function of unknown parameters from a linear model, collected in {{<math>}}$\boldsymbol{\gamma}${{</math>}}.
- We can then estimate {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}} from OLS residuals and use it to construct {{<math>}}$\boldsymbol{\Sigma}(\hat{\boldsymbol{\gamma}})${{</math>}}.
- This procedure is known as Feasible Generalized Least Squares (FGLS), because its calculation is feasible even when GLS itself is not.

- Note that if {{<math>}}$\boldsymbol{\Sigma}(\hat{\boldsymbol{\gamma}})${{</math>}} is a poor approximation to {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, then the resulting FGLS estimates and inference may perform poorly.


<br>

- We want to estimate the model
{{<math>}}$$y_i = \beta_0 + \beta_1 x_{i1} + ... + \beta_K x_{iK} + \varepsilon_i = \boldsymbol{x}'_i \boldsymbol{\beta} + \varepsilon_i, \tag{1} $${{</math>}}
while the individual error variance is typically assumed to be given by:
{{<math>}}$$Var(\varepsilon_i | \boldsymbol{x}'_i) = \sigma^2 \exp(\boldsymbol{x}'_i \boldsymbol{\gamma}). $${{</math>}}

- The function {{<math>}}$\exp(\boldsymbol{x}'_i \boldsymbol{\gamma})${{</math>}} is an example of a _skedastic_ function, ensuring that the fitted value is never negative after estimating {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}} and thus keeping the variance positive for every individual.

- To estimate {{<math>}}$\boldsymbol{\gamma}${{</math>}}, we need consistent estimates of {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}. The usual starting point is to compute {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}${{</math>}}.
- Next, we run the auxiliary linear regression
{{<math>}}$$ \log{\hat{\varepsilon}}^2_i = \boldsymbol{x}'_i \boldsymbol{\gamma} + u_i, \tag{2} $${{</math>}}
- From that estimation, we use the fitted values to compute
{{<math>}}$$h(\boldsymbol{x}'_i) = \exp(\boldsymbol{x}'_i \boldsymbol{\gamma})$${{</math>}}
which is the inverse of the weight
{{<math>}}$$w_i = \frac{1}{h(\boldsymbol{x}'_i)} = \frac{1}{\exp(\boldsymbol{x}'_i \boldsymbol{\gamma})}$${{</math>}}

- With the estimated {{<math>}}$\boldsymbol{W}${{</math>}}, we can compute {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}} and {{<math>}}$V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}})${{</math>}}, following the same steps as for WLS.
- We can then use the estimated {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}} to estimate a new {{<math>}}$\boldsymbol{\gamma}${{</math>}} and a new {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}}. This can be iterated until convergence (if it occurs) or for a fixed number of iterations.


### Estimation via lm()


```r
data(smoke, package="wooldridge")

# OLS estimation
reg.ols = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
             data=smoke)
round(summary(reg.ols)$coef, 4)
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  -3.6398    24.0787 -0.1512   0.8799
## lincome       0.8803     0.7278  1.2095   0.2268
## lcigpric     -0.7509     5.7733 -0.1301   0.8966
## educ         -0.5015     0.1671 -3.0016   0.0028
## age           0.7707     0.1601  4.8132   0.0000
## agesq        -0.0090     0.0017 -5.1765   0.0000
## restaurn     -2.8251     1.1118 -2.5410   0.0112
```

```r
# Obtain the weights w_i = 1/h(z_i) = 1/exp(Xg)
logu2 = log(resid(reg.ols)^2)
reg.var = lm(logu2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
             data=smoke)
w = 1/exp(fitted(reg.var))

# FGLS estimation
reg.fgls = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
              weight=w, data=smoke)
round(summary(reg.fgls)$coef, 4)
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   5.6355    17.8031  0.3165   0.7517
## lincome       1.2952     0.4370  2.9639   0.0031
## lcigpric     -2.9403     4.4601 -0.6592   0.5099
## educ         -0.4634     0.1202 -3.8570   0.0001
## age           0.4819     0.0968  4.9784   0.0000
## agesq        -0.0056     0.0009 -5.9897   0.0000
## restaurn     -3.4611     0.7955 -4.3508   0.0000
```


### Analytical Estimation
- This is similar to WLS; only the beginning changes:
**a)** Create the vectors/matrices and define _N_ and _K_

```r
# Create the y vector
y = as.matrix(smoke[,"cigs"]) # convert the data-frame column to a matrix

# Create the covariate matrix X with a leading column of ones
X = as.matrix( cbind(1, smoke[,c("lincome", "lcigpric", "educ", "age", "agesq",
                                 "restaurn")]) ) # bind the column of ones to x

# Store the values of N and K
N = nrow(X)
K = ncol(X) - 1
```


**b1)** OLS estimation to obtain {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}${{</math>}}


```r
bhat_ols = solve(t(X) %*% X) %*% t(X) %*% y
yhat = X %*% bhat_ols
ehat = y - yhat
```

**b2)** Regress the log squared residuals and estimate {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}
{{<math>}}$$ \log{\hat{\boldsymbol{\varepsilon}}}^2 = \boldsymbol{X} \boldsymbol{\gamma} + \boldsymbol{u} $${{</math>}}

```r
ghat = solve( t(X) %*% X ) %*% t(X) %*% log(ehat^2)
```


**b3)** Weight matrix {{<math>}}$\boldsymbol{W}${{</math>}}
{{<math>}}$$\boldsymbol{W} = diag\left(\frac{1}{\exp(\boldsymbol{X} \hat{\boldsymbol{\gamma}})}\right) = \begin{bmatrix}
\frac{1}{\exp(\boldsymbol{x}'_1\hat{\boldsymbol{\gamma}})} & 0 & \cdots & 0 \\
0 & \frac{1}{\exp(\boldsymbol{x}'_2\hat{\boldsymbol{\gamma}})} & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \frac{1}{\exp(\boldsymbol{x}'_N\hat{\boldsymbol{\gamma}})}
\end{bmatrix}$${{</math>}}


```r
W = diag(as.numeric(1 / exp(X %*% ghat)))
round(W[1:7,1:7], 3)
```

```
##       [,1]  [,2]  [,3] [,4]  [,5]  [,6]  [,7]
## [1,] 0.008 0.000 0.000 0.00 0.000 0.000 0.000
## [2,] 0.000 0.007 0.000 0.00 0.000 0.000 0.000
## [3,] 0.000 0.000 0.009 0.00 0.000 0.000 0.000
## [4,] 0.000 0.000 0.000 0.01 0.000 0.000 0.000
## [5,] 0.000 0.000 0.000 0.00 0.024 0.000 0.000
## [6,] 0.000 0.000 0.000 0.00 0.000 0.444 0.000
## [7,] 0.000 0.000 0.000 0.00 0.000 0.000 0.007
```

- The remaining steps are the same as in WLS:

**c)** FGLS estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}}
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} $${{</math>}}


```r
bhat_fgls = solve( t(X) %*% W %*% X ) %*% t(X) %*% W %*% y
bhat_fgls
```

```
##                 [,1]
## 1         5.63546183
## lincome   1.29523990
## lcigpric -2.94031229
## educ     -0.46344637
## age       0.48194788
## agesq    -0.00562721
## restaurn -3.46106414
```

**d)** Fitted values {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{FGLS}}${{</math>}}

```r
yhat_fgls = X %*% bhat_fgls
head(yhat_fgls)
```

```
##        [,1]
## 1  9.246793
## 2  9.914233
## 3 10.527827
## 4  9.667243
## 5  8.440092
## 6  2.048962
```


**e)** Residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{FGLS}}${{</math>}}

```r
ehat_fgls = y - yhat_fgls
head(ehat_fgls)
```

```
##        [,1]
## 1 -9.246793
## 2 -9.914233
## 3 -7.527827
## 4 -9.667243
## 5 -8.440092
## 6 -2.048962
```

**f)** Error variance estimate {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{FGLS}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 =  \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat_fgls = as.numeric( t(ehat_fgls) %*% W %*% ehat_fgls / (N-K-1) )
sig2hat_fgls
```

```
## [1] 2.492289
```

**h)** Variance-Covariance Matrix of the Estimator

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} $${{</math>}}


```r
Vbhat_fgls = sig2hat_fgls * solve( t(X) %*% W %*% X )
round(Vbhat_fgls, 3)
```

```
##                1 lincome lcigpric   educ    age  agesq restaurn
## 1        316.952   0.444  -77.432  0.196 -0.389  0.004    2.323
## lincome    0.444   0.191   -0.463 -0.016 -0.007  0.000    0.008
## lcigpric -77.432  -0.463   19.893 -0.050  0.071 -0.001   -0.620
## educ       0.196  -0.016   -0.050  0.014 -0.001  0.000    0.002
## age       -0.389  -0.007    0.071 -0.001  0.009  0.000   -0.009
## agesq      0.004   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn   2.323   0.008   -0.620  0.002 -0.009  0.000    0.633
```


**i)** Standard Errors, t Statistics, and p-values

```r
se_fgls = sqrt( diag(Vbhat_fgls) )
t_fgls = bhat_fgls / se_fgls
p_fgls = 2 * pt(-abs(t_fgls), N-K-1)

# Results
round(data.frame(bhat_fgls, se_fgls, t_fgls, p_fgls), 4) # FGLS results
```

```
##          bhat_fgls se_fgls  t_fgls p_fgls
## 1           5.6355 17.8031  0.3165 0.7517
## lincome     1.2952  0.4370  2.9639 0.0031
## lcigpric   -2.9403  4.4601 -0.6592 0.5099
## educ       -0.4634  0.1202 -3.8570 0.0001
## age         0.4819  0.0968  4.9784 0.0000
## agesq      -0.0056  0.0009 -5.9897 0.0000
## restaurn   -3.4611  0.7955 -4.3508 0.0000
```

```r
round(summary(reg.fgls)$coef, 4) # FGLS results via lm()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   5.6355    17.8031  0.3165   0.7517
## lincome       1.2952     0.4370  2.9639   0.0031
## lcigpric     -2.9403     4.4601 -0.6592   0.5099
## educ         -0.4634     0.1202 -3.8570   0.0001
## age           0.4819     0.0968  4.9784   0.0000
## agesq        -0.0056     0.0009 -5.9897   0.0000
## restaurn     -3.4611     0.7955 -4.3508   0.0000
```



<br>




{{< cta cta_text="Proceed to Instrumental Variables" cta_link="../sec11" >}}


