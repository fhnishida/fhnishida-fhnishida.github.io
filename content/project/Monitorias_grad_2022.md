---
title: "Monitoria de Econometria I (REC2301/2022)"
author: "Fábio Nishida (fabio.nishida@usp.br)"
date: "2º semestre/2022"
output: rmdformats::robobook
# output: pdf_document
---






# Resumindo dados

## Funções básicas para resumir dados
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


## Família de funções _apply_
Veremos uma família de funções _apply_ que permitem executar comandos em loop de maneira compacta:
- `apply`: aplica uma função sobre as margens (linha ou coluna) de uma matrix/array
- `lapply`: loop sobre uma lista e avalia uma função em cada elemento
    - função auxiliar `split` é útil ao ser utilizada em conjunto da `lapply`
- `sapply`: mesmo que o `lapply`, mas simplifica o resultado



### Função `apply()`
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


### Função `lapply()`
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
##  [1]  0.26771152  0.51797493 -2.32565246  0.20868970 -1.32585530 -0.05622491
##  [7]  1.26870682 -2.47312792 -1.69598019  1.00283087
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
## [1] -0.4610927
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
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -2.47313 -1.60345  0.07623 -0.46109  0.45541  1.26871 
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


### Função `sapply()`
Similar ao `lapply`, mas `sapply` tenta simplificar o output:

- Se o resultado for uma lista em que todo elemento tem comprimento 1 (tem apenas um elemento também), retorna um vetor

```r
sapply(x, mean) # retorna um vetor
```

```
##          a          b          c 
##  3.0000000 -0.4610927 19.0000000
```
- Se o resultado for uma lista em que cada elemento tem mesmo comprimento, retorna uma matriz

```r
sapply(x, summary) # retorna uma matriz
```

```
##         a           b     c
## Min.    1 -2.47312792  1.00
## 1st Qu. 2 -1.60344897  3.25
## Median  3  0.07623239  5.00
## Mean    3 -0.46109269 19.00
## 3rd Qu. 4  0.45540908 20.75
## Max.    5  1.26870682 65.00
```



# Manipulação de dados

> “Between 30% to 80% of the data analysis task is spent on cleaning and understanding the data.” (Dasu \& Johnson, 2003)

## Extração de subconjuntos
- [Subsetting and sorting (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/aqd2Y/subsetting-and-sorting)
- Como exemplo, criaremos um _data frame_ com três variáveis, em que, para misturar a ordem dos números, usaremos a função `sample()` num vetor de números e também incluiremos alguns valores ausentes `NA`.

```r
set.seed(2022)

# Criando uma base de dados arbitrária
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
x$var1 <= 3
```

```
## [1] FALSE  TRUE  TRUE  TRUE FALSE
```

```r
x[x$var1 <= 3,] # Extraindo as linhas de x
```

```
##   var1 var2 var3
## 2    3    7   11
## 3    2   NA   12
## 4    1   10   15
```

```r
x$var1 <= 3 & x$var3 > 11
```

```
## [1] FALSE FALSE  TRUE  TRUE FALSE
```

```r
x[x$var1 <= 3 & x$var3 > 11,] # Extraindo as linhas de x
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


## Ordenação
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

## Inclusão de novas colunas/variáveis
- Para incluir novas variáveis, podemos usar `$<novo_nome_var>` e atribuir um vetor de mesmo tamanho (mesma quantidade de linhas):

```r
x$var4 = rnorm(5)
x
```

```
##   var1 var2 var3        var4
## 1    4   NA   13 -1.16252771
## 2    3    7   11  0.03637665
## 3    2   NA   12  1.04034378
## 4    1   10   15  0.17720563
## 5    5    6   14 -1.09296084
```

- [Algumas transformações comuns de variáveis (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/r6VHJ/creating-new-variables)

```r
abs(x$var4) # valor absoluto
```

```
## [1] 1.16252771 0.03637665 1.04034378 0.17720563 1.09296084
```

```r
sqrt(x$var4) # raiz quadrada
```

```
## Warning in sqrt(x$var4): NaNs produzidos
```

```
## [1]       NaN 0.1907266 1.0199724 0.4209580       NaN
```

```r
ceiling(x$var4) # valor inteiro acima
```

```
## [1] -1  1  2  1 -1
```

```r
floor(x$var4) # valor inteiro abaixo
```

```
## [1] -2  0  1  0 -2
```

```r
round(x$var4, digits=1) # arredondamento com 1 dígito
```

```
## [1] -1.2  0.0  1.0  0.2 -1.1
```

```r
cos(x$var4) # cosseno
```

```
## [1] 0.3970208 0.9993384 0.5059237 0.9843401 0.4598582
```

```r
sin(x$var4) # seno
```

```
## [1] -0.91780959  0.03636862  0.86257821  0.17627965 -0.88799237
```

```r
log(x$var4) # logaritmo natural
```

```
## Warning in log(x$var4): NaNs produzidos
```

```
## [1]         NaN -3.31382832  0.03955122 -1.73044448         NaN
```

```r
log10(x$var4) # logaritmo base 10
```

```
## Warning: NaNs produzidos
```

```
## [1]         NaN -1.43917735  0.01717688 -0.75152249         NaN
```

```r
exp(x$var4) # exponencial
```

```
## [1] 0.3126948 1.0370464 2.8301898 1.1938766 0.3352225
```



## Juntando bases de dados
### Acrescentando colunas e linhas via `cbind()` e `rbind()`

- Uma maneira de juntar o data frame com um vetor de mesmo tamanho é usando `cbind()`

```r
y = rnorm(5)
x = cbind(x, y)
x
```

```
##   var1 var2 var3        var4          y
## 1    4   NA   13 -1.16252771  1.5147431
## 2    3    7   11  0.03637665  2.8275563
## 3    2   NA   12  1.04034378  0.7507876
## 4    1   10   15  0.17720563  0.3521377
## 5    5    6   14 -1.09296084 -0.2394846
```
- Também podemos acrescentar linhas usando `rbind()`, desde que o vetor tenha a quantidade de elementos igual ao número de colunas (ou data frame a ser incluído tenha o mesmo número de colunas)

```r
z = rnorm(5)
x = rbind(x, z)
x
```

```
##        var1       var2       var3        var4           y
## 1  4.000000         NA 13.0000000 -1.16252771  1.51474310
## 2  3.000000  7.0000000 11.0000000  0.03637665  2.82755634
## 3  2.000000         NA 12.0000000  1.04034378  0.75078755
## 4  1.000000 10.0000000 15.0000000  0.17720563  0.35213771
## 5  5.000000  6.0000000 14.0000000 -1.09296084 -0.23948464
## 6 -1.491039  0.1253538  0.7226886 -0.14665985  0.06153939
```

### Mesclando base de dados com `merge()`
- [Merging data (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/pVV6K/merging-data)
- Podemos juntar base de dados a partir de uma variável-chave que aparece em ambas bases.
- Como exemplo, utilizaremos duas bases de dados de respostas a perguntas (`solutions`) e de correções feitas por seus pares (`reviews`).

```r
solutions = read.csv("https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv")
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
reviews = read.csv("https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv")
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


<center><img src="https://fhnishida.github.io/fearp/eco1/merge.webp"></center>


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




# Manipulação via `dplyr`
- [Vignette - Introduction to _dplyr_](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
- O pacote `dplyr` facilita a manipulação dos dados por meio de funções simples e computacionalmente eficientes
- As funções pode, ser organizadas em três categorias:
    - Colunas:
        - `select()`: seleciona (ou retira) as colunas do data frame
        - `rename()`: muda os nomes das colunas
        - `mutate()`: cria ou muda os valores nas colunas
    - Linhas:
        - `filter()`: seleciona linhas de acordo com valores das colunas
        - `arrange()`: organiza a ordem das linhas
    - Grupo de linhas:
        - `summarise()`: colapsa um grupo em uma única linha
- Nesta subseção, continuaremos utilizando a base de dados de Star Wars (`starwars`), utilizada na subseção anterior.
- Você irá notar que, ao usar essas funções, o data frame é transformado em um _tibble_ que é um formato mais eficiente para tratar dados tabulares, mas que funciona de forma igual a um data frame.


```r
library("dplyr")
```

```
## Warning: package 'dplyr' was built under R version 4.2.2
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
bd_sw = starwars # Dando novo nome para a base starwars
head(bd_sw)
```

```
## # A tibble: 6 × 14
##   name         height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##   <chr>         <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
## 1 Luke Skywal…    172    77 blond   fair    blue       19   male  mascu… Tatooi…
## 2 C-3PO           167    75 <NA>    gold    yellow    112   none  mascu… Tatooi…
## 3 R2-D2            96    32 <NA>    white,… red        33   none  mascu… Naboo  
## 4 Darth Vader     202   136 none    white   yellow     41.9 male  mascu… Tatooi…
## 5 Leia Organa     150    49 brown   light   brown      19   fema… femin… Aldera…
## 6 Owen Lars       178   120 brown,… light   blue       52   male  mascu… Tatooi…
## # … with 4 more variables: species <chr>, films <list>, vehicles <list>,
## #   starships <list>, and abbreviated variable names ¹​hair_color, ²​skin_color,
## #   ³​eye_color, ⁴​birth_year, ⁵​homeworld
```


## Filtre linhas com `filter()`
- Permite selecionar um subconjunto de linhas de um data frame
```yaml
filter(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: <data-masking> Expressions that return a logical value, and are defined in terms of the variables in .data. If multiple expressions are included, they are combined with the & operator. Only rows for which all conditions evaluate to TRUE are kept.
```
- 

```r
bd_sw1 = filter(bd_sw, species == "Human", height >= 100)
bd_sw1
```

```
## # A tibble: 31 × 14
##    name        height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##    <chr>        <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
##  1 Luke Skywa…    172    77 blond   fair    blue       19   male  mascu… Tatooi…
##  2 Darth Vader    202   136 none    white   yellow     41.9 male  mascu… Tatooi…
##  3 Leia Organa    150    49 brown   light   brown      19   fema… femin… Aldera…
##  4 Owen Lars      178   120 brown,… light   blue       52   male  mascu… Tatooi…
##  5 Beru White…    165    75 brown   light   blue       47   fema… femin… Tatooi…
##  6 Biggs Dark…    183    84 black   light   brown      24   male  mascu… Tatooi…
##  7 Obi-Wan Ke…    182    77 auburn… fair    blue-g…    57   male  mascu… Stewjon
##  8 Anakin Sky…    188    84 blond   fair    blue       41.9 male  mascu… Tatooi…
##  9 Wilhuff Ta…    180    NA auburn… fair    blue       64   male  mascu… Eriadu 
## 10 Han Solo       180    80 brown   fair    brown      29   male  mascu… Corell…
## # … with 21 more rows, 4 more variables: species <chr>, films <list>,
## #   vehicles <list>, starships <list>, and abbreviated variable names
## #   ¹​hair_color, ²​skin_color, ³​eye_color, ⁴​birth_year, ⁵​homeworld
```

```r
# Equivalente a:
bd_sw[bd_sw$species == "Human" & bd_sw$height >= 100, ]
```

```
## # A tibble: 39 × 14
##    name        height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##    <chr>        <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
##  1 Luke Skywa…    172    77 blond   fair    blue       19   male  mascu… Tatooi…
##  2 Darth Vader    202   136 none    white   yellow     41.9 male  mascu… Tatooi…
##  3 Leia Organa    150    49 brown   light   brown      19   fema… femin… Aldera…
##  4 Owen Lars      178   120 brown,… light   blue       52   male  mascu… Tatooi…
##  5 Beru White…    165    75 brown   light   blue       47   fema… femin… Tatooi…
##  6 Biggs Dark…    183    84 black   light   brown      24   male  mascu… Tatooi…
##  7 Obi-Wan Ke…    182    77 auburn… fair    blue-g…    57   male  mascu… Stewjon
##  8 Anakin Sky…    188    84 blond   fair    blue       41.9 male  mascu… Tatooi…
##  9 Wilhuff Ta…    180    NA auburn… fair    blue       64   male  mascu… Eriadu 
## 10 Han Solo       180    80 brown   fair    brown      29   male  mascu… Corell…
## # … with 29 more rows, 4 more variables: species <chr>, films <list>,
## #   vehicles <list>, starships <list>, and abbreviated variable names
## #   ¹​hair_color, ²​skin_color, ³​eye_color, ⁴​birth_year, ⁵​homeworld
```

## Organize linhas com `arrange()`
- Reordena as linhas a partir de um conjunto de nomes de coluna
```yaml
arrange(.data, ..., .by_group = FALSE)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
... : <data-masking> Variables, or functions of variables. Use desc() to sort a variable in descending order.
```
- Se for inserido mais de um nome de variável, organiza de acordo com a 1ª variável e, em caso de ter linhas com o mesmo valor na 1ª variável, ordena estas linhas de mesmo valor de acordo com a 2ª variável
- Para usar a ordem decrescente, temos a função `desc()`

```r
bd_sw2 = arrange(bd_sw1, height, desc(mass))
bd_sw2
```

```
## # A tibble: 31 × 14
##    name        height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##    <chr>        <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
##  1 Leia Organa    150    49 brown   light   brown        19 fema… femin… Aldera…
##  2 Mon Mothma     150    NA auburn  fair    blue         48 fema… femin… Chandr…
##  3 Cordé          157    NA brown   light   brown        NA fema… femin… Naboo  
##  4 Shmi Skywa…    163    NA black   fair    brown        72 fema… femin… Tatooi…
##  5 Beru White…    165    75 brown   light   blue         47 fema… femin… Tatooi…
##  6 Padmé Amid…    165    45 brown   light   brown        46 fema… femin… Naboo  
##  7 Dormé          165    NA brown   light   brown        NA fema… femin… Naboo  
##  8 Jocasta Nu     167    NA white   fair    blue         NA fema… femin… Corusc…
##  9 Wedge Anti…    170    77 brown   fair    hazel        21 male  mascu… Corell…
## 10 Palpatine      170    75 grey    pale    yellow       82 male  mascu… Naboo  
## # … with 21 more rows, 4 more variables: species <chr>, films <list>,
## #   vehicles <list>, starships <list>, and abbreviated variable names
## #   ¹​hair_color, ²​skin_color, ³​eye_color, ⁴​birth_year, ⁵​homeworld
```


## Selecione colunas com `select()`
- Seleciona colunas que são de interesse.
```yaml
select(.data, ...)

... : variables in a data frame
: for selecting a range of consecutive variables.
! for taking the complement of a set of variables.
c() for combining selections.
```
- Coloca-se os nomes das colunas desejadas para selecioná-las.
- Também é possível selecionar um intervalo de variáveis usando `var1:var2`
- Caso queira tirar apenas algumas colunas, basta informar o nome delas precedidas pelo sinal de subtração (`-var`)

```r
bd_sw3 = select(bd_sw2, name:eye_color, sex:species)
# equivalente: select(bd_sw2, -birth_year, -c(films:starships))
bd_sw3
```

```
## # A tibble: 31 × 10
##    name        height  mass hair_…¹ skin_…² eye_c…³ sex   gender homew…⁴ species
##    <chr>        <int> <dbl> <chr>   <chr>   <chr>   <chr> <chr>  <chr>   <chr>  
##  1 Leia Organa    150    49 brown   light   brown   fema… femin… Aldera… Human  
##  2 Mon Mothma     150    NA auburn  fair    blue    fema… femin… Chandr… Human  
##  3 Cordé          157    NA brown   light   brown   fema… femin… Naboo   Human  
##  4 Shmi Skywa…    163    NA black   fair    brown   fema… femin… Tatooi… Human  
##  5 Beru White…    165    75 brown   light   blue    fema… femin… Tatooi… Human  
##  6 Padmé Amid…    165    45 brown   light   brown   fema… femin… Naboo   Human  
##  7 Dormé          165    NA brown   light   brown   fema… femin… Naboo   Human  
##  8 Jocasta Nu     167    NA white   fair    blue    fema… femin… Corusc… Human  
##  9 Wedge Anti…    170    77 brown   fair    hazel   male  mascu… Corell… Human  
## 10 Palpatine      170    75 grey    pale    yellow  male  mascu… Naboo   Human  
## # … with 21 more rows, and abbreviated variable names ¹​hair_color, ²​skin_color,
## #   ³​eye_color, ⁴​homeworld
```
- Note que o `select()` pode não funcionar corretamente se o pacote `MASS` estiver ativo. Caso esteja, retire a seleção do pacote `MASS` no quadrante inferior/direito em 'Packages' (ou digite `detach("package:MASS", unload = TRUE)`)
- Uma outra forma de fazer a seleção de coluna é combinando com `starts_with()` e `ends_with()`, que resulta na seleção de colunas que se iniciam e terminam com um texto dado

```r
head( select(starwars, ends_with("color")) ) # colunas que terminam com color
```

```
## # A tibble: 6 × 3
##   hair_color  skin_color  eye_color
##   <chr>       <chr>       <chr>    
## 1 blond       fair        blue     
## 2 <NA>        gold        yellow   
## 3 <NA>        white, blue red      
## 4 none        white       yellow   
## 5 brown       light       brown    
## 6 brown, grey light       blue
```

```r
head( select(starwars, starts_with("s")) ) # colunas que iniciam com a letra "s"
```

```
## # A tibble: 6 × 4
##   skin_color  sex    species starships
##   <chr>       <chr>  <chr>   <list>   
## 1 fair        male   Human   <chr [2]>
## 2 gold        none   Droid   <chr [0]>
## 3 white, blue none   Droid   <chr [0]>
## 4 white       male   Human   <chr [1]>
## 5 light       female Human   <chr [0]>
## 6 light       male   Human   <chr [0]>
```

## Renomeie colunas com `rename()`
- Renomeia colunas usando `novo_nome = velho_nome`
```yaml
rename(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: For rename(): <tidy-select> Use new_name = old_name to rename selected variables.
```


```r
bd_sw4 = rename(bd_sw3,
                haircolor = hair_color,
                skincolor = skin_color, 
                eyecolor = eye_color)
bd_sw4
```

```
## # A tibble: 31 × 10
##    name        height  mass hairc…¹ skinc…² eyeco…³ sex   gender homew…⁴ species
##    <chr>        <int> <dbl> <chr>   <chr>   <chr>   <chr> <chr>  <chr>   <chr>  
##  1 Leia Organa    150    49 brown   light   brown   fema… femin… Aldera… Human  
##  2 Mon Mothma     150    NA auburn  fair    blue    fema… femin… Chandr… Human  
##  3 Cordé          157    NA brown   light   brown   fema… femin… Naboo   Human  
##  4 Shmi Skywa…    163    NA black   fair    brown   fema… femin… Tatooi… Human  
##  5 Beru White…    165    75 brown   light   blue    fema… femin… Tatooi… Human  
##  6 Padmé Amid…    165    45 brown   light   brown   fema… femin… Naboo   Human  
##  7 Dormé          165    NA brown   light   brown   fema… femin… Naboo   Human  
##  8 Jocasta Nu     167    NA white   fair    blue    fema… femin… Corusc… Human  
##  9 Wedge Anti…    170    77 brown   fair    hazel   male  mascu… Corell… Human  
## 10 Palpatine      170    75 grey    pale    yellow  male  mascu… Naboo   Human  
## # … with 21 more rows, and abbreviated variable names ¹​haircolor, ²​skincolor,
## #   ³​eyecolor, ⁴​homeworld
```


## Modifique/Adicione colunas com `mutate()`
- Modifica uma coluna se ela já existir
- Cria uma coluna se ela não existir
```yaml
mutate(.data, ...)

.data: A data frame, data frame extension (e.g. a tibble), or a lazy data frame (e.g. from dbplyr or dtplyr).
...	: <data-masking> Name-value pairs. The name gives the name of the column in the output. The value can be:
 - A vector of length 1, which will be recycled to the correct length.
 - A vector the same length as the current group (or the whole data frame if ungrouped).
 - NULL, to remove the column.
```

```r
bd_sw5 = mutate(bd_sw4,
                height = height/100, # transf cm p/ metro
                BMI = mass / height^2,
                dummy = 1 # se não for vetor, tudo fica igual
                )
bd_sw5 = select(bd_sw5, BMI, dummy, everything()) # facilitar
bd_sw5
```

```
## # A tibble: 31 × 12
##      BMI dummy name    height  mass hairc…¹ skinc…² eyeco…³ sex   gender homew…⁴
##    <dbl> <dbl> <chr>    <dbl> <dbl> <chr>   <chr>   <chr>   <chr> <chr>  <chr>  
##  1  21.8     1 Leia O…   1.5     49 brown   light   brown   fema… femin… Aldera…
##  2  NA       1 Mon Mo…   1.5     NA auburn  fair    blue    fema… femin… Chandr…
##  3  NA       1 Cordé     1.57    NA brown   light   brown   fema… femin… Naboo  
##  4  NA       1 Shmi S…   1.63    NA black   fair    brown   fema… femin… Tatooi…
##  5  27.5     1 Beru W…   1.65    75 brown   light   blue    fema… femin… Tatooi…
##  6  16.5     1 Padmé …   1.65    45 brown   light   brown   fema… femin… Naboo  
##  7  NA       1 Dormé     1.65    NA brown   light   brown   fema… femin… Naboo  
##  8  NA       1 Jocast…   1.67    NA white   fair    blue    fema… femin… Corusc…
##  9  26.6     1 Wedge …   1.7     77 brown   fair    hazel   male  mascu… Corell…
## 10  26.0     1 Palpat…   1.7     75 grey    pale    yellow  male  mascu… Naboo  
## # … with 21 more rows, 1 more variable: species <chr>, and abbreviated variable
## #   names ¹​haircolor, ²​skincolor, ³​eyecolor, ⁴​homeworld
```

## Operador Pipe `%>%`
- Note que todas as funções do pacote `dyplr` anteriores têm como 1º argumento a base de dados (`.data`), e isto não é por acaso.
- O operador pipe `%>%` joga um data frame (escrito à sua esquerda) no 1º argumento da função seguinte (à sua direita).

```r
filter(starwars, species=="Droid") # sem operador pipe
```

```
## # A tibble: 6 × 14
##   name   height  mass hair_color skin_color eye_c…¹ birth…² sex   gender homew…³
##   <chr>   <int> <dbl> <chr>      <chr>      <chr>     <dbl> <chr> <chr>  <chr>  
## 1 C-3PO     167    75 <NA>       gold       yellow      112 none  mascu… Tatooi…
## 2 R2-D2      96    32 <NA>       white, bl… red          33 none  mascu… Naboo  
## 3 R5-D4      97    32 <NA>       white, red red          NA none  mascu… Tatooi…
## 4 IG-88     200   140 none       metal      red          15 none  mascu… <NA>   
## 5 R4-P17     96    NA none       silver, r… red, b…      NA none  femin… <NA>   
## 6 BB8        NA    NA none       none       black        NA none  mascu… <NA>   
## # … with 4 more variables: species <chr>, films <list>, vehicles <list>,
## #   starships <list>, and abbreviated variable names ¹​eye_color, ²​birth_year,
## #   ³​homeworld
```

```r
starwars %>% filter(species=="Droid") # com operador pipe
```

```
## # A tibble: 6 × 14
##   name   height  mass hair_color skin_color eye_c…¹ birth…² sex   gender homew…³
##   <chr>   <int> <dbl> <chr>      <chr>      <chr>     <dbl> <chr> <chr>  <chr>  
## 1 C-3PO     167    75 <NA>       gold       yellow      112 none  mascu… Tatooi…
## 2 R2-D2      96    32 <NA>       white, bl… red          33 none  mascu… Naboo  
## 3 R5-D4      97    32 <NA>       white, red red          NA none  mascu… Tatooi…
## 4 IG-88     200   140 none       metal      red          15 none  mascu… <NA>   
## 5 R4-P17     96    NA none       silver, r… red, b…      NA none  femin… <NA>   
## 6 BB8        NA    NA none       none       black        NA none  mascu… <NA>   
## # … with 4 more variables: species <chr>, films <list>, vehicles <list>,
## #   starships <list>, and abbreviated variable names ¹​eye_color, ²​birth_year,
## #   ³​homeworld
```
- Observe que, ao usar o operador pipe, o 1º argumento com a base de dados não deve ser preenchida (já está sendo aplicada automaticamente via `%>%`).
- Note que, desde a subseção com a função `filter()` até `mutate()` fomos "acumulando" as alterações em novos data frames, ou seja, o último data frame `bd_sw5` é a base original `starwars` que foi alterada por `filter()`, `arrange()`, `select()`, `rename()` e `mutate()`.

```r
bd_sw1 = filter(starwars, species == "Human", height >= 100)
bd_sw2 = arrange(bd_sw1, height, desc(mass))
bd_sw3 = select(bd_sw2, name:eye_color, sex:species)
bd_sw4 = rename(bd_sw3,
                haircolor = hair_color,
                skincolor = skin_color, 
                eyecolor = eye_color)
bd_sw5 = mutate(bd_sw4,
                height = height/100,
                BMI = mass / height^2,
                dummy = 1
                )
bd_sw5 = select(bd_sw5, BMI, dummy, everything())
bd_sw5
```

```
## # A tibble: 31 × 12
##      BMI dummy name    height  mass hairc…¹ skinc…² eyeco…³ sex   gender homew…⁴
##    <dbl> <dbl> <chr>    <dbl> <dbl> <chr>   <chr>   <chr>   <chr> <chr>  <chr>  
##  1  21.8     1 Leia O…   1.5     49 brown   light   brown   fema… femin… Aldera…
##  2  NA       1 Mon Mo…   1.5     NA auburn  fair    blue    fema… femin… Chandr…
##  3  NA       1 Cordé     1.57    NA brown   light   brown   fema… femin… Naboo  
##  4  NA       1 Shmi S…   1.63    NA black   fair    brown   fema… femin… Tatooi…
##  5  27.5     1 Beru W…   1.65    75 brown   light   blue    fema… femin… Tatooi…
##  6  16.5     1 Padmé …   1.65    45 brown   light   brown   fema… femin… Naboo  
##  7  NA       1 Dormé     1.65    NA brown   light   brown   fema… femin… Naboo  
##  8  NA       1 Jocast…   1.67    NA white   fair    blue    fema… femin… Corusc…
##  9  26.6     1 Wedge …   1.7     77 brown   fair    hazel   male  mascu… Corell…
## 10  26.0     1 Palpat…   1.7     75 grey    pale    yellow  male  mascu… Naboo  
## # … with 21 more rows, 1 more variable: species <chr>, and abbreviated variable
## #   names ¹​haircolor, ²​skincolor, ³​eyecolor, ⁴​homeworld
```
- Usando o operador pipe `%>%` várias vezes, podemos ir pegando o output resultante da aplicação de uma função e jogar como input da função seguinte. Reescreveremos o código acima "em única linha" com `%>%`, chegando ao mesmo data frame de `bd_sw5`

```r
bd_sw_pipe = starwars %>% 
    filter(species == "Human", height >= 100) %>%
    arrange(height, desc(mass)) %>%
    select(name:eye_color, sex:species) %>%
    rename(haircolor = hair_color,
           skincolor = skin_color, 
           eyecolor = eye_color) %>%
    mutate(height = height/100,
           BMI = mass / height^2,
           dummy = 1
           ) %>%
    select(BMI, dummy, everything())
bd_sw_pipe
```

```
## # A tibble: 31 × 12
##      BMI dummy name    height  mass hairc…¹ skinc…² eyeco…³ sex   gender homew…⁴
##    <dbl> <dbl> <chr>    <dbl> <dbl> <chr>   <chr>   <chr>   <chr> <chr>  <chr>  
##  1  21.8     1 Leia O…   1.5     49 brown   light   brown   fema… femin… Aldera…
##  2  NA       1 Mon Mo…   1.5     NA auburn  fair    blue    fema… femin… Chandr…
##  3  NA       1 Cordé     1.57    NA brown   light   brown   fema… femin… Naboo  
##  4  NA       1 Shmi S…   1.63    NA black   fair    brown   fema… femin… Tatooi…
##  5  27.5     1 Beru W…   1.65    75 brown   light   blue    fema… femin… Tatooi…
##  6  16.5     1 Padmé …   1.65    45 brown   light   brown   fema… femin… Naboo  
##  7  NA       1 Dormé     1.65    NA brown   light   brown   fema… femin… Naboo  
##  8  NA       1 Jocast…   1.67    NA white   fair    blue    fema… femin… Corusc…
##  9  26.6     1 Wedge …   1.7     77 brown   fair    hazel   male  mascu… Corell…
## 10  26.0     1 Palpat…   1.7     75 grey    pale    yellow  male  mascu… Naboo  
## # … with 21 more rows, 1 more variable: species <chr>, and abbreviated variable
## #   names ¹​haircolor, ²​skincolor, ³​eyecolor, ⁴​homeworld
```

```r
all(bd_sw_pipe == bd_sw5, na.rm=TRUE) # verificando se todos elementos são iguais
```

```
## [1] TRUE
```

## Resuma com `summarise()`

- Podemos usar a função `summarise()` para gerar alguma estatística acerca de uma ou mais variáveis:

```r
starwars %>% summarise(
    n_obs = n(),
    mean_height = mean(height, na.rm=TRUE),
    mean_mass = mean(mass, na.rm=TRUE)
    )
```

```
## # A tibble: 1 × 3
##   n_obs mean_height mean_mass
##   <int>       <dbl>     <dbl>
## 1    87        174.      97.3
```
- No caso acima, gerou simplesmente o tamanho da amostra e as médias de altura e de massa considerando a amostra inteira de `starwars` (o que não foi muito útil).


## Agrupe com `group_by()`
- Diferente das outras funções do `dplyr` mostradas até agora, o output do `group_by` não altera conteúdo do data frame, apenas **transforma em uma base de dados agrupada** em categorias de uma dada variável

```r
grouped_sw = starwars %>% group_by(sex)
class(grouped_sw)
```

```
## [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"
```

```r
head(starwars)
```

```
## # A tibble: 6 × 14
##   name         height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##   <chr>         <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
## 1 Luke Skywal…    172    77 blond   fair    blue       19   male  mascu… Tatooi…
## 2 C-3PO           167    75 <NA>    gold    yellow    112   none  mascu… Tatooi…
## 3 R2-D2            96    32 <NA>    white,… red        33   none  mascu… Naboo  
## 4 Darth Vader     202   136 none    white   yellow     41.9 male  mascu… Tatooi…
## 5 Leia Organa     150    49 brown   light   brown      19   fema… femin… Aldera…
## 6 Owen Lars       178   120 brown,… light   blue       52   male  mascu… Tatooi…
## # … with 4 more variables: species <chr>, films <list>, vehicles <list>,
## #   starships <list>, and abbreviated variable names ¹​hair_color, ²​skin_color,
## #   ³​eye_color, ⁴​birth_year, ⁵​homeworld
```

```r
head(grouped_sw) # agrupado por sexo
```

```
## # A tibble: 6 × 14
## # Groups:   sex [3]
##   name         height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ sex   gender homew…⁵
##   <chr>         <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> <chr>  <chr>  
## 1 Luke Skywal…    172    77 blond   fair    blue       19   male  mascu… Tatooi…
## 2 C-3PO           167    75 <NA>    gold    yellow    112   none  mascu… Tatooi…
## 3 R2-D2            96    32 <NA>    white,… red        33   none  mascu… Naboo  
## 4 Darth Vader     202   136 none    white   yellow     41.9 male  mascu… Tatooi…
## 5 Leia Organa     150    49 brown   light   brown      19   fema… femin… Aldera…
## 6 Owen Lars       178   120 brown,… light   blue       52   male  mascu… Tatooi…
## # … with 4 more variables: species <chr>, films <list>, vehicles <list>,
## #   starships <list>, and abbreviated variable names ¹​hair_color, ²​skin_color,
## #   ³​eye_color, ⁴​birth_year, ⁵​homeworld
```
- O `group_by()` prepara o data frame para operações que consideram várias linhas. Como exemplo, vamos criar uma coluna com a soma de `mass` de todas observações

```r
starwars %>%
    mutate(mean_mass = mean(mass, na.rm=TRUE)) %>% 
    select(mean_mass, sex, everything()) %>%
    head(10)
```

```
## # A tibble: 10 × 15
##    mean_mass sex    name     height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ gender
##        <dbl> <chr>  <chr>     <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> 
##  1      97.3 male   Luke Sk…    172    77 blond   fair    blue       19   mascu…
##  2      97.3 none   C-3PO       167    75 <NA>    gold    yellow    112   mascu…
##  3      97.3 none   R2-D2        96    32 <NA>    white,… red        33   mascu…
##  4      97.3 male   Darth V…    202   136 none    white   yellow     41.9 mascu…
##  5      97.3 female Leia Or…    150    49 brown   light   brown      19   femin…
##  6      97.3 male   Owen La…    178   120 brown,… light   blue       52   mascu…
##  7      97.3 female Beru Wh…    165    75 brown   light   blue       47   femin…
##  8      97.3 none   R5-D4        97    32 <NA>    white,… red        NA   mascu…
##  9      97.3 male   Biggs D…    183    84 black   light   brown      24   mascu…
## 10      97.3 male   Obi-Wan…    182    77 auburn… fair    blue-g…    57   mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>, and abbreviated variable names
## #   ¹​hair_color, ²​skin_color, ³​eye_color, ⁴​birth_year
```
- Note que todos os valores de `mean_mass` são iguais. Agora, agruparemos por `sex` antes de fazer a soma:

```r
starwars %>%
    group_by(sex) %>%
    mutate(mean_mass = mean(mass, na.rm=TRUE)) %>% 
    ungroup() %>% # Lembre-se sempre de desagrupar depois!
    select(mean_mass, sex, everything()) %>%
    head(10)
```

```
## # A tibble: 10 × 15
##    mean_mass sex    name     height  mass hair_…¹ skin_…² eye_c…³ birth…⁴ gender
##        <dbl> <chr>  <chr>     <int> <dbl> <chr>   <chr>   <chr>     <dbl> <chr> 
##  1      81.0 male   Luke Sk…    172    77 blond   fair    blue       19   mascu…
##  2      69.8 none   C-3PO       167    75 <NA>    gold    yellow    112   mascu…
##  3      69.8 none   R2-D2        96    32 <NA>    white,… red        33   mascu…
##  4      81.0 male   Darth V…    202   136 none    white   yellow     41.9 mascu…
##  5      54.7 female Leia Or…    150    49 brown   light   brown      19   femin…
##  6      81.0 male   Owen La…    178   120 brown,… light   blue       52   mascu…
##  7      54.7 female Beru Wh…    165    75 brown   light   blue       47   femin…
##  8      69.8 none   R5-D4        97    32 <NA>    white,… red        NA   mascu…
##  9      81.0 male   Biggs D…    183    84 black   light   brown      24   mascu…
## 10      81.0 male   Obi-Wan…    182    77 auburn… fair    blue-g…    57   mascu…
## # … with 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>, and abbreviated variable names
## #   ¹​hair_color, ²​skin_color, ³​eye_color, ⁴​birth_year
```
- Note que, agora, a coluna `mean_mass` tem valores diferentes de acordo com o sexo da observação.
- Isso é útil em algumas aplicações econômicas em que consideramos variáveis a nível de grupo (e.g. domicílio) a qual uma observação (e.g. morador) pertence.

> **Evite potenciais erros**: Sempre que usar `group_by()`, não se esqueça de desagrupar o data frame via função `ungroup()` após realizar a operações desejadas.

## Resuma em grupos com `group_by()` e `summarise()`
- A função `summarise()` é de fato útil quando combinada com a função `group_by()`, pois conseguimos obter as estatísticas de grupos:

```r
summary_sw = starwars %>% group_by(sex) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE),
        mean_mass = mean(mass, na.rm = TRUE)
    )
summary_sw
```

```
## # A tibble: 5 × 4
##   sex            n_obs mean_height mean_mass
##   <chr>          <int>       <dbl>     <dbl>
## 1 female            16        169.      54.7
## 2 hermaphroditic     1        175     1358  
## 3 male              60        179.      81.0
## 4 none               6        131.      69.8
## 5 <NA>               4        181.      48
```

```r
class(summary_sw) # ao usar summary, deixa de ser agrupada
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```
- Note que, ao usar `summarise()`, o data frame resultante não é agrupado e, portanto, não é necessário usar `ungroup()` neste caso.
- Também é possível adicionar mais de uma variável para agrupar:

```r
starwars %>% group_by(sex, hair_color) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE),
        mean_mass = mean(mass, na.rm = TRUE)
    )
```

```
## `summarise()` has grouped output by 'sex'. You can override using the `.groups`
## argument.
```

```
## # A tibble: 23 × 5
## # Groups:   sex [5]
##    sex            hair_color    n_obs mean_height mean_mass
##    <chr>          <chr>         <int>       <dbl>     <dbl>
##  1 female         auburn            1        150      NaN  
##  2 female         black             3        166.      53.1
##  3 female         blonde            1        168       55  
##  4 female         brown             6        160.      56.3
##  5 female         none              4        188.      54  
##  6 female         white             1        167      NaN  
##  7 hermaphroditic <NA>              1        175     1358  
##  8 male           auburn, grey      1        180      NaN  
##  9 male           auburn, white     1        182       77  
## 10 male           black             9        176.      81.0
## # … with 13 more rows
```
- Para agrupar variáveis **contínuas**, precisamos definir intervalos usando a função `cut()`
```yaml
cut(x, ...)

x: a numeric vector which is to be converted to a factor by cutting.

breaks: either a numeric vector of two or more unique cut points or a single number (greater than or equal to 2) giving the number of intervals into which x is to be cut.
```

```r
# breaks com um integer = qtd desejada de grupos
starwars %>% group_by(cut(birth_year, breaks=5)) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE)
    )
```

```
## # A tibble: 5 × 3
##   `cut(birth_year, breaks = 5)` n_obs mean_height
##   <fct>                         <int>       <dbl>
## 1 (7.11,186]                       40        175.
## 2 (186,363]                         1        228 
## 3 (541,718]                         1        175 
## 4 (718,897]                         1         66 
## 5 <NA>                             44        176.
```

```r
# breaks com um vetor = quebras dos intervalos dos grupos
starwars %>% group_by(birth_year=cut(birth_year, 
                          breaks=c(0, 40, 90, 200, 900))) %>%
    summarise(
        n_obs = n(),
        mean_height = mean(height, na.rm = TRUE)
    )
```

```
## # A tibble: 5 × 3
##   birth_year n_obs mean_height
##   <fct>      <int>       <dbl>
## 1 (0,40]        13        164.
## 2 (40,90]       22        179.
## 3 (90,200]       6        192.
## 4 (200,900]      2        120.
## 5 <NA>          44        176.
```
- Note que inserimos `birth_year=cut(birth_year, ...)` para que o nome da coluna ficasse `birth_year`, caso contrário a coluna ficaria com o nome `cut(birth_year, ...)`.


## Junte bases de dados com funções _join_
- Vimos anteriormente que podemos usar o `cbind()` juntar um data frame com outro data frame (ou vetor), caso tenham o mesmo número de linhas
- Para juntar linhas (considerando que as colunas possuem as mesmas classes de variáveis), podemos usar o `rbind`
- Para agrupar bases de dados a partir de variáveis-chave, usamos a função `merge()`.
- O pacote `dplyr` fornece uma família de funções _join_ que executam o mesmo comando que `merge()`, porém, ao invés de alterar o valor de um argumento, você precisa escolher uma das funções _join_ que podem ser resumidas na seguinte figura:


<center><img src="https://fhnishida.github.io/fearp/eco1/dplyr-data-join-functions.png"></center>

- Todas as funções possuem a mesma sintaxe:
    - `x`: base 1
    - `y`: base 2
    - `by`: vetor de variáveis-chave
    - `suffix`: vetor de 2 sufixos para incluir em colunas de mesmos nomes
- Como exemplo, usaremos subconjuntos da base de dados `starwars`:

```r
bd1 = starwars[1:6, c(1, 3, 11)]
bd2 = starwars[c(2, 4, 7:10), c(1:2, 6)]
bd1
```

```
## # A tibble: 6 × 3
##   name            mass species
##   <chr>          <dbl> <chr>  
## 1 Luke Skywalker    77 Human  
## 2 C-3PO             75 Droid  
## 3 R2-D2             32 Droid  
## 4 Darth Vader      136 Human  
## 5 Leia Organa       49 Human  
## 6 Owen Lars        120 Human
```

```r
bd2
```

```
## # A tibble: 6 × 3
##   name               height eye_color
##   <chr>               <int> <chr>    
## 1 C-3PO                 167 yellow   
## 2 Darth Vader           202 yellow   
## 3 Beru Whitesun lars    165 blue     
## 4 R5-D4                  97 red      
## 5 Biggs Darklighter     183 brown    
## 6 Obi-Wan Kenobi        182 blue-gray
```
- Note que há 12 personagens únicos em ambas bases, mas apenas "C-3PO" e "Darth Vader" são observações comuns.
- `inner_join()`: mantém apenas ID's presentes simultaneamente em ambas bases

```r
inner_join(bd1, bd2, by="name")
```

```
## # A tibble: 2 × 5
##   name         mass species height eye_color
##   <chr>       <dbl> <chr>    <int> <chr>    
## 1 C-3PO          75 Droid      167 yellow   
## 2 Darth Vader   136 Human      202 yellow
```

- `full_join()`: mantém todas ID's, mesmo que estejam em apenas em um das bases

```r
full_join(bd1, bd2, by="name")
```

```
## # A tibble: 10 × 5
##    name                mass species height eye_color
##    <chr>              <dbl> <chr>    <int> <chr>    
##  1 Luke Skywalker        77 Human       NA <NA>     
##  2 C-3PO                 75 Droid      167 yellow   
##  3 R2-D2                 32 Droid       NA <NA>     
##  4 Darth Vader          136 Human      202 yellow   
##  5 Leia Organa           49 Human       NA <NA>     
##  6 Owen Lars            120 Human       NA <NA>     
##  7 Beru Whitesun lars    NA <NA>       165 blue     
##  8 R5-D4                 NA <NA>        97 red      
##  9 Biggs Darklighter     NA <NA>       183 brown    
## 10 Obi-Wan Kenobi        NA <NA>       182 blue-gray
```
- `left_join()`: mantém apenas ID's presentes na base 1 (informada como `x`)

```r
left_join(bd1, bd2, by="name")
```

```
## # A tibble: 6 × 5
##   name            mass species height eye_color
##   <chr>          <dbl> <chr>    <int> <chr>    
## 1 Luke Skywalker    77 Human       NA <NA>     
## 2 C-3PO             75 Droid      167 yellow   
## 3 R2-D2             32 Droid       NA <NA>     
## 4 Darth Vader      136 Human      202 yellow   
## 5 Leia Organa       49 Human       NA <NA>     
## 6 Owen Lars        120 Human       NA <NA>
```
- `right_join()`: mantém apenas ID's presentes na base 2 (informada como `y`)

```r
right_join(bd1, bd2, by="name")
```

```
## # A tibble: 6 × 5
##   name                mass species height eye_color
##   <chr>              <dbl> <chr>    <int> <chr>    
## 1 C-3PO                 75 Droid      167 yellow   
## 2 Darth Vader          136 Human      202 yellow   
## 3 Beru Whitesun lars    NA <NA>       165 blue     
## 4 R5-D4                 NA <NA>        97 red      
## 5 Biggs Darklighter     NA <NA>       183 brown    
## 6 Obi-Wan Kenobi        NA <NA>       182 blue-gray
```

- Note que podemos incluir mais de uma variável-chave para correspondência entre ID's de ambas bases. Primeiro, vamos construir as bases como paineis

```r
bd1 = starwars[1:5, c(1, 3)]
bd1 = rbind(bd1, bd1) %>%
    mutate(year = c(rep(2021, 5), rep(2022, 5)),
           # Se não for ano 2021, multiplica por um número aleatório ~ N(1, 0.025)
           mass = ifelse(year == 2021, mass, mass*rnorm(10, 1, 0.025))) %>%
    select(name, year, mass) %>%
    arrange(name, year)
bd1
```

```
## # A tibble: 10 × 3
##    name            year  mass
##    <chr>          <dbl> <dbl>
##  1 C-3PO           2021  75  
##  2 C-3PO           2022  74.7
##  3 Darth Vader     2021 136  
##  4 Darth Vader     2022 136. 
##  5 Leia Organa     2021  49  
##  6 Leia Organa     2022  50.1
##  7 Luke Skywalker  2021  77  
##  8 Luke Skywalker  2022  77.4
##  9 R2-D2           2021  32  
## 10 R2-D2           2022  31.1
```

```r
bd2 = starwars[c(2, 4, 7:9), 1:2]
bd2 = rbind(bd2, bd2) %>%
    mutate(year = c(rep(2021, 5), rep(2022, 5)),
           # Se não for ano 2021, altura cresce 2%
           height = ifelse(year == 2021, height, height*1.02)) %>%
    select(name, year, height) %>%
    arrange(name, year)
bd2
```

```
## # A tibble: 10 × 3
##    name                year height
##    <chr>              <dbl>  <dbl>
##  1 Beru Whitesun lars  2021  165  
##  2 Beru Whitesun lars  2022  168. 
##  3 Biggs Darklighter   2021  183  
##  4 Biggs Darklighter   2022  187. 
##  5 C-3PO               2021  167  
##  6 C-3PO               2022  170. 
##  7 Darth Vader         2021  202  
##  8 Darth Vader         2022  206. 
##  9 R5-D4               2021   97  
## 10 R5-D4               2022   98.9
```
- Note agora que, para cada personagem, temos 2 linhas que correspondem aos dois anos (2021 e 2022). Faremos um `full_join()` considerando como variáveis-chave ambos `name` e `year`.

```r
# Juntando as bases
full_join(bd1, bd2, by=c("name", "year"))
```

```
## # A tibble: 16 × 4
##    name                year  mass height
##    <chr>              <dbl> <dbl>  <dbl>
##  1 C-3PO               2021  75    167  
##  2 C-3PO               2022  74.7  170. 
##  3 Darth Vader         2021 136    202  
##  4 Darth Vader         2022 136.   206. 
##  5 Leia Organa         2021  49     NA  
##  6 Leia Organa         2022  50.1   NA  
##  7 Luke Skywalker      2021  77     NA  
##  8 Luke Skywalker      2022  77.4   NA  
##  9 R2-D2               2021  32     NA  
## 10 R2-D2               2022  31.1   NA  
## 11 Beru Whitesun lars  2021  NA    165  
## 12 Beru Whitesun lars  2022  NA    168. 
## 13 Biggs Darklighter   2021  NA    183  
## 14 Biggs Darklighter   2022  NA    187. 
## 15 R5-D4               2021  NA     97  
## 16 R5-D4               2022  NA     98.9
```
- Atente-se também aos nomes das variáveis, pois ao juntar bases com variáveis de mesmos nomes (que não são usadas como chave), a função acaba incluindo ambas variáveis renomeadas, por padrão, com sufixos `.x` e `.y` (sufixos podem ser alterados pelo argumento `suffix`)

```r
bd2 = bd2 %>% mutate(mass = rnorm(10)) # Criando uma variável mass

full_join(bd1, bd2, by=c("name", "year"))
```

```
## # A tibble: 16 × 5
##    name                year mass.x height  mass.y
##    <chr>              <dbl>  <dbl>  <dbl>   <dbl>
##  1 C-3PO               2021   75    167    0.774 
##  2 C-3PO               2022   74.7  170.  -1.48  
##  3 Darth Vader         2021  136    202    0.655 
##  4 Darth Vader         2022  136.   206.  -0.0482
##  5 Leia Organa         2021   49     NA   NA     
##  6 Leia Organa         2022   50.1   NA   NA     
##  7 Luke Skywalker      2021   77     NA   NA     
##  8 Luke Skywalker      2022   77.4   NA   NA     
##  9 R2-D2               2021   32     NA   NA     
## 10 R2-D2               2022   31.1   NA   NA     
## 11 Beru Whitesun lars  2021   NA    165    0.965 
## 12 Beru Whitesun lars  2022   NA    168.  -0.104 
## 13 Biggs Darklighter   2021   NA    183    0.237 
## 14 Biggs Darklighter   2022   NA    187.   1.11  
## 15 R5-D4               2021   NA     97   -0.242 
## 16 R5-D4               2022   NA     98.9  0.641
```


# Gráficos
- [Exploratory graphs - Part 1 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/ilRAK/exploratory-graphs-part-1)
- [Base plotting system - Part 2 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/m4P1I/base-plotting-system-part-2)
- [Base plotting demonstration (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/yUFDH/base-plotting-demonstration)


- [Aplicações R Base (The R Graph Gallery)](https://r-graph-gallery.com/base-R.html)
- Objetivos dos gráficos em análise de dados:
    1. Entender as propriedades dos dados
    2. Encontrar padrões nos dados
    3. Sugerir estratégias de modelagem
    4. Analisar "bugs"
    5. Comunicar resultados

## Gráficos para Análise Exploratória de Dados (EDA)
- Os gráficos para análise exploratória abrangem os 4 primeiros objetivos, ou seja, não são para comunicar um resultado final do seu trabalho.
- Características:
    1. Feitas rapidamente e em grande quantidade
    2. O objetivo é o entendimento dos dados
    3. Eixos/legendas normalmente são retiradas
    4. Cores/tamanhos são primariamente usadas para informação
- Principais gráficos simples:
    a. Diagrama de caixa (_Boxplot_)
    b. Histogramas
    c. Gráfico de barra (_Barplot_)
    d. Gráfico de dispersão (_Scatterplot_)

Como exemplo, usaremos dados da Agência de Proteção Ambiental dos EUA (EPA), [avgpm25.csv](https://fhnishida.github.io/fearp/eco1/avgpm25.csv), que informa a quantidade de poluição por partícula fina (PM2.5). A média anual de PM2.5 que não pode exceder 12 `\(\mu g/m^3\)`.


```r
library(dplyr)
pollution = read.csv("https://fhnishida.github.io/fearp/eco1/avgpm25.csv")
summary(pollution)
```

```
##       pm25             fips          region            longitude      
##  Min.   : 3.383   Min.   : 1003   Length:576         Min.   :-158.04  
##  1st Qu.: 8.549   1st Qu.:16038   Class :character   1st Qu.: -97.38  
##  Median :10.047   Median :28034   Mode  :character   Median : -87.37  
##  Mean   : 9.836   Mean   :28431                      Mean   : -91.65  
##  3rd Qu.:11.356   3rd Qu.:41045                      3rd Qu.: -80.72  
##  Max.   :18.441   Max.   :56039                      Max.   : -68.26  
##     latitude    
##  Min.   :19.68  
##  1st Qu.:35.30  
##  Median :39.09  
##  Mean   :38.56  
##  3rd Qu.:41.75  
##  Max.   :64.82
```

### Diagrama de caixa (_Boxplot_)
- Apresenta mínimo, máximo, os quartis e outliers.

```r
boxplot(pollution$pm25, col="blue")
abline(h=12, col="red") # Linha horizontal no valor 12
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-63-1.png" width="672" />
- Para múltiplos boxplots, usamos `<variável_numérica> ~ <variável categórica>`:


```r
boxplot(pollution$pm25 ~ pollution$region, col="blue")
abline(h=12, col="red") # Linha horizontal no valor 12
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-64-1.png" width="672" />



### Histograma

```r
hist(pollution$pm25, col="green")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-65-1.png" width="672" />

```r
hist(pollution$pm25, col="green", breaks=100) # 100 quebras
rug(pollution$pm25) # Traços dos valores da amostra abaixo do histograma 
abline(v=12, col="red") # Linha vertical no valor 12
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-65-2.png" width="672" />
- Podemos colocar mais de um gráfico numa figura usando a função `par(mfrow, mar)`:

```r
par(mfrow=c(2, 1), mar=c(4, 4, 2, 1)) # Criando figura com 2 linhas e 1 coluna + margens

pol_west = pollution %>% filter(region == "west")
pol_east = pollution %>% filter(region == "east")

hist(pol_west$pm25, col="green")
hist(pol_east$pm25, col="green")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-66-1.png" width="672" />

- Note que você precisa usar `par(mfrow=c(1, 1))` para voltar a incluir apenas 1 gráfico na figura. 


### Gráfico de barra (_Barplot_)

```r
barplot(table(pollution$region), col="wheat",
        main="Nº de países em cada região")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-67-1.png" width="672" />



### Gráfico de dispersão (_Scatterplot_)
- Gera gráficos sob 2 dimensões

```r
plot(pollution$latitude, pollution$pm25)
abline(h=12, lwd=1.5, lty=2, col="red")
abline(lm(pm25 ~ latitude, data=pollution), col="blue")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-68-1.png" width="672" />


```r
par(mfrow=c(1, 2), mar=c(4, 4, 2, 1)) # Criando figura com 1 linha e 2 colunas + margens

plot(pol_west$latitude, pol_west$pm25, main="West")
plot(pol_east$latitude, pol_east$pm25, main="East")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-69-1.png" width="672" />

- Também é possível adicionar objetos gráficos e textos no gráfico gerado por `plot()`:
    - `abline()`: adiciona linhas horizontal, vertical ou de regressão
    - `points()`: adiciona pontos ao gráfico
    - `lines()`: adiciona linhas ao gráfico
    - `text()`: adiciona texto ao gráfico
    - `title()`: adiciona anotações aos eixos, título, subtítulo e margem exterior
    - `mtext()`: adiciona texto às margens (interna e externa) do gráfico
    - `axis()`: adiciona traços/rótulos aos eixos


```r
par(mfrow=c(1, 1)) # Retornando ao padrão

air_may = airquality %>% filter(Month==5)
air_other = airquality %>% filter(Month!=5)

plot(airquality$Wind, airquality$Ozone, main="Ozone and Wind in NYC")
points(air_may$Wind, air_may$Ozone, col="blue")
points(air_other$Wind, air_other$Ozone, col="red")
legend("topright", pch=1, col=c("blue", "red"), legend=c("May", "Other Months"))
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-70-1.png" width="672" />


Alguns parâmetros gráficos importantes:

- `pch`: símbolo dos pontos gráficos (padrão é círculo)
- `lty`: tipo da linha (padrão é linha sólida, mais pode ser pontilhado, etc.)
- `lwd`: grossura da linha (integer)
- `col`: cor, especificada como número, texto ou código hex (função `colors()` dá um vetor de cores por nome)
- `xlab`: rótulo do eixo x
- `ylab`: rótulo do eixo y
- `par()`: função que especifica parâmetros *globais* que afetam todas figuras:
    - `las`: orientação dos rótulos 
    - `bg`: cor de fundo
    - `mar`: tamanho da margem
    - `oma`: tamanho da margem externa (padrão é 0)
    - `mfrow`: número de gráficos por linha
    - `mfcol`: número de gráficos por coluna



## Grammar of Graphics (pacote `ggplot2`)
- [_ggplot2_ - Part 3 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/idcsq/ggplot2-part-3)
- [_ggplot2_ - Part 4 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/cj6RA/ggplot2-part-4)
- [_ggplot2_ Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf)
- [Aplicações _ggplot2_ (The R Graph Gallery)](https://r-graph-gallery.com/ggplot2-package.html)

<!-- > ``In brief, the grammar tells us that a statistical graphic is a **mapping** from data to **aesthetic** attributes (colour, shape, size) of **geometric** objects (points, lines, bars). The plot may also contain statistical transformations of the data and is drawn on a specific coordinate system'' (from _ggplot2_ book) -->

- Componentes básicos do `ggplot2`:
    - um **data frame**
    - estética (**aesthetics**): como os dados são mapeados (tamanho, forma, cor)
    - objetos geométricos (**geoms**): pontos, linhas, formas
    - **facets**: para gráficos condicionais
- Ao invés de criar um gráfico diretamente, os gráficos do `ggplot2` são construídos em camadas (layers)


1. Data Frame

```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

2. Base do Gráfico (`ggplot()`)
    - dados que serão incluídos no gráfico
    - toda vez que for incluir uma variável, é necessário precisa usar a função `aes()` sobre elas

```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 4.2.2
```

```r
g = ggplot(data=mtcars, aes(mpg, wt)) # Criando a base do gráfico
g
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-72-1.png" width="672" />

3. Layer geomético (`geom`)
    - incluindos formas, linhas e pontos
    - caso não sejam informadas novas variáveis, a função para criar um objeto geométrico irá usar as variáveis-base definidas na função `ggplot()` inicial
    - Junta-se a base do gráfico com outras layers usando o sinal `+`

```r
g + geom_point()
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-73-1.png" width="672" />

4. Layer de suavização/tendência (`smooth`)
```yaml
geom_smooth(
  mapping = NULL, data = NULL, ...,
  method = NULL, formula = NULL, se = TRUE, level = 0.95
)

mapping: Set of aesthetic mappings created by aes() or aes_(). If specified and inherit.aes = TRUE (the default), it is combined with the default mapping at the top level of the plot. You must supply mapping if there is no plot mapping.
data: The data to be displayed in this layer. If NULL, the default, the data is inherited from the plot data as specified in the call to ggplot().
method: Smoothing method (function) to use, accepts either NULL or a character vector, e.g. "lm", "glm", "gam", "loess" or a function (...).
formula: Formula to use in smoothing function, eg. y ~ x, y ~ poly(x, 2), y ~ log(x).
se: Display confidence interval around smooth? (TRUE by default, see level to control.)
level: Level of confidence interval to use (0.95 by default).
```


```r
g + geom_point() + geom_smooth(method="lm") # suavização a partir de MQO
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-74-1.png" width="672" />



5. Layers condicionais
Facets (usar `cyl`)


```r
g + geom_point() + geom_smooth(method="lm") + facet_grid(. ~ cyl) # agrupando por nº cilindros horizontalmente
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-75-1.png" width="672" />

```r
g + geom_point() + geom_smooth(method="lm") + facet_grid(cyl ~ .) # agrupando por nº cilindros verticalmente
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-75-2.png" width="672" />

6. Anotações
    - Rótulos: `xlab()`, `ylab()`, `labs()`, `ggtitle()`
    - Cada _geom_ tem opções para modificar, mas use `theme()` para opções globais do gráfico. Use `?theme` e veja a quantidade de configurações você pode fazer no seu gráfico.
    - Se quiser temas pré-definidos, há 2 templates padrão `theme_gray()` e `theme_bw()` (preto/branco). Também é possível usar outros usando o pacote `ggthemes`.

```r
g + geom_point() + ggthemes::theme_economist() + 
    ylab("Peso (libras)") + xlab("Milhas por galão") +
    ggtitle("Milhas por galão X Peso do carro")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-76-1.png" width="672" />


7. Modificando Estética
    - Dentro de cada _geom_, podemos definir a cor (`color`), o tamanho (`size`) e a transparência (`alpha`)

```r
g + geom_point(color="steelblue", size=9, alpha=0.4)
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-77-1.png" width="672" />

```r
g + geom_point(aes(color=cyl), size=9, alpha=0.4) # colorindo por variável - precisa usar aes()
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-77-2.png" width="672" />


# ECONOMETRIA ============

- A parte de Econometria no R é baseada no livro de Florian Heiss "Using R for Introductory Econometrics" (2ª edição, 2020)
    - Aplicar no R o conteúdo e os exemplos do livro do Wooldridge de 2019 (versão em inglês)
    - É possível ler gratuitamente a versão online em: <http://www.urfie.net>
    - Há também uma versão de Python do livro em: <http://www.upfie.net>
- A base de dados dos exemplos contidos no livro do Wooldridge podem ser obtidos por meio da instalação e do carregamento do pacote `wooldridge`:

```r
# install.packages("wooldridge")
library(wooldridge)
```

```
## Warning: package 'wooldridge' was built under R version 4.2.2
```



# Distribuições
- [Seção 1.7 de Heiss (2020)](http://www.urfie.net/read/index.html#page/65)
- [Probability Distributions in R (Examples): PDF, CDF & Quantile Function (Statistics Globe)](https://statisticsglobe.com/probability-distributions-in-r)
- [Basic Probability Distributions in R (Greg Graham)](https://rstudio-pubs-static.s3.amazonaws.com/100906_8e3a32dd11c14b839468db756cee7400.html)


- As funções relacionadas a distribuições são dadas por `<prefixo><nome da distribuição>`
- Existem 4 prefixos que indicam qual ação será realizada:
    - `d`: retorna uma probabilidade a partir de uma função de densidade de probabilidade (fdp)
    - `p`: retorna uma probabilidade acumulada a partir de uma função de distribuição acumulada (fda)
    - `q`: retorna uma estatística da distribuição (quantil) dada uma probabilidade acumulada
    - `r`: gera números aleatórios dada a distribuição
- Existem diversas distribuições disponíveis no R:
    - `norm`: Normal
    - `bern`: Bernoulli (pacote `Rlab`)
    - `binom`: Binomial
    - `pois`: Poisson
    - `chisq`: Qui-Quadrado ($\chi^2$)
    - `t`: t-Student
    - `f`: F
    - `unif`: Uniforme
    - `weibull`: Weibull
    - `gamma`: Gamma
    - `logis`: Logística
    - `exp`: Exponencial
- Seguem as principais distribuições e suas respectivas funções:

| **Distribuição**   | **Densidade de Probabilidade** | **Distribuição Acumulada** | **Quantil**             |
|--------------------|--------------------------------|----------------------------|-------------------------|
| Normal             | `dnorm(x, mean, sd)`           | `pnorm(q, mean, sd)`       | `qnorm(p, mean, sd)`    |
| Qui-Quadrado       | `dchisq(x, df)`                | `pchisq(q, df)`            | `qchisq(p, df)`         |
| t-Student          | `dt(x, df)`                    | `pt(q, df)`                | `qt(p, df)`             |
| F                  | `df(x, df1, df2)`              | `pf(q, df1, df2)`          | `qf(p, df1, df2)`       |
| Binomial           | `dbinom(x, size, prob)`        | `pbinom(q, size, prob)`    | `qbinom(p, size, prob)` |

em que `x` e `q` são estatísticas de cada distribuição (quantis), e `p` é probabilidade.


## Distribuição Normal
- Considere uma normal padrão, `\(N(\mu=0, \sigma=1)\)`, e escores padrão `\(Z=-1,96 \text{ e } 1,96\)` (para intervalo de confiança de `\(\approx 5\%\)`):


<center><img src="https://spss-tutorials.com/img/standard-normal-distribution-with-critical-values.png"></center>

- [`d`]: Densidade a partir de uma fdp, dada estatística (escore padrão):

```r
dnorm(1.96, mean=0, sd=1) # probabilidade para escore padrão de 1,96
```

```
## [1] 0.05844094
```

```r
dnorm(-1.96, mean=0, sd=1) # probabilidade para escore padrão de -1,96
```

```
## [1] 0.05844094
```

- [`p`]: Probabilidade acumulada a partir de uma fda, dada estatística (escore padrão):

```r
pnorm(1.96, mean=0, sd=1) # probabilidade acumulada para escore padrão de 1,96
```

```
## [1] 0.9750021
```

```r
pnorm(-1.96, mean=0, sd=1) # probabilidade acumulada para escore padrão de -1,96
```

```
## [1] 0.0249979
```

Logo, a probabilidade de que uma variável aleatória com distribuição normal padrão esteja com valor entre -1,96 e 1,96 é de 95\%

```r
pnorm(1.96, mean=0, sd=1) - pnorm(-1.96, mean=0, sd=1)
```

```
## [1] 0.9500042
```


- [`q`]: Estatística (escore padrão) a partir de um quantil:

```r
qnorm(0.975, mean=0, sd=1) # quantil dada o quantil de 97,5%
```

```
## [1] 1.959964
```

```r
qnorm(0.025, mean=0, sd=1) # quantil dada o quantil de 2,5%
```

```
## [1] -1.959964
```

Podemos criar gráficos usando a função `curve( function(x), from, to )`, na qual inserimos uma função com um `x` arbitrário e seus limites mínimo e máximo (`from` e `to`):

```r
# pdf de normal padrão com estatística (escore padrão) no intervalo -3 e 3
curve(dnorm(x, mean=0, sd=1), from=-3, to=3)
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-84-1.png" width="672" />

```r
# cdf de normal padrão com estatística (escore padrão) no intervalo -3 e 3
curve(pnorm(x, mean=0, sd=1), from=-3, to=3)
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-84-2.png" width="672" />

```r
# quantil de normal padrão com probabilidade acumulada no intervalo 0 e 1
curve(qnorm(x, mean=0, sd=1), from=0, to=1)
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-84-3.png" width="672" />


## Distribuição t-Student
- Criaremos gráficos com diversos graus de liberdade
- Quanto maior os graus de liberdade, mais se aproxima de uma normal padrão


```r
curve(dnorm(x, mean=0, sd=1), from=-3, to=3, pch=".") # fdp normal padrão

for (n in c(10, 5, 3, 2)) {
    curve(dt(x, df=n), from=-3, to=3, col=n, add=T) # fdp t-student
}
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-85-1.png" width="672" />



# Simulação

## Amostragem aleatória
- [Simulation - Random sampling (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/ykXUb/simulation-random-sampling)
- Para fazer uma amostragem a partir de um dado vetor, usamos a função `sample()`
```yaml
sample(x, size, replace = FALSE, prob = NULL)

x: either a vector of one or more elements from which to choose, or a positive integer. See ‘Details.’
n: a positive number, the number of items to choose from.
size: a non-negative integer giving the number of items to choose.
replace: should sampling be with replacement?
prob: a vector of probability weights for obtaining the elements of the vector being sampled.
```

```r
sample(letters, 5) # Amostragem de 5 letras
```

```
## [1] "l" "e" "p" "j" "s"
```

```r
sample(1:10, 4) # Amostragem de 4 números de 1 a 10
```

```
## [1] 2 8 9 1
```

```r
sample(1:10) # Permutação (amostra mesma qtd de elementos do vetor)
```

```
##  [1]  2  5  9  6  7  1 10  3  8  4
```

```r
sample(1:10, replace = TRUE) # Amostragem com reposição
```

```
##  [1]  8 10  1  7  9  9  3  3  4  3
```
- Note que, por padrão, a função `sample()` faz a amostragem sem reposição.


### Visualizando a Lei dos Grandes Números (LGN)
- Podemos usar a amostragem para simular jogadas de dado não viesado.
- Vamos jogar uma vez o dado:

```r
sample(1:6, 1) # amostra um número dentro do vetor 1:6
```

```
## [1] 6
```
- Vamos jogar 500 vezes o dado (usando função `replicate()`) e verificar sua distribuição:

```r
amostra = replicate(500, expr=sample(1:6, 1))
table(amostra) # tabela com contagem das jogadas
```

```
## amostra
##  1  2  3  4  5  6 
## 89 93 91 65 82 80
```

```r
# Gráfico
plot(table(amostra), type="h")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-88-1.png" width="672" />
- Note que não podemos usar a função `rep()` com simulação, pois ele sortearia um número e replicaria esse mesmo número 500 vezes.
- Agora, vamos jogar 2 vezes o dado e fazer a média entre eles

```r
mean(sample(1:6, 2))
```

```
## [1] 3.5
```
- Fazendo isso 500 vezes, temos:

```r
amostra = replicate(500, mean(sample(1:6, 2, replace=T)))
table(amostra) # tabela com contagem das médias de 2 jogadas
```

```
## amostra
##   1 1.5   2 2.5   3 3.5   4 4.5   5 5.5   6 
##  15  16  39  48  70  79  95  57  47  25   9
```

```r
# Gráfico
plot(table(amostra), type="h")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-90-1.png" width="672" />

- Note que, ao repetir 500 vezes, o cálcilo da média de 2 jogadas de dado, começou a dar mais peso para médias próximas à média populacional (3,5), mas ainda tem densidade nos valores mais extremos (1 e 6)
- Foi necessário usar o argumento `replace=TRUE` para ter "reposição" dos números do dado
- Calculando 500 vezes a média de `\(N=100\)` jogadas de dado, temos:

```r
N = 100
amostra = replicate(500, mean(sample(1:6, N, replace=T)))

# Gráfico
plot(table(amostra), type="h", xlim=c(1,6))
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-91-1.png" width="672" />

- Note que, quanto maior `\(N\)`, a concentração das médias das amostragens se concentraram ainda mais próximo da média populacional (3,5). Além disso, a densidade de médias mais distantes ficaram praticamente nulas.


## Geração de números aleatórios
- Para gerar números aleatórios, usaremos o prefixo `r` junto de uma distribuição.

```r
rnorm(5) # gerando 5 números aleatórios
```

```
## [1]  1.1069861 -0.1852287  1.3556348  0.8025769 -0.3390595
```

- Para reproduzir resultados que usem números aleatórios, podemos definir "sementes" usando a função `set.seed()` e informando um número inteiro. Isso também é válido para a função `sample()`.

```r
# definindo seed
set.seed(2022)
rnorm(5)
```

```
## [1]  0.9001420 -1.1733458 -0.8974854 -1.4445014 -0.3310136
```

```r
# sem definir seed
rnorm(5)
```

```
## [1] -2.9006290 -1.0592557  0.2779547  0.7494859  0.2415825
```

```r
# definindo seed
set.seed(2022)
rnorm(5)
```

```
## [1]  0.9001420 -1.1733458 -0.8974854 -1.4445014 -0.3310136
```

# Intervalos de Confiança
- [Subseção 1.8.1 de Heiss (2020)](http://www.urfie.net/read/index.html#page/71)
- No Apêndice C.5 de Wooldridge (2006, em português), são construídos intervalos de confiança de 95\%.
- Para uma população normalmente distribuída com média `\(\mu\)` e variância `\(\sigma^2\)`, o intervalo de confiança com significância de `\(\alpha\)` é dado por:
$$ \text{IC}_\alpha = \left[\bar{y} - C_{\alpha/2}.se(\bar{y}),\quad \bar{y} + C_{\alpha/2}.se(\bar{y})\right] \tag{1.2} $$
em que:

- `\(\bar{y}\)`: média amostral
- `\(se(\bar{y}) = \frac{s}{\sqrt{n}}\)`: erro padrão de `\(\bar{y}\)`
- `\(s\)`: desvio padrão de `\(\bar{y}\)`
- `\(n\)`: tamanho da amostra
- `\(C_{\alpha/2}\)`: é o valor crítico do quantil de `\((1-\alpha/2)\)` da distribuição `\(t_{n-1}\)`.
    - Por exemplo, para `\(\alpha = 5\%\)`, usa-se o quantil 97,5\% ($= 1 - 5\%/2$).
    - Quando o número de graus de liberdade é grande, a distribuição _t_ se aproxima ao de uma normal padrão. Logo, para um intervalo de confiança de 95\%, o valor crítico é `\(C_{2,5\%} \approx 1,96\)`


### Exemplo C.2: Efeito de subsídios de treinamento corporativo sobre a produtividade do trabalhador  (Wooldridge, 2006)

- Holzer, Block, Cheatham e Knott (1993) estudaram os efeitos de subsídios de treinamentos corporativos sobre a produtividade dos trabalhadores
- Para isto, avaliou-se a "taxa de refugo", isto é, a quantidade de itens descartados a cada 100 itens produzidos.
- Entre 1987 e 1988, houve treinamento corporativo em 20 empresas e queremos saber se ele teve efeito sobre a taxa de refugo, ou seja, a diferença entre as médias dos anos foi estatisticamente significante (diferente de 0).
- Comecemos criando vetores de taxa de refugos das 20 empresas para os anos de 1987 (_SR87_) e de 1988 (_SR88_):

```r
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)
```
- Criando o vetor das variações das taxas de refugo e extraindo estatísticas:

```r
Change = SR88 - SR87 # vetor de variações
n = length(Change) # quantidade de empresas/tamanho do vetor Variacao
avgChange = mean(Change) # média do vetor Variacao
sdChange = sd(Change) # desvio padrão do vetor Variacao
```
- Calculando o erro padrão e o valor crítico para intervalo de confiança de 95\%:

```r
se = sdChange / sqrt(n) # erro padrão
CV = qt(.975, n-1) # valor crítico para intervalo de confiança de 95%
```
- Finalmente, calcula-se o intervalo de confiança usando (1.2)

```r
c(avgChange - CV*se, avgChange + CV*se) # limites inferior e superior do intervalo
```

```
## [1] -2.27803369 -0.03096631
```

```r
# também poderíamos escrever o intervalo mais sucintamente:
avgChange + CV * c(-se, se)
```

```
## [1] -2.27803369 -0.03096631
```
- Note que o valor 0 está fora do intervalo de confiança de 95\% e, portanto, conclui-se que houve alteração na taxa de refugo (houve efeito negativo estatisticamente significante).


# Teste _t_ e p-valores
- [Subseções 1.8.2 e 1.8.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/74)
- Apêndice C.6 de Wooldridge (2006, em português)

- A estatística _t_ para testar uma hipótese sobre uma variável aleatória `\(y\)` normalmente distribuída com média `\(\bar{y}\)` é dado pela equação C.35 (Wooldridge, 2006). Dada a hipótese nula `\(H_0: \bar{y} = \mu_0\)`,
$$ t = \frac{\bar{y} - \mu_0}{se(\bar{y})}. \tag{1.3} $$

- Para rejeitarmos a hipótese nula, o módulo da estatística _t_ precisa ser maior do que o valor crítico, dado um nível de significância `\(\alpha\)`.
- Por exemplo, ao nível de significância `\(\alpha = 5\%\)` e com uma grande amostra (e, portanto, a distribuição _t_ se aproxima a de uma normal padrão), rejeitamos a hipótese nula se
$$ |t| \ge 1,96 \approx \text{valor crítico ao nível de significância de 5%} $$

- A vantagem de utilizar o p-valor é a sua conveniência, pois pode-se compará-lo diretamente com o nível de significância.
- Para testes _t_ bicaudais, a fórmula do p-valor é dado por (Wooldridge, 2006, equação C.42):
$$ p = 2.Pr(T_{n-1} > |t|) = 2.[1 - F_{t_{n-1}}(|t|)] $$
em que `\(F_{t_{n-1}}(\cdot)\)` é a fda da distribuição `\(t_{n-1}\)`.


<center><img src="https://fhnishida.github.io/fearp/rec2301/t-student_test.png"></center>


- Rejeitamos a hipótese nula se o p-valor for menor do que o nível de significância `\(\alpha\)`.


### Exemplo C.6: Efeito de subsídios de treinamento corporativo sobre a produtividade do trabalhador  (Wooldridge, 2006)
- Continuação do exemplo C.2
- Considerando teste bicaudal (diferente dos livros), podemos calcular a estatística _t_

```r
# Estatística t para H0: mu = 0
t = (avgChange - 0) / se
print(paste0("estatística t = ", abs(t), " > ", CV, " = valor crítico"))
```

```
## [1] "estatística t = 2.15071100397349 > 2.09302405440831 = valor crítico"
```
- Como estatística _t_ é maior do que o valor crítico, rejeitamos `\(H_0\)` a nível de significância de 5\%.
- De forma equivalente, podemos calcular o p-valor:

```r
p = 2 * (1 - pt(abs(t), n-1))
print(paste0("p-valor = ", p, " < 0.05 = nível de significância"))
```

```
## [1] "p-valor = 0.0445812529367844 < 0.05 = nível de significância"
```
- Como o p-valor é maior do que `\(\alpha = 5\%\)`, rejeitamos `\(H_0\)`.


## Cálculos automáticos via `t.test()`
```yaml
t.test(x, y = NULL,
       alternative = c("two.sided", "less", "greater"),
       mu = 0, paired = FALSE, var.equal = FALSE,
       conf.level = 0.95, ...)

x: (non-empty) numeric vector of data values.
alternative: a character string specifying the alternative hypothesis, must be one of "two.sided" (default), "greater" or "less". You can specify just the initial letter.
mu: a number indicating the true value of the mean (or difference in means if you are performing a two sample test).
conf.level: confidence level of the interval.
```
- Note que incluiremos um vetor de valor no argmento `x` e, por padrão, a função considera um teste bicaudal, testando a `\(H_0\)` se média verdadeira é igual a zero e com intervalo de confiança de 95\%.
- Retornando aos exemplos C.2 e C.6 ("Efeito de subsídios de treinamento corporativo sobre a produtividade"), temos:

```r
testresults = t.test(Change)
testresults
```

```
## 
## 	One Sample t-test
## 
## data:  Change
## t = -2.1507, df = 19, p-value = 0.04458
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  -2.27803369 -0.03096631
## sample estimates:
## mean of x 
##   -1.1545
```
- Dentro do objeto de resultado do teste, temos as seguintes informações:

```r
names(testresults)
```

```
##  [1] "statistic"   "parameter"   "p.value"     "conf.int"    "estimate"   
##  [6] "null.value"  "stderr"      "alternative" "method"      "data.name"
```
- Podemos, por exemplo, acessar o p-valor usando:

```r
testresults$p.value
```

```
## [1] 0.04458125
```


# Modelo de Regressão Simples

## Regressão simples por MQO
- [Seção 2.1 de Heiss (2020)](http://www.urfie.net/read/index.html#page/93)
- Considere o seguinte modelo empírico
$$ y = \beta_0 + \beta_1 x + u \tag{2.1} $$
- Os estimadores de mínimos quadrados ordinários (MQO), segundo Wooldridge (2006, Seção 2.2) é dado por
`\begin{align}
    \hat{\beta}_0 &= \bar{y} - \hat{\beta}_1 \bar{x} \tag{2.2}\\
    \hat{\beta}_1 &= \frac{Cov(x,y)}{Var(x)} \tag{2.3}
\end{align}`
- E os valores ajustados/preditos, `\(\hat{y}\)` é dado por
$$ \hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x \tag{2.4} $$
tal que 
$$ y = \hat{y} + \hat{u} $$

### Exemplo 2.3: Salário de Diretores Executivos e Retornos de Ações (Wooldridge, 2006)

- Considere o seguinte modelo de regressão simples
$$ \text{salary} = \beta_0 + \beta_1 \text{roe} + u $$
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
# Cálculo "na mão" dos coeficientes de MQO
( b1_hat = cov(salary, roe) / var(roe) ) # por (2.3)
```

```
## [1] 18.50119
```

```r
( b0_hat = mean(salary) - var(roe)*mean(salary) ) # por (2.2)
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

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-107-1.png" width="672" />


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
( bhat = coef(CEOregres) )
```

```
## (Intercept)         roe 
##   963.19134    18.50119
```

```r
bhat_0 = bhat["(Intercept)"] # ou bhat[1]
bhat_1 = bhat["roe"] # ou bhat[2]
```

- Dados estes parâmetros estimados, podemos calcular os valores ajustados/preditos, `\(\hat{y}\)`, e os desvios, `\(\hat{u}\)`, para cada observação `\(i=1, ..., n\)`:
`\begin{align}
    \hat{y}_i &= \hat{\beta}_0 + \hat{\beta}_1 . x_i \tag{2.5} \\
    \hat{u}_i &= y_i - \hat{y}_i \tag{2.6}
\end{align}`


```r
# Extraindo colunas de ceosal1 em vetores
sal = ceosal1$salary
roe = ceosal1$roe

# Calculando os valores ajustados/preditos
sal_hat = bhat_0 + (bhat_1 * roe)

# Calculando os desvios
u_hat = sal - sal_hat

# Visualizando as 6 primerias linhas de sal, roe, sal_hat e u_hat
head( cbind(sal, roe, sal_hat, u_hat) )
```

```
##       sal  roe  sal_hat     u_hat
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


- Na seção 2.3 de Wooldridge (2006), vemos que a estimação por MQO assume as seguintes hipóteses:
`\begin{align}
    &\sum^n_{i=1}{\hat{u}_i} = 0 \quad \implies \quad \bar{\hat{u}} = 0 \tag{2.7} \\
    &\sum^n_{i=1}{x_i \hat{u}_i} = 0 \quad \implies \quad Cov(x,\hat{u}) = 0 \tag{2.8} \\
    &\bar{y}=\hat{\beta}_0 + \hat{\beta}_1.\bar{x} \tag{2.9}
\end{align}`

- Podemos verificá-los em nosso exemplo:

```r
# Verificando (2.7)
mean(u_hat) # bem próximo de 0
```

```
## [1] -2.666235e-14
```

```r
# Verificando (2.8)
cor(ceosal1$roe, u_hat) # bem próximo de 0
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

- **IMPORTANTE**: Isso só quer dizer que o MQO escolhe `\(\hat{\beta}_0\)` e `\(\hat{\beta}_1\)` tais que 2.7, 2.8 e 2.9 sejam verdadeiros.
- Isto **NÃO** quer dizer que, para o modelo empírico/populacional, as seguintes hipóteses sejam verdadeiras:
`\begin{align}
    &E(u) = 0 \tag{2.7'} \\
    &Cov(x, u) = 0 \tag{2.8'}
\end{align}`
- De fato, se 2.7' e 2.8' não forem válidos, a estimação por MQO (que assume 2.7, 2.8 e 2.9) será viesada.


## Transformações log
- [Seção 2.4 de Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- Também podemos fazer estimações transformando variáveis em nível para logaritmo.
    - É especialmente importante para transformar modelos não-lineares em lineares - quando o parâmetro está no expoente ao invés estar multiplicando:
    $$ y = A K^\alpha L^\beta\quad \overset{\text{log}}{\rightarrow}\quad \log(y) = \log(A) + \alpha \log(K) + \beta \log(L) $$
    - Também é frequentemente utilizada em variáveis dependentes `\(y \ge 0\)`

    

<center><img src="https://fhnishida.github.io/fearp/rec2301/tab_2-3.png"></center>

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
- Um aumento em US\$ 1 milhão em vendas está relacionado incremento de US\$ 0,01547 milhares de dólares do salário do diretor executivo.
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
- Um aumento em US\$ 1 milhão em vendas tende a elevar em 0,0015\% ($=100 \beta_1\%$ ) o salário do diretor executivo.
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
- Um aumento em 1\% das vendas aumenta o salário em cerca de 0,257\% ($=\beta_1\%$) maior.


## Regressão a partir da origem e sobre uma constante
- [Seção 2.5 de Heiss (2020)](http://www.urfie.net/read/index.html#page/103)
- Para esstimar o modelo sem o intercepto (constante), precisamos adicionar `0 +` nos regressores na função `lm()`:

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


## Diferença de médias
- Baseado no Exemplo C.6: Efeito de subsídios de treinamento corporativo sobre a produtividade do trabalhador  (Wooldridge, 2006)
- Poderíamos ter calculado a diferença de médias por meio de uma regressão sobre uma variável _dummy_, cujos valores são 0 ou 1.
- Primeiro vamos criar um vetor único de taxas de refugo (vamos empilhar `SR87` e `SR88`)

```r
SR87 = c(10, 1, 6, .45, 1.25, 1.3, 1.06, 3, 8.18, 1.67, .98,
         1, .45, 5.03, 8, 9, 18, .28, 7, 3.97)
SR88 = c(3, 1, 5, .5, 1.54, 1.5, .8, 2, .67, 1.17, .51, .5, 
         .61, 6.7, 4, 7, 19, .2, 5, 3.83)

( SR = c(SR87, SR88) ) # empilhando SR87 e SR88 em único vetor
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
( group88 = c(rep(0, 20), rep(1, 20)) ) # valores 0/1 para 20 primeiras/últimas observações
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



## Valores esperados, Variância e Erros padrão
- [Seção 2.6 de Heiss (2020)](http://www.urfie.net/read/index.html#page/106)

<!-- - Sob as hipóteses: RLS.1 a RLS.5 -->
<!--     - *RLS.1*: linearidade nos parâmetros: `\(y = \beta_0 + \beta_1x + u\)` -->
<!--     - *RLS.2*: amostragem aleatória de `\(x\)` e `\(y\)` na população -->
<!--     - *RLS.3*: variação amostral na variável independente [RLS.4 em Wooldridge (2016)] -->
<!--     - *RLS.4*: média condicional zero: `\(E(u|X) = 0\)` -->
<!--     - *RLS.5*: homocedasticidade> `\(Var(u|x)=\sigma^2\)` -->
    
- Wooldridge (2006, Seção 2.5) deriva o estimador do termo de erro:
$$ \hat{\sigma}^2 = \frac{1}{n-2} \sum^n_{i=1}{\hat{u}^2_i} = \frac{n-1}{n-2} Var(\hat{u}) \tag{2.14} $$
em que `\(Var(\hat{u}) = \frac{1}{n-1} \sum^n_{i=1}{\hat{u}^2_i}\)`.
- Observe que precisamos considerar os graus de liberdade, dado que estamos estimando dois parâmetros ($\hat{\beta}_0$ e `\(\hat{\beta}_1\)`).
- Note que `\(\hat{\sigma} = \sqrt{\hat{\sigma}^2}\)` é chamado de erro padrão da regressão (EPR). No R, é chamado de erro padrão residual 
- também podemos obter os erros padrão (EP) dos estimadores:

`\begin{align}
    se(\hat{\beta}_0) &= \sqrt{\frac{\hat{\sigma}\bar{x}^2}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \sqrt{\bar{x^2}} \tag{2.15}\\
    se(\hat{\beta}_1) &= \sqrt{\frac{\hat{\sigma}}{\sum^n_{i=1}{(x_i - \bar{x})^2}}} = \frac{1}{\sqrt{n-1}} \frac{\hat{\sigma}}{sd(x)} \tag{2.16}
\end{align}`


### Exemplo 2.12: Desempenho em Matemática de Estudante e o Programa de Merenda Escolar (Wooldridge, 2006)
- Sejam as variáveis
    - `math10`: o percentual de alunos de primeiro ano de ensino médio aprovados em exame de matemática
    - `lnchprg`: o percentual de estudante aptos para participar do programa de merenda escolar
- O modelo de regressão simples é
$$ \text{math10} = \beta_0 + \beta_1 \text{lnchprg} + u $$


```r
data(meap93, package="wooldridge")

# Estimando o modelo e atribuindo no objeto 'results'
results = lm(math10 ~ lnchprg, data=meap93)

# Extraindo número de observações
( n = nobs(results) )
```

```
## [1] 408
```

```r
# Calculando o Erro Padrão da Regressão (raiz quadrada de 2.14)
( SER = sqrt( (n-1)/(n-2) ) * sd(resid(results)) )
```

```
## [1] 9.565938
```

```r
# Erro padrão de bhat_0 (2.15)
(1 / sqrt(n-1)) * (SER / sd(meap93$lnchprg)) * sqrt( mean(meap93$lnchprg^2) ) # Erro padrão de bhat_1 (2.16)
```

```
## [1] 0.9975824
```

```r
(1 / sqrt(n-1)) * (SER / sd(meap93$lnchprg)) # bhat_1
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

- Observe também que, por padrão, são feitos testes de hipótese (bicaudais), cujas hipóteses nulas são `\(\beta_0 = 0\)` e `\(\beta_1=0\)`.
- Ou seja, avalia se as estimativas calculadas são estatisticamente nulas e também mostra as respectivas estatísticas t e p-valores.
- Neste caso, como os p-valores são bem pequenos (`<2e-16` = menor do que `\(2 \times 10^{-16}\)`), rejeitamos ambas hipóteses nulas e, portanto, as estimativas são estatisticamente significantes.
- Também podemos calcular essas estimativas "na mão":

```r
# Extraindo as estimativas
( estim = coef(summary(results)) )
```

```
##               Estimate Std. Error   t value      Pr(>|t|)
## (Intercept) 32.1427116 0.99758239 32.220609 6.267302e-114
## lnchprg     -0.3188643 0.03483933 -9.152422  2.746609e-18
```

```r
# Estatísticas t para H0: bhat = 0
( t_bhat_0 = (estim["(Intercept)", "Estimate"] - 0) / estim["(Intercept)", "Std. Error"] )
```

```
## [1] 32.22061
```

```r
( t_bhat_1 = (estim["lnchprg", "Estimate"] - 0) / estim["lnchprg", "Std. Error"] )
```

```
## [1] -9.152422
```

```r
# p-valores para H0: bhat = 0
2 * (1 - pt(abs(t_bhat_0), n-1)) # p-valor para bhat_0
```

```
## [1] 0
```

```r
2 * (1 - pt(abs(t_bhat_1), n-1)) # p-valor para bhat_1
```

```
## [1] 0
```


## Violações de hipótese
- [Subseção 2.7.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/113), mas usando como exemplo o teste elaborado 1.
- [Simulating a linear model (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/u7in9/simulation-simulating-a-linear-model)
- Na prática, fazemos regressões a partir de observações contidas em bases de dados e não sabemos qual é o _modelo real_ que gerou essas observações.
- No R, podemos supor um _modelo real_ e simular suas observações no R para analisar o que ocorre quando há violação de hipótese de algum modelo econométrico ou estimador.
- Usaremos o exemplo dado no Teste Elaborado 1, no qual queremos encontrar a relação das horas de prática em culinária com o número de queimaduras na cozinha.


### Sem violação de hipótese: Exemplo 1
- Sejam `\(y\)` o número de queimaduras na cozinha e `\(x\)` o número de horas gastas aprendendo a cozinhar.
- Suponha o _modelo real_:
$$ y = a_0 + b_0 x + \varepsilon, \qquad \varepsilon \sim N(0, 2^2) \tag{1}$$
em que `\(a_0=50\)` e `\(b_0=-5\)`.

1. Definindo `\(a_0\)` e `\(b_0\)` e gerando por simulação as "observações" de `\(x\)` e `\(y\)`:
    - Apenas para facilitar, geraremos valores aleatórios `\(x \sim N(5; 0,5^2)\)`. Aqui, não importa a distribuição de `\(x\)`. 

```r
a0 = 50
b0 = -5
N = 200 # Número de observações

set.seed(1)
u = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
y = a0 + b0*x + u # calculando observações y a partir de "e" e "x"

plot(x, y)
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-125-1.png" width="672" />
Simulamos as observações `\(x\)` e `\(y\)` que são, na prática, as informações que observamos.

2. Estimando por MQO os parâmetros `\(\hat{a}\)` e `\(\hat{b}\)` a partir das observações simuladas de `\(y\)` e `\(x\)`:
    - Um economista supôs a relação entre as variáveis pelo seguinte _modelo empírico_:
    $$ y = a + b x + u, \tag{1a}$$
    assumindo que `\(E[u] = 0\)` e `\(E[ux]=0\)`.
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

- Note que foi possível recuperar os parâmetros populacionais ($\hat{a} = 50,268 \approx 50 = a_0$ e `\(\hat{b} = -5,039 \approx -5 = b_0\)`).


```r
plot(x, y) # Figura de x contra y
abline(a=50, b=-5, col="red") # reta do modelo real
abline(lm(y ~ x), col="blue") # reta estimada a partir das observações
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-127-1.png" width="672" />

### Sem violação de hipótese: Exemplo 2
- Agora, no _modelo real_, suponha que o número de queimaduras `\(y\)` é determinado tanto pela quantidade de horas de aprendizado `\(x\)` e pela quantidade de horas gastas cozinhando `\(z\)`:
$$ y = a_0 + b_0 x + c_0 z + u, \qquad u \sim N(0, 2^2) \tag{2} $$
em que `\(a_0=50\)`, `\(b_0=-5\)` e `\(c_0=3\)`. Apenas para facilitar, usaremos geraremos valores aleatórios de `\(x \sim N(5; 0,5^2)\)` e `\(z \sim N(1,875; 0,25^2)\)`. Note que `\(z\)`, por construção, não é correlacionada com `\(x\)` no _modelo real_.

- Primeiro, vamos simular as observações:

```r
a0 = 50
b0 = -5
c0 = 3
N = 200 # Número de observações

set.seed(1)
u = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
z = rnorm(N, 1.875, 0.25) # Gerando 200 obs. de média 1,875 e desv pad 0.25
y = a0 + b0*x + c0*z + u # calculando observações y a partir de "e", "x" e "z"
```

- Considere que um economista suponha a relação entre as variáveis pelo seguinte _modelo empírico_:
    $$ y = a + b x + u, \tag{2a}$$
    assumindo que `\(E[u] = 0\)` e `\(E[ux] = 0\)`.

- Note que o economista deixou a variável de horas cozinhando `\(z\)` fora do modelo, então ela acaba ``entrando'' no erro da estimação.
- No entanto, como `\(z\)` não tem relação com `\(x\)`, então isso não afeta a estimativa de `\(\hat{b}\)`:

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
- Note que `\(\hat{b} = -5,12 \approx -5 = b_0\)`, portanto a estimação por MQO conseguiu recuperar o parâmetro populacional `\(b_0\)`, apesar do economista não ter incluído `\(z\)` no modelo.
- Grande parte dos estudos econômicos tentam estabelecer a relação/causalidade entre `\(y\)` e `\(x\)`, então não é necessário incluir todas possíveis variáveis que impactam `\(y\)`, desde que `\(E(ux) = 0\)` (ou seja, que nenhuma variável explicativa correlacionada com `\(x\)` tenha ``ficado de fora'' e, portanto, compondo o termo de erro).



### Violação de `\(E(ux)=0\)`
- Agora, suponha que, no _modelo real_, quanto mais horas a pessoa pratica culinária, mais ele cozinha (ou seja, `\(x\)` está relacionada com `\(z\)`).
    - Considere que `\(z \sim N(1,875x; (0,25)^2)\)`:

```r
set.seed(1)
e = rnorm(N, 0, 2) # Desvios: 200 obs. de média 0 e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
z = rnorm(N, 1.875*x, 0.25) # Gerando 200 obs. de média 1,875x e desv pad 0.25x
y = a0 + b0*x + c0*z + e # calculando observações y a partir de "e", "x" e "z"
cor(x, z) # correlação de x e z
```

```
## [1] 0.9618748
```

- Note que, agora, `\(x\)` e `\(z\)` são consideravalmente correlacionados
- Vamos estimar o _modelo empírico_:
    $$ y = a + b x + u,$$
    assumindo que `\(E[u] = 0\)` e `\(E[ux]=0\)`.

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

- Observe que `\(\hat{b} = 0,5 \neq -5 = b_0\)`. Isto se dá porque `\(z\)` não foi incluído no modelo e, portanto, ele acaba compondo o desvio `\(\hat{u}\)`. Como `\(z\)` é correlacionado com `\(x\)`, então `\(E(ux)\neq 0\)` (violando a hipótese do MQO).
- Observe que, se incluíssemos a variável `\(z\)` na estimação, conseguiríamos recuperar `\(\hat{b} \approx b_0\)`:


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

### Violação de `\(E(u)=0\)`
- Agora, consideraremos que `\(E[u] = k\)`, sendo `\(k \neq 0\)` uma constante.
- Assuma que `\(k = 10\)`:

```r
a0 = 50
b0 = -5
k = 10

set.seed(1)
u = rnorm(N, k, 2) # Desvios: 200 obs. de média k e desv pad 2
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
y = a0 + b0*x + u # calculando observações y a partir de "e" e "x"
```
- Caso um economista considere um _modelo empírico_ com `\(E[u] = 0\)`, segue que:

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
- Note que o fato de `\(E[u] \neq 0\)` afeta apenas a estimação de `\(\hat{a} \neq a_0\)`, porém não afeta a de `\(\hat{b} \approx b_0\)`, que é normalmente o parâmetro de interesse em estudos econômicos.


### Violação de Homocedasticidade
- Agora, consideraremos que `\(u \sim N(0, (2x)^2)\)`, ou seja, a variância cresce com `\(x\)` ($u$ não é independente de `\(x\)`/não vale homocedasticidade).

```r
a0 = 50
b0 = -5

set.seed(1)
x = rnorm(N, 5, 0.5) # Gerando 200 obs. de média 5 e desv pad 1
u = rnorm(N, 0, 2*x) # Desvios: 200 obs. de média k e desv pad 2x
y = a0 + b0*x + u # calculando observações y a partir de "e" e "x"

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
- Note que, mesmo com heterocesdasticidade, é possível recuperar `\(\hat{b} \approx b_0\)`. Mas, observe também que, se a amostra for pequena, mais provável é que `\(\hat{b} \neq b_0\)`. Teste diversas vezes para `\(N\)` menores.



## Qualidade do ajuste
- [Seção 2.3 de Heiss (2020)](http://www.urfie.net/read/index.html#page/101)
- A soma de quadrados total (SQT), a soma de quadrados explicada (SQE) e a soma de quadrados dos resíduos (SQR) podem ser escritos como:
`\begin{align}
    SQT &= \sum^n_{i=1}{(y_i - \bar{y})^2} = (n-1) . Var(y) \tag{2.10}\\
    SQE &= \sum^n_{i=1}{(\hat{y}_i - \bar{y})^2} = (n-1) . Var(\hat{y}) \tag{2.11}\\
    SQR &= \sum^n_{i=1}{(\hat{u}_i - 0)^2} = (n-1) . Var(\hat{u}) \tag{2.12}
\end{align}`
em que `\(Var(x) = \frac{1}{n-1} \sum^n_{i=1}{(x_i - \bar{x})^2}\)`.

- Wooldridge (2006) define o coeficiente de determinação como:
`\begin{align}
    R^2 &= \frac{SQE}{SQT} = 1 - \frac{SQR}{SQT}\\
        &= \frac{Var(\hat{y})}{Var(y)} = 1 - \frac{Var(\hat{u})}{Var(y)} \tag{2.13}
\end{align}`
pois `\(SQT = SQE + SQR\)`.


```r
# Calculando R^2 de três maneiras:
var(sal_hat) / var(sal)
```

```
## [1] 0.01318862
```

```r
1 - var(u_hat)/var(sal)
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

- Para obter o `\(R^2\)` de forma mais conveniente, pode-se usar a função `summary()` sobre o objeto de resultado da regressão. Esta função fornece uma visualização dos resultados mais detalhada, incluindo o `\(R^2\)`:

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



## [Extra] Otimização numérica
- Essa seção tem o objetivo para dar uma intuição sobre métodos de otimização.
- Veremos os métodos de _grid search_ e _steepest ascent_ que representam famílias de métodos de otimização.


#### _Grid Search_


- O método mais simples de otimização numérica é o _grid search_ (discretização).
- Como o R não lida com problemas com infinitos valores, uma forma lidar com isso é discretizando diversos possíveis valores dos parâmetros de escolha dentro de intervalos.
- Para cada possível combinação de parâmetros, calculam-se diversos valores a partir da função objetivo. De todos os valores calculados, escolhe-se a combinação de parâmetros que maximizam (ou minimizam) a função objetivo.
- O exemplo abaixo considera apenas um parâmetro de escolha `\(\theta\)` e, para cada ponto escolhido dentro do intervalo `\([-1, 1]\)`, calcula-se a função objetivo:

<center><img src="https://fhnishida.github.io/fearp/eco1/grid_search.png"></center>

\\

- Este é um método robusto a funções com descontinuidades e quinas (não diferenciáveis), e menos sensível a chutes de valores iniciais. (ver método abaixo)
- Porém, este método fica preciso apenas com maiores quantidades de pontos e, como é necessário fazer o cálculo da função objetivo para cada ponto, o _grid search_ tende a ser menos eficiente computacionalmente (demora mais tempo para calcular).


#### _Steepest Ascent_



- Conforme o número de parâmetros do modelo cresce, aumenta o número de possíveis combinações entre parâmetros e torna o processo computacional cada vez mais lento.
- Uma forma mais eficiente de encontrar o conjunto de parâmetros que otimizam a função objetivo é por meio do método _steepest ascent_.
- Seja `\(\theta^{**}\)` o conjunto de parâmetros que maximiza globalmente a função objetivo:
  1. Comece com algum valor inicial de parâmetro, `\(\theta^0\)`
  2. Calcula-se a derivada e avalia-se a possibilidade de "andar para cima" a um valor mais alto
  3. Caso possa, ande na direção correta a `\(\theta^1\)`
  4. Repita os passos (2) e (3), andando para um novo `\(\theta^2, \theta^3, ...\)` até
  atingir um `\(\theta^*\)` cuja função objetivo é máxima e cuja derivada é igual a zero.

<center><img src="https://fhnishida.github.io/fearp/eco1/steepest_ascent.png"></center>

- Note que esse método de otimização é sensível ao parâmetro inicial e às descontinuidades da função objetivo.
    - No exemplo, se os chutes iniciais forem `\(\theta^0_A\)` ou `\(\theta^0_B\)`, então consegue atingir o máximo global.
    - Já se o chute inicial for `\(\theta^0_C\)`, então ele acaba atingindo um máximo local com `\(\theta^*\)` (menor do que o máximo global em `\(\theta^{**}\)`).
- Por outro lado, é um método mais eficiente, pois calcula-se a função objetivo uma vez a cada passo e também tende a ser mais preciso nas estimações.


## [Extra] Encontrando MQO por diferentes estratégias
- Nesta seção, encontraremos as estimativas de MQO usando as estratégias da (i) teoria da decisão, do (ii) método dos momentos e da (iii) máxima verossimilhança.
- Em todas elas, usaremos um método de otimização, mas, diferente da seção anterior, queremos achar uma _dupla_ de parâmetros que otimizam uma função objetivo.


### Base de dados `mtcars`
É necessário carregar o pacote `dplyr` para manipulação da base de dados abaixo.

```r
library(dplyr)
```

Usaremos dados extraídos da _Motor Trend_ US magazine de 1974, que analisa o
consumo de combustível e 10 aspectos técnicos de 32 automóveis.

No _R_, a base de dados já está incorporada ao programa e pode ser acessada pelo código `mtcars`, contendo a seguinte estrutura:

> - _mpg_: milhas por galão
> - _hp_: cavalos-vapor bruto


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
## Plotando consumo de combustível (mpg) por potência do carro (hp)
plot(mtcars$mpg, mtcars$hp, xlab="Milhas por galão (mpg)", ylab="Cavalos-vapor (hp)")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-141-1.png" width="672" />

Queremos estimar o seguinte modelo:
$$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \varepsilon  $$


```r
## Rodar a regressao MQO
fit = lm(formula = mpg ~ hp + wt, data = mtcars)

## Resumir os resultados da regressao
fit
```

```
## 
## Call:
## lm(formula = mpg ~ hp + wt, data = mtcars)
## 
## Coefficients:
## (Intercept)           hp           wt  
##    37.22727     -0.03177     -3.87783
```


### (i) Teoria da Decisão
- Pela estratégia da teoria da decisão, queremos encontrar as estimativas, $\hat{\beta}_0\ \text{e}\ \hat{\beta}_1 $, que minimizam a soma dos desvios quadráticos:


#### 1. Criar função perda que calcula a soma dos desvios quadráticos
- A função para calcular a soma dos desvios quadráticos recebe como inputs:
  - um **vetor** de possíveis estimativas `\(\hat{\beta}_0\)`, `\(\hat{\beta}_1\)`
  - uma base de dados

```r
desv_quad = function(params, data) {
  # Extraindo os parâmetros para objetos
  beta_hat_0 = params[1]
  beta_hat_1 = params[2]
  
  mpg_ajustado = beta_hat_0 + beta_hat_1*data$hp # valores ajustados
  desvios = data$mpg - mpg_ajustado # desvios = observados - ajustados
  sum(desvios^2)
}
```


#### 2. Otimização
- Agora encontraremos os parâmetros que minimizam a função perda
$$ \underset{\hat{\beta}_0, \hat{\beta}_1}{\text{argmin}} \sum_{i=1}^{N}\hat{\varepsilon}^2 \quad = \quad \underset{\hat{\beta}_0, \hat{\beta}_1}{\text{argmin}} \sum_{i=1}^{N}\left( \text{mpg}_i - \widehat{\text{mpg}}_i \right)^2 $$
<!-- tal que `\(\Theta = \{ \beta_0, \beta_1, \beta_2 \}\)`. -->
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
## [1] 30.09886054 -0.06822828  0.00000000
## 
## $value
## [1] 447.6743
## 
## $counts
## function gradient 
##       31        5 
## 
## $convergence
## [1] 0
## 
## $message
## NULL
## 
## $hessian
##      [,1]    [,2] [,3]
## [1,]   64    9388    0
## [2,] 9388 1668556    0
## [3,]    0       0    0
```



### (ii) Máxima verossimilhança (MLE)
- [ResEcon 703](https://github.com/woerman/ResEcon703) - Week 6 (University of Massachusetts Amherst)

Para uma equação de regressão geral
$$ y_i = \beta' X + \varepsilon $$
supondo distribuição normal do termo de erro
$$ \varepsilon \sim \mathcal{N}(0, \sigma^2), $$
temos uma distribuição condicional de `\(y\)` dada por
$$ y | X \sim \mathcal{N}(\beta'X, \sigma^2). $$

Logo, a função log-verossimilhança (condicional) é
$$ \ln{L(\beta, \sigma^2 | y, X)} = \sum^n_{i=1}{\ln{f(y | X, \beta, \sigma^2)}}. $$

Em nosso exemplo, temos que estimar 4 parâmetros
$$ \theta = \left( \beta_0, \beta_1, \beta_2, \sigma^2 \right). $$

Podemos:

- Tomar derivadas de `\(\ln{L(\beta, \sigma^2 | y, X)}\)` em relação a cada parâmetro e resolver as CPOs, ou
- Maximizar `\(\ln{L(\beta, \sigma^2 | y, X)}\)` por otimização numérica.


### Intuição do cálculo da função de verossimilhança
- Apenas para ilustrar a construção da função de verossimilhança, considere um modelo logit em que queremos estimar os indivíduos precisam escolher se usam carro ou ônibus para deslocamento.
- Para estimar as probabilidades de usar carro (e, por consequência, de ônibus), vamos utilizar as informações dos preços que os indivíduos pagam pela gasolina e pela passagem de ônibus.
- Note que os valores abaixo foram todos inventados.
- Considere um conjunto de parâmetros `\(\theta^A = \{ \beta^A_0, \beta^A_1, \beta^A_2 \}\)` que gerem as seguintes probabilidades de usar carro e de ônibus (últimas 2 colunas):

|             | **Preço Gasolina** | **Preço Bus** | **Escolha** | **_Prob(Car  `\(| \theta^A\)`)_** | **_Prob(Bus `\(| \theta^A\)`)_** |
|:-----------:|:------------------:|:----------------:|:-----------:|:-----------------:|:------------------:|
| Indiv. 1 |        6,93        |       5,00       |    Car    |        **0,63**       |        0,37        |
| Indiv. 2 |        7,01        |       2,50       |    Bus   |        0,33       |        **0,67**        |
| Indiv. 3 |        6,80        |       2,50       |    Bus   |        0,25       |        **0,75**        |
| Indiv. 4 |        6,75        |       5,00       |    Car    |        **0,73**       |        0,27        |

- Logo, a verossimilhança, dado os parâmetros `\(\theta^A\)` é
$$ \mathcal{L}(\theta^A) = 0,63 \times 0,67 \times 0,75 \times 0,73 = 0,231 $$
- Agora, considere `\(\theta^B = \{ \beta^B_0, \beta^B_1, \beta^B_2 \}\)` que gerem as seguintes probabilidades:

|             | **Preço Gasolina** | **Preço Bus** | **Escolha** | **_Prob(Car  `\(| \theta^B\)`)_** | **_Prob(Bus `\(| \theta^B\)`)_** |
|:-----------:|:------------------:|:----------------:|:-----------:|:-----------------:|:------------------:|
| Indiv. 1 |        6,93        |       5,00       |    Car    |        **0,54**       |        0,46        |
| Indiv. 2 |        7,01        |       2,50       |    Bus   |        0,43       |        **0,57**        |
| Indiv. 3 |        6,80        |       2,50       |    Bus   |        0,35       |        **0,65**        |
| Indiv. 4 |        6,75        |       5,00       |    Car    |        **0,58**       |        0,42        |

- Então, a verossimilhança, dado `\(\theta^B\)`, é
$$ \mathcal{L}(\theta^B) = 0,54 \times 0,57 \times 0,65 \times 0,58 = 0,116 $$
- Como `\(\mathcal{L}(\theta^A) = 0,231 > 0,116 = \mathcal{L}(\theta^B)\)`, então os parâmetros `\(\theta^A\)` se mostram mais adequados em relação a `\(\theta^B\)`
- Na máxima verossimilhança (MLE), é escolhido o conjunto de parâmetros `\(\theta^*\)` que maximiza a função de verossimilhança (ou log-verossimilhança).
- No modelo logit, as probabilidades usadas para calcular a verossimilhança são as próprias proabilidades de escolha por uma alternativa, dado um conjunto de parâmetros.
- Já no modelo linear, usamos a função de densidade de probabilidade para avaliar a "distância" de cada observação, `\(y_i\)`, em relação ao seu valor ajustado `\(\hat y_i\)`, dado um conjunto de parâmetros.



#### Otimização Numérica para MLE
A função `optim()` do R será usada novamente para desempenhar a otimização numérica. Precisamos usar como input:

- Alguns valores inicias dos parâmetros, `\(\theta^0\)`
- Uma função que tome esses parâmetros como um argumento e calcule a 
log-verossimilhança, `\(\ln{L(\theta)}\)`.

> Como `optim()` irá encontrar os parâmetros que minimizem a função objetivo, precisamos adaptar o output da função de log-verossimilhança (minimizaremos o negativo da log-lik).

A função log-verossimilhança é dada por
$$ \ln{L(\beta, \sigma^2 | y, X)} = \sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}, $$
em que a distribuição condicional de cada `\(y_i\)` é
$$ y_i | x_i \sim \mathcal{N}(\beta'x_i, \sigma^2) $$

1. Construir matriz `\(X\)` e vetor `\(y\)`
2. Calcular os valores ajustados de `\(y\)`, `\(\hat{y} - \beta'x_i\)`, que é a média de cada `\(y_i\)`
3. Calcular a densidade para cada `\(y_i\)`, `\(f(y_i | x_i, \beta, \sigma^2)\)`
4. Calcular a log-verossimilhança, `\(\ln{L(\beta, \sigma^2 | y, X)} = \sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}\)`


##### 1. Chute de valores iniciais para `\(\beta_0, \beta_1, \beta_2\)` e `\(\sigma^2\)`
- Note que, diferente da estimação por MQO, um dos parâmetros a ser estimado via MLE é a variância ($\sigma^2$).

```r
params = c(35, -0.02, -3.5, 1)
# (beta_0, beta_1 , beta_2, sigma2)
```

##### 2. Seleção da base de dados e variáveis

```r
## Adicionando colunas de 1's para o termo constante
data = mtcars
beta_0 = params[1]
beta_1 = params[2]
beta_2 = params[3]
sigma2 = params[4]
```

##### 3. Cálculo dos valores ajustados e das densidades

```r
## Calculando valores ajustados de y
y_hat = beta_0 + beta_1*data$hp + beta_2*data$wt
```

##### 4. Cálculo das densidades
$$ f(y_i | x_i, \beta, \sigma^2) $$

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
`$$\varepsilon | X \sim N(0, \sigma^2)$$`
- No exemplo abaixo, podemos ver que, para cada `\(x\)`, temos um valor ajustado `\(\hat{y} = \beta_0 + \beta_1 x\)` e seus desvios `\(\varepsilon\)` são normalmente distribuídos com a mesma variância `\(\sigma^2\)`

<center><img src="https://fhnishida.github.io/fearp/eco1/mle.jpg"></center>
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

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-151-1.png" width="672" />

```r
# Mazda RX4 Wag 
pdf_norm2 = dnorm(qt_norm, mean=bd_joined$mpg_hat[2], sd=sqrt(sigma2)) # pdf
plot(qt_norm, pdf_norm2, type="l", xlab="mpg", ylab="densidade", main="Mazda RX4 Wag")
abline(v=c(bd_joined$mpg_hat[2], bd_joined$mpg[2]), col="blue")
text(c(bd_joined$mpg_hat[2], bd_joined$mpg[2]), 0.2, 
     c(expression(widehat(mpg)[2]), expression(mpg[2])), 
     pos=2, srt=90, col="blue")
```

<img src="/project/Monitorias_grad_2022_files/figure-html/unnamed-chunk-151-2.png" width="672" />
- Logo, a verossimilhança (produto de todas probabilidades) será maior quanto mais próximos forem os valores ajustados dos seus respectivos valores observados.


##### 5. Calculando a Log-Verossimilhança
$$ \mathcal{l}(\beta, \sigma^2) = \sum^{N}_{i=1}{\ln\left[ f(y_i | x_i, \beta, \sigma^2) \right]} $$

```r
## Calculando a log-verossimilhanca
loglik = sum(log(y_pdf))
loglik
```

```
## [1] -153.4266
```


##### 6. Criando a Função de Log-Verossimilhança

```r
## Criando funcao para calcular log-verossimilhanca MQO 
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


##### 7. Otimização

Tendo a função objetivo, usaremos `optim()` para *minimizar*
$$ -\ln{L(\beta, \sigma^2 | y, X)} = -\sum^n_{i=1}{\ln{f(y_i | x_i, \beta, \sigma^2)}}. $$
Aqui, **minimizamos o negativo** da log-Verossimilhança para **maximizarmos** (função`optim()` apenas minimiza).


```r
## Maximizando a função log-verossimilhança MQO
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


### 3. Estimação por GMM
- [Computing Generalized Method of Moments and Generalized Empirical Likelihood with R (Pierre Chaussé)](https://cran.r-project.org/web/packages/gmm/vignettes/gmm_with_R.pdf)
- [Generalized Method of Moments (GMM) in R - Part 1 (Alfred F. SAM)](https://medium.com/codex/generalized-method-of-moments-gmm-in-r-part-1-of-3-c65f41b6199)


- Para estimar via GMM precisamos construir vetores relacionados aos seguintes momentos:
$$ E(\varepsilon) = 0 \qquad \text{ e } \qquad E(\varepsilon'X) = 0 $$
em que `\(X\)` é a matriz de covariadas e `\(\varepsilon\)` é o desvio. Note que estes são os momentos relacionados ao MQO, dado que este é um caso particular do GMM.


- Relembre que estamos usando a base de dados `mtcars` para estimar o modelo linear:
$$ \text{mpg} = \beta_0 + \beta_1 \text{hp} + \beta_2 \text{wt} + \varepsilon $$
que relaciona o consumo de combustível (em milhas por galão - _mpg_) com a potência (_hp_) e o peso (em mil libras - _wt_) do carro.


#### Otimização Numérica para GMM

##### 1. Chute de valores iniciais para `\(\beta_0\)`, `\(\beta_1\)` e `\(\beta_2\)`
- Vamos criar um vetor com possíveis valores de `\(\beta_0, \beta_1, \beta_2\)`:

```r
library(dplyr)

params = c(35, -0.02, -3.5)
beta_0 = params[1]
beta_1 = params[2]
beta_2 = params[3]
```

##### 2. Seleção da base de dados e variáveis

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

##### 3. Cálculo dos valores ajustados e dos desvios

```r
## Valores ajustados e desvios
y_hat = X %*% params
# equivalente a: y_hat = beta_0 + beta_1 * X[,"hp"] + beta_2 * X[,"wt"]

e = y - y_hat
```

##### 4. Criação da matriz de momentos
- Note que `\(E(\varepsilon' X)\)` é uma multiplicação matricial, mas a função `gmm()` exige que como input os vetores com multiplicação elemento a elemento do resíduo `\(\varepsilon\)` com as covariadas `\(X\)` (neste caso: constante, hp, wt)

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
- Note que, como multiplicamos a constante igual a 1 com os desvios `\(\varepsilon\)`, a 1ª coluna corresponde ao momento `\(E(\varepsilon)=0\)` (mas sem tomar a esperança).
- Já as colunas 2 e 3 correspodem ao momento `\(E(\varepsilon'X)=0\)` para as variáveis _hp_ e _wt_ (também sem tomar a esperança).
- Logicamente, para estimar por GMM, precisamos escolher os parâmetros `\(\theta = \{ \beta_0, \beta_1, \beta_2 \}\)` que, ao tomar a esperança em cada um destas colunas, se aproximem ao máximo de zero. Isso será feito via função `gmm()` (semelhante à função `optim()`)


##### 5. Criação de função com os momentos
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


##### 6. Otimização via função `gmm()`
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


# Modelo de Regressão Multivariado

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
O estimador de MQO é dado por:
$$ \hat{\beta} = (X'X)^{-1} X' y $$


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
$$ \hat{y} = X\hat{\beta} $$

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
$$ \varepsilon = y - \hat{y} $$

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
$$ \hat{\sigma}^2 = \frac{e'e}{n-k} $$

```r
## Estimando variancia do termo de erro
sigma2 = t(e) %*% e / (nrow(X) - ncol(X))
sigma2
```

```
##          e
## e 6.725785
```


#### 6. Calcular a matriz de covariâncias `\(\widehat{Cov}(\widehat{\beta})\)`
$$ \widehat{Cov}(\hat{\beta}) = \hat{\sigma}^2 (X'X)^{-1} $$

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


