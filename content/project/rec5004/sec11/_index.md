---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: VI/2SLS/SEM
summary: Instrumental Variable Regression.
title: Instrumental Variable, Two-Stages Least Squares and Simulteneous Equations Model
weight: 11
output: md_document
type: book
---



## Notações

- Considere, para a observação {{<math>}}$i${{</math>}}, o modelo multivariado com {{<math>}}$K${{</math>}} regressores:
{{<math>}}$$ y_i = \beta_0 + \beta_1 x^*_{i1} + ... + \beta_J x^*_{iJ} + \beta_{J+1} x_{i,J+1} + ... + \beta_K x_{iK} + \varepsilon_i, \qquad i=1, 2, ..., N \tag{1} $${{</math>}}
em que {{<math>}}$\boldsymbol{x}^*_1, ..., x^*_{iJ}${{</math>}} são as {{<math>}}$J${{</math>}} variáveis endógenas do modelo, {{<math>}}$N${{</math>}} observações.


- Matricialmente, podemos escrever (1) como:
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \tag{2} $${{</math>}}
em que
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{X}} = \left[ \begin{matrix} 1 & x^*_{11} & \cdots & x_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & z_{NJ} & x^*_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}
{{<math>}}$$ \underset{N \times 1}{\boldsymbol{y}} = \left[ \begin{matrix} \boldsymbol{y}_1 \\ \boldsymbol{y}_2 \\ \vdots \\ \boldsymbol{y}_N \end{matrix} \right] \quad \text{ e } \quad  \underset{N \times 1}{\boldsymbol{\varepsilon}} = \left[ \begin{matrix} \boldsymbol{\varepsilon}_1 \\ \boldsymbol{\varepsilon}_2 \\ \vdots \\ \boldsymbol{\varepsilon}_N \end{matrix} \right] $${{</math>}}

- Denote {{<math>}}$\boldsymbol{Z}${{</math>}} a matriz de instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas e das variáveis exógenas:
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}
- Note que:
  - {{<math>}}$\boldsymbol{z}_1${{</math>}} é o instrumento da variável exógena {{<math>}}$\boldsymbol{x}^*_1${{</math>}}
  - os (melhores) instrumentos de variáveis exógenas são elas mesmas ({{<math>}}$\boldsymbol{x}_2, ..., \boldsymbol{x}_K${{</math>}})


</br>

## Estimador VI

- [Seções 15.1 e 15.2 de Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- O **estimador de variáveis instrumentais (VI)** é dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = \left[ \begin{matrix} \hat{\beta}_0^{\scriptscriptstyle{VI}} \\ \hat{\beta}_1^{\scriptscriptstyle{VI}} \\ \hat{\beta}_2^{\scriptscriptstyle{VI}} \\ \vdots \\ \hat{\beta}_K^{\scriptscriptstyle{VI}} \end{matrix} \right] = (\boldsymbol{Z}'\boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}

- A **matriz de variâncias-covariâncias do estimador** é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}})= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{Z}' (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \equiv \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1}  $${{</math>}}
em que {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} é a matriz de projeção ortogonal em {{<math>}}$\boldsymbol{Z}${{</math>}}.

- A **variância do termo de erro** pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1}  $${{</math>}}


#### Exemplo 15.1: Retorno da Educação para Mulheres Casadas (Wooldridge, 2019)

- Vamos usar a base de dados `mroz` do pacote `wooldridge` para estimar o seguinte modelo

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ} + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

- Apenas para comparação, vamos estimar por MQO:

```r
data(mroz, package="wooldridge") # carregando base de dados
mroz = mroz[!is.na(mroz$wage),] # retirando valores ausentes de salário

reg.ols = lm(lwage ~ educ + exper + expersq, mroz) # regressão por MQO
round( summary(reg.ols)$coef, 3 )
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.522      0.199  -2.628    0.009
## educ           0.107      0.014   7.598    0.000
## exper          0.042      0.013   3.155    0.002
## expersq       -0.001      0.000  -2.063    0.040
```


### Estimação via `ivreg()`

- [CRAN - Package ivreg](https://cran.r-project.org/web/packages/ivreg/vignettes/ivreg.html)
- Para fazer regressão com variável instrumental, vamos usar a função `ivreg()` do pacote `ivreg` (também presente no pacote `AER`, do mesmo autor).
- É necessário incluir a variável instrumental de _educ_ (que neste caso é a educação do pai - _fatheduc_) e dos demais instrumentos das variáveis exógenas (elas mesmas), após informar o modelo, incluindo um `|`:


```r
library(ivreg) # carregando pacote com ivreg
reg.iv1 = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + exper + expersq, data=mroz) # regressão por VI

# Comparando com MQO
stargazer::stargazer(reg.ols, reg.iv1, type="text", digits=3)
```

```
## 
## ===================================================================
##                                        Dependent variable:         
##                                ------------------------------------
##                                               lwage                
##                                          OLS           instrumental
##                                                          variable  
##                                          (1)               (2)     
## -------------------------------------------------------------------
## educ                                  0.107***           0.070**   
##                                        (0.014)           (0.034)   
##                                                                    
## exper                                 0.042***           0.044***  
##                                        (0.013)           (0.013)   
##                                                                    
## expersq                               -0.001**           -0.001**  
##                                       (0.0004)           (0.0004)  
##                                                                    
## Constant                              -0.522***           -0.061   
##                                        (0.199)           (0.436)   
##                                                                    
## -------------------------------------------------------------------
## Observations                             428               428     
## R2                                      0.157             0.143    
## Adjusted R2                             0.151             0.137    
## Residual Std. Error (df = 424)          0.666             0.672    
## F Statistic                    26.286*** (df = 3; 424)             
## ===================================================================
## Note:                                   *p<0.1; **p<0.05; ***p<0.01
```


### Estimação analítica

a) Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz de instrumentos Z com primeira coluna de 1's
Z = as.matrix( cbind(1, mroz[,c("fatheduc","exper","expersq")]) )

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


b) Estimativas VI {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}' \boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
bhat
```

```
##                 [,1]
## 1       -0.061116933
## educ     0.070226291
## exper    0.043671588
## expersq -0.000882155
```

c) Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{VI}}${{</math>}}

```r
yhat = X %*% bhat
head(yhat)
```

```
##        [,1]
## 1 1.2200984
## 2 0.9779026
## 3 1.2381875
## 4 1.0118705
## 5 1.1845267
## 6 1.2620942
```


d) Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{VI}}${{</math>}}

```r
ehat = y - yhat
head(ehat)
```

```
##           [,1]
## 1 -0.009944725
## 2 -0.649390526
## 3  0.275950227
## 4 -0.919747190
## 5  0.339745535
## 6  0.294385830
```

e) Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{VI}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 =  \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4513836
```

f) Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}


```r
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )
Vbhat
```

```
##                     1          educ         exper       expersq
## 1        1.904852e-01 -1.467376e-02 -2.903230e-04  4.591458e-07
## educ    -1.467376e-02  1.186299e-03 -6.701635e-05  2.259110e-06
## exper   -2.903230e-04 -6.701635e-05  1.795632e-04 -5.122537e-06
## expersq  4.591458e-07  2.259110e-06 -5.122537e-06  1.607344e-07
```


g) Erros-padrão do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}})${{</math>}}

É a raiz quadrada da diagonal principal da Matriz de Variâncias-Covariâncias do Estimador

```r
se = sqrt( diag(Vbhat) )
se
```

```
##           1        educ       exper     expersq 
## 0.436446128 0.034442694 0.013400121 0.000400917
```

h) Estatística _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} 
$$ {{</math>}}


```r
t = bhat / se
t
```

```
##               [,1]
## 1       -0.1400332
## educ     2.0389314
## exper    3.2590443
## expersq -2.2003431
```

i) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), $${{</math>}}


```r
p = 2 * pt(-abs(t), N-K-1)
p
```

```
##                [,1]
## 1       0.888700281
## educ    0.042076572
## exper   0.001207928
## expersq 0.028321194
```

j) Tabela-resumo

```r
data.frame(bhat, se, t, p) # resultado VI
```

```
##                 bhat          se          t           p
## 1       -0.061116933 0.436446128 -0.1400332 0.888700281
## educ     0.070226291 0.034442694  2.0389314 0.042076572
## exper    0.043671588 0.013400121  3.2590443 0.001207928
## expersq -0.000882155 0.000400917 -2.2003431 0.028321194
```

```r
summary(reg.iv1)$coef # resultado VI via ivreg()
```

```
##                 Estimate  Std. Error    t value    Pr(>|t|)
## (Intercept) -0.061116933 0.436446128 -0.1400332 0.888700281
## educ         0.070226291 0.034442694  2.0389314 0.042076572
## exper        0.043671588 0.013400121  3.2590443 0.001207928
## expersq     -0.000882155 0.000400917 -2.2003431 0.028321194
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```


</br>

## Estimador VI sobreidentificado

>**ATENÇÃO**: Nas notas de aula do professor, usa-se {{<math>}}$\boldsymbol{Z}${{</math>}} para matrizes de diferentes dimensões, então estou usando de maneira um pouco distinta:
>- {{<math>}}$\boldsymbol{Z}${{</math>}} (maiúsculo) é SEMPRE uma matriz de instrumentos de mesma dimensão de {{<math>}}$\boldsymbol{X}${{</math>}}, {{<math>}}$N \times (K+1)${{</math>}}:
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}
>- {{<math>}}$\boldsymbol{z}^*${{</math>}} (minúsculo) é uma matriz cuja APENAS com os {{<math>}}$L (>J)${{</math>}} instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas (além da coluna de 1's):
{{<math>}}$$ \underset{N \times (L+1)}{\boldsymbol{z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & z^*_{12} & \cdots & z^*_{1L} \\ 1 & z^*_{21} & z^*_{22} & \cdots & z^*_{2L} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & z^*_{N2} & \cdots & z^*_{NL} \end{matrix} \right], $${{</math>}}
em que {{<math>}}$L${{</math>}} é o número de instrumentos.
>- {{<math>}}$\boldsymbol{Z}^*${{</math>}} (Maiúsculo) é uma matriz "sobreidentificada" com todos os {{<math>}}$L (>J)${{</math>}} instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas e todas as {{<math>}}$(K-J)${{</math>}}  variáveis exógenas (além da coluna de 1's):
>{{<math>}}$$ \underset{N \times (1+L+K-J)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & \cdots & z^*_{1L} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z^*_{21} & \cdots & z^*_{2L} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & \cdots & z^*_{NL} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right] $${{</math>}}

</br>

- Tome, como exemplo, um caso com {{<math>}}$L = 2${{</math>}} instrumentos para {{<math>}}$J = 1${{</math>}} variável endógena {{<math>}}$\boldsymbol{x}_1^*${{</math>}}



**(1)** Para fazer a estimação VI, podemos **criar um novo instrumento** que é uma combinação linear dos outros dois a partir do seguinte modelo:
{{<math>}}$$ \boldsymbol{x}_1^* = \gamma_0 + \gamma_1 z^*_1 + \gamma_2 z^*_2 + u $$ {{</math>}}

- Calculamos as estimativas:
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{z}^{*\prime} \boldsymbol{z}^{*})^{-1} \boldsymbol{z}^{*\prime} \boldsymbol{x}_1^*  $$ {{</math>}}
em que
{{<math>}}$$ \underset{N \times 3}{\boldsymbol{z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & z^*_{12} \\ 1 & z^*_{21} & z^*_{22} \\ \vdots & \vdots & \vdots \\ 1 & z^*_{N1} & z^*_{N2} \end{matrix} \right] \quad \text{ e } \quad \boldsymbol{x}_{1}^* = \begin{bmatrix} x_{11}^* \\ x_{21}^* \\ \vdots \\ x_{N1}^* \end{bmatrix} $${{</math>}}

- Aí, podemos usar o valor ajustado do modelo acima como instrumento dentro de {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$ \boldsymbol{z}_1 = \hat{\boldsymbol{x}}_1^* = \boldsymbol{x}_1^*\hat{\boldsymbol{\gamma}}$$ {{</math>}}


</br>

**(2)** Uma **outra opção** "mais direta", é criarmos a matriz de instrumentos "sobreidentificada" {{<math>}}$\boldsymbol{Z}^*${{</math>}}, cujo número de colunas é maior do que de {{<math>}}$\boldsymbol{X}${{</math>}} e, portanto, não pode ser usada diretamente para estimação
{{<math>}}$$ \underset{N \times (K+2)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & z^*_{12} & x_{12} & \cdots & x_{1K}   \\ 1 & z^*_{21} & z^*_{22} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & z^*_{N2} & x_{N2} & \cdots & x_{NK} \end{matrix} \right] $${{</math>}}

- A matriz {{<math>}}$\boldsymbol{Z}${{</math>}} pode ser obtida usando
{{<math>}}$$ \boldsymbol{Z} = \boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}}} \boldsymbol{X}$${{</math>}}
em que
{{<math>}}$$ \underset{N \times N}{\boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}} }} = \boldsymbol{Z}^* (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^*)^{-1} \boldsymbol{Z}^{*\prime} $${{</math>}}





- Agora




### Estimação via `ivreg()`

```r
library(ivreg) # carregando pacote com ivreg
reg.iv2 = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # regressão por VI

# Comparando com MQO
stargazer::stargazer(reg.ols, reg.iv1, reg.iv2, type="text", digits=3)
```

```
## 
## ========================================================================
##                                           Dependent variable:           
##                                -----------------------------------------
##                                                  lwage                  
##                                          OLS             instrumental   
##                                                            variable     
##                                          (1)             (2)      (3)   
## ------------------------------------------------------------------------
## educ                                  0.107***         0.070**   0.061* 
##                                        (0.014)         (0.034)  (0.031) 
##                                                                         
## exper                                 0.042***         0.044*** 0.044***
##                                        (0.013)         (0.013)  (0.013) 
##                                                                         
## expersq                               -0.001**         -0.001** -0.001**
##                                       (0.0004)         (0.0004) (0.0004)
##                                                                         
## Constant                              -0.522***         -0.061   0.048  
##                                        (0.199)         (0.436)  (0.400) 
##                                                                         
## ------------------------------------------------------------------------
## Observations                             428             428      428   
## R2                                      0.157           0.143    0.136  
## Adjusted R2                             0.151           0.137    0.130  
## Residual Std. Error (df = 424)          0.666           0.672    0.675  
## F Statistic                    26.286*** (df = 3; 424)                  
## ========================================================================
## Note:                                        *p<0.1; **p<0.05; ***p<0.01
```



### Estimação analítica (1)

- Aqui vamos criar "na mão" uma nova variável instrumental a partir das duas existentes

a1) Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando vetor com variável x1* endógena
x1star = as.matrix(mroz[,"educ"])

# Criando a matriz dos instrumentos APENAS das variáveis endógenas z*
zstar = as.matrix(cbind(1, mroz[,c("fatheduc","motheduc")]))

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```

a2) Estimando {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}, obtendo {{<math>}}$\boldsymbol{z}_{1} = \hat{\boldsymbol{x}}^*_1${{</math>}} e construindo {{<math>}}$ \boldsymbol{Z} $ {{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{z}^{*\prime} \boldsymbol{z}^{*})^{-1} \boldsymbol{z}^{*\prime} \boldsymbol{x}_1^*, \qquad \hat{\boldsymbol{x}}^*_1 = \boldsymbol{x}^*_1 \hat{\boldsymbol{\gamma}} $$ {{</math>}}


```r
# Estimando ghat e x1hat
ghat = solve( t(zstar) %*% zstar ) %*% t(zstar) %*% x1star
x1hat = zstar %*% ghat

# Construindo matriz de instrumentos Z
Z = as.matrix( cbind(1, x1hat, mroz[,c("exper","expersq")]) )
head(Z)
```

```
##   1    x1hat exper expersq
## 1 1 12.67324    14     196
## 2 1 11.89140     5      25
## 3 1 12.67324    15     225
## 4 1 11.89140     6      36
## 5 1 13.98993     7      49
## 6 1 12.98598    33    1089
```


b) Estimativas VI {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}' \boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
bhat
```

```
##                  [,1]
## 1        0.0480913538
## educ     0.0613973525
## exper    0.0441703521
## expersq -0.0008989682
```

c) Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{VI}}${{</math>}}

```r
yhat = X %*% bhat
head(yhat)
```

```
##        [,1]
## 1 1.2270467
## 2 0.9832371
## 3 1.2451470
## 4 1.0175188
## 5 1.1727973
## 6 1.2635048
```


d) Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{VI}}${{</math>}}

```r
ehat = y - yhat
head(ehat)
```

```
##          [,1]
## 1 -0.01689304
## 2 -0.65472504
## 3  0.26899073
## 4 -0.92539552
## 5  0.35147489
## 6  0.29297523
```

e) Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{VI}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 =  \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4552355
```

f) Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}


```r
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )
Vbhat
```

```
##                     1          educ         exper       expersq
## 1        1.602624e-01 -1.222420e-02 -4.382545e-04  5.366295e-06
## educ    -1.222420e-02  9.882651e-04 -5.582902e-05  1.881987e-06
## exper   -4.382545e-04 -5.582902e-05  1.804313e-04 -5.143857e-06
## expersq  5.366295e-06  1.881987e-06 -5.143857e-06  1.613512e-07
```


g) Erros-padrão do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}})${{</math>}}

É a raiz quadrada da diagonal principal da Matriz de Variâncias-Covariâncias do Estimador

```r
se = sqrt( diag(Vbhat) )
se
```

```
##            1         educ        exper      expersq 
## 0.4003279243 0.0314366836 0.0134324704 0.0004016855
```

h) Estatística _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} 
$$ {{</math>}}


```r
t = bhat / se
t
```

```
##               [,1]
## 1        0.1201299
## educ     1.9530480
## exper    3.2883268
## expersq -2.2379904
```

i) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), $${{</math>}}


```r
p = 2 * pt(-abs(t), N-K-1)
p
```

```
##                [,1]
## 1       0.904437148
## educ    0.051471347
## exper   0.001091845
## expersq 0.025740197
```

j) Tabela-resumo

```r
data.frame(bhat, se, t, p) # resultado VI
```

```
##                  bhat           se          t           p
## 1        0.0480913538 0.4003279243  0.1201299 0.904437148
## educ     0.0613973525 0.0314366836  1.9530480 0.051471347
## exper    0.0441703521 0.0134324704  3.2883268 0.001091845
## expersq -0.0008989682 0.0004016855 -2.2379904 0.025740197
```

```r
summary(reg.iv2)$coef # resultado VI via ivreg()
```

```
##                  Estimate   Std. Error    t value    Pr(>|t|)
## (Intercept)  0.0481003069 0.4003280776  0.1201522 0.904419479
## educ         0.0613966287 0.0314366956  1.9530242 0.051474174
## exper        0.0441703929 0.0134324755  3.2883286 0.001091838
## expersq     -0.0008989696 0.0004016856 -2.2379930 0.025740027
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```




### Estimação analítica (2)


a1') Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz "sobreidentificada" de instrumentos Z* [L endóg + (K-J) exóg]
Zstar = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```

a2') Obtendo {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z^*}}}${{</math>}} e {{<math>}}$\boldsymbol{Z} ${{</math>}}
{{<math>}}$$ \underset{N \times N}{\boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}} }} = \boldsymbol{Z}^* (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^*)^{-1} \boldsymbol{Z}^{*\prime} \quad \text{ e } \quad \boldsymbol{Z} = \boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}}} \boldsymbol{X} $${{</math>}}

```r
Pzstar = Zstar %*% solve( t(Zstar) %*% Zstar ) %*% t(Zstar) # matriz de projeção em Z*
Z = Pzstar %*% X # matriz Z
head(Z)
```

```
##   1     educ exper expersq
## 1 1 12.75602    14     196
## 2 1 11.73356     5      25
## 3 1 12.77198    15     225
## 4 1 11.76768     6      36
## 5 1 13.91461     7      49
## 6 1 13.02938    33    1089
```

- Note que, mesmo pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z^*}}}${{</math>}}, **as variáveis exógenas permaneceram com os mesmos valores**, já que as dimensões _exper_ e _expersq_ estão presentes em ambas matrizes {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{Z}^*${{</math>}} e são projetadas nas próprias dimensões.
- Embora o instrumento {{<math>}}$\boldsymbol{x}^*_1${{</math>}} em {{<math>}}$\boldsymbol{Z}${{</math>}} não esteja exatamente igual no passo (a2), estão bastante próximas.
- A partir do item (b), os passos são os mesmos dos aplicados anteriormente e, por concisão, estão foram omitidos abaixo

b -- i) ...


j) Tabela-resumo

```r
data.frame(bhat, se, t, p) # resultado VI
```

```
##                  bhat           se          t           p
## 1        0.0481003069 0.4003280776  0.1201522 0.904419479
## educ     0.0613966287 0.0314366956  1.9530242 0.051474174
## exper    0.0441703929 0.0134324755  3.2883286 0.001091838
## expersq -0.0008989696 0.0004016856 -2.2379930 0.025740027
```

```r
summary(reg.iv2)$coef # resultado VI via ivreg()
```

```
##                  Estimate   Std. Error    t value    Pr(>|t|)
## (Intercept)  0.0481003069 0.4003280776  0.1201522 0.904419479
## educ         0.0613966287 0.0314366956  1.9530242 0.051474174
## exper        0.0441703929 0.0134324755  3.2883286 0.001091838
## expersq     -0.0008989696 0.0004016856 -2.2379930 0.025740027
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```





</br>

## Estimador MQ2E

- Mínimos Quadrados em 2 Estágios (MQ2E/2SLS)



</br>

## Equações Simultâneas

- Modelos de Equações Simultâneas (MES/SEM)





</br>


{{< cta cta_text="👉 Proceed to GMM" cta_link="../sec11" >}}
