---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Testes de Hipótese
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Testes de Hipótese
weight: 9
output: md_document
type: book
---



- Agora, veremos formas mais gerais de testes de hipótese, que não são normalmente informadas nos resultados das regressões.


## Teste de Wald
- Considere:
  - {{<math>}}$G${{</math>}} o número de restrições lineares
  - {{<math>}}$\boldsymbol{\beta}${{</math>}} é um vetor de parâmetros {{<math>}}$(K+1) \times 1${{</math>}}
  - {{<math>}}$\boldsymbol{h}${{</math>}} é um vetor de constantes {{<math>}}$Q \times 1${{</math>}}
  - {{<math>}}$\boldsymbol{R}${{</math>}} é uma matriz {{<math>}}$G \times (K+1)${{</math>}}, contida por diversos vetores-linha {{<math>}}$\boldsymbol{r}'_g${{</math>}} de dimensões {{<math>}}$1 \times (K+1)${{</math>}}, para {{<math>}}$g=1, 2, ..., Q${{</math>}}
  - Modelo multivariado:
  
  {{<math>}}$$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + ... + \beta_K x_K + u$${{</math>}}

- A partir destas matrizes e vetores, é possível construir testes de hipótese na forma:
{{<math>}}\begin{align}
\text{H}_0: &\underset{G\times (K+1)}{\boldsymbol{R}} \underset{(K+1)\times 1}{\boldsymbol{\beta}} = \underset{G \times 1}{\boldsymbol{h}} \\
\text{H}_0: &\left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \vdots \\ \boldsymbol{r}'_{G} \end{matrix} \right] \boldsymbol{\beta} = \left[ \begin{matrix} h_1 \\ h_2 \\ \vdots \\ h_G \end{matrix} \right] \\
\text{H}_0: &\left\{ \begin{matrix} \boldsymbol{r}'_1 \boldsymbol{\beta} = h_1 \\ \boldsymbol{r}'_2 \boldsymbol{\beta} = h_2 \\ \vdots \\ \boldsymbol{r}'_G \boldsymbol{\beta} = h_G \end{matrix} \right.
\end{align}{{</math>}}



### Uma restrição linear

- Considere o modelo:
  {{<math>}}$$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + u$${{</math>}}

- Logo, há {{<math>}}$K=2${{</math>}} variáveis explicativas (e há 3 parâmetros)
- 1 restrição linear {{<math>}}$\Longrightarrow \ G=1${{</math>}}
- Logo, neste caso específico, temos
{{<math>}}$$\boldsymbol{R} = \boldsymbol{r}'_1\ \implies\ \text{H}_0:\ \boldsymbol{r}'_1 \boldsymbol{\beta} = h_1 $${{</math>}}


#### Exemplo 1: {{<math>}}H$_0: \ \beta_1 = 4${{</math>}}
- Note que {{<math>}}$h_1 = 4${{</math>}}
- O vetor {{<math>}}$r'_1${{</math>}} pode ser escrito como

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] $${{</math>}}

- Então, a hipótese nula é
{{<math>}}$$\text{H}_0:\ \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 4\ \iff\ \beta_1 = 4 $${{</math>}}



#### Exemplo 2: {{<math>}}H$_0: \ \beta_1 + \beta_2 = 2${{</math>}}
- Note que {{<math>}}$h_1 = 2${{</math>}}
- O vetor {{<math>}}$r'_1${{</math>}} pode ser escrito como

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- Então, a hipótese nula é
{{<math>}}$$\text{H}_0:\ \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 2\ \iff\ \beta_1 + \beta_2 = 2 $${{</math>}}


#### Exemplo 3: {{<math>}}H$_0: \ \beta_1 = \beta_2${{</math>}}
- Note que
{{<math>}}$$\beta_1 = \beta_2 \iff \beta_1 - \beta_2 = 0 $${{</math>}}

- Logo, {{<math>}}$h_1 = 0${{</math>}}
- O vetor {{<math>}}$r'_1${{</math>}} pode ser escrito como

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & -1 \end{matrix} \right] $${{</math>}}

- Então, a hipótese nula é
{{<math>}}$$\text{H}_0:\ \left[ \begin{matrix} 0 & 1 & -1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = 0\ \iff\ \beta_1 - \beta_2 = 0 $${{</math>}}


#### Avaliando a hipótese nula com restrição única
- Para o caso com uma única restrição, assumimos que 
{{<math>}}$$ \boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} \sim N(\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}};\ \sigma^2 \boldsymbol{r}'_1 \boldsymbol{V_{\beta(x)} r_1})$${{</math>}}

- Calcula-se a estatística _t_:
{{<math>}}$$ t = \frac{\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} - h_1}{\sqrt{\hat{\sigma}^2 \boldsymbol{r}'_1 \boldsymbol{V_{\beta(x)} r_1}}} $${{</math>}}

- Note que, em pequenas amostras, precisamos assumir que {{<math>}}$ u|x \sim N(0; \sigma^2) ${{</math>}}
- Escolhe-se o nível de significância {{<math>}}$\alpha${{</math>}} e rejeita-se a hipótese nula se a estatística _t_ não pertencer ao intervalo de confiança.

</br>


### Múltiplas restrições lineares

#### Exemplo 4: {{<math>}}H$_0: \ \beta_1 = 0\ \text{ e }\ \beta_1 + \beta_2 = 2${{</math>}}
- Note que {{<math>}}$h_1 = 0 \text{ e } h_2 = 2${{</math>}}
- Os vetores {{<math>}}$r'_1 \text{ e } r'_2${{</math>}} podem ser escritos como

{{<math>}}$$ r'_1 = \left[ \begin{matrix} 0 & 1 & 0 \end{matrix} \right] \quad \text{e} \quad r'_2 = \left[ \begin{matrix} 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- Logo, {{<math>}}$\boldsymbol{R}${{</math>}} é
{{<math>}}$$ \boldsymbol{R} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \end{matrix} \right] = \left[ \begin{matrix} 0 & 1 & 0 \\ 0 & 1 & 1 \end{matrix} \right] $${{</math>}}

- Então, a hipótese nula é
{{<math>}}$$\text{H}_0:\ \boldsymbol{R} \boldsymbol{\beta} = \left[ \begin{matrix} 0 & 1 & 0 \\ 0 & 1 & 1 \end{matrix} \right] \left[ \begin{matrix} \beta_0 \\ \beta_1 \\ \beta_2 \end{matrix} \right] = \left[ \begin{matrix} h_1 \\ h_2 \end{matrix} \right]\ \iff\ \text{H}_0:\ \left\{  \begin{matrix} \beta_1 &= 0 \\ \beta_1 + \beta_2 &= 2 \end{matrix} \right. $${{</math>}}


#### Avaliando a hipótese nula com múltiplas restrições
- Para o caso com _G_ restrições, assumimos que 
{{<math>}}$$ \boldsymbol{R} \hat{\boldsymbol{\beta}} \sim N(\boldsymbol{R} \hat{\boldsymbol{\beta}};\ \sigma^2 \boldsymbol{R} \boldsymbol{V_{\beta(x)} R'})$${{</math>}}

- Calcula-se a estatística de Wald
{{<math>}}$$ w(\hat{\boldsymbol{\beta}}) = \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V_{\hat{\beta}} R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}

- Escolhe-se o nível de significância {{<math>}}$\alpha${{</math>}} e rejeita-se a hipótese nula se a estatística {{<math>}}$ w(\hat{\boldsymbol{\beta}})${{</math>}} não pertencer ao intervalo de confiança (do zero ao valor crítico).

</br>

### Aplicando no R

- Usaremos o pacote de dados `mlb1` (com estatísticas de jogadores de beisebol) do pacote `wooldridge`
- Queremos estimar o modelo
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + \beta_3. \text{bavg} + \\
&\beta_4 .\text{hrunsyr} + \beta_5. \text{rbisyr} + u \end{align}{{</math>}}


em que:
  - `log(salary)`: log do salário de 1993
  - `years`: anos jogando na 1ª divisão de beisebol americano
  - `gamesyr`: média de jogos por ano
  - `bavg`: média de rebatidas na carreira
  - `hrunsyr`: média de _home runs_ por ano
  - `rbisyr`: média de corridas impulsionadas por ano


```r
data(mlb1, package="wooldridge")

# Estimando o modelo completo (irrestrito)
res.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)
round(summary(res.ur)$coef, 5) # coeficientes da estimação
```

```
##             Estimate Std. Error  t value Pr(>|t|)
## (Intercept) 11.19242    0.28882 38.75184  0.00000
## years        0.06886    0.01211  5.68430  0.00000
## gamesyr      0.01255    0.00265  4.74244  0.00000
## bavg         0.00098    0.00110  0.88681  0.37579
## hrunsyr      0.01443    0.01606  0.89864  0.36947
## rbisyr       0.01077    0.00717  1.50046  0.13440
```

- Note que, individualmente, as variáveis `bavg`, `hrunsyr` e `rbisyr` são estatisticamente não significantes.
- Queremos avaliar se eles são estatisticamente significantes de forma conjunta, ou seja,
{{<math>}}$$ \text{H}_0:\ \left\{ \begin{matrix} \beta_3 = 0 \\ \beta_4 = 0 \\ \beta_5 = 0\end{matrix} \right.   $${{</math>}}

- Logo, temos que
{{<math>}}$$ \boldsymbol{R} = \left[ \begin{matrix} \boldsymbol{r}'_1 \\ \boldsymbol{r}'_2 \\ \boldsymbol{r}'_3 \end{matrix} \right] = \left[ \begin{matrix} 0 & 0 & 0 & 1 & 0 & 0 \\ 0 & 0 & 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 0 & 0 & 1 \end{matrix} \right] $${{</math>}}


#### Usando função `Wald.test()`


```r
# Extraindo matriz de variância-covariância do estimador
V_bhat = vcov(res.ur)
round(V_bhat, 5)
```

```
##             (Intercept)    years  gamesyr     bavg  hrunsyr   rbisyr
## (Intercept)     0.08342  0.00001 -0.00027 -0.00029 -0.00148  0.00082
## years           0.00001  0.00015 -0.00001  0.00000 -0.00002  0.00001
## gamesyr        -0.00027 -0.00001  0.00001  0.00000  0.00002 -0.00002
## bavg           -0.00029  0.00000  0.00000  0.00000  0.00000  0.00000
## hrunsyr        -0.00148 -0.00002  0.00002  0.00000  0.00026 -0.00010
## rbisyr          0.00082  0.00001 -0.00002  0.00000 -0.00010  0.00005
```

```r
# Calculando a estatística de Wald
# install.packages("aod") # instalando o pacote necessário
aod::wald.test(Sigma = V_bhat, # matriz de variância-covariância
               b = coef(res.ur), # estimativas
               Terms = 4:6, # posições dos parâmetros a serem testados
               H0 = c(0, 0, 0) # Hipótese nula (tudo igual a zero)
               )
```

```
## Wald test:
## ----------
## 
## Chi-squared test:
## X2 = 28.7, df = 3, P(> X2) = 2.7e-06
```

- Observe que rejeitamos a hipótese nula e, portanto, os parâmetros {{<math>}}$\beta_3, \beta_4 \text{ e } \beta_5${{</math>}} são conjuntamente significantes.


#### Calculando "na mão"

- Estimando o modelo

```r
# Criando variavel log_salary
mlb1$log_salary = log(mlb1$salary)
name_y = "log_salary"
names_X = c("years", "gamesyr", "bavg", "hrunsyr", "rbisyr")

# Criando o vetor y
y = as.matrix(mlb1[,name_y]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind( const=1, mlb1[,names_X] ) ) # juntando 1's com as covariadas

# Pegando valores N e K
N = nrow(mlb1)
K = ncol(X) - 1

# Estimando o modelo
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
round(bhat, 5)
```

```
##             [,1]
## const   11.19242
## years    0.06886
## gamesyr  0.01255
## bavg     0.00098
## hrunsyr  0.01443
## rbisyr   0.01077
```

```r
# Calculando os resíduos
uhat = y - X %*% bhat

# Variância do termo de erro
sig2hat = as.numeric( t(uhat) %*% uhat / (N-K-1) )

# Matriz de variância-covariância do estimador
V_bhat = sig2hat * solve( t(X) %*% X )
round(V_bhat, 5)
```

```
##            const    years  gamesyr     bavg  hrunsyr   rbisyr
## const    0.08342  0.00001 -0.00027 -0.00029 -0.00148  0.00082
## years    0.00001  0.00015 -0.00001  0.00000 -0.00002  0.00001
## gamesyr -0.00027 -0.00001  0.00001  0.00000  0.00002 -0.00002
## bavg    -0.00029  0.00000  0.00000  0.00000  0.00000  0.00000
## hrunsyr -0.00148 -0.00002  0.00002  0.00000  0.00026 -0.00010
## rbisyr   0.00082  0.00001 -0.00002  0.00000 -0.00010  0.00005
```

- Agora, vamos criar a matriz das restrições

```r
# Número de restrições
G = 3

# Matriz das restrições
R = matrix(c(0, 0, 0, 1, 0, 0,
             0, 0, 0, 0, 1, 0,
             0, 0, 0, 0, 0, 1),
           nrow=G, byrow=TRUE)
R
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    0    0    0    1    0    0
## [2,]    0    0    0    0    1    0
## [3,]    0    0    0    0    0    1
```

```r
# Vetor de constantes h
h = matrix(c(0, 0, 0),
           nrow=3, ncol=1)
h
```

```
##      [,1]
## [1,]    0
## [2,]    0
## [3,]    0
```

- Lembre-se que, por padrão, a função `matrix()` "preenche" a matrix por coluna.
- No entanto, é mais intuito preencher as restrições por linha (já que cada linha representa uma restrição). Para isto, foi usado o argumento `byrow=TRUE`.
- Calculando a estatística de Wald, dada por
{{<math>}}$$ w(\hat{\boldsymbol{\beta}}) = \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]' \left[ \boldsymbol{R V_{\hat{\beta}} R}' \right]^{-1} \left[ \boldsymbol{R}\hat{\boldsymbol{\beta}} - \boldsymbol{h} \right]\ \sim\ \chi^2_{(G)} $${{</math>}}


```r
# Estatística de Wald
w = t( R %*% bhat - h ) %*% solve( R %*% V_bhat %*% t(R) ) %*% (R %*% bhat - h)
w
```

```
##          [,1]
## [1,] 28.65076
```

```r
# Encontrando valor crítico Qui-quadrado para 5% de signif.
alpha = 0.05
cv = qchisq(1-alpha, df=G)
cv
```

```
## [1] 7.814728
```

```r
# Comparando estatística de Wald e valor crítico
w > cv
```

```
##      [,1]
## [1,] TRUE
```

- Como Estatística de Wald (= 28,65) é maior do que o valor crítico (= 7,81), então rejeitamos a hipótese nula conjunta de que todos parâmetros testados são iguais a zero.
- Também poderíamos verificar o p-valor por meio da estatística de Wald:

```r
1 - pchisq(w, df=G)
```

```
##              [,1]
## [1,] 2.651604e-06
```

- Como é menor do que 5%, rejeita-se a hipótese nula.


</br>


## Teste F

- [Seção 4.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/133)
- Uma outra forma de avaliar 

{{< cta cta_text="👉 Seguir para Otimização Numérica" cta_link="../sec9" >}}
