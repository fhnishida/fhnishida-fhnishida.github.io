---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: OLS Estimation
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: OLS Estimation
weight: 7
output: md_document
type: book
---



É necessário carregar o pacote `dplyr` para manipulação da base de dados abaixo.

```r
library(dplyr)
```


## Base de dados `mtcars`

Usaremos dados extraídos da _Motor Trend_ US magazine de 1974, que analisa o
consumo de combustível e 10 aspectos técnicos de 32 automóveis.

No _R_, a base de dados já está incorporada ao programa e pode ser acessada pelo
código `mtcars`, contendo a seguinte estrutura:

> - _mpg_: milhas por galão
> - _cyl_: número de cilindros 
> - _disp_: deslocamento do motor
> - _hp_: cavalos-vapor bruto
> - _drat_: razão eixo traseiro
> - _wt_: peso (1000 libras)
> - _qsec_: tempo de 1/4 de milha
> - _vs_: motor (0 = forma de V, 1 = reto)
> - _am_: transmissão (0 = automático, 1 = manual)
> - _gear_: número de marchas


Façamos um resumo da base de dados:


```r
### Examinaremos a base da dados mtcars
## Estrutura de mtcars
str(mtcars)
```

```
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```

```r
## Selecionando 3 variáveis e resumindo 
mtcars %>% 
  select(mpg, hp, wt) %>% 
  summary()
```

```
##       mpg              hp              wt       
##  Min.   :10.40   Min.   : 52.0   Min.   :1.513  
##  1st Qu.:15.43   1st Qu.: 96.5   1st Qu.:2.581  
##  Median :19.20   Median :123.0   Median :3.325  
##  Mean   :20.09   Mean   :146.7   Mean   :3.217  
##  3rd Qu.:22.80   3rd Qu.:180.0   3rd Qu.:3.610  
##  Max.   :33.90   Max.   :335.0   Max.   :5.424
```

```r
## Plotando consumo de combustível (mpg) por potência do carro (hp)
plot(mtcars$mpg, mtcars$hp, xlab="Milhas por galão (mpg)", ylab="Cavalos-vapor (hp)")
```

<img src="/project/rec2301/chapter7/_index_files/figure-html/unnamed-chunk-2-1.png" width="672" />

```r
## Plotando consumo de combustível (mpg) por peso do carro (wt)
plot(mtcars$mpg, mtcars$wt, xlab="Milhas por galão (mpg)", ylab="Libras (wt)")
```

<img src="/project/rec2301/chapter7/_index_files/figure-html/unnamed-chunk-2-2.png" width="672" />

Queremos estimar o seguinte modelo:
{{<math>}}$$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \beta_2 \text{wt} + \varepsilon  $${{</math>}}


## Estimação por OLS

### Usando a função `lm()`

```
lm(formula, data, subset, weights, na.action,
   method = "qr", model = TRUE, x = FALSE, y = FALSE, qr = TRUE,
   singular.ok = TRUE, contrasts = NULL, offset, ...)
   
formula: an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.
data: an optional data frame, list or environment (or object coercible by as.data.frame to a data frame) containing the variables in the model.
weights: an optional vector of weights to be used in the fitting process. Should be NULL or a numeric vector.
```
- Em `formula` você irá inserir a variável dependente separada por `~` das variáveis independentes. Estas serão separadas por um `+`. Neste exemplo: `formula = mpg ~ hp + wt`
  - Para incluir uma interação entre variáveis independentes, usa-se `<var1>:<var2>`. Por exemplo: `formula = mpg ~ hp + wt + hp:am`
  - Para fazer uma alteraçao em alguma variável dentro da função `lm()`, usa-se `I()`. Por exemplo, para incluir também o peso do carro, _wt_, ao quadrado: `formula = mpg ~ hp + wt + I(wt^2)`
- Em `data`, será atribuída uma base de dados e, em `weights`, é possível atribuir ponderações para cada observação (bastante comum em bases providas pelo IBGE, como PNAD e POF)

Vamos regredir o consumo de combustível (_mpg_) pela potência (_hp_) e pelo peso (_wt_) do carro:

```r
## Rodar a regressao OLS
fit_ols1 = lm(formula = mpg ~ hp + wt, data = mtcars)

## Resumir os resultados da regressao
summary(fit_ols1)
```

```
## 
## Call:
## lm(formula = mpg ~ hp + wt, data = mtcars)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -3.941 -1.600 -0.182  1.050  5.854 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 37.22727    1.59879  23.285  < 2e-16 ***
## hp          -0.03177    0.00903  -3.519  0.00145 ** 
## wt          -3.87783    0.63273  -6.129 1.12e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.593 on 29 degrees of freedom
## Multiple R-squared:  0.8268,	Adjusted R-squared:  0.8148 
## F-statistic: 69.21 on 2 and 29 DF,  p-value: 9.109e-12
```

- É possível extrair informações da regressão:

```r
names(fit_ols1) # verificar todas informações contidas no objeto da regressão
```

```
##  [1] "coefficients"  "residuals"     "effects"       "rank"         
##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
##  [9] "xlevels"       "call"          "terms"         "model"
```

```r
fit_ols1$coefficients # Estimativas
```

```
## (Intercept)          hp          wt 
## 37.22727012 -0.03177295 -3.87783074
```

```r
summary(fit_ols1)$coefficients # Estimativas pelo summary()
```

```
##                Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 37.22727012 1.59878754 23.284689 2.565459e-20
## hp          -0.03177295 0.00902971 -3.518712 1.451229e-03
## wt          -3.87783074 0.63273349 -6.128695 1.119647e-06
```

```r
head(fit_ols1$fitted.values) # valores ajustados
```

```
##         Mazda RX4     Mazda RX4 Wag        Datsun 710    Hornet 4 Drive 
##          23.57233          22.58348          25.27582          21.26502 
## Hornet Sportabout           Valiant 
##          18.32727          20.47382
```

```r
head(fit_ols1$residuals) # resíduos
```

```
##         Mazda RX4     Mazda RX4 Wag        Datsun 710    Hornet 4 Drive 
##        -2.5723294        -1.5834826        -2.4758187         0.1349799 
## Hornet Sportabout           Valiant 
##         0.3727334        -2.3738163
```

#### Variáveis categóricas
- Ao inserir **variáveis categóricas** na regressão, criam-se _dummies_ para cada categoria e retira-se uma delas para evitar problema de multicolinearidade:
- No exemplo abaixo, transformaremos a variável de cilindros (_cyl_), que possui apenas 3 valores (4, 6, e 8), na classe _factor_.

```r
mtcars_factor1 = mtcars %>% mutate(cyl = factor(cyl))
summary( lm(mpg ~ cyl, data=mtcars_factor1) )$coef
```

```
##               Estimate Std. Error   t value     Pr(>|t|)
## (Intercept)  26.663636  0.9718008 27.437347 2.688358e-22
## cyl6         -6.920779  1.5583482 -4.441099 1.194696e-04
## cyl8        -11.563636  1.2986235 -8.904534 8.568209e-10
```
- Note que criou apenas 2 _dummies_ de cilindros (_cyl6_ e _cyl8_), sendo que as suas estimativas são negativas e significativas em relação ao carro com 4 cilindros (_cyl4_) que é a caregoria omitida para evitar multicolinearidade.
- Podemos também definir a categoria a ser omitida usando as funções:
  - `factor(..., levels=c(...))`, quando transforma um vetor em factor (omite o 1º)
  - `relevel(..., ref="")`, quando o vetor já é da classe factor e quer apenas alterar os níveis
- Para omitir _cyl8_ fazemos:

```r
# Via relevel() - via factor já existente
mtcars_factor1$cyl = relevel(mtcars_factor1$cyl, ref="8")
summary( lm(mpg ~ cyl, data=mtcars_factor1) )$coef
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 15.100000  0.8614094 17.529412 5.660681e-17
## cyl4        11.563636  1.2986235  8.904534 8.568209e-10
## cyl6         4.642857  1.4920048  3.111825 4.152209e-03
```

```r
# Via factor() - omite o 1º nível
mtcars_factor2 = mtcars %>% mutate(cyl = factor(cyl, levels = c(8, 4, 6)))
summary( lm(mpg ~ cyl, data=mtcars_factor2) )$coef
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 15.100000  0.8614094 17.529412 5.660681e-17
## cyl4        11.563636  1.2986235  8.904534 8.568209e-10
## cyl6         4.642857  1.4920048  3.111825 4.152209e-03
```
- Observe que as estimativas estão positivas agora, dado que a referência agora é _cyl8_

#### Exportando output em LaTeX
- Podemos usar os pacotes `stargazer` e `textreg` para gerar o output da regressão em LaTeX
- As funções têm os mesmos nomes dos pacotes:
```r
stargazer::stargazer(fit_ols1)
texreg::texreg(fit_ols1)
```
- Depois, copie o output e jogue num programa de LaTeX.


### Estimação Analítica
- [ResEcon 703](https://github.com/woerman/ResEcon703) - Week 2 (University of Massachusetts Amherst)

#### 1. Construir matrizes de covariadas `\(X\)` e da variável dependente `\(y\)`

```r
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


#### 2. Estimador `\(\hat{\beta}\)`
O estimador de OLS é dado por:
{{<math>}}$$ \hat{\beta} = (X'X)^{-1} X' y $${{</math>}}


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


#### 3. Calcular os valores ajustados `\(\hat{y}\)`
{{<math>}}$$ \hat{y} = X\hat{\beta} $${{</math>}}

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


#### 4. Calcular os resíduos `\(e\)`
{{<math>}}$$ \varepsilon = y - \hat{y} $${{</math>}}

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


#### 5. Calcular a variância do termo de erro `\(s^2\)`
{{<math>}}$$ \hat{\sigma}^2 = \frac{e'e}{n-k} $${{</math>}}

```r
## Estimando variancia do termo de erro
sigma2 = t(e) %*% e / (nrow(X) - ncol(X))
sigma2
```

```
##          e
## e 6.725785
```


#### 6. Calcular a matriz de covariâncias `\(\hat{Cov}(\widehat{\beta})\)`
{{<math>}}$$ \widehat{Cov}(\hat{\beta}) = \hat{\sigma}^2 (X'X)^{-1} $${{</math>}}

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


### Estimação Numérica

#### 1. Criar função perda que calcula a soma dos desvios quadráticos
- A função para calcular a soma dos desvios quadráticos recebe como inputs:
  - um **vetor** de possíveis valores para {{<math>}}$\beta_0${{</math>}}, {{<math>}}$\beta_1${{</math>}} e {{<math>}}$\beta_2${{</math>}}
  - uma base de dados

```r
desv_quad = function(params, data) {
  # Extraindo os parâmetros para objetos
  beta_0 = params[1]
  beta_1 = params[2]
  beta_2 = params[3]
  
  mpg_ajustado = beta_0 + beta_1*data$hp + beta_2*data$wt # valores ajustados
  desvios = data$mpg - mpg_ajustado # desvios = observados - ajustados
  sum(desvios^2)
}
```


#### 2. Otimização
- Agora encontraremos os parâmetros que minimizam a função perda
{{<math>}}$$ \text{argmin}_{\theta \in \Theta} \sum_{i=1}^{N}\left( \text{mpg}_i - \widehat{\text{mpg}}_i \right)^2 $${{</math>}}
- Para isto usaremos a função `optim()` que retorna os parâmetros que minimizam uma função (equivalente ao _argmin_):
```yaml
optim(par, fn, gr = NULL, ...,
      method = c("Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"),
      lower = -Inf, upper = Inf,
      control = list(), hessian = FALSE)

par: Initial values for the parameters to be optimized over.
fn: A function to be minimized (or maximized), with first argument the vector of parameters over which minimization is to take place. It should return a scalar result.
method: The method to be used. See ‘Details’. Can be abbreviated.
hessian: Logical. Should a numerically differentiated Hessian matrix be returned?
```
- Colocaremos como input:
  - a função perda criada `desv_quad()`
  - um chute inicial dos parâmetros
    - Note que a estimação pode ser mais ou menos sensível ao valores iniciais, dependendo do método de otimização utilizado
    - O mais comum é encontrar como chute inicial um vetor de zeros `c(0, 0, 0)`, por ser mais neutro em relação ao sinal das estimativas
    - Em Econometria III, prof. Laurini recomendou usar método "Nelder-Mead" (padrão) com um chute inicial de zeros e, depois, usar suas estimativas como chute inicial para o método "BFGS".
  - Por padrão, temos o argumento `hessian = FALSE`, coloque `TRUE` para calcularmos o erro padrão, estatística t e p-valor das estimativas


```r
# Estimação por BFGS
theta_ini = c(0, 0, 0) # Chute inicial de beta_0, beta_1 e beta_2

fit_ols2 = optim(par=theta_ini, fn=desv_quad, data=mtcars,
                  method="BFGS", hessian=TRUE)
fit_ols2
```

```
## $par
## [1] 37.22727012 -0.03177295 -3.87783074
## 
## $value
## [1] 195.0478
## 
## $counts
## function gradient 
##       34        6 
## 
## $convergence
## [1] 0
## 
## $message
## NULL
## 
## $hessian
##          [,1]       [,2]       [,3]
## [1,]   64.000    9388.00   205.9040
## [2,] 9388.000 1668556.00 32943.4880
## [3,]  205.904   32943.49   721.8021
```

## Métodos de Otimização Básicos
- Essa seção tem o objetivo para dar uma intuição sobre métodos de otimização e está baseada em Hamilton (1994), seção 5.7.
- Veremos os métodos de _grid search_ (discretização) e _steepest ascent_ que são métodos simples, mas que representam famílias de métodos de otimização.
- Para maior profundidade no assunto, sugiro cursar disciplina de Economia Computacional.

### _Grid Search_

- O método mais simples de otimização numérica é o _grid search_ (discretização).
- Como o R não lida com problemas com infinitos valores, uma forma lidar com isso é discretizando diversos possíveis valores dos parâmetros de escolha dentro de intervalos.
- Para cada possível combinação de parâmetros, calculam-se diversos valores a partir da função objetivo. De todos os valores calculados, escolhe-se a combinação de parâmetros que maximizam (ou minimizam) a função objetivo.
- O exemplo abaixo considera apenas um parâmetro de escolha {{<math>}}$\theta${{</math>}} e, para cada ponto escolhido dentro do intervalo {{<math>}}$[-1, 1]${{</math>}}, calcula-se a função objetivo:

<center><img src="../grid_search.png"></center>

- Este é um método robusto a funções com descontinuidades e quinas (não diferenciáveis), e menos sensível a chutes de valores iniciais. (ver método abaixo)
- Porém, por ter que fazer cálculo da função objetivo para inúmeros pontos, tende a ser menos eficiente.


### _Steepest Ascent_

- Conforme o número de parâmetros do modelo cresce, aumenta o número de possíveis combinações entre parâmetros e torna o processo computacional cada vez mais lento.
- Uma forma mais eficiente de encontrar o conjunto de parâmetros que otimizam a função objetivo é por meio do método _steepest ascent_.
- Seja {{<math>}}$\theta^*${{</math>}} o conjunto de parâmetros que maximiza a função objetivo:
  1. Comece com alguns valores iniciais dos parâmetros, {{<math>}}$\theta^0${{</math>}}
  2. Calcula-se o gradiente e avalia-se a possibilidade de "andar para cima" a um valor mais alto
  3. Caso possa, ande na direção correta a {{<math>}}$\theta_1${{</math>}}
  4. Repita os passos (2) e (3), andando de {{<math>}}$\theta^s${{</math>}} para {{<math>}}$\theta^{s+1}${{</math>}} até
  atingir o máximo com {{<math>}}$\theta^*${{</math>}}.

<center><img src="../steepest_ascent.png"></center>

- Note que esse método de otimização é sensível ao conjunto de parâmetros iniciais e a descontinuidades da função objetivo.
- Por outro lado, é um método mais eficiente (calcula uma função objetivo dado os parâmetros a cada passo que dá) e tende a ser também mais preciso nas estimações.



## Estimação por MLE
- [ResEcon 703](https://github.com/woerman/ResEcon703) - Week 6 (University of Massachusetts Amherst)


### Intuição do cálculo da função de verossimilhança
- Apenas para ilustrar a construção da função de verossimilhança, considere um modelo logit em que queremos estimar os indivíduos precisam escolher se usam carro ou ônibus para deslocamento.
- Para estimar as probabilidades de usar carro (e, por consequência, de ônibus), vamos utilizar as informações dos preços que os indivíduos pagam pela gasolina e pela passagem de ônibus.
- Note que os valores abaixo foram todos inventados.
- Considere um conjunto de parâmetros {{<math>}}$\theta^A = \{ \beta^A_0, \beta^A_1, \beta^A_2 \}${{</math>}} que gerem as seguintes probabilidades de usar carro e de ônibus (últimas 2 colunas):

|             | **Preço Gasolina** | **Preço Bus** | **Escolha** | **_Prob(Car  `\(| \theta^A\)`)_** | **_Prob(Bus `\(| \theta^A\)`)_** |
|:-----------:|:------------------:|:----------------:|:-----------:|:-----------------:|:------------------:|
| Indiv. 1 |        6,93        |       5,00       |    Car    |        **0,63**       |        0,37        |
| Indiv. 2 |        7,01        |       2,50       |    Bus   |        0,33       |        **0,67**        |
| Indiv. 3 |        6,80        |       2,50       |    Bus   |        0,25       |        **0,75**        |
| Indiv. 4 |        6,75        |       5,00       |    Car    |        **0,73**       |        0,27        |

- Logo, a verossimilhança, dado os parâmetros {{<math>}}$\theta^A${{</math>}} é
{{<math>}}$$ \mathcal{L}(\theta^A) = 0,63 \times 0,67 \times 0,75 \times 0,73 = 0,231 $${{</math>}}

- Agora, considere `\(\theta^B = \{ \beta^B_0, \beta^B_1, \beta^B_2 \}\)` que gerem as seguintes probabilidades:

|             | **Preço Gasolina** | **Preço Bus** | **Escolha** | **_Prob(Car  `\(| \theta^B\)`)_** | **_Prob(Bus `\(| \theta^B\)`)_** |
|:-----------:|:------------------:|:----------------:|:-----------:|:-----------------:|:------------------:|
| Indiv. 1 |        6,93        |       5,00       |    Car    |        **0,54**       |        0,46        |
| Indiv. 2 |        7,01        |       2,50       |    Bus   |        0,43       |        **0,57**        |
| Indiv. 3 |        6,80        |       2,50       |    Bus   |        0,35       |        **0,65**        |
| Indiv. 4 |        6,75        |       5,00       |    Car    |        **0,58**       |        0,42        |

- Então, a verossimilhança, dado {{<math>}}$\theta^B${{</math>}}, é

{{<math>}}$$ \mathcal{L}(\theta^B) = 0,54 \times 0,57 \times 0,65 \times 0,58 = 0,116 $${{</math>}}

- Como {{<math>}}$\mathcal{L}(\theta^A) = 0,231 > 0,116 = \mathcal{L}(\theta^B)${{</math>}}, então os parâmetros {{<math>}}$\theta^A${{</math>}} se mostram mais adequados em relação a {{<math>}}$\theta^B${{</math>}}
- Na máxima verossimilhança (MLE), é escolhido o conjunto de parâmetros {{<math>}}$\theta^*${{</math>}} que maximiza a função de verossimilhança (ou log-verossimilhança).
- No modelo logit, as probabilidades usadas para calcular a verossimilhança são as próprias proabilidades de escolha por uma alternativa, dado um conjunto de parâmetros.
- Já no modelo linear, usamos a função de densidade de probabilidade para avaliar a "distância" de cada observação, {{<math>}}$y_i${{</math>}}, em relação ao seu valor ajustado {{<math>}}$\hat y_i${{</math>}}, dado um conjunto de parâmetros.



### Otimização Numérica para MLE
A função `optim()` do R será usada novamente para desempenhar a otimização numérica. Precisamos usar como input:

- Alguns valores inicias dos parâmetros, {{<math>}}$\theta^0${{</math>}}
- Uma função que tome esses parâmetros como um argumento e calcule a 
log-verossimilhança, {{<math>}}$\ln{L(\theta)}${{</math>}}.

A função log-verossimilhança é dada por
{{<math>}}$$ \ln{L(\beta, \sigma^2 | y, X)} = \sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}, $${{</math>}}
em que a distribuição condicional de cada {{<math>}}$y_i${{</math>}} é
{{<math>}}$$ y_i | x_i \sim \mathcal{N}(\beta'x_i, \sigma^2) $${{</math>}}

1. Construir matriz {{<math>}}$X${{</math>}} e vetor {{<math>}}$y${{</math>}}
2. Calcular os valores ajustados de {{<math>}}$y${{</math>}}, {{<math>}}$\hat{y} - \beta'x_i${{</math>}}, que é a média de cada {{<math>}}$y_i${{</math>}}
3. Calcular a densidade para cada {{<math>}}$y_i${{</math>}}, {{<math>}}$f(y_i | x_i, \beta, \sigma^2)${{</math>}}
4. Calcular a log-verossimilhança, {{<math>}}$\ln{L(\beta, \sigma^2 | y, X)} = \sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}${{</math>}}


#### 1. Chute de valores iniciais para `\(\beta_0, \beta_1, \beta_2\)` e `\(\sigma^2\)`
- Note que, diferente da estimação por OLS, um dos parâmetros a ser estimado via MLE é a variância ({{<math>}}$\sigma^2${{</math>}}).

```r
params = c(35, -0.02, -3.5, 1)
# (beta_0, beta_1 , beta_2, sigma2)
```

#### 2. Seleção da base de dados e variáveis

```r
## Adicionando colunas de 1's para o termo constante
data = mtcars
beta_0 = params[1]
beta_1 = params[2]
beta_2 = params[3]
sigma2 = params[4]
```

#### 3. Cálculo dos valores ajustados e das densidades

```r
## Calculando valores ajustados de y
y_hat = beta_0 + beta_1*data$hp + beta_2*data$wt
```

#### 4. Cálculo das densidades
{{<math>}}$$ f(y_i | x_i, \beta, \sigma^2) $${{</math>}}

```r
## Calculando os pdf's de cada outcome
y_pdf = dnorm(data$mpg, mean = y_hat, sd = sqrt(sigma2))

head(y_pdf) # Primeiros valores da densidade
```

```
## [1] 0.01255811 0.08817854 0.03394076 0.39462606 0.29887241 0.01070560
```

```r
prod(y_pdf) # Verossimilhança
```

```
## [1] 2.331786e-67
```

- Para entender melhor o que estamos fazendo aqui, relembre que, na estimação por máxima verossimilhança, assume-se que
{{<math>}}$$\varepsilon | X \sim N(0, \sigma^2)$${{</math>}}
- No exemplo abaixo, podemos ver que, para cada {{<math>}}$x${{</math>}}, temos um valor ajustado {{<math>}}$\hat{y} = \beta_0 + \beta_1 x${{</math>}} e seus desvios {{<math>}}$\varepsilon${{</math>}} são normalmente distribuídos com a mesma variância {{<math>}}$\sigma^2${{</math>}}

<center><img src="../mle.jpg"></center>

- Agora, vamos juntar o data frame `mtcars` com os valores ajustados `mpg_hat` e as densidades `y_pdf`:

```r
mpg_hat = y_hat # atribuindo y_hat a um objeto com nome mais adequado

# Juntando as bases e visualizando os primeiros valores
bd_joined = cbind(mtcars, mpg_hat, y_pdf) %>%
  select(hp, wt, mpg, mpg_hat, y_pdf)
head(bd_joined)
```

```
##                    hp    wt  mpg mpg_hat      y_pdf
## Mazda RX4         110 2.620 21.0 23.6300 0.01255811
## Mazda RX4 Wag     110 2.875 21.0 22.7375 0.08817854
## Datsun 710         93 2.320 22.8 25.0200 0.03394076
## Hornet 4 Drive    110 3.215 21.4 21.5475 0.39462606
## Hornet Sportabout 175 3.440 18.7 19.4600 0.29887241
## Valiant           105 3.460 18.1 20.7900 0.01070560
```
- Como pode ser visto na base de dados juntada e nos gráficos abaixo, quanto mais próximo o valor ajustado for do valor observado de cada observação, maior será a densidade/probabilidade.

```r
# Criando gráfico para os 2 primeiros carros (Mazda RX4 e Mazda RX 4 Wag)
qt_norm = seq(20, 27, by=0.1) # valores de mpg ("escores Z")

# Mazda RX4
pdf_norm1 = dnorm(qt_norm, mean=bd_joined$mpg_hat[1], sd=sqrt(sigma2)) # pdf
plot(qt_norm, pdf_norm1, type="l", xlab="mpg", ylab="densidade", main="Mazda RX4")
abline(v=c(bd_joined$mpg_hat[1], bd_joined$mpg[1]), col="red")
text(c(bd_joined$mpg_hat[1], bd_joined$mpg[1]), 0.2, 
     c(expression(widehat(mpg)[1]), expression(mpg[1])), 
     pos=2, srt=90, col="red")
```

<img src="/project/rec2301/chapter7/_index_files/figure-html/unnamed-chunk-21-1.png" width="672" />

```r
# Mazda RX4 Wag 
pdf_norm2 = dnorm(qt_norm, mean=bd_joined$mpg_hat[2], sd=sqrt(sigma2)) # pdf
plot(qt_norm, pdf_norm2, type="l", xlab="mpg", ylab="densidade", main="Mazda RX4 Wag")
abline(v=c(bd_joined$mpg_hat[2], bd_joined$mpg[2]), col="blue")
text(c(bd_joined$mpg_hat[2], bd_joined$mpg[2]), 0.2, 
     c(expression(widehat(mpg)[2]), expression(mpg[2])), 
     pos=2, srt=90, col="blue")
```

<img src="/project/rec2301/chapter7/_index_files/figure-html/unnamed-chunk-21-2.png" width="672" />
- Logo, a verossimilhança (produto de todas probabilidades) será maior quanto mais próximos forem os valores ajustados dos seus respectivos valores observados.


#### 5. Calculando a Log-Verossimilhança
{{<math>}}$$ \mathcal{l}(\beta, \sigma^2) = \sum^{N}_{i=1}{\ln\left[ f(y_i | x_i, \beta, \sigma^2) \right]} $${{</math>}}

```r
## Calculando a log-verossimilhanca
loglik = sum(log(y_pdf))
loglik
```

```
## [1] -153.4266
```


#### 6. Criando a Função de Log-Verossimilhança

```r
## Criando funcao para calcular log-verossimilhanca OLS 
loglik_lm = function(params, data) {
  # Pegando os parâmetros
  beta_0 = params[1]
  beta_1 = params[2]
  beta_2 = params[3]
  sigma2 = params[4]
  
  ## Calculando valores ajustados de y
  y_hat = beta_0 + beta_1*data$hp + beta_2*data$wt
  
  ## Calculando os pdf's de cada outcome
  y_pdf = dnorm(data$mpg, mean = y_hat, sd = sqrt(sigma2))
  
  ## Calculando a log-verossimilhanca
  loglik = sum(log(y_pdf))
  
  ## Retornando o negativo da log-verossimilanca - optim() não maximiza
  -loglik
}
```


#### 7. Otimização

Tendo a função objetivo, usaremos `optim()` para *minimizar*
{{<math>}}$$ -\ln{L(\beta, \sigma^2 | y, X)} = -\sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}. $${{</math>}}
Aqui, **minimizamos o negativo** da log-Verossimilhança para **maximizarmos** (função`optim()` apenas minimiza).


```r
## Maximizando a função log-verossimilhança OLS
mle = optim(par = c(0, 0, 0, 1), fn = loglik_lm, data = mtcars,
              method = "BFGS", hessian = TRUE)

## Mostrando os resultados da otimização
mle
```

```
## $par
## [1] 37.227256 -0.031773 -3.877825  6.095146
## 
## $value
## [1] 74.32617
## 
## $counts
## function gradient 
##      105       41 
## 
## $convergence
## [1] 0
## 
## $message
## NULL
## 
## $hessian
##              [,1]         [,2]         [,3]         [,4]
## [1,] 5.250080e+00 7.701211e+02 1.689082e+01 1.715961e-06
## [2,] 7.701211e+02 1.368758e+05 2.702437e+03 2.252101e-04
## [3,] 1.689082e+01 2.702437e+03 5.921123e+01 2.589928e-06
## [4,] 1.715961e-06 2.252101e-04 2.589928e-06 4.306909e-01
```

```r
## Calculando os erros padrão
mle_se = mle$hessian %>% # hessiano
  solve() %>% # toma a inversa para obter a matriz de var/cov
  diag() %>% # pega a diagonal da matriz
  sqrt() # calcula a raiz quadrada

# Visualizando as estimativas e os erros padrão
cbind(mle$par, mle_se)
```

```
##                     mle_se
## [1,] 37.227256 1.521988303
## [2,] -0.031773 0.008595959
## [3,] -3.877825 0.602339558
## [4,]  6.095146 1.523762060
```



## Estimação por GMM
- [Computing Generalized Method of Moments and Generalized Empirical Likelihood with R (Pierre Chaussé)](https://cran.r-project.org/web/packages/gmm/vignettes/gmm_with_R.pdf)
- [Generalized Method of Moments (GMM) in R - Part 1 (Alfred F. SAM)](https://medium.com/codex/generalized-method-of-moments-gmm-in-r-part-1-of-3-c65f41b6199)


- Para estimar via GMM precisamos construir vetores relacionados aos seguintes momentos:
{{<math>}}$$ E(\varepsilon) = 0 \qquad \text{ e } \qquad E(\varepsilon'X) = 0 $${{</math>}}
em que `\(X\)` é a matriz de covariadas e `\(\varepsilon\)` é o desvio. Note que estes são os momentos relacionados ao OLS, dado que este é um caso particular do GMM.


- Relembre que estamos usando a base de dados `mtcars` para estimar o modelo linear:
{{<math>}}$$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \beta_2 \text{wt} + \varepsilon $${{</math>}}
que relaciona o consumo de combustível (em milhas por galão - _mpg_) com a potência (_hp_) e o peso (em mil libras - _wt_) do carro.


### Otimização Numérica para GMM

#### 1. Chute de valores iniciais para {{<math>}}$\{ \beta_0, \beta_1, \beta_2 \}${{</math>}}

- Vamos criar um vetor com possíveis valores de {{<math>}}$\{ \beta_0, \beta_1, \beta_2 \}${{</math>}}:


```r
library(dplyr)

params = c(35, -0.02, -3.5)
beta_0 = params[1]
beta_1 = params[2]
beta_2 = params[3]
```

#### 2. Seleção da base de dados e variáveis

```r
data = mtcars %>% mutate(constant=1) # Criando variável de constante

## Selecionando colunas para X (covariadas) e convertendo para matrix
X = data %>% 
  select("constant", "hp", "wt") %>% 
  as.matrix()

## Selecionando variavel para y e convertendo para matrix
y = data %>% 
  select("mpg") %>% 
  as.matrix()
```

#### 3. Cálculo dos valores ajustados e dos desvios

```r
## Valores ajustados e desvios
y_hat = X %*% params
# equivalente a: y_hat = beta_0 + beta_1 * X[,"hp"] + beta_2 * X[,"wt"]

e = y - y_hat
```

#### 4. Criação da matriz de momentos

- Note que {{<math>}}$E(\varepsilon' X)${{</math>}} é uma multiplicação matricial, mas a função `gmm()` exige que como input os vetores com multiplicação elemento a elemento do resíduo {{<math>}}$\varepsilon${{</math>}} com as covariadas {{<math>}}$X${{</math>}} (neste caso: constante, hp, wt)


```r
m = X * as.vector(e) # matriz de momentos (sem tomar esperança)
head(m)
```

```
##                   constant       hp         wt
## Mazda RX4          -2.6300 -289.300 -6.8906000
## Mazda RX4 Wag      -1.7375 -191.125 -4.9953125
## Datsun 710         -2.2200 -206.460 -5.1504000
## Hornet 4 Drive     -0.1475  -16.225 -0.4742125
## Hornet Sportabout  -0.7600 -133.000 -2.6144000
## Valiant            -2.6900 -282.450 -9.3074000
```


- Note que, como multiplicamos a constante igual a 1 com os desvios {{<math>}}$\varepsilon${{</math>}}, a 1ª coluna corresponde ao momento {{<math>}}$E(\varepsilon)=0${{</math>}} (mas sem tomar a esperança).

- Já as colunas 2 e 3 correspodem ao momento {{<math>}}$E(\varepsilon'X)=0${{</math>}} para as variáveis _hp_ e _wt_ (também sem tomar a esperança).

- Logicamente, para estimar por GMM, precisamos escolher os parâmetros {{<math>}}$\theta = \{ \beta_0, \beta_1, \beta_2 \}${{</math>}} que, ao tomar a esperança em cada um destas colunas, se aproximem ao máximo de zero. Isso será feito via função `gmm()` (semelhante à função `optim()`)



#### 5. Criação de função com os momentos
- Vamos criar uma função que tem como input um vetor de parâmetros (`params`) e uma base de dados (`data`), e que retorna uma matriz em que cada coluna representa um momento.
- Essa função incluirá todos os comandos descritos nos itens 1 a 4 (que, na verdade, apenas foram feitos por didática).

```r
mom_ols = function(params, data) {
  ## Adicionando colunas de 1's para o termo constante
  data = data %>% mutate(constant = 1)
  
  ## Selecionando colunas para X (covariadas) e convertendo para matrix
  X = data %>% 
    select("constant", "hp", "wt") %>% 
    as.matrix()
  
  ## Selecionando variavel para y e convertendo para matrix
  y = data %>% 
    select("mpg") %>% 
    as.matrix()
  
  ## Valores ajustados e desvios
  y_hat = X %*% params
  e = y - y_hat
  
  m = as.vector(e) * X # matriz de momentos (vetor - multiplicação por elemento)
  m
}
```


#### 6. Otimização via função `gmm()`
- A função `gmm()`, assim como a `optim()`, recebe uma função como argumento.
- No entanto, ao invés de retornar um valor, a função que entra no `gmm()` retorna uma matriz, cujas médias das colunas queremos aproximar de zero. 

```r
library(gmm)
```

```
## Warning: package 'gmm' was built under R version 4.2.2
```

```
## Carregando pacotes exigidos: sandwich
```

```
## Warning: package 'sandwich' was built under R version 4.2.2
```

```r
gmm_lm = gmm(mom_ols, mtcars, c(0,0,0),
             wmatrix = "optimal", # matriz de ponderação
             optfct = "nlminb" # função de otimização
             )

summary(gmm_lm)$coefficients
```

```
##             Estimate  Std. Error   t value      Pr(>|t|)
## Theta[1] 37.22727054 1.477465796 25.196705 4.352959e-140
## Theta[2] -0.03177295 0.007330972 -4.334070  1.463775e-05
## Theta[3] -3.87783083 0.595735804 -6.509313  7.549526e-11
```




{{< cta cta_text="👉 Proceed to Panel Data" cta_link="../chapter8" >}}
