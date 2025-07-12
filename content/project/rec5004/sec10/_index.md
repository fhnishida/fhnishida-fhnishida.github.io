---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: GLS/WLS/FGLS
summary: The section covers topics such as the variance-covariance matrix of errors, heteroskedasticity tests (including the Breusch-Pagan and White tests), and various estimators such as OLS with robust standard errors, GLS, WLS, and FGLS. The section provides R code examples for performing these analyses and includes references to relevant literature. Overall, this section of the webpage provides a comprehensive overview of econometric methods and techniques for analyzing data using R. It is a valuable resource for anyone interested in learning more about these topics.
title: Heterocedasticidade
weight: 10
output: md_document
type: book
---



- [Seções 8.2 e 8.3 de Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- Seções 5.5, 7.1 a 7.4 de Davidson e MacKinnon (1999)
- Seções 4.2.3 e 4.2.4 de Wooldridge


## Matriz de variâncias-covariâncias dos erros

Relembre que a matriz de variâncias-covariâncias dos erros é dada por:

{{<math>}}$$ cov(\boldsymbol{\varepsilon}) = \underset{N \times N}{\boldsymbol{\Sigma}} = 
\left[ \begin{array}{cccc}
var(\varepsilon_{1}) & cov(\varepsilon_{1}, \varepsilon_{2}) & \cdots & cov(\varepsilon_{1}, \varepsilon_{N}) \\
cov(\varepsilon_{2}, \varepsilon_{1}) & var(\varepsilon_{2}) & \cdots & cov(\varepsilon_{2}, \varepsilon_{N}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{N}, \varepsilon_{1}) & cov(\varepsilon_{N}, \varepsilon_{2}) & \cdots & var(\varepsilon_{N}) 
\end{array} \right]$${{</math>}}

Como assumimos amostragem aleatória, a covariância entre dois indivíduos distintos {{<math>}}($i \neq j$){{</math>}} é  
{{<math>}}$$ cov(\varepsilon_{i}, \varepsilon_{j}) = 0,  \qquad \text{para todo } i \neq j.$${{</math>}}

Logo, 
{{<math>}}$$ \boldsymbol{\Sigma} = 
\left[ \begin{array}{cccc}
var(\varepsilon_{1}) & 0 & \cdots & 0 \\
0 & var(\varepsilon_{2}) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & var(\varepsilon_{N}) 
\end{array} \right]$${{</math>}}


Para MQO, assumíamos homocedasticidade e, portanto, a diagonal principal era toda preenchida por um mesmo {{<math>}}$ var(\varepsilon_i) = \sigma^2,\ \forall i${{</math>}}.
Na presença de **heteroscedasticidade**, segue que {{<math>}}$ var(\varepsilon_i) = \sigma^2_i,\ \forall i${{</math>}} e, logo:

{{<math>}}$$ \boldsymbol{\Sigma} = 
\left[ \begin{array}{cccc}
\sigma^2_1 & 0 & \cdots & 0 \\
0 & \sigma^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2_N 
\end{array} \right] \ \neq\ \sigma^2 I_N $${{</math>}}

Como é uma matriz diagonal, é fácil computar a inversa da matriz:

{{<math>}}$$ \boldsymbol{\Sigma}^{-1} = 
\left[ \begin{array}{cccc}
1/\sigma^2_1 & 0 & \cdots & 0 \\
0 & 1/\sigma^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1/\sigma^2_N 
\end{array} \right]$${{</math>}}
e
{{<math>}}$$\boldsymbol{\Sigma}^{-0.5} = 
\left[ \begin{array}{cccc}
1/\sigma_1 & 0 & \cdots & 0 \\
0 & 1/\sigma_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1/\sigma_N 
\end{array} \right]$${{</math>}}


<br>



## Testes de heterocedasticidade

- A ideia os testes de heterocedasticidade é pegar os resíduos da estimação por MQO, {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}, e verificar sua correlação com as variáveis explicativas, {{<math>}}$\boldsymbol{X}${{</math>}}. Em caso de homocedasticidade, essa correlação deveria ser estatisticamente nula.
- Podemos testar isso por meio do testes de Breusch-Pagan ou de White.


### Teste de Breusch-Pagan

- Inicialmente, considere o seguinte modelo linear
{{<math>}}$$\boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}_{1} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} $${{</math>}}
- Ao estimá-lo por MQO, obtemos os resíduos
{{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}} = \boldsymbol{y} - \boldsymbol{X} \hat{\boldsymbol{\beta}}${{</math>}}
- Depois, fazemos a regressão dos resíduos ao quadrado em função das covariadas:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + \gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} = \boldsymbol{X} \boldsymbol{\gamma} + \boldsymbol{u} $${{</math>}}
- Breusch-Pagan (1979) e Koenker (1981) propuseram testar a hipótese nula **conjunta** de que todos os parâmetros são iguais a zero:
{{<math>}}$$H_0: \quad \boldsymbol{\gamma} = \boldsymbol{0} \iff \begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots \\ \gamma_K \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} $${{</math>}}

- A verificação dessa hipótese pode ser feita via estatística LM 

{{<math>}}$$ LM = N. R^2_{\scriptstyle{\hat{\varepsilon}}}\ \sim\ \chi^2_K $${{</math>}}


#### Exemplo 8.7: Demanda por Cigarros (Wooldridge)
- Nesta seção, vamos usar a base de dados `smoke` do pacote `wooldridge` para estimar o seguinte modelo:
{{<math>}}\begin{align}\text{cigs} = &\beta_0 + \beta_1 \text{lincome} + \beta_2 \text{lcigpric} + \beta_3 \text{educ} + \beta_4 \text{age}\\ &+ \beta_5 \text{agesq} + \beta_6 \text{restaurn} + \varepsilon \end{align}{{</math>}}
em que:

- _cigs_: cigarros fumados por dia
- _lincome_: log da renda
- _lcigpric_: log do preço do cigarro
- _educ_: anos de escolaridade
- _age_: idade
- _agesq_: idade ao quadrado
- _restaurn_: dummy resturante tem restrições de fumo


```r
library(lmtest) # precisa ser instalado
data(smoke, package="wooldridge")

# Regressão do modelo
reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke)
bptest(reg)
```

```
## 
## 	studentized Breusch-Pagan test
## 
## data:  reg
## BP = 32.258, df = 6, p-value = 1.456e-05
```

```r
# Teste BP na "mão"
N = nrow(smoke)
K = ncol(model.matrix(reg)) - 1

reg.resid = lm(resid(reg)^2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
               data=smoke)
r2e = summary(reg.resid)$r.squared
LM = N * r2e
1 - pchisq(LM, K)
```

```
## [1] 1.455779e-05
```

- Alternativamente, o teste também pode ser feito pela estatística LM (ou, também, Wald):
{{<math>}}$$ F_{\scriptscriptstyle{K, (N-K-1)}} = \frac{R^2_{\scriptstyle{\hat{\varepsilon}}}/K}{(1 - R^2_{\scriptstyle{\hat{\varepsilon}}}) / (N-K-1)} $${{</math>}}


```r
# Teste F já vem calculado no summary(lm())
summary(reg.resid)
```

```
## 
## Call:
## lm(formula = resid(reg)^2 ~ lincome + lcigpric + educ + age + 
##     agesq + restaurn, data = smoke)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -270.1 -127.5  -94.0  -39.1 4667.8 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -636.30306  652.49456  -0.975   0.3298    
## lincome       24.63848   19.72180   1.249   0.2119    
## lcigpric      60.97655  156.44869   0.390   0.6968    
## educ          -2.38423    4.52753  -0.527   0.5986    
## age           19.41748    4.33907   4.475 8.75e-06 ***
## agesq         -0.21479    0.04723  -4.547 6.27e-06 ***
## restaurn     -71.18138   30.12789  -2.363   0.0184 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 363.2 on 800 degrees of freedom
## Multiple R-squared:  0.03997,	Adjusted R-squared:  0.03277 
## F-statistic: 5.552 on 6 and 800 DF,  p-value: 1.189e-05
```

```r
# Teste F na "mão"
F = (r2e / K) / ((1-r2e) / (N-K-1))
F
```

```
## [1] 5.551687
```

```r
1 - pf(F, K, N-K-1)
```

```
## [1] 1.188811e-05
```

- Note que os testes avaliam se há heterocedasticidade, mas não mostra quais variáveis são responsáveis por isso.
- Por isso, pode ser interessante também visualizar os testes t de cada regressor na regressão sobre o quadrado do resíduos. Neste caso, aparenta ocorrer pela variável _age_, _agesq_ e _restaurn_.



### Teste de White

- Embora o teste de Breusch-Pagan seja interessante, ele avalia os erros apenas de forma linear nas variáveis explicativas:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + \gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u}$${{</math>}}
- Portanto, para capturar mais formas de heterocedasticidade, é interessante colocar também as **interações entre os regressores e seus quadrados** na forma:
{{<math>}}\begin{align} \hat{\boldsymbol{\varepsilon}}^2 = & \alpha + {\color{blue}\gamma_1 \boldsymbol{x}_{1} + ... + \gamma_K \boldsymbol{x}_{K}} + {\color{red}\delta_{11} \boldsymbol{x}^2_{1} + \delta_{12} (\boldsymbol{x}_{1}\boldsymbol{x}_{2}) + ... + \delta_{1K} (\boldsymbol{x}_{1}\boldsymbol{x}_{K})}\\
& {\color{red}+ \delta_{22} \boldsymbol{x}^2_{2} + \delta_{23} (\boldsymbol{x}_{2}\boldsymbol{x}_{3}) + ... + \delta_{KK}\boldsymbol{x}^2_{K}} + \boldsymbol{u} \end{align}{{</math>}}
- Então, o teste de hipótese seria:
{{<math>}}$$H_0: \quad \begin{bmatrix}\boldsymbol{\gamma} \\ \boldsymbol{\delta} \end{bmatrix} = \boldsymbol{0} \iff \begin{bmatrix} \gamma_1 \\ \gamma_2 \\ \vdots \\ \gamma_K \\ \delta_{11} \\ \delta_{12} \\ \vdots \\ \delta_{KK} \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \\ 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} $${{</math>}}
- O problema é que se perdem muitos graus de liberdade quando incluímos parâmetros para todas as interações e os quadrados dos regressores.
- White (1980) então mostrou que é possível fazer um teste equivalente incluindo apenas {{<math>}}$\hat{\boldsymbol{y}}${{</math>}} e {{<math>}}$\hat{\boldsymbol{y}}^2${{</math>}} como regressores no modelo do resíduo ao quadrado:
{{<math>}}$$\hat{\boldsymbol{\varepsilon}}^2 = \alpha + {\color{blue}\gamma \hat{\boldsymbol{y}}} + {\color{red}\delta \hat{\boldsymbol{y}}^2} + \boldsymbol{u}$${{</math>}}
- E o teste de hipótese se torna apenas
{{<math>}}$$H_0: \quad \begin{bmatrix}\gamma \\ \delta \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \end{bmatrix} $${{</math>}}
que também pode ser testada pelas estatísticas LM (Breusch-Pagan) ou F.


```r
# Valores ajustados
yhat = fitted(reg)

# Teste via bptest()
bptest(reg, ~ yhat + I(yhat^2))
```

```
## 
## 	studentized Breusch-Pagan test
## 
## data:  reg
## BP = 26.573, df = 2, p-value = 1.698e-06
```

```r
# Teste BP/LM "na mão"
reg.resid = lm(resid(reg)^2 ~ yhat + I(yhat^2), data=smoke)
r2e = summary(reg.resid)$r.squared
LM = N * r2e
1 - pchisq(LM, 2)
```

```
## [1] 1.697606e-06
```



<br>


## Estimador MQO com erros padrão robustos

- O estimador de MQO permanece não-viesado/consistente sob heterocedasticidade, mas perde eficiência.
- Um forma de contornar esse problema é modelarmos a matriz de variâncias-covariâncias **dos erros** {{<math>}}$\boldsymbol{\Sigma}${{</math>}}
- Primeiro, lembre-se que a matriz de variâncias-covariâncias **do estimador de MQO** é dada por
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}
- Como há heterocedasticidade, essa matriz não se simplifica para {{<math>}}$V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}) = \sigma^2 (\boldsymbol{X}' \boldsymbol{X})^{-1}${{</math>}}, porém também não conhecemos {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, que precisa ser estimado.
- A forma mais simples de obter {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}} foi sugerido por White (1980), que é preencher sua diagonal com o quadrado do resíduo de cada indivíduo (obtido por estimação MQO):
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = \begin{bmatrix}
\hat{\varepsilon}^2_1 & 0 & \cdots & 0 \\
0 & \hat{\varepsilon}^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \hat{\varepsilon}^2_N \end{bmatrix}$${{</math>}}
- Portanto, temos o estimador de matriz de covariâncias consistente com heterocedasticidade (HCCME)
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}
que é também é conhecido como estimador sanduíche, pois {{<math>}}$(\boldsymbol{X}' \boldsymbol{X})^{-1}${{</math>}} está nos extremos da fórmula (pão/_bread_), que "sanduicham" o termo {{<math>}}$\boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X}${{</math>}} (carne/_meat_).

### Estimação via lm() e vcovHC()


```r
# Usando fórmula vcovHC() do pacote sandwich
library(lmtest)
library(sandwich) # precisa ser instalado

# Regressão do modelo
reg = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke)

# Construindo matriz vcov do estimador ajustado por heterocedasticidade
vcov_sandwich = vcovHC(reg, type="HC0")
round(vcov_sandwich, 3)
```

```
##             (Intercept) lincome lcigpric   educ    age  agesq restaurn
## (Intercept)     650.511  -2.642 -149.814 -0.240 -0.489  0.005    3.823
## lincome          -2.642   0.352    0.009 -0.029 -0.019  0.000   -0.077
## lcigpric       -149.814   0.009   36.110  0.048  0.078 -0.001   -0.783
## educ             -0.240  -0.029    0.048  0.026 -0.001  0.000   -0.012
## age              -0.489  -0.019    0.078 -0.001  0.019  0.000   -0.002
## agesq             0.005   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn          3.823  -0.077   -0.783 -0.012 -0.002  0.000    1.007
```

```r
# Resultados
round(coeftest(reg), 3) # resultado padrão do MQO
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     24.079  -0.151    0.880    
## lincome        0.880      0.728   1.210    0.227    
## lcigpric      -0.751      5.773  -0.130    0.897    
## educ          -0.501      0.167  -3.002    0.003 ** 
## age            0.771      0.160   4.813   <2e-16 ***
## agesq         -0.009      0.002  -5.176   <2e-16 ***
## restaurn      -2.825      1.112  -2.541    0.011 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
round(coeftest(reg, vcov=vcov_sandwich), 3) # resultado com correção
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     25.505  -0.143    0.887    
## lincome        0.880      0.593   1.483    0.138    
## lcigpric      -0.751      6.009  -0.125    0.901    
## educ          -0.501      0.162  -3.102    0.002 ** 
## age            0.771      0.138   5.598   <2e-16 ***
## agesq         -0.009      0.001  -6.198   <2e-16 ***
## restaurn      -2.825      1.004  -2.815    0.005 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

- Note que, neste caso, os erros padrão foram pouco alterados com o ajuste.
- Para ter ganho em eficiência, {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}} precisa ser bem especificado. Há também outras formas de modelar {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}} na própria função `vcovHC()`.


### Estimação Analítica
- Também podemos fazer a inferência robusta a heterocedasticidade analiticamente:


```r
# Criando o vetor y
y = as.matrix(smoke[,"cigs"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, smoke[,c("lincome", "lcigpric", "educ", "age", "agesq",
                                 "restaurn")]) ) # juntando 1's com x

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1

# Estimativas MQO, valores preditos e resíduos
bhat = solve(t(X) %*% X) %*% t(X) %*% y
yhat = X %*% bhat
ehat = y - yhat
head(ehat^2)
```

```
##         [,1]
## 1 106.770712
## 2 115.665513
## 3  59.596771
## 4 105.280775
## 5  56.312306
## 6   5.950747
```

- Agora vamos estimar a matriz de variâncias-covariâncias dos erros pelo método de White, preenchendo a sua diagonal com os resíduos ao quadrado para cada indivíduo:
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = diag(\hat{\varepsilon}_1, \hat{\varepsilon}_2, ..., \hat{\varepsilon}_N)  = \begin{bmatrix}
\hat{\varepsilon}^2_1 & 0 & \cdots & 0 \\
0 & \hat{\varepsilon}^2_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \hat{\varepsilon}^2_N \end{bmatrix}$${{</math>}}


```r
# Estimando matriz de vcov dos erros (diagonal com resíduo^2 de cada indiv)
Sigma = diag(as.numeric(ehat^2)) # transformar em numeric p/ preencher diagonal
round(Sigma[1:7, 1:7], 3)
```

```
##         [,1]    [,2]   [,3]    [,4]   [,5]  [,6]    [,7]
## [1,] 106.771   0.000  0.000   0.000  0.000 0.000   0.000
## [2,]   0.000 115.666  0.000   0.000  0.000 0.000   0.000
## [3,]   0.000   0.000 59.597   0.000  0.000 0.000   0.000
## [4,]   0.000   0.000  0.000 105.281  0.000 0.000   0.000
## [5,]   0.000   0.000  0.000   0.000 56.312 0.000   0.000
## [6,]   0.000   0.000  0.000   0.000  0.000 5.951   0.000
## [7,]   0.000   0.000  0.000   0.000  0.000 0.000 142.419
```
- Note que foi necessário transformar `ehat^2` em numeric para aplicar o operador `diag()`. Caso não fosse feito, iria retornar um número ao invés de criar uma matriz diagonal preenchida com os resíduos ao quadrado.
- Agora, o podemos estimar a matriz de variâncias-covariâncias do estimador robusta a heterocedasticidade:
{{<math>}}$$V(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}' \boldsymbol{X})^{-1}$${{</math>}}


```r
# Matriz de variâncias-covariância do estimador
bread = solve(t(X) %*% X)
meat = t(X) %*% Sigma %*% X
Vbhat = bread %*% meat %*% bread
round(Vbhat, 3)
```

```
##                 1 lincome lcigpric   educ    age  agesq restaurn
## 1         650.511  -2.642 -149.814 -0.240 -0.489  0.005    3.823
## lincome    -2.642   0.352    0.009 -0.029 -0.019  0.000   -0.077
## lcigpric -149.814   0.009   36.110  0.048  0.078 -0.001   -0.783
## educ       -0.240  -0.029    0.048  0.026 -0.001  0.000   -0.012
## age        -0.489  -0.019    0.078 -0.001  0.019  0.000   -0.002
## agesq       0.005   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn    3.823  -0.077   -0.783 -0.012 -0.002  0.000    1.007
```
- Só falta calcular os erros padrão, estísticas t e p-valores:

```r
# Erro padrão robusto, estat t e p-valor
se = sqrt(diag(Vbhat))
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Resultados
round(data.frame(bhat, se, t, p), 3) # resultado obtido analiticamente
```

```
##            bhat     se      t     p
## 1        -3.640 25.505 -0.143 0.887
## lincome   0.880  0.593  1.483 0.138
## lcigpric -0.751  6.009 -0.125 0.901
## educ     -0.501  0.162 -3.102 0.002
## age       0.771  0.138  5.598 0.000
## agesq    -0.009  0.001 -6.198 0.000
## restaurn -2.825  1.004 -2.815 0.005
```

```r
round(coeftest(reg, vcov=vcov_sandwich), 3) # obtido por funções
```

```
## 
## t test of coefficients:
## 
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   -3.640     25.505  -0.143    0.887    
## lincome        0.880      0.593   1.483    0.138    
## lcigpric      -0.751      6.009  -0.125    0.901    
## educ          -0.501      0.162  -3.102    0.002 ** 
## age            0.771      0.138   5.598   <2e-16 ***
## agesq         -0.009      0.001  -6.198   <2e-16 ***
## restaurn      -2.825      1.004  -2.815    0.005 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



<br>

## Estimador MQG

- Alternativamente, podemos fazer a estimação e a inferência modelando a matriz de variâncias-covariâncias dos erros, {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- O estimador de Mínimos Quadrados Generalizados (MQG/GLS), assumindo dados em corte transversal, é dado por
{{<math>}}$$ {\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQG}} = (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) $${{</math>}}

- A matriz de variâncias-covariâncias do estimador é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQG}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} $${{</math>}}

- O problema é que desconhecemos {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, e precisamos fazer mais premissas sobre a forma da matriz de variâncias-covariâncias dos erros (e sua inversa) para estimar {{<math>}}$\boldsymbol{\hat{\Sigma}}${{</math>}}.



<br>

## Estimador MQP

- [Seção 4.1 de Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- [Weighted Least Squares (Yibi Huang)](https://www.stat.uchicago.edu/~yibi/teaching/stat224/L14.pdf)

- Um caso especial de MQG é o estimador de Mínimos Quadrados Ponderados (MQP/WLS), que considera que a variância do erro de cada observação é conhecida e proporcional a das demais.
- A variância do erro individual é a partir uma função das variáveis explicativas, {{<math>}}$h(\boldsymbol{x}'_i)${{</math>}}:
{{<math>}}$$ Var(\varepsilon_i | \boldsymbol{x}'_i) = \sigma^2.h(\boldsymbol{x}'_i), $${{</math>}}
ou seja,
{{<math>}}\begin{align} \boldsymbol{\Sigma} &= 
\left[ \begin{array}{cccc}
\sigma^2 h(\boldsymbol{x}'_1) & 0 & \cdots & 0 \\
0 & \sigma^2 h(\boldsymbol{x}'_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2 h(\boldsymbol{x}'_1) 
\end{array} \right] \\
&= \sigma^2 \left[ \begin{array}{cccc}
h(\boldsymbol{x}'_1) & 0 & \cdots & 0 \\
0 & h(\boldsymbol{x}'_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & h(\boldsymbol{x}'_N) 
\end{array} \right] \\
&\equiv \sigma^2 \boldsymbol{W}^{-1}
\end{align}{{</math>}}
em que {{<math>}}$\boldsymbol{W}${{</math>}} é uma matriz de pesos:
{{<math>}}$$ \boldsymbol{W} = \left[ \begin{array}{cccc}
\frac{1}{h(\boldsymbol{x}'_1)} & 0 & \cdots & 0 \\
0 & \frac{1}{h(\boldsymbol{x}'_2)} & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \frac{1}{h(\boldsymbol{x}'_N)}
\end{array} \right] \equiv \left[ \begin{array}{cccc}
w_1 & 0 & \cdots & 0 \\
0 & w_2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & w_N
\end{array} \right] $${{</math>}}
em que {{<math>}}$w_i${{</math>}} são os pesos da estimação.

<br>

- Por exemplo, considere que a variância das mulheres é o dobro da variância dos homens ({{<math>}}$\sigma^2_M = 2.\sigma^2_H ${{</math>}}), então:
{{<math>}}$$ h(\text{female}_i) = \left\{ \begin{matrix} 
2, &\text{se female}_i = 1 \\
1, &\text{se female}_i = 0
\end{matrix} \right. $${{</math>}}

- Considerando que as {{<math>}}$M${{</math>}} primeiras linhas são de mulheres, a matriz de variâncias-covariâncias dos erros pode ser simplificada para:
{{<math>}}\begin{align} \boldsymbol{\Sigma} &= 
\left[ \begin{array}{cccc}
\sigma^2_M & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \sigma^2_M & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2_H & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2_H \\
\end{array} \right] \\
&= \left[ \begin{array}{cccc}
2\sigma^2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2\sigma^2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2 \\
\end{array} \right] \\ 
&= \left[ \begin{array}{cccc}
2\sigma^2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2\sigma^2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & \sigma^2 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \sigma^2 \\
\end{array} \right] \\
&= \sigma^2 \left[ \begin{array}{cccc}
2 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2 & 0 & \cdots & 0 \\
0 & \cdots & 0 & 1 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & 1 \\
\end{array} \right] 
\end{align}{{</math>}}


- Por ser uma matriz diagonal, as seguintes matrizes são facilmente calculadas:
{{<math>}}$$ \boldsymbol{\Sigma}^{-1} = 
\frac{1}{\sigma^2} \left[ \begin{array}{cccc}
\frac{1}{2} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{2} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{1} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{1} \\
\end{array} \right] \equiv 
\frac{1}{\sigma^2} \boldsymbol{W}, $${{</math>}}
e
{{<math>}}$$ \boldsymbol{\Sigma}^{-0.5} = 
\frac{1}{\sigma} \left[ \begin{array}{cccc}
\frac{1}{\sqrt{2}} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{\sqrt{2}} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{\sqrt{1}} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{\sqrt{1}} \\
\end{array} \right] \equiv 
\frac{1}{\sigma} \boldsymbol{W}^{0.5} $${{</math>}}


<br>

- Disto, podemos obter o estimador {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}${{</math>}}:

{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQG}} &= (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) \\
&= \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{y} \right) \\
&= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \frac{1}{\sigma^2} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}
\end{align}{{</math>}}


- A matriz de variâncias-covariâncias do estimador de MQP é dada por

{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQG}}) &= \left(\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X} \right)^{-1} \\
&= \left(\boldsymbol{X}' \frac{1}{\sigma^2} \boldsymbol{W} \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} = V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}) \end{align}{{</math>}}


<!-- - Note que, para calcularmos {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}${{</math>}} precisamos estimar {{<math>}}$\sigma^2${{</math>}}. Porém, a variância dos erros é estimada a partir de resíduos, {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}, que por sua vez são obtidos a partir de estimativas {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}}. -->

- A variância dos erros, {{<math>}}$\sigma^2${{</math>}}, pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


<br>

- Também podemos transformar as variáveis e resolver por MQO, pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{W}^{0.5}${{</math>}}, e definindo:
{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{y}$${{</math>}}

- No exemplo em que a variância da mulher é o dobro da variância do homem, temos:
{{<math>}}\begin{align} \boldsymbol{W}^{0.5} \boldsymbol{y} &= \begin{bmatrix}
2^{0.5} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 2^{0.5} & 0 & \cdots & 0 \\
0 & \cdots & 0 & 1^{0.5} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & 1^{0.5} \\
\end{bmatrix} \begin{bmatrix} y_1 \\ \vdots \\ y_M \\ y_{M+1} \\ \vdots \\ y_N \end{bmatrix}\\
&= \begin{bmatrix}
\frac{1}{\sqrt{2}} & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & \frac{1}{\sqrt{2}} & 0 & \cdots & 0 \\
0 & \cdots & 0 & \frac{1}{\sqrt{1}} & \cdots & 0 \\
\vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
0 & \cdots & 0 & 0 & \cdots & \frac{1}{\sqrt{1}} \\
\end{bmatrix} \begin{bmatrix}  y_1 \\ \vdots \\ y_M \\ y_{M+1} \\ \vdots \\ y_N \end{bmatrix} \\
&= \begin{bmatrix} \frac{1}{\sqrt{2}} y_1 \\ \vdots \\ \frac{1}{\sqrt{2}}  y_M \\ \frac{1}{\sqrt{1}}  y_{M+1} \\ \vdots \\ \frac{1}{\sqrt{1}} y_N \end{bmatrix} \end{align}{{</math>}}
em que {{<math>}}$M${{</math>}} é o número de mulheres na base de dados.

- Note que as variáveis {{<math>}}$\boldsymbol{y}${{</math>}} e {{<math>}}$\boldsymbol{X}${{</math>}} ficam multiplicadas pelo inverso da raiz de seus respectivos pesos, quando as pré-multiplicamos por {{<math>}}$\boldsymbol{W}${{</math>}}.


- Observe também que os estimadores são equivalentes:
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}} &= \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' \boldsymbol{W}^{0.5} \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' \boldsymbol{W}^{0.5} \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= \left( \left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5} \boldsymbol{X} \right)^{-1} \left(\left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5} \boldsymbol{y} \right) \\
&= ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} ) \equiv \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}} \end{align}{{</math>}}
e
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}) &= \sigma^2 \left(\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}} \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\boldsymbol{X}' {\boldsymbol{W}^{0.5}}^{\prime} \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left(\left[ \boldsymbol{W}^{0.5} \boldsymbol{X} \right]' \boldsymbol{W}^{0.5}  \boldsymbol{X} \right)^{-1} \\
V(\tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}}) &= \sigma^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1}
\end{align}{{</math>}}

em que usamos {{<math>}}$\boldsymbol{W}^{0.5} = {\boldsymbol{W}^{0.5}}^{\prime}${{</math>}} (matriz simétrica).



### Estimação via `lm()`

- Aqui usaremos um exemplo parecido com o que simulamos em uma seção anterior, pois é difícil encontrar um exemplo que saiba o formato exato da heterocedasticidade à priori.
- Vamos criar observações do seguinte modelo real com presença de heterocedasticidade:
{{<math>}}$$ y = \tilde{\beta}_0 + \tilde{\beta}_1 x + \tilde{\varepsilon}, \qquad \tilde{\varepsilon} \sim N(0, (10x)^2) $${{</math>}}
logo
{{<math>}}$$ Var(\tilde{\varepsilon}_i | x_i) = \sigma^2 (10x_i)^2 \quad \implies\quad sd(\tilde{\varepsilon}_i | x_i) = \sigma (10x_i) $${{</math>}}
- Para estimar o MQP via `lm()`, precisamos informar os pesos no argumento `weights`


```r
# Definindo parâmetros
b0til = 50
b1til = -5
N = 100

# Gerando x e y por simulação
set.seed(123)
x = runif(N, 1, 9) # Gerando 100 obs. de x
e_til = rnorm(N, 0, 10*x) # Erros: 100 obs. de média 0 e desv pad 10x
y = b0til + b1til*x + e_til # calculando observações y
plot(x, y)
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-9-1.png" width="672" />

- Agora, vamos estimar por MQO e MQP o seguinte modelo empírico
{{<math>}}$$ y = \beta_0 + \beta_1 x + \varepsilon $${{</math>}}


```r
# Estimações
reg.ols = lm(y ~ x) # estimação por MQO
reg.wls = lm(y ~ x, weights=1/(10*x)^2) # estimação por MQP
stargazer::stargazer(reg.ols, reg.wls, digits=2, type="text", omit.stat="f")
```

```
## 
## ==========================================================
##                                   Dependent variable:     
##                               ----------------------------
##                                            y              
##                                    (1)            (2)     
## ----------------------------------------------------------
## x                                -5.51**       -5.92***   
##                                   (2.35)        (1.77)    
##                                                           
## Constant                         49.27***      51.43***   
##                                  (12.87)        (5.50)    
##                                                           
## ----------------------------------------------------------
## Observations                       100            100     
## R2                                 0.05          0.10     
## Adjusted R2                        0.04          0.09     
## Residual Std. Error (df = 98)     53.30          0.97     
## ==========================================================
## Note:                          *p<0.1; **p<0.05; ***p<0.01
```

- Veja que a estimação por MQP foi mais eficiente - produziu erros padrão menores, dado que **já sabíamos que a variância do erro era proporcional à variável _x_**.
- Na prática, é difícil conhecer/defender uma forma exata da heterocedasticidade, já que não conhecemos o modelo real da variância do erro.
- Abaixo, segue uma estimação feita com pesos errados {{<math>}}$ Var(\tilde{\varepsilon}_i | x_i) = \sigma^2 \left(\frac{1}{10 x_i}\right)^2${{</math>}} e note que, inclusive, afeta a estimativas (além de piorar os erros padrão):

```r
# Estimações
reg.wls2 = lm(y ~ x, weights=x^2) # estimação por MQP
stargazer::stargazer(reg.ols, reg.wls, reg.wls2, digits=2, type="text", omit.stat="f")
```

```
## 
## ===========================================================
##                                    Dependent variable:     
##                               -----------------------------
##                                             y              
##                                  (1)        (2)      (3)   
## -----------------------------------------------------------
## x                              -5.51**   -5.92***   -2.60  
##                                 (2.35)    (1.77)    (3.88) 
##                                                            
## Constant                       49.27***  51.43***   30.54  
##                                (12.87)    (5.50)   (26.90) 
##                                                            
## -----------------------------------------------------------
## Observations                     100        100      100   
## R2                               0.05      0.10     0.005  
## Adjusted R2                      0.04      0.09     -0.01  
## Residual Std. Error (df = 98)   53.30      0.97     368.51 
## ===========================================================
## Note:                           *p<0.1; **p<0.05; ***p<0.01
```


<!-- - Vamos continuar com a base de dados de cigarros -->
<!-- - Aqui, vamos assumir que a variância dos erros é dada por -->
<!-- {{<math>}}$$ Var(\varepsilon_i | \text{age}_i) = \sigma^2 (\text{age}_i + \text{age}^2_i)$${{</math>}} -->
<!-- - Agora, vamos estimar por MQO e MQP: -->

<!-- ```{r warning=FALSE} -->
<!-- data(smoke, package="wooldridge") -->

<!-- # Regressão do modelo -->
<!-- reg.ols = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, data=smoke) -->
<!-- reg.wls = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn, -->
<!--              weights=1/(age + agesq), data=smoke) -->

<!-- stargazer::stargazer(reg.ols, reg.wls, digits=4, type="text") -->
<!-- ``` -->



### Estimação Analítica

**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(y) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, x) ) # juntando 1's com x

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


**b)** Matriz de pesos {{<math>}}$\boldsymbol{W}${{</math>}}

- É a matriz cuja diagonal principal é preenchida pelos pesos, {{<math>}}$w_i = 1/x^2_i${{</math>}} 


```r
W = diag(1/x^2)
round(W[1:10,1:10], 2)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,] 0.09 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [2,] 0.00 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [3,] 0.00 0.00 0.05 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [4,] 0.00 0.00 0.00 0.02 0.00 0.00 0.00 0.00 0.00  0.00
##  [5,] 0.00 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00  0.00
##  [6,] 0.00 0.00 0.00 0.00 0.00 0.54 0.00 0.00 0.00  0.00
##  [7,] 0.00 0.00 0.00 0.00 0.00 0.00 0.04 0.00 0.00  0.00
##  [8,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.00  0.00
##  [9,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.03  0.00
## [10,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.05
```

**c)** Estimativas MQP {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}} = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} $${{</math>}}


```r
bhat_wls = solve( t(X) %*% W %*% X ) %*% t(X) %*% W %*% y
bhat_wls
```

```
##        [,1]
##   51.433290
## x -5.923353
```

**d)** Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{MQP}}${{</math>}}

```r
yhat_wls = X %*% bhat_wls
head(yhat_wls)
```

```
##            [,1]
## [1,] 31.8825514
## [2,]  8.1546597
## [3,] 26.1298192
## [4,]  3.6665460
## [5,]  0.9441786
## [6,] 43.3511590
```


**e)** Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQP}}${{</math>}}

```r
ehat_wls = y - yhat_wls
head(ehat_wls)
```

```
##             [,1]
## [1,]   9.9754298
## [2,]   3.2273830
## [3,]   0.6797571
## [4,] 116.3787515
## [5,] -12.8069979
## [6,]  20.5180944
```

**f)** Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{MQP}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat_wls = as.numeric( t(ehat_wls) %*% W %*% ehat_wls / (N-K-1) )
sig2hat_wls
```

```
## [1] 93.95364
```

**h)** Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} $${{</math>}}


```r
Vbhat_wls = sig2hat_wls * solve( t(X) %*% W %*% X )
round(Vbhat_wls, 3)
```

```
##               x
##   30.248 -8.144
## x -8.144  3.132
```


**i)** Erros-padrão, estatísticas t e p-valores

```r
se_wls = sqrt( diag(Vbhat_wls) )
t_wls = bhat_wls / se_wls
p_wls = 2 * pt(-abs(t_wls), N-K-1)

# Resultados
data.frame(bhat_wls, se_wls, t_wls, p_wls) # resultado MQP
```

```
##    bhat_wls   se_wls     t_wls        p_wls
##   51.433290 5.499861  9.351743 3.090884e-15
## x -5.923353 1.769796 -3.346913 1.159943e-03
```

```r
summary(reg.wls)$coef # resultado MQP via lm()
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 51.433290   5.499861  9.351743 3.090884e-15
## x           -5.923353   1.769796 -3.346913 1.159943e-03
```



#### Transformando e estimando por MQO
- Agora, vamos transformar as variáveis e resolver por MQO, pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{W}^{0.5}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W}^{0.5} \boldsymbol{y}$${{</math>}}


**b')** Matriz de pesos {{<math>}}$\boldsymbol{W}^{0.5}${{</math>}}

- É a matriz cuja diagonal principal é preenchida pelas raízes quadradas dos pesos


```r
W_0.5 = diag(1/(10*x))
round(W_0.5[1:10,1:10], 2)
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,] 0.03 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [2,] 0.00 0.01 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [3,] 0.00 0.00 0.02 0.00 0.00 0.00 0.00 0.00 0.00  0.00
##  [4,] 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00 0.00  0.00
##  [5,] 0.00 0.00 0.00 0.00 0.01 0.00 0.00 0.00 0.00  0.00
##  [6,] 0.00 0.00 0.00 0.00 0.00 0.07 0.00 0.00 0.00  0.00
##  [7,] 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.00 0.00  0.00
##  [8,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.01 0.00  0.00
##  [9,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02  0.00
## [10,] 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00  0.02
```

**b'')** Variáveis transformadas {{<math>}}$\tilde{\boldsymbol{y}}${{</math>}} e {{<math>}}$\tilde{\boldsymbol{X}}${{</math>}}

```r
ytil = W_0.5 %*% y
Xtil = W_0.5 %*% X
# Gráficos
plot(x, ytil, ylim=c(-125,175), 
     main=expression(paste("Gráfico ", x ," \u00D7 ", tilde(y))),
     xlab=expression(x), ylab=expression(tilde(y))) # plot xtil e ytil
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-21-1.png" width="672" />

```r
plot(x, y, ylim=c(-125,175), 
     main=expression(paste("Gráfico ", x ," \u00D7 ", y)),
     xlab=expression(x), ylab=expression(y)) # plot x e y
```

<img src="/project/rec5004/sec10/_index_files/figure-html/unnamed-chunk-21-2.png" width="672" />


**c')** Estimativas MQO {{<math>}}$\tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQo}} = (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}


```r
bhat_ols = solve( t(Xtil) %*% Xtil ) %*% t(Xtil) %*% ytil
bhat_ols
```

```
##        [,1]
##   51.433290
## x -5.923353
```

**d')** Valores ajustados {{<math>}}$\tilde{\hat{\boldsymbol{y}}}_{\scriptscriptstyle{MQO}}${{</math>}}

```r
yhat_ols = Xtil %*% bhat_ols
head(yhat_ols)
```

```
##            [,1]
## [1,] 0.96595639
## [2,] 0.11160919
## [3,] 0.61167951
## [4,] 0.04546730
## [5,] 0.01107705
## [6,] 3.17718463
```


**e')** Resíduos {{<math>}}$\tilde{\hat{\boldsymbol{\varepsilon}}}_{\scriptscriptstyle{MQO}}${{</math>}}

```r
ehat_ols = ytil - yhat_ols
head(ehat_ols)
```

```
##             [,1]
## [1,]  0.30222895
## [2,]  0.04417175
## [3,]  0.01591261
## [4,]  1.44316397
## [5,] -0.15025095
## [6,]  1.50376081
```

**f')** Estimativa da variância do erro {{<math>}}$\tilde{\hat{\sigma}}^2_{\scriptscriptstyle{MQO}}${{</math>}}
{{<math>}}$$\tilde{\hat{\sigma}}^2 =  \frac{\tilde{\hat{\boldsymbol{\varepsilon}}}' \tilde{\hat{\boldsymbol{\varepsilon}}}}{N - K - 1} $${{</math>}}


```r
sig2hat_ols = as.numeric( t(ehat_ols) %*% ehat_ols / (N-K-1) )
sig2hat_ols
```

```
## [1] 0.9395364
```

**h')** Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}) = \tilde{\hat{\sigma}}^2(\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
Vbhat_ols = sig2hat_ols * solve( t(Xtil) %*% Xtil )
round(Vbhat_ols, 3)
```

```
##               x
##   30.248 -8.144
## x -8.144  3.132
```


**i')** Erros-padrão, estatísticas t e p-valores

```r
se_ols = sqrt( diag(Vbhat_ols) )
t_ols = bhat_ols / se_ols
p_ols = 2 * pt(-abs(t_ols), N-K-1)

# Resultados
data.frame(bhat_ols, se_ols, t_ols, p_ols) # resultado MQO transformado
```

```
##    bhat_ols   se_ols     t_ols        p_ols
##   51.433290 5.499861  9.351743 3.090884e-15
## x -5.923353 1.769796 -3.346913 1.159943e-03
```

```r
summary(reg.wls)$coef # resultado MQP via lm()
```

```
##              Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 51.433290   5.499861  9.351743 3.090884e-15
## x           -5.923353   1.769796 -3.346913 1.159943e-03
```


<br>

## Estimador MQGF

- Na prática, é difícil conhecer a priori a matriz de variâncias-covariâncias dos erros.
- Uma forma razoável é supor que {{<math>}}$\boldsymbol{\Sigma}${{</math>}} é uma função de parâmetros de um modelo linear {{<math>}}$\boldsymbol{\gamma}${{</math>}} desconhecidos.
- Assim, podemos calcular {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}} para obter {{<math>}}$\boldsymbol{\Sigma}(\hat{\boldsymbol{\gamma}})${{</math>}}, a partir de resíduos de MQO.
- Esse tipo de procedimento é conhecido como Mínimos Quadrados Generalizados Factíveis (MQGF/FGLS), pois seu cálculo é possível enquanto o MQG não é.

- Note que, se {{<math>}}$\boldsymbol{\Sigma}(\hat{\boldsymbol{\gamma}})${{</math>}} não for uma boa aproximação de {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, então as estimativas e inferências por MQGF poderão ser ruins.


<br>

- Queremos estimar o modelo
{{<math>}}$$y_i = \beta_0 + \beta_1 x_{i1} + ... + \beta_K x_{iK} + \varepsilon_i = \boldsymbol{x}'_i \boldsymbol{\beta} + \varepsilon_i, \tag{1} $${{</math>}}
enquanto, geralmente, assume-se a variância do erro individual é dada por:
{{<math>}}$$Var(\varepsilon_i | \boldsymbol{x}'_i) = \sigma^2 \exp(\boldsymbol{x}'_i \boldsymbol{\gamma}). $${{</math>}}

- A função {{<math>}}$\exp(\boldsymbol{x}'_i \boldsymbol{\gamma})${{</math>}} é um exemplo de função _skedastic_, que garante que, após cálculo de {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}, o valor ajustado não seja negativo (para a variância do indivíduo ser sempre positiva).

- Para estimar {{<math>}}$\boldsymbol{\gamma}${{</math>}}, é necessário ter estimativas {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}} consistentes. A forma mais comum é começar calculando {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}.
- Depois, é feita a regressão linear auxiliar
{{<math>}}$$ \log{\hat{\varepsilon}}^2_i = \boldsymbol{x}'_i \boldsymbol{\gamma} + u_i, \tag{2} $${{</math>}}
- A partir da estimação, podemos usar os valores ajustados para calcular
{{<math>}}$$h(\boldsymbol{x}'_i) = \exp(\boldsymbol{x}'_i \boldsymbol{\gamma})$${{</math>}}
que é a inverso do peso
{{<math>}}$$w_i = \frac{1}{h(\boldsymbol{x}'_i)} = \frac{1}{\exp(\boldsymbol{x}'_i \boldsymbol{\gamma})}$${{</math>}}

- Com {{<math>}}$\boldsymbol{W}${{</math>}} estimado, podemos calcular {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}} e {{<math>}}$V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}})${{</math>}}, seguindo os mesmos passos de MQP.
- Podemos usar esse {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}} estimado para estimar um novo {{<math>}}$\boldsymbol{\gamma}${{</math>}} e um novo {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}}. Isso pode ser feito iteradamente até sua convergência (se isso ocorrer) ou até um certo número de repetições.


### Estimação via lm()


```r
data(smoke, package="wooldridge")

# Estimação por MQO
reg.ols = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
             data=smoke)
round(summary(reg.ols)$coef, 4)
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  -3.6398    24.0787 -0.1512   0.8799
## lincome       0.8803     0.7278  1.2095   0.2268
## lcigpric     -0.7509     5.7733 -0.1301   0.8966
## educ         -0.5015     0.1671 -3.0016   0.0028
## age           0.7707     0.1601  4.8132   0.0000
## agesq        -0.0090     0.0017 -5.1765   0.0000
## restaurn     -2.8251     1.1118 -2.5410   0.0112
```

```r
# Obtenção dos pesos wi = 1/h(zi) = 1/exp(Xg)
logu2 = log(resid(reg.ols)^2)
reg.var = lm(logu2 ~ lincome + lcigpric + educ + age + agesq + restaurn,
             data=smoke)
w = 1/exp(fitted(reg.var))

# Estimação por MQGF
reg.fgls = lm(cigs ~ lincome + lcigpric + educ + age + agesq + restaurn,
              weight=w, data=smoke)
round(summary(reg.fgls)$coef, 4)
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   5.6355    17.8031  0.3165   0.7517
## lincome       1.2952     0.4370  2.9639   0.0031
## lcigpric     -2.9403     4.4601 -0.6592   0.5099
## educ         -0.4634     0.1202 -3.8570   0.0001
## age           0.4819     0.0968  4.9784   0.0000
## agesq        -0.0056     0.0009 -5.9897   0.0000
## restaurn     -3.4611     0.7955 -4.3508   0.0000
```


### Estimação Analítica
- Parecida com MQP, apenas o início é diferente:
**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(smoke[,"cigs"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, smoke[,c("lincome", "lcigpric", "educ", "age", "agesq",
                                 "restaurn")]) ) # juntando 1's com x

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


**b1)** Estimação por MQO para obter {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}


```r
bhat_ols = solve(t(X) %*% X) %*% t(X) %*% y
yhat = X %*% bhat_ols
ehat = y - yhat
```

**b2)** Regressão do log dos resíduos ao quadrado e estimação de {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}
{{<math>}}$$ \log{\hat{\boldsymbol{\varepsilon}}}^2 = \boldsymbol{X} \boldsymbol{\gamma} + \boldsymbol{u} $${{</math>}}

```r
ghat = solve( t(X) %*% X ) %*% t(X) %*% log(ehat^2)
```


**b3)** Matriz de pesos {{<math>}}$\boldsymbol{W}${{</math>}}
{{<math>}}$$\boldsymbol{W} = diag\left(\frac{1}{\exp(\boldsymbol{X} \hat{\boldsymbol{\gamma}})}\right) = \begin{bmatrix}
\frac{1}{\exp(\boldsymbol{x}'_1\hat{\boldsymbol{\gamma}})} & 0 & \cdots & 0 \\
0 & \frac{1}{\exp(\boldsymbol{x}'_2\hat{\boldsymbol{\gamma}})} & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \frac{1}{\exp(\boldsymbol{x}'_N\hat{\boldsymbol{\gamma}})}
\end{bmatrix}$${{</math>}}


```r
W = diag(as.numeric(1 / exp(X %*% ghat)))
round(W[1:7,1:7], 3)
```

```
##       [,1]  [,2]  [,3] [,4]  [,5]  [,6]  [,7]
## [1,] 0.008 0.000 0.000 0.00 0.000 0.000 0.000
## [2,] 0.000 0.007 0.000 0.00 0.000 0.000 0.000
## [3,] 0.000 0.000 0.009 0.00 0.000 0.000 0.000
## [4,] 0.000 0.000 0.000 0.01 0.000 0.000 0.000
## [5,] 0.000 0.000 0.000 0.00 0.024 0.000 0.000
## [6,] 0.000 0.000 0.000 0.00 0.000 0.444 0.000
## [7,] 0.000 0.000 0.000 0.00 0.000 0.000 0.007
```

- Os próximos passos são os mesmos de MQP:

**c)** Estimativas MQGF {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}}
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} $${{</math>}}


```r
bhat_fgls = solve( t(X) %*% W %*% X ) %*% t(X) %*% W %*% y
bhat_fgls
```

```
##                 [,1]
## 1         5.63546183
## lincome   1.29523990
## lcigpric -2.94031229
## educ     -0.46344637
## age       0.48194788
## agesq    -0.00562721
## restaurn -3.46106414
```

**d)** Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{MQGF}}${{</math>}}

```r
yhat_fgls = X %*% bhat_fgls
head(yhat_fgls)
```

```
##        [,1]
## 1  9.246793
## 2  9.914233
## 3 10.527827
## 4  9.667243
## 5  8.440092
## 6  2.048962
```


**e)** Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQGF}}${{</math>}}

```r
ehat_fgls = y - yhat_fgls
head(ehat_fgls)
```

```
##        [,1]
## 1 -9.246793
## 2 -9.914233
## 3 -7.527827
## 4 -9.667243
## 5 -8.440092
## 6 -2.048962
```

**f)** Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{MQGF}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 =  \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat_fgls = as.numeric( t(ehat_fgls) %*% W %*% ehat_fgls / (N-K-1) )
sig2hat_fgls
```

```
## [1] 2.492289
```

**h)** Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQP}}) = (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1} $${{</math>}}


```r
Vbhat_fgls = sig2hat_fgls * solve( t(X) %*% W %*% X )
round(Vbhat_fgls, 3)
```

```
##                1 lincome lcigpric   educ    age  agesq restaurn
## 1        316.952   0.444  -77.432  0.196 -0.389  0.004    2.323
## lincome    0.444   0.191   -0.463 -0.016 -0.007  0.000    0.008
## lcigpric -77.432  -0.463   19.893 -0.050  0.071 -0.001   -0.620
## educ       0.196  -0.016   -0.050  0.014 -0.001  0.000    0.002
## age       -0.389  -0.007    0.071 -0.001  0.009  0.000   -0.009
## agesq      0.004   0.000   -0.001  0.000  0.000  0.000    0.000
## restaurn   2.323   0.008   -0.620  0.002 -0.009  0.000    0.633
```


**i)** Erros-padrão, estatísticas t e p-valores

```r
se_fgls = sqrt( diag(Vbhat_fgls) )
t_fgls = bhat_fgls / se_fgls
p_fgls = 2 * pt(-abs(t_fgls), N-K-1)

# Resultados
round(data.frame(bhat_fgls, se_fgls, t_fgls, p_fgls), 4) # resultado MQP
```

```
##          bhat_fgls se_fgls  t_fgls p_fgls
## 1           5.6355 17.8031  0.3165 0.7517
## lincome     1.2952  0.4370  2.9639 0.0031
## lcigpric   -2.9403  4.4601 -0.6592 0.5099
## educ       -0.4634  0.1202 -3.8570 0.0001
## age         0.4819  0.0968  4.9784 0.0000
## agesq      -0.0056  0.0009 -5.9897 0.0000
## restaurn   -3.4611  0.7955 -4.3508 0.0000
```

```r
round(summary(reg.fgls)$coef, 4) # resultado MQGF via lm()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   5.6355    17.8031  0.3165   0.7517
## lincome       1.2952     0.4370  2.9639   0.0031
## lcigpric     -2.9403     4.4601 -0.6592   0.5099
## educ         -0.4634     0.1202 -3.8570   0.0001
## age           0.4819     0.0968  4.9784   0.0000
## agesq        -0.0056     0.0009 -5.9897   0.0000
## restaurn     -3.4611     0.7955 -4.3508   0.0000
```



<br>




{{< cta cta_text="👉 Proceed to Instrumental Variable" cta_link="../sec11" >}}


