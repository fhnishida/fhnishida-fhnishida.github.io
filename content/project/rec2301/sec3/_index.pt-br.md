---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Manipulação de Dados"
summary: "Notas de Econometria I sobre estatísticas descritivas, família apply, ordenação, filtros, transformações e combinação básica de bases no R."
title: "Manipulação de Dados no R"
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

dim(airquality) # Verificar tamanho da base (linhas x colunas)
```

```
## [1] 153   6
```

```r
head(airquality) # Visualizando as 6 primeiras linhas
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
tail(airquality) # Visualizando as 6 últimas linhas
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
str(airquality)
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


- Para fazer um **resumo** de todas as variáveis da base, podemos usar a função `summary()` que, para variáveis numéricas, calcula a média e os quartis, e mostra a quantidade de `NA`.

```r
summary(airquality)
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
quantile(airquality$Ozone, probs=c(0, .25, .5 , .75, 1), na.rm=TRUE)
```

```
##     0%    25%    50%    75%   100% 
##   1.00  18.00  31.50  63.25 168.00
```

- Note que, para variáveis lógicas, de texto ou categóricas (factor), aparecem a contagem de cada categoria/possível valor:

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
table(CO2$Type) # contagem
```

```
## 
##      Quebec Mississippi 
##          42          42
```

```r
prop.table(table(CO2$Type)) # percentual
```

```
## 
##      Quebec Mississippi 
##         0.5         0.5
```
- Também podemos incluir mais uma variável em `table()` para visualizar a contagem considerando 2 variáveis:

```r
table(CO2$Type, CO2$Treatment)
```

```
##              
##               nonchilled chilled
##   Quebec              21      21
##   Mississippi         21      21
```


### Família de funções _apply_
Veremos uma família de funções _apply_ que permitem executar comandos em loop de maneira compacta:
- `apply`: aplica uma função sobre as margens (linha ou coluna) de uma matrix/array
- `lapply`: loop sobre uma lista e avalia uma função em cada elemento
    - função auxiliar `split` é útil ao ser utilizada em conjunto da `lapply`
- `sapply`: mesmo que o `lapply`, mas simplifica o resultado



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
- Podemos, por exemplo, também calcular os quantis de uma matriz usando a função `quantile()`

```r
x = matrix(1:50, 10, 5) # matriz 20x10 - 200 números ~ N(0, 1)
x
```

```
##       [,1] [,2] [,3] [,4] [,5]
##  [1,]    1   11   21   31   41
##  [2,]    2   12   22   32   42
##  [3,]    3   13   23   33   43
##  [4,]    4   14   24   34   44
##  [5,]    5   15   25   35   45
##  [6,]    6   16   26   36   46
##  [7,]    7   17   27   37   47
##  [8,]    8   18   28   38   48
##  [9,]    9   19   29   39   49
## [10,]   10   20   30   40   50
```

```r
apply(x, 2, quantile) # obtendo os quantis de cada coluna
```

```
##       [,1]  [,2]  [,3]  [,4]  [,5]
## 0%    1.00 11.00 21.00 31.00 41.00
## 25%   3.25 13.25 23.25 33.25 43.25
## 50%   5.50 15.50 25.50 35.50 45.50
## 75%   7.75 17.75 27.75 37.75 47.75
## 100% 10.00 20.00 30.00 40.00 50.00
```
- Com também podemos verificar quais são os valores únicos de cada variável em um data frame combinando `apply()` e `unique()`

```r
apply(mtcars, 2, unique)
```

```
## $mpg
##  [1] 21.0 22.8 21.4 18.7 18.1 14.3 24.4 19.2 17.8 16.4 17.3 15.2 10.4 14.7 32.4
## [16] 30.4 33.9 21.5 15.5 13.3 27.3 26.0 15.8 19.7 15.0
## 
## $cyl
## [1] 6 4 8
## 
## $disp
##  [1] 160.0 108.0 258.0 360.0 225.0 146.7 140.8 167.6 275.8 472.0 460.0 440.0
## [13]  78.7  75.7  71.1 120.1 318.0 304.0 350.0 400.0  79.0 120.3  95.1 351.0
## [25] 145.0 301.0 121.0
## 
## $hp
##  [1] 110  93 175 105 245  62  95 123 180 205 215 230  66  52  65  97 150  91 113
## [20] 264 335 109
## 
## $drat
##  [1] 3.90 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.07 2.93 3.00 3.23 4.08 4.93 4.22
## [16] 3.70 3.73 4.43 3.77 3.62 3.54 4.11
## 
## $wt
##  [1] 2.620 2.875 2.320 3.215 3.440 3.460 3.570 3.190 3.150 4.070 3.730 3.780
## [13] 5.250 5.424 5.345 2.200 1.615 1.835 2.465 3.520 3.435 3.840 3.845 1.935
## [25] 2.140 1.513 3.170 2.770 2.780
## 
## $qsec
##  [1] 16.46 17.02 18.61 19.44 20.22 15.84 20.00 22.90 18.30 18.90 17.40 17.60
## [13] 18.00 17.98 17.82 17.42 19.47 18.52 19.90 20.01 16.87 17.30 15.41 17.05
## [25] 16.70 16.90 14.50 15.50 14.60 18.60
## 
## $vs
## [1] 0 1
## 
## $am
## [1] 1 0
## 
## $gear
## [1] 4 3 5
## 
## $carb
## [1] 4 1 2 3 6 8
```


- Podemos verificar o **número de NA's** em cada coluna usando `apply()` com `sum` (ou também `colSums()`) na base de dados com `is.na()` (transforma a base de dados em TRUE/FALSE se for ou não `NA`)

```r
head( is.na(airquality) ) # 6 primeiras linhas aplicando is.na()
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
apply(is.na(airquality), 2, sum) # somando cada coluna de TRUE/FALSE
```

```
##   Ozone Solar.R    Wind    Temp   Month     Day 
##      37       7       0       0       0       0
```


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
# Criando uma lista com vetor de dimensões distintas
x = list(a=1:5, b=rnorm(10), c=c(1, 4, 65, 6))
x
```

```
## $a
## [1] 1 2 3 4 5
## 
## $b
##  [1]  0.18993857  0.35887312  0.05119241  0.64612554 -1.37369836 -0.41862369
##  [7]  0.41233772 -0.44974287  0.37252688 -2.41036847
## 
## $c
## [1]  1  4 65  6
```

```r
lapply(x, mean) # retorna médias de cada vetor dentro da lista
```

```
## $a
## [1] 3
## 
## $b
## [1] -0.2621439
## 
## $c
## [1] 19
```

```r
lapply(x, summary) # retorna 6 estatísticas de cada vetor dentro da lista
```

```
## $a
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       1       2       3       3       4       5 
## 
## $b
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -2.4104 -0.4420  0.1206 -0.2621  0.3691  0.6461 
## 
## $c
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    3.25    5.00   19.00   20.75   65.00
```

```r
class(lapply(x, mean)) # classe do objeto retornado pelo lapply
```

```
## [1] "list"
```


#### Função `sapply()`
Similar ao `lapply`, mas `sapply` tenta simplificar o output:

- Se o resultado for uma lista em que todo elemento tem comprimento 1 (tem apenas um elemento também), retorna um vetor

```r
sapply(x, mean) # retorna um vetor
```

```
##          a          b          c 
##  3.0000000 -0.2621439 19.0000000
```
- Se o resultado for uma lista em que cada elemento tem mesmo comprimento, retorna uma matriz

```r
sapply(x, summary) # retorna uma matriz
```

```
##         a          b     c
## Min.    1 -2.4103685  1.00
## 1st Qu. 2 -0.4419631  3.25
## Median  3  0.1205655  5.00
## Mean    3 -0.2621439 19.00
## 3rd Qu. 4  0.3691134 20.75
## Max.    5  0.6461255 65.00
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



{{< cta cta_text="👉 Seguir para Manipulação via `dplyr`" cta_link="../sec4" >}}
