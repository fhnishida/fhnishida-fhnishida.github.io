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



## Regressão Múltipla na Prática (via `lm()`)

- [Seção 3.1 de Heiss (2020)](http://www.urfie.net/read/index.html#page/115)

- Para estimar um modelo multivariado no R, podemos usar a função `lm()`:
  - O til (`~`) separa a a variável dependente das variáveis independentes
  - As variáveis independentes precisam ser separadas por um `+`
  - A constante ({{<math>}}$\beta_0${{</math>}}) é incluída automaticamente pela função `lm()` -- para retirá-la, precisa incluir a "variável independente" `0` na fórmula.


#### Exemplo 3.1: Determinantes da Nota Média em Curso Superior nos EUA (Wooldridge, 2006)
- Sejam as variáveis
    - `colGPA` (_college GPA_): a nota média em um curso superior,
    - `hsGPA` (_high school GPA_): a nota médio do ensino médio, e
    - `ACT` (_achievement test score_): a nota de avaliação de conhecimentos para ingresso no ensino superior.
- Usando a base `gpa1` do pacote `wooldridge`, vamos estimar o seguinte modelo:

$$ \text{colGPA} = \beta_0 + \beta_1 \text{hsGPA} + \beta_2 \text{ACT} + u $$


```r
# Acessando a base de dados gpa1
data(gpa1, package = "wooldridge")

# Estimando o modelo
GPAres = lm(colGPA ~ hsGPA + ACT, data = gpa1)
GPAres
```

```
## 
## Call:
## lm(formula = colGPA ~ hsGPA + ACT, data = gpa1)
## 
## Coefficients:
## (Intercept)        hsGPA          ACT  
##    1.286328     0.453456     0.009426
```

- Podemos obter um resumo mais detalhado dos resultados usando a função `summary()`:

```r
summary(GPAres)
```

```
## 
## Call:
## lm(formula = colGPA ~ hsGPA + ACT, data = gpa1)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.85442 -0.24666 -0.02614  0.28127  0.85357 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 1.286328   0.340822   3.774 0.000238 ***
## hsGPA       0.453456   0.095813   4.733 5.42e-06 ***
## ACT         0.009426   0.010777   0.875 0.383297    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3403 on 138 degrees of freedom
## Multiple R-squared:  0.1764,	Adjusted R-squared:  0.1645 
## F-statistic: 14.78 on 2 and 138 DF,  p-value: 1.526e-06
```

- Note que o {{<math>}}R$^2${{</math>}} é de 0,1764, ou seja, os dois regressores (`hsGPA` e `ACT`) explicam 17,64\% da variância da nota média em um curso superior (`colGPA`).



## MQO na forma matricial

### Notações

- Para mais detalhes sobre a forma matricial do MQO, ver Apêndice E de Wooldridge (2006)
- Considere o modelo multivariado com {{<math>}}$K${{</math>}} regressores para a observação {{<math>}}$i${{</math>}}:
$$ y_i = \beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + ... + \beta_K x_{iK} + u_i, \qquad i=1, 2, ..., N \tag{E.1} $$
em que {{<math>}}$N${{</math>}} é o número de observações.

- Defina o vetor-coluna de parâmetros, {{<math>}}$\boldsymbol{\beta}${{</math>}}, e o vetor-linha de variáveis independentes da observação {{<math>}}$i${{</math>}}, {{<math>}}$\boldsymbol{x}_i${{</math>}} (minúsculo):
{{<math>}}$$ \underset{1 \times K}{\mathbf{x}_i} = \left[ \begin{matrix} 1 & x_{i1} & x_{i2} & \cdots & x_{iK}  \end{matrix} \right]  \qquad \text{e} \qquad  \underset{(K+1) \times 1}{\boldsymbol{\beta}} = \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{matrix} \right],$${{</math>}}

- Note que o produto interno {{<math>}}$\mathbf{x}_i \boldsymbol{\beta}${{</math>}} é:

{{<math>}}$$ \underset{1 \times 1}{\mathbf{x}_i \boldsymbol{\beta}} = \left[ \begin{matrix} 1 & x_{i1} & x_{i2} & \cdots & x_{iK}  \end{matrix} \right]  \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{matrix} \right] = 1.\beta_0 + x_{i1} \beta_1  + x_{i2} \beta_2 + \cdots + x_{iK} \beta_K,$${{</math>}}

- Logo, a equação (3.1) pode ser reescrita como

$$ y_i = \underbrace{\beta_0 + \beta_1 x_{i1} + \beta_2 x_{i2} + ... + \beta_K x_{iK}}_{\mathbf{x}_i \boldsymbol{\beta}} + u_i = \mathbf{x}_i \boldsymbol{\beta} + u_i, \qquad i=1, 2, ..., N \tag{E.2} $$

- Considere {{<math>}}$\mathbf{X}${{</math>}} a matriz de todas {{<math>}}$N${{</math>}} observações para as {{<math>}}$K+1${{</math>}} variáveis explicativas:

{{<math>}}$$ \underset{N \times (K+1)}{\mathbf{X}} = \left[ \begin{matrix} \mathbf{x}_1 \\ \mathbf{x}_2 \\ \vdots \\ \mathbf{x}_N \end{matrix} \right] = \left[ \begin{matrix} 1 & x_{11} & x_{12} & \cdots & x_{1K}   \\ 1 & x_{21} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & x_{N1} & x_{N2} & \cdots & x_{NK} \end{matrix} \right] , $${{</math>}}

- Agora, podemos "empilhar" as equações (3.2) para todo {{<math>}}$i=1, 2, ..., N${{</math>}} e obtemos:

{{<math>}}\begin{align} \mathbf{y} = \mathbf{X} \boldsymbol{\beta} + \mathbf{u} &= \left[ \begin{matrix} 1 & x_{11} & x_{12} & \cdots & x_{1K}   \\ 1 & x_{21} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & x_{N1} & x_{N2} & \cdots & x_{NK} \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{matrix} \right] + \left[ \begin{matrix}u_1 \\ u_2 \\ \vdots \\ u_N \end{matrix} \right] \\
&= \left[ \begin{matrix} \beta_0. 1 + \beta_1 x_{11} + \beta_2 x_{12} + ... + \beta_K x_{1K} + u_1 \\ \beta_0 .1 + \beta_1 x_{21} + \beta_2 x_{22} + ... + \beta_K x_{2K} + u_2 \\ \vdots \\ \beta_0. 1 + \beta_1 x_{N1} + \beta_2 x_{N2} + ... + \beta_K x_{NK} + u_N \end{matrix} \right] = \left[ \begin{matrix}y_1 \\ y_2 \\ \vdots \\ y_N \end{matrix} \right] \tag{E.3} \end{align}{{</math>}}


em que:
{{<math>}}$$  \underset{N\times 1}{\mathbf{y}} = \left[ \begin{matrix} y_1 \\ y_2 \\ \vdots \\ y_N \end{matrix} \right]  \qquad \text{e} \qquad \underset{N\times 1}{\mathbf{u}} = \left[ \begin{matrix}u_1 \\ u_2 \\ \vdots \\ u_N \end{matrix} \right]. $${{</math>}}

- O estimador de MQO {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} pode ser obtido pela seguinte fórmula (Wooldridge, 2006):

$$ \hat{\boldsymbol{\beta}} = \left[ \begin{matrix} \hat{\beta}_0 \\ \hat{\beta}_1 \\ \hat{\beta}_2 \\ \vdots \\ \hat{\beta}_K \end{matrix} \right] = (\mathbf{X}'\mathbf{X})^{-1} \mathbf{X}' \mathbf{y} \tag{3.2} $$


### Aplicando no R

- No R, queremos encontrar as estimativas para {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}}:
  - Transposta...




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
