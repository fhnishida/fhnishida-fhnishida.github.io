---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Hypothesis Testing"
summary: "Applied econometrics notes on Wald and F tests, linear restrictions, and by-hand as well as R-based hypothesis testing."
title: "Hypothesis Testing in Econometrics"
weight: 3
output: md_document
type: book
---




- We now turn to more general hypothesis tests that are not usually reported directly in standard regression output.


## Wald Test
- Consider:
  - {{<math>}}$G${{</math>}}: the number of linear restrictions
  - {{<math>}}$\boldsymbol{\beta}${{</math>}}: a {{<math>}}$(K+1) \times 1${{</math>}} parameter vector
  - {{<math>}}$\boldsymbol{h}${{</math>}}: a {{<math>}}$G \times 1${{</math>}} vector of constants
  - {{<math>}}$\boldsymbol{R}${{</math>}}: a {{<math>}}$G \times (K+1)${{</math>}} matrix formed by stacking {{<math>}}$G${{</math>}} row vectors {{<math>}}$\boldsymbol{r}'_g${{</math>}} of dimension {{<math>}}$1 \times (K+1)${{</math>}}, for {{<math>}}$g=1, 2, ..., G${{</math>}}
  - A multivariate model:
  
  {{<math>}}$$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + ... + \beta_K x_K + \varepsilon$${{</math>}}

- Using these matrices and vectors, we can write hypothesis tests in the form:
{{<math>}}\begin{align}
\text{H}_0: &\underset{G\times (K+1)}{\boldsymbol{R}} \underset{(K+1)\times 1}{\boldsymbol{\beta}} = \underset{G \times 1}{\boldsymbol{h}} \\
\text{H}_0: &\left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \vdots \\ \boldsymbol{r}'_{G} \end{matrix} \right] \boldsymbol{\beta} = \left[ \begin{matrix} h_1 \\ h_2 \\ \vdots \\ h_G \end{matrix} \right] \\
\text{H}_0: &\left\{ \begin{matrix} \boldsymbol{r}'_1 \boldsymbol{\beta} = h_1 \\ \boldsymbol{r}'_2 \boldsymbol{\beta} = h_2 \\ \vdots \\ \boldsymbol{r}'_G \boldsymbol{\beta} = h_G \end{matrix} \right.
\end{align}{{</math>}}




### One Linear Restriction

- Consider the model:
  {{<math>}}$$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \varepsilon$${{</math>}}

- There are {{<math>}}$K=2${{</math>}} explanatory variables (and therefore 3 parameters).
- One linear restriction {{<math>}}$\Longrightarrow \ G=1${{</math>}}
- In this particular case, we have
{{<math>}}$$\boldsymbol{R} = \boldsymbol{r}'_1\ \implies\ \text{H}_0:\ \boldsymbol{r}'_1 \boldsymbol{\beta} = h_1 $${{</math>}}


#### Evaluating the Null Hypothesis with a Single Restriction
- With a single restriction, we assume that
{{<math>}}$$ \boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} \sim N(\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}};\ \boldsymbol{r}'_1 \boldsymbol{V(\hat{\boldsymbol{\beta}}) r_1})$${{</math>}}

- The Wald statistic is then computed as follows. With a single restriction, it coincides with the usual _t_ statistic:
{{<math>}}$$ w = t = \frac{\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} - h_1}{\sqrt{\boldsymbol{r}'_1 \hat{\sigma}^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{r}_1}} = \frac{\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} - h_1}{\sqrt{\boldsymbol{r}'_1 \boldsymbol{V(\hat{\boldsymbol{\beta}})} \boldsymbol{r}_1}} $${{</math>}}

- Choose a significance level {{<math>}}$\alpha${{</math>}} and reject the null hypothesis when the _t_ statistic lies outside the relevant confidence interval.



#### Example 1: {{<math>}}H$_0: \ \beta_1 = 4${{</math>}}
- Note that {{<math>}}$h_1 = 4${{</math>}}.
- The vector {{<math>}}$r'_1${{</math>}} can be written as

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] $${{</math>}}

- So the null hypothesis is
{{<math>}}$$\text{H}_0:\ \boldsymbol{r}'_1 \boldsymbol{\beta}\ =\ \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 4\ \iff\ \beta_1 = 4 $${{</math>}}

- And the denominator of the _t_ statistic is:
{{<math>}}\begin{align} &\sqrt{\boldsymbol{r}'_1 \boldsymbol{V(\hat{\boldsymbol{\beta}})} \boldsymbol{r}_1} \\
&= \sqrt{\left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right]  {\small \begin{bmatrix}
var(\hat{\beta}_0) & cov(\hat{\beta}_0, \hat{\beta}_1) & cov(\hat{\beta}_0, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_1) & var(\hat{\beta}_1)   & cov(\hat{\beta}_1, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_2) & cov(\hat{\beta}_1, \hat{\beta}_2) & var(\hat{\beta}_2) \\
\end{bmatrix}}  \left[ \begin{matrix} 0 \\ 1 \\ 0 \end{matrix} \right]} \\
&= \sqrt{\small{\begin{bmatrix}
cov(\hat{\beta}_0, \hat{\beta}_1) & var(\hat{\beta}_1)   & cov(\hat{\beta}_1, \hat{\beta}_2)
\end{bmatrix}} \left[ \begin{matrix} 0 \\ 1 \\ 0 \end{matrix} \right]} \\
&= \sqrt{var(\hat{\beta}_1)} = se(\hat{\beta}_1) \end{align}{{</math>}}


#### Example 2: {{<math>}}H$_0: \ \beta_1 + \beta_2 = 2${{</math>}}
- Note that {{<math>}}$h_1 = 2${{</math>}}.
- The vector {{<math>}}$r'_1${{</math>}} can be written as

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- So the null hypothesis is
{{<math>}}$$\text{H}_0:\ \boldsymbol{r}'_1 \boldsymbol{\beta}\ =\ \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 2\ \iff\ \beta_1 + \beta_2 = 2 $${{</math>}}

- And the denominator of the _t_ statistic is:
{{<math>}}\begin{align} &\sqrt{\boldsymbol{r}'_1 \boldsymbol{V(\hat{\boldsymbol{\beta}})} \boldsymbol{r}_1} \\
&= \sqrt{\left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right]  {\small \begin{bmatrix}
var(\hat{\beta}_0) & cov(\hat{\beta}_0, \hat{\beta}_1) & cov(\hat{\beta}_0, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_1) & var(\hat{\beta}_1)   & cov(\hat{\beta}_1, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_2) & cov(\hat{\beta}_1, \hat{\beta}_2) & var(\hat{\beta}_2) \\
\end{bmatrix}}  \left[ \begin{matrix} 0 \\ 1 \\ 1 \end{matrix} \right]} \\
&= \sqrt{\small{\begin{bmatrix}
cov(\hat{\beta}_0, \hat{\beta}_1)+cov(\hat{\beta}_0, \hat{\beta}_2) \\ var(\hat{\beta}_1) + cov(\hat{\beta}_1, \hat{\beta}_2) \\ cov(\hat{\beta}_1, \hat{\beta}_2) + var(\hat{\beta}_2)
\end{bmatrix}}' \left[ \begin{matrix} 0 \\ 1 \\ 1 \end{matrix} \right]} \\
&= \sqrt{var(\hat{\beta}_1) + var(\hat{\beta}_2) + 2cov(\hat{\beta}_1, \hat{\beta}_2)} = \sqrt{var(\hat{\beta}_1 + \hat{\beta}_2)} \end{align}{{</math>}}


#### Example 3: {{<math>}}H$_0: \ \beta_1 = \beta_2${{</math>}}
- Note that
{{<math>}}$$\beta_1 = \beta_2 \iff \beta_1 - \beta_2 = 0 $${{</math>}}

- Hence, {{<math>}}$h_1 = 0${{</math>}}.
- The vector {{<math>}}$r'_1${{</math>}} can be written as

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & -1 \end{matrix} \right] $${{</math>}}

- So the null hypothesis is
{{<math>}}$$\text{H}_0:\ \boldsymbol{r}'_1 \boldsymbol{\beta}\ =\ \left[ \begin{matrix} 0 & 1 & -1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 0\ \iff\ \beta_1 - \beta_2 = 0 $${{</math>}}

- And the denominator of the _t_ statistic is:
{{<math>}}\begin{align} &\sqrt{\boldsymbol{r}'_1 \boldsymbol{V(\hat{\boldsymbol{\beta}})} \boldsymbol{r}_1} \\
&= \sqrt{\left[ \begin{matrix} 0 & 1 & -1 \end{matrix} \right]  {\small \begin{bmatrix}
var(\hat{\beta}_0) & cov(\hat{\beta}_0, \hat{\beta}_1) & cov(\hat{\beta}_0, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_1) & var(\hat{\beta}_1)   & cov(\hat{\beta}_1, \hat{\beta}_2) \\
cov(\hat{\beta}_0, \hat{\beta}_2) & cov(\hat{\beta}_1, \hat{\beta}_2) & var(\hat{\beta}_2) \\
\end{bmatrix}}  \left[ \begin{matrix} 0 \\ 1 \\ -1 \end{matrix} \right]} \\
&= \sqrt{\small{\begin{bmatrix}
cov(\hat{\beta}_0, \hat{\beta}_1)-cov(\hat{\beta}_0, \hat{\beta}_2) \\ var(\hat{\beta}_1) - cov(\hat{\beta}_1, \hat{\beta}_2) \\ cov(\hat{\beta}_1, \hat{\beta}_2) - var(\hat{\beta}_2)
\end{bmatrix}}' \left[ \begin{matrix} 0 \\ 1 \\ -1 \end{matrix} \right]} \\
&= \sqrt{var(\hat{\beta}_1) + var(\hat{\beta}_2) - 2cov(\hat{\beta}_1, \hat{\beta}_2)} = \sqrt{var(\hat{\beta}_1 - \hat{\beta}_2)} \end{align}{{</math>}}


#### Implementing It in R

##### (Continued) Example 7.5: Log Hourly Wage Equation (Wooldridge, 2006)
- Earlier, we estimated the following model:

{{<math>}}\begin{align}
\log(\text{wage}) = &\beta_0 + \beta_1 \text{female} + \beta_2 \text{married} + \delta_2 \text{female*married} + \beta_3 \text{educ} +\\
&\beta_4 \text{exper} + \beta_5 \text{exper}^2 + \beta_6 \text{tenure} + \beta_7 \text{tenure}^2 + \varepsilon \end{align}{{</math>}}
where:

- `wage`: average hourly wage
- `female`: dummy equal to (1) for women and (0) for men
- `married`: dummy equal to (1) for married individuals and (0) otherwise
- `female*married`: interaction term between the `female` and `married` dummies
- `educ`: years of education
- `exper`: years of experience (`expersq` = years squared)
- `tenure`: years with the current employer (`tenursq` = years squared)


```r
# Loading the required dataset
data(wage1, package="wooldridge")

# Estimating the model
res_7.14 = lm(lwage ~ female*married + educ + exper + expersq + tenure + tenursq, data=wage1)
round( summary(res_7.14)$coef, 4 )
```

```
##                Estimate Std. Error t value Pr(>|t|)
## (Intercept)      0.3214     0.1000  3.2135   0.0014
## female          -0.1104     0.0557 -1.9797   0.0483
## married          0.2127     0.0554  3.8419   0.0001
## educ             0.0789     0.0067 11.7873   0.0000
## exper            0.0268     0.0052  5.1118   0.0000
## expersq         -0.0005     0.0001 -4.8471   0.0000
## tenure           0.0291     0.0068  4.3016   0.0000
## tenursq         -0.0005     0.0002 -2.3056   0.0215
## female:married  -0.3006     0.0718 -4.1885   0.0000
```

- We can see that the effect of marriage for women differs from the effect for men because the coefficient on `female:married` ({{<math>}}$\delta_2${{</math>}}) is statistically significant.
- However, to determine whether the effect of marriage for women is itself significant, we need to test whether {{<math>}}H$_0 :\ \beta_2 + \delta_2 = 0${{</math>}}.
- Because there is only one restriction, we can evaluate this hypothesis with a _t_ test:

<img src="../t_test.png" alt="" width=60%>


```r
# Extracting objects from the regression
bhat = matrix(coef(res_7.14), ncol=1) # coefficients as a column vector
Vbhat = vcov(res_7.14) # variance-covariance matrix of the estimator
N = nrow(wage1) # number of observations
K = length(bhat) - 1 # number of covariates
ehat = residuals(res_7.14) # regression residuals

# Building the row vector for the restriction
r1prime = matrix(c(0, 0, 1, 0, 0, 0, 0, 0, 1), nrow=1) # restriction vector
h1 = 0 # constant in H0
G = 1 # number of restrictions

# Computing the t statistic
t = (r1prime %*% bhat - h1) / sqrt(r1prime %*% Vbhat %*% t(r1prime))
abs(t)
```

```
##          [,1]
## [1,] 1.679475
```

```r
# Computing the p-value
p = 2 * pt(-abs(t), N-K-1)
p
```

```
##            [,1]
## [1,] 0.09366368
```

- Since {{<math>}}$|t| < 2${{</math>}} (an approximate critical value for a 5\% significance level), we do not reject the null hypothesis and conclude that the effect of marriage on women's wages ({{<math>}}$\beta_2 + \delta_2${{</math>}}) is not statistically significant.

- We can also assess the same restriction with a Wald test, evaluating the statistic against a {{<math>}}$\chi^2${{</math>}} distribution with 1 degree of freedom (because there is only {{<math>}}$G=1${{</math>}} restriction).
- Recall that the chi-squared test is right-tailed.




```r
# Computing the Wald statistic
aux = r1prime %*% bhat - h1 # R \beta - h
w = t(aux) %*% solve( r1prime %*% Vbhat %*% t(r1prime)) %*% aux
w
```

```
##          [,1]
## [1,] 2.820636
```

```r
# Computing the p-value for w
p = 1 - pchisq(w, df=G)
p
```

```
##            [,1]
## [1,] 0.09305951
```


</br>


### Multiple Linear Restrictions

#### Evaluating the Null Hypothesis with Multiple Restrictions
- With _G_ restrictions, we assume that
{{<math>}}$$ \boldsymbol{R} \hat{\boldsymbol{\beta}} \sim N(\boldsymbol{R} \hat{\boldsymbol{\beta}};\ \sigma^2 \boldsymbol{R} \boldsymbol{V(\hat{\boldsymbol{\beta}}) R'})$${{</math>}}

- The Wald statistic is then
{{<math>}}$$ w = \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V(\hat{\beta}) R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}

- Choose a significance level {{<math>}}$\alpha${{</math>}} and reject the null hypothesis when the statistic {{<math>}}$w${{</math>}} falls outside the acceptance region (from zero to the critical value).



<img src="../chisq_test.png" alt="">


#### Example 4: {{<math>}}H$_0: \ \beta_1 = 0\ \text{ e }\ \beta_1 + \beta_2 = 2${{</math>}}
- Note that {{<math>}}$h_1 = 0 \text{ and } h_2 = 2${{</math>}}.
- The vectors {{<math>}}$r'_1 \text{ and } r'_2${{</math>}} can be written as

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] \quad \text{e} \quad r'_2 = \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- Therefore, {{<math>}}$\boldsymbol{R}${{</math>}} is
{{<math>}}$$ \boldsymbol{R} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \end{matrix} \right] = \left[ \begin{matrix} 0 & 1 & 0 \\ 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- So the null hypothesis is
{{<math>}}$$\text{H}_0:\ \boldsymbol{R} \boldsymbol{\beta} = \left[ \begin{matrix} 0 & 1 & 0 \\ 0 & 1 & 1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = \left[ \begin{matrix} h_1 \\ h_2 \end{matrix} \right]\ \iff\ \text{H}_0:\ \left\{  \begin{matrix} \beta_1 &= 0 \\ \beta_1 + \beta_2 &= 2 \end{matrix} \right. $${{</math>}}


</br>

### Implementing It in R

- As an example, we use the `mlb1` dataset from the `wooldridge` package, which contains baseball-player statistics (Wooldridge, 2006, Section 4.5).
- We want to estimate the model:
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + \beta_3. \text{bavg} + \\
&\beta_4 .\text{hrunsyr} + \beta_5. \text{rbisyr} + \varepsilon \end{align}{{</math>}}
where:
  - `log(salary)`: log salary in 1993
  - `years`: years spent in Major League Baseball
  - `gamesyr`: average number of games per year
  - `bavg`: career batting average
  - `hrunsyr`: average number of home runs per year
  - `rbisyr`: average number of runs batted in per year


```r
data(mlb1, package="wooldridge")

# Estimating the full (unrestricted) model
resMLB = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)
round(summary(resMLB)$coef, 5) # estimated coefficients
```

```
##             Estimate Std. Error  t value Pr(>|t|)
## (Intercept) 11.19242    0.28882 38.75184  0.00000
## years        0.06886    0.01211  5.68430  0.00000
## gamesyr      0.01255    0.00265  4.74244  0.00000
## bavg         0.00098    0.00110  0.88681  0.37579
## hrunsyr      0.01443    0.01606  0.89864  0.36947
## rbisyr       0.01077    0.00717  1.50046  0.13440
```

- Individually, the variables `bavg`, `hrunsyr`, and `rbisyr` are not statistically significant.
- We want to test whether they are jointly significant, that is,
{{<math>}}$$ \text{H}_0:\ \left\{ \begin{matrix} \beta_3 = 0 \\ \beta_4 = 0 \\ \beta_5 = 0\end{matrix} \right.   $${{</math>}}

- Thus, we have
{{<math>}}$$ \boldsymbol{R} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \boldsymbol{r}'_3 \end{matrix} \right] = \left[ \begin{matrix} 0 & 0 & 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 0 & 0 & 1 \end{matrix} \right] $${{</math>}}


#### Using `Wald.test()`


```r
# Extracting the variance-covariance matrix of the estimator
Vbhat = vcov(resMLB)
round(Vbhat, 5)
```

```
##             (Intercept)    years  gamesyr     bavg  hrunsyr   rbisyr
## (Intercept)     0.08342  0.00001 -0.00027 -0.00029 -0.00148  0.00082
## years           0.00001  0.00015 -0.00001  0.00000 -0.00002  0.00001
## gamesyr        -0.00027 -0.00001  0.00001  0.00000  0.00002 -0.00002
## bavg           -0.00029  0.00000  0.00000  0.00000  0.00000  0.00000
## hrunsyr        -0.00148 -0.00002  0.00002  0.00000  0.00026 -0.00010
## rbisyr          0.00082  0.00001 -0.00002  0.00000 -0.00010  0.00005
```

```r
# Computing the Wald statistic
# install.packages("aod") # installing the required package
aod::wald.test(Sigma = Vbhat, # variance-covariance matrix
               b = coef(resMLB), # estimated coefficients
               Terms = 4:6, # positions of the parameters to be tested
               H0 = c(0, 0, 0) # vector h (all equal to zero)
               )
```

```
## Wald test:
## ----------
## 
## Chi-squared test:
## X2 = 28.7, df = 3, P(> X2) = 2.7e-06
```

- We reject the null hypothesis and therefore conclude that the parameters {{<math>}}$\beta_3, \beta_4 \text{ and } \beta_5${{</math>}} are jointly significant.


#### Computing It By Hand

- Estimating the model

```r
# Creating the log_salary variable
mlb1$log_salary = log(mlb1$salary)
name_y = "log_salary"
names_X = c("years", "gamesyr", "bavg", "hrunsyr", "rbisyr")

# Creating the y vector
y = as.matrix(mlb1[,name_y]) # converting a data-frame column to a matrix

# Creating the covariate matrix X with a first column of 1s
X = as.matrix( cbind( const=1, mlb1[,names_X] ) ) # binding a column of 1s to the covariates

# Extracting N and K
N = nrow(mlb1)
K = ncol(X) - 1

# Estimating the model
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
round(bhat, 5)
```

```
##             [,1]
## const   11.19242
## years    0.06886
## gamesyr  0.01255
## bavg     0.00098
## hrunsyr  0.01443
## rbisyr   0.01077
```

```r
# Computing residuals
ehat = y - X %*% bhat

# Variance of the error term
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )

# Variance-covariance matrix of the estimator
Vbhat = sig2hat * solve( t(X) %*% X )
round(Vbhat, 5)
```

```
##            const    years  gamesyr     bavg  hrunsyr   rbisyr
## const    0.08342  0.00001 -0.00027 -0.00029 -0.00148  0.00082
## years    0.00001  0.00015 -0.00001  0.00000 -0.00002  0.00001
## gamesyr -0.00027 -0.00001  0.00001  0.00000  0.00002 -0.00002
## bavg    -0.00029  0.00000  0.00000  0.00000  0.00000  0.00000
## hrunsyr -0.00148 -0.00002  0.00002  0.00000  0.00026 -0.00010
## rbisyr   0.00082  0.00001 -0.00002  0.00000 -0.00010  0.00005
```

- Next, we build the restriction matrix.

```r
# Number of restrictions
G = 3

# Restriction matrix
R = matrix(c(0, 0, 0, 1, 0, 0,
             0, 0, 0, 0, 1, 0,
             0, 0, 0, 0, 0, 1),
           nrow=G, byrow=TRUE)
R
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    0    1    0    0
## [2,]    0    0    0    0    1    0
## [3,]    0    0    0    0    0    1
```

```r
# Vector of constants h
h = matrix(c(0, 0, 0),
           nrow=3, ncol=1)
h
```

```
##      [,1]
## [1,]    0
## [2,]    0
## [3,]    0
```

- Remember that, by default, `matrix()` fills a matrix by column.
- Here, however, it is more intuitive to fill the restriction matrix by row, since each row corresponds to one restriction. That is why we used `byrow=TRUE`.
- The Wald statistic is therefore
{{<math>}}$$ w(\hat{\boldsymbol{\beta}}) = \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V_{\hat{\beta}} R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}


```r
# Wald statistic
w = t( R %*% bhat - h ) %*% solve( R %*% Vbhat %*% t(R) ) %*% (R %*% bhat - h)
w
```

```
##          [,1]
## [1,] 28.65076
```

```r
# Finding the 5% chi-squared critical value
alpha = 0.05
c = qchisq(1-alpha, df=G)
c
```

```
## [1] 7.814728
```

```r
# Comparing the Wald statistic with the critical value
w > c
```

```
##      [,1]
## [1,] TRUE
```

- Since the Wald statistic (= 28.65) is larger than the critical value (= 7.81), we reject the joint null hypothesis that all tested parameters are equal to zero.
- We could also evaluate the corresponding p-value:

```r
1 - pchisq(w, df=G)
```

```
##              [,1]
## [1,] 2.651604e-06
```

- Since it is smaller than 5%, we reject the null hypothesis.


</br>


## F Test

- [Section 4.3 of Heiss (2020)](http://www.urfie.net/read/index.html#page/133)
- Another way to evaluate multiple restrictions is with the F test.
- Here we estimate two models:
  - Unrestricted: includes all explanatory variables of interest
  - Restricted: excludes some variables from the specification
- The F test compares the residual sums of squares (RSS) or the {{<math>}}R$^2${{</math>}} values of the two models.
- The intuition is straightforward: if the excluded variables are jointly significant, then the unrestricted model should have greater explanatory power.

</br>

- The _F_ statistic can be computed as:

{{<math>}}$$ F = \frac{\text{SSR}_{r} - \text{SSR}_{ur}}{\text{SSR}_{ur}}.\frac{N-K-1}{G} = \frac{R^2_{ur} - R^2_{r}}{1 - R^2_{ur}}.\frac{N-K-1}{G} \tag{4.10} $${{</math>}}

- where `ur` denotes the unrestricted model and `r` denotes the restricted model.

- We then evaluate the _F_ statistic using a right-tailed test based on the _F_ distribution:

<img src="../F_test.png" alt="">



### Implementing It in R

- We continue using the `mlb1` dataset from Section 4.5 of Wooldridge (2006).
- The unrestricted model (including all explanatory variables) is
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + \beta_3. \text{bavg} + \\
&\beta_4 .\text{hrunsyr} + \beta_5. \text{rbisyr} + \varepsilon \end{align}{{</math>}}

- The restricted model (excluding the variables under test) is
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + \varepsilon \end{align}{{</math>}}


#### Using `linearHypothesis()`
- We can compute the _F_ test with `linearHypothesis()` from the `car` package.
- Besides the regression object, we must also provide a character vector listing the restrictions:


```r
# Estimating the unrestricted model
res.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)

# Creating the vector of restrictions
myH0 = c("bavg = 0", "hrunsyr = 0", "rbisyr = 0")

# Applying the F test
# install.packages("car") # installing the required package
car::linearHypothesis(res.ur, myH0)
```

```
## Linear hypothesis test
## 
## Hypothesis:
## bavg = 0
## hrunsyr = 0
## rbisyr = 0
## 
## Model 1: restricted model
## Model 2: log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr
## 
##   Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
## 1    350 198.31                                  
## 2    347 183.19  3    15.125 9.5503 4.474e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

- In the second row (the unrestricted model), the residual sum of squares is lower than in the restricted model. So, as expected, the larger set of covariates provides more explanatory power.
- To evaluate the null hypothesis ({{<math>}}$\beta_3 = \beta_4 = \beta_5 = 0${{</math>}}), we can either compare the _F_ statistic with a critical value or check whether the p-value is below the chosen significance level.
- From the p-value criterion above, we reject the null hypothesis.
- The 5\% critical value can be obtained with:


```r
qf(1-0.05, G, N-K-1)
```

```
## [1] 2.630641
```
- Since 9.55 > 2.63, we reject the null hypothesis.


#### Computing It By Hand

- Here we obtain the restricted and unrestricted estimates from `lm()` directly, so we do not need to rework every estimation step from scratch.


```r
# Estimating the unrestricted model
res.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)

# Estimating the restricted model
res.r = lm(log(salary) ~ years + gamesyr, data=mlb1)

# Extracting the R2 values from the regression results
r2.ur = summary(res.ur)$r.squared
r2.ur
```

```
## [1] 0.6278028
```

```r
r2.r = summary(res.r)$r.squared
r2.r
```

```
## [1] 0.5970716
```

```r
# Computing the F statistic
F = ( r2.ur - r2.r ) / (1 - r2.ur) * (N-K-1) /  G
F
```

```
## [1] 9.550254
```

```r
# F-test p-value
1 - pf(F, G, N-K-1)
```

```
## [1] 4.473708e-06
```




</br>

{{< cta cta_text="👉 Proceed to Panel Data Estimation" cta_link="../sec4" >}}
