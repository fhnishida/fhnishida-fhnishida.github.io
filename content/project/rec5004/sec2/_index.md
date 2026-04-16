---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Programming
summary: The page also contains a table of contents for his R programming project, which includes topics such as basic operations, objects in R, logical/boolean expressions, vectors, matrices, lists, data frames, extracting subsets, removing missing values (NA), vector/matrix operations, basic statistics on vectors and matrices, control structures (conditional (if), repetition (for), repetition (while)), and examples of optimization of univariate and bivariate functions.
title: R Programming
weight: 2
output: md_document
type: book
---




</br>

## Basic operations

```r
# Soma
1 + 1
```

```
## [1] 2
```

```r
# Subtração
2 - 3
```

```
## [1] -1
```

```r
# Multiplicação
2 * 3
```

```
## [1] 6
```

```r
# Divisão
6 / 4
```

```
## [1] 1.5
```

```r
# Divisão Inteira
6 %/% 4
```

```
## [1] 1
```

```r
# Resto da Divisão
6 %% 4
```

```
## [1] 2
```

```r
# Potenciação
2 ^ 3
```

```
## [1] 8
```

```r
8 ^ (1 / 3)
```

```
## [1] 2
```


</br>

## Objetos no R
 - [Data types, R objects and attributes (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/OS8hs/data-types-r-objects-and-attributes)
 
Para criar um objeto, atribuímos algo (neste caso, um valor) a um nome por meio do operador de atribuição `<-` ou `=`:

```r
obj1 <- 5
obj2 = 5 + 2
```

Note que ambos objetos foram criados e aparecem no quadrante superior/direito (_Environment_). Agora, podemos imprimir os seus valores executando o nome do objeto

```r
obj1
```

```
## [1] 5
```
ou imprimindo explicitamente por meio da função `print()`:

```r
print(obj2)
```

```
## [1] 7
```

Note que, podemos alterar um objeto atribuindo algo novo a ele:

```r
obj1 = obj2
obj1
```

```
## [1] 7
```

Uma forma bastante utilizada para alteração de valor de um objeto é utilizando o próprio valor de objeto como base:

```r
obj1 = obj1 + 3
obj1
```

```
## [1] 10
```
> Isto será especialmente relevante quando trabalharmos com repetições/loops.


É possível visualizar o tipo de objeto usando a função `class()`:

```r
class(obj1)
```

```
## [1] "numeric"
```

Logo, `obj1` é um número real. Há 5 tipos de classes de objetos "atômicos" (que contêm apenas 1 valor):

 - `character`: texto
 - `numeric`: número real
 - `integer`: número inteiro
 - `complex`: número complexo
 - `logical`: verdadeiro/falso (1 ou 0)
 

```r
num_real = 3
class(num_real)
```

```
## [1] "numeric"
```

```r
num_inteiro = 3L # para número inteiro, usar sufixo L
class(num_inteiro)
```

```
## [1] "integer"
```

```r
texto = "Oi"
print(texto)
```

```
## [1] "Oi"
```

```r
class(texto)
```

```
## [1] "character"
```

```r
boolean = 2>1
print(boolean)
```

```
## [1] TRUE
```

```r
class(boolean)
```

```
## [1] "logical"
```

```r
boolean2 = T # poderia escrever TRUE 
print(boolean2)
```

```
## [1] TRUE
```

```r
boolean3 = F # poderia escrever FALSE
print(boolean3)
```

```
## [1] FALSE
```


### Expressões lógicas/booleanas
São expressões que retornam o valor Verdadeiro ou Falso:

```r
class(TRUE)
```

```
## [1] "logical"
```

```r
class(FALSE)
```

```
## [1] "logical"
```

```r
T + F + T + F + F # soma de 1's (TRUE) e 0's (FALSE)
```

```
## [1] 2
```

```r
2 < 20
```

```
## [1] TRUE
```

```r
19 >= 19
```

```
## [1] TRUE
```

```r
100 == 10^2
```

```
## [1] TRUE
```

```r
100 != 20*5
```

```
## [1] FALSE
```

É possível escrever expressões compostas utilizando `|` (ou) e `&` (e):

```r
x = 20
x < 0 | x^2 > 100
```

```
## [1] TRUE
```

```r
x < 0 & x^2 > 100
```

```
## [1] FALSE
```

> **Tabela de Precedência de Operadores**
> 
> - Nível 6 - potenciação: `^`
> - Nível 5 - multiplicação: `*`, `/`, `%/%`, `%%`
> - Nível 4 - adição: `+`, `-`
> - Nível 3 - relacional: `==`, `!=`, `<=`, `>=`, `>`, `<`
> - Nível 2 - lógico: `&` (e)
> - Nível 1 - lógico: `|` (ou)


### Vetores
- [Data types - Vectors and lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/wkAHm/data-types-vectors-and-lists)

Depois das 5 classes de objetos apresentadas acima, as mais básicas são os vetores e as listas, que possuem mais de um elemento dentro do objeto. Um vetor necessariamente exige que os elementos sejam da mesma classe. Podemos criar um vetor usando a função `c()` e incluindo os valores separados por `,`:

```r
x = c(0.5, 0.6) # numeric
x = c(TRUE, FALSE) # logical
x = c("a", "b", "c") # character
x = 9:12 # integer (é igual a c(9, 10, 11, 12))
x = c(1+0i, 2+4i) # complex
```


Se utilizarmos a função `c()` com elementos de classes diferentes, o R transforma a classe do objeto para o "mais geral":

```r
y = c(1.7, "a") # (numeric, character) -> character
class(y)
```

```
## [1] "character"
```

```r
y = c(FALSE, 0.75) # (logical, numeric) -> numeric
class(y)
```

```
## [1] "numeric"
```

```r
y = c("a", TRUE) # (character, logical) -> character
class(y)
```

```
## [1] "character"
```

> **Note que**:
>
> character > complex > numeric > integer > logical

Também podemos forçar a mudança de classe de objeto para a classe "menos geral", o que acaba transformando:

- os elementos "mais gerais" em missing values (NA's),

```r
as.numeric(c(1.7, "a")) # (numeric, character)
```

```
## Warning: NAs introduzidos por coerção
```

```
## [1] 1.7  NA
```

```r
as.logical(c("a", TRUE)) # (character, logical) 
```

```
## [1]   NA TRUE
```
- [exceção] de _character_ com número (por exemplo, "9") para _numeric_: torna-se _numeric_

```r
as.numeric(c(1.7, "9")) # (numeric, character número)
```

```
## [1] 1.7 9.0
```
- [exceção] de _numeric_ diferente de zero para _logical_: torna-se TRUE
- [exceção] de _numeric_ igual a zero para _logical_: torna-se FALSE

```r
as.logical(c(FALSE, 0.75, -10)) # (logical, numeric > 0, numeric < 0)
```

```
## [1] FALSE  TRUE  TRUE
```

```r
as.logical(c(TRUE, 0)) # (logical, numeric zero) 
```

```
## [1]  TRUE FALSE
```
- [exceção] de _character_ lógico ("TRUE", "T", "FALSE", "F") para _logical_: torna-se _logical_ ("0" e "1" tornam-se NA)

```r
as.logical(c("T", "FALSE", "1", TRUE)) # (character TRUE/FALSE, logical) 
```

```
## [1]  TRUE FALSE    NA  TRUE
```

#### Construção de vetor de sequência
- Uma forma interessante de construir um vetor numérico com uma sequência é utilizando a função `seq()`

```yaml
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, ...)

- from, to: the starting and (maximal) end values of the sequence.
- by:	number, increment of the sequence.
- length.out (length): desired length of the sequence.
```
- Note que todos argumentos já possuem valores pré-definidos, então podemos montar sequências de maneiras distintas.
- Considerando o preenchimento dos argumentos `from` e `to`, podemos:
    - definir `by` para dar um valor de quanto varia entre um elemento e outro, ou
    - definir `length.out` (ou simplesmente `length`) para informar a quantidade de elementos que terá na sequência

```r
seq(from=0, to=10, by=2)
```

```
## [1]  0  2  4  6  8 10
```

```r
seq(from=0, to=10, length=5)
```

```
## [1]  0.0  2.5  5.0  7.5 10.0
```

#### Construção de vetor com elementos repetidos
- Podemos construir vetores com elementos repetidos usando a função `rep()`
```yaml
rep(x, times)

- x: a vector (of any mode including a list) or a factor.
- times: an integer-valued vector giving the (non-negative) number of times to repeat each element, or to repeat the whole vector.
```

```r
rep(0, 10) # repetição de 10 zeros
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0
```

```r
rep(c("a", "b"), 2) # repetição do vetor c("a", "b")
```

```
## [1] "a" "b" "a" "b"
```


### Matrizes
Matrizes também possuem elementos de mesma classe, mas bidimensional. Uma matriz pode ser criada usando a função `matrix()`:

```yaml
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, ...)

- data: an optional data vector (including a list or expression vector). Non-atomic classed R objects are coerced by as.vector and all attributes discarded.
- nrow: the desired number of rows.
- ncol: the desired number of columns.
- byrow: logical. If FALSE (the default) the matrix is filled by columns, otherwise the matrix is filled by rows.
```


```r
# matriz de NAs
m = matrix(nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]   NA   NA   NA
```

```r
# matriz de 0s
m = matrix(0, 2, 3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
```

É possível construir uma matriz "preenchida" informando os seus (nº linhas {{<math>}}$\times${{</math>}} nº colunas) valores por meio de um vetor. Os elementos deste vetor preenchem primeiro todas linhas de uma coluna para, depois, preencher a próxima coluna (_column-wise_):

```r
m = matrix(1:6, nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


Outra maneira de criar matrizes é juntando vetores em colunas (_column-binding_) ou em linhas (_row-binding_), usando as funções `cbind()` e `rbind()`, respectivamente:


```r
x = 1:3
y = 10:12

cbind(x, y) # juntando por coluna
```

```
##      x  y
## [1,] 1 10
## [2,] 2 11
## [3,] 3 12
```

```r
rbind(x, y) # juntando por linha
```

```
##   [,1] [,2] [,3]
## x    1    2    3
## y   10   11   12
```


### Arrays
Arrays são "matrizes" com mais de duas dimensões.
```yaml
array(data = NA, dim = length(data), dimnames = NULL)

- data: a vector (including a list or expression vector) giving data to fill the array. Non-atomic classed objects are coerced by as.vector.
- dim: the dim attribute for the array to be created, that is an integer vector of length one or more giving the maximal indices in each dimension.
- dimnames: either NULL or the names for the dimensions.
```


```r
# arrays de NAs de dimensões 1 x 2 x 3
a = array(dim=c(1, 2, 3))
a
```

```
## , , 1
## 
##      [,1] [,2]
## [1,]   NA   NA
## 
## , , 2
## 
##      [,1] [,2]
## [1,]   NA   NA
## 
## , , 3
## 
##      [,1] [,2]
## [1,]   NA   NA
```

```r
# matriz preenchida de dimensões 1 x 2 x 3
a = array(1:6, c(1, 2, 3))
a
```

```
## , , 1
## 
##      [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
##      [,1] [,2]
## [1,]    5    6
```



### Listas
Já uma lista permite que os valores pertençam a classes distintas, inclusive podendo conter um vetor como elemento. Ela pode ser criada por meio da função `list()`:

```r
x = list(1, "a", TRUE, 1+4i, c(0.5, 0.6))
x
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] "a"
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] 1+4i
## 
## [[5]]
## [1] 0.5 0.6
```

```r
class(x)
```

```
## [1] "list"
```


### Data frames
- [Data types - Data frames (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/kz1Lh/data-types-data-frames)

- É um tipo especial de lista, where cada elemento da lista possui o mesmo tamanho
- Cada elemento da lista pode ser entendida como uma coluna de uma base de dados
- Diferente de matrizes, cada elemento de um _data frame_ pode ser de uma classe diferente 
- Normalmente é criada automaticamente ao carregarmos uma base de dados em .txt ou .csv via `read.table()` ou `read.csv()`
- Mas também pode ser criada manualmente via `data.frame()`

```yaml
data.frame(...)
... : these arguments are of either the form value or tag = value
```


```r
x = data.frame(foo=1:4, bar=c(T, T, F, F))
x
```

```
##   foo   bar
## 1   1  TRUE
## 2   2  TRUE
## 3   3 FALSE
## 4   4 FALSE
```

```r
nrow(x) # Número de linhas de x
```

```
## [1] 4
```

```r
ncol(x) # Número de colunas de x
```

```
## [1] 2
```


#### Importando data frames
- [Reading tabular data (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/bQ5B9/reading-tabular-data)
- Para leitura de base de dados, as funções mais utilizadas são `read.table()` e `read.csv()`
- O `read.table()` tem o seguinte argumentos (que também podem ser visto nas demais funções de leitura de base de dados):
    - `file`: caminho/endereço do arquivo, incluindo a sua extensão
    - `header`: `TRUE` ou `FALSE` indicando se a 1ª linha da base de dados é um cabeçalho
    - `sep`: indica como as colunas são separadas
    - `stringAsFactors`: `TRUE` ou `FALSE` se as variáveis de texto devem ser transformadas em _factors_.
```r
data_txt = read.table("mtcars.txt") # também lê .csv
data_csv = read.csv("mtcars.csv")
```
- Caso queira testar, faça download das bases: [mtcars.txt](../mtcars.txt) e [mtcars.csv](../mtcars.csv)
- Note que, caso você não tenha definido o diretório de trabalho, é necessário informar o caminho/endereço inteiro do arquivo que você quer importar:
```r
data = read.table("C:/Users/Fabio/OneDrive/FEA-RP/mtcars.csv")
```
- `read.csv()` é igual ao `read.table()`, mas considera como padrão que o separador de colunas é a vírgula (`sep = ","`)
- Para gravar uma base de dados, utilizamos as funções `write.csv()` e `write.table()`, nas quais informamos um data frame e o nome do arquivo (junto de sua extensão).


#### Importando em outros formatos
- Para abrir arquivos em Excel, nos formatos .xls e xlsx, é necessário utilizar o [pacote `xlsx`](https://cran.r-project.org/web/packages/xlsx/xlsx.pdf)
```r
read.xlsx("mtcars.xlsx", sheetIndex=1) # Lendo a 1ª aba do arquivo Excel
```
Caso queira testar, faça download da base [mtcars.xlsx](../mtcars.xlsx)
- Para abrir arquivos de SPSS, Stata e SAS, é necessário utilizar o pacote `haven` e, respectivamente, as funções `read_spss()`, `read_dta()` e `read_sas()`

> Note que no padrão do R, o separador decimal é o ponto (`.`), enquanto no padrão brasileiro usa-se vírgula.
>
> Isso pode gerar importação equivocada dos valores, caso o .csv ou o .xlsx tenham sido gerados no padrão brasileiro.
>
> Para contornar este problema, utilize as funções de importação `read.csv2()` e `read.xlsx2()` para que os dados sejam lidos a partir do padrão brasileiro e os dados sejam importados corretamente
> Caso queira testar, faça download das bases: [mtcars_br.csv](../mtcars_br.csv) e [mtcars_br.xlsx](../mtcars_br.xlsx)


</br>

## Extraindo Subconjuntos
- [Subsetting - Basics (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/JDoLX/subsetting-basics)
- Há 3 operadores básicos para extrair subconjuntos de objetos no R:
    - `[]`: retorna um "sub-objeto" da mesma classe do objeto original
    - `[[]]`: usado para extrair elementos de uma lista ou data frame, where o "sub-objeto" não é necessariamente da mesma classe do objeto original
    - `$`: usado para extrair elemento de uma lista ou data frame pelo nome


### Subconjunto de vetores

```r
x = c(1, 2, 3, 3, 4, 1)
x[1] # extraindo o 1º elemento de x
```

```
## [1] 1
```

```r
x[1:4] # extraindo do 1º ao 4º elemento de x
```

```
## [1] 1 2 3 3
```


- Note que, ao fazer uma expressão lógica com um vetor, obtemos um _vetor lógico_

```r
x > 1
```

```
## [1] FALSE  TRUE  TRUE  TRUE  TRUE FALSE
```
- Usando o operador `[]`, podemos extrair um subconjunto do vetor `x` usando uma condição. Por exemplo, vamos extrair apenas valores maiores do que 1:

```r
x[x > 1]
```

```
## [1] 2 3 3 4
```

```r
x[c(F, T, T, T, T, F)] # Equivalente ao x[x > 1] - Extrair apenas TRUE's
```

```
## [1] 2 3 3 4
```

### Subconjunto de listas
- [Subsetting - Lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/hVKHm/subsetting-lists)
- Note que, diferente do vetor, para acessar um valor/elemento de uma lista é necessário utilizar `[[]]` com o número da posição do elemento da lista

```r
x = list(foo=1:4, bar=0.6)
x
```

```
## $foo
## [1] 1 2 3 4
## 
## $bar
## [1] 0.6
```

```r
x[1] # retorna a lista foo
```

```
## $foo
## [1] 1 2 3 4
```

```r
class(x[1])
```

```
## [1] "list"
```

```r
x[[1]] # retorna o vetor foo de classe numeric
```

```
## [1] 1 2 3 4
```

```r
class(x[[1]])
```

```
## [1] "integer"
```
- Se quiser acessar um elemento dentro deste elemento da lista, precisa ser seguido por `[]`

```r
x[[1]][2]
```

```
## [1] 2
```

```r
x[[2]][1]
```

```
## [1] 0.6
```
- Também podemos usar o nome para extrair um subconjunto do objeto

```r
x[["foo"]]
```

```
## [1] 1 2 3 4
```

```r
x$foo
```

```
## [1] 1 2 3 4
```


### Subconjunto de matrizes e de data frames
- [Subsetting - Matrices (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/4gSc1/subsetting-matrices)
- Para extrair um pedaço de uma matriz ou de um data frame, indicamos as linhas e as colunas dentro do operador `[]`

```r
x = matrix(1:6, 2, 3)
x
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
x[1, 2] # linha 1 e coluna 2 da matriz x
```

```
## [1] 3
```

```r
x[1:2, 2:3] # linha 1 e colunas 2 e 3 da matriz x
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```
- É possível selecionar linhas/colunas usando um vetor lógico (`TRUE`'s e `FALSE`'s) de mesmo comprimento da dimensão:

```r
x[, c(F, T, T)] # vet. lógico selecionando as 2 últimas colunas
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```
- Podemos selecionar linhas ou colunas inteiras ao não informar os índices:

```r
x[1, ] # linha 1 e todas colunas
```

```
## [1] 1 3 5
```

```r
x[, 2] # todas linhas e coluna 2
```

```
## [1] 3 4
```


- O mesmo pode ser utilizado para arrays, porém com mais dimensões

```r
x = array(1:16, c(1, 2, 3)) # array com 3 dimensões
x
```

```
## , , 1
## 
##      [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
##      [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
##      [,1] [,2]
## [1,]    5    6
```

```r
x[1, 1, 2] # extraindo valor com índices (1, 1, 2)
```

```
## [1] 3
```


### Removendo valores ausentes (`NA`)
- [Subsetting - Removing missing values (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/Qy8bH/subsetting-removing-missing-values)
- Remover dados faltantes é uma ação comum quando manipulamos bases de dados
- Para verificar quais dados são `NA`, usa-se a função `is.na()`

```r
x = c(1, 2, NA, 4, NA, NA)
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE  TRUE
```

```r
sum(is.na(x)) # qtd de missing values
```

```
## [1] 3
```
- Relembre que o operador `!` nega uma expressão e, portanto, `!is.na()` nos resulta os elementos que **não** são ausentes

```r
x[ !is.na(x) ]
```

```
## [1] 1 2 4
```


</br>



## Estatísticas básicas
- **Valores Absolutos**: `abs()`

```r
x = c(1, 4, -5, 2, 8, -2, 4, 7, 8, 0, 2, 3, -5, 7, 4, -4, 2, 5, 2, -3)
x
```

```
##  [1]  1  4 -5  2  8 -2  4  7  8  0  2  3 -5  7  4 -4  2  5  2 -3
```

```r
abs(x)
```

```
##  [1] 1 4 5 2 8 2 4 7 8 0 2 3 5 7 4 4 2 5 2 3
```
- **Soma**: `sum(..., na.rm = FALSE)`

```r
sum(x)
```

```
## [1] 40
```
- **Média**: `mean(x, trim = 0, na.rm = FALSE, ...)`

```r
mean(x)
```

```
## [1] 2
```
- **Desvio Padrão**: `sd(x, na.rm = FALSE)`

```r
sd(x)
```

```
## [1] 4.129483
```
- **Quantis**: `quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE, ...)`

```r
# Mínimo, 1º Quartil, Mediana, 3º Quartil e Máximo
quantile(x, probs=c(0, .25, .5, .75, 1))
```

```
##    0%   25%   50%   75%  100% 
## -5.00 -0.50  2.00  4.25  8.00
```
- **Máximo** e **Mínimo**: `max(..., na.rm = FALSE)` e `min(..., na.rm = FALSE)`

```r
# Mínimo, 1º Quartil, Mediana, 3º Quartil e Máximo
max(x) # Valor máximo
```

```
## [1] 8
```

```r
min(x) # Valor mínimo
```

```
## [1] -5
```

- Para obter os índices de todos os elementos iguais ao valor máximo/mínimo, podemos usar a função `which()` que tem como argumento um **vetor lógico** (de `TRUE`'s e `FALSE`'s) como input, e gera um vetor/matriz de índices:
```yaml
which(x, arr.ind = FALSE, ...)
    
- x: a logical vector or array. NAs are allowed and omitted (treated as if FALSE).
- arr.ind: logical; should array indices be returned when x is an array?
```

```r
x == max(x) # vetor lógico (TRUE's são os máximos)
```

```
##  [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
which(x == max(x)) # vetor de índices de elementos com valores máximos
```

```
## [1] 5 9
```

```r
x[which(x == max(x))] # valores máximos
```

```
## [1] 8 8
```

```r
x[which(x == min(x))] # valores máximos
```

```
## [1] -5 -5
```

- Isso também é válido para matrizes, mas se quisermos ter o índice da linha e da coluna, precisamos usar o argumento `arr.ind = TRUE`

```r
x = matrix(1:6, nrow=2)
x
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

```r
which(x == max(x)) # retorna um número único
```

```
## [1] 6
```

```r
which(x == max(x), arr.ind = T) # retorna um vetor de números
```

```
##      row col
## [1,]   2   3
```


- Note que, se houver valores ausentes (`NA`), a função retorna `NA` por padrão. Para excluir os valores ausentes, precisamos definir o argumento `na.rm = TRUE`:

```r
x = c(1, 4, -5, 2, NA, -2, 4, 7, NA, 0, 2, 3, -5, NA, 4, -4, NA, 5, 2, NA)
max(x) # Sem excluir valores ausentes
```

```
## [1] NA
```

```r
max(x, na.rm=TRUE) # Excluindo valores ausentes
```

```
## [1] 7
```


### Example: Otimização de função univariada
- Queremos encontrar o {{<math>}}$x${{</math>}} que minimiza a função univariada {{<math>}}$f(x) = x^2 + 4x - 4${{</math>}}, ou seja,
    $$ \text{arg} \min_x (x^2 + 4x - 4) $$
- Ver no [Wolfram](https://www.wolframalpha.com/input?i=solve+x%5E2+%2B+4x+-+4+%3D+0)
- Para resolver numericamente, podemos chutar diversos valores de {{<math>}}$x${{</math>}} e pegar o menor valor
- Primeiro, vamos construir um vetor com diversos valores de {{<math>}}$x${{</math>}} no intervalo {{<math>}}$[-5, 5]${{</math>}}.

```r
x_grid = seq(-5, 5, length=20)
x_grid
```

```
##  [1] -5.0000000 -4.4736842 -3.9473684 -3.4210526 -2.8947368 -2.3684211
##  [7] -1.8421053 -1.3157895 -0.7894737 -0.2631579  0.2631579  0.7894737
## [13]  1.3157895  1.8421053  2.3684211  2.8947368  3.4210526  3.9473684
## [19]  4.4736842  5.0000000
```
- Agora, vamos calcular o valor de {{<math>}}$f(x)${{</math>}} para cada possível {{<math>}}$x${{</math>}}

```r
fx = x_grid^2 + 4*x_grid - 4 
```
- Note que cada elemento calculado em `fx_grid` corresponde a um {{<math>}}$x${{</math>}} na mesma posição/índice em `x_grid`

```r
head( cbind(x=x_grid, fx=fx), 6) # mostrando os 6 primeiros valores
```

```
##              x        fx
## [1,] -5.000000  1.000000
## [2,] -4.473684 -1.880886
## [3,] -3.947368 -4.207756
## [4,] -3.421053 -5.980609
## [5,] -2.894737 -7.199446
## [6,] -2.368421 -7.864266
```
- Agora, vamos ver o valor e a *posição* de {{<math>}}$x${{</math>}} que minimiza a função:

```r
min(fx) # f(x) mínimo
```

```
## [1] -7.975069
```

```r
argmin = which(fx == min(fx)) # índice de x que maximiza
argmin
```

```
## [1] 7
```
- Para recuperar o valor de {{<math>}}$x${{</math>}} que minimiza {{<math>}}$f(x)${{</math>}}, precisamos usar o índice encontrado para encontrar no vetor `x_grid`:

```r
x_grid[argmin]
```

```
## [1] -1.842105
```
- Observe que podemos aumentar a precisão aumentando o número de possíveis valores de {{<math>}}$x${{</math>}} no `x_grid`. Por outro lado, em contas mais complexas, pode elevar muito o tempo de execução do comando.



</br>

## Estruturas de controle
- Estruturas de controle no R permitem o controle do fluxo do programa

### Condicional (`if`)
- [Control structures - If/Else (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/PDOOA/control-structures-if-else)

```r
x = 5
if (x > 10) {
    y = 10
} else if (x > 0) {
    y = 5
} else {
    y = 0
}
y
```

```
## [1] 5
```

- Essa mesma estrutura também pode atribuir diretamente um valor a um objeto

```r
x = 5
y = if (x > 10) {
    10
} else if (x > 0) {
    5
} else {
    0
}
y
```

```
## [1] 5
```


### Repetição (`for`)
- [Control structures - For loops (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/baydC/control-structures-for-loops)
- A repetição usando `for` exige que você insira um vetor e defina um nome para a variável de indicação

```r
for(i in 3:7) {
    print(i)
}
```

```
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
```
- Acima, nomeamos a variável de indicação como `i` e inserimos um vetor de números inteiros entre 3 e 7.
- A cada _iteração_ (loop) é atribuído ao `i` um valor do vetor `3:7`, até "acabarem" todos os elementos do vetor
- Sequências são interessantes para incluir em repetições utilizando `for`

```r
sequencia = seq(1, 5, length.out=11)
sequencia
```

```
##  [1] 1.0 1.4 1.8 2.2 2.6 3.0 3.4 3.8 4.2 4.6 5.0
```

```r
for (val in sequencia) {
    print(val^2)
}
```

```
## [1] 1
## [1] 1.96
## [1] 3.24
## [1] 4.84
## [1] 6.76
## [1] 9
## [1] 11.56
## [1] 14.44
## [1] 17.64
## [1] 21.16
## [1] 25
```


### Repetição (`while`)
- [Control structures - While loops (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/WWXg6/control-structures-while-loops)
- Diferente do `for`, a repetição via `while` exige que uma variável de indicação já esteja criada previamente antes de entrar no loop
- Isto se dá, pois os loops (inclusive o primeiro) só serão realizados se uma condição for verdadeira
- Note que, por não seguir uma sequência de elemento dentro de um vetor (como no `for`), **é necessário que a variável de indicação seja atualizada a cada iteração para que a repetição não seja feita infinitamente**.
- Um forma comum de executar o `while` é definindo a variável de indicação como um contador, isto é, ir contando a quantidade de loops realizados e parar em uma determinada quantidade

```r
contador = 0

while (contador <= 10) {
    print(contador)
    contador = contador + 1
}
```

```
## [1] 0
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 9
## [1] 10
```
- Uma alternativa à variável de indicação que funciona como contador: valor a ser calculado em cada iteração até convergir (chegar a um valor muito pequeno) ou ultrapassar algum valor limite. No exemplo abaixo, a cada loop da variável de indicação `distancia` diminuirá pela metade e irá parar num valor bem próximo de 0 (algum valor menor do que `\(10^{-3}\)`)

```r
distancia = 10
tolerancia = 1e-3 # = 1 x 10^(-3) = 0.001

while (distancia > tolerancia) {
    distancia = distancia / 2
}

distancia
```

```
## [1] 0.0006103516
```


### Example: Preenchendo matriz a partir de uma _f(x,y)_
- É comum o uso de uma estrutura de repetição dentro de outra estrutura de repetição (repetições encaixadas).
- Como exemplo, calcularemos a função
{{<math>}}$$ f(x,y) = 2x^2 - y^2 + 3xy, $${{</math>}}
para cada combinação de {{<math>}}$x \in \boldsymbol{X}=\{ -5, -4, -3, ..., 3, 4, 5\}${{</math>}} e de {{<math>}}$y \in \boldsymbol{Y}=\{ 0, 2, 4, 6, 8, 10\} ${{</math>}}.

Uma matriz será preenchida com os valores:

{{<math>}}$$ \begin{pmatrix}
f(-5, 0) & f(-5, 2) & \cdots & f(-5, 10) \\
f(-4, 0) & f(-4, 2) & \cdots & f(-4, 10) \\
\vdots & \vdots & \ddots & \vdots \\
f(5, 0) & f(5, 2) & \cdots & f(5, 10)
\end{pmatrix} $${{</math>}}


No R:

```r
X = seq(-5, 5, by=1)
Y = seq(0, 10, by=2)
fxy = matrix(NA, nrow=length(X), ncol=length(Y)) # Criando matrix 11 x 6

# Preenchimento da matriz com a f(x,y)
for (i in 1:length(X)) {
    # Dado um valor de linha, preenche todas colunas
    for (j in 1:length(Y)) {
        fxy[i, j] = 2*X[i]^2 - Y[j]^2 + 3*X[i]*Y[j]
    }
    # Terminada todas colunas de uma linha, começa novo loop na próxima linha
}
fxy
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6]
##  [1,]   50   16  -26  -76 -134 -200
##  [2,]   32    4  -32  -76 -128 -188
##  [3,]   18   -4  -34  -72 -118 -172
##  [4,]    8   -8  -32  -64 -104 -152
##  [5,]    2   -8  -26  -52  -86 -128
##  [6,]    0   -4  -16  -36  -64 -100
##  [7,]    2    4   -2  -16  -38  -68
##  [8,]    8   16   16    8   -8  -32
##  [9,]   18   32   38   36   26    8
## [10,]   32   52   64   68   64   52
## [11,]   50   76   94  104  106  100
```


<!-- ### Example 2: Otimização de função bivariada -->
<!-- - Queremos encontrar o {{<math>}}$x${{</math>}} que minimiza a função univariada {{<math>}}$f(x, z) = x^2 + 4z^2 - 4${{</math>}}, ou seja, -->
<!--     $$ \text{arg} \min_{x, z} (x^2 + 4z^2 - 4) $$ -->
<!-- - Primeiro, vamos criar vetores de possíveis valores de `\(x\)` e `\(z\)`. -->
<!-- ```{r} -->
<!-- x_grid = seq(-5, 5, length=11) -->
<!-- z_grid = seq(-6, 6, length=11) -->
<!-- ``` -->
<!-- - Agora, vamos criar uma matriz where cada linha representa um valor de {{<math>}}$x${{</math>}} e cada coluna representa um valor de {{<math>}}$z${{</math>}}: -->
<!-- ```{r} -->
<!-- # Criando matriz para preencher -->
<!-- fxz = matrix(NA, length(x_grid), length(z_grid)) -->

<!-- # Nomeando linhas e colunas -->
<!-- rownames(fxz) = x_grid -->
<!-- colnames(fxz) = z_grid -->

<!-- fxz -->
<!-- ``` -->
<!-- - Agora, vamos preencher cada possível combinação usando a estrutura de repetição dentro de outra repetição. -->

<!-- ```{r} -->
<!-- # Preenchimento da matriz fxz -->
<!-- for (lin_x in 1:length(x_grid)) { -->
<!--     for (lin_z in 1:length(z_grid)) { -->
<!--         fxz[lin_x, lin_z] = x_grid[lin_x]^2 + 4*z_grid[lin_z]^2 -4 -->
<!--     } -->
<!-- } -->
<!-- fxz -->
<!-- ``` -->
<!-- - Para recuperar a dupla {{<math>}}$(x, z)${{</math>}} que minimiza {{<math>}}$f(x, z)${{</math>}}, precisamos usar a função `which.min()` usando argumento `arr.ind=TRUE`: -->
<!-- ```{r} -->
<!-- argmin = which(fxz==min(fxz), arr.ind = TRUE) -->
<!-- argmin -->

<!-- argmin_x = x_grid[argmin[1]] # aplicando índice de x em x_grid -->
<!-- argmin_z = z_grid[argmin[2]] # aplicando índice de z em z_grid -->

<!-- paste0("O par (x = ", argmin_x, ", z = ", argmin_z, ") minimizam a função f(x,z).") -->
<!-- ``` -->



</br>

## Criando funções
- [Your first R function (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/BM3dR/your-first-r-function)
- Para criar uma função, usamos a função `function(){}`:
    - dentro dos parêntesis `()`, incluímos nomes de variáveis arbitrárias (argumentos/inputs) que serão utilizadas pela função para fazer cálculos
    - dentro das chaves `{}`, usamos os nomes das variáveis arbitrárias definidas dentro do parêntesis para fazer cálculos e retornar um output (último valor dentro das chaves)
- Como exemplo, criaremos uma função que pega 2 números como inputs e retorna sua soma

```r
soma = function(a, b) {
    a^2 + b
}
```
- Ao atribuir a função ao objeto `soma` não geramos resultados. Para fazer isso, usamos a função `soma()` inserindo 2 números como inputs:

```r
soma(10, 4)
```

```
## [1] 104
```
- Note que as variáveis arbitrárias `a` e `b` são utilizadas apenas dentro da função
```r
> a
Error: object 'a' not found
```

- Note que podemos inserir um valor padrão para um argumento de função. Como exemplo, criaremos uma função que retorna todos elementos acima de `n` de um vetor dado:

```r
vetor = 1:20
above = function(x, n = 10) {
    x[x > n]
}

above(vetor) # todos acima do valor padrão 10
```

```
##  [1] 11 12 13 14 15 16 17 18 19 20
```

```r
above(vetor, 14) # todos acima de 14
```

```
## [1] 15 16 17 18 19 20
```






{{< cta cta_text="👉 Proceed to Data Manipulation" cta_link="../sec3" >}}
