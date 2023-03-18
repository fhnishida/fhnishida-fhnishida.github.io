---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Variáveis Instrumentais
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Variáveis Instrumentais
weight: 4
output: md_document
type: book
---




## Variáveis Instrumentais em Regressão Simples

- [Seção 15.1 de Heiss (2020)](http://www.urfie.net/read/index.html#page/247)
- Considere a regressão linear simples:

{{<math>}}$$ y = \beta_0 + \beta_1 x + \varepsilon \tag{15.1} $${{</math>}}

O estimador de MQO seria:

{{<math>}}$$ \beta^{MQO}_1 = \frac{cov(x, y)}{var(x)} $${{</math>}}

Supondo que o regressor {{<math>}}$x${{</math>}} está relacionado com o termo de erro {{<math>}}$\varepsilon${{</math>}}, então o estimador de OLS será viesado.

Considerando a existência de uma variável instrumental válida {{<math>}}$z${{</math>}}, o estimador de variável instrumental (VI) é:

{{<math>}}$$ \beta^{VI}_1 = \frac{cov(z, y)}{cov(z,x)} $${{</math>}}


### Aplicando no R

#### Exemplo 15.1: Retorno da Educação para Mulheres Casadas (Wooldridge, 2019)

- Vamos usar a base de dados `mroz` do pacote `wooldridge` para estimar o seguinte modelo

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ} + \varepsilon $${{</math>}}

- Apenas para comparação, vamos estimar por MQO:

```r
data(mroz, package="wooldridge") # carregando base de dados
mroz = mroz[!is.na(mroz$wage),] # retirando valores ausentes de salário

reg.ols = lm(lwage ~ educ, mroz) # regressão por MQO
round( summary(reg.ols)$coef, 5 )
```

```
##             Estimate Std. Error  t value Pr(>|t|)
## (Intercept) -0.18520    0.18523 -0.99984  0.31795
## educ         0.10865    0.01440  7.54513  0.00000
```


#### Usando a função `ivreg()`

- Para fazer regressão com variável instrumental, vamos usar a função `ivreg()` do pacote `AER`.
- É necessário incluir a variável instrumental (que neste caso é a educação do pai - `fatheduc`), após informar a variável explicativa `educ`, separada por uma `|`:


```r
library(AER) # carregando pacote com ivreg
```

```
## Carregando pacotes exigidos: car
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

```r
reg.iv = ivreg(lwage ~ educ | fatheduc, data=mroz) # regressão por VI
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


#### Estimação "na mão"

##### (1) Estimativas {{<math>}}$$ \beta^{VI} $${{</math>}}

<<<< Talvez fazer apenas para VI multivariado >>>>

</br>


## Variáveis Instrumentais em Regressão Múltipla

- [Seção 15.2 de Heiss (2020)](http://www.urfie.net/read/index.html#page/249)



</br>


## Testando a Exogeneidade dos Regressores

- [Seção 15.4 de Heiss (2020)](http://www.urfie.net/read/index.html#page/252)



</br>


## Testando Restrições Sobre-identificadas

- [Seção 15.5 de Heiss (2020)](http://www.urfie.net/read/index.html#page/252)




</br>


## Mínimos Quadrados em 2 Estágios

- [Seção 15.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/250)




</br>

{{< cta cta_text="👉 Seguir para Equações Simultâneas" cta_link="../sec5" >}}
