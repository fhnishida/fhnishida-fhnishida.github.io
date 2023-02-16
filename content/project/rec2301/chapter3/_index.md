---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Data Manipulation
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Data Manipulation
weight: 3
output: md_document
type: book
---




## Resumindo dados

### Funções básicas
- [Summarizing data (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/e5qVi/summarizing-data)
- Para esta seção, usaremos a base de dados `airquality`, já presente no R.
- Verificaremos o **dimensões** da base com `dim()` e visualizaremos as 6 **primeiras** e **últimas** linhas da base via `head()` e `tail()`, respectivamente.

```r
# data() # lista de base de dados presentes no R
bd_air = airquality # Atribuindo a base a um outro objeto

dim(bd_air) # Verificar tamanho da base (linhas x colunas)
```

```
## [1] 153   6
```

```r
head(bd_air) # Visualizando as 6 primeiras linhas
```

```
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
## 3    12     149 12.6   74     5   3
## 4    18     313 11.5   62     5   4
## 5    NA      NA 14.3   56     5   5
## 6    28      NA 14.9   66     5   6
```

```r
tail(bd_air) # Visualizando as 6 últimas linhas
```

```
##     Ozone Solar.R Wind Temp Month Day
## 148    14      20 16.6   63     9  25
## 149    30     193  6.9   70     9  26
## 150    NA     145 13.2   77     9  27
## 151    14     191 14.3   75     9  28
## 152    18     131  8.0   76     9  29
## 153    20     223 11.5   68     9  30
```
- Usando `str()`, podemos visualizar a **estrutura** da base:
    - todas a variáveis (colunas),
    - a classe de cada uma delas e
    - algumas de suas observações.

```r
str(bd_air)
```

```
## 'data.frame':	153 obs. of  6 variables:
##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...
```
- Podemos ver as **categorias/valores únicos** para cada variável combinando `apply()` e `unique()`

```r
apply(bd_air, 2, unique)
```

```
## $Ozone
##  [1]  41  36  12  18  NA  28  23  19   8   7  16  11  14  34   6  30   1   4  32
## [20]  45 115  37  29  71  39  21  20  13 135  49  64  40  77  97  85  10  27  48
## [39]  35  61  79  63  80 108  52  82  50  59   9  78  66 122  89 110  44  65  22
## [58]  31 168  73  76 118  84  96  91  47  24  46
## 
## $Solar.R
##   [1] 190 118 149 313  NA 299  99  19 194 256 290 274  65 334 307  78 322  44
##  [19]   8 320  25  92  66 266  13 252 223 279 286 287 242 186 220 264 127 273
##  [37] 291 323 259 250 148 332 191 284  37 120 137 150  59  91 135  47  98  31
##  [55] 138 269 248 236 101 175 314 276 267 272 139  48 260 285 187   7 258 295
##  [73] 294  81  82 213 275 253 254  83  24  77 255 229 207 222 192 157  64  71
##  [91]  51 115 244  36 212 238 215 153 203 225 237 188 167 197 183 189  95 230
## [109] 112 224  27 201  14  49  20 193 145 131
## 
## $Wind
##  [1]  7.4  8.0 12.6 11.5 14.3 14.9  8.6 13.8 20.1  6.9  9.7  9.2 10.9 13.2 12.0
## [16] 18.4 16.6  5.7 16.1 20.7 10.3  6.3  1.7  4.6  4.1  5.1  4.0 15.5  3.4  2.3
## [31]  2.8
## 
## $Temp
##  [1] 67 72 74 62 56 66 65 59 61 69 68 58 64 57 73 81 79 76 78 84 85 82 87 90 93
## [26] 92 80 77 75 83 88 89 91 86 97 94 96 71 63 70
## 
## $Month
## [1] 5 6 7 8 9
## 
## $Day
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
## [26] 26 27 28 29 30 31
```
- Podemos verificar o **número de NA's** em cada coluna usando `apply()` com `sum` (ou também `colSums()`) na base de dados com `is.na()` (transforma a base de dados em TRUE/FALSE se for ou não `NA`)

```r
head( is.na(bd_air) ) # 6 primeiras linhas aplicando is.na()
```

```
##      Ozone Solar.R  Wind  Temp Month   Day
## [1,] FALSE   FALSE FALSE FALSE FALSE FALSE
## [2,] FALSE   FALSE FALSE FALSE FALSE FALSE
## [3,] FALSE   FALSE FALSE FALSE FALSE FALSE
## [4,] FALSE   FALSE FALSE FALSE FALSE FALSE
## [5,]  TRUE    TRUE FALSE FALSE FALSE FALSE
## [6,] FALSE    TRUE FALSE FALSE FALSE FALSE
```

```r
apply(is.na(bd_air), 2, sum) # somando cada coluna de TRUE/FALSE
```

```
##   Ozone Solar.R    Wind    Temp   Month     Day 
##      37       7       0       0       0       0
```

- Para fazer um **resumo** de todas as variáveis da base, podemos usar a função `summary()` que, para variáveis numéricas, calcula a média e os quartis, e mostra a quantidade de `NA`.

```r
summary(bd_air)
```

```
##      Ozone           Solar.R           Wind             Temp      
##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
##  NA's   :37       NA's   :7                                       
##      Month            Day      
##  Min.   :5.000   Min.   : 1.0  
##  1st Qu.:6.000   1st Qu.: 8.0  
##  Median :7.000   Median :16.0  
##  Mean   :6.993   Mean   :15.8  
##  3rd Qu.:8.000   3rd Qu.:23.0  
##  Max.   :9.000   Max.   :31.0  
## 
```
- Também podemos calcular os **quantis** via `quantile()`

```r
quantile(bd_air$Ozone, probs=c(0, .25, .5 , .75, 1), na.rm=TRUE)
```

```
##     0%    25%    50%    75%   100% 
##   1.00  18.00  31.50  63.25 168.00
```
- Outra maneira de verificarmos quartis/médias de variáveis numéricas de um data frame inteiro é utilizando o `summary()`

```r
summary(bd_air)
```

```
##      Ozone           Solar.R           Wind             Temp      
##  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
##  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
##  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
##  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
##  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
##  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
##  NA's   :37       NA's   :7                                       
##      Month            Day      
##  Min.   :5.000   Min.   : 1.0  
##  1st Qu.:6.000   1st Qu.: 8.0  
##  Median :7.000   Median :16.0  
##  Mean   :6.993   Mean   :15.8  
##  3rd Qu.:8.000   3rd Qu.:23.0  
##  Max.   :9.000   Max.   :31.0  
## 
```
- Note que, para variáveis lógicas, de texto ou categóricas (factor), aparecem a quantidade de cada valor:

```r
summary(CO2) # base de dados 'Carbon Dioxide Uptake in Grass Plants'
```

```
##      Plant             Type         Treatment       conc          uptake     
##  Qn1    : 7   Quebec     :42   nonchilled:42   Min.   :  95   Min.   : 7.70  
##  Qn2    : 7   Mississippi:42   chilled   :42   1st Qu.: 175   1st Qu.:17.90  
##  Qn3    : 7                                    Median : 350   Median :28.30  
##  Qc1    : 7                                    Mean   : 435   Mean   :27.21  
##  Qc3    : 7                                    3rd Qu.: 675   3rd Qu.:37.12  
##  Qc2    : 7                                    Max.   :1000   Max.   :45.50  
##  (Other):42
```
- Para variáveis de texto, pode ser interessante fazer uma **tabela com a contagem** de cada possível categoria de uma variável. Isto é possível por meio da função `table()` e aplicaremos `prop.table(table())` para visualizar em **percentuais**.

```r
table(CO2$Type, useNA="ifany") # mostrando os NA's
```

```
## 
##      Quebec Mississippi 
##          42          42
```

```r
prop.table(table(CO2$Type, useNA="ifany"))
```

```
## 
##      Quebec Mississippi 
##         0.5         0.5
```

```r
# table(bd_air$Month, useNA="ifany") # mostrando os NA's
# prop.table(table(bd_air$Month, useNA="ifany"))
```
- Também podemos incluir mais uma variável em `table()` para verificar alguma relação entre categorias de 2 variáveis:

```r
table(CO2$Type, CO2$Treatment, useNA="ifany")
```

```
##              
##               nonchilled chilled
##   Quebec              21      21
##   Mississippi         21      21
```


### Família de funções _apply_
Veremos uma família de funções _apply_ que permitem executar comandos em loop de maneira compacta:

- `lapply`: loop sobre uma lista e avalia uma função em cada elemento
    - função auxiliar `split` é útil ao ser utilizada em conjunto da `lapply`
- `sapply`: mesmo que o `lapply`, mas simplifica o resultado
- `apply`: aplica uma função sobre as margens de um array
- `tapply`: aplica uma função sobre subconjuntos de um vetor
- `mapply`: versão multivariada do `lapply`



#### Função `lapply()`
- [Loop functions - lapply (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/t5iuo/loop-functions-lapply)
- `lapply` usa três argumentos: uma **lista**, o nome de uma função e outros argumentos (incluindo os da função inserida)
```yaml
lapply(X, FUN, ...)

X: a vector (atomic or list) or an expression object. Other objects (including classed objects) will be coerced by base::as.list.
FUN: the function to be applied to each element of X: see ‘Details’. In the case of functions like +, %*%, the function name must be backquoted or quoted.
... : optional arguments to FUN.
```

```r
x = list(a=1:5, b=rnorm(10))
lapply(x, mean)
```

```
## $a
## [1] 3
## 
## $b
## [1] 0.2011982
```

- `lapply` transforma o objeto em uma _lista_ (caso o input não seja), em que cada elemento possui um único elemento

```r
nada = function(x) {
    x # Retorna o próprio input
}

x = 1:4 # Vetor de 1 a 4 (será transformado em lista no lapply)
lapply(x, nada)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] 3
## 
## [[4]]
## [1] 4
```

- `lapply` sempre retorna uma _lista_ como output. Como exemplo, usaremos a função `runif(n, min = 0, max = 1)` para gerar `n` números aleatórios:

```r
runif(2) # Gerando 2 números aleatórios
```

```
## [1] 0.9868356 0.3915565
```

```r
x = 1:4 # Vetor de 1 a 4 (será transformado em lista no lapply)
lapply(x, runif, min=0, max=10) # 2 últimos argumentos são do runif
```

```
## [[1]]
## [1] 2.476778
## 
## [[2]]
## [1] 3.367401 9.541326
## 
## [[3]]
## [1] 2.9983309 0.6304832 7.2958016
## 
## [[4]]
## [1] 0.3879915 7.0672849 6.5840245 0.8029940
```
- Podemos usar funções _anônimas_ diretamente no `lapply`. Como exemplo, criaremos uma função que nos dá a 1ª coluna de uma matriz ou data frame:

```r
# Criando lista com 2 matrizes
x = list(a=matrix(1:4, 2, 2), b=matrix(1:6, 3, 2))
x
```

```
## $a
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## 
## $b
##      [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
```

```r
# Pegando as primeiras colunas de cada matriz da lista x
lapply(x, function(matriz){matriz[, 1]})
```

```
## $a
## [1] 1 2
## 
## $b
## [1] 1 2 3
```


#### Função `sapply()`
Similar ao `lapply`, mas `sapply` tenta simplificar o output:

- Se o resultado for uma lista em que todo elemento tem comprimento 1 (tem apenas um elemento também), retorna um vetor

```r
x = list(a=1:4, b=rnorm(10), c=rnorm(20, 1), d=rnorm(100, 5))
x
```

```
## $a
## [1] 1 2 3 4
## 
## $b
##  [1] -0.06626754 -1.61982173  0.50324286  1.52556079 -0.89963601 -1.16977134
##  [7]  0.06749303 -0.43575021 -1.45711368 -1.16506868
## 
## $c
##  [1]  1.71866950  2.77903590  1.12752637  2.66767763  1.23916746  1.54456494
##  [7]  0.47738427  0.70740333  2.00422576  1.55615223  0.23528671  0.08042295
## [13]  2.27237935 -0.12111176  1.55822794  0.36803266  1.36045465  1.14649226
## [19]  0.39238809  1.11268289
## 
## $d
##   [1] 6.032312 5.499384 4.802191 6.576707 5.307580 5.194670 4.782912 2.847100
##   [9] 4.782573 4.826916 4.895173 4.319973 4.995600 5.017713 4.003849 5.511380
##  [17] 5.704605 3.917463 5.117136 4.846049 5.721167 5.403748 4.981022 3.882856
##  [25] 5.337285 6.168357 3.724423 6.387623 4.939249 4.312517 5.169173 3.022127
##  [33] 4.469179 5.467962 6.784527 4.813113 5.349689 4.582251 4.683717 4.384101
##  [41] 4.408942 5.131878 4.962991 4.329092 4.928479 4.686996 4.789621 4.641457
##  [49] 5.009883 4.197657 3.791334 5.817296 2.576504 5.070883 4.706517 3.518276
##  [57] 3.109608 4.891961 5.744947 4.899517 5.539382 3.167600 5.902386 4.568241
##  [65] 5.748478 5.307421 3.960045 7.259957 6.750028 4.692822 5.259506 5.160191
##  [73] 5.460082 4.315419 6.849733 5.058773 5.067979 4.887062 5.742725 4.196349
##  [81] 5.181921 6.443224 6.080389 5.272432 4.428167 5.561348 4.597434 4.364897
##  [89] 5.117511 5.011159 6.120460 2.411815 5.086834 3.271331 4.228603 3.522625
##  [97] 4.695924 3.953700 4.181980 6.940345
```

```r
lapply(x, mean) # retorna uma lista
```

```
## $a
## [1] 2.5
## 
## $b
## [1] -0.4717133
## 
## $c
## [1] 1.211353
## 
## $d
## [1] 4.911455
```

```r
sapply(x, mean) # retorna um vetor
```

```
##          a          b          c          d 
##  2.5000000 -0.4717133  1.2113532  4.9114549
```
- Se o resultado for uma lista em que cada elemento tem mesmo comprimento ($>1$), retorna uma matriz

```r
x = 1:4

tabuada = function(a) {
    a * 1:10
}
tabuada(2)
```

```
##  [1]  2  4  6  8 10 12 14 16 18 20
```

```r
lapply(x, tabuada) # retorna uma lista
```

```
## [[1]]
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## [[2]]
##  [1]  2  4  6  8 10 12 14 16 18 20
## 
## [[3]]
##  [1]  3  6  9 12 15 18 21 24 27 30
## 
## [[4]]
##  [1]  4  8 12 16 20 24 28 32 36 40
```

```r
sapply(x, tabuada) # retorna uma matrix
```

```
##       [,1] [,2] [,3] [,4]
##  [1,]    1    2    3    4
##  [2,]    2    4    6    8
##  [3,]    3    6    9   12
##  [4,]    4    8   12   16
##  [5,]    5   10   15   20
##  [6,]    6   12   18   24
##  [7,]    7   14   21   28
##  [8,]    8   16   24   32
##  [9,]    9   18   27   36
## [10,]   10   20   30   40
```

- Caso contrário, retorna uma lista (assim como `lapply`)

```r
x = 1:4
sapply(x, runif, min=0, max=10) # retorna igual ao lapply
```

```
## [[1]]
## [1] 2.14253
## 
## [[2]]
## [1] 9.355927 5.421518
## 
## [[3]]
## [1] 4.587367 9.717092 4.971157
## 
## [[4]]
## [1] 3.4356143 2.0059809 0.2831549 3.9405858
```


#### Função `apply()`
- [Loop functions - apply (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/IUUhK/loop-functions-apply)
- Usado para avaliar, por meio de uma função, margens de um array
- Frequentemente é utilizado para aplicar uma função a linhas ou a colunas de uma matriz
- Não é mais rápido do que escrever um loop, mas funciona em uma única linha
```yaml
apply(X, MARGIN, FUN, ...)

X: an array, including a matrix.MARGIN: a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns. Where X has named dimnames, it can be a character vector selecting dimension names.
FUN: the function to be applied: see ‘Details’. In the case of functions like +, %*%, etc., the function name must be backquoted or quoted.
... : optional arguments to FUN.
```

```r
x = matrix(1:20, 5, 4)
x
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    6   11   16
## [2,]    2    7   12   17
## [3,]    3    8   13   18
## [4,]    4    9   14   19
## [5,]    5   10   15   20
```

```r
apply(x, 1, mean) # médias das linhas
```

```
## [1]  8.5  9.5 10.5 11.5 12.5
```

```r
apply(x, 2, mean) # médias das colunas
```

```
## [1]  3  8 13 18
```
- Há funções pré-definidas que aplicam `apply` com soma e com média:
    - `rowSums = apply(x, 1, sum)`
    - `rowMeans = apply(x, 1, mean)`
    - `colSums = apply(x, 2, sum)`
    - `colMeans = apply(x, 2, mean)`
- Podemos também calcular os quantis de uma matriz usando a função `quantile()`
```yaml
quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE,
         names = TRUE, type = 7, digits = 7, ...)

x: numeric vector whose sample quantiles are wanted, or an object of a class for which a method has been defined (see also ‘details’). NA and NaN values are not allowed in numeric vectors unless na.rm is TRUE.
probs: numeric vector of probabilities with values in [0,1]. (Values up to 2e-14 outside that range are accepted and moved to the nearby endpoint.)
na.rm: logical; if true, any NA and NaN's are removed from x before the quantiles are computed.
```

```r
x = matrix(1:50, 10, 5) # matriz 20x10 - 200 números ~ N(0, 1)
apply(x, 2, quantile, probs=c(0, .25, .5, .75, 1))
```

```
##       [,1]  [,2]  [,3]  [,4]  [,5]
## 0%    1.00 11.00 21.00 31.00 41.00
## 25%   3.25 13.25 23.25 33.25 43.25
## 50%   5.50 15.50 25.50 35.50 45.50
## 75%   7.75 17.75 27.75 37.75 47.75
## 100% 10.00 20.00 30.00 40.00 50.00
```


#### Função `mapply()`
- [Loop functions - mapply (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/EBnAr/loop-functions-mapply)
- Versão multivariada de apply. Antes incluímos apenas um vetor `x` para aplicar na função, agora iremos incluir 2 ou mais vetores.
- Por isso, `mapply` tem como primeiro argumento a função `FUN`, já que podemos ter diversos vetores como input
```yaml
mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,
       USE.NAMES = TRUE)

FUN: function to apply, found via match.fun.
...	: arguments to vectorize over (vectors or lists of strictly positive length, or all of zero length). See also ‘Details’.
MoreArgs: a list of other arguments to FUN.
SIMPLIFY: logical or character string; attempt to reduce the result to a vector, matrix or higher dimensional array; see the simplify argument of sapply.
```
- Note que, agora, precisamos incluir os argumento da função por meio de uma _lista_ no argumento `MoreArgs`
- Como exemplo, usaremos a função `rep(x, n)` que cria um vetor com o objeto `x` repetido `n` vezes (**são necessário 2 argumentos**)

```r
rep(1, 5)
```

```
## [1] 1 1 1 1 1
```

```r
# Criando uma lista com números repetidos
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
```

```
## [[1]]
## [1] 1 1 1 1
## 
## [[2]]
## [1] 2 2 2
## 
## [[3]]
## [1] 3 3
## 
## [[4]]
## [1] 4
```

```r
# Podemos fazer o mesmo usando a função mapply
mapply(rep, 1:4, 4:1)
```

```
## [[1]]
## [1] 1 1 1 1
## 
## [[2]]
## [1] 2 2 2
## 
## [[3]]
## [1] 3 3
## 
## [[4]]
## [1] 4
```


#### Função `tapply()`
- [Loop functions - tapply (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/w98BR/loop-functions-tapply)
- Função `tapply` é uma versão do `apply` em que há um output para cada grupo/categoria.
- Para usá-la, precisamos inserir tanto um vetor de valores `x`, quanto um vetor de índices dos grupos/categoria.
```yaml
tapply(X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)

X: an R object for which a split method exists. Typically vector-like, allowing subsetting with [.
INDEX: a list of one or more factors, each of same length as X. The elements are coerced to factors by as.factor.
FUN: a function (or name of a function) to be applied, or NULL. In the case of functions like +, %*%, etc., the function name must be backquoted or quoted. If FUN is NULL, tapply returns a vector which can be used to subscript the multi-way array tapply normally produces.
```
- Como exemplo, calcularemos a média de `x` para 4 grupos

```r
x = rnorm(20)
grupos = rep(c("a", "b", "c", "d"), 5)
data.frame(x, grupos)
```

```
##              x grupos
## 1   0.06453586      a
## 2   0.85789908      b
## 3   1.61012943      c
## 4   0.13481258      d
## 5  -0.07117312      a
## 6  -0.93607198      b
## 7  -1.32282991      c
## 8   0.55507640      d
## 9   0.23831474      a
## 10  0.90152863      b
## 11  0.75304668      c
## 12 -0.92288028      d
## 13 -1.20664939      a
## 14  1.11838327      b
## 15 -1.10253018      c
## 16 -1.96373977      d
## 17  0.53678013      a
## 18  0.70343655      b
## 19 -1.00317721      c
## 20  0.11412991      d
```

```r
tapply(x, grupos, mean)
```

```
##           a           b           c           d 
## -0.08763836  0.52903511 -0.21307224 -0.41652023
```


#### Função `split()`
- [Loop functions - split (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/2VYGZ/loop-functions-split)
- Assim como o `tapply`, divide em grupos, mas retorna apenas uma lista com elementos correspondentes aos grupos e seus valores

```r
split(x, grupos)
```

```
## $a
## [1]  0.06453586 -0.07117312  0.23831474 -1.20664939  0.53678013
## 
## $b
## [1]  0.8578991 -0.9360720  0.9015286  1.1183833  0.7034365
## 
## $c
## [1]  1.6101294 -1.3228299  0.7530467 -1.1025302 -1.0031772
## 
## $d
## [1]  0.1348126  0.5550764 -0.9228803 -1.9637398  0.1141299
```
- Depois de separar em uma lista, podemos usar o `lapply` ou `sapply` (é como se fosse aplicar o `tapply`, mas em 2 etapas)

```r
sapply(split(x, grupos), mean)
```

```
##           a           b           c           d 
## -0.08763836  0.52903511 -0.21307224 -0.41652023
```




## Manipulando dados

> “Between 30% to 80% of the data analysis task is spent on cleaning and understanding the data.” (Dasu \& Johnson, 2003)

### Extração de subconjuntos
- [Subsetting and sorting (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/aqd2Y/subsetting-and-sorting)
- Como exemplo, criaremos um _data frame_ com três variáveis, em que, para misturar a ordem dos números, usaremos a função `sample()` num vetor de números e também incluiremos alguns valores ausentes `NA`.

```r
set.seed(2022)
x = data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x
```

```
##   var1 var2 var3
## 1    4    9   13
## 2    3    7   11
## 3    2    8   12
## 4    1   10   15
## 5    5    6   14
```

```r
x$var2[c(1, 3)] = NA
x
```

```
##   var1 var2 var3
## 1    4   NA   13
## 2    3    7   11
## 3    2   NA   12
## 4    1   10   15
## 5    5    6   14
```
- Lembre-se que, para extrair um subconjunto de um data frame, usamos as chaves `[]` indicando vetores de linhas e de colunas (ou também os nomes das colunas).

```r
x[, 1] # Todas linhas e 1ª coluna
```

```
## [1] 4 3 2 1 5
```

```r
x[, "var1"] # Todas linhas e 1ª coluna (usando seu nome)
```

```
## [1] 4 3 2 1 5
```

```r
x[1:2, "var2"] # Linhas 1 e 2, e 2ª coluna (usando seu nome)
```

```
## [1] NA  7
```
- Note que, podemos usar expressões lógicas (vetor com `TRUE` e `FALSE`) para extrair uma parte do data frame. Por exemplo, queremos obter apenas as observações em que a variável 1 seja menor ou igual a 3 **E** (`&`) que a variável 3 seja estritamente maior do que 11:

```r
x$var1 <= 3 & x$var3 > 11
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE
```

```r
# Extraindo as linhas de x
x[x$var1 <= 3 & x$var3 > 11, ]
```

```
##   var1 var2 var3
## 3    2   NA   12
## 4    1   10   15
```
- Poderíamos também obter apenas as observações em que a variável 1 seja menor ou igual a 3 **OU** (`|`) que a variável 3 seja estritamente maior do que 11:

```r
x[x$var1 <= 3 | x$var3 > 11, ]
```

```
##   var1 var2 var3
## 1    4   NA   13
## 2    3    7   11
## 3    2   NA   12
## 4    1   10   15
## 5    5    6   14
```
- Também podemos verificar se determinados valores estão contidos em um vetor específico (equivale `==` com mais de um valor)

```r
x$var1 %in% c(1, 5) # obs em que var1 é igual a 1 ou 5
```

```
## [1] FALSE FALSE FALSE  TRUE  TRUE
```

```r
x[x$var1 %in% c(1, 5), ]
```

```
##   var1 var2 var3
## 4    1   10   15
## 5    5    6   14
```

- Note que, ao escrevermos uma expressão lógica para um vetor que contém valores ausentes, gerará um vetor com `TRUE`, `FALSE` e `NA`

```r
x$var2 > 8
```

```
## [1]    NA FALSE    NA  TRUE FALSE
```

```r
x[x$var2 > 8, ]
```

```
##      var1 var2 var3
## NA     NA   NA   NA
## NA.1   NA   NA   NA
## 4       1   10   15
```
- Para contornar este problema, podemos usar a função `which()` que, ao invés de gerar um vetor de `TRUE`/`FALSE`, retorna um vetor com as posições dos elementos que tornam a expressão lógica verdadeira

```r
which(x$var2 > 8)
```

```
## [1] 4
```

```r
x[which(x$var2 > 8), ]
```

```
##   var1 var2 var3
## 4    1   10   15
```
- Outra forma de contornar os valores ausentes é incluir a condição 
de não incluir valores ausentes `!is.na()`:

```r
x$var2 > 8 & !is.na(x$var2)
```

```
## [1] FALSE FALSE FALSE  TRUE FALSE
```

```r
x[x$var2 > 8 & !is.na(x$var2), ]
```

```
##   var1 var2 var3
## 4    1   10   15
```


### Ordenação
- Podemos usar a função `sort()` para ordenar um vetor de maneira crescente (padrão) ou decrescente:

```r
sort(x$var1) # ordenando de maneira crescente
```

```
## [1] 1 2 3 4 5
```

```r
sort(x$var1, decreasing=TRUE) # ordenando de maneira decrescente
```

```
## [1] 5 4 3 2 1
```
- Por padrão, o `sort()` retira os valores ausentes. Para mantê-los e deixá-los no final, precisamos usar o argumento `na.last=TRUE`

```r
sort(x$var2) # ordenando e retirando NA
```

```
## [1]  6  7 10
```

```r
sort(x$var2, na.last=TRUE) # ordenando e mantendo NA no final
```

```
## [1]  6  7 10 NA NA
```
- Note que não podemos usar a função `sort()` para ordenar um data frame, pois a função retorna valores e, portanto, não retorna suas posições.

```r
sort(x$var3)
```

```
## [1] 11 12 13 14 15
```

```r
x[sort(x$var3), ] # Retorna erro, pois não há nº de linhas > 5
```

```
##      var1 var2 var3
## NA     NA   NA   NA
## NA.1   NA   NA   NA
## NA.2   NA   NA   NA
## NA.3   NA   NA   NA
## NA.4   NA   NA   NA
```
- Para ordenar data frames, precisamos utilizar a função `order()` que, ao invés de retorar os valores em algum ordem, retorna as suas posições

```r
order(x$var3)
```

```
## [1] 2 3 1 5 4
```

```r
x[order(x$var3), ] # Retorna erro, pois não há nº de linhas > 5
```

```
##   var1 var2 var3
## 2    3    7   11
## 3    2   NA   12
## 1    4   NA   13
## 5    5    6   14
## 4    1   10   15
```

### Inclusão de novas colunas/variáveis
- Para incluir novas variáveis, podemos usar `$<novo_nome_var>` e atribuir um vetor de mesmo tamanho (mesma quantidade de linhas):

```r
set.seed(1234)
x$var4 = rnorm(5)
x
```

```
##   var1 var2 var3       var4
## 1    4   NA   13 -1.2070657
## 2    3    7   11  0.2774292
## 3    2   NA   12  1.0844412
## 4    1   10   15 -2.3456977
## 5    5    6   14  0.4291247
```

- [Algumas transformações comuns de variáveis (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/r6VHJ/creating-new-variables)

```r
abs(x$var4) # valor absoluto
```

```
## [1] 1.2070657 0.2774292 1.0844412 2.3456977 0.4291247
```

```r
sqrt(x$var4) # raiz quadrada
```

```
## Warning in sqrt(x$var4): NaNs produzidos
```

```
## [1]       NaN 0.5267155 1.0413651       NaN 0.6550761
```

```r
ceiling(x$var4) # valor inteiro acima
```

```
## [1] -1  1  2 -2  1
```

```r
floor(x$var4) # valor inteiro abaixo
```

```
## [1] -2  0  1 -3  0
```

```r
round(x$var4, digits=1) # arredondamento com 1 dígito
```

```
## [1] -1.2  0.3  1.1 -2.3  0.4
```

```r
cos(x$var4) # cosseno
```

```
## [1]  0.3557632  0.9617627  0.4674068 -0.6996456  0.9093303
```

```r
sin(x$var4) # seno
```

```
## [1] -0.9345761  0.2738841  0.8840424 -0.7144900  0.4160750
```

```r
log(x$var4) # logaritmo natural
```

```
## Warning in log(x$var4): NaNs produzidos
```

```
## [1]         NaN -1.28218936  0.08106481         NaN -0.84600775
```

```r
log10(x$var4) # logaritmo base 10
```

```
## Warning: NaNs produzidos
```

```
## [1]        NaN -0.5568478  0.0352060        NaN -0.3674165
```

```r
exp(x$var4) # exponencial
```

```
## [1] 0.29907355 1.31973273 2.95778648 0.09578035 1.53591253
```



### Juntando bases de dados

#### Acrescentando colunas e linhas via `cbind()` e `rbind()`

- Uma maneira de juntar o data frame com um vetor de mesmo tamanho é usando `cbind()`

```r
y = rnorm(5)
x = cbind(x, y)
x
```

```
##   var1 var2 var3       var4          y
## 1    4   NA   13 -1.2070657  0.5060559
## 2    3    7   11  0.2774292 -0.5747400
## 3    2   NA   12  1.0844412 -0.5466319
## 4    1   10   15 -2.3456977 -0.5644520
## 5    5    6   14  0.4291247 -0.8900378
```
- Também podemos acrescentar linhas usando `rbind()`, desde que o vetor tenha a quantidade de elementos igual ao número de colunas (ou data frame a ser incluído tenha o mesmo número de colunas)

```r
z = rnorm(5)
x = rbind(x, z)
x
```

```
##         var1       var2       var3        var4          y
## 1  4.0000000         NA 13.0000000 -1.20706575  0.5060559
## 2  3.0000000  7.0000000 11.0000000  0.27742924 -0.5747400
## 3  2.0000000         NA 12.0000000  1.08444118 -0.5466319
## 4  1.0000000 10.0000000 15.0000000 -2.34569770 -0.5644520
## 5  5.0000000  6.0000000 14.0000000  0.42912469 -0.8900378
## 6 -0.4771927 -0.9983864 -0.7762539  0.06445882  0.9594941
```

#### Mesclando base de dados com `merge()`
- [Merging data (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/pVV6K/merging-data)
- Podemos juntar base de dados a partir de uma variável-chave que aparece em ambas bases.
- Como exemplo, utilizaremos duas bases de dados de respostas a perguntas ([`solutions.csv`](https://fhnishida-rec5004.netlify.app/docs/solutions.csv)) e de correções feitas por seus pares ([`reviews.csv`](https://fhnishida-rec5004.netlify.app/docs/reviews.csv)).

```r
solutions = read.csv("https://fhnishida-rec5004.netlify.app/docs/solutions.csv")
head(solutions)
```

```
##   id problem_id subject_id      start       stop time_left answer
## 1  1        156         29 1304095119 1304095169      2343      B
## 2  2        269         25 1304095119 1304095183      2329      C
## 3  3         34         22 1304095127 1304095146      2366      C
## 4  4         19         23 1304095127 1304095150      2362      D
## 5  5        605         26 1304095127 1304095167      2345      A
## 6  6        384         27 1304095131 1304095270      2242      C
```

```r
reviews = read.csv("https://fhnishida-rec5004.netlify.app/docs/reviews.csv")
head(reviews)
```

```
##   id solution_id reviewer_id      start       stop time_left accept
## 1  1           3          27 1304095698 1304095758      1754      1
## 2  2           4          22 1304095188 1304095206      2306      1
## 3  3           5          28 1304095276 1304095320      2192      1
## 4  4           1          26 1304095267 1304095423      2089      1
## 5  5          10          29 1304095456 1304095469      2043      1
## 6  6           2          29 1304095471 1304095513      1999      1
```
- Note que:
    - as primeiras colunas das bases `solutions` e `reviews`` são os identificadores únicos das soluções e dos reviews, respectivamente.
    - na base `reviews` há a coluna _problem_id_ que faz a ligação entre esta base com a coluna _id_ da base `solutions`.
- Usaremos a função `merge()` para juntar ambas bases em uma só, a partir do id da solução.

```yaml
merge(x, y, by = intersect(names(x), names(y)),
      by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
      sort = TRUE, suffixes = c(".x",".y"), ...)

x, y: data frames, or objects to be coerced to one.
by, by.x, by.y: specifications of the columns used for merging. See ‘Details’.
all: logical; all = L is shorthand for all.x = L and all.y = L, where L is either TRUE or FALSE.
all.x: logical; if TRUE, then extra rows will be added to the output, one for each row in x that has no matching row in y. These rows will have NAs in those columns that are usually filled with values from y. The default is FALSE, so that only rows with data from both x and y are included in the output.
all.y: logical; analogous to all.x.
sort: logical. Should the result be sorted on the by columns?
suffixes: a character vector of length 2 specifying the suffixes to be used for making unique the names of columns in the result which are not used for merging (appearing in by etc).
```

<center><img src="../merge.webp"></center>


```r
mergedData = merge(reviews, solutions,
                   by.x="solution_id",
                   by.y="id",
                   all=TRUE)
head(mergedData)
```

```
##   solution_id id reviewer_id    start.x     stop.x time_left.x accept
## 1           1  4          26 1304095267 1304095423        2089      1
## 2           2  6          29 1304095471 1304095513        1999      1
## 3           3  1          27 1304095698 1304095758        1754      1
## 4           4  2          22 1304095188 1304095206        2306      1
## 5           5  3          28 1304095276 1304095320        2192      1
## 6           6 16          22 1304095303 1304095471        2041      1
##   problem_id subject_id    start.y     stop.y time_left.y answer
## 1        156         29 1304095119 1304095169        2343      B
## 2        269         25 1304095119 1304095183        2329      C
## 3         34         22 1304095127 1304095146        2366      C
## 4         19         23 1304095127 1304095150        2362      D
## 5        605         26 1304095127 1304095167        2345      A
## 6        384         27 1304095131 1304095270        2242      C
```

- Note que, como há colunas de mesmos nomes, e especificamos que a variável chave era somente o id de solução, então as colunas de nomes iguais foram renomeadas com sufixos `.x` e `.y`, correspondendo às 1ª e 2ª bases inseridas na função `merge()`
- Para verificar as colunas com mesmos nomes em duas bases, podemos usar a função `intersect()` em conjunto com a função `names()`:

```r
intersect( names(solutions), names(reviews) )
```

```
## [1] "id"        "start"     "stop"      "time_left"
```
- Se não especificássemos nenhuma variável-chave, a função `merge()` utilizaria como variável-chave todas as colunas com nomes iguais em ambas bases de dados 

```r
wrong = merge(reviews, solutions,
                   all=TRUE)
head(wrong)
```

```
##   id      start       stop time_left solution_id reviewer_id accept problem_id
## 1  1 1304095119 1304095169      2343          NA          NA     NA        156
## 2  1 1304095698 1304095758      1754           3          27      1         NA
## 3  2 1304095119 1304095183      2329          NA          NA     NA        269
## 4  2 1304095188 1304095206      2306           4          22      1         NA
## 5  3 1304095127 1304095146      2366          NA          NA     NA         34
## 6  3 1304095276 1304095320      2192           5          28      1         NA
##   subject_id answer
## 1         29      B
## 2         NA   <NA>
## 3         25      C
## 4         NA   <NA>
## 5         22      C
## 6         NA   <NA>
```



{{< cta cta_text="👉 Proceed to `dplyr` Manipulation" cta_link="../chapter4" >}}
