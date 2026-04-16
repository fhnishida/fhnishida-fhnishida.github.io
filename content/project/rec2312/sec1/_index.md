---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: R Review
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: R Review
weight: 1
output: md_document
type: book
---




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


## Objetos básicos
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
obj1 = 3
obj1
```

```
## [1] 3
```

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
num_inteiro = 3L # para número inteiro, usar sufixo L
num_inteiro
```

```
## [1] 3
```

```r
class(num_inteiro)
```

```
## [1] "integer"
```

```r
texto = "Oi"
texto
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
boolean1 = TRUE # ou = T
boolean1
```

```
## [1] TRUE
```

```r
class(boolean1)
```

```
## [1] "logical"
```

```r
boolean2 = FALSE # ou = T
boolean2
```

```
## [1] FALSE
```

```r
class(boolean2)
```

```
## [1] "logical"
```

### Expressões lógicas/booleanas
São expressões que retornam o valor Verdadeiro ou Falso:

```r
2 < 20 # TRUE
```

```
## [1] TRUE
```

```r
15 >= 19 # FALSE
```

```
## [1] FALSE
```

```r
100 == 10^2 # TRUE
```

```
## [1] TRUE
```

```r
100 != 20*5 # FALSE
```

```
## [1] FALSE
```

É possível escrever expressões compostas utilizando `|` (ou) e `&` (e):

```r
x = 20 # atribuindo 20 a x

# Expressões lógicas compostas
x < 0 | x^2 > 100 # TRUE se UMA das expressões for TRUE
```

```
## [1] TRUE
```

```r
x < 0 & x^2 > 100 # TRUE se TODAS expressões for TRUE
```

```
## [1] FALSE
```


> **Tabela de Precedência de Operadores**
> 
> - Nível 6 - potenciação: `^`
> - Nível 5 - multiplicação: `*`, `/`
> - Nível 4 - adição: `+`, `-`
> - Nível 3 - relacional: `==`, `!=`, `<=`, `>=`, `>`, `<`
> - Nível 2 - lógico: `&` (e)
> - Nível 1 - lógico: `|` (ou)

- **Níveis 4 a 6**: são utilizados para CALCULAR valores
- **Nível 3**: é usado para relacionar 2 valores para CRIAR UMA expressão lógica
- **Níveis 1 e 2**: são usados para JUNTAR expressões lógicas



## Vetores e Matrizes

- Depois das 5 classes de objetos apresentadas acima, as mais básicas são vetores e matrizes, que possuem mais de um elemento dentro do objeto.
- Ambos necessariamente exigwhere os seus elementos sejam da mesma classe. 


### Vetores
- [Data types - Vectors and lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/wkAHm/data-types-vectors-and-lists)
- Podemos criar um vetor usando a função `c()` e incluindo os valores separados por `,`:

```r
x = c(0.5, 0.6) # numeric
x = c(TRUE, FALSE) # logical
x = c("a", "b", "c") # character
x = 9:12 # integer (é igual a c(9, 10, 11, 12))
```


### Matrizes
Matrizes são vetores (e, portanto, possuem elementos de mesma classe) com atributo de _dimensão_ (nº linhas por nº colunas). Uma matriz pode ser criada usando a função `matrix()`:

```yaml
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, ...)

data: an optional data vector (including a list or expression vector).
nrow: the desired number of rows.
ncol: the desired number of columns.
byrow: logical. If FALSE (the default) the matrix is filled by columns, otherwise the matrix is filled by rows.
```


```r
m = matrix(nrow=2, ncol=3) # matriz vazia
m
```

```
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]   NA   NA   NA
```

Pode-se preencher todos elementos de uma matriz com um único valor informando um único escalar:


```r
m = matrix(0, nrow=2, ncol=3) # matriz vazia
m
```

```
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
```

É possível construir uma matriz "preenchida" incluindo um vetor com (nº linhas {{<math>}}$\times${{</math>}} nº colunas) elementos. 

```r
m = matrix(1:6, nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


Os elementos do vetor `1:6` preenchem primeiro todas linhas de uma coluna para, depois, preencher a próxima coluna (_column-wise_). Para preencher por linha, usamos o argumento `byrow=TRUE`:

```r
m = matrix(1:6, nrow=2, ncol=3, byrow=TRUE)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
```


Note que muitas vezes é redundante informar ambos números de linhas e de colunas:

```r
m = matrix(1:6, nrow=2, byrow=TRUE)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
```

Podemos criar vetores-linha ou vetores-coluna inserindo, respectivamente, `nrow=1` e `ncol=1`:

```r
# vetor-linha
vrow = matrix(1:3, nrow=1)
vrow
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
```

```r
# vetor-coluna
vcol = matrix(1:3, ncol=1)
vcol
```

```
##      [,1]
## [1,]    1
## [2,]    2
## [3,]    3
```


Podemos criar matrizes identidade facilmente utilizando a função `diag()` e informando o nº de elementos na diagonal principal da matriz:

```r
I = diag(3) # matriz identidade com 3 elementos na diagonal
I
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```


</br>

Outra maneira de criar matrizes é juntando vetores em colunas (_column-binding_) ou em linhas (_row-binding_), usando as funções `cbind()` e `rbind()`, respectivamente:


```r
# Criando 2 vetores
x = 1:3
y = 10:12

# Criando/Visualizando matrizes
X = cbind(x, y) # juntando vetores por coluna
X
```

```
##      x  y
## [1,] 1 10
## [2,] 2 11
## [3,] 3 12
```

```r
Y = rbind(x, y) # juntando vetores por linha
Y
```

```
##   [,1] [,2] [,3]
## x    1    2    3
## y   10   11   12
```

```r
# Caso juntemos um escalar com um vetor, o escalar é replicado:
Z = cbind(1, y) # juntando escalar com vetor por coluna
Z
```

```
##         y
## [1,] 1 10
## [2,] 1 11
## [3,] 1 12
```


### Operações matriciais
- [Vectorized operations (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/nobfZ/vectorized-operations)
- Ao utilizar as operações matemáticas convencionais em vetores, cada elemento é operacionalizado com o elemento na mesma posição do outro vetor

```r
# Criando vetores-coluna
x = matrix(1:4, ncol=1) # vetor-coluna
y = matrix(6:9, ncol=1) # vetor-coluna

x + y # soma de cada elemento na mesma posição
```

```
##      [,1]
## [1,]    7
## [2,]    9
## [3,]   11
## [4,]   13
```

```r
x + 2 # soma de de cada elemento com um mesmo escalar
```

```
##      [,1]
## [1,]    3
## [2,]    4
## [3,]    5
## [4,]    6
```

```r
x * y # multiplicação de cada elemento na mesma posição
```

```
##      [,1]
## [1,]    6
## [2,]   14
## [3,]   24
## [4,]   36
```

```r
x / y # divisão de cada elemento na mesma posição
```

```
##           [,1]
## [1,] 0.1666667
## [2,] 0.2857143
## [3,] 0.3750000
## [4,] 0.4444444
```
- Para fazer o produto vetorial usa-se `%*%`. Por padrão, o R considera que o 1º vetor é um vetor-linha e o 2º é um vetor-coluna.

```r
t(x) %*% y # Produto interno: x vetor-linha / y vetor-coluna
```

```
##      [,1]
## [1,]   80
```

```r
x %*% t(y) # Produto externo: x vetor-coluna / y vetor-linha
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```

- O mesmo é válido para matrizes, e também é possível tomar a inversa de uma matriz quadrada usando `solve()`:

```r
X = matrix(6:1, nrow=3, ncol=2)
X
```

```
##      [,1] [,2]
## [1,]    6    3
## [2,]    5    2
## [3,]    4    1
```

```r
Y = matrix(10, nrow=3, ncol=2)
Y
```

```
##      [,1] [,2]
## [1,]   10   10
## [2,]   10   10
## [3,]   10   10
```

```r
X + Y # Soma de elementos na mesma posição
```

```
##      [,1] [,2]
## [1,]   16   13
## [2,]   15   12
## [3,]   14   11
```

```r
X + 2 # Soma de cada elemento da matriz com um mesmo escalar
```

```
##      [,1] [,2]
## [1,]    8    5
## [2,]    7    4
## [3,]    6    3
```

```r
X * Y # Multiplicação de elementos na mesma posição
```

```
##      [,1] [,2]
## [1,]   60   30
## [2,]   50   20
## [3,]   40   10
```

```r
t(X) %*% X # Multiplicação matricial
```

```
##      [,1] [,2]
## [1,]   77   32
## [2,]   32   14
```

```r
solve( t(X) %*% X ) # inversa de X'X
```

```
##            [,1]       [,2]
## [1,]  0.2592593 -0.5925926
## [2,] -0.5925926  1.4259259
```

- E, é claro, dá para fazer operações entre vetor e matriz:

```r
# Criando ps objetos
X = matrix(6:1, nrow=3, ncol=2) # matriz 3x2
X
```

```
##      [,1] [,2]
## [1,]    6    3
## [2,]    5    2
## [3,]    4    1
```

```r
e = matrix(-1:1, ncol=1) # vetor-coluna 3x1
e
```

```
##      [,1]
## [1,]   -1
## [2,]    0
## [3,]    1
```

```r
t(X) %*% e # Multiplicação matricial
```

```
##      [,1]
## [1,]   -2
## [2,]   -2
```



## Data frames
- [Data types - Data frames (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/kz1Lh/data-types-data-frames)

- Diferente de matrizes, cada elemento de um _data frame_ pode ser de uma classe diferente 
- Normalmente um data frame é "criado" a partir da leitura de uma base de dados em .txt ou .csv via `read.table()` ou `read.csv()`


### Importando bases de arquivos
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
- Note que, caso você não tenha definido o diretório de trabalho ou queria fazer download diretamente da internet, é necessário informar o caminho/endereço inteiro da base de dados que você quer importar:

```r
data = read.csv("C:/Users/Fabio/OneDrive/FEA-RP/mtcars.csv")
data = read.csv("https://fhnishida.netlify.app/project/rec2312/mtcars.csv")
```

### Carregando bases de pacotes
Há algumas bases de dados já presentes no pacote `base` (já carregado automaticamente) do R. Para listá-las, pode-se usar a função `data()`:
```r
data()
```

```r
## Data sets in package ‘datasets’:
## 
## AirPassengers              Monthly Airline Passenger Numbers 1949-1960
## BJsales                    Sales Data with Leading Indicator
## BJsales.lead (BJsales)     Sales Data with Leading Indicator
## BOD                        Biochemical Oxygen Demand
## CO2                        Carbon Dioxide Uptake in Grass Plants
## ChickWeight                Weight versus age of chicks on different diets
## DNase                      Elisa assay of DNase
## (...)
```

É possível acessá-las apenas escrevendo seu nome. Vamos ver as 6 primeras linhas (função `head()`) de uma base de dados listada:

```r
head( CO2 )
```

```
##   Plant   Type  Treatment conc uptake
## 1   Qn1 Quebec nonchilled   95   16.0
## 2   Qn1 Quebec nonchilled  175   30.4
## 3   Qn1 Quebec nonchilled  250   34.8
## 4   Qn1 Quebec nonchilled  350   37.2
## 5   Qn1 Quebec nonchilled  500   35.3
## 6   Qn1 Quebec nonchilled  675   39.2
```

Além disso, é possível baixar um pacote e usar uma de suas bases de dados usando a função `data()`. Abaixo, vamos instalar o pacote `wooldridge` e carregar a de suas bases de dados `gpa1`:

```r
install.packages("wooldridge") # instalando a base de dados
```

```r
data(gpa1, package="wooldridge") # carregando base de dados do pacote wooldridge
head(gpa1) # visualizando 6 primeiras linhas
```

```
##   age soph junior senior senior5 male campus business engineer colGPA hsGPA ACT
## 1  21    0      0      1       0    0      0        1        0    3.0   3.0  21
## 2  21    0      0      1       0    0      0        1        0    3.4   3.2  24
## 3  20    0      1      0       0    0      0        1        0    3.0   3.6  26
## 4  19    1      0      0       0    1      1        1        0    3.5   3.5  27
## 5  20    0      1      0       0    0      0        1        0    3.6   3.9  28
## 6  20    0      0      1       0    1      1        1        0    3.0   3.4  25
##   job19 job20 drive bike walk voluntr PC greek car siblings bgfriend clubs
## 1     0     1     1    0    0       0  0     0   1        1        0     0
## 2     0     1     1    0    0       0  0     0   1        0        1     1
## 3     1     0     0    0    1       0  0     0   1        1        0     1
## 4     1     0     0    0    1       0  0     0   0        1        0     0
## 5     0     1     0    1    0       0  0     0   1        1        1     0
## 6     0     0     0    0    1       0  0     0   1        1        0     0
##   skipped alcohol gradMI fathcoll mothcoll
## 1       2     1.0      1        0        0
## 2       0     1.0      1        1        1
## 3       0     1.0      1        1        1
## 4       0     0.0      0        0        0
## 5       0     1.5      1        1        0
## 6       0     0.0      0        1        0
```



### Extraindo subconjuntos de data frames
- [Subsetting - Matrices (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/4gSc1/subsetting-matrices)
- Para extrair um pedaço de uma matriz ou de um data frame, indicamos as linhas e as colunas dentro do operador `[]`
- Como exemplo, vamos usar a base de dados `mtcars`:

```r
head(mtcars) # Visualizando 6 primeiras linhas
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

```r
mtcars[1, 2] # linha 1 e coluna 2 da matriz X
```

```
## [1] 6
```

```r
mtcars[1:2, 3:4] # linha 1 e colunas 3 e 4 da matriz X
```

```
##               disp  hp
## Mazda RX4      160 110
## Mazda RX4 Wag  160 110
```

- Podemos selecionar linhas ou colunas inteiras ao não informar os índices:

```r
mtcars[1, ] # linha 1 e todas colunas
```

```
##           mpg cyl disp  hp drat   wt  qsec vs am gear carb
## Mazda RX4  21   6  160 110  3.9 2.62 16.46  0  1    4    4
```

```r
mtcars[, c(1, 4)] # todos valores das colunas 1 e 4
```

```
##                      mpg  hp
## Mazda RX4           21.0 110
## Mazda RX4 Wag       21.0 110
## Datsun 710          22.8  93
## Hornet 4 Drive      21.4 110
## Hornet Sportabout   18.7 175
## Valiant             18.1 105
## Duster 360          14.3 245
## Merc 240D           24.4  62
## Merc 230            22.8  95
## Merc 280            19.2 123
## Merc 280C           17.8 123
## Merc 450SE          16.4 180
## Merc 450SL          17.3 180
## Merc 450SLC         15.2 180
## Cadillac Fleetwood  10.4 205
## Lincoln Continental 10.4 215
## Chrysler Imperial   14.7 230
## Fiat 128            32.4  66
## Honda Civic         30.4  52
## Toyota Corolla      33.9  65
## Toyota Corona       21.5  97
## Dodge Challenger    15.5 150
## AMC Javelin         15.2 150
## Camaro Z28          13.3 245
## Pontiac Firebird    19.2 175
## Fiat X1-9           27.3  66
## Porsche 914-2       26.0  91
## Lotus Europa        30.4 113
## Ford Pantera L      15.8 264
## Ferrari Dino        19.7 175
## Maserati Bora       15.0 335
## Volvo 142E          21.4 109
```

- Também é possível selecionar diversas colunas usando os nomes delas:

```r
# 1a forma: incluindo vetor com os nomes dentro de []
mtcars[, c("mpg", "hp")] # todos valores das colunas 2 e 4
```

```
##                      mpg  hp
## Mazda RX4           21.0 110
## Mazda RX4 Wag       21.0 110
## Datsun 710          22.8  93
## Hornet 4 Drive      21.4 110
## Hornet Sportabout   18.7 175
## Valiant             18.1 105
## Duster 360          14.3 245
## Merc 240D           24.4  62
## Merc 230            22.8  95
## Merc 280            19.2 123
## Merc 280C           17.8 123
## Merc 450SE          16.4 180
## Merc 450SL          17.3 180
## Merc 450SLC         15.2 180
## Cadillac Fleetwood  10.4 205
## Lincoln Continental 10.4 215
## Chrysler Imperial   14.7 230
## Fiat 128            32.4  66
## Honda Civic         30.4  52
## Toyota Corolla      33.9  65
## Toyota Corona       21.5  97
## Dodge Challenger    15.5 150
## AMC Javelin         15.2 150
## Camaro Z28          13.3 245
## Pontiac Firebird    19.2 175
## Fiat X1-9           27.3  66
## Porsche 914-2       26.0  91
## Lotus Europa        30.4 113
## Ford Pantera L      15.8 264
## Ferrari Dino        19.7 175
## Maserati Bora       15.0 335
## Volvo 142E          21.4 109
```

```r
# 2a forma: usando $ (possível selecionar apenas 1 coluna)
mtcars$mpg
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```


### Novas variáveis em data frames

- Podemos criar novas variáveis usando os operadores `$` para nomear uma nova coluna e `=` para atribuir um vetor.
- Normalmente, preenchemos essa nova variável a partir da informação de outras variáveis pré-existentes.
- Usando a base de dados `mtcars`, vamos criar as variáveis:
  - `mpg2`: variável `mpg` ao quadrado,
  - `mpg_neg`: negativo de `mpg` (multiplicado por -1),
  - `mpg_neg_abs`: valor absoluto de `mpg_neg`
  - `mpg_am`: interação (multiplicação) da variável `mpg` com a `am`, que é uma variável _dummy_ (valores são apenas 0 e 1)


```r
mtcars$mpg2 = mtcars$mpg ^ 2 # mpg ao quadrado
mtcars$mpg_neg = mtcars$mpg * (-1) # negativo de mpg
mtcars$mpg_neg_abs = abs(mtcars$mpg_neg)# absoluo do negativo de mpg
mtcars$mpg_am = mtcars$mpg * mtcars$am # interação entre mpg e am

head(mtcars) # primeiras 6 linhas de mtcars
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb   mpg2
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4 441.00
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4 441.00
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1 519.84
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1 457.96
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2 349.69
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1 327.61
##                   mpg_neg mpg_neg_abs mpg_am
## Mazda RX4           -21.0        21.0   21.0
## Mazda RX4 Wag       -21.0        21.0   21.0
## Datsun 710          -22.8        22.8   22.8
## Hornet 4 Drive      -21.4        21.4    0.0
## Hornet Sportabout   -18.7        18.7    0.0
## Valiant             -18.1        18.1    0.0
```



</br>


{{< cta cta_text="👉 Seguir para Ordinary Least Squares (OLS)" cta_link="../sec2" >}}
