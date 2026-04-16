---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Instrumental Variables"
summary: "Introductory notes on instrumental variables in simple regression, including identification, intuition, and estimation in R."
title: "Instrumental Variables in Simple Regression"
weight: 6
output: md_document
type: book
---




## Instrumental Variables in Simple Regression

- [Section 15.1 of Heiss (2020)](http://www.urfie.net/read/index.html#page/247)
- Consider the simple linear regression:

{{<math>}}$$ y = \beta_0 + \beta_1 x + \varepsilon \tag{15.1} $${{</math>}}

The OLS estimator is:

{{<math>}}$$ \beta^{OLS}_1 = \frac{cov(x, y)}{var(x)} $${{</math>}}

If the regressor {{<math>}}$x${{</math>}} is correlated with the error term {{<math>}}$\varepsilon${{</math>}}, then the OLS estimator is biased.

Given a valid instrumental variable {{<math>}}$z${{</math>}}, the IV estimator becomes:

{{<math>}}$$ \beta^{VI}_1 = \frac{cov(z, y)}{cov(z,x)} $${{</math>}}


### Implementing IV in R

#### Example 15.1: Returns to Education for Married Women (Wooldridge, 2019)

- We will use the `mroz` dataset from the `wooldridge` package to estimate the following model:

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ} + \varepsilon $${{</math>}}

- For comparison, we first estimate the model by OLS:

```r
data(mroz, package="wooldridge") # loading the dataset
mroz = mroz[!is.na(mroz$wage),] # dropping missing wage observations

reg.ols = lm(lwage ~ educ, mroz) # OLS regression
round( summary(reg.ols)$coef, 5 )
```

```
##             Estimate Std. Error  t value Pr(>|t|)
## (Intercept) -0.18520    0.18523 -0.99984  0.31795
## educ         0.10865    0.01440  7.54513  0.00000
```


#### Using `ivreg()`

- To estimate an instrumental-variables regression, we can use the `ivreg()` function from the `AER` package.
- After specifying the endogenous regressor `educ`, we add the instrument on the right-hand side of `|`. In this example, the father's education (`fatheduc`) is used as the instrument:


```r
library(AER) # loading the package that includes ivreg
```

```
## Carregando pacotes exigidos: car
```

```
## Warning: package 'car' was built under R version 4.2.3
```

```
## Carregando pacotes exigidos: carData
```

```
## Carregando pacotes exigidos: lmtest
```

```
## Carregando pacotes exigidos: zoo
```

```
## Warning: package 'zoo' was built under R version 4.2.3
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```
## Carregando pacotes exigidos: sandwich
```

```
## Carregando pacotes exigidos: survival
```

```
## Warning: package 'survival' was built under R version 4.2.3
```

```r
reg.iv = ivreg(lwage ~ educ | fatheduc, data=mroz) # IV regression
round( summary(reg.iv)$coef, 5 )
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  0.44110    0.44610 0.98880  0.32332
## educ         0.05917    0.03514 1.68385  0.09294
## attr(,"df")
## [1] 426
## attr(,"nobs")
## [1] 428
```


#### By-hand derivation

##### (1) IV estimate {{<math>}}$$ \beta^{VI} $${{</math>}}

- The simple-regression formula above is useful for intuition.
- In practice, the multivariate IV setup is more relevant in econometrics, so the full matrix derivation is developed in the next section.

</br>


## Instrumental Variables in Multiple Regression

- [Section 15.2 of Heiss (2020)](http://www.urfie.net/read/index.html#page/249)
- The next section extends the IV estimator to the multivariate case, where we combine endogenous and exogenous regressors in matrix form.



</br>


## Testing Regressor Exogeneity

- [Section 15.4 of Heiss (2020)](http://www.urfie.net/read/index.html#page/252)
- Once we allow for endogeneity, an important empirical question is whether OLS and IV differ enough to justify treating a regressor as endogenous.



</br>


## Testing Overidentifying Restrictions

- [Section 15.5 of Heiss (2020)](http://www.urfie.net/read/index.html#page/252)
- When the model has more instruments than endogenous regressors, we can test whether the extra instruments are jointly consistent with the exogeneity assumptions.




</br>


## Two-Stage Least Squares

- [Section 15.3 of Heiss (2020)](http://www.urfie.net/read/index.html#page/250)
- Two-stage least squares (2SLS) is the standard operational form of IV estimation in multivariate models and will be the main focus of the following section.





</br>


## Simultaneous Equations Models

- [Section 15.3 of Heiss (2020)](http://www.urfie.net/read/index.html#page/250)
- Simultaneous-equations settings provide a classic motivation for IV methods, since endogenous variables are determined jointly within the system.



</br>

{{< cta cta_text="👉 Proceed to IV / 2SLS" cta_link="../sec7" >}}
