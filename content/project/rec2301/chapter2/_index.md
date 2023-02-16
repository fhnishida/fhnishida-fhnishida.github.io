---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: R Programming
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: R Programming
weight: 2
output: md_document
type: book
---




## Operações básicas

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

### Textos
- Só será abordado um conteúdo bem básico para trabalhar com texto.
- Para mais conteúdo:
    - [Editing text variables (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/drpnT/editing-text-variables)
    - [Regular expressions I (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/bNiON/regular-expressions-i)
    - [Regular expressions II (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/QvbWt/regular-expressions-ii)
- Para extrair parte de um texto, usamos a função `substr()`
```yaml
substr(x, start, stop)

x: a character vector.
start: integer. The first element to be replaced.
stop: integer. The last element to be replaced.
```


```r
substr("shampoo", 1, 3) # extraindo caracteres 1 a 3 do texto
```

```
## [1] "sha"
```

```r
substr(110521, 4, 6) # também pode ser feito em números (torn-se texto)
```

```
## [1] "521"
```
- Isto pode ser interessante, por exemplo, com códigos de localidades do IBGE:

```r
cod_distrito = 110001515 # Distrito de Filadélfia d'Oeste
substr(cod_distrito, 1, 7) # Município de Alta Floresta d'Oeste
```

```
## [1] "1100015"
```

```r
substr(cod_distrito, 1, 2) # UF Rondônia
```

```
## [1] "11"
```
- Eventualmente, uma base de dados pode vir com os códigos de UF, município e distrito de forma separada e precisamos juntar os códigos:

```r
cod_uf = 11
cod_municipio = 15
cod_distrito = 15
```
- No entanto, como o código parcial do município veio como número, precisamos adicionar uma certa quantidade de zeros na frente para ficar com 5 caracteres e ficar no padrão do IBGE. Para fazer isso, usamos a função `sprintf()` com a formatação `fmt="%05d"` (número com 5 dígitos)
```yaml
sprintf(fmt, ...)

fmt: a character vector of format strings, each of up to 8192 bytes.
...	: values to be passed into fmt. Only logical, integer, real and character vectors are supported, but some coercion will be done. Up to 100.
```

```r
sprintf("%05d", cod_municipio)
```

```
## [1] "00015"
```
- Agora, para juntar textos (podendo incluir números), usamos as funções `paste0()` e `paste()`. A diferença entre eles é que o `paste0()` não incluir um separador entre os textos, e o `paste()` inclui um separador (o padrão é um espaço):

```r
paste0(cod_uf, sprintf("%05d", cod_municipio), cod_distrito)
```

```
## [1] "110001515"
```

```r
paste(cod_uf, sprintf("%05d", cod_municipio), cod_distrito)
```

```
## [1] "11 00015 15"
```


### Datas e horários
- [Dates and times (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/yl7BO/dates-and-times)
- [Working with dates (John Hopkins/Coursera)](https://www.coursera.org/learn/data-cleaning/lecture/0rohY/working-with-dates)
- R usa uma representação especial para datas e horários
- Datas são representadas na classe `Date`
    - São armazenadas internamente como _número de dias_ desde 1970-01-01
    - Para transformar um texto em uma data, usamos a função `as.Date()`
    

```r
x = as.Date("1970-01-01")
class(x)
```

```
## [1] "Date"
```

```r
x
```

```
## [1] "1970-01-01"
```

```r
unclass(x) # Dia 0
```

```
## [1] 0
```

```r
unclass(as.Date("1969-12-31")) # Dia -1
```

```
## [1] -1
```

- Horários são representadas na classe `POSIXct` (apenas um _integer_ bem grande) ou `POSIXlt` (_lista_ guarda mais informações - dia da semana, dia do ano, mês, dia do mês)
     - São armazenadas internamente como _número de segundos_ desde:
        - **1970**-01-01, se `POSIXct`
        - **1900**-01-01, se `POSIXlt`


```r
## POSIXct
x = as.POSIXct("1970-01-01")
x
```

```
## [1] "1970-01-01 -03"
```

```r
class(x)
```

```
## [1] "POSIXct" "POSIXt"
```

```r
unclass(x) # Nº de segundos desde 1970-01-01 (dado fuso horário)
```

```
## [1] 10800
## attr(,"tzone")
## [1] ""
```

```r
## POSIXlt
p = as.POSIXlt("1970-01-01")
class(p)
```

```
## [1] "POSIXlt" "POSIXt"
```

```r
unclass(p) # informações desde 1900
```

```
## $sec
## [1] 0
## 
## $min
## [1] 0
## 
## $hour
## [1] 0
## 
## $mday
## [1] 1
## 
## $mon
## [1] 0
## 
## $year
## [1] 70
## 
## $wday
## [1] 4
## 
## $yday
## [1] 0
## 
## $isdst
## [1] 0
## 
## $zone
## [1] "-03"
## 
## $gmtoff
## [1] NA
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
100 == 10**2
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
x < 0 | x**2 > 100
```

```
## [1] TRUE
```

```r
x < 0 & x**2 > 100
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


Também é possível criar um vetor "em branco" usando a função `vector()` e definindo a classe dos seus elementos junto de seu tamanho:

```yaml
vector(mode = "logical", length = 0)

mode: character string naming an atomic mode or "list" or "expression" or (except for vector) "any". Currently, is.vector() allows any type (see typeof) for mode, and when mode is not "any", is.vector(x, mode) is almost the same as typeof(x) == mode.
length: a non-negative integer specifying the desired length. For a long vector, i.e., length > .Machine$integer.max, it has to be of type "double". Supplying an argument of length other than one is an error
```


```r
x = vector(mode="numeric", length=10)
x
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0
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
> character `\(>\)` complex `\(>\)` numeric `\(>\)` integer `\(>\)` logical

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

from, to: the starting and (maximal) end values of the sequence. Of length 1 unless just from is supplied as an unnamed argument.
by:	number, increment of the sequence.
length.out: desired length of the sequence. A non-negative number, which for seq and seq.int will be rounded up if fractional.
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

x: a vector (of any mode including a list) or a factor or (for rep only) a POSIXct or POSIXlt or Date object.
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


### Matrizes
Matrizes são vetores (e, portanto, possuem elementos de mesma classe) com atributo de _dimensão_ (nº linhas por nº colunas). Uma matriz pode ser criada usando a função `matrix()`:

```yaml
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, ...)

data: an optional data vector (including a list or expression vector). Non-atomic classed R objects are coerced by as.vector and all attributes discarded.
nrow: the desired number of rows.
ncol: the desired number of columns.
byrow: logical. If FALSE (the default) the matrix is filled by columns, otherwise the matrix is filled by rows.
```


```r
m = matrix(nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]   NA   NA   NA
```

É possível construir uma matriz "preenchida" informando os seus (nº linhas `\(\times\)` nº colunas) valores por meio de um vetor. Os elementos deste vetor preenchem primeiro todas linhas de uma coluna para, depois, preencher a próxima coluna (_column-wise_):

```r
m = matrix(1:6, nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

> **ATENÇÃO**: No Python, você informa os valores da matriz por linha (_row-wise_).

Outra maneira de criar matrizes é juntando vetores em colunas (_column-binding_) ou em linhas (_row-binding_), usando as funções `cbind()` e `rbind()`, respectivamente:

```yaml
cbind(...)
rbind(...)

... : (generalized) vectors or matrices. These can be given as named arguments. Other R objects may be coerced as appropriate, or S4 methods may be used: see sections ‘Details’ and ‘Value’. (For the "data.frame" method of cbind these can be further arguments to data.frame such as stringsAsFactors.)
```


```r
x = 1:3
y = 10:12

cbind(x, y)
```

```
##      x  y
## [1,] 1 10
## [2,] 2 11
## [3,] 3 12
```

```r
rbind(x, y)
```

```
##   [,1] [,2] [,3]
## x    1    2    3
## y   10   11   12
```


### Fatores
- [Data types - Factors (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/Eidkq/data-types-factors)

- _Factor_ é uma classe de objeto que representa uma variável categórica, em que cada possível valor é considerado uma categoria/nível (_level_) distinto.
- Por exemplo, ao usar factor em uma variável de sexo/gênero, os valores "masculino" e "feminino" podem ser considerados como níveis (_levels_) 1 e 2, por exemplo.
- Isso é especialmente interessante em regressões (via `lm()` ou `glm()`), pois
    - quando esse _factor_ é colocado como variável explicativa, o R já considera cada nível como uma _dummy_, e
    - para evitar multicolinearidade perfeita, retira-se automaticamente o 1º nível (no exemplo, portanto, manteria apenas uma _dummy_ de "feminino" na regressão).
- Para criar um _factor_, usa-se a função `factor()`
```yaml
factor(x = character(), levels, ...)

x: a vector of data, usually taking a small number of distinct values.
levels: an optional vector of the unique values (as character strings) that x might have taken. The default is the unique set of values taken by as.character(x), sorted into increasing order of x. Note that this set can be specified as smaller than sort(unique(x)).
```


```r
texto = c("yes", "yes", "no", "maybe", "yes", "no")
x = factor(texto)
x
```

```
## [1] yes   yes   no    maybe yes   no   
## Levels: maybe no yes
```

```r
unclass(x) # Visualizar como o factor é representado em níveis
```

```
## [1] 3 3 2 1 3 2
## attr(,"levels")
## [1] "maybe" "no"    "yes"
```

- Note que, quando transformamos o vetor `texto` em factor, considerou automaticamente que "maybe" é o 1º nível, "no" é o 2º nível e "yes" é o 3º nível.
- Eventualmente, queremos definir "yes" como 1º nível do _factor_ para que, por exemplo, seja o nível desconsiderado numa regressão (para evitar multicolinearidade perfeita).
- Para isto, podemos usar incluir o argumento `levels = ...` quando transformar um vetor em _factor_ usando a função `factor`
- Ou, também, utilizar a função `relevel()` em um _factor_ existente

```yaml
relevel(x, ref, ...)

x: an unordered factor.
ref: the reference level, typically a string.
```


```r
y = factor(texto, levels=c("yes", "no", "maybe"))
unclass(y)
```

```
## [1] 1 1 2 3 1 2
## attr(,"levels")
## [1] "yes"   "no"    "maybe"
```

```r
x = relevel(x, ref="yes")
unclass(x)
```

```
## [1] 1 1 3 2 1 3
## attr(,"levels")
## [1] "yes"   "maybe" "no"
```


### Data frames
- [Data types - Data frames (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/kz1Lh/data-types-data-frames)

- É um tipo especial de lista, em que cada elemento da lista possui o mesmo tamanho
- Cada elemento da lista pode ser entendida como uma coluna de uma base de dados
- Diferente de matrizes, cada elemento de um _data frame_ pode ser de uma classe diferente 
- Normalmente é criada automaticamente ao carregarmos uma base de dados em .txt ou .csv via `read.table()` ou `read.csv()`
- Mas também pode ser criada manualmente via `data.frame()`

```yaml
data.frame(..., stringsAsFactors = FALSE)

... : these arguments are of either the form value or tag = value. Component names are created based on the tag (if present) or the deparsed argument itself.
stringsAsFactors: logical: should character vectors be converted to factors?.
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
- Caso queira testar, faça download das bases: [mtcars.txt](https://fhnishida.github.io/fearp/eco1/mtcars.txt) e [mtcars.csv](https://fhnishida.github.io/fearp/eco1/mtcars.csv)
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


## Subsetting
- [Subsetting - Basics (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/JDoLX/subsetting-basics)
- Há 3 operadores básicos para extrair subconjuntos de objetos no R:
    - `[]`: retorna um "sub-objeto" da mesma classe do objeto original
    - `[[]]`: usado para extrair elementos de uma lista ou data frame, em que o "sub-objeto" não é necessariamente da mesma classe do objeto original
    - `$`: usado para extrair elemento de uma lista ou data frame pelo nome


### Subsetting vector

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

> **ATENÇÃO**: Diferente do Python, em que a numeração se inicia no 0, a numeração dos elementos no R se inicia no 1.

- Note que, ao fazer uma expressão lógica com um vetor, obtemos um outro vetor, chamado de _índice lógico_

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

### Subsetting list
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
x[1] # retorna uma lista $foo
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
x[[1]] # retorna um vetor de classe numeric
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


### Subsetting matrix and data frame
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
- Note que, quando o subconjunto é um valor único ou um vetor, o objeto retornado deixa de ser uma matriz. Podemos forçar a se manter como matriz usando o argumento `drop= FALSE`

```r
x[1, 2, drop = FALSE]
```

```
##      [,1]
## [1,]    3
```

### Removing `NA`s
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


## Operações vetoriais/matriciais
- [Vectorized operations (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/nobfZ/vectorized-operations)
- Ao utilizar as operações matemáticas convencionais em vetores, cada elemento é operacionalizado com o elemento na mesma posição do outro vetor

```r
x = 1:4
y = 6:9

x + y # soma de cada elemento na mesma posição
```

```
## [1]  7  9 11 13
```

```r
x + 2 # soma de de cada elemento com um mesmo escalar
```

```
## [1] 3 4 5 6
```

```r
x * y # multiplicação de cada elemento na mesma posição
```

```
## [1]  6 14 24 36
```

```r
x / y # divisão de cada elemento na mesma posição
```

```
## [1] 0.1666667 0.2857143 0.3750000 0.4444444
```
- Para fazer o produto vetorial usa-se `%*%`. Por padrão, o R considera que o 1º vetor é um vetor-linha e o 2º é um vetor-coluna.

```r
x %*% y
```

```
##      [,1]
## [1,]   80
```
- Para transpor um vetor ou uma matriz, pode-se transformar em um vetor linha ou coluna via `matrix()`, ou é possível transpor usando  a função `t()`.

```r
x %*% t(y) # x vetor-coluna / y vetor-linha
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```

```r
# Transformando vetores em objetos matriz
x_col = matrix(x, ncol=1)
x_col
```

```
##      [,1]
## [1,]    1
## [2,]    2
## [3,]    3
## [4,]    4
```

```r
y_lin = matrix(y, nrow=1)
y_lin
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
```

```r
x_col %*% y_lin
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```
- O mesmo é válido para matrizes:

```r
x = matrix(1:4, nrow=2, ncol=2)
x
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

```r
y = matrix(rep(10, 4), nrow=2, ncol=2)
y
```

```
##      [,1] [,2]
## [1,]   10   10
## [2,]   10   10
```

```r
x + y # Soma de elementos na mesma posição
```

```
##      [,1] [,2]
## [1,]   11   13
## [2,]   12   14
```

```r
x + 2 # Soma de cada elemento da matriz com um mesmo escalar
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```

```r
x * y # Multiplicação de elementos na mesma posição
```

```
##      [,1] [,2]
## [1,]   10   30
## [2,]   20   40
```

```r
x %*% y # Multplicação matricial
```

```
##      [,1] [,2]
## [1,]   40   40
## [2,]   60   60
```

> Note que essas operações matemáticas são equivalentes às realizadas apenas quando as matrizes são transformadas em `numpy.array` no Python.


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
- A obtenção dos valores máximos e mínimos também poderia ser feita usando as funções `which.max()` e `which.min()`, que retornam **o índice do 1º elemento** de valor máximo/mínimo a partir de um **vetor de números**:

```r
which.max(x) # 1º índice de valor máximo
```

```
## [1] 5
```

```r
which.min(x) # 1º índice de valor mínimo
```

```
## [1] 3
```

```r
x[which.max(x)] # extraindo o valor máximo do vetor x
```

```
## [1] 8
```
- Para obter os índices de todos os elementos de valor máximo/mínimo, precisamos usar a função `which()` que tem como argumento um **vetor lógico** (de `TRUE`'s e `FALSE`'s) como input, e gera um vetor de índices:
```yaml
which(x, ...)
    
x: a logical vector or array. NAs are allowed and omitted (treated as if FALSE).
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
- Note que, se houve valores ausentes (`NA`), a função retorna `NA` por padrão. Para excluir os valores ausentes, precisamos definir o argumento `na.rm = TRUE`:

```r
x = c(1, 4, -5, 2, NA, -2, 4, 7, NA, 0, 2, 3, -5, NA, 4, -4, NA, 5, 2, NA)
mean(x) # Sem excluir valores ausentes
```

```
## [1] NA
```

```r
mean(x, na.rm=TRUE) # Excluindo valores ausentes
```

```
## [1] 1.2
```

## Estruturas de controle
- Estruturas de controle no R permitem o controle do fluxo do programa

### Condicional (`if`)
- [Control structures - If/Else (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/PDOOA/control-structures-if-else)

```r
x = 5
if (x > 10) {
    y = 10
    print("caso x > 10")
} else if (x > 0) {
    y = 5
    print("caso 10 >= x > 0")
} else {
    y = 0
    print("caso x >= 0")
}
```

```
## [1] "caso 10 >= x > 0"
```

```r
y
```

```
## [1] 5
```

- Essa mesma estrutura também pode ser utilizada para atribuir valor a um objeto

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
- mas existem funções mais práticas para atribuir valor a um objeto a partir de uma condição:
    - função `ifelse()` (útil para 2 possíveis valores)
    
```yaml
ifelse(test, yes, no)

test: an object which can be coerced to logical mode.
yes: return values for true elements of test.
no: return values for false elements of test.
```


```r
x = 5
y = ifelse(x > 10, yes=10, no=5)
y
```

```
## [1] 5
```

- função `case_when()` do pacote `dplyr` (útil para mais do que 2 possíveis valores)

```yaml
case_when(...)

... : A sequence of two-sided formulas. The left hand side (LHS) determines which values match this case. The right hand side (RHS) provides the replacement value.
```
    

```r
x = 5
y = dplyr::case_when(
    x > 10 ~ 10,
    x >  0 ~  5,
    TRUE   ~  0  # Else
)
y
```

```
## [1] 5
```

- note que, no `case_when()`, se não deixarmos claros todas os possíveis casos e, por acaso, cair num caso não declarado, a função retorna o valor `NA`
    

```r
x = 5
y = dplyr::case_when(
    x > 10 ~ 10,
    x <= 0 ~  0
)
y
```

```
## [1] NA
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
- Note que, por não seguir uma sequência de elemento dentro de um vetor (como no `for`), **é necessário que a variável indicadora seja atualizada a cada iteração para que a repetição não seja feita infinitamente**.
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
- Uma outra maneira é, ao invés de aumentar em uma unidade por loop, a variável indicadora ser calculada e ela convergir ou ultrapassar algum limite. No exemplo abaixo, a cada loop da `distancia` diminuirá pela metade e irá parar num valor bem próximo de 0 (algum valor menor do que `\(10^{-3}\)`)

```r
distancia = 10
tolerancia = 1e-3
tolerancia
```

```
## [1] 0.001
```

```r
while (distancia > tolerancia) {
    distancia = distancia / 2
}

distancia
```

```
## [1] 0.0006103516
```


### Exemplo: Tabuada
- É comum o uso de uma estrutura de repetição dentro de outra estrutura de repetição (repetições encaixadas).
- Como exemplo, será criada uma matriz vazia e esta será preenchida com a tabela de tabuada


```r
tabuada = matrix(NA, 10, 10)
tabuada
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [2,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [3,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [4,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [5,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [6,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [7,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [8,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
##  [9,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
## [10,]   NA   NA   NA   NA   NA   NA   NA   NA   NA    NA
```

```r
# Preenchimento da matriz de tabuada
for (linha in 1:10) {
    for (coluna in 1:10) {
        tabuada[linha, coluna] = linha * coluna
    }
}
tabuada
```

```
##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
##  [1,]    1    2    3    4    5    6    7    8    9    10
##  [2,]    2    4    6    8   10   12   14   16   18    20
##  [3,]    3    6    9   12   15   18   21   24   27    30
##  [4,]    4    8   12   16   20   24   28   32   36    40
##  [5,]    5   10   15   20   25   30   35   40   45    50
##  [6,]    6   12   18   24   30   36   42   48   54    60
##  [7,]    7   14   21   28   35   42   49   56   63    70
##  [8,]    8   16   24   32   40   48   56   64   72    80
##  [9,]    9   18   27   36   45   54   63   72   81    90
## [10,]   10   20   30   40   50   60   70   80   90   100
```


## Simulação
<!-- Funções para distribuições de probabilidade no R: -->

<!-- - `rnorm`: gera amostra aleatória normal, dada uma média e dado um desvio padrão -->
<!-- - `dnorm`: avalia a densidade de probabilidade normal (dada média e desvio padrão) em um ponto (ou num vetor de pontos) -->
<!-- - `pnorm`: avalia a função de distribuição acumulada para uma distribuição normal -->
<!-- - `rpois`: gera amostra aleatória Poisson, dada uma taxa -->

### Números aleatórios
Para cada função de distribuição de probabilidade (Normal, Poisson, Binomial, Exponencial, Gamma, etc.), há normalmente quatro funções associadas que utilizam os seguintes prefixos:

- `d`: densidade
- `r`: geração de números aleatórios
- `p`: distribuição acumulada
- `q`: quantil

Portanto, para a distribuição normal, temos as seguintes funções:
```yaml
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

x, q: vector of quantiles.
p: vector of probabilities.
n: number of observations. If length(n) > 1, the length is taken to be the number required.
mean: vector of means.
sd: vector of standard deviations.
log, log.p: logical; if TRUE, probabilities p are given as log(p).
lower.tail: logical; if TRUE (default), probabilities are P[X ≤ x] otherwise, P[X > x].
```
- Para reproduzir resultados, podemos usar a função `set.seed()` que, dado um número inteiro, faz com que a função `rnorm()` sempre gere os mesmos número aleatórios.

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


#### Simulando um modelo linear
- [Simulating a linear model (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/u7in9/simulation-simulating-a-linear-model)
- Suponha o modelo linear:
$$ y = 0,5 + 2x + \varepsilon, \qquad \varepsilon \sim N(0, 2^2) $$
- Assuma também que `\(x \sim N(0, 1^2), \beta_0 = 0.5\)` e `\(\beta_1 = 2\)`:

```r
set.seed(2022)
x = rnorm(100)
e = rnorm(100, 0, 2)

y = 0.5 + 2*x + e
head(y, 10)
```

```
##  [1]  1.864507212 -4.281986960 -2.803127733 -2.006542439  1.932538373
##  [6] -3.121601205 -0.227562617  0.007171963  2.527003695  3.465565859
```

```r
summary(y) # resumo da variável y
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -5.8760 -1.9534  0.5354  0.3737  2.6069  7.4756
```

```r
plot(x, y) # Figura de x contra y
```

<img src="/project/rec5004/chapter2/_index_files/figure-html/unnamed-chunk-70-1.png" width="672" />


### Amostragem aleatória
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
set.seed(2022)
sample(1:10, 4) # Amostragem definindo seed
```

```
## [1] 4 3 6 7
```

```r
sample(1:10, 4) # Amostragem sem definir seed
```

```
## [1] 4 6 7 9
```

```r
sample(letters, 5) # Amostragem de 5 letras
```

```
## [1] "i" "n" "x" "g" "r"
```

```r
sample(1:10) # Permutação (amostra mesma qtd de elementos do vetor)
```

```
##  [1]  7  6  5  1  3 10  2  4  8  9
```

```r
sample(1:10, replace = TRUE) # Amostragem com reposição
```

```
##  [1] 6 7 6 5 4 8 3 4 2 2
```
- Note que, por padrão, a função `sample()` amostra sem reposição.


## Criando funções
- [Your first R function (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/BM3dR/your-first-r-function)
- Para criar uma função, usamos a função `function(){}`:
    - dentro dos parêntesis `()`, incluímos nomes de variáveis arbitrárias (argumentos/inputs) que serão utilizadas pela função para fazer cálculos
    - dentro das chaves `{}`, usamos os nomes das variáveis arbitrárias definidas dentro do parêntesis para fazer cálculos e retornar um output (último valor dentro das chaves)
- Como exemplo, criaremos uma função que pega 2 números como inputs e retorna sua soma

```r
soma = function(a, b) {
    a + b
}
```
- Ao atribuir a função ao objeto `soma` não geramos resultados. Para fazer isso, usamos a função `soma()` inserindo 2 números como inputs:

```r
soma(10, 4)
```

```
## [1] 14
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




{{< cta cta_text="👉 Proceed to Data Manipulation" cta_link="../chapter3" >}}
