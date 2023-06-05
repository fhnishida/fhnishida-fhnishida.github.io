---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: IV / 2SLS
summary: Instrumental Variable Regression.
title: Instrumental Variable, Two-Stages Least Squares and Simulteneous Equations Model
weight: 11
output: md_document
type: book
---




- [Seções 15.1 a 15.5 de Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)
- Seção 4.8 de Cameron e Trivedi (2005)
- Capítulo 5 de Wooldridge (2010)


## Notações

- Considere, para a observação {{<math>}}$i${{</math>}}, o modelo multivariado com {{<math>}}$K${{</math>}} regressores:
{{<math>}}$$ y_i = \beta_0 + \beta_1 x^*_{i1} + ... + \beta_J x^*_{iJ} + \beta_{J+1} x_{i,J+1} + ... + \beta_K x_{iK} + \varepsilon_i, \qquad i=1, 2, ..., N \tag{1} $${{</math>}}
em que {{<math>}}$\boldsymbol{x}^*_1, ..., \boldsymbol{x}^*_{iJ}${{</math>}} são as {{<math>}}$J${{</math>}} variáveis endógenas do modelo, com {{<math>}}$N${{</math>}} observações.


- Matricialmente, podemos escrever (1) como:
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \tag{2} $${{</math>}}
em que
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{X}} = \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix}, $${{</math>}}
{{<math>}}$$ \underset{N \times 1}{\boldsymbol{y}} = \left[ \begin{matrix} \boldsymbol{y}_1 \\ \boldsymbol{y}_2 \\ \vdots \\ \boldsymbol{y}_N \end{matrix} \right] \quad \text{ e } \quad  \underset{N \times 1}{\boldsymbol{\varepsilon}} = \left[ \begin{matrix} \boldsymbol{\varepsilon}_1 \\ \boldsymbol{\varepsilon}_2 \\ \vdots \\ \boldsymbol{\varepsilon}_N \end{matrix} \right] $${{</math>}}

- Denote {{<math>}}$\boldsymbol{Z}${{</math>}} a matriz de instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas e das variáveis exógenas:
{{<math>}}$$ \underset{N \times (1+L+K-J)}{\boldsymbol{Z}} = \begin{bmatrix}
1 & z_{11} & \cdots & z_{1L} & x_{1,J+1} & \cdots & x_{1K} \\
1 & z_{21} & \cdots & z_{2L} & x_{2,J+1} & \cdots & x_{2K} \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
1 & z_{N1} & \cdots & z_{NL} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix},$${{</math>}}
- Note que:
  - {{<math>}}$\boldsymbol{z}_1${{</math>}} é o instrumento da variável exógena {{<math>}}$\boldsymbol{x}^*_1${{</math>}}
  - os (melhores) instrumentos de variáveis exógenas são elas mesmas ({{<math>}}$\boldsymbol{x}_2, ..., \boldsymbol{x}_K${{</math>}})
  - **Apenas no caso em que {{<math>}}$J = L${{</math>}} (nº de variáveis endógenas = nº de instrumentos)**, a matriz {{<math>}}$\boldsymbol{Z}${{</math>}} tem as mesmas dimensões de {{<math>}}$\boldsymbol{X:}${{</math>}}
  
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}


- E assuma {{<math>}}$\boldsymbol{Z}^*${{</math>}} a submatriz das {{<math>}}$(L+1)${{</math>}} colunas de {{<math>}}$\boldsymbol{Z}${{</math>}}, com a coluna de 1's e os {{<math>}}$L${{</math>}} instrumentos das variáveis endógenas:
{{<math>}}$$ \underset{N \times (L+1)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z_{11} & z_{12} & \cdots & z_{1L} \\ 1 & z_{21} & z_{22} & \cdots & z_{2L} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & z_{N2} & \cdots & z_{NL} \end{matrix} \right], $${{</math>}}

- As notações são um pouco diferentes das notas de aula do professor.

</br>

## Estimador VI

- O **estimador de variáveis instrumentais (VI)** é dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}'\boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}

- Observe que o estimador VI **exige queas dimensões de {{<math>}}$\boldsymbol{Z}${{</math>}} sejam as mesmas de {{<math>}}$\boldsymbol{X}${{</math>}}**, caso contrário não é possível inverter {{<math>}}$\boldsymbol{Z'X}${{</math>}} (pois não seria uma matriz quadrada).

- A **matriz de variâncias-covariâncias do estimador** é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}})= \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' \boldsymbol{\Sigma} \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} $${{</math>}}

- Assumindo homocedasticidade, {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}}, podemos simplificar a expressão:
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}}) &= \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' (\sigma^2 \boldsymbol{I}) \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{Z} (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \\
&= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1}  \end{align}{{</math>}}
em que {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} é a matriz de projeção ortogonal em {{<math>}}$\boldsymbol{Z}${{</math>}}.

- A **variância do termo de erro** pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>

#### Exemplo 15.1: Retorno da Educação para Mulheres Casadas (Wooldridge, 2019)

- Vamos usar a base de dados `mroz` do pacote `wooldridge` para estimar o seguinte modelo

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

- Apenas para comparação, vamos estimar por MQO:

```r
data(mroz, package="wooldridge") # carregando base de dados
mroz = mroz[!is.na(mroz$wage),] # retirando valores ausentes de salário

reg.ols = lm(lwage ~ educ + exper + expersq, mroz) # regressão MQO
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
reg.iv = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + exper + expersq, data=mroz) # regressão VI
# Comparativo
stargazer::stargazer(reg.ols, reg.iv, type="text", digits=4)
```

```
## 
## ====================================================================
##                                         Dependent variable:         
##                                -------------------------------------
##                                                lwage                
##                                          OLS            instrumental
##                                                           variable  
##                                          (1)                (2)     
## --------------------------------------------------------------------
## educ                                  0.1075***           0.0702**  
##                                        (0.0141)           (0.0344)  
##                                                                     
## exper                                 0.0416***          0.0437***  
##                                        (0.0132)           (0.0134)  
##                                                                     
## expersq                               -0.0008**          -0.0009**  
##                                        (0.0004)           (0.0004)  
##                                                                     
## Constant                              -0.5220***          -0.0611   
##                                        (0.1986)           (0.4364)  
##                                                                     
## --------------------------------------------------------------------
## Observations                             428                428     
## R2                                      0.1568             0.1430   
## Adjusted R2                             0.1509             0.1370   
## Residual Std. Error (df = 424)          0.6664             0.6719   
## F Statistic                    26.2862*** (df = 3; 424)             
## ====================================================================
## Note:                                    *p<0.1; **p<0.05; ***p<0.01
```


### Estimação analítica

**a)** Criando vetores/matrizes e definindo _N_ e _K_

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


**b)** Estimativas VI {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}${{</math>}}

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

**c)** Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

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


**d)** Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

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

**e)** Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2${{</math>}}
{{<math>}}$$\hat{\sigma}^2_{\scriptscriptstyle{VI}} =  \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4513836
```

**f)** Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}


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


**g)** Erros-padrão do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}})${{</math>}}

É a raiz quadrada da diagonal principal da Matriz de Variâncias-Covariâncias do Estimador

```r
se = sqrt( diag(Vbhat) )
se
```

```
##           1        educ       exper     expersq 
## 0.436446128 0.034442694 0.013400121 0.000400917
```

**h)** Estatística _t_

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

**i)** P-valor

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

**j)** Tabela-resumo

```r
round(data.frame(bhat, se, t, p), 4) # resultado VI
```

```
##            bhat     se       t      p
## 1       -0.0611 0.4364 -0.1400 0.8887
## educ     0.0702 0.0344  2.0389 0.0421
## exper    0.0437 0.0134  3.2590 0.0012
## expersq -0.0009 0.0004 -2.2003 0.0283
```

```r
summary(reg.iv)$coef # resultado VI via ivreg()
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

### VI com sobreidentificação

<!-- >**ATENÇÃO**: Nas notas de aula do professor, usa-se {{<math>}}$\boldsymbol{Z}${{</math>}} para matrizes de diferentes dimensões, então estou usando de maneira um pouco distinta: -->
<!-- >- {{<math>}}$\boldsymbol{Z}${{</math>}} (maiúsculo) é SEMPRE uma matriz de instrumentos de mesma dimensão de {{<math>}}$\boldsymbol{X}${{</math>}}, {{<math>}}$N \times (K+1)${{</math>}}: -->
<!-- {{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}} -->
<!-- >- {{<math>}}$\boldsymbol{z}^*${{</math>}} (minúsculo) é uma matriz cuja APENAS com os {{<math>}}$L (>J)${{</math>}} instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas (além da coluna de 1's): -->
<!-- {{<math>}}$$ \underset{N \times (L+1)}{\boldsymbol{z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & z^*_{12} & \cdots & z^*_{1L} \\ 1 & z^*_{21} & z^*_{22} & \cdots & z^*_{2L} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & z^*_{N2} & \cdots & z^*_{NL} \end{matrix} \right], $${{</math>}} -->
<!-- em que {{<math>}}$L${{</math>}} é o número de instrumentos. -->
<!-- >- {{<math>}}$\boldsymbol{Z}^*${{</math>}} (Maiúsculo) é uma matriz "sobreidentificada" com todos os {{<math>}}$L (>J)${{</math>}} instrumentos das {{<math>}}$J${{</math>}} variáveis endógenas e todas as {{<math>}}$(K-J)${{</math>}}  variáveis exógenas (além da coluna de 1's): -->
<!-- >{{<math>}}$$ \underset{N \times (1+L+K-J)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & \cdots & z^*_{1L} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z^*_{21} & \cdots & z^*_{2L} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & \cdots & z^*_{NL} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right] $${{</math>}} -->


- Como exemplo, considere um caso com {{<math>}}$L = 2${{</math>}} instrumentos para {{<math>}}$J = 1${{</math>}} variável endógena {{<math>}}$\boldsymbol{x}_1^*${{</math>}}
- Note que {{<math>}}$L > J,${{</math>}} então temos um modelo sobreidentificado.

- Para fazer a estimação VI, podemos **criar um novo instrumento**, {{<math>}}$\boldsymbol{z}_1^*${{</math>}}, que é uma combinação linear dos outros dois a partir do seguinte modelo:
{{<math>}}\begin{align} \boldsymbol{x}_1^* &= \gamma_0 + \gamma_1 \boldsymbol{z}_1 + \gamma_2 \boldsymbol{z}_2 + \boldsymbol{u} \\
&= \boldsymbol{Z}^*\boldsymbol{\gamma} + \boldsymbol{u} \end{align}{{</math>}}
em que
{{<math>}}$$ \boldsymbol{\gamma} = \begin{bmatrix} \gamma_0 \\ \gamma_1 \\ \gamma_2 \end{bmatrix}, \quad \boldsymbol{x}_{1}^* = \begin{bmatrix} x_{11}^* \\ x_{21}^* \\ \vdots \\ x_{N1}^* \end{bmatrix} \quad \text{ e } \quad \boldsymbol{Z}^* = \begin{bmatrix} 1 & z_{11} & z_{12} \\ 1 & z_{21} & z_{22} \\ \vdots & \vdots & \vdots \\ 1 & z_{N1} & z_{N2} \end{bmatrix} $${{</math>}}

- Precisamos estimar:
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^{*})^{-1} \boldsymbol{Z}^{*\prime} \boldsymbol{x}_1^*  $$ {{</math>}}

- E podemos usar o valor ajustado deste modelo, {{<math>}}$\hat{\boldsymbol{x}}_1^*${{</math>}}, como instrumento de {{<math>}}$\boldsymbol{x}_1^*${{</math>}} dentro de {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$ \boldsymbol{z}^*_1 \equiv \hat{\boldsymbol{x}}_1^* = \boldsymbol{Z}^*\hat{\boldsymbol{\gamma}}$$ {{</math>}}

- Então, a matriz de instrumentos, de mesmas dimensões de {{<math>}}$\boldsymbol{X}${{</math>}} fica:

{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & \hat{x}^*_{11} & x_{12} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & x_{N2} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}




#### Estimação analítica

- Aqui vamos criar "na mão" uma nova variável instrumental a partir das duas existentes
- A partir do exemplo 15.1 do Wooldridge, vamos adicionar outra variável instrumental (_motheduc_), além _fatheduc_, para a variável endógena _educ_.
- Lembre-se que queremos estimar o seguinte modelo:
{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

**a1)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando vetor com variável x1* endógena
x1star = as.matrix(mroz[,"educ"])

# Criando a matriz dos instrumentos APENAS da variável endógena x1*
Zstar = as.matrix(cbind(1, mroz[,c("fatheduc","motheduc")]))

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```

**a2)** Estimando {{<math>}}$\hat{\boldsymbol{\gamma}}${{</math>}}, obtendo {{<math>}}$\boldsymbol{z}_{1} = \hat{\boldsymbol{x}}^*_1${{</math>}} e construindo {{<math>}}$ \boldsymbol{Z} $ {{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^{*})^{-1} \boldsymbol{Z}^{*\prime} \boldsymbol{x}_1^* \quad \text{ e } \quad \hat{\boldsymbol{x}}^*_1 = \boldsymbol{Z}^* \hat{\boldsymbol{\gamma}} $$ {{</math>}}


```r
# Estimando ghat e x1hat
ghat = solve( t(Zstar) %*% Zstar ) %*% t(Zstar) %*% x1star
x1hat = Zstar %*% ghat

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

**b -- j)** Passos são os mesmos dos aplicados anteriormente:

```r
# Estimação, valores preditos e resíduos
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
yhat = X %*% bhat
ehat = y - yhat

# Matriz de variâncias-covariâncias
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )

# Erro padrão, estatística t e p-valor
se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Tabela-resumo
reg.iv2 = data.frame(bhat, se, t, p) # resultado VI sobreidentificado
round(reg.iv2, 4)
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1201 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```


</br>

## Estimador MQ2E

- Como o estimador VI exige que o número de instrumentos seja igual ao número de regressores, não é utilizado para modelos sobreidentificados (a não ser que faça o ajuste mostrado acima).
- Quando {{<math>}}$L>J${{</math>}}, é comum o uso do Mínimos Quadrados em 2 Estágios (MQ2E/2SLS).

</br> 

- O **estimador de mínimos quadrados em 2 estágios (MQ2E)** é dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}
em que {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} é a matriz de projeção ortogonal em {{<math>}}$\boldsymbol{Z}${{</math>}}.


- A **matriz de variâncias-covariâncias do estimador** é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}})= \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' \boldsymbol{S} \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} $${{</math>}}
em que {{<math>}}$\boldsymbol{S} = N^{-1} \sum_i {\hat{\varepsilon}^2_i \boldsymbol{z}_i \boldsymbol{z}'_i}${{</math>}}
- Sob homocedasticidade, podemos simplificar a expressão para:
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}})= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1} $${{</math>}}

- A **variância do termo de erro** pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>


- Note que, definindo {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} e {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}}, o estimador de MQ2E pode ser reescrito como
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} &= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= ([\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} [\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&\equiv (\hat{\boldsymbol{X}}' \hat{\boldsymbol{X}})^{-1} \hat{\boldsymbol{X}}' \hat{\boldsymbol{y}}
\end{align}{{</math>}}
pois {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} é idempotente {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}.\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}})${{</math>}} e simétrico {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}}')${{</math>}}

</br>

- Com a transformação das variáveis, podemos resolver o estimador por MQO e, por isso, o nome do estimador faz alusão a 2 MQO's.
- O 1º MQO ocorre quando pré-multiplicamos por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, pois esta matriz projeta {{<math>}}$\boldsymbol{X}${{</math>}} no espaço de {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}\begin{align} \hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} &= \boldsymbol{P_{\scriptscriptstyle{Z}}} \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \\
&= \ \quad \begin{bmatrix} 1 & \hat{x}^*_{11} & \cdots & \hat{x}^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & \cdots & \hat{x}^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & \cdots & \hat{x}^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \end{align}{{</math>}}
em que cada variável de {{<math>}}$\boldsymbol{X}${{</math>}} foi regredida por todos instrumentos em {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$\hat{\boldsymbol{x}}^*_{k} = \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}^*_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K}  ,$${{</math>}}
para {{<math>}}$k = 1, ..., J ${{</math>}}, e
{{<math>}}\begin{align} \hat{\boldsymbol{x}}_{k} &= \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K} \\
&= 0 + \cdots + 0 + \hat{\gamma}_{kk} \boldsymbol{x}_k + 0 + \cdots + 0 \\
&= 0 + \cdots + 0 + 1 \boldsymbol{x}_k + 0 + \cdots + 0\ \ =\ \ \boldsymbol{x}_{k},
\end{align}{{</math>}}
para {{<math>}}$k = J+1, ..., K${{</math>}}.
- Naturalmente, as variáveis exógenas não são modificadas por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, pois estão presentes em ambos espaços de {{<math>}}$\boldsymbol{X}${{</math>}} e de {{<math>}}$\boldsymbol{Z}${{</math>}}.


<!-- **(2)** Uma **outra opção** "mais direta", é criarmos a matriz de instrumentos "sobreidentificada" {{<math>}}$\boldsymbol{Z}${{</math>}}, cujo número de colunas é maior do que de {{<math>}}$\boldsymbol{X}${{</math>}} e, portanto, não pode ser usada diretamente para estimação -->
<!-- {{<math>}}$$ \underset{N \times (K+2)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z^*_{11} & z^*_{12} & x_{12} & \cdots & x_{1K}   \\ 1 & z^*_{21} & z^*_{22} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z^*_{N1} & z^*_{N2} & x_{N2} & \cdots & x_{NK} \end{matrix} \right] $${{</math>}} -->
<!-- - A matriz {{<math>}}$\boldsymbol{Z}${{</math>}} pode ser obtida usando -->
<!-- {{<math>}}$$ \boldsymbol{Z} = \boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}}} \boldsymbol{X}$${{</math>}} -->
<!-- em que -->
<!-- {{<math>}}$$ \underset{N \times N}{\boldsymbol{P_{\scriptscriptstyle{\boldsymbol{Z}^*}} }} = \boldsymbol{Z}^* (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^*)^{-1} \boldsymbol{Z}^{*\prime} $${{</math>}} -->


#### Estimação via `ivreg()`
- Só é necessário incluir o novo instrumento após o `|` na fórmula do `ivreg()`

```r
library(ivreg) # carregando pacote com ivreg
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # regressão 2SLS
# Comparativo
round(summary(reg.2sls)$coef, 4) # 2SLS por ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```

```r
round(reg.iv2, 4) # resultado IV sobreidentificado
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1201 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```


#### Estimação via `lm()`
- 1º MQO: `educ ~ fatheduc + motheduc + exper + expersq`
- Obter os valores ajustados `educ_hat`
- 2º MQO: `lwage ~ educ_hat + exper + expersq`

```r
# 1o passo: educ em função dos instrumentos
reg.1step = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
educ_hat = fitted(reg.1step)

# 2o passo: lwage em função de educ_hat e demais variáveis exógenas
reg.2step = lm(lwage ~ educ_hat + exper + expersq, data=mroz)

# Comparativo
stargazer::stargazer(reg.2sls, reg.2step, type="text", digits=4)
```

```
## 
## ===================================================================
##                                        Dependent variable:         
##                                ------------------------------------
##                                               lwage                
##                                instrumental           OLS          
##                                  variable                          
##                                    (1)                (2)          
## -------------------------------------------------------------------
## educ                             0.0614*                           
##                                  (0.0314)                          
##                                                                    
## educ_hat                                            0.0614*        
##                                                    (0.0330)        
##                                                                    
## exper                           0.0442***          0.0442***       
##                                  (0.0134)          (0.0141)        
##                                                                    
## expersq                         -0.0009**          -0.0009**       
##                                  (0.0004)          (0.0004)        
##                                                                    
## Constant                          0.0481            0.0481         
##                                  (0.4003)          (0.4198)        
##                                                                    
## -------------------------------------------------------------------
## Observations                       428                428          
## R2                                0.1357            0.0498         
## Adjusted R2                       0.1296            0.0431         
## Residual Std. Error (df = 424)    0.6747            0.7075         
## F Statistic                                 7.4046*** (df = 3; 424)
## ===================================================================
## Note:                                   *p<0.1; **p<0.05; ***p<0.01
```


### Estimação analítica 1

**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz "sobreidentificada" de instrumentos Z e de projeção Pz
Z = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


**b)** Estimativas MQ2E {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(X) %*% Pz %*% X ) %*% t(X) %*% Pz %*% y
bhat
```

```
##                  [,1]
## 1        0.0481003069
## educ     0.0613966287
## exper    0.0441703929
## expersq -0.0008989696
```


**c)** Valores ajustados {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

```r
yhat = X %*% bhat
head(yhat)
```

```
##        [,1]
## 1 1.2270473
## 2 0.9832376
## 3 1.2451476
## 4 1.0175193
## 5 1.1727963
## 6 1.2635049
```


**d)** Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

```r
ehat = y - yhat
head(ehat)
```

```
##          [,1]
## 1 -0.01689361
## 2 -0.65472547
## 3  0.26899016
## 4 -0.92539598
## 5  0.35147585
## 6  0.29297511
```

**e)** Estimativa da variância do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{MQ2E}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4552359
```

**f)** Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}}) = \hat{\sigma}^2 (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} $${{</math>}}

```r
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )
Vbhat
```

```
##                     1          educ         exper       expersq
## 1        1.602626e-01 -1.222421e-02 -4.382549e-04  5.366299e-06
## educ    -1.222421e-02  9.882658e-04 -5.582906e-05  1.881989e-06
## exper   -4.382549e-04 -5.582906e-05  1.804314e-04 -5.143861e-06
## expersq  5.366299e-06  1.881989e-06 -5.143861e-06  1.613513e-07
```


**g)** Erros-padrão, estatísticas t, p-valores e tabela-resumo

```r
se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Tabela-resumo
round(data.frame(bhat, se, t, p), 4) # resultado 2SLS analítico
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1202 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```

```r
round(summary(reg.2sls)$coef, 4) # resultado 2SLS via ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```


### Estimação analítica 2

- Também podemos fazer a estimação MQ2E por meio de MQO nas variáveis transformadas


**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz "sobreidentificada" de instrumentos Z e de projeção Pz
Z = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


**b1)** Obtendo {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} e {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}}


```r
yhatZ = Pz %*% y
XhatZ = Pz %*% X
head(cbind(X, XhatZ))
```

```
##   1 educ exper expersq 1     educ exper expersq
## 1 1   12    14     196 1 12.75602    14     196
## 2 1   12     5      25 1 11.73356     5      25
## 3 1   12    15     225 1 12.77198    15     225
## 4 1   12     6      36 1 11.76768     6      36
## 5 1   14     7      49 1 13.91461     7      49
## 6 1   12    33    1089 1 13.02938    33    1089
```

- Note que, mesmo pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z^*}}}${{</math>}}, **as variáveis exógenas permaneceram com os mesmos valores**, já que _exper_ e _expersq_ estão presentes em ambas matrizes {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{Z}${{</math>}}.
- Embora o instrumento {{<math>}}$\boldsymbol{x}^*_1${{</math>}} em 


**b2)** Estimativas MQ2E {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}


```r
bhat = solve( t(XhatZ) %*% XhatZ ) %*% t(XhatZ) %*% yhatZ
bhat
```

```
##                  [,1]
## 1        0.0481003069
## educ     0.0613966287
## exper    0.0441703929
## expersq -0.0008989696
```


**c -- g)** Passos são os mesmos dos aplicados anteriormente:

```r
yhat = X %*% bhat
ehat = y - yhat
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Vbhat = sig2hat * solve( t(XhatZ) %*% XhatZ )

se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Tabela-resumo
round(data.frame(bhat, se, t, p), 4) # resultado 2SLS analítico
```

```
##            bhat     se       t      p
## 1        0.0481 0.4003  0.1202 0.9044
## educ     0.0614 0.0314  1.9530 0.0515
## exper    0.0442 0.0134  3.2883 0.0011
## expersq -0.0009 0.0004 -2.2380 0.0257
```

```r
round(summary(reg.2sls)$coef, 4) # resultado 2SLS via ivreg()
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.0481     0.4003  0.1202   0.9044
## educ          0.0614     0.0314  1.9530   0.0515
## exper         0.0442     0.0134  3.2883   0.0011
## expersq      -0.0009     0.0004 -2.2380   0.0257
## attr(,"df")
## [1] 424
## attr(,"nobs")
## [1] 428
```

### Testes

Diagnóstico via `ivreg`:

```r
summary(reg.2sls)
```

```
## 
## Call:
## ivreg(formula = lwage ~ educ + exper + expersq | fatheduc + motheduc + 
##     exper + expersq, data = mroz)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.0986 -0.3196  0.0551  0.3689  2.3493 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)   
## (Intercept)  0.0481003  0.4003281   0.120  0.90442   
## educ         0.0613966  0.0314367   1.953  0.05147 . 
## exper        0.0441704  0.0134325   3.288  0.00109 **
## expersq     -0.0008990  0.0004017  -2.238  0.02574 * 
## 
## Diagnostic tests:
##                  df1 df2 statistic p-value    
## Weak instruments   2 423    55.400  <2e-16 ***
## Wu-Hausman         1 423     2.793  0.0954 .  
## Sargan             1  NA     0.378  0.5386    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6747 on 424 degrees of freedom
## Multiple R-Squared: 0.1357,	Adjusted R-squared: 0.1296 
## Wald test: 8.141 on 3 and 424 DF,  p-value: 2.787e-05
```



#### Teste de Instrumentos Fracos


#### Teste de Endogeneidade (Wu-Hausman)



#### Teste de Sobreidentificação (Sargan)





</br>

## Equações Simultâneas

- Modelos de Equações Simultâneas (MES/SEM)





</br>


{{< cta cta_text="👉 Proceed to GMM" cta_link="../sec11" >}}
