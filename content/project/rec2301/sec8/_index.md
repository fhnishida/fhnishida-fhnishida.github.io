---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Regressão Múltipla
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Regressão Múltipla
weight: 8
output: md_document
type: book
---







### Estimação Analítica
- [ResEcon 703](https://github.com/woerman/ResEcon703) - Week 2 (University of Massachusetts Amherst)

#### 1. Construir matrizes de covariadas {{<math>}}$X${{</math>}} e da variável dependente {{<math>}}$y${{</math>}}

```r
library(dplyr)

## Criando reg_data a partir de variáveis de mtcars + uma coluna de 1's (p/ constante)
reg_data = mtcars %>%
    select(mpg, hp, wt) %>%  # Selecionando as variáveis dependente e independentes
    mutate(constante = 1)  # Criando coluna de constante

## Selecionando variáveis independentes no objeto X e convertendo em matriz (n x k)
X = reg_data %>%
    select(constante, hp, wt) %>%  # Selecionando as covariadas X (incluindo constante)
    as.matrix()  # Transformando em matrix

## Selecionando a variável dependente no objeto y e convertendo em matriz (n x 1)
y = reg_data %>%
    select(mpg) %>%  # Selecionando as covariadas X (incluindo constante)
    as.matrix()  # Transformando em matrix

## Visualização das primeiras linhas de y e X
head(X)
```

```
##                   constante  hp    wt
## Mazda RX4                 1 110 2.620
## Mazda RX4 Wag             1 110 2.875
## Datsun 710                1  93 2.320
## Hornet 4 Drive            1 110 3.215
## Hornet Sportabout         1 175 3.440
## Valiant                   1 105 3.460
```

```r
head(y)
```

```
##                    mpg
## Mazda RX4         21.0
## Mazda RX4 Wag     21.0
## Datsun 710        22.8
## Hornet 4 Drive    21.4
## Hornet Sportabout 18.7
## Valiant           18.1
```


#### 2. Estimador {{<math>}}$\hat{\beta}${{</math>}}
O estimador de MQO é dado por:
$$ \hat{\beta} = (X'X)^{-1} X' y $$


```r
## Estimando os parametros beta
beta_hat = solve(t(X) %*% X) %*% t(X) %*% y # solve() calcula a inversa
beta_hat
```

```
##                   mpg
## constante 37.22727012
## hp        -0.03177295
## wt        -3.87783074
```


#### 3. Calcular os valores ajustados {{<math>}}$\hat{y}${{</math>}}
$$ \hat{y} = X\hat{\beta} $$

```r
## Calculando os valores ajustados de y
y_hat = X %*% beta_hat
colnames(y_hat) = "mpg_hat"
head(y_hat)
```

```
##                    mpg_hat
## Mazda RX4         23.57233
## Mazda RX4 Wag     22.58348
## Datsun 710        25.27582
## Hornet 4 Drive    21.26502
## Hornet Sportabout 18.32727
## Valiant           20.47382
```


#### 4. Calcular os resíduos {{<math>}}$e${{</math>}}
$$ \varepsilon = y - \hat{y} $$

```r
## Calculando os residuos
e = y - y_hat
colnames(e) = "e"
head(e)
```

```
##                            e
## Mazda RX4         -2.5723294
## Mazda RX4 Wag     -1.5834826
## Datsun 710        -2.4758187
## Hornet 4 Drive     0.1349799
## Hornet Sportabout  0.3727334
## Valiant           -2.3738163
```


#### 5. Calcular a variância do termo de erro {{<math>}}$\hat{\sigma}^2${{</math>}}
$$ \hat{\sigma}^2 = \frac{\varepsilon'\varepsilon}{n-k} $$

```r
## Estimando variancia do termo de erro
sigma2 = t(e) %*% e / (nrow(X) - ncol(X))
sigma2
```

```
##          e
## e 6.725785
```


#### 6. Calcular a matriz de covariâncias {{<math>}}$\widehat{cov}(\widehat{\beta})${{</math>}}
$$ \widehat{cov}(\hat{\beta}) = \hat{\sigma}^2 (X'X)^{-1} $$

```r
## Estimando a matriz de variancia/covariancia das estimativas beta
vcov_hat = c(sigma2) * solve(t(X) %*% X)
vcov_hat
```

```
##               constante            hp          wt
## constante  2.5561215917  1.484701e-04 -0.73594515
## hp         0.0001484701  8.153566e-05 -0.00376369
## wt        -0.7359451464 -3.763690e-03  0.40035167
```


#### 7. Calcular erros padrão, estatísticas t, e p-valores

```r
## Calculando erros padrao das estimativas beta
std_err = sqrt(diag(vcov_hat)) # Raiz da diagonal da matriz de covariâncias

## Calculando estatisticas t das estimativas beta
t_stat = beta_hat / std_err

## Calculando p-valores das estimativas beta
p_value = 2 * pt(q = -abs(t_stat), df = nrow(X) - ncol(X)) # 2 x acumulada até estatística t negativa

## Organizando os resultados da regressao em uma matriz
results = cbind(beta_hat, std_err, t_stat, p_value)

## Nomeando as colunas da matriz de resultados
colnames(results) = c('Estimate', 'Std. Error', 't stat', 'Pr(>|t|)')
results
```

```
##              Estimate Std. Error    t stat     Pr(>|t|)
## constante 37.22727012 1.59878754 23.284689 2.565459e-20
## hp        -0.03177295 0.00902971 -3.518712 1.451229e-03
## wt        -3.87783074 0.63273349 -6.128695 1.119647e-06
```




{{< cta cta_text="👉 Seguir para Otimização Numérica" cta_link="../sec9" >}}
