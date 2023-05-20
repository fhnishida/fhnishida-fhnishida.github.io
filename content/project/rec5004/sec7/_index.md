---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Optimization
summary: The author covers topics such as grid search and steepest ascent methods for optimization to show three approaches to reach the OLS estimation formula. The page also includes examples and code snippets to illustrate the concepts discussed.
title: Optimization
weight: 7
output: md_document
type: book
---




## Otimização numérica
- Essa seção tem o objetivo para dar uma intuição sobre métodos de otimização.
- Veremos os métodos de _grid search_ e _gradient ascent_ (_descent_) que representam famílias de métodos de otimização.


### _Grid Search_

- O método mais simples de otimização numérica é o _grid search_ (discretização).
- Como o R não lida com problemas com infinitos valores, uma forma lidar com isso é discretizando diversos possíveis valores dos parâmetros de escolha dentro de intervalos.
- Para cada possível combinação de parâmetros, calculam-se diversos valores a partir da função objetivo. De todos os valores calculados, escolhe-se a combinação de parâmetros que maximizam (ou minimizam) a função objetivo.
- O exemplo abaixo considera apenas um parâmetro de escolha {{<math>}}$\beta${{</math>}} e, para cada ponto escolhido dentro do intervalo {{<math>}}$(-1, 1)${{</math>}}, calcula-se a função objetivo:

<center><img src="../grid_search.png"></center>


- Este é um método robusto a funções com descontinuidades e quinas (não diferenciáveis), e menos sensível a chutes de valores iniciais. (ver método abaixo)
- Porém, este método fica preciso apenas com maiores quantidades de pontos e, como é necessário fazer o cálculo da função objetivo para cada ponto, o _grid search_ tende a ser menos eficiente computacionalmente (demora mais tempo para calcular).


### _Gradient Ascent (Descent)_

- Conforme o número de parâmetros do modelo cresce, aumenta o número de possíveis combinações entre parâmetros e torna o processo computacional cada vez mais demandante.
- Uma forma mais eficiente de encontrar o conjunto de parâmetros que otimizam a função objetivo é por meio do método _gradient ascent_ (_descent_).
- Queremos encontrar o {{<math>}}${\beta}^{**}${{</math>}} que é o parâmetro que maximiza globalmente a função objetivo
- Passos para encontrar um máximo:
  1. Comece com algum valor inicial de parâmetro, {{<math>}}${\beta}^0${{</math>}}
  2. Calcula-se o gradiente (vetor de derivadas parciais das variáveis) e a hessiana (matriz de segundas derivadas parciais) e avalia-se a possibilidade de "andar para cima" a um valor mais alto
  3. Caso possa, ande na direção correta a {{<math>}}${\beta}^1${{</math>}}
    3.1. gradiente dá a direção do passo
    3.2. hessiana dá o tamanho do passo
  4. Repita os passos (2) e (3), andando para um novo {{<math>}}${\beta}^2, {\beta}^3, ...${{</math>}} até atingir um ponto máximo

<center><img src="../steepest_ascent.png"></center>


- Note que esse método de otimização é sensível ao parâmetro inicial e às descontinuidades da função objetivo.
    - No exemplo, se os chutes iniciais forem {{<math>}}${\beta}^0_A${{</math>}} ou {{<math>}}${\beta}^0_B${{</math>}}, então consegue atingir o máximo global.
    - Já se o chute inicial for {{<math>}}${\beta}^0_C${{</math>}}, então ele acaba atingindo um máximo local com {{<math>}}${\beta}^*${{</math>}} (menor do que o máximo global em {{<math>}}${\beta}^{**}${{</math>}}).


<video width="500px" height="500px" controls="controls"/>
    <source src="../local-maxima.mp4" type="video/mp4">
</video>

- Por outro lado, é um método mais eficiente, pois calcula-se a função objetivo uma vez a cada passo, além de ser mais preciso nas estimações.



</br>

## Encontrando MQO por diferentes estratégias
- Nesta seção, encontraremos as estimativas de MQO usando as estratégias da (a) minimização da função perda, de (b) método dos momentos e de (c) máxima verossimilhança.
- Em cada uma delas, temos uma função objetivo distinta, que será avaliada a partir de um vetor com dois parâmetros, {{<math>}}$ \hat{\boldsymbol{\beta}} = \left\{ \hat{\beta}_0, \hat{\beta}_1 \right\} ${{</math>}}. No R, vamos chamar esse vetor de `params`.



### Base `mtcars`

Usaremos dados extraídos da _Motor Trend_ US magazine de 1974, que analisa o
consumo de combustível e 10 aspectos técnicos de 32 automóveis.

No _R_, a base de dados `mtcars` já está pré-carregada no programa e queremos estimar o seguinte modelo:
{{<math>}} $$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \varepsilon, $$ {{</math>}}
em que:

- _mpg_: consumo de combustível (milhas por galão)
- _hp_: potência (cavalos-vapor)


```r
## Regressao MQO
reg = lm(formula = mpg ~ hp, data = mtcars)
reg$coef
```

```
## (Intercept)          hp 
## 30.09886054 -0.06822828
```



### (a) Minimização da função perda
- A função perda adotada pela Teoria da Decisão é a **função de soma dos quadrados dos resíduos**
- Por essa estratégia, queremos encontrar as estimativas, {{<math>}}$\hat{\boldsymbol{\beta}} = \left\{ \hat{\beta}_0,\ \hat{\beta}_1 \right\}${{</math>}}, que **minimizam** essa função.


#### 1. Criar função perda que calcula a soma dos resíduos quadráticos
- A função para calcular a soma dos resíduos quadráticos recebe como inputs:
  - um **vetor** de possíveis valores {{<math>}}$\hat{\boldsymbol{\beta}} = \left\{ \hat{\beta}_0,\ \hat{\beta}_1 \right\}${{</math>}}
  - um **texto** com o nome da variável dependente
  - um **vetor de texto** com os nomes dos regressores
  - uma base de dados

```r
resid_quad = function(params, yname, xname, data) {
  # Extraindo as variáveis da base em vetores
  y = data[,yname]
  x = data[,xname]
  
  # Extraindo os parâmetros de params
  b0 = params[1]
  b1 = params[2]
  
  yhat = b0 + b1 * x # valores ajustados
  e_hat = y - yhat # desvios = observados - ajustados
  sum(e_hat^2)
}
```


#### 2. Otimização
- Agora encontraremos os parâmetros que minimizam a função perda

{{<math>}}$$ \underset{\hat{\beta}_0, \hat{\beta}_1}{\text{argmin}} \sum_{i=1}^{N}\hat{\varepsilon}^2_i \quad = \quad \underset{\hat{\beta}_0, \hat{\beta}_1}{\text{argmin}} \sum_{i=1}^{N}\left( \text{mpg}_i - \widehat{\text{mpg}}_i \right)^2 $${{</math>}}

- Para isto usaremos a função `optim()` que retorna os parâmetros que minimizam uma função (equivalente ao _argmin_):
```yaml
optim(par, fn, gr = NULL, ...,
      method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"),
      lower = -Inf, upper = Inf,
      control = list(), hessian = FALSE)

- par: Initial values for the parameters to be optimized over.
- fn: A function to be minimized (or maximized), with first argument the vector of parameters over which minimization is to take place. It should return a scalar result.
- method: The method to be used. See ‘Details’. Can be abbreviated.
- hessian: Logical. Should a numerically differentiated Hessian matrix be returned?
```
- Colocaremos como input:
  - a função perda criada `resid_quad()`
  - um chute inicial dos parâmetros
    - Note que a estimação pode ser mais ou menos sensível ao valores iniciais, dependendo do método de otimização utilizado
    - O mais comum é encontrar como chute inicial um vetor de zeros `c(0, 0)`, por ser mais neutro em relação ao sinal das estimativas
    - Em Econometria III, prof. Laurini recomendou usar método "Nelder-Mead" (padrão) com um chute inicial de zeros e, depois, usar suas estimativas como chute inicial para o método "BFGS".
  - Por padrão, temos o argumento `hessian = FALSE`, coloque `TRUE` se quiser calcular o erro padrão, estatística t e p-valor das estimativas.


```r
# Estimação por BFGS
theta_ini = c(0, 0) # Chute inicial de b0, b1

min_loss = optim(par=theta_ini, fn=resid_quad, 
                 yname="mpg", xname="hp", data=mtcars,
                 method="BFGS")
min_loss
```

```
## $par
## [1] 30.09886054 -0.06822828
## 
## $value
## [1] 447.6743
## 
## $counts
## function gradient 
##       31        5 
## 
## $convergence
## [1] 0
## 
## $message
## NULL
```

```r
# Comparando com estimativas via lm()
reg$coef
```

```
## (Intercept)          hp 
## 30.09886054 -0.06822828
```


</br>

### (b) Método dos Momentos
- [Computing Generalized Method of Moments and Generalized Empirical Likelihood with R (Pierre Chaussé)](https://cran.r-project.org/web/packages/gmm/vignettes/gmm_with_R.pdf)
- [Generalized Method of Moments (GMM) in R - Part 1 (Alfred F. SAM)](https://medium.com/codex/generalized-method-of-moments-gmm-in-r-part-1-of-3-c65f41b6199)

- Para estimar via GMM precisamos construir vetores relacionados aos seguintes momentos:

{{<math>}}$$ E(\boldsymbol{\varepsilon}) = 0 \qquad \text{ e } \qquad E(\boldsymbol{\varepsilon x}) = \boldsymbol{0} $${{</math>}}

Note que estes são os momentos relacionados ao MQO, dado que este é um caso particular do GMM. Os análogos amostrais são:

{{<math>}}$$ \frac{1}{N} \sum^N_{i=1}{\hat{\varepsilon}_i} = 0 \qquad \text{ e } \qquad \frac{1}{N} \sum^N_{i=1}{\hat{\varepsilon}_i.x_i} = 0 $${{</math>}}

Podemos calcular os dois momentos amostrais em uma única multiplicação matricial. Considere:

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}} = \begin{bmatrix} \varepsilon_1 \\ \varepsilon_2 \\ \vdots \\ \varepsilon_N \end{bmatrix} \qquad \text{e} \qquad \boldsymbol{x} = \begin{bmatrix} x_1 \\ x_2 \\ \vdots \\ x_N \end{bmatrix} $${{</math>}}

Vamos juntar uma coluna de 1's com {{<math>}}$\boldsymbol{x}${{</math>}} e definir a matriz:
{{<math>}}$$ \boldsymbol{X} = \begin{bmatrix} 1 & x_1 \\ 1 & x_2 \\ \vdots & \vdots \\ 1 & x_N \end{bmatrix} $${{</math>}}

Fazendo a multiplicação matricia entre {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}} e {{<math>}}$\boldsymbol{X}${{</math>}}, temos:

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}' \boldsymbol{X}\ =\ \begin{bmatrix} \varepsilon_1 & \varepsilon_2 & \cdots & \varepsilon_N \end{bmatrix} \begin{bmatrix} 1 & x_1 \\ 1 & x_2 \\ \vdots & \vdots \\ 1 & x_N \end{bmatrix}\ =\ \begin{bmatrix}  \sum^N_{i=1}{\hat{\varepsilon}_i} &  \sum^N_{i=1}{\hat{\varepsilon}_i .x_i} \end{bmatrix} $${{</math>}}

Note que o vetor resultante são exatamente os momentos amostrais, os quais queremos aproximá-los ao máximo de zero (0).



#### Otimização Numérica para GMM

##### 1. Chute de valores iniciais para {{<math>}}$\beta_0${{</math>}} e {{<math>}}$\beta_1${{</math>}}
- Vamos criar um vetor com possíveis valores de {{<math>}}$\beta_0, \beta_1${{</math>}}:

```r
params = c(30, -0.05)
yname = "mpg"
xname = "hp"
data = mtcars
```

##### 2. Seleção da base de dados e variáveis

```r
# Extraindo as variáveis da base em vetores
y = data[,yname]
x = data[,xname]

# Extraindo os parâmetros de params
b0 = params[1]
b1 = params[2]
```

##### 3. Cálculo dos valores ajustados e dos resíduos

```r
## Valores ajustados de y
yhat = b0 + b1 * x

## Resíduos
e_hat = y - yhat
```


##### 4. Criação da matriz de momentos
- Note que {{<math>}}$\hat{\boldsymbol{\varepsilon}}' X${{</math>}} um vetor dos momentos amostrais, mas a função `gmm()` exige uma matriz com **multiplicação elemento a elemento** do resíduo {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}} com as covariadas {{<math>}}$\boldsymbol{X}${{</math>}} (neste caso: constante e hp), na forma:

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}} \times \boldsymbol{X}\ =\ \begin{bmatrix} \varepsilon_1 \\ \varepsilon_2 \\ \vdots \\ \varepsilon_N \end{bmatrix} \times \begin{bmatrix} 1 & x_1 \\ 1 & x_2 \\ \vdots & \vdots \\ 1 & x_N \end{bmatrix}\ =\ \begin{bmatrix} \varepsilon_1 & \varepsilon_1.x_1  \\ \varepsilon_2 & \varepsilon_2.x_2 \\ \vdots & \vdots \\ \varepsilon_N & \varepsilon_N.x_N \end{bmatrix}, $${{</math>}}
em que {{<math>}}$\times${{</math>}} denota a multiplicação padrão, elemento a elemento por linha. Note que se fizermos as somas de cada coluna, obtemos os dois momentos amostrais.

Note que, para fazer o GMM no R, não devemos tirar a média de cada coluna (a própria função `gmm()` fará isso).



```r
# Matriz de momentos
m = as.numeric(e_hat) * as.numeric(e_hat) * cbind(1,x) # multiplicação por elemento
apply(m, 2, sum) # soma de cada coluna
```

```
##                     x 
##    708.275 106721.440
```
- Note que, como multiplicamos a constante igual a 1 com os resíduos {{<math>}}$\hat{\varepsilon}${{</math>}}, a 1ª coluna corresponde ao momento amostral {{<math>}}$\sum^N_{i=1}{\hat{\varepsilon}_i}${{</math>}} (mas sem dividir por _N_).
- Já a coluna 2 correspode ao momento amostral {{<math>}}$\sum^N_{i=1}{\hat{\varepsilon}_i .x_i}=0${{</math>}} para a variável _hp_ (mas sem dividir por _N_).
- Logicamente, para estimar por GMM, precisamos escolher os parâmetros {{<math>}}$\hat{\boldsymbol{\beta}} = \{ \hat{\beta}_0, \hat{\beta}_1 \}${{</math>}} que, ao tomar a esperança em cada um destas colunas, se aproximem ao máximo de zero. Isso será feito via função `gmm()` (semelhante à função `optim()`)


##### 5. Criação de função com os momentos
- Vamos criar uma função que tem como input um vetor de parâmetros (`params`) e uma base de dados (`data`), e que retorna uma matriz em que cada coluna representa um momento.
- Essa função incluirá todos os comandos descritos nos itens 1 a 4 (que, na verdade, apenas foram feitos por didática).

```r
mom_ols = function(params, args) {
  # No gmm(), só pode ter 1 input dos argumentos dessa função
  # Por isso, foi incluído uma lista com 3 argumentos
  yname = args[[1]]
  xname = args[[2]]
  data = args[[3]]
  
  # Extraindo as variáveis da base em vetores
  y = data[,yname]
  x = data[,xname]
  
  # Extraindo os parâmetros de params
  b0 = params[1]
  b1 = params[2]
  
  ## Valores ajustados de y
  yhat = b0 + b1 * x
  
  ## Resíduos
  e_hat = y - yhat
  
  ## Matriz de momentos
  m = as.numeric(e_hat) * cbind(1,x)
  m # output da função
}
```


##### 6. Otimização via função `gmm()`
- A função `gmm()`, assim como a `optim()`, recebe uma função como argumento.
- No entanto, ao invés de retornar um valor, a função que entra no `gmm()` retorna uma matriz, cujas médias das colunas queremos aproximar de zero. 

```r
gmm_lm = gmm::gmm(
  g=mom_ols, 
  x=list(yname="mpg", xname="hp", data=mtcars), # argumentos função
  t0=c(0,0), # chute inicial de params
  # wmatrix = "optimal", # matriz de ponderação
  optfct = "nlminb" # função de otimização
  )
gmm_lm$coef
```

```
##    Theta[1]    Theta[2] 
## 30.09886038 -0.06822828
```

```r
# Comparando com estimativas via lm()
reg$coef
```

```
## (Intercept)          hp 
## 30.09886054 -0.06822828
```


</br>

### (c) Máxima Verossimilhança
- [ResEcon 703](https://github.com/woerman/ResEcon703) - Week 6 (University of Massachusetts Amherst)
- A função objetivo é a função de verossimilhança que, ao contrário da função de soma de quadrado dos resíduos, queremos maximizá-la


#### Intuição do cálculo da função de verossimilhança
- Apenas para ilustrar a construção da função de verossimilhança, {{<math>}}$\mathcal{L}${{</math>}}, considere um modelo de probabilidade linear:
{{<math>}}$$ \text{am} = \beta_0 + \beta_1 \text{cyl} + \varepsilon, $${{</math>}}
em que _cyl_ é a quantidade de cilindros do carro, e _am_ é uma variável _dummy_ que é igual a 1 se o carro for automático e 0 caso contrário.

- Queremos encontrar {{<math>}}$\hat{\boldsymbol{\beta}} = \left\{ \hat{\beta}_0, \hat{\beta}_1 \right\}${{</math>}} que maximizam a função de verossimilhança.
- Considere um chute de parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}_A = \left\{ \hat{\beta}^A_0 = 1.3, \hat{\beta}^A_1 = -0.14 \right\}${{</math>}} que gerem os seguintes valores preditos/ajustados (probabilidades):

<center><img src="../likelihood_A.png" width=80%></center>


- Logo, a verossimilhança, dado os parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}_A${{</math>}} é
{{<math>}}$$ \mathcal{L}(\boldsymbol{\beta}^A) = 46\% \times 46\% \times 74\% \times 54\% \times 82\% = 6,9\% $${{</math>}}

- Agora, considere um segundo chute de parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}_B = \left\{ \beta^B_0=1.0, \beta^B_1=-0.10 \right\}${{</math>}} que gerem as seguintes probabilidades:

<center><img src="../likelihood_B.png" width=80%></center>

- Então, a verossimilhança, dado {{<math>}}$\hat{\boldsymbol{\beta}}_B${{</math>}}, é
{{<math>}}$$ \mathcal{L}(\hat{\boldsymbol{\beta}}_B) = 40\% \times 40\% \times 60\% \times 60\% \times 80\% = 4,6\% $${{</math>}}
- Como {{<math>}}$\mathcal{L}\left(\hat{\boldsymbol{\beta}}_A\right) = 6,9\% > 4,6\% = \mathcal{L}\left(\hat{\boldsymbol{\beta}}_B\right)${{</math>}}, então os parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}_A${{</math>}} se mostram mais adequados em relação a {{<math>}}$\hat{\boldsymbol{\beta}}_B${{</math>}}
- Na estratégia de máxima verossimilhança (ML), escolhe-se o conjunto de parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}^*${{</math>}} que maximiza a função de verossimilhança (ou log-verossimilhança).






#### Otimização Numérica para Máxima Verossimilhança

- No modelo de probabilidade linear, as probabilidades usadas para calcular a verossimilhança são as próprias probabilidades de ser automático (se for carro automático) ou de ser manual (se for carro manual), dado um conjunto de parâmetros.
- Já no modelo linear, usamos a função de densidade de probabilidade para avaliar a "probabilidade" de cada observação, {{<math>}}$y_i${{</math>}}, ser o ser valor ajustado {{<math>}}$\hat y_i${{</math>}}, dado um conjunto de parâmetros {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} e {{<math>}}$\hat{\sigma}${{</math>}}.

<center><img src="../mle.jpg"></center>

- Como demonstra a figura acima, assumimos que o erro {{<math>}}$\varepsilon${{</math>}} é normalmente distribuído para todo `\(x\)`, com a mesma variância {{<math>}}$\sigma^2${{</math>}} (homocedasticidade)

- Em nosso modelo
{{<math>}} $$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \varepsilon, $$ {{</math>}}
queremos estimar 3 parâmetros
{{<math>}}$$ \hat{\boldsymbol{\beta}} = \left\{ \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma} \right\}, $${{</math>}}
em que {{<math>}}$\hat{\sigma}${{</math>}} é desvio padrão do resíduo.

- A função `ml2()` do pacote `bbmle`, que será usada para desempenhar a otimização numérica, assim como `optim()`. Precisamos usar como input:
  - Alguns valores inicias dos parâmetros, {{<math>}}$\hat{\boldsymbol{\beta}}^0 = \left\{ \hat{\beta}^0_0, \hat{\beta}^0_1, \hat{\sigma}^0 \right\}${{</math>}}
  - Uma função que tome esses parâmetros como argumento e calcule a 
log-verossimilhança, {{<math>}}$\ln{L(\boldsymbol{\hat{\boldsymbol{\beta}}})}${{</math>}}.

> Como as funções de otimização costumam encontrar o mínimo de uma função objetivo, precisamos adaptar o output para o negativo função de log-verossimilhança. Ao minimizar o negativo de log-lik, estamos maximizando log-lik.

A função log-verossimilhança é dada por
{{<math>}}$$ \ln{L(\hat{\beta}_0, \hat{\beta}_1, \hat{\sigma} | y, x)} = \sum^n_{i=1}{\ln{f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})}}, $${{</math>}}
em que a distribuição condicional de cada {{<math>}}$y_i${{</math>}} é

{{<math>}}$$ y_i | x_i \sim \mathcal{N}(\hat{\beta}_0 + \hat{\beta}_1 x_i, \hat{\sigma}) $${{</math>}}
o que implica que 

{{<math>}}$$\varepsilon_i | x_i \sim N(0, \sigma^2)$${{</math>}}

<!-- <center><img src="../mle.jpg"></center> -->

Passos para estimar uma regressão por máxima verossimilhança:

1. Chutar valores iniciais de 
2. Calcular os valores ajustados, {{<math>}}$\hat{y}${{</math>}}
3. Calcular a densidade para cada {{<math>}}$y_i${{</math>}}, usando {{<math>}}$f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})${{</math>}}
4. Calcular a log-verossimilhança, {{<math>}}$\sum^n_{i=1}{\ln{f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})}}${{</math>}}


##### 1. Chute de valores iniciais para {{<math>}}$\beta_0, \beta_1${{</math>}} e {{<math>}}$\sigma^2${{</math>}}
- Note que, diferente da estimação por MQO, um dos parâmetros a ser estimado via MLE é a variância ({{<math>}}$\sigma^2${{</math>}}).

```r
params = c(30, -0.06, 1)
# (b0, b1 , sig2)
```

##### 2. Seleção da base de dados e variáveis

```r
## Inicializando
yname = "mpg"
xname = "hp"
data = mtcars

# Extraindo as variáveis da base em vetores
y = data[,yname]
x = data[,xname]

# Extraindo os parâmetros de params
b0hat = params[1]
b1hat = params[2]
sighat = params[3]
```

##### 3. Cálculo dos valores ajustados e das densidades

```r
## Calculando valores ajustados de y
yhat = b0hat + b1hat * x
head(yhat)
```

```
## [1] 23.40 23.40 24.42 23.40 19.50 23.70
```

##### 4. Cálculo das densidades
{{<math>}}$$ f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma}) $${{</math>}}

```r
## Calculando os pdf's de cada linha
ypdf = dnorm(y, mean = yhat, sd = sighat)

head(round(ypdf, 4)) # Primeiros valores da densidade
```

```
## [1] 0.0224 0.0224 0.1074 0.0540 0.2897 0.0000
```

```r
sum(ypdf) # Verossimilhança
```

```
## [1] 2.447628
```

```r
prod(ypdf) # Log-Verossimilhança
```

```
## [1] 2.201994e-121
```
- Agora, vamos juntar visualizar os 6 primeiros elementos dos objetos trabalhados:

```r
# Juntando as bases e visualizando os primeiros valores
tab = cbind(y, x, yhat, round(ypdf, 4)) # arredondando ypdf (4 dígitos)
colnames(tab) = c("y", "x", "yhat", "ypdf") # renomeando colunas
head(tab)
```

```
##         y   x  yhat   ypdf
## [1,] 21.0 110 23.40 0.0224
## [2,] 21.0 110 23.40 0.0224
## [3,] 22.8  93 24.42 0.1074
## [4,] 21.4 110 23.40 0.0540
## [5,] 18.7 175 19.50 0.2897
## [6,] 18.1 105 23.70 0.0000
```
- Como pode ser visto na base de dados juntada e nos gráficos abaixo, quanto mais próximo o valor ajustado for do valor observado de cada observação, maior será a densidade/probabilidade.
<img src="/project/rec5004/sec7/_index_files/figure-html/unnamed-chunk-16-1.png" width="672" /><img src="/project/rec5004/sec7/_index_files/figure-html/unnamed-chunk-16-2.png" width="672" /><img src="/project/rec5004/sec7/_index_files/figure-html/unnamed-chunk-16-3.png" width="672" />
- Logo, a verossimilhança (produto de todas densidades de probabilidade) será maior quanto mais próximos forem os valores ajustados dos seus respectivos valores observados.


##### 5. Calculando a Log-Verossimilhança

A log-verossimilhança é a soma do log de todas probabilidades:

{{<math>}}$$ \mathcal{l}(\hat{\beta}_0, \hat{\beta}_1, \hat{\sigma}) = \sum^{N}_{i=1}{\ln\left[ f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma}) \right]} $${{</math>}}

```r
## Calculando a log-verossimilhanca
loglik = sum(log(ypdf))
loglik
```

```
## [1] -277.8234
```


##### 6. Criando a Função de Log-Verossimilhança

Juntando tudo que fizemos anteriormente, podemos criar uma função no R que calcular a função de log-verossimilhança.


```r
## Criando função para calcular log-verossimilhanca de OLS
loglik_lm = function(b0hat, b1hat, sighat) {
  # Extraindo as variáveis da base em vetores
  y = as.matrix(data[,yname])
  x = as.matrix(data[,xname])

  ## Calculando valores ajustados de y
  yhat = b0hat + b1hat * x
  
  ## Calculando os pdf's de cada linha
  ypdf = dnorm(y, mean = yhat, sd = sighat)
  
  ## Calculando a log-verossimilhanca
  loglik = sum(log(ypdf))
  
  ## Retornando o negativo da log-verossimilanca
  -loglik # Negativo, pois mle2() minimiza e queremos maximizar
}
```


##### 7. Otimização

Tendo a função objetivo, usaremos `mle2()` para *minimizar o negativo* da função de log-verossimilhança

{{<math>}}$$ \min_{(\hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})} -\sum^n_{i=1}{\ln{f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})}} = \max_{(\hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})} \sum^n_{i=1}{\ln{f(y_i | x_i, \hat{\beta}_0, \hat{\beta}_1, \hat{\sigma})}} $${{</math>}}



```r
## Maximizando a função log-verossimilhança de OLS
mle_ols = bbmle::mle2(
  minuslogl=loglik_lm,
  start=list(b0hat=0, b1hat=0, sighat=1),
  data=list(yname = "mpg", xname = "hp", data = mtcars),
  hessian=T
  )
mle_ols
```

```
## 
## Call:
## bbmle::mle2(minuslogl = loglik_lm, start = list(b0hat = 0, b1hat = 0, 
##     sighat = 1), data = list(yname = "mpg", xname = "hp", data = mtcars), 
##     hessian.opts = T)
## 
## Coefficients:
##       b0hat       b1hat      sighat 
## 30.09886884 -0.06822833  3.74029716 
## 
## Log-likelihood: -87.62
```

```r
# Comparando com estimativas via lm()
reg$coef
```

```
## (Intercept)          hp 
## 30.09886054 -0.06822828
```



</br>

{{< cta cta_text="👉 Proceed to Multiple Regression" cta_link="../sec8" >}}
