---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Simple Regression"
summary: "Econometrics I notes on simple OLS regression, fitted values, residuals, log transformations, standard errors, and assumption violations."
title: "Simple OLS Regression"
weight: 7
output: md_document
type: book
---



## Simple OLS Regression
- [Section 2.1 of Heiss (2020)](http://www.urfie.net/read/index.html#page/93)
- Consider the following empirical model:
$$ y = \beta_0 + \beta_1 x + u \tag{2.1} $$
- According to Wooldridge (2006, Section 2.2), the ordinary least squares (OLS) estimators are given by

{{<math>}}\begin{align}
    \hat{\beta}_0 &= \bar{y} - \hat{\beta}_1 \bar{x} \tag{2.2}\\
    \hat{\beta}_1 &= \frac{Cov(x,y)}{Var(x)} \tag{2.3}
\end{align}{{</math>}}

- The fitted (predicted) values, {{<math>}}$\hat{y}${{</math>}}, are given by
$$ \hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x \tag{2.4} $$
such that
$$ y = \hat{y} + \hat{u} $$

### Example 2.3: CEO Compensation and Stock Returns (Wooldridge, 2006)

- Consider the following simple regression model:
$$ \text{salary} = \beta_0 + \beta_1 \text{roe} + u $$
where `salary` is CEO compensation in thousands of dollars and `roe` is the return on equity, measured in percentage points.


#### Estimating Simple Regression "By Hand"


```r
# Load the dataset from the 'wooldridge' package
data(ceosal1, package="wooldridge")

attach(ceosal1) # avoids writing 'ceosal1$' before every variable

cov(salary, roe) # covariance between the dependent and independent variables
```

```
## [1] 1342.538
```

```r
var(roe) # variance of the return on equity
```

```
## [1] 72.56499
```

```r
mean(roe) # mean return on equity
```

```
## [1] 17.18421
```

```r
mean(salary) # mean salary
```

```
## [1] 1281.12
```

```r
# Compute the OLS coefficients "by hand"
( b1_hat = cov(salary, roe) / var(roe) ) # by (2.3)
```

```
## [1] 18.50119
```

```r
( b0_hat = mean(salary) - var(roe)*mean(salary) ) # by (2.2)
```

```
## [1] -91683.31
```

```r
detach(ceosal1) # stop looking for variables inside the 'ceosal1' object
```

- We see that a one-percentage-point increase in return on equity (`roe`) is associated with an increase of about 18 thousand dollars in CEO compensation.


#### Estimating Simple Regression with `lm()`
- A more convenient way to estimate an OLS model is to use the `lm()` function.
- In a univariate model, we write the dependent and independent variables separated by a tilde (`~`):

```r
lm(ceosal1$salary ~ ceosal1$roe)
```

```
## 
## Call:
## lm(formula = ceosal1$salary ~ ceosal1$roe)
## 
## Coefficients:
## (Intercept)  ceosal1$roe  
##       963.2         18.5
```

- We can also omit the `ceosal1$` prefix by supplying `data = ceosal1`.

```r
lm(salary ~ roe, data=ceosal1)
```

```
## 
## Call:
## lm(formula = salary ~ roe, data = ceosal1)
## 
## Coefficients:
## (Intercept)          roe  
##       963.2         18.5
```

- We can use `lm()` to add the regression line to a scatterplot.

```r
# Scatterplot
plot(ceosal1$roe, ceosal1$salary)

# Add the regression line
abline(lm(salary ~ roe, data=ceosal1), col="red")
```

<img src="/project/rec2301/sec7/_index_files/figure-html/unnamed-chunk-4-1.png" width="672" />


## Coefficients, Fitted Values, and Residuals
- [Section 2.2 of Heiss (2020)](http://www.urfie.net/read/index.html#page/98)
- We can store the estimation results in an object (a `list`) and then extract information from it.

```r
# Store the regression results in an object
CEOregres = lm(salary ~ roe, data=ceosal1)

# Check the names of the components stored in the object
names(CEOregres)
```

```
##  [1] "coefficients"  "residuals"     "effects"       "rank"         
##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
##  [9] "xlevels"       "call"          "terms"         "model"
```

- We can use `coef()` to extract the estimated regression coefficients.

```r
( bhat = coef(CEOregres) )
```

```
## (Intercept)         roe 
##   963.19134    18.50119
```

```r
bhat_0 = bhat["(Intercept)"] # or bhat[1]
bhat_1 = bhat["roe"] # or bhat[2]
```

- Given these estimated parameters, we can calculate the fitted values, {{<math>}}$\hat{y}${{</math>}}, and the residuals, {{<math>}}$\hat{u}${{</math>}}, for each observation {{<math>}}$i=1, ..., n${{</math>}}:

{{<math>}}\begin{align}
    \hat{y}_i &= \hat{\beta}_0 + \hat{\beta}_1 . x_i \tag{2.5} \\
    \hat{u}_i &= y_i - \hat{y}_i \tag{2.6}
\end{align}{{</math>}}


```r
# Extract ceosal1 columns as vectors
sal = ceosal1$salary
roe = ceosal1$roe

# Compute fitted values
sal_hat = bhat_0 + (bhat_1 * roe)

# Compute residuals
u_hat = sal - sal_hat

# Display the first 6 rows of sal, roe, sal_hat, and u_hat
head( cbind(sal, roe, sal_hat, u_hat) )
```

```
##       sal  roe  sal_hat     u_hat
## [1,] 1095 14.1 1224.058 -129.0581
## [2,] 1001 10.9 1164.854 -163.8543
## [3,] 1122 23.5 1397.969 -275.9692
## [4,]  578  5.9 1072.348 -494.3483
## [5,] 1368 13.8 1218.508  149.4923
## [6,] 1145 20.0 1333.215 -188.2151
```

- With `fitted()` and `resid()`, we can extract the fitted values and residuals directly from the regression object:

```r
head( cbind(fitted(CEOregres), resid(CEOregres)) )
```

```
##       [,1]      [,2]
## 1 1224.058 -129.0581
## 2 1164.854 -163.8543
## 3 1397.969 -275.9692
## 4 1072.348 -494.3483
## 5 1218.508  149.4923
## 6 1333.215 -188.2151
```

```r
# Or equivalently
head( cbind(CEOregres$fitted.values, CEOregres$residuals) )
```

```
##       [,1]      [,2]
## 1 1224.058 -129.0581
## 2 1164.854 -163.8543
## 3 1397.969 -275.9692
## 4 1072.348 -494.3483
## 5 1218.508  149.4923
## 6 1333.215 -188.2151
```


- In Section 2.3 of Wooldridge (2006), OLS estimation implies the following sample properties:
{{<math>}}\begin{align}
    &\sum^n_{i=1}{\hat{u}_i} = 0 \quad \implies \quad \bar{\hat{u}} = 0 \tag{2.7} \\
    &\sum^n_{i=1}{x_i \hat{u}_i} = 0 \quad \implies \quad Cov(x,\hat{u}) = 0 \tag{2.8} \\
    &\bar{y}=\hat{\beta}_0 + \hat{\beta}_1.\bar{x} \tag{2.9}
\end{align}{{</math>}}

- We can verify them in our example:

```r
# Checking (2.7)
mean(u_hat) # very close to 0
```

```
## [1] -2.666235e-14
```

```r
# Checking (2.8)
cor(ceosal1$roe, u_hat) # very close to 0
```

```
## [1] -6.038735e-17
```

```r
# Checking (2.9)
mean(ceosal1$salary)
```

```
## [1] 1281.12
```

```r
mean(sal_hat)
```

```
## [1] 1281.12
```

- **IMPORTANT**: This only means that OLS chooses {{<math>}}$\hat{\beta}_0${{</math>}} and {{<math>}}$\hat{\beta}_1${{</math>}} so that 2.7, 2.8, and 2.9 hold in the sample.
- This does **NOT** mean that the following population assumptions are necessarily true:
{{<math>}}\begin{align}
    &E(u) = 0 \tag{2.7'} \\
    &Cov(x, u) = 0 \tag{2.8'}
\end{align}{{</math>}}
- In fact, if 2.7' and 2.8' do not hold, OLS estimation will be biased.


## Log Transformations
- [Section 2.4 of Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- We can also estimate models after transforming variables from levels into logarithms.
- This is especially useful for turning nonlinear models into linear ones, such as when the parameter appears in the exponent rather than multiplicatively:
  
$$ y = A K^\alpha L^\beta\quad \overset{\text{log}}{\rightarrow}\quad \log(y) = \log(A) + \alpha \log(K) + \beta \log(L) $$

- Log transformations are also commonly used for dependent variables with {{<math>}}$y \ge 0${{</math>}}.


<center><img src="../tab_2-3.png"></center>

- There are two main ways to apply a log transformation:
    - create a new vector/column containing the logged variable, or
    - use the `log()` function directly inside `lm()`.


### Example 2.11: CEO Compensation and Firm Sales (Wooldridge, 2006)
- Consider the variables:
    - `wage`: annual salary, in thousands of dollars
    - `sales`: firm sales, in millions of dollars


- _Level-level model_:

```r
# Load the dataset
data(ceosal1, package="wooldridge")

# Estimate the level-level model
lm(salary ~ sales, data=ceosal1)
```

```
## 
## Call:
## lm(formula = salary ~ sales, data = ceosal1)
## 
## Coefficients:
## (Intercept)        sales  
##   1.174e+03    1.547e-02
```
- An increase of US\$1 million in sales is associated with an increase of US\$0.01547 thousand in CEO compensation.
- _Log-level model_:

```r
# Estimate the log-level model
lm(log(salary) ~ sales, data=ceosal1)
```

```
## 
## Call:
## lm(formula = log(salary) ~ sales, data = ceosal1)
## 
## Coefficients:
## (Intercept)        sales  
##   6.847e+00    1.498e-05
```
- An increase of US\$1 million in sales tends to raise CEO salary by about 0.0015\% ($=100 \beta_1\%$).
- _Log-log model_:

```r
# Estimate the log-log model
lm(log(salary) ~ log(sales), data=ceosal1)
```

```
## 
## Call:
## lm(formula = log(salary) ~ log(sales), data = ceosal1)
## 
## Coefficients:
## (Intercept)   log(sales)  
##      4.8220       0.2567
```
- A 1\% increase in sales is associated with an increase of about 0.257\% in salary ($=\beta_1\%$).


## Regression Through the Origin and on a Constant
- [Section 2.5 of Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- To estimate the model without an intercept, we need to add `0 +` to the regressors inside `lm()`:

```r
data(ceosal1, package="wooldridge")
lm(salary ~ 0 + roe, data=ceosal1)
```

```
## 
## Call:
## lm(formula = salary ~ 0 + roe, data = ceosal1)
## 
## Coefficients:
##   roe  
## 63.54
```

- If we regress a dependent variable on a constant only (`1`), we obtain its sample mean.

```r
lm(salary ~ 1, data=ceosal1)
```

```
## 
## Call:
## lm(formula = salary ~ 1, data = ceosal1)
## 
## Coefficients:
## (Intercept)  
##        1281
```

```r
mean(ceosal1$salary, na.rm=TRUE)
```

```
## [1] 1281.12
```


## Difference in Means
- Based on Example C.6: the effect of job-training grants on worker productivity (Wooldridge, 2006).
- We can calculate a difference in means by regressing on a dummy variable that takes values 0 or 1.
- First, we create a single vector of scrap rates by stacking `SR87` and `SR88`:

```r
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)

( SR = c(SR87, SR88) ) # stack SR87 and SR88 into a single vector
```

```
##  [1] 10.00  1.00  6.00  0.45  1.25  1.30  1.06  3.00  8.18  1.67  0.98  1.00
## [13]  0.45  5.03  8.00  9.00 18.00  0.28  7.00  3.97  3.00  1.00  5.00  0.50
## [25]  1.54  1.50  0.80  2.00  0.67  1.17  0.51  0.50  0.61  6.70  4.00  7.00
## [37] 19.00  0.20  5.00  3.83
```

- Note that the first 20 values refer to scrap rates in 1987 and the last 20 refer to 1988.
- Next, we create a dummy variable called `group88` that assigns value 1 to observations from 1988 and 0 to observations from 1987:

```r
( group88 = c(rep(0, 20), rep(1, 20)) ) # 0/1 values for the first/last 20 observations
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [39] 1 1
```

- Regressing the scrap rate on the dummy yields the difference in means:

```r
lm(SR ~ group88)
```

```
## 
## Call:
## lm(formula = SR ~ group88)
## 
## Coefficients:
## (Intercept)      group88  
##       4.381       -1.154
```



## Expected Values, Variance, and Standard Errors
- [Section 2.6 of Heiss (2020)](http://www.urfie.net/read/index.html#page/106)


- Wooldridge (2006, Section 2.5) derives the estimator of the error variance:
$$ \hat{\sigma}^2 = \frac{1}{n-2} \sum^n_{i=1}{\hat{u}^2_i} = \frac{n-1}{n-2} Var(\hat{u}) \tag{2.14} $$
where {{<math>}}$Var(\hat{u}) = \frac{1}{n-1} \sum^n_{i=1}{\hat{u}^2_i}${{</math>}}.

- Notice that we need to account for degrees of freedom because we are estimating two parameters ({{<math>}}$\hat{\beta}_0${{</math>}} and {{<math>}}$\hat{\beta}_1${{</math>}}).
- Note that {{<math>}}$\hat{\sigma} = \sqrt{\hat{\sigma}^2}${{</math>}} is called the standard error of the regression (SER). In R, this appears as the residual standard error.
- We can also obtain the standard errors of the estimators:

{{<math>}}\begin{align}
    se(\hat{\beta}_0) &= \sqrt{\frac{\hat{\sigma}\bar{x}^2}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \sqrt{\bar{x^2}} \tag{2.15}\\
    se(\hat{\beta}_1) &= \sqrt{\frac{\hat{\sigma}}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \tag{2.16}
\end{align}{{</math>}}


### Example 2.12: Student Math Performance and the School Lunch Program (Wooldridge, 2006)
- Consider the variables:
    - `math10`: the percentage of tenth graders who pass a standardized math exam
    - `lnchprg`: the percentage of students eligible for the school lunch program

- The simple regression model is
$$ \text{math10} = \beta_0 + \beta_1 \text{lnchprg} + u $$


```r
data(meap93, package="wooldridge")

# Estimate the model and store it in the object 'results'
results = lm(math10 ~ lnchprg, data=meap93)

# Extract the number of observations
( n = nobs(results) )
```

```
## [1] 408
```

```r
# Compute the standard error of the regression (square root of 2.14)
( SER = sqrt( (n-1)/(n-2) ) * sd(resid(results)) )
```

```
## [1] 9.565938
```

```r
# Standard error of bhat_0 (2.15)
(1 / sqrt(n-1)) * (SER / sd(meap93$lnchprg)) * sqrt( mean(meap93$lnchprg^2) ) # Standard error of bhat_0
```

```
## [1] 0.9975824
```

```r
(1 / sqrt(n-1)) * (SER / sd(meap93$lnchprg)) # bhat_1
```

```
## [1] 0.03483933
```

- The standard-error calculations can also be obtained with the `summary()` function applied to the regression object:

```r
summary(results)
```

```
## 
## Call:
## lm(formula = math10 ~ lnchprg, data = meap93)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -24.386  -5.979  -1.207   4.865  45.845 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 32.14271    0.99758  32.221   <2e-16 ***
## lnchprg     -0.31886    0.03484  -9.152   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 9.566 on 406 degrees of freedom
## Multiple R-squared:  0.171,	Adjusted R-squared:  0.169 
## F-statistic: 83.77 on 1 and 406 DF,  p-value: < 2.2e-16
```

- Also note that, by default, `summary()` reports two-sided hypothesis tests whose null hypotheses are {{<math>}}$\beta_0 = 0${{</math>}} and {{<math>}}$\beta_1=0${{</math>}}.
- In other words, it tests whether the estimated coefficients are statistically equal to zero and reports the corresponding t statistics and p-values.
- In this case, the p-values are extremely small (`<2e-16`, that is, smaller than {{<math>}}$2 \times 10^{-16}${{</math>}}), so we reject both null hypotheses and conclude that the estimates are statistically significant.
- We can also compute these statistics by hand:

```r
# Extract the estimated coefficients
( estim = coef(summary(results)) )
```

```
##               Estimate Std. Error   t value      Pr(>|t|)
## (Intercept) 32.1427116 0.99758239 32.220609 6.267302e-114
## lnchprg     -0.3188643 0.03483933 -9.152422  2.746609e-18
```

```r
# t statistics for H0: bhat = 0
( t_bhat_0 = (estim["(Intercept)", "Estimate"] - 0) / estim["(Intercept)", "Std. Error"] )
```

```
## [1] 32.22061
```

```r
( t_bhat_1 = (estim["lnchprg", "Estimate"] - 0) / estim["lnchprg", "Std. Error"] )
```

```
## [1] -9.152422
```

```r
# p-values for H0: bhat = 0
2 * (1 - pt(abs(t_bhat_0), n-1)) # p-value for bhat_0
```

```
## [1] 0
```

```r
2 * (1 - pt(abs(t_bhat_1), n-1)) # p-value for bhat_1
```

```
## [1] 0
```


## Assumption Violations
- [Subsection 2.7.3 of Heiss (2020)](http://www.urfie.net/read/index.html#page/113), but using the material from Worked Example 1.
- [Simulating a linear model (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/u7in9/simulation-simulating-a-linear-model)
- In practice, we run regressions using observed data and do not know the true model that generated those observations.
- In R, however, we can posit a true data-generating process and simulate observations to study what happens when an econometric assumption is violated.
- We will use the example from Worked Example 1, where we want to study the relationship between hours of cooking practice and the number of kitchen burns.


### No Assumption Violation: Example 1
- Let {{<math>}}$y${{</math>}} denote the number of kitchen burns and {{<math>}}$x${{</math>}} the number of hours spent learning how to cook.
- Suppose the true model is
$$ y = a_0 + b_0 x + \varepsilon, \qquad \varepsilon \sim N(0, 2^2) \tag{1}$$
where {{<math>}}$a_0=50${{</math>}} and {{<math>}}$b_0=-5${{</math>}}.

1. Set {{<math>}}$a_0${{</math>}} and {{<math>}}$b_0${{</math>}}, then simulate observations of {{<math>}}$x${{</math>}} and {{<math>}}$y${{</math>}}.
    - For convenience, we generate random draws from {{<math>}}$x \sim N(5; 0.5^2)${{</math>}}. Here, the specific distribution of {{<math>}}$x${{</math>}} is not important.

```r
a0 = 50
b0 = -5
N = 200 # number of observations

set.seed(1)
u = rnorm(N, 0, 2) # disturbances: 200 obs. with mean 0 and sd 2
x = rnorm(N, 5, 0.5) # 200 obs. with mean 5 and sd 0.5
y = a0 + b0*x + u # compute y from u and x

plot(x, y)
```

<img src="/project/rec2301/sec7/_index_files/figure-html/unnamed-chunk-21-1.png" width="672" />
These simulated {{<math>}}$x${{</math>}} and {{<math>}}$y${{</math>}} values are the information we would observe in practice.

2. Estimate the parameters {{<math>}}$\hat{a}${{</math>}} and {{<math>}}$\hat{b}${{</math>}} by OLS using the simulated observations of {{<math>}}$y${{</math>}} and {{<math>}}$x${{</math>}}.
    - Suppose an economist writes the following empirical model:
    $$ y = a + b x + u, \tag{1a}$$
    assuming that {{<math>}}$E[u] = 0${{</math>}} and {{<math>}}$E[ux]=0${{</math>}}.
    - To estimate the model by OLS, we use `lm()`.
    

```r
lm(y ~ x) # regress y on x by OLS
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##      50.463       -5.078
```

- Notice that the population parameters are recovered reasonably well ({{<math>}}$\hat{a} \approx 50 = a_0${{</math>}} and {{<math>}}$\hat{b} \approx -5 = b_0${{</math>}}).


```r
plot(x, y) # plot x against y
abline(a=50, b=-5, col="red") # true model line
abline(lm(y ~ x), col="blue") # estimated line from the observed data
```

<img src="/project/rec2301/sec7/_index_files/figure-html/unnamed-chunk-23-1.png" width="672" />

### No Assumption Violation: Example 2
- Now suppose that, in the true model, the number of burns {{<math>}}$y${{</math>}} is determined both by hours of practice {{<math>}}$x${{</math>}} and by hours actually spent cooking {{<math>}}$z${{</math>}}:

$$ y = a_0 + b_0 x + c_0 z + u, \qquad u \sim N(0, 2^2) \tag{2} $$
where {{<math>}}$a_0=50${{</math>}}, {{<math>}}$b_0=-5${{</math>}}, and {{<math>}}$c_0=3${{</math>}}. For convenience, we generate random draws from {{<math>}}$x \sim N(5; 0.5^2)${{</math>}} and {{<math>}}$z \sim N(1.875; 0.25^2)${{</math>}}. By construction, {{<math>}}$z${{</math>}} is uncorrelated with {{<math>}}$x${{</math>}} in the true model.

- First, let us simulate the observations:

```r
a0 = 50
b0 = -5
c0 = 3
N = 200 # number of observations

set.seed(1)
u = rnorm(N, 0, 2) # disturbances: 200 obs. with mean 0 and sd 2
x = rnorm(N, 5, 0.5) # 200 obs. with mean 5 and sd 0.5
z = rnorm(N, 1.875, 0.25) # 200 obs. with mean 1.875 and sd 0.25
y = a0 + b0*x + c0*z + u # compute y from u, x, and z
```

- Suppose an economist writes the following empirical model:
    $$ y = a + b x + u, \tag{2a}$$
    assuming that {{<math>}}$E[u] = 0${{</math>}} and {{<math>}}$E[ux] = 0${{</math>}}.

- Notice that the economist omitted the hours-cooking variable {{<math>}}$z${{</math>}}, so it is absorbed into the regression error term.
- However, because {{<math>}}$z${{</math>}} is unrelated to {{<math>}}$x${{</math>}}, this omission does not bias the estimate of {{<math>}}$\hat{b}${{</math>}}:

```r
cor(x, z) # correlation between x and z -> close to 0
```

```
## [1] -0.02625278
```

```r
lm(y ~ x) # OLS estimation
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##       56.27        -5.12
```
- Since {{<math>}}$\hat{b} \approx -5 = b_0${{</math>}}, OLS successfully recovers the population parameter {{<math>}}$b_0${{</math>}} even though the economist excluded {{<math>}}$z${{</math>}} from the model.
- In many economic applications, the main goal is to estimate the relationship or causal effect between {{<math>}}$y${{</math>}} and {{<math>}}$x${{</math>}}. We therefore do not need to include every variable that affects {{<math>}}$y${{</math>}}, as long as {{<math>}}$E(ux) = 0${{</math>}} holds; that is, as long as no omitted explanatory variable correlated with {{<math>}}$x${{</math>}} is hiding inside the error term.



### Violation of E(ux)=0
- Now suppose that, in the true model, the more someone practices cooking, the more time they actually spend cooking. In other words, {{<math>}}$x${{</math>}} is related to {{<math>}}$z${{</math>}}.
    - Assume that {{<math>}}$z \sim N(1.875x; (0.25)^2)${{</math>}}:
    

```r
set.seed(1)
e = rnorm(N, 0, 2) # disturbances: 200 obs. with mean 0 and sd 2
x = rnorm(N, 5, 0.5) # 200 obs. with mean 5 and sd 0.5
z = rnorm(N, 1.875*x, 0.25) # 200 obs. with mean 1.875x and sd 0.25
y = a0 + b0*x + c0*z + e # compute y from e, x, and z
cor(x, z) # correlation between x and z
```

```
## [1] 0.9618748
```

- Now {{<math>}}$x${{</math>}} and {{<math>}}$z${{</math>}} are strongly correlated.
- Estimate the empirical model
    $$ y = a + b x + u,$$
    assuming that {{<math>}}$E[u] = 0${{</math>}} and {{<math>}}$E[ux]=0${{</math>}}.
    

```r
lm(y ~ x) # OLS estimation
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##     50.6406       0.5053
```

- Here, {{<math>}}$\hat{b} = 0.5 \neq -5 = b_0${{</math>}}. This happens because {{<math>}}$z${{</math>}} was omitted from the model and is therefore absorbed into the residual {{<math>}}$\hat{u}${{</math>}}. Since {{<math>}}$z${{</math>}} is correlated with {{<math>}}$x${{</math>}}, we have {{<math>}}$E(ux)\neq 0${{</math>}}, which violates the key OLS exogeneity assumption.
- If we include {{<math>}}$z${{</math>}} in the regression, we recover an estimate close to {{<math>}}$b_0${{</math>}}:


```r
lm(y ~ x + z)
```

```
## 
## Call:
## lm(formula = y ~ x + z)
## 
## Coefficients:
## (Intercept)            x            z  
##      50.435       -5.953        3.470
```

### Violation of E(u)=0
- Now assume that {{<math>}}$E[u] = k${{</math>}}, where {{<math>}}$k \neq 0${{</math>}} is a constant.
- Let {{<math>}}$k = 10${{</math>}}:

```r
a0 = 50
b0 = -5
k = 10

set.seed(1)
u = rnorm(N, k, 2) # disturbances: 200 obs. with mean k and sd 2
x = rnorm(N, 5, 0.5) # 200 obs. with mean 5 and sd 0.5
y = a0 + b0*x + u # compute y from u and x
```
- If an economist estimates an empirical model that imposes {{<math>}}$E[u] = 0${{</math>}}, then:

```r
lm(y ~ x) # OLS estimation
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##      60.463       -5.078
```
- Notice that {{<math>}}$E[u] \neq 0${{</math>}} affects the intercept estimate, so {{<math>}}$\hat{a} \neq a_0${{</math>}}, but it does not affect {{<math>}}$\hat{b} \approx b_0${{</math>}}, which is usually the parameter of primary interest in economic applications.


### Violation of Homoskedasticity
- Now suppose that {{<math>}}$u \sim N(0, (2x)^2)${{</math>}}, so the variance increases with {{<math>}}$x${{</math>}}. In other words, the error variance depends on {{<math>}}$x${{</math>}}, and homoskedasticity fails.

```r
a0 = 50
b0 = -5

set.seed(1)
x = rnorm(N, 5, 0.5) # 200 obs. with mean 5 and sd 0.5
u = rnorm(N, 0, 2*x) # disturbances with sd equal to 2x
y = a0 + b0*x + u # compute y from u and x

lm(y ~ x) # OLS estimation
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##      51.221       -5.166
```
- Even with heteroskedasticity, we can still recover {{<math>}}$\hat{b} \approx b_0${{</math>}} in this simulation. But with a smaller sample, it becomes more likely that {{<math>}}$\hat{b} \neq b_0${{</math>}}. Try repeating the exercise with smaller values of {{<math>}}$N${{</math>}}.



## Goodness of Fit
- [Section 2.3 of Heiss (2020)](http://www.urfie.net/read/index.html#page/101)
- The total sum of squares (TSS), explained sum of squares (ESS), and residual sum of squares (RSS) can be written as

{{<math>}}\begin{align}
    SQT &= \sum^n_{i=1}{(y_i - \bar{y})^2} = (n-1) . Var(y) \tag{2.10}\\
    SQE &= \sum^n_{i=1}{(\hat{y}_i - \bar{y})^2} = (n-1) . Var(\hat{y}) \tag{2.11}\\
    SQR &= \sum^n_{i=1}{(\hat{u}_i - 0)^2} = (n-1) . Var(\hat{u}) \tag{2.12}
\end{align}{{</math>}}
where {{<math>}}$Var(x) = \frac{1}{n-1} \sum^n_{i=1}{(x_i - \bar{x})^2}${{</math>}}.

- Wooldridge (2006) defines the coefficient of determination as
{{<math>}}\begin{align}
    R^2 &= \frac{SQE}{SQT} = 1 - \frac{SQR}{SQT}\\
        &= \frac{Var(\hat{y})}{Var(y)} = 1 - \frac{Var(\hat{u})}{Var(y)} \tag{2.13}
\end{align}{{</math>}}
because {{<math>}}$SQT = SQE + SQR${{</math>}}.


```r
# Compute R^2 in three equivalent ways:
var(sal_hat) / var(sal)
```

```
## [1] 0.01318862
```

```r
1 - var(u_hat)/var(sal)
```

```
## [1] 0.01318862
```

```r
cor(sal, sal_hat)^2 # squared correlation between the dependent variable and fitted values
```

```
## [1] 0.01318862
```

- A more convenient way to obtain {{<math>}}$R^2${{</math>}} is to use `summary()` on the regression object. This produces a more detailed regression table, including {{<math>}}$R^2${{</math>}}:

```r
summary(CEOregres)
```

```
## 
## Call:
## lm(formula = salary ~ roe, data = ceosal1)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1160.2  -526.0  -254.0   138.8 13499.9 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   963.19     213.24   4.517 1.05e-05 ***
## roe            18.50      11.12   1.663   0.0978 .  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 1367 on 207 degrees of freedom
## Multiple R-squared:  0.01319,	Adjusted R-squared:  0.008421 
## F-statistic: 2.767 on 1 and 207 DF,  p-value: 0.09777
```



{{< cta cta_text="👉 Proceed to Multiple Regression" cta_link="../sec8" >}}
