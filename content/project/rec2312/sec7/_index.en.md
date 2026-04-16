---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "IV / 2SLS"
summary: "Detailed IV and 2SLS notes with notation, identification conditions, matrix formulas, and applied R examples."
title: "Instrumental Variables and Two-Stage Least Squares (2SLS)"
weight: 7
output: md_document
type: book
---



- [Se��es 15.1 a 15.5 de Heiss (2020)](http://www.urfie.net/downloads/PDF/URfIE_web.pdf)


## Nota��es

- Considere o modelo multivariado com {{<math>}}$K${{</math>}} regressores:
{{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + ... + \beta_J \boldsymbol{x}^*_{J} + \beta_{J+1} \boldsymbol{x}_{J+1} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} $${{</math>}}
em que {{<math>}}$\boldsymbol{x}^*_1, ..., \boldsymbol{x}^*_{iJ}${{</math>}} s�o as {{<math>}}$J${{</math>}} regressores end�genos do modelo, com {{<math>}}$N${{</math>}} observa��es.


- Matricialmente, podemos escrever (1) como:
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \tag{2} $${{</math>}}
em que
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{X}} = \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix}, $${{</math>}}
{{<math>}}$$ \underset{N \times 1}{\boldsymbol{y}} = \left[ \begin{matrix} \boldsymbol{y}_1 \\ \boldsymbol{y}_2 \\ \vdots \\ \boldsymbol{y}_N \end{matrix} \right] \quad \text{ e } \quad  \underset{N \times 1}{\boldsymbol{\varepsilon}} = \left[ \begin{matrix} \boldsymbol{\varepsilon}_1 \\ \boldsymbol{\varepsilon}_2 \\ \vdots \\ \boldsymbol{\varepsilon}_N \end{matrix} \right] $${{</math>}}

- Denote {{<math>}}$\boldsymbol{Z}${{</math>}} a matriz de instrumentos com {{<math>}}$L${{</math>}} vari�veis instrumentais, {{<math>}}$\boldsymbol{z}_k${{</math>}}, e {{<math>}}$K-J${{</math>}} vari�veis ex�genas, {{<math>}}$\boldsymbol{x}_k${{</math>}}:
{{<math>}}$$ \underset{N \times (1+L+K-J)}{\boldsymbol{Z}} = \begin{bmatrix}
1 & z_{11} & \cdots & z_{1L} & x_{1,J+1} & \cdots & x_{1K} \\
1 & z_{21} & \cdots & z_{2L} & x_{2,J+1} & \cdots & x_{2K} \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\
1 & z_{N1} & \cdots & z_{NL} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix},$${{</math>}}
em que {{<math>}}$J \ge L${{</math>}} e, logo, {{<math>}}$\boldsymbol{Z}${{</math>}} tem pelo menos o mesmo n�mero de colunas da matriz {{<math>}}$\boldsymbol{X}${{</math>}}

- Note que:
  - {{<math>}}$\boldsymbol{z}_1${{</math>}} � o instrumento da vari�vel ex�gena {{<math>}}$\boldsymbol{x}^*_1${{</math>}}
  - os (melhores) instrumentos de vari�veis ex�genas s�o elas mesmas ({{<math>}}$\boldsymbol{x}_2, ..., \boldsymbol{x}_K${{</math>}})
  - **Apenas no caso em que {{<math>}}$J = L${{</math>}} (n� de regressores end�genos = n� de instrumentos)**, a matriz {{<math>}}$\boldsymbol{Z}${{</math>}} tem as mesmas dimens�es de {{<math>}}$\boldsymbol{X:}${{</math>}}
  
{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & z_{11} & \cdots & z_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & z_{21} & \cdots & z_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & \cdots & z_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}


- E assuma {{<math>}}$\boldsymbol{Z}^*${{</math>}} a submatriz das {{<math>}}$(L+1)${{</math>}} colunas de {{<math>}}$\boldsymbol{Z}${{</math>}}, com a coluna de 1's e os {{<math>}}$L${{</math>}} instrumentos dos regressores end�genos:
{{<math>}}$$ \underset{N \times (L+1)}{\boldsymbol{Z}^*} = \left[ \begin{matrix} 1 & z_{11} & z_{12} & \cdots & z_{1L} \\ 1 & z_{21} & z_{22} & \cdots & z_{2L} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & z_{N1} & z_{N2} & \cdots & z_{NL} \end{matrix} \right], $${{</math>}}

- As nota��es s�o um pouco diferentes das notas de aula do professor.

</br>

## Estimador VI

- O **estimador de vari�veis instrumentais (VI)** � dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}} = (\boldsymbol{Z}'\boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} $${{</math>}}

- Observe que o **estimador VI exige que as dimens�es de {{<math>}}$\boldsymbol{Z}${{</math>}} sejam as mesmas de {{<math>}}$\boldsymbol{X}${{</math>}}**, caso contr�rio n�o � poss�vel inverter {{<math>}}$\boldsymbol{Z'X}${{</math>}} (pois n�o seria uma matriz quadrada).

- A **matriz de vari�ncias-covari�ncias do estimador** � dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}})= \left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1} \boldsymbol{Z}' \boldsymbol{\Sigma} \boldsymbol{Z} \left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1} $${{</math>}}

- Assumindo homocedasticidade, {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}}, podemos simplificar a express�o:
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{VI}}) &= \left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1} \boldsymbol{Z}' (\sigma^2 \boldsymbol{I}) \boldsymbol{Z} \left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1} \\
&= \sigma^2 {\color{red}\left( \boldsymbol{Z}' \boldsymbol{X}\right)^{-1}} {\color{green}\boldsymbol{Z}' \boldsymbol{Z}} {\color{blue}\left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1}} \\
&\overset{*}{=} \sigma^2 \left( {\color{blue}\boldsymbol{X}' \boldsymbol{Z}} {\color{green}(\boldsymbol{Z}' \boldsymbol{Z})^{-1}} {\color{red}\boldsymbol{Z}' \boldsymbol{X}} \right)^{-1} \\
&= \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1}  \end{align}{{</math>}}
em que {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} � a matriz de proje��o ortogonal em {{<math>}}$\boldsymbol{Z}${{</math>}}. (*) Como cada dupla de matrizes tem dimens�o K x K, ent�o podemos inverter toda express�o "da direita para esquerda", iniciando pela inversa de  {{<math>}}$\left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1}${{</math>}}, inversa de {{<math>}}$\boldsymbol{Z}' \boldsymbol{Z}${{</math>}}, e inversa de {{<math>}}$\left(\boldsymbol{X}' \boldsymbol{Z} \right)^{-1}${{</math>}}

- A **vari�ncia do termo de erro** pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>

#### Exemplo 15.1: Retorno da Educa��o para Mulheres (Wooldridge, 2019)

- Vamos usar a base de dados `mroz` do pacote `wooldridge` para estimar o seguinte modelo

{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

- Apenas para compara��o, vamos estimar por MQO:

```r
data(mroz, package="wooldridge") # carregando base de dados
mroz = mroz[!is.na(mroz$wage),] # retirando valores ausentes de sal�rio

reg.ols = lm(lwage ~ educ + exper + expersq, mroz) # regress�o MQO
round( summary(reg.ols)$coef, 3 )
```

```
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.522      0.199  -2.628    0.009
## educ           0.107      0.014   7.598    0.000
## exper          0.042      0.013   3.155    0.002
## expersq       -0.001      0.000  -2.063    0.040
```


### Estima��o via `ivreg()`

- [CRAN - Package ivreg](https://cran.r-project.org/web/packages/ivreg/vignettes/ivreg.html)
- Para fazer regress�o com vari�vel instrumental, vamos usar a fun��o `ivreg()` do pacote `ivreg` (tamb�m presente no pacote `AER`, do mesmo autor).
- ?? necess�rio incluir a vari�vel instrumental de _educ_ (que neste caso � a educa��o do pai - _fatheduc_) e dos demais instrumentos das vari�veis ex�genas (elas mesmas), ap�s informar o modelo, incluindo um `|`:


```r
library(ivreg) # carregando pacote com ivreg
reg.iv = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + exper + expersq, data=mroz) # regress�o VI
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


### Estima��o anal�tica

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


**d)** Res�duos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

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

**e)** Estimativa da vari�ncia do erro {{<math>}}$\hat{\sigma}^2${{</math>}}
{{<math>}}$$\hat{\sigma}^2_{\scriptscriptstyle{VI}} =  \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4513836
```

**f)** Matriz de Vari�ncias-Covari�ncias do Estimador

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


**g)** Erros-padr�o do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{VI}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se = sqrt( diag(Vbhat) )
se
```

```
##           1        educ       exper     expersq 
## 0.436446128 0.034442694 0.013400121 0.000400917
```

**h)** Estat�stica _t_

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

### Ajuste para sobreidentifica��o

- Como exemplo, considere um caso com {{<math>}}$L = 2${{</math>}} instrumentos para {{<math>}}$J = 1${{</math>}} regressor end�geno {{<math>}}$\boldsymbol{x}_1^*${{</math>}}
- Note que {{<math>}}$L > J,${{</math>}} ent�o temos um modelo sobreidentificado.

- Para fazer a estima��o VI, podemos **criar um novo instrumento**, {{<math>}}$\boldsymbol{z}_1^*${{</math>}}, que � uma combina��o linear dos outros dois a partir do seguinte modelo:
{{<math>}}\begin{align} \boldsymbol{x}_1^* &= \gamma_0 + \gamma_1 \boldsymbol{z}_1 + \gamma_2 \boldsymbol{z}_2 + \boldsymbol{u} \\
&= \boldsymbol{Z}^*\boldsymbol{\gamma} + \boldsymbol{u} \end{align}{{</math>}}
em que
{{<math>}}$$ \boldsymbol{\gamma} = \begin{bmatrix} \gamma_0 \\ \gamma_1 \\ \gamma_2 \end{bmatrix}, \quad \boldsymbol{x}_{1}^* = \begin{bmatrix} x_{11}^* \\ x_{21}^* \\ \vdots \\ x_{N1}^* \end{bmatrix} \quad \text{ e } \quad \boldsymbol{Z}^* = \begin{bmatrix} 1 & z_{11} & z_{12} \\ 1 & z_{21} & z_{22} \\ \vdots & \vdots & \vdots \\ 1 & z_{N1} & z_{N2} \end{bmatrix} $${{</math>}}

- Precisamos estimar:
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\boldsymbol{Z}^{*\prime} \boldsymbol{Z}^{*})^{-1} \boldsymbol{Z}^{*\prime} \boldsymbol{x}_1^*  $$ {{</math>}}

- E podemos usar o valor ajustado deste modelo, {{<math>}}$\hat{\boldsymbol{x}}_1^*${{</math>}}, como instrumento de {{<math>}}$\boldsymbol{x}_1^*${{</math>}} dentro de {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$ \boldsymbol{z}^*_1 \equiv \hat{\boldsymbol{x}}_1^* = \boldsymbol{Z}^*\hat{\boldsymbol{\gamma}}$$ {{</math>}}

- Ent�o, a matriz de instrumentos, de mesmas dimens�es de {{<math>}}$\boldsymbol{X}${{</math>}} fica:

{{<math>}}$$ \underset{N \times (K+1)}{\boldsymbol{Z}} = \left[ \begin{matrix} 1 & \hat{x}^*_{11} & x_{12} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & x_{22} & \cdots & x_{2K} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & x_{N2} & \cdots & x_{NK} \end{matrix} \right], $${{</math>}}




#### Estima��o anal�tica

- Aqui vamos criar "na m�o" uma nova vari�vel instrumental a partir das duas existentes
- A partir do exemplo 15.1 do Wooldridge, vamos adicionar outra vari�vel instrumental (_motheduc_), al�m _fatheduc_, para o regressor end�geno _educ_.
- Lembre-se que queremos estimar o seguinte modelo:
{{<math>}}$$ \log(\text{wage}) = \beta_0 + \beta_1 \text{educ}^* + \beta_2 \text{exper} + \beta_3 \text{exper}^2 + \varepsilon $${{</math>}}

**a1)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando vetor com vari�vel x1* end�gena
x1star = as.matrix(mroz[,"educ"])

# Criando a matriz dos instrumentos APENAS do regressor end�geno x1*
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

**b -- j)** Passos s�o os mesmos dos aplicados anteriormente:

```r
# Estima��o, valores preditos e res�duos
bhat = solve( t(Z) %*% X ) %*% t(Z) %*% y
yhat = X %*% bhat
ehat = y - yhat

# Matriz de vari�ncias-covari�ncias
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)
Vbhat = sig2hat * solve( t(X) %*% Pz %*% X )

# Erro padr�o, estat�stica t e p-valor
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

- Como o estimador VI exige que o n�mero de instrumentos seja igual ao n�mero de regressores, n�o � utilizado para modelos sobreidentificados (a n�o ser que fa�a o ajuste mostrado acima).
- Quando {{<math>}}$L>J${{</math>}}, � comum o uso do M�nimos Quadrados em 2 Est�gios (MQ2E/2SLS), tamb�m conhecido como estimador VI generalizado (GIVE).

- O **estimador de m�nimos quadrados em 2 est�gios (MQ2E)** � dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} = (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} $${{</math>}}
em que {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} � a matriz de proje��o ortogonal em {{<math>}}$\boldsymbol{Z}${{</math>}}.
- Observe tamb�m que o estimador MQ2E � o caso geral do VI, quando o modelo � exatamente identificado {{<math>}}($\boldsymbol{Z}${{</math>}} e {{<math>}}$\boldsymbol{X}${{</math>}} t�m mesma dimens�o):
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} &= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= ({\color{blue}\boldsymbol{X}' \boldsymbol{Z}} {\color{green}(\boldsymbol{Z}' \boldsymbol{Z})^{-1}} {\color{red}\boldsymbol{Z}' \boldsymbol{X}})^{-1} \boldsymbol{X}' \boldsymbol{Z} (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{y} \\
&= {\color{red}(\boldsymbol{Z}' \boldsymbol{X})^{-1}} {\color{green}\boldsymbol{Z}' \boldsymbol{Z}} \underbrace{{\color{blue}(\boldsymbol{X}' \boldsymbol{Z})^{-1}} \boldsymbol{X}' \boldsymbol{Z}}_{\boldsymbol{I}} (\boldsymbol{Z}' \boldsymbol{Z})^{-1} \boldsymbol{Z}' \boldsymbol{y} \\
&= (\boldsymbol{Z}' \boldsymbol{X})^{-1}  \underbrace{\boldsymbol{Z}' \boldsymbol{Z} (\boldsymbol{Z}' \boldsymbol{Z})^{-1}}_{\boldsymbol{I}}  \boldsymbol{Z}' \boldsymbol{y} \\
&= (\boldsymbol{Z}' \boldsymbol{X})^{-1} \boldsymbol{Z}' \boldsymbol{y} = \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{IV}} \end{align}{{</math>}}

- A **matriz de vari�ncias-covari�ncias do estimador** � dada por
{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}) &= \left( \boldsymbol{X}' \boldsymbol{Z}\right)^{-1} \boldsymbol{Z}' \boldsymbol{S} \boldsymbol{Z} \left(\boldsymbol{Z}' \boldsymbol{X} \right)^{-1} \\
&\overset{*}{=} \sigma^2 \left( \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} \right)^{-1} \end{align}{{</math>}}
em que {{<math>}}$\boldsymbol{S} = N^{-1} \sum_i {\hat{\varepsilon}^2_i \boldsymbol{z}_i \boldsymbol{z}'_i}${{</math>}}. (*) Sob homocedasticidade.

- A **vari�ncia do termo de erro** pode ser estimada usando:
{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}'\hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}


</br>

- Note que, definindo {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} e {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y}${{</math>}} (n�o � {{<math>}}$\hat{\boldsymbol{y}}${{</math>}} para n�o confundir com valor predito), o estimador de MQ2E pode ser reescrito como
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} &= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&= ([\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} [\boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}]' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y} \\
&\equiv (\hat{\boldsymbol{X}}' \hat{\boldsymbol{X}})^{-1} \hat{\boldsymbol{X}}' \tilde{\boldsymbol{y}}
\end{align}{{</math>}}
pois {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}} � idempotente {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}.\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}})${{</math>}} e sim�trico {{<math>}}$(\boldsymbol{P_{\scriptscriptstyle{Z}}}=\boldsymbol{P_{\scriptscriptstyle{Z}}}')${{</math>}}

- Com a transforma��o das vari�veis, podemos resolver o estimador por MQO e, por isso, o nome do estimador faz alus�o a dois MQO's.
- O 1� MQO ocorre quando pr�-multiplicamos por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, pois esta matriz projeta {{<math>}}$\boldsymbol{X}${{</math>}} no espa�o de {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}\begin{align} \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X} &= \boldsymbol{P_{\scriptscriptstyle{Z}}} \begin{bmatrix} 1 & x^*_{11} & \cdots & x^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & x^*_{21} & \cdots & x^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & x^*_{N1} & \cdots & x^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \\
&= \ \quad \begin{bmatrix} 1 & \hat{x}^*_{11} & \cdots & \hat{x}^*_{1J} & x_{1,J+1} & \cdots & x_{1K}   \\ 1 & \hat{x}^*_{21} & \cdots & \hat{x}^*_{2J} & x_{2,J+1} & \cdots & x_{2K} \\ \vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots \\ 1 & \hat{x}^*_{N1} & \cdots & \hat{x}^*_{NJ} & x_{N,J+1} & \cdots & x_{NK} \end{bmatrix} \equiv \hat{\boldsymbol{X}} \end{align}{{</math>}}
em que cada vari�vel de {{<math>}}$\boldsymbol{X}${{</math>}} foi regredida por todos instrumentos (e vari�veis ex�genas) em {{<math>}}$\boldsymbol{Z}${{</math>}}:
{{<math>}}$$\hat{\boldsymbol{x}}^*_{k} = \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}^*_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K}  ,$${{</math>}}
para {{<math>}}$k = 1, ..., J ${{</math>}}, e
{{<math>}}\begin{align} \hat{\boldsymbol{x}}_{k} &= \hat{\gamma}_{k0} + \hat{\gamma}_{k1} \boldsymbol{z}^*_1 + \cdots + \hat{\gamma}_{kL} \boldsymbol{z}_L + \hat{\gamma}_{k,J+1} \boldsymbol{x}_{J+1} + \cdots + \hat{\gamma}_{kK} \boldsymbol{x}_{K} \\
&= 0 + \cdots + 0 + \hat{\gamma}_{kk} \boldsymbol{x}_k + 0 + \cdots + 0 \\
&= 0 + \cdots + 0 + 1 \boldsymbol{x}_k + 0 + \cdots + 0\ \ =\ \ \boldsymbol{x}_{k},
\end{align}{{</math>}}
para {{<math>}}$k = J+1, ..., K${{</math>}}.
- Naturalmente, as vari�veis ex�genas n�o s�o modificadas por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z}}}${{</math>}}, pois est�o presentes em ambos espa�os de {{<math>}}$\boldsymbol{X}${{</math>}} e de {{<math>}}$\boldsymbol{Z}${{</math>}}.



### Estima��o via `ivreg()`
- S� � necess�rio incluir o novo instrumento ap�s o `|` na f�rmula do `ivreg()`

```r
library(ivreg) # carregando pacote com ivreg
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # regress�o 2SLS
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


### Estima��o via `lm()`
- 1� MQO: `educ ~ fatheduc + motheduc + exper + expersq`
- Obter os valores ajustados `educ_hat`
- 2� MQO: `lwage ~ educ_hat + exper + expersq`

```r
# 1o passo: educ em fun��o dos instrumentos
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
educ_hat = fitted(reg.1st)

# 2o passo: lwage em fun��o de educ_hat e demais vari�veis ex�genas
reg.2nd = lm(lwage ~ educ_hat + exper + expersq, data=mroz)

# Comparativo
stargazer::stargazer(reg.2sls, reg.2nd, type="text", digits=4)
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


### Estima��o anal�tica 1

**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz "sobreidentificada" de instrumentos Z e de proje��o Pz
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


**d)** Res�duos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

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

**e)** Estimativa da vari�ncia do erro {{<math>}}$\hat{\sigma}^2_{\scriptscriptstyle{MQ2E}}${{</math>}}
{{<math>}}$$\hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}}{N - K - 1} $${{</math>}}


```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
sig2hat
```

```
## [1] 0.4552359
```

**f)** Matriz de Vari�ncias-Covari�ncias do Estimador

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


**g)** Erros-padr�o, estat�sticas t, p-valores e tabela-resumo

```r
se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Tabela-resumo
round(data.frame(bhat, se, t, p), 4) # resultado 2SLS anal�tico
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


### Estima��o anal�tica 2

- Tamb�m podemos fazer a estima��o MQ2E por meio de MQO nas vari�veis transformadas


**a)** Criando vetores/matrizes e definindo _N_ e _K_

```r
# Criando o vetor y
y = as.matrix(mroz[,"lwage"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, mroz[,c("educ","exper","expersq")]) )

# Criando a matriz "sobreidentificada" de instrumentos Z e de proje��o Pz
Z = as.matrix( cbind(1, mroz[,c("fatheduc","motheduc","exper","expersq")]) )
Pz = Z %*% solve( t(Z) %*% Z ) %*% t(Z)

# Pegando valores N e K
N = nrow(X)
K = ncol(X) - 1
```


**b1)** Obtendo {{<math>}}$\hat{\boldsymbol{X}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X}${{</math>}} e {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{y}${{</math>}}


```r
ytil = Pz %*% y
Xhat = Pz %*% X
head(cbind(X, Xhat))
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

- Note que, mesmo pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} por {{<math>}}$\boldsymbol{P_{\scriptscriptstyle{Z^*}}}${{</math>}}, **as vari�veis ex�genas permaneceram com os mesmos valores**, j� que _exper_ e _expersq_ est�o presentes em ambas matrizes {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{Z}${{</math>}}.
- Embora o instrumento {{<math>}}$\boldsymbol{x}^*_1${{</math>}} em 


**b2)** Estimativas MQ2E {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQ2E}} = (\hat{\boldsymbol{X}}' \hat{\boldsymbol{X}})^{-1} \hat{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}


```r
bhat = solve( t(Xhat) %*% Xhat ) %*% t(Xhat) %*% ytil
bhat
```

```
##                  [,1]
## 1        0.0481003069
## educ     0.0613966287
## exper    0.0441703929
## expersq -0.0008989696
```


**c -- g)** Passos s�o os mesmos dos aplicados anteriormente:

```r
yhat = X %*% bhat
ehat = y - yhat
sig2hat = as.numeric( t(ehat) %*% ehat / (N-K-1) )
Vbhat = sig2hat * solve( t(X) %*% X )

se = sqrt( diag(Vbhat) )
t = bhat / se
p = 2 * pt(-abs(t), N-K-1)

# Tabela-resumo
round(data.frame(bhat, se, t, p), 4) # resultado 2SLS anal�tico
```

```
##            bhat     se       t      p
## 1        0.0481 0.2011  0.2392 0.8111
## educ     0.0614 0.0143  4.2867 0.0000
## exper    0.0442 0.0133  3.3113 0.0010
## expersq -0.0009 0.0004 -2.2580 0.0245
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


<!-- ### Equa��es Simult�neas -->

<!-- - Modelos de Equa��es Simult�neas (MES/SEM) -->





</br>

## Testes de diagn�stico

- Para os testes, considere o modelo multivariado com {{<math>}}$J=1${{</math>}} regressor end�geno:
{{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + \beta_{2} \boldsymbol{x}_{2} + ... + \beta_K \boldsymbol{x}_{K} + \boldsymbol{\varepsilon} $${{</math>}}
em que {{<math>}}$\boldsymbol{x}^*_1${{</math>}} � o regressor end�geno do modelo, com {{<math>}}$K${{</math>}} regressores.
- Para estimar por MQ2E, fazemos o primeiro est�gio do regressor end�geno em rela��o aos seus {{<math>}}$L${{</math>}} instrumentos e as demais vari�veis ex�genas:
{{<math>}}$$ \boldsymbol{x}^*_{1} = \gamma_0 + \gamma^*_1 \boldsymbol{z}_{1} + \gamma^*_2 \boldsymbol{z}_{2} + ... + \gamma^*_L \boldsymbol{z}_{L} + \gamma_{2} \boldsymbol{x}_{2} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} $${{</math>}}

Usando o pr�prio `summary()` em um objeto gerado por `ivreg()`, j� s�o mostrados tr�s testes de diagn�stico: 

```r
data(mroz, package="wooldridge") # carregando base de dados
mroz = mroz[!is.na(mroz$wage),] # retirando valores ausentes de sal�rio

# Regress�o e Resumo detalhado do resultado
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # regress�o 2SLS
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

- Vamos ver os testes de maneira mais detalhada abaixo.


</br>

### Teste de Endogeneidade

#### (a) Teste de Hausman

- Para verificar a presen�a de endogeneidade podemos usar o **Teste de Hausman** (tamb�m conhecido como Durbin-Wu-Hausman)
- Este � um teste mais geral, que **compara** dois vetores de estimativas para verificar se s�o estatisticamente iguais.
- Para isto, � utilizado um vetor de constrastes (vetor de diferen�a entre vetores de estimativas)

A ideia do Teste de Hausman � a seguinte:
- Escolhemos dois m�todos/modelos de estima��o, cuja **diferen�a seja a robustez uma "situa��o"**
- Os dois estimadores s�o **ambos consistentes na aus�ncia da "situa��o"**
  - O estimador "menos robusto" � mais eficiente quando a "situa��o" est� ausente
  - J� o estimador "mais robusto" � **n�o-viesado na presen�a da "situa��o"**
- Se a diferen�a entre as estimativas for estatisticamente
  - _significante_, isto deve-se ao fato da presen�a da "situa��o", que torna o estimador "menos robusto" viesado/inconsistente e, portanto, diferente do estimador "mais robusto";
  - _n�o-significante_, ent�o a "situa��o" n�o est� presente e, logo, o estimador mais eficiente (e "menos robusto") � mais adequado
  

</br>  

No caso de vari�veis instrumentais:
- Escolhemos os estimadores de MQO e de MQ2E/VI, em que a "situa��o" � a endogeneidade.
- Caso a **endogeneidade esteja presente**, estimador MQ2E/VI ser� n�o-viesado/consistente e, portanto, tendem estimativas tendem a ser diferentes de MQO (viesado)
- Caso a **endogeneidade esteja ausente, ambos estimadores s�o consistentes** (tendem ao verdadeiro {{<math>}}$\boldsymbol{\beta}${{</math>}}), mas o estimador de **MQO ser� o mais eficiente**
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}'  \boldsymbol{X})^{-1}\right] \quad \text{ e } \quad \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}} \boldsymbol{X})^{-1} \right]$${{</math>}}
e, portanto, podemos testar
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[0,\ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}}) \right] $${{</math>}}
por meio de uma estat�stica na forma quadr�tica (de Wald):
{{<math>}}$$ w = (\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}})' \left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}}) \right]^{-1} (\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}} - \hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}})\, \sim\, \chi^2_{(J)} $${{</math>}}
em que os graus de liberdade da estat�stica qui-quadrado � a quantidade de regressores end�genos sendo consideradas no modelo ({{<math>}}$J${{</math>}}).

- Note que a inversa a subtra��o de matrizes de vari�ncias-covari�ncias de estimadores, {{<math>}}$\left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQO}}) \right]^{-1}${{</math>}}, � inst�vel e, caso d� erro, pode ser necess�rio fazer a opera��o via **inversa generalizada** (`MASS::ginv()` no R).


</br>

Aplicando ao exemplo no R:


```r
# estima��o do modelo MQO
reg.ols = ivreg(lwage ~ educ + exper + expersq, data=mroz)

# estima��o do modelo MQ2E
reg.2sls = ivreg(lwage ~ educ + exper + expersq |
                   fatheduc + motheduc + exper + expersq, data=mroz)

contrast = coef(reg.2sls) - coef(reg.ols) # vetor de contrastes
w = (t(contrast) %*% solve( vcov(reg.2sls) - vcov(reg.ols) ) %*% contrast)
w # estat�stica de Wald
```

```
##         [,1]
## [1,] 2.69566
```

```r
1 - pchisq(abs(w), df=1) # p-valor do teste qui-quadrado
```

```
##           [,1]
## [1,] 0.1006218
```
- O p-valor � pr�ximo de 10\%, ou seja, a diferen�a entre os estimadores MQO e MQ2E (vetor de contrastes) � n�o-significante aos n�veis comuns de signific�ncia.
- Isto � um ind�cio de que n�o h� endogeneidade, pois o estimador de MQO seria viesado na presen�a de endogeneidade e, portanto, geraria estimativas distintas do MQ2E/VI.



#### (b) Teste de Hausman por regress�o

Como apontado por Hausman (1978, 1983), **� poss�vel obter, por regress�o, uma estat�stica assintoticamente equivalente** � estat�stica de Wald acima:

- Faz-se a regress�o de 1� est�gio
  {{<math>}}$$ \boldsymbol{x}^*_{1} = \gamma_0 + \gamma^*_1 \boldsymbol{z}_{1} + \gamma^*_2 \boldsymbol{z}_{2} + ... + \gamma^*_L \boldsymbol{z}_{L} + \gamma_{2} \boldsymbol{x}_{2} + ... + \gamma_K \boldsymbol{x}_{K} + \boldsymbol{u} $${{</math>}}
- Obt�m-se os res�duos do primeiro est�gio {{<math>}}$\hat{\boldsymbol{u}}${{</math>}}
- Realiza-se o 2� est�gio modificado, incluindo os res�duos do primeiro est�gio como um regressor:
  {{<math>}}$$ \boldsymbol{y} = \beta_0 + \beta_1 \boldsymbol{x}^*_{1} + \beta_{2} \boldsymbol{x}_{2} + ... + \beta_K \boldsymbol{x}_{K} + \delta \hat{\boldsymbol{u}} + \boldsymbol{\varepsilon} $${{</math>}}
em que {{<math>}}$\boldsymbol{x}^*_1${{</math>}}
- Avalia-se o p-valor do par�metro dos res�duos do 1� est�gio, {{<math>}}$\delta${{</math>}}
  

```r
# 1� est�gio
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
uhat = resid(reg.1st)

# 2� est�gio modificado (com res�duos do 1� est�gio como regressor)
reg.2nd.mod  = lm(lwage ~ educ + exper + expersq + uhat, data=mroz)
summary(reg.2nd.mod)$coef
```

```
##                  Estimate   Std. Error   t value     Pr(>|t|)
## (Intercept)  0.0481003069 0.3945752571  0.121904 0.9030329286
## educ         0.0613966287 0.0309849420  1.981499 0.0481823507
## exper        0.0441703929 0.0132394473  3.336272 0.0009240749
## expersq     -0.0008989696 0.0003959133 -2.270622 0.0236719150
## uhat         0.0581666128 0.0348072757  1.671105 0.0954405509
```

- O p-valor de _uhat_ � pr�ximo ao obtido fazendo o Teste de Hausman de fato, mas n�o � exatamente igual a ele (aqui � significante a 10\%)
- O p-valor obtido por regress�o � o utilizado no output do `summary(ivreg(...))`


</br>


### Testes de Instrumentos Fracos

- No teste de instrumentos fracos, testamos a hip�tese nula **conjunta** de que os par�metros dos instrumentos s�o iguais a zero, ou seja:
{{<math>}}$$H_0: \quad \ \boldsymbol{\gamma}^* = \boldsymbol{0}\ \iff\ \begin{bmatrix} \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \end{bmatrix} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix}$${{</math>}}
- Podemos verificar isso por meio dos Testes de Wald ou F.
- For more details, see the [Hypothesis Testing section](../sec3).


#### (a) Teste de Wald

{{<math>}}$$ w(\hat{\boldsymbol{\gamma}}) = \left[ \boldsymbol{R}\hat{\boldsymbol{\gamma}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V_{\hat{\gamma}} R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\gamma}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}
em que:
- {{<math>}}$G${{</math>}} o n�mero de restri��es lineares
- {{<math>}}$\boldsymbol{\beta}${{</math>}} � um vetor de par�metros {{<math>}}$(K+1) \times 1${{</math>}}
- {{<math>}}$\boldsymbol{h}${{</math>}} � um vetor de constantes {{<math>}}$G \times 1${{</math>}}
- {{<math>}}$\boldsymbol{R}${{</math>}} � uma matriz {{<math>}}$G \times (K+1)${{</math>}}, contida por diversos vetores-linha {{<math>}}$\boldsymbol{r}'_g${{</math>}} de dimens�es {{<math>}}$1 \times (K+1)${{</math>}}, para {{<math>}}$g=1, 2, ..., G${{</math>}}

O teste, neste caso de instrumentos fracos temos {{<math>}}$G=L${{</math>}},
{{<math>}}$$\underset{L \times 1}{\boldsymbol{h}} = \boldsymbol{0} = \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix}, \qquad \qquad \underset{(1+L+K-J) \times 1}{\boldsymbol{\gamma}} = \begin{bmatrix} \gamma_0 \\ \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \\ \gamma_{J+1} \\ \vdots \\ \gamma_K \end{bmatrix} $${{</math>}}

{{<math>}}$$ \underset{L \times (1+L+K-J)}{\boldsymbol{R}} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \vdots \\ \boldsymbol{r}'_L \end{matrix} \right] =  \begin{matrix} 
\begin{matrix} \ \end{matrix}  \\
\left[ \begin{array}{c|cccc|ccc}
\ 0\  & \ 1 & \ 0 & \cdots & \ 0 & \ 0 & \ \cdots & \ 0\  \\
\ 0\  & \ 0 & \ 1 & \cdots & \ 0 & \ 0 & \ \cdots & \ 0\  \\
\ \vdots\ & \ \vdots & \ \vdots & \ddots & \ \vdots & \ \vdots & \ \ddots & \ \vdots\  \\
\ 0\  & \ 0 & \ 0 & \cdots & \ 1 & \ 0 & \ \cdots & \ 0\  \\
\end{array} \right] \\  
\begin{matrix} \color{red}\gamma_0 & \color{red}\gamma^*_1 & \color{red}\gamma^*_2 & \color{red}\cdots & \color{red}\gamma^*_L & \color{red}\gamma_{J+1} & \color{red}\cdots & \color{red}\gamma_{K} \end{matrix}  \end{matrix} $${{</math>}}

- Ent�o, a hip�tese nula �
{{<math>}}\begin{align} \text{H}_0:\quad \boldsymbol{R} \hat{\boldsymbol{\gamma}}\ &=\ \boldsymbol{h} \\
\begin{bmatrix} \gamma^*_1 \\ \gamma^*_2 \\ \vdots \\ \gamma^*_L \end{bmatrix} &= \begin{bmatrix} 0 \\ 0 \\ \vdots \\ 0 \end{bmatrix} \ \iff\ \boldsymbol{\gamma}^* = \boldsymbol{0} \end{align}{{</math>}}


</br>

Aplicando ao exemplo no R:


```r
# 1o passo: educ em fun��o dos instrumentos
reg.1st = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)
Vghat = vcov(reg.1st)
ghat = as.matrix(coef(reg.1st))

G = 2 # n� de restri��es = L instrumentos
R = matrix(c(
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0
  ), nrow=G, byrow=TRUE)
R
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    0    1    0    0    0
## [2,]    0    0    1    0    0
```

```r
h = matrix(0, nrow=G)
h
```

```
##      [,1]
## [1,]    0
## [2,]    0
```

```r
aux = R %*% ghat - h # Rg = h
w = t(aux) %*% solve( R %*% Vghat %*% t(R)) %*% aux
w # estat�stica de Wald
```

```
##          [,1]
## [1,] 110.8006
```

```r
1 - pchisq(abs(w), df=G)
```

```
##      [,1]
## [1,]    0
```

P-valor � praticamente igual a zero, ent�o rejeitamos que os instrumentos sejam conjuntamente estatisticamente iguais a zero (fracos).



#### (b) Teste F
- Uma outra forma de avaliar restri��es m�ltiplas � por meio do teste F.
- Nele, estimamos dois modelos:
  - Irrestrito (_ur_): inclui todas os vari�veis explicativas de interesse
  - Restrito (_r_): exclui algumas vari�veis da estima��o
- O teste F compara as somas dos quadrados dos res�duos (SQR) ou os {{<math>}}R$^2${{</math>}} de ambos modelos.
- A ideia �: se as vari�veis exclu�das forem significantes conjuntamente, ent�o haver� uma diferen�a de poder explicativo entre os modelos e, logo, as vari�veis seriam significantes.

No caso de vari�veis instrumentais, vamos estimar o primeiro est�gio:
- com todos os instrumentos (irrestrito)
- sem nenhum instrumento (restrito)
e, assim, calcular a estat�stica F

{{<math>}}$$ F = \frac{\text{SSR}_{r} - \text{SSR}_{ur}}{\text{SSR}_{ur}}.\frac{N-K-1}{G} = \frac{R^2_{ur} - R^2_{r}}{1 - R^2_{ur}}.\frac{N-K-1}{G} $${{</math>}}

- Depois, avalia-se a estat�stica _F_ a partir de um teste unicaudal � direita em uma distribui��o _F_ com {{<math>}}$G${{</math>}} e {{<math>}}$N-K-1${{</math>}} graus de liberdade.


</br>

Aplicando ao exemplo no R:

```r
# Pegando valores
N = nrow(mroz) # n� de observa��es
K = 4 # n� de covariadas
G = 2 # n� de restri��es/instrumentos

# Estimando o modelo irrestrito (igual ao de cima)
reg.1st_ur = lm(educ ~ fatheduc + motheduc + exper + expersq, data=mroz)

# Estimando o modelo restrito
reg.1st_r = lm(educ ~ exper + expersq, data=mroz)

# Extraindo os R2 dos resultados das estima��es
r2.ur = summary(reg.1st_ur)$r.squared
r2.ur # R2 irrestrito
```

```
## [1] 0.2114706
```

```r
r2.r = summary(reg.1st_r)$r.squared
r2.r # R2 restrito
```

```
## [1] 0.004923277
```

```r
# Calculando a estat�stica F
F = ( r2.ur - r2.r ) / (1 - r2.ur) * (N-K-1) /  G
F
```

```
## [1] 55.4003
```

```r
# p-valor do teste F
1 - pf(F, G, N-K-1)
```

```
## [1] 0
```
Assim como no Teste de Wald, o p-valor do Teste F � praticamente igual a zero, ent�o rejeitamos que os instrumentos sejam conjuntamente estatisticamente iguais a zero (fracos).


</br>

### Testes de Sobreidentifica��o

- Quando temos mais instrumentos dispon�veis do que regressores end�genos {{<math>}}$(L>J)${{</math>}}, � interressante incluir a **maior quantidade de vari�veis instrumentais** para tornar o estimador ainda **mais eficiente**.
- No entanto, deve-se tomar cuidado para n�o incluir instrumentos que n�o sejam de fato ex�genos (independentes do termo de erro), pois pode acarretar na perda da consist�ncia dos estimadores {{<math>}}($\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{MQ2E}}${{</math>}} deixa de tender ao valor verdadeiro).



#### (a) Teste de Hausman

- Aqui, vamos utilizar novamente o **Teste de (Durbin-Wu-)Hausman**, por�m comparando dois vetores de estimativas calculadas pelo mesmo m�todo (MQ2E):
  - [Irrestrito - _ur_]: um vetor de estimativas com **todos instrumentos** do regressor end�geno
    - **Mais eficiente na aus�ncia de endogeneidade** ("situa��o") dos instrumentos extras com o erro
  - [Restrito - _r_]: outro **apenas com {{<math>}}$L=J${{</math>}} "melhores" instrumentos**, ou seja, inclui apenas os instrumentos que (por suposi��o) s�o de fato ex�genos em rela��o ao erro.
    - Modelo exatamente identificado
    - Na presen�a de endogeneidade dos instrumentos extras, � (por suposi��o) consistente.
- O Teste de Hausman faz um teste **comparativo** da diferen�a das estimativas MQ2E dos dois modelos (vetor de contrastes). Se as estimativas forem estatisticamente:
  - diferentes, ent�o os instrumentos extras provavelmente s�o end�genos e suas estimativas inconsistentes, pois um conjunto de instrumentos �timo deveria melhorar a efici�ncia do estimador
  - iguais, ent�o os instrumentos extras provavelmente s�o ex�genos e podem ser utilizados.

Formalmente:

- Sob a hip�tese nula, ambos modelos restrito (_r_) e irrestrito (_ur_) s�o consistentes produzem estimadores consistentes de {{<math>}}$\boldsymbol{\beta}${{</math>}}:
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{ur}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}^{ur} \boldsymbol{X})^{-1}\right] \quad \text{ e } \quad \hat{\boldsymbol{\beta}}^{r}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[\beta,\ \sigma^2(\boldsymbol{X}' \boldsymbol{P_{\scriptscriptstyle{Z}}}^{r} \boldsymbol{X})^{-1} \right] $${{</math>}}
e, portanto, podemos testar
{{<math>}}$$ \hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r}\ \overset{\scriptscriptstyle{A}}{\sim}\ N\left[0,\ V(\hat{\boldsymbol{\beta}}^{ur}) - V(\hat{\boldsymbol{\beta}}^{r}) \right] $${{</math>}}
a partir da estat�stica teste de Wald:

{{<math>}}$$ w = (\hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r})' \left[ V(\hat{\boldsymbol{\beta}}^{ur}) - V(\hat{\boldsymbol{\beta}}^{r}) \right]^{-1} (\hat{\boldsymbol{\beta}}^{ur} - \hat{\boldsymbol{\beta}}^{r})\, \sim\, \chi^2_{(L-M)} $${{</math>}}

- Note que a inversa a subtra��o de matrizes de vari�ncias-covari�ncias de estimadores, {{<math>}}$\left[ V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{ur}}) - V(\hat{\boldsymbol{\beta}}^{\scriptscriptstyle{r}}) \right]^{-1}${{</math>}}, � inst�vel e, caso d� erro, pode ser necess�rio fazer a opera��o via **inversa generalizada** (`MASS::ginv()` no R).



```r
# estima��o do modelo irrestrito
reg.ur = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz)

# estima��o do modelo restrito
reg.r = ivreg(lwage ~ educ + exper + expersq |
                fatheduc + exper + expersq, data=mroz)

contrast = coef(reg.ur) - coef(reg.r) # vetor de contrastes
w = (t(contrast) %*% solve( vcov(reg.ur) - vcov(reg.r) ) %*% contrast)
w # estat�stica de Wald
```

```
##            [,1]
## [1,] -0.3936859
```

```r
1 - pchisq(abs(w), df=1) # p-valor do teste qui-quadrado
```

```
##           [,1]
## [1,] 0.5303683
```

- O p-valor do teste indica que que as estimativas de ambos modelos n�o s�o estatisticamente diferentes -- n�o evidenciando, portanto, exist�ncia de endogeneidade dos instrumentos.
- No entanto, � preciso ter cuidado, pois ainda � poss�vel que haja algum instrumento end�geno, j� que ambos modelos restrito e irrestrito podem assintoticamente viesados de maneira similar (e, portanto, n�o haveria muita diferen�a entre eles).



#### (b) Teste de Wald

- Alternativamente, podemos **avaliar diretamente a rela��o entre o termo de erro e os instrumentos**.
- Para isto precisamos:
  - Estimar por MQ2E o modelo com todos instrumentos dispon�veis.
  - Obter res�duos do modelo, {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}
  - Regredir os res�duos em fun��o de todos instrumentos e vari�veis ex�genas
  - Testar se as estimativas dos poss�veis instrumentos (candidatos a ex�genos) s�o conjuntamente iguais a zero via Teste de Wald (parecido com o teste de instrumentos fracos).
  


#### (c) Teste de Sargan

- Sargan desenvolveu um teste equivalente ao Wald (acima) utilizando regress�o.
- Utiliza os mesmos passos acima, por�m, ao inv�s de calcular a estat�stica de Wald, ap�s regredir os res�duos em fun��o dos instrumentos e vari�veis ex�genas, calcula-se a estat�stica
{{<math>}}$$NR^2\ \overset{A}{\sim}\ \chi^2_{(L-J)}$${{</math>}}


```r
# Pegando valores
N = nrow(mroz)
L = 2 # n� instrumentos 
J = 1 # n� regressores end�genos

# Estima��es
reg.2sls = ivreg(lwage ~ educ + exper + expersq | 
                 fatheduc + motheduc + exper + expersq, data=mroz) # regress�o 2SLS
res.aux = lm(resid(reg.2sls) ~ fatheduc + motheduc + exper + expersq, data=mroz)

# Estat�stica SARG
r2 = summary(res.aux)$r.squared
sarg = N * r2 # sempre positivo
1 - pchisq(sarg, df=L-J) # p-valor
```

```
## [1] 0.5386372
```

- Note que este teste � em rela��o a **todos os instrumentos**, j� que n�o faz uma compara��o entre modelos distintos com diferentes instrumentos.
- Ao rejeitar este teste, � necess�rio rever os instrumentos inseridos no modelo:
- Por�m, o teste n�o aponta qual dos instrumentos n�o s�o ex�genos -- pode ser apenas um, mais que um, ou todos os instrumentos!




<!-- </br> -->


