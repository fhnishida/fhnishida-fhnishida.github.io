---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Simple Regression
summary: This page covers topics such as simple OLS regression and assumptions violations. Also includes examples and code snippets to illustrate the concepts discussed.
title: Simple Regression
weight: 6
output: md_document
type: book
---





## Regressão simples por MQO
- [Seção 2.1 de Heiss (2020)](http://www.urfie.net/read/index.html#page/93)
- Considere o seguinte modelo empírico
$$ y = \beta_0 + \beta_1 x + \varepsilon \tag{2.1} $$
- Os estimadores de mínimos quadrados ordinários (MQO), segundo Wooldridge (2006, Seção 2.2) é dado por

{{<math>}}\begin{align}
    \hat{\beta}_0 &= \bar{y} - \hat{\beta}_1 \bar{x} \tag{2.2}\\
    \hat{\beta}_1 &= \frac{cov(x,y)}{var(x)} \tag{2.3}
\end{align}{{</math>}}

- E os valores ajustados/preditos, {{<math>}}$\hat{y}${{</math>}} é dado por
$$ \hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x \tag{2.4} $$
tal que 
$$ y = \hat{y} + \hat{\varepsilon} $$

### Exemplo 2.3: Salário de Diretores Executivos e Retornos de Ações (Wooldridge, 2006)

- Considere o seguinte modelo de regressão simples
$$ \text{salary} = \beta_0 + \beta_1 \text{roe} + \varepsilon $$
em que `salary` é a remuneração de um diretor executivo em milhares de dólares e `roe` é o retorno sobre o investimento em percentual.


#### Estimando regressão simples "na mão"


```r
# Carregando a base de dados do pacote 'wooldridge'
data(ceosal1, package="wooldridge")

attach(ceosal1) # para não precisar escrever 'ceosal1$' antes de toda variável

cov(salary, roe) # covariância entre variável dependente e independente
```

```
## [1] 1342.538
```

```r
var(roe) # variância do retorno sobre o investimento
```

```
## [1] 72.56499
```

```r
mean(roe) # média do retorno sobre o investimento
```

```
## [1] 17.18421
```

```r
mean(salary) # média do salário
```

```
## [1] 1281.12
```

```r
# Cálculo "na mão" das estimativas de MQO
b1hat = cov(salary, roe) / var(roe) # por (2.3)
b1hat
```

```
## [1] 18.50119
```

```r
b0hat = mean(salary) - var(roe)*mean(salary) # por (2.2)
b0hat
```

```
## [1] -91683.31
```

```r
detach(ceosal1) # para parar de procurar variável dentro do objeto 'ceosal1'
```

- Vemos que um incremento de uma unidade (porcento) no retorno sobre o investimento (_roe_), aumentar 18 unidades (milhares de dólares) nos salários dos diretores executivos.


#### Estimando regressão simples via `lm()`
- Uma maneira mais conveniente de fazer a estimação por MQO é usando a função `lm()`
- Em um modelo univariado, inserimos dois vetores (variáveis dependente e independente) separados por um til (`~`):

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

- Também podemos deixar de usar o prefixo `ceosal1$` antes dos nomes do vetores preenchermos o argumento `data = ceosal1`

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

- Podemos usar a função `lm()` para incluir uma reta de regressão no gráfico

```r
# Gráfico de dispersão (scatter)
plot(ceosal1$roe, ceosal1$salary)

# Adicionando a reta de regressão
abline(lm(salary ~ roe, data=ceosal1), col="red")
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-4-1.png" width="672" />


</br>

## Coeficientes, Valores Ajustados e Resíduos
- [Seção 2.2 de Heiss (2020)](http://www.urfie.net/read/index.html#page/98)
- Podemos "guardar" os resultados da estimação em um objeto (da classe `list`) e, depois, extrair informações dele.

```r
# atribuindo o resultado da regressão em um objeto
CEOregres = lm(salary ~ roe, data=ceosal1)

# verificando os "nomes" das informações contidas no objeto
names(CEOregres)
```

```
##  [1] "coefficients"  "residuals"     "effects"       "rank"         
##  [5] "fitted.values" "assign"        "qr"            "df.residual"  
##  [9] "xlevels"       "call"          "terms"         "model"
```

- Podemos usar a função `coef()` para extrairmos um data frame com os coeficientes da regressão

```r
# Extraindo vetor de coeficientes da regressão
bhat = coef(CEOregres)
bhat
```

```
## (Intercept)         roe 
##   963.19134    18.50119
```

```r
b0hat = bhat["(Intercept)"] # ou bhat[1]
b1hat = bhat["roe"] # ou bhat[2]
```

- Dados estes parâmetros estimados, podemos calcular os valores ajustados/preditos, {{<math>}}$\hat{y}${{</math>}}, e os desvios, {{<math>}}$\hat{\varepsilon}${{</math>}}, para cada observação {{<math>}}$i=1, ..., n${{</math>}}:

{{<math>}}\begin{align}
    \hat{y}_i &= \hat{\beta}_0 + \hat{\beta}_1 . x_i \tag{2.5} \\
    \hat{\varepsilon}_i &= y_i - \hat{y}_i \tag{2.6}
\end{align}{{</math>}}


```r
# Extraindo colunas de ceosal1 em vetores
sal = ceosal1$salary
roe = ceosal1$roe

# Calculando os valores ajustados/preditos
sal_hat = b0hat + (b1hat * roe)

# Calculando os desvios
ehat = sal - sal_hat

# Visualizando as 6 primerias linhas de sal, roe, sal_hat e ehat
head( cbind(sal, roe, sal_hat, ehat) )
```

```
##       sal  roe  sal_hat      ehat
## [1,] 1095 14.1 1224.058 -129.0581
## [2,] 1001 10.9 1164.854 -163.8543
## [3,] 1122 23.5 1397.969 -275.9692
## [4,]  578  5.9 1072.348 -494.3483
## [5,] 1368 13.8 1218.508  149.4923
## [6,] 1145 20.0 1333.215 -188.2151
```

- Com as funções `fitted()` e `resid()` podemos extrair os valores ajustados e os resíduos do objeto com resultado da regressão:

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
# Ou também
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


- Na seção 2.3 de Wooldridge (2006), vemos que a estimação por MQO usa as seguintes hipóteses:
{{<math>}}\begin{align}
    &\sum^n_{i=1}{\hat{\varepsilon}_i} = 0 \quad \implies \quad \bar{\hat{\varepsilon}} = 0 \tag{2.7} \\
    &\sum^n_{i=1}{x_i \hat{\varepsilon}_i} = 0 \quad \implies \quad cov(x,\hat{\varepsilon}) = 0 \tag{2.8} \\
    &\bar{y}=\hat{\beta}_0 + \hat{\beta}_1.\bar{x} \tag{2.9}
\end{align}{{</math>}}

- Podemos verificá-los em nosso exemplo:

```r
# Verificando (2.7)
mean(ehat) # bem próximo de 0
```

```
## [1] -2.666235e-14
```

```r
# Verificando (2.8)
cor(ceosal1$roe, ehat) # bem próximo de 0
```

```
## [1] -6.038735e-17
```

```r
# Verificando (2.9)
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

- **IMPORTANTE**: Isso só quer dizer que o MQO escolhe {{<math>}}$\hat{\beta}_0${{</math>}} e {{<math>}}$\hat{\beta}_1${{</math>}} tais que 2.7, 2.8 e 2.9 sejam verdadeiros.
- Isto **NÃO** quer dizer que, para o modelo real as seguintes hipóteses sejam verdadeiras:
{{<math>}}\begin{align}
    &E(\varepsilon) = 0 \tag{2.7'} \\
    &cov(x, \varepsilon) = 0 \tag{2.8'}
\end{align}{{</math>}}
- De fato, se 2.7' e 2.8' não forem válidos, a estimação por MQO (que assume 2.7, 2.8 e 2.9) será viesada.


</br>

## Transformações log
- [Seção 2.4 de Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- Também podemos fazer estimações transformando variáveis em nível para logaritmo.
- É especialmente importante para transformar modelos não-lineares em lineares - quando o parâmetro está no expoente ao invés estar multiplicando:
  
$$ y = A K^\alpha L^\beta\quad \overset{\text{log}}{\rightarrow}\quad \log(y) = \log(A) + \alpha \log(K) + \beta \log(L) $$

- Também é frequentemente utilizada em variáveis dependentes {{<math>}}$y \ge 0${{</math>}}


<center><img src="../tab_2-3.png"></center>

- Há duas maneiras de fazer a transformação log:
    - Criar um novo vetor/coluna com a variável em log, ou
    - Usar a função `log()` diretamente no vetor dentro da função `lm()`


### Exemplo 2.11: Salário de Diretores Executivos e Vendas das Empresas (Wooldridge, 2006)
- Considere as variáveis:
    - `wage`: salário anual em milhares de dólares
    - `sales`: vendas em milhões de dólares


- _Modelo nível-nível_:

```r
# Carregando a base de dados
data(ceosal1, package="wooldridge")

# Estimando modelo nível-nível
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

- _Modelo log-nível_:

```r
# Estimando modelo log-nível
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

- _Modelo log-log_:

```r
# Estimando modelo log-log
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


</br>

## Regressão a partir da origem ou sobre uma constante
- [Seção 2.5 de Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- Para esstimar o modelo sem o intercepto (constante), precisamos adicionar um `0` ou `-1` nos regressores na função `lm()`:

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

- Ao regredirmos uma variável dependente sobre uma constante (1), obtemos a média desta variável.

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


</br>

## Diferença de médias
- Baseado no Exemplo C.6: Efeito de subsídios de treinamento corporativo sobre a produtividade do trabalhador  (Wooldridge, 2006)
- Poderíamos ter calculado a diferença de médias por meio de uma regressão sobre uma variável _dummy_, cujos valores são 0 ou 1.
- Primeiro vamos criar um vetor único de taxas de refugo (vamos empilhar `SR87` e `SR88`)

```r
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)

SR = c(SR87, SR88) # empilhando SR87 e SR88 em único vetor
SR
```

```
##  [1] 10.00  1.00  6.00  0.45  1.25  1.30  1.06  3.00  8.18  1.67  0.98  1.00
## [13]  0.45  5.03  8.00  9.00 18.00  0.28  7.00  3.97  3.00  1.00  5.00  0.50
## [25]  1.54  1.50  0.80  2.00  0.67  1.17  0.51  0.50  0.61  6.70  4.00  7.00
## [37] 19.00  0.20  5.00  3.83
```

- Note que os 20 primeiros valores são relativos às taxas de refugo no ano de 1987 e os 20 últimos valores são de 1988.
- Vamos criar uma variável _dummy_ chamada de _group88_ que atribui valor 1 as observações do ano de 1988 e o valor 0 para as de 1987:

```r
group88 = c(rep(0, 20), rep(1, 20)) # 0/1 para 20 primeiras/últimas observ
group88
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
## [39] 1 1
```

- Ao regredirmos a taxa de refugo em relação à _dummy_ obtemos a diferença das médias

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


</br>

## Valores esperados, Variância e Erros padrão
- [Seção 2.6 de Heiss (2020)](http://www.urfie.net/read/index.html#page/106)


- Wooldridge (2006, Seção 2.5) deriva o estimador do termo de erro:
$$ \hat{\sigma}^2 = \frac{1}{n-2} \sum^n_{i=1}{\hat{\varepsilon}^2_i} = \frac{n-1}{n-2} Var(\hat{\varepsilon}) \tag{2.14} $$
em que {{<math>}}$Var(\hat{\varepsilon}) = \frac{1}{n-1} \sum^n_{i=1}{\hat{\varepsilon}^2_i}${{</math>}}.

- Observe que precisamos considerar os graus de liberdade, dado que estamos estimando dois parâmetros ({{<math>}}$\hat{\beta}_0${{</math>}} e {{<math>}}$\hat{\beta}_1${{</math>}}).
- Note que {{<math>}}$\hat{\sigma} = \sqrt{\hat{\sigma}^2}${{</math>}} é chamado de erro padrão da regressão (EPR). No R, é chamado de erro padrão residual 
- também podemos obter os erros padrão (EP) dos estimadores:

{{<math>}}\begin{align}
    se(\hat{\beta}_0) &= \sqrt{\frac{\hat{\sigma}\bar{x}^2}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \sqrt{\bar{x^2}} \tag{2.15}\\
    se(\hat{\beta}_1) &= \sqrt{\frac{\hat{\sigma}}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \tag{2.16}
\end{align}{{</math>}}


### Exemplo 2.12: Desempenho em Matemática de Estudante e o Programa de Merenda Escolar (Wooldridge, 2006)
- Sejam as variáveis
    - `math10`: o percentual de alunos de primeiro ano de ensino médio aprovados em exame de matemática
    - `lnchprg`: o percentual de estudante aptos para participar do programa de merenda escolar
    
- O modelo de regressão simples é
{{math}}$$ \text{math10} = \beta_0 + \beta_1 \text{lnchprg} + \varepsilon $${{/math}}


```r
data(meap93, package="wooldridge")

# Estimando o modelo e atribuindo no objeto 'results'
results = lm(math10 ~ lnchprg, data=meap93)

# Extraindo número de observações
N = nobs(results)
N
```

```
## [1] 408
```

```r
# Calculando o Erro Padrão da Regressão (raiz quadrada de 2.14)
SER = sqrt( (N-1)/(N-2) ) * sd(resid(results))
SER
```

```
## [1] 9.565938
```

```r
# Erro padrão de b0hat (2.15)
(1 / sqrt(N-1)) * (SER / sd(meap93$lnchprg)) * sqrt( mean(meap93$lnchprg^2) ) # SE b1hat (2.16)
```

```
## [1] 0.9975824
```

```r
(1 / sqrt(N-1)) * (SER / sd(meap93$lnchprg)) # b1hat
```

```
## [1] 0.03483933
```

- Os cálculos dos erros padrão podem ser obtidos via uso da função `summary()` sobre o objeto com resultado da regressão:

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

- Observe também que, por padrão, são feitos testes de hipótese (bicaudais), cujas hipóteses nulas são {{<math>}}$\beta_0 = 0${{</math>}} e {{<math>}}$\beta_1=0${{</math>}}.
- Ou seja, avalia se as estimativas calculadas são estatisticamente nulas e também mostra as respectivas estatísticas t e p-valores.
- Neste caso, como os p-valores são bem pequenos (`<2e-16` = menor do que {{<math>}}$2 \times 10^{-16}${{</math>}}), rejeitamos ambas hipóteses nulas e, portanto, as estimativas são estatisticamente significantes.
- Também podemos calcular essas estimativas "na mão":

```r
# Extraindo as estimativas
estim = coef(summary(results))
estim
```

```
##               Estimate Std. Error   t value      Pr(>|t|)
## (Intercept) 32.1427116 0.99758239 32.220609 6.267302e-114
## lnchprg     -0.3188643 0.03483933 -9.152422  2.746609e-18
```

```r
# Estatísticas t para H0: bhat = 0
t_b0hat = (estim["(Intercept)", "Estimate"] - 0) / estim["(Intercept)", "Std. Error"]
t_b0hat
```

```
## [1] 32.22061
```

```r
t_b1hat = (estim["lnchprg", "Estimate"] - 0) / estim["lnchprg", "Std. Error"]
t_b1hat
```

```
## [1] -9.152422
```

```r
# p-valores para H0: bhat = 0
2 * (1 - pt(abs(t_b0hat), N-1)) # p-valor para b0hat
```

```
## [1] 0
```

```r
2 * (1 - pt(abs(t_b1hat), N-1)) # p-valor para b1hat
```

```
## [1] 0
```


</br>

## Violações de hipótese
- [Subseção 2.7.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/113), mas usando como exemplo o teste elaborado 1.
- [Simulating a linear model (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/u7in9/simulation-simulating-a-linear-model)
- Na prática, fazemos regressões a partir de observações contidas em bases de dados e não sabemos qual é o _modelo real_ que gerou essas observações.
- No R, podemos supor um _modelo real_ e simular suas observações no R para analisar o que ocorre quando há violação de hipótese de algum modelo econométrico ou estimador.
- Usaremos o exemplo dado no Teste Elaborado 1, no qual queremos encontrar a relação das horas de prática em culinária com o número de queimaduras na cozinha.


### Sem violação de hipótese: Exemplo 1
- Sejam {{<math>}}$y${{</math>}} o número de queimaduras na cozinha e {{<math>}}$x${{</math>}} o número de horas gastas aprendendo a cozinhar.
- Suponha o _modelo real_:
{{math}}$$ y = \tilde{\beta}_0 + \tilde{\beta}_1 x + \tilde{\varepsilon}, \qquad \tilde{\varepsilon} \sim N(0, 2^2) \tag{1}$${{/math}}
em que {{<math>}}$\tilde{\beta}_0=50${{</math>}} e {{<math>}}$\tilde{\beta}_1=-5${{</math>}}.

1. Iremos definir {{<math>}}$\tilde{\beta}_0${{</math>}} e {{<math>}}$\tilde{\beta}_1${{</math>}}, e gerar, por simulação, as observações de {{<math>}}$x${{</math>}} e {{<math>}}$y${{</math>}}:
    - Geraremos valores aleatórios {{<math>}}$x \sim N(5; 0,5^2)${{</math>}}. Isso é apenas para facilitar, não importa a distribuição de {{<math>}}$x${{</math>}}. 

```r
b0til = 50
b1til = -5
N = 200 # Número de observações

set.seed(1)
e_til = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
y = b0til + b1til*x + e_til # calculando observações y

plot(x, y)
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-21-1.png" width="672" />
Simulamos as observações {{<math>}}$x${{</math>}} e {{<math>}}$y${{</math>}} que são, na prática, as informações que observamos.

2. Estimaremos, por MQO, os parâmetros {{<math>}}$\hat{\beta}_0${{</math>}} e {{<math>}}$\hat{\beta}_1${{</math>}} a partir das observações simuladas de {{<math>}}$y${{</math>}} e {{<math>}}$x${{</math>}}:
    - Um economista supôs a relação entre as variáveis pelo seguinte _modelo empírico_:
    $$ y = \beta_0 + \beta_1 x + \varepsilon, \tag{1a}$$
    assumindo que {{<math>}}$E[\varepsilon] = 0${{</math>}} e {{<math>}}$cov(\varepsilon, x)= 0=0${{</math>}}.
    - Para estimar o modelo por MQO, usamos a função `lm()`
    

```r
lm(y ~ x) # regredindo por MQO a var. dependente y pela var. x
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

- Note que foi possível recuperar os parâmetros populacionais ({{<math>}}$\hat{\beta}_0 = 50,268 \approx 50 = \tilde{\beta}_0${{</math>}} e {{<math>}}$\hat{\beta}_1 = -5,039 \approx -5 = \tilde{\beta}_1${{</math>}}).


```r
plot(x, y) # Figura de x contra y
abline(a=50, b=-5, col="red") # reta do modelo real
abline(lm(y ~ x), col="blue") # reta estimada a partir das observações
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-23-1.png" width="672" />

### Sem violação de hipótese: Exemplo 2
- Agora, no _modelo real_, suponha que o número de queimaduras {{<math>}}$y${{</math>}} é determinado tanto pela quantidade de horas de aprendizado {{<math>}}$x${{</math>}} e pela quantidade de horas gastas cozinhando {{<math>}}$z${{</math>}}:

$$ y = \tilde{\beta}_0 + \tilde{\beta}_1 x + \tilde{\beta}_2 z + \tilde{\varepsilon}, \qquad \tilde{\varepsilon} \sim N(0, 2^2) \tag{2} $$
em que {{<math>}}$\beta_0=50${{</math>}}, {{<math>}}$\beta_1=-5${{</math>}} e {{<math>}}$\beta_2=3${{</math>}}. Apenas para facilitar, usaremos geraremos valores aleatórios de {{<math>}}$x \sim N(5; 0,5^2)${{</math>}} e {{<math>}}$z \sim N(1,875; 0,25^2)${{</math>}}. Note que {{<math>}}$z${{</math>}}, por construção, **não** é correlacionada com {{<math>}}$x${{</math>}} no _modelo real_.

- Primeiro, vamos simular as observações:

```r
b0til = 50
b1til = -5
b2til = 3
N = 200 # Número de observações

set.seed(1)
etil = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
z = rnorm(N, 1.875, 0.25) # Gerando 200 obs. de média 1,875 e desv pad 0.25
y = b0til + b1til*x + b2til*z + etil # calculando observações y
```

- Considere que um economista suponha a relação entre as variáveis pelo seguinte _modelo empírico_:
    $$ y = \beta_0 + \beta_1 x + \varepsilon, \tag{2a}$$
    assumindo que {{<math>}}$E[\varepsilon] = 0${{</math>}} e {{<math>}}$cov(\varepsilon, x)= 0${{</math>}}.

- Note que o economista deixou a variável de horas cozinhando {{<math>}}$z${{</math>}} fora do modelo, então ela acaba ``entrando'' no erro da estimação.
- No entanto, como {{<math>}}$z${{</math>}} não tem relação com {{<math>}}$x${{</math>}}, então isso não afeta a estimativa de {{<math>}}$\hat{\beta}_1${{</math>}}:

```r
cor(x, z) # correlação de x e z -> próxima de 0
```

```
## [1] -0.02625278
```

```r
lm(y ~ x) # estimação por MQO
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
- Note que {{<math>}}$\hat{\beta}_1 = -5,12 \approx -5 = \tilde{\beta}_1${{</math>}}, portanto a estimação por MQO conseguiu recuperar o parâmetro real, apesar do economista não ter incluído {{<math>}}$z${{</math>}} no modelo.
- Grande parte dos estudos econômicos tentam estabelecer a relação/causalidade entre {{<math>}}$y${{</math>}} e alguma variável de interesse {{<math>}}$x${{</math>}}, então não é necessário incluir todas possíveis variáveis que impactam {{<math>}}$y${{</math>}}, desde que {{<math>}}$cov(\varepsilon, x) = 0${{</math>}}. Ou seja, que nenhuma variável explicativa correlacionada com {{<math>}}$x${{</math>}} tenha ``ficado de fora'' e, portanto, compondo o termo de erro.



### Violação de cov(e,x) = 0
- Agora, suponha que, no _modelo real_, quanto mais horas a pessoa pratica culinária, mais ele cozinha (ou seja, {{<math>}}$x${{</math>}} está relacionada com {{<math>}}$z${{</math>}}).
    - Considere que {{<math>}}$z = 1,875x + u, \quad u \sim N(0; (0,25)^2)${{</math>}}:
    

```r
set.seed(1)
etil = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
z = 1.875*x + rnorm(N, 0, 0.25) # Gerando 200 obs. de z
y = b0til + b1til*x + b2til*z + etil # calculando observações y
cor(x, z) # correlação de x e z
```

```
## [1] 0.9618748
```

- Note que, agora, {{<math>}}$x${{</math>}} e {{<math>}}$z${{</math>}} são consideravalmente correlacionados
- Vamos estimar o _modelo empírico_:
    $$ y = \beta_0 + \beta_1 x + \varepsilon,$$
    assumindo que {{<math>}}$E[\varepsilon] = 0${{</math>}} e {{<math>}}$cov(\varepsilon, x)= 0${{</math>}}.
    

```r
lm(y ~ x) # estimação por MQO
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

- Observe que {{<math>}}$\hat{b} = 0,5 \neq -5 = b_0${{</math>}}. Isto se dá porque {{<math>}}$z${{</math>}} não foi incluído no modelo e, portanto, ele acaba compondo o desvio {{<math>}}$\hat{\varepsilon}${{</math>}}. Como {{<math>}}$z${{</math>}} é correlacionado com {{<math>}}$x${{</math>}}, então {{<math>}}$cov(\varepsilon, x)\neq 0${{</math>}} (violando a hipótese do MQO).
- Observe que, se incluíssemos a variável {{<math>}}$z${{</math>}} na estimação, conseguiríamos recuperar {{<math>}}$\hat{\beta}_1 \approx \tilde{\beta}_1${{</math>}}:


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

### Violação de E(e) = 0
- Agora, consideraremos que {{<math>}}$E[\varepsilon] = k${{</math>}}, sendo {{<math>}}$k \neq 0${{</math>}} uma constante.
- Assuma que {{<math>}}$k = 10${{</math>}}:

```r
b0til = 50
b1til = -5
k = 10

set.seed(1)
etil = rnorm(N, k, 2) # Desvios: 200 obs. de média k e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
y = b0til + b1til*x + etil # calculando observações y
```
- Caso um economista considere um _modelo empírico_ com {{<math>}}$E[\varepsilon] = 0${{</math>}}, segue que:

```r
lm(y ~ x) # estimação por MQO
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
- Note que o fato de {{<math>}}$E[\varepsilon] \neq 0${{</math>}} afeta apenas a estimação de {{<math>}}$\hat{\beta}_0 \neq \tilde{\beta}_0${{</math>}}, porém não afeta a de {{<math>}}$\hat{\beta}_1 \approx \tilde{\beta}_1${{</math>}}, que é normalmente o parâmetro de interesse em estudos econômicos.


### Violação de E(e|x) = constante (Homocedasticidade)
- Agora, consideraremos que {{<math>}}$\varepsilon \sim N(0, (2x)^2)${{</math>}}, ou seja, a variância cresce com {{<math>}}$x${{</math>}} ({{<math>}}$E(\varepsilon|x) \neq ${{</math>}} constante (não vale homocedasticidade).


```r
b0til = 50
b1til = -5
N = 200

set.seed(1)
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
etil = rnorm(N, 0, 2*x) # Desvios: 200 obs. de média k e desv pad 2x
y = b0til + b1til*x + etil # calculando observações y

lm(y ~ x) # estimação por MQO
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
- Note que, mesmo com heterocesdasticidade, é possível recuperar {{<math>}}$\hat{\beta}_1 \approx \tilde{\beta}_1${{</math>}} quando {{<math>}}$N${{</math>}} for grande (ainda é consistente). Mas, observe também que, se a amostra for pequena, mais provável é que {{<math>}}$\hat{\beta}_1 \neq \tilde{\beta}_1${{</math>}}. Teste para {{<math>}}$N${{</math>}} menores.


</br>

## Qualidade do ajuste
- [Seção 2.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/101)
- A soma de quadrados total (SQT), a soma de quadrados explicada (SQE) e a soma de quadrados dos resíduos (SQR) podem ser escritos como:

{{<math>}}\begin{align}
    SQT &= \sum^n_{i=1}{(y_i - \bar{y})^2} = (n-1) . Var(y) \tag{2.10}\\
    SQE &= \sum^n_{i=1}{(\hat{y}_i - \bar{y})^2} = (n-1) . Var(\hat{y}) \tag{2.11}\\
    SQR &= \sum^n_{i=1}{(\hat{\varepsilon}_i - 0)^2} = (n-1) . Var(\hat{\varepsilon}) \tag{2.12}
\end{align}{{</math>}}
em que {{<math>}}$var(x) = \frac{1}{n-1} \sum^n_{i=1}{(x_i - \bar{x})^2}${{</math>}}.

- Wooldridge (2006) define o coeficiente de determinação como:
{{<math>}}\begin{align}
    R^2 &= \frac{SQE}{SQT} = 1 - \frac{SQR}{SQT}\\
        &= \frac{Var(\hat{y})}{Var(y)} = 1 - \frac{Var(\hat{\varepsilon})}{Var(y)} \tag{2.13}
\end{align}{{</math>}}
pois {{<math>}}$SQT = SQE + SQR${{</math>}}.


```r
# Calculando R^2 de três maneiras:
var(sal_hat) / var(sal)
```

```
## [1] 0.01318862
```

```r
1 - var(ehat)/var(sal)
```

```
## [1] 0.01318862
```

```r
cor(sal, sal_hat)^2 # correlação ao quadrado da variável dependente com valores ajustados
```

```
## [1] 0.01318862
```

- Para obter o {{<math>}}$R^2${{</math>}} de forma mais conveniente, pode-se usar a função `summary()` sobre o objeto de resultado da regressão. Esta função fornece uma visualização dos resultados mais detalhada, incluindo o {{<math>}}$R^2${{</math>}}:

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



{{< cta cta_text="👉 Seguir para Optimization" cta_link="../sec7" >}}
