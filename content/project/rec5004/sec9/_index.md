---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Hypothesis Testing
summary: This page is about statistical hypothesis testing using the Wald test. It explains how to construct hypothesis tests using matrices and vectors and provides examples of linear constraints. The page also includes R code for evaluating the null hypothesis with a single constraint and multiple linear constraints. Additionally, it discusses the F-test and provides an example using the mlb1 dataset from Wooldridge (2006).
title: Hypothesis Testing
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



#### Aplicando no R

#### Avaliando a hipótese nula com restrição única
- Para o caso com uma única restrição, assumimos que 
{{<math>}}$$ \boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} \sim N(\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}};\ \boldsymbol{r}'_1 \boldsymbol{V_{\beta(x)} r_1})$${{</math>}}

- Calcula-se a estatística _t_:
{{<math>}}$$ t = \frac{\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} - h_1}{\sqrt{\boldsymbol{r}'_1 S^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{r}_1}} = \frac{\boldsymbol{r}'_1 \hat{\boldsymbol{\beta}} - h_1}{\sqrt{\boldsymbol{r}'_1 \boldsymbol{V_{\beta(x)}} \boldsymbol{r}_1}} $${{</math>}}

- Note que, em pequenas amostras, precisamos assumir que {{<math>}}$ u|x \sim N(0; \sigma^2) ${{</math>}}
- Escolhe-se o nível de significância {{<math>}}$\alpha${{</math>}} e rejeita-se a hipótese nula se a estatística _t_ não pertencer ao intervalo de confiança.



##### (Continuação) Exemplo 7.5 - Equação do Log do Salário-Hora (Wooldridge, 2006)
- Anteriormente, estimamos o seguinte modelo:

{{<math>}}\begin{align}
\log(\text{wage}) = &\beta_0 + \beta_1 \text{female} + \beta_2 \text{married} + \delta_2 \text{female*married} + \beta_3 \text{educ} +\\
&\beta_4 \text{exper} + \beta_5 \text{exper}^2 + \beta_6 \text{tenure} + \beta_7 \text{tenure}^2 + u \end{align}{{</math>}}
em que:

- `wage`: salário médio por hora
- `female`: dummy em que (1) mulher e (0) homem
- `married`: dummy em que (1) casado e (0) solteiro
- `female*married`: interação (multiplicação) das _dummies_ `female` e `married`
- `educ`: anos de educação
- `exper`: anos de experiência (`expersq` = anos ao quadrado)
- `tenure`: anos de trabalho no empregador atual (`tenursq` = anos ao quadrado)


```r
# Carregando a base de dados necessária
data(wage1, package="wooldridge")

# Estimando o modelo
res_7.14 = lm(lwage ~ female*married + educ + exper + expersq + tenure + tenursq, data=wage1)
round( summary(res_7.14)$coef, 4 )
```

```
##                Estimate Std. Error t value Pr(>|t|)
## (Intercept)      0.3214     0.1000  3.2135   0.0014
## female          -0.1104     0.0557 -1.9797   0.0483
## married          0.2127     0.0554  3.8419   0.0001
## educ             0.0789     0.0067 11.7873   0.0000
## exper            0.0268     0.0052  5.1118   0.0000
## expersq         -0.0005     0.0001 -4.8471   0.0000
## tenure           0.0291     0.0068  4.3016   0.0000
## tenursq         -0.0005     0.0002 -2.3056   0.0215
## female:married  -0.3006     0.0718 -4.1885   0.0000
```

- Notamos que o efeito do casamento sobre mulheres é diferente do efeito sobre homens, pois o parâmetro de `female:married` ({{<math>}}$\delta_2${{</math>}}) é significante.
- No entanto, para avaliar se o efeito do casamento sobre a mulher é significante, precisamos ver se {{<math>}}H$_0 :\ \beta_2 + \delta_2 = 0${{</math>}}.
- Como tem apenas uma restrição, a hipótese pode ser avaliada por teste _t_:

<img src="../t_test.png" alt="">


```r
# Extraindo objetos da regressão
bhat = matrix(coef(res_7.14), ncol=1) # coeficientes como vetor-coluna
Vbhat = vcov(res_7.14) # matriz de variância-covariância do estimador
N = nrow(wage1) # número de observações
K = length(bhat) - 1 # número de covariadas
uhat = residuals(res_7.14) # resíduos da regressão

# Criando vetor-linha de restrição
r1prime = matrix(c(0, 0, 1, 0, 0, 0, 0, 0, 1), nrow=1) # vetor restrição
h1 = 0 # constante da H0
G = 1 # número de restrições

# Fazendo teste t
t = (r1prime %*% bhat - h1) / sqrt(r1prime %*% Vbhat %*% t(r1prime))
abs(t)
```

```
##          [,1]
## [1,] 1.679475
```

```r
# Avaliando valor crítico em distribuição Qui-quadrado a 5% signif.
c = qt(1 - 0.05/2, df=N-K-1)
c
```

```
## [1] 1.964563
```

```r
# Calculando o p-valor
p = pt(-abs(t), N-K-1) * 2
p
```

```
##            [,1]
## [1,] 0.09366368
```

- Como {{<math>}}$|t| < 2${{</math>}} (valor crítico aproximada para nível de significância de 5\%), então não rejeitamos a hipótese nula e concluímos que o efeito do casamento sobre o salário de mulheres ({{<math>}}$\beta_2 + \delta_2${{</math>}}) é estatisticamente não-significante.

- Também podemos fazer o mesmo pelo teste de Wald, mas avaliando a estatística pela distribuição {{<math>}}$\chi^2${{</math>}} com 1 grau de liberdade (pois há apenas {{<math>}}$G=1${{</math>}} restrição)
- Lembre-se também que usa-se o teste qui-quadrado unicaudal à direita.


<img src="../chisq_test.png" alt="">



```r
# Calculando estatística de Wald
aux = r1prime %*% bhat - h1 # R \beta - h
w = t(aux) %*% solve( r1prime %*% Vbhat %*% t(r1prime)) %*% aux
w
```

```
##          [,1]
## [1,] 2.820636
```

```r
# Avaliando valor crítico em distribuição Qui-quadrado a 5% signif.
c = qchisq(1-0.05, df=G)
c
```

```
## [1] 3.841459
```

```r
# Calculando p-valor de w
p = 1 - pchisq(w, df=G)
p
```

```
##            [,1]
## [1,] 0.09305951
```


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

- Como exemplo, usaremos o pacote de dados `mlb1` com estatísticas de jogadores de beisebol (Wooldridge, 2006, Seção 4.5)
- Queremos estimar o modelo:
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
resMLB = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)
round(summary(resMLB)$coef, 5) # coeficientes da estimação
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
Vbhat = vcov(resMLB)
round(Vbhat, 5)
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
aod::wald.test(Sigma = Vbhat, # matriz de variância-covariância
               b = coef(resMLB), # estimativas
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

```r
# Wald test for the effect of root
# aod::wald.test(b = coef(resMLB), Sigma = vcov(resMLB), L=R, H0=h)
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
S2 = as.numeric( t(uhat) %*% uhat / (N-K-1) )

# Matriz de variância-covariância do estimador
Vbhat = S2 * solve( t(X) %*% X )
round(Vbhat, 5)
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
w = t( R %*% bhat - h ) %*% solve( R %*% Vbhat %*% t(R) ) %*% (R %*% bhat - h)
w
```

```
##          [,1]
## [1,] 28.65076
```

```r
# Encontrando valor crítico Qui-quadrado para 5% de signif.
alpha = 0.05
c = qchisq(1-alpha, df=G)
c
```

```
## [1] 7.814728
```

```r
# Comparando estatística de Wald e valor crítico
w > c
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
- Uma outra forma de avaliar restrições múltiplas é por meio do teste F.
- Nele, estimamos dois modelos:
  - Irrestrito: inclui todas as as variáveis explicativas de interesse
  - Restrito: exclui algumas variáveis da estimação
- O teste F compara as somas dos quadrados dos resíduos (SQR) ou os {{<math>}}R$^2${{</math>}} de ambos modelos.
- A ideia é: se as variáveis excluídas forem significantes conjuntamente, então haverá uma diferença de poder explicativo entre os modelos e, logo, as variáveis seriam significantes.

</br>

- A estatística _F_ pode ser calculada por:

{{<math>}}$$ F = \frac{\text{SQR}_{r} - \text{SQR}_{ur}}{\text{SQR}_{ur}}.\frac{N-K-1}{G} = \frac{R^2_{ur} - R^2_{r}}{1 - R^2_{ur}}.\frac{N-K-1}{G} \tag{4.10} $${{</math>}}

em que `ur` indica o modelo irrestrito, e `r` indica o modelo restrito.

- Depois, avalia-se a estatística _F_ a partir de um teste unicaudal à direita em uma distribuição _F_:

<img src="../F_test.png" alt="">



### Aplicando no R

- Aqui, continuaremos usando a base de dados `mlb1` da Seção 4.5 de Wooldridge (2006)
- O modelo irrestrito (com todas variáveis explicativas) é:
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + \beta_3. \text{bavg} + \\
&\beta_4 .\text{hrunsyr} + \beta_5. \text{rbisyr} + u \end{align}{{</math>}}

- O modelo restrito (excluindo as variáveis) é:
{{<math>}}\begin{align} \log(\text{salary}) = &\beta_0 + \beta_1. \text{years} + \beta_2. \text{gameyr} + u \end{align}{{</math>}}


#### Usando função `linearHypothesis()`
- É possível fazer o teste _F_ a partir da função `linearHypothesis()` do pacote `car`
- Além de incluir o objeto resultante de uma estimação, é necessário incluir um vetor de texto com as restrições:


```r
# Estimando o modelo irrestrito
res.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)

# Criando vetor com as restrições
myH0 = c("bavg = 0", "hrunsyr = 0", "rbisyr = 0")

# Aplicando o teste F
# install.packages("car") # instalando o pacote necessário
car::linearHypothesis(res.ur, myH0)
```

```
## Linear hypothesis test
## 
## Hypothesis:
## bavg = 0
## hrunsyr = 0
## rbisyr = 0
## 
## Model 1: restricted model
## Model 2: log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr
## 
##   Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
## 1    350 198.31                                  
## 2    347 183.19  3    15.125 9.5503 4.474e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

- Note que na 2ª linha (modelo irrestrito), a soma dos quadrados dos resíduos (SQR/RSS) é menor do que o do modelo restrito e, portanto, o conjunto maior de covariadas tem um maior poder explicativo (o que é esperado)
- Para avaliar a hipótese nula ({{<math>}}$\beta_3 = \beta_4 = \beta_5 = 0${{</math>}}), podemos verificar se a estatística _F_ é maior do que um valor crítico (dado um nível de significância), ou avaliarmos se o p-valor é menor do que esse nível de significância.
- É possível ver acima, pelo segundo critério, que rejeitamos a hipótese nula.
- Podemos ver o valor crítico a 5% de significância via:


```r
qf(1-0.05, G, N-K-1)
```

```
## [1] 2.630641
```
- Como 9,55 > 2,63, então rejeitamos a hipótese nula.


#### Calculando "na mão"

- Aqui, vamos estimar os resultados dos modelos irrestrito e restrito, estimados por `lm()` para não ter que fazer todos passos da estimação duas vezes.


```r
# Estimando o modelo irrestrito
res.ur = lm(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=mlb1)

# Estimando o modelo restrito
res.r = lm(log(salary) ~ years + gamesyr, data=mlb1)

# Extraindo os R2 dos resultados das estimações
r2.ur = summary(res.ur)$r.squared
r2.ur
```

```
## [1] 0.6278028
```

```r
r2.r = summary(res.r)$r.squared
r2.r
```

```
## [1] 0.5970716
```

```r
# Calculando a estatística F
F = ( r2.ur - r2.r ) / (1 - r2.ur) * (N-K-1) /  G
F
```

```
## [1] 9.550254
```

```r
# p-valor do teste F
1 - pf(F, G, N-K-1)
```

```
## [1] 4.473708e-06
```



</br>

{{< cta cta_text="👉 Proceed to Panel Data" cta_link="../sec10" >}}


