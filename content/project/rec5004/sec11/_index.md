---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "IV/2SLS"
summary: "Instrumental variables and 2SLS notes covering endogeneity, valid instruments, first-stage relevance, overidentification tests, and R estimation examples."
title: "Instrumental Variables and 2SLS"
weight: 11
output: md_document
type: book
---



- [Sections 15.1 to 15.5 of Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)


## Notation

- Consider the multivariate model with {{<math>}}$K${{</math>}} regressors:
{{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + ... + \beta_J \boldsymbol{x}^*_{J} + \beta_{J+1} \boldsymbol{x}_{J+1} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} $${{</math>}}
where {{<math>}}$\boldsymbol{x}^*_1, ..., \boldsymbol{x}^*_{J}${{</math>}} are the {{<math>}}$J${{</math>}} endogenous regressors in the model, with {{<math>}}$N${{</math>}} observations.


- In matrix form, we can write (1) as:
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \tag{2} $${{</math>}}
where
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{X}} = \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix}, $${{</math>}}
{{<math>}}$$ \underset{N \times 1}{\boldsymbol{y}} = \left[ \begin{matrix} \boldsymbol{y}_1 \\ \boldsymbol{y}_2 \\ \vdots \\ \boldsymbol{y}_N \end{matrix} \right] \quad \text{ e } \quad  \underset{N \times 1}{\boldsymbol{\varepsilon}} = \left[ \begin{matrix} \boldsymbol{\varepsilon}_1 \\ \boldsymbol{\varepsilon}_2 \\ \vdots \\ \boldsymbol{\varepsilon}_N \end{matrix} \right] $${{</math>}}

- Let {{<math>}}$\boldsymbol{Z}${{</math>}} denote the instrument matrix with {{<math>}}$L${{</math>}} instrumental variables, {{<math>}}$\boldsymbol{z}_k${{</math>}}, and {{<math>}}$K-J${{</math>}} exogenous variables, {{<math>}}$\boldsymbol{x}_k${{</math>}}:
{{<math>}}$$ \underset{N \times (1+L+K-J)}{\boldsymbol{Z}} = \begin{bmatrix}
1 & z_{11} & \cdots & z_{1L} & x_{1,J+1} & \cdots & x_{1K} \\
1 & z_{21} & \cdots & z_{2L} & x_{2,J+1} & \cdots & x_{2K} \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
1 & z_{N1} & \cdots & z_{NL} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix},$${{</math>}}
where {{<math>}}$J \le L${{</math>}}, so {{<math>}}$\boldsymbol{Z}${{</math>}} has at least as many columns as {{<math>}}$\boldsymbol{X}${{</math>}}.

- Note that:
  - {{<math>}}$\boldsymbol{z}_1${{</math>}} is the instrument for the endogenous variable {{<math>}}$\boldsymbol{x}^*_1${{</math>}}.
  - The best instruments for exogenous regressors are the variables themselves ({{<math>}}$\boldsymbol{x}_{J+1}, ..., \boldsymbol{x}_K${{</math>}}).
  - **Only when {{<math>}}$J = L${{</math>}} (number of endogenous regressors equals number of instruments)** does {{<math>}}$\boldsymbol{Z}${{</math>}} have the same dimensions as {{<math>}}$\boldsymbol{X}${{</math>}}:
  
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}


- Let {{<math>}}$\boldsymbol{Z}^*${{</math>}} denote the submatrix formed by the {{<math>}}$(L+1)${{</math>}} columns of {{<math>}}$\boldsymbol{Z}${{</math>}} containing the intercept and the {{<math>}}$L${{</math>}} instruments for the endogenous regressors:
{{<math>}}$$ \underset{N \times (L+1)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z_{11} & z_{12} & \cdots & z_{1L} \\ 1 & z_{21} & z_{22} & \cdots & z_{2L} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & z_{N2} & \cdots & z_{NL} \end{matrix} \right], $${{</math>}}

- The notation here differs slightly from the instructor's lecture notes.

</br>

## IV Estimator

- The **instrumental-variables (IV) estimator** is
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}'\boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}

- Notice that the **IV estimator requires {{<math>}}$\boldsymbol{Z}${{</math>}} and {{<math>}}$\boldsymbol{X}${{</math>}} to have the same dimensions**. Otherwise, {{<math>}}$\boldsymbol{Z'X}${{</math>}} is not square and therefore cannot be inverted.

- The **variance-covariance matrix of the estimator** is
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}})= \left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1} \boldsymbol{Z}' \boldsymbol{\Sigma} \boldsymbol{Z} \left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1} $${{</math>}}

- Under homoskedasticity, {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}}, so the expression simplifies to:
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}}) &= \left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1} \boldsymbol{Z}' (\sigma^2 \boldsymbol{I}) \boldsymbol{Z} \left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1} \\
&= \sigma^2 {\color{red}\left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1}} {\color{green}\boldsymbol{Z}' \boldsymbol{Z}} {\color{blue}\left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1}} \\
&\overset{*}{=} \sigma^2 \left( {\color{blue}\boldsymbol{X}' \boldsymbol{Z}} {\color{green}(\boldsymbol{Z}' \boldsymbol{Z})^{-1}} {\color{red}\boldsymbol{Z}' \boldsymbol{X}} \right)^{-1} \\
&= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1}  \end{align}{{</math>}}
where {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} is the orthogonal projection matrix onto the column space of {{<math>}}$\boldsymbol{Z}${{</math>}}. (*) Since each matrix pair has dimension K x K, we can invert the expression from right to left, starting with the inverse of {{<math>}}$\left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1}${{</math>}}, then the inverse of {{<math>}}$\boldsymbol{Z}' \boldsymbol{Z}${{</math>}}, and finally the inverse of {{<math>}}$\left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1}${{</math>}}.

- The **error variance** can be estimated as:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>

#### Example 15.1: Returns to Education for Women (Wooldridge, 2019)

- We use the `mroz` dataset from the `wooldridge` package to estimate the following model:

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

- For comparison, we first estimate the model by OLS:

```r
data(mroz, package="wooldridge") # loading the dataset
mroz = mroz[!is.na(mroz$wage),] # dropping observations with missing wages

reg.ols = lm(lwage ~ educ + exper + expersq, mroz) # OLS regression
round( summary(reg.ols)$coef, 3 )
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.522      0.199  -2.628    0.009
## educ           0.107      0.014   7.598    0.000
## exper          0.042      0.013   3.155    0.002
## expersq       -0.001      0.000  -2.063    0.040
```


### Estimation with `ivreg()`

- [CRAN - Package ivreg](https://cran.r-project.org/web/packages/ivreg/vignettes/ivreg.html)
- To estimate an instrumental-variables regression, we use the `ivreg()` function from the `ivreg` package (also available in `AER`, by the same author).
- We must include the instrument for _educ_ (in this case, father's education, _fatheduc_) as well as the instruments for the exogenous regressors (namely, the exogenous regressors themselves) after the `|` in the formula:


```r
library(ivreg) # loading the ivreg package
reg.iv = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + exper + expersq, data=mroz) # IV regression
# Comparison
stargazer::stargazer(reg.ols, reg.iv, type="text", digits=4)
```

```
## 
## ====================================================================
##                                         Dependent variable:         
##                                -------------------------------------
##                                                lwage                
##                                          OLS            instrumental
##                                                           variable  
##                                          (1)                (2)     
## --------------------------------------------------------------------
## educ                                  0.1075***           0.0702**  
##                                        (0.0141)           (0.0344)  
##                                                                     
## exper                                 0.0416***          0.0437***  
##                                        (0.0132)           (0.0134)  
##                                                                     
## expersq                               -0.0008**          -0.0009**  
##                                        (0.0004)           (0.0004)  
##                                                                     
## Constant                              -0.5220***          -0.0611   
##                                        (0.1986)           (0.4364)  
##                                                                     
## --------------------------------------------------------------------
## Observations                             428                428     
## R2                                      0.1568             0.1430   
## Adjusted R2                             0.1509             0.1370   
## Residual Std. Error (df = 424)          0.6664             0.6719   
## F Statistic                    26.2862*** (df = 3; 424)             
## ====================================================================
## Note:                                    *p<0.1; **p<0.05; ***p<0.01
```


### Analytical Estimation

**a)** Building the vectors/matrices and defining _N_ and _K_

```r
# Building the y vector
y = as.matrix(mroz[,"lwage"]) # converting the data-frame column into a matrix

# Building the covariate matrix X with a leading column of 1s
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Building the instrument matrix Z with a leading column of 1s
Z = as.matrix( cbind(1, mroz[,c("fatheduc","exper","expersq")]) )

# Retrieving N and K
N = nrow(X)
K = ncol(X) - 1
```


**b)** IV Estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}' \boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
bhat
```

```
##                 [,1]
## 1       -0.061116933
## educ     0.070226291
## exper    0.043671588
## expersq -0.000882155
```

**c)** Fitted Values {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

```r
yhat = X %*% bhat
head(yhat)
```

```
##        [,1]
## 1 1.2200984
## 2 0.9779026
## 3 1.2381875
## 4 1.0118705
## 5 1.1845267
## 6 1.2620942
```


**d)** Residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

```r
ehat = y - yhat
head(ehat)
```

```
##           [,1]
## 1 -0.009944725
## 2 -0.649390526
## 3  0.275950227
## 4 -0.919747190
## 5  0.339745535
## 6  0.294385830
```

**e)** Estimated Error Variance {{<math>}}$\hat{\sigma}^2${{</math>}}
{{<math>}}$$\hat{\sigma}^2_{\scriptscriptstyle{VI}} =  \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4513836
```

**f)** Variance-Covariance Matrix of the Estimator

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}


```r
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )
Vbhat
```

```
##                     1          educ         exper       expersq
## 1        1.904852e-01 -1.467376e-02 -2.903230e-04  4.591458e-07
## educ    -1.467376e-02  1.186299e-03 -6.701635e-05  2.259110e-06
## exper   -2.903230e-04 -6.701635e-05  1.795632e-04 -5.122537e-06
## expersq  4.591458e-07  2.259110e-06 -5.122537e-06  1.607344e-07
```


**g)** Standard Errors of the Estimator {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}})${{</math>}}

They are the square roots of the main diagonal of the estimator's variance-covariance matrix.

```r
se = sqrt( diag(Vbhat) )
se
```

```
##           1        educ       exper     expersq 
## 0.436446128 0.034442694 0.013400121 0.000400917
```

**h)** _t_ Statistic

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} 
$$ {{</math>}}


```r
t = bhat / se
t
```

```
##               [,1]
## 1       -0.1400332
## educ     2.0389314
## exper    3.2590443
## expersq -2.2003431
```

**i)** p-value

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), $${{</math>}}


```r
p = 2 * pt(-abs(t), N-K-1)
p
```

```
##                [,1]
## 1       0.888700281
## educ    0.042076572
## exper   0.001207928
## expersq 0.028321194
```

**j)** Summary Table

```r
round(data.frame(bhat, se, t, p), 4) # IV results
```

```
##            bhat     se       t      p
## 1       -0.0611 0.4364 -0.1400 0.8887
## educ     0.0702 0.0344  2.0389 0.0421
## exper    0.0437 0.0134  3.2590 0.0012
## expersq -0.0009 0.0004 -2.2003 0.0283
```

```r
summary(reg.iv)$coef # IV results from ivreg()
```

```
##                 Estimate  Std. Error    t value    Pr(>|t|)
## (Intercept) -0.061116933 0.436446128 -0.1400332 0.888700281
## educ         0.070226291 0.034442694  2.0389314 0.042076572
## exper        0.043671588 0.013400121  3.2590443 0.001207928
## expersq     -0.000882155 0.000400917 -2.2003431 0.028321194
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```


</br>

### Overidentification Adjustment

- As an example, consider the case with {{<math>}}$L = 2${{</math>}} instruments for {{<math>}}$J = 1${{</math>}} endogenous regressor {{<math>}}$\boldsymbol{x}_1^*${{</math>}}.
- Since {{<math>}}$L > J${{</math>}}, the model is overidentified.

- To perform IV estimation, we can **create a new instrument**, {{<math>}}$\boldsymbol{z}_1^*${{</math>}}, as a linear combination of the other two instruments using the following model:
{{<math>}}\begin{align} \boldsymbol{x}_1^* &= \gamma_0 + \gamma_1 \boldsymbol{z}_1 + \gamma_2 \boldsymbol{z}_2 + \boldsymbol{u} \\
&= \boldsymbol{Z}^*\boldsymbol{\gamma} + \boldsymbol{u} \end{align}{{</math>}}
where
{{<math>}}$$ \boldsymbol{\gamma} = \begin{bmatrix} \gamma_0 \\ \gamma_1 \\ \gamma_2 \end{bmatrix}, \quad \boldsymbol{x}_{1}^* = \begin{bmatrix} x_{11}^* \\ x_{21}^* \\ \vdots \\ x_{N1}^* \end{bmatrix} \quad \text{ e } \quad \boldsymbol{Z}^* = \begin{bmatrix} 1 & z_{11} & z_{12} \\ 1 & z_{21} & z_{22} \\ \vdots & \vdots & \vdots \\ 1 & z_{N1} & z_{N2} \end{bmatrix} $${{</math>}}

- We need to estimate:
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^{*})^{-1} \boldsymbol{Z}^{*\prime} \boldsymbol{x}_1^*  $$ {{</math>}}

- We can then use the fitted value from this model, {{<math>}}$\hat{\boldsymbol{x}}_1^*${{</math>}}, as the instrument for {{<math>}}$\boldsymbol{x}_1^*${{</math>}} inside {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$ \boldsymbol{z}^*_1 \equiv \hat{\boldsymbol{x}}_1^* = \boldsymbol{Z}^*\hat{\boldsymbol{\gamma}}$$ {{</math>}}

- The resulting instrument matrix, now with the same dimensions as {{<math>}}$\boldsymbol{X}${{</math>}}, is:

{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & \hat{x}^*_{11} & x_{12} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & x_{N2} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}




#### Analytical Estimation

- Here we construct a new instrumental variable "by hand" from the two available instruments.
- Continuing with Wooldridge's Example 15.1, we add another instrumental variable (_motheduc_), in addition to _fatheduc_, for the endogenous regressor _educ_.
- Recall that we want to estimate the following model:
{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

**a1)** Building the vectors/matrices and defining _N_ and _K_

```r
# Building the y vector
y = as.matrix(mroz[,"lwage"]) # converting the data-frame column into a matrix

# Building the covariate matrix X with a leading column of 1s
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Building the vector with the endogenous variable x1*
x1star = as.matrix(mroz[,"educ"])

# Building the matrix containing ONLY the instruments for the endogenous regressor x1*
Zstar = as.matrix(cbind(1, mroz[,c("fatheduc","motheduc")]))

# Retrieving N and K
N = nrow(X)
K = ncol(X) - 1
```

**a2)** Estimating {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}, obtaining {{<math>}}$\boldsymbol{z}_{1} = \hat{\boldsymbol{x}}^*_1${{</math>}}, and constructing {{<math>}}$\boldsymbol{Z}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^{*})^{-1} \boldsymbol{Z}^{*\prime} \boldsymbol{x}_1^* \quad \text{ e } \quad \hat{\boldsymbol{x}}^*_1 = \boldsymbol{Z}^* \hat{\boldsymbol{\gamma}} $$ {{</math>}}


```r
# Estimating ghat and x1hat
ghat = solve( t(Zstar) %*% Zstar ) %*% t(Zstar) %*% x1star
x1hat = Zstar %*% ghat

# Building the instrument matrix Z
Z = as.matrix( cbind(1, x1hat, mroz[,c("exper","expersq")]) )
head(Z)
```

```
##   1    x1hat exper expersq
## 1 1 12.67324    14     196
## 2 1 11.89140     5      25
## 3 1 12.67324    15     225
## 4 1 11.89140     6      36
## 5 1 13.98993     7      49
## 6 1 12.98598    33    1089
```

**b -- j)** The remaining steps are the same as before:

```r
# Estimation, fitted values, and residuals
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
yhat = X %*% bhat
ehat = y - yhat

# Variance-covariance matrix
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )

# Standard errors, t-statistics, and p-values
se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Summary table
reg.iv2 = data.frame(bhat, se, t, p) # overidentified IV results
round(reg.iv2, 4)
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1201 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```


</br>

## 2SLS Estimator

- Because the IV estimator requires the number of instruments to equal the number of endogenous regressors, it is not used directly in overidentified models unless we apply the adjustment shown above.
- When {{<math>}}$L>J${{</math>}}, the standard approach is to use Two-Stage Least Squares (2SLS), also known as the generalized IV estimator.

- The **two-stage least squares (2SLS) estimator** is
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}
where {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} is the orthogonal projection matrix onto the column space of {{<math>}}$\boldsymbol{Z}${{</math>}}.
- Note also that 2SLS collapses to IV when the model is exactly identified (that is, when {{<math>}}$\boldsymbol{Z}${{</math>}} and {{<math>}}$\boldsymbol{X}${{</math>}} have the same dimensions):
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}} &= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= ({\color{blue}\boldsymbol{X}' \boldsymbol{Z}} {\color{green}(\boldsymbol{Z}' \boldsymbol{Z})^{-1}} {\color{red}\boldsymbol{Z}' \boldsymbol{X}})^{-1} \boldsymbol{X}' \boldsymbol{Z} (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{y} \\
&= {\color{red}(\boldsymbol{Z}' \boldsymbol{X})^{-1}} {\color{green}\boldsymbol{Z}' \boldsymbol{Z}} \underbrace{{\color{blue}(\boldsymbol{X}' \boldsymbol{Z})^{-1}} \boldsymbol{X}' \boldsymbol{Z}}_{\boldsymbol{I}} (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{y} \\
&= (\boldsymbol{Z}' \boldsymbol{X})^{-1}  \underbrace{\boldsymbol{Z}' \boldsymbol{Z} (\boldsymbol{Z}' \boldsymbol{Z})^{-1}}_{\boldsymbol{I}}  \boldsymbol{Z}' \boldsymbol{y} \\
&= (\boldsymbol{Z}' \boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} = \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{IV}} \end{align}{{</math>}}

- The **variance-covariance matrix of the estimator** is
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}) &= \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' \boldsymbol{S} \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \\
&\overset{*}{=} \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1} \end{align}{{</math>}}
where {{<math>}}$\boldsymbol{S} = N^{-1} \sum_i {\hat{\varepsilon}^2_i \boldsymbol{z}_i \boldsymbol{z}'_i}${{</math>}}. (*) Under homoskedasticity.

- The **error variance** can be estimated as:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>

- If we define {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} and {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y}${{</math>}} (we avoid {{<math>}}$\hat{\boldsymbol{y}}${{</math>}} here so it is not confused with fitted values), then the 2SLS estimator can be rewritten as
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}} &= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= ([\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} [\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&\equiv (\hat{\boldsymbol{X}}' \hat{\boldsymbol{X}})^{-1} \hat{\boldsymbol{X}}' \tilde{\boldsymbol{y}}
\end{align}{{</math>}}
because {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} is idempotent {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}})${{</math>}} and symmetric {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}}')${{</math>}}.

- Once the variables are transformed, the estimator can be computed by OLS, which is why the method is called "two-stage" least squares.
- The 1st OLS stage appears when we pre-multiply by {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, since this matrix projects {{<math>}}$\boldsymbol{X}${{</math>}} onto the column space of {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}\begin{align} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} &= \boldsymbol{P_{\scriptscriptstyle{Z}}} \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \\
&= \ \quad \begin{bmatrix} 1 & \hat{x}^*_{11} & \cdots & \hat{x}^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & \cdots & \hat{x}^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & \cdots & \hat{x}^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \equiv \hat{\boldsymbol{X}} \end{align}{{</math>}}
where each variable in {{<math>}}$\boldsymbol{X}${{</math>}} has been regressed on all instruments (and exogenous regressors) in {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$\hat{\boldsymbol{x}}^*_{k} = \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}^*_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K}  ,$${{</math>}}
for {{<math>}}$k = 1, ..., J ${{</math>}}, and
{{<math>}}\begin{align} \hat{\boldsymbol{x}}_{k} &= \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K} \\
&= 0 + \cdots + 0 + \hat{\gamma}_{kk} \boldsymbol{x}_k + 0 + \cdots + 0 \\
&= 0 + \cdots + 0 + 1 \boldsymbol{x}_k + 0 + \cdots + 0\ \ =\ \ \boldsymbol{x}_{k},
\end{align}{{</math>}}
for {{<math>}}$k = J+1, ..., K${{</math>}}.
- Naturally, the exogenous regressors are unchanged by {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, because they belong to both the column space of {{<math>}}$\boldsymbol{X}${{</math>}} and that of {{<math>}}$\boldsymbol{Z}${{</math>}}.



### Estimation with `ivreg()`
- We only need to add the new instrument after the `|` in the `ivreg()` formula.

```r
library(ivreg) # loading the ivreg package
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # 2SLS regression
# Comparison
round(summary(reg.2sls)$coef, 4) # 2SLS results from ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```

```r
round(reg.iv2, 4) # overidentified IV results
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1201 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```


### Estimation with `lm()`
- 1st OLS: `educ ~ fatheduc + motheduc + exper + expersq`
- Obtain the fitted values `educ_hat`
- 2nd OLS: `lwage ~ educ_hat + exper + expersq`

```r
# 1st step: regress educ on the instruments
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
educ_hat = fitted(reg.1st)

# 2nd step: regress lwage on educ_hat and the remaining exogenous regressors
reg.2nd = lm(lwage ~ educ_hat + exper + expersq, data=mroz)

# Comparison
stargazer::stargazer(reg.2sls, reg.2nd, type="text", digits=4)
```

```
## 
## ===================================================================
##                                        Dependent variable:         
##                                ------------------------------------
##                                               lwage                
##                                instrumental           OLS          
##                                  variable                          
##                                    (1)                (2)          
## -------------------------------------------------------------------
## educ                             0.0614*                           
##                                  (0.0314)                          
##                                                                    
## educ_hat                                            0.0614*        
##                                                    (0.0330)        
##                                                                    
## exper                           0.0442***          0.0442***       
##                                  (0.0134)          (0.0141)        
##                                                                    
## expersq                         -0.0009**          -0.0009**       
##                                  (0.0004)          (0.0004)        
##                                                                    
## Constant                          0.0481            0.0481         
##                                  (0.4003)          (0.4198)        
##                                                                    
## -------------------------------------------------------------------
## Observations                       428                428          
## R2                                0.1357            0.0498         
## Adjusted R2                       0.1296            0.0431         
## Residual Std. Error (df = 424)    0.6747            0.7075         
## F Statistic                                 7.4046*** (df = 3; 424)
## ===================================================================
## Note:                                   *p<0.1; **p<0.05; ***p<0.01
```


### Analytical Estimation 1

**a)** Building the vectors/matrices and defining _N_ and _K_

```r
# Building the y vector
y = as.matrix(mroz[,"lwage"]) # converting the data-frame column into a matrix

# Building the covariate matrix X with a leading column of 1s
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Building the overidentified instrument matrix Z and the projection matrix Pz
Z = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)

# Retrieving N and K
N = nrow(X)
K = ncol(X) - 1
```


**b)** 2SLS Estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(X) %*% Pz %*% X ) %*% t(X) %*% Pz %*% y
bhat
```

```
##                  [,1]
## 1        0.0481003069
## educ     0.0613966287
## exper    0.0441703929
## expersq -0.0008989696
```


**c)** Fitted Values {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

```r
yhat = X %*% bhat
head(yhat)
```

```
##        [,1]
## 1 1.2270473
## 2 0.9832376
## 3 1.2451476
## 4 1.0175193
## 5 1.1727963
## 6 1.2635049
```


**d)** Residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

```r
ehat = y - yhat
head(ehat)
```

```
##          [,1]
## 1 -0.01689361
## 2 -0.65472547
## 3  0.26899016
## 4 -0.92539598
## 5  0.35147585
## 6  0.29297511
```

**e)** Estimated Error Variance {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{2SLS}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4552359
```

**f)** Variance-Covariance Matrix of the Estimator

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}

```r
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )
Vbhat
```

```
##                     1          educ         exper       expersq
## 1        1.602626e-01 -1.222421e-02 -4.382549e-04  5.366299e-06
## educ    -1.222421e-02  9.882658e-04 -5.582906e-05  1.881989e-06
## exper   -4.382549e-04 -5.582906e-05  1.804314e-04 -5.143861e-06
## expersq  5.366299e-06  1.881989e-06 -5.143861e-06  1.613513e-07
```


**g)** Standard Errors, t-Statistics, p-values, and Summary Table

```r
se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Summary table
round(data.frame(bhat, se, t, p), 4) # analytical 2SLS results
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1202 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```

```r
round(summary(reg.2sls)$coef, 4) # 2SLS results from ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```


### Analytical Estimation 2

- We can also compute 2SLS through OLS applied to the transformed variables.


**a)** Building the vectors/matrices and defining _N_ and _K_

```r
# Building the y vector
y = as.matrix(mroz[,"lwage"]) # converting the data-frame column into a matrix

# Building the covariate matrix X with a leading column of 1s
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Building the overidentified instrument matrix Z and the projection matrix Pz
Z = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)

# Retrieving N and K
N = nrow(X)
K = ncol(X) - 1
```


**b1)** Obtaining {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} and {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y}${{</math>}}


```r
ytil = Pz %*% y
Xhat = Pz %*% X
head(cbind(X, Xhat))
```

```
##   1 educ exper expersq 1     educ exper expersq
## 1 1   12    14     196 1 12.75602    14     196
## 2 1   12     5      25 1 11.73356     5      25
## 3 1   12    15     225 1 12.77198    15     225
## 4 1   12     6      36 1 11.76768     6      36
## 5 1   14     7      49 1 13.91461     7      49
## 6 1   12    33    1089 1 13.02938    33    1089
```

- Notice that even after pre-multiplying {{<math>}}$\boldsymbol{X}${{</math>}} by {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, **the exogenous regressors keep the same values**, because _exper_ and _expersq_ belong to both {{<math>}}$\boldsymbol{X}${{</math>}} and {{<math>}}$\boldsymbol{Z}${{</math>}}.
- The endogenous regressor is replaced by its fitted counterpart from the first-stage projection onto the instrument space.


**b2)** 2SLS Estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{2SLS}} = (\hat{\boldsymbol{X}}' \hat{\boldsymbol{X}})^{-1} \hat{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}


```r
bhat = solve( t(Xhat) %*% Xhat ) %*% t(Xhat) %*% ytil
bhat
```

```
##                  [,1]
## 1        0.0481003069
## educ     0.0613966287
## exper    0.0441703929
## expersq -0.0008989696
```


**c -- g)** The remaining steps are the same as before:

```r
yhat = X %*% bhat
ehat = y - yhat
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Vbhat = sig2hat * solve( t(X) %*% X )

se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Summary table
round(data.frame(bhat, se, t, p), 4) # analytical 2SLS results
```

```
##            bhat     se       t      p
## 1        0.0481 0.2011  0.2392 0.8111
## educ     0.0614 0.0143  4.2867 0.0000
## exper    0.0442 0.0133  3.3113 0.0010
## expersq -0.0009 0.0004 -2.2580 0.0245
```

```r
round(summary(reg.2sls)$coef, 4) # 2SLS results from ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```


<!-- ### Simultaneous Equations -->

<!-- - Simultaneous Equations Models (MES/SEM) -->





</br>

## Diagnostic Tests

- For the tests below, consider the multivariate model with {{<math>}}$J=1${{</math>}} endogenous regressor:
{{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + \beta_{2} \boldsymbol{x}_{2} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} $${{</math>}}
where {{<math>}}$\boldsymbol{x}^*_1${{</math>}} is the endogenous regressor in a model with {{<math>}}$K${{</math>}} regressors.
- To estimate the model by 2SLS, we run the first stage of the endogenous regressor on its {{<math>}}$L${{</math>}} instruments and the remaining exogenous regressors:
{{<math>}}$$ \boldsymbol{x}^*_{1} = \gamma_0 + \gamma^*_1 \boldsymbol{z}_{1} + \gamma^*_2 \boldsymbol{z}_{2} + ... + \gamma^*_L \boldsymbol{z}_{L} + \gamma_{2} \boldsymbol{x}_{2} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} $${{</math>}}

Using `summary()` on an object created by `ivreg()`, we already obtain three diagnostic tests:

```r
data(mroz, package="wooldridge") # loading the dataset
mroz = mroz[!is.na(mroz$wage),] # dropping observations with missing wages

# Regression and detailed summary output
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # 2SLS regression
summary(reg.2sls)
```

```
## 
## Call:
## ivreg(formula = lwage ~ educ + exper + expersq | fatheduc + motheduc + 
##     exper + expersq, data = mroz)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.0986 -0.3196  0.0551  0.3689  2.3493 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)   
## (Intercept)  0.0481003  0.4003281   0.120  0.90442   
## educ         0.0613966  0.0314367   1.953  0.05147 . 
## exper        0.0441704  0.0134325   3.288  0.00109 **
## expersq     -0.0008990  0.0004017  -2.238  0.02574 * 
## 
## Diagnostic tests:
##                  df1 df2 statistic p-value    
## Weak instruments   2 423    55.400  <2e-16 ***
## Wu-Hausman         1 423     2.793  0.0954 .  
## Sargan             1  NA     0.378  0.5386    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6747 on 424 degrees of freedom
## Multiple R-Squared: 0.1357,	Adjusted R-squared: 0.1296 
## Wald test: 8.141 on 3 and 424 DF,  p-value: 2.787e-05
```

- We now examine these tests in more detail.


</br>

### Endogeneity Test

#### (a) Hausman Test

- To check for endogeneity, we can use the **Hausman test** (also known as the Durbin-Wu-Hausman test).
- This is a more general test that **compares** two vectors of estimates to determine whether they are statistically equal.
- It is based on a contrast vector, that is, the difference between the two vectors of estimates.

The logic of the Hausman test is:
- We choose two estimation methods/models that differ in how robust they are to a particular "problem."
- Both estimators are **consistent when the problem is absent**.
  - The "less robust" estimator is more efficient when the problem is absent.
  - The "more robust" estimator remains **unbiased/consistent when the problem is present**.
- If the difference between the estimates is statistically
  - _significant_, that suggests the problem is present, making the "less robust" estimator biased/inconsistent and therefore different from the "more robust" estimator;
  - _insignificant_, then the problem is likely absent and the more efficient (but "less robust") estimator is preferred.
  

</br>  

In the instrumental-variables setting:
- We compare the OLS and 2SLS/IV estimators, where the relevant "problem" is endogeneity.
- If **endogeneity is present**, the 2SLS/IV estimator is unbiased/consistent, so its estimates should tend to differ from OLS, which is biased.
- If **endogeneity is absent**, both estimators are consistent (they converge to the true {{<math>}}$\boldsymbol{\beta}${{</math>}}), but **OLS is more efficient**.
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}'  \boldsymbol{X})^{-1}\right] \quad \text{ e } \quad \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \right]$${{</math>}}
Hence, we can test
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[0,\ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}}) \right] $${{</math>}}
using a quadratic-form (Wald-type) statistic:
{{<math>}}$$ w = (\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}})' \left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}}) \right]^{-1} (\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}})\, \sim\, \chi^2_{(J)} $${{</math>}}
where the chi-square degrees of freedom equal the number of endogenous regressors in the model ({{<math>}}$J${{</math>}}).

- Note that inverting the difference between the two variance-covariance matrices, {{<math>}}$\left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{OLS}}) \right]^{-1}${{</math>}}, can be numerically unstable. If that causes an error, you may need a **generalized inverse** (`MASS::ginv()` in R).


</br>

Applying this to the example in R:


```r
# estimating the OLS model
reg.ols = ivreg(lwage ~ educ + exper + expersq, data=mroz)

# estimating the 2SLS model
reg.2sls = ivreg(lwage ~ educ + exper + expersq |
                   fatheduc + motheduc + exper + expersq, data=mroz)

contrast = coef(reg.2sls) - coef(reg.ols) # contrast vector
w = (t(contrast) %*% solve( vcov(reg.2sls) - vcov(reg.ols) ) %*% contrast)
w # Wald statistic
```

```
##         [,1]
## [1,] 2.69566
```

```r
1 - pchisq(abs(w), df=1) # chi-square p-value
```

```
##           [,1]
## [1,] 0.1006218
```
- The p-value is close to 10%, so the difference between the OLS and 2SLS estimators (the contrast vector) is not significant at conventional significance levels.
- This suggests that there is no strong evidence of endogeneity, since OLS would be biased in the presence of endogeneity and would therefore tend to differ from 2SLS/IV.



#### (b) Regression-Based Hausman Test

As shown by Hausman (1978, 1983), **we can obtain an asymptotically equivalent statistic by regression**:

- Run the first-stage regression
  {{<math>}}$$ \boldsymbol{x}^*_{1} = \gamma_0 + \gamma^*_1 \boldsymbol{z}_{1} + \gamma^*_2 \boldsymbol{z}_{2} + ... + \gamma^*_L \boldsymbol{z}_{L} + \gamma_{2} \boldsymbol{x}_{2} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} $${{</math>}}
- Obtain the first-stage residuals {{<math>}}$\hat{\boldsymbol{u}}${{</math>}}
- Estimate the modified second stage, including the first-stage residuals as an additional regressor:
  {{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + \beta_{2} \boldsymbol{x}_{2} + ... + \beta_K \boldsymbol{x}_{K} + \delta \hat{\boldsymbol{u}} + \boldsymbol{\varepsilon} $${{</math>}}
where {{<math>}}$\boldsymbol{x}^*_1${{</math>}} remains the endogenous regressor.
- Then evaluate the p-value on the first-stage residual coefficient, {{<math>}}$\delta${{</math>}}.
  

```r
# 1st stage
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
uhat = resid(reg.1st)

# modified 2nd stage (including first-stage residuals as a regressor)
reg.2nd.mod  = lm(lwage ~ educ + exper + expersq + uhat, data=mroz)
summary(reg.2nd.mod)$coef
```

```
##                  Estimate   Std. Error   t value     Pr(>|t|)
## (Intercept)  0.0481003069 0.3945752571  0.121904 0.9030329286
## educ         0.0613966287 0.0309849420  1.981499 0.0481823507
## exper        0.0441703929 0.0132394473  3.336272 0.0009240749
## expersq     -0.0008989696 0.0003959133 -2.270622 0.0236719150
## uhat         0.0581666128 0.0348072757  1.671105 0.0954405509
```

- The p-value for _uhat_ is close to the one obtained from the actual Hausman test, though not exactly identical (here it is significant at 10%).
- This regression-based p-value is the one reported by `summary(ivreg(...))`.


</br>


### Weak-Instrument Tests

- In the weak-instrument setting, we test the **joint** null that the coefficients on the instruments are equal to zero:
{{<math>}}$$H_0: \quad \ \boldsymbol{\gamma}^* = \boldsymbol{0}\ \iff\ \begin{bmatrix} \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix}$${{</math>}}
- We can examine this using either Wald or F tests.
- For more details, see the [Hypothesis Testing section](../sec9).


#### (a) Wald Test

{{<math>}}$$ w(\hat{\boldsymbol{\gamma}}) = \left[ \boldsymbol{R}\hat{\boldsymbol{\gamma}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V_{\hat{\gamma}} R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\gamma}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}
where:
- {{<math>}}$G${{</math>}} is the number of linear restrictions
- {{<math>}}$\boldsymbol{\gamma}${{</math>}} is a parameter vector of dimension {{<math>}}$(K+1) \times 1${{</math>}}
- {{<math>}}$\boldsymbol{h}${{</math>}} is a vector of constants of dimension {{<math>}}$G \times 1${{</math>}}
- {{<math>}}$\boldsymbol{R}${{</math>}} is a {{<math>}}$G \times (K+1)${{</math>}} matrix composed of row vectors {{<math>}}$\boldsymbol{r}'_g${{</math>}} of dimension {{<math>}}$1 \times (K+1)${{</math>}}, for {{<math>}}$g=1, 2, ..., G${{</math>}}

In the weak-instrument case, we have {{<math>}}$G=L${{</math>}},
{{<math>}}$$\underset{L \times 1}{\boldsymbol{h}} = \boldsymbol{0} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix}, \qquad \qquad \underset{(1+L+K-J) \times 1}{\boldsymbol{\gamma}} = \begin{bmatrix} \gamma_0 \\ \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \\ \gamma_{J+1} \\ \vdots \\ \gamma_K \end{bmatrix} $${{</math>}}

{{<math>}}$$ \underset{L \times (1+L+K-J)}{\boldsymbol{R}} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \vdots \\ \boldsymbol{r}'_L \end{matrix} \right] =  \begin{matrix} 
\begin{matrix} \ \end{matrix}  \\
\left[ \begin{array}{c|cccc|ccc}
\ 0\  & \ 1 & \ 0 & \cdots & \ 0 & \ 0 & \ \cdots & \ 0\  \\
\ 0\  & \ 0 & \ 1 & \cdots & \ 0 & \ 0 & \ \cdots & \ 0\  \\
\ \vdots\ & \ \vdots & \ \vdots & \ddots & \ \vdots & \ \vdots & \ \ddots & \ \vdots\  \\
\ 0\  & \ 0 & \ 0 & \cdots & \ 1 & \ 0 & \ \cdots & \ 0\  \\
\end{array} \right] \\  
\begin{matrix} \color{red}\gamma_0 & \color{red}\gamma^*_1 & \color{red}\gamma^*_2 & \color{red}\cdots & \color{red}\gamma^*_L & \color{red}\gamma_{J+1} & \color{red}\cdots & \color{red}\gamma_{K} \end{matrix}  \end{matrix} $${{</math>}}

- Hence, the null hypothesis is
{{<math>}}\begin{align} \text{H}_0:\quad \boldsymbol{R} \hat{\boldsymbol{\gamma}}\ &=\ \boldsymbol{h} \\
\begin{bmatrix} \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \end{bmatrix} &= \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} \ \iff\ \boldsymbol{\gamma}^* = \boldsymbol{0} \end{align}{{</math>}}


</br>

Applying this to the example in R:


```r
# 1st step: regress educ on the instruments
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
Vghat = vcov(reg.1st)
ghat = as.matrix(coef(reg.1st))

G = 2 # number of restrictions = number of instruments L
R = matrix(c(
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0
  ), nrow=G, byrow=TRUE)
R
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    0    1    0    0    0
## [2,]    0    0    1    0    0
```

```r
h = matrix(0, nrow=G)
h
```

```
##      [,1]
## [1,]    0
## [2,]    0
```

```r
aux = R %*% ghat - h # Rg = h
w = t(aux) %*% solve( R %*% Vghat %*% t(R)) %*% aux
w # Wald statistic
```

```
##          [,1]
## [1,] 110.8006
```

```r
1 - pchisq(abs(w), df=G)
```

```
##      [,1]
## [1,]    0
```

The p-value is essentially zero, so we reject the null that the instruments are jointly equal to zero.



#### (b) F Test
- Another way to evaluate multiple restrictions is with the F test.
- We estimate two models:
  - Unrestricted (_ur_): includes all explanatory variables of interest
  - Restricted (_r_): excludes some variables from the regression
- The F test compares the sums of squared residuals (SSR) or the {{<math>}}R$^2${{</math>}} from the two models.
- The idea is simple: if the excluded variables are jointly significant, then the unrestricted model should display greater explanatory power.

In the instrumental-variables setting, we estimate the first stage:
- with all instruments (unrestricted)
- without any instrument (restricted)
and then compute the F statistic.

{{<math>}}$$ F = \frac{\text{SSR}_{r} - \text{SSR}_{ur}}{\text{SSR}_{ur}}.\frac{N-K-1}{G} = \frac{R^2_{ur} - R^2_{r}}{1 - R^2_{ur}}.\frac{N-K-1}{G} $${{</math>}}

- The _F_ statistic is then evaluated with a right-tailed test using an _F_ distribution with {{<math>}}$G${{</math>}} and {{<math>}}$N-K-1${{</math>}} degrees of freedom.


</br>

Applying this to the example in R:

```r
# Retrieving values
N = nrow(mroz) # number of observations
K = 4 # number of covariates
G = 2 # number of restrictions/instruments

# Estimating the unrestricted model (same as above)
reg.1st_ur = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)

# Estimating the restricted model
reg.1st_r = lm(educ ~ exper + expersq, data=mroz)

# Extracting the R-squared values
r2.ur = summary(reg.1st_ur)$r.squared
r2.ur # unrestricted R-squared
```

```
## [1] 0.2114706
```

```r
r2.r = summary(reg.1st_r)$r.squared
r2.r # restricted R-squared
```

```
## [1] 0.004923277
```

```r
# Computing the F statistic
F = ( r2.ur - r2.r ) / (1 - r2.ur) * (N-K-1) /  G
F
```

```
## [1] 55.4003
```

```r
# p-value of the F test
1 - pf(F, G, N-K-1)
```

```
## [1] 0
```
As with the Wald test, the p-value from the F test is essentially zero, so we reject the null that the instruments are jointly equal to zero.


</br>

### Overidentification Tests

- When more instruments are available than endogenous regressors {{<math>}}$(L>J)${{</math>}}, it is tempting to include as many instruments as possible in order to improve efficiency.
- However, we must be careful not to include instruments that are not truly exogenous (independent of the error term), because doing so can destroy consistency {{<math>}}(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{2SLS}}){{</math>}}.



#### (a) Hausman Test

- Here we again use the **(Durbin-Wu-)Hausman test**, but now comparing two 2SLS estimators:
  - [Unrestricted - _ur_]: an estimator that uses **all available instruments** for the endogenous regressor
    - It is **more efficient if the extra instruments are exogenous**.
  - [Restricted - _r_]: an estimator that uses only the {{<math>}}$L=J${{</math>}} "best" instruments, meaning the ones assumed to be exogenous.
    - This yields an exactly identified model.
    - If the extra instruments are endogenous, this restricted model is still assumed to be consistent.
- The Hausman test compares the difference between the two 2SLS estimates (the contrast vector). If the estimates are statistically:
  - different, then the extra instruments are probably endogenous and produce inconsistent estimates;
  - equal, then the extra instruments are probably exogenous and can be retained.

Formalmente:

- Under the null hypothesis, both the restricted (_r_) and unrestricted (_ur_) models are consistent and therefore estimate {{<math>}}$\boldsymbol{\beta}${{</math>}} consistently:
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{ur}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}^{ur} \boldsymbol{X})^{-1}\right] \quad \text{ e } \quad \hat{\boldsymbol{\beta}}^{r}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}^{r} \boldsymbol{X})^{-1} \right] $${{</math>}}
therefore,
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[0,\ V(\hat{\boldsymbol{\beta}}^{ur}) - V(\hat{\boldsymbol{\beta}}^{r}) \right] $${{</math>}}
we can test this using the Wald statistic:

{{<math>}}$$ w = (\hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r})' \left[ V(\hat{\boldsymbol{\beta}}^{ur}) - V(\hat{\boldsymbol{\beta}}^{r}) \right]^{-1} (\hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r})\, \sim\, \chi^2_{(L-M)} $${{</math>}}

- As before, inverting the difference between the two variance-covariance matrices, {{<math>}}$\left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{ur}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{r}}) \right]^{-1}${{</math>}}, can be numerically unstable. If necessary, use a **generalized inverse** (`MASS::ginv()` in R).



```r
# estimating the unrestricted model
reg.ur = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz)

# estimating the restricted model
reg.r = ivreg(lwage ~ educ + exper + expersq |
                fatheduc + exper + expersq, data=mroz)

contrast = coef(reg.ur) - coef(reg.r) # contrast vector
w = (t(contrast) %*% solve( vcov(reg.ur) - vcov(reg.r) ) %*% contrast)
w # Wald statistic
```

```
##            [,1]
## [1,] -0.3936859
```

```r
1 - pchisq(abs(w), df=1) # chi-square p-value
```

```
##           [,1]
## [1,] 0.5303683
```

- The test p-value indicates that the estimates from the two models are not statistically different, so there is no evidence here that the extra instruments are endogenous.
- Still, some caution is warranted: it is possible for both the restricted and unrestricted models to be asymptotically biased in similar ways, which would make the difference between them look small.



#### (b) Wald Test

- Alternatively, we can **test the relationship between the error term and the instruments directly**.
- The steps are:
  - Estimate the model by 2SLS using all available instruments.
  - Obtain the residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}.
  - Regress those residuals on all instruments and exogenous regressors.
  - Test whether the coefficients on the candidate instruments are jointly equal to zero using a Wald test, much like in the weak-instrument case.
  


#### (c) Sargan Test

- Sargan proposed a test that is equivalent to the Wald approach above but expressed through a regression.
- It uses the same steps as above, but instead of computing a Wald statistic after regressing the residuals on the instruments and exogenous regressors, we compute
{{<math>}}$$NR^2\ \overset{A}{\sim}\ \chi^2_{(L-J)}$${{</math>}}


```r
# Retrieving values
N = nrow(mroz)
L = 2 # number of instruments 
J = 1 # number of endogenous regressors

# Estimation
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # 2SLS regression
res.aux = lm(resid(reg.2sls) ~ fatheduc + motheduc + exper + expersq, data=mroz)

# Sargan statistic
r2 = summary(res.aux)$r.squared
sarg = N * r2 # always positive
1 - pchisq(sarg, df=L-J) # p-value
```

```
## [1] 0.5386372
```

- Note that this test concerns **all instruments jointly**, since it does not compare separate models built with different instrument sets.
- If we reject this test, we need to revisit the set of instruments used in the model.
- However, the test does not identify which instrument is not exogenous; it could be one, several, or all of them.




<!-- </br> -->

