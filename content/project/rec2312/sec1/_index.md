---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "R Review"
summary: "Brief R review covering core objects, matrices, data frames, and basic data import commands used throughout Econometrics II."
title: "R Review for Econometrics"
weight: 1
output: md_document
type: book
---




## Basic operations

```r
# Addition
1 + 1
```

```
## [1] 2
```

```r
# Subtraction
2 - 3
```

```
## [1] -1
```

```r
# Multiplication
2 * 3
```

```
## [1] 6
```

```r
# Division
6 / 4
```

```
## [1] 1.5
```


## Basic Objects
 - [Data types, R objects and attributes (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/OS8hs/data-types-r-objects-and-attributes)
 
To create an object, we assign something to a name, in this case a value, using the assignment operator `<-` or `=`:

```r
obj1 <- 5
obj2 = 5 + 2
```

Notice that both objects were created and appear in the upper-right panel (_Environment_). We can print their values simply by typing the object name:

```r
obj1
```

```
## [1] 5
```
or by explicitly calling `print()`:

```r
print(obj2)
```

```
## [1] 7
```

We can also overwrite an object by assigning it a new value:

```r
obj1 = 3
obj1
```

```
## [1] 3
```

We can inspect the object's type with `class()`:

```r
class(obj1)
```

```
## [1] "numeric"
```

So `obj1` is a real number. There are 5 basic atomic classes of objects (each storing a single value):

 - `character`: text
 - `numeric`: real number
 - `integer`: integer
 - `complex`: complex number
 - `logical`: true/false (1 or 0)
 

```r
num_inteiro = 3L # use suffix L to create an integer
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
texto = "Hi"
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
boolean1 = TRUE # or = T
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
boolean2 = FALSE # or = F
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

### Logical / Boolean Expressions
These expressions return either `TRUE` or `FALSE`:

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

We can build compound logical expressions with `|` (or) and `&` (and):

```r
x = 20 # assigning 20 to x

# Compound logical expressions
x < 0 | x^2 > 100 # TRUE if ONE of the expressions is TRUE
```

```
## [1] TRUE
```

```r
x < 0 & x^2 > 100 # TRUE if ALL expressions are TRUE
```

```
## [1] FALSE
```


> **Operator Precedence Table**
> 
> - Level 6 - exponentiation: `^`
> - Level 5 - multiplication: `*`, `/`
> - Level 4 - addition: `+`, `-`
> - Level 3 - relational: `==`, `!=`, `<=`, `>=`, `>`, `<`
> - Level 2 - logical: `&` (and)
> - Level 1 - logical: `|` (or)

- **Levels 4 to 6** are used to CALCULATE values.
- **Level 3** compares 2 values to CREATE A logical expression.
- **Levels 1 and 2** are used to COMBINE logical expressions.



## Vectors and Matrices

- After the 5 atomic object classes above, the next basic structures are vectors and matrices, which contain more than one element.
- In both cases, all elements must belong to the same class.


### Vectors
- [Data types - Vectors and lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/wkAHm/data-types-vectors-and-lists)
- We can create a vector with `c()` by listing values separated by commas:

```r
x = c(0.5, 0.6) # numeric
x = c(TRUE, FALSE) # logical
x = c("a", "b", "c") # character
x = 9:12 # integer (equivalent to c(9, 10, 11, 12))
```


### Matrices
Matrices are vectors, and therefore also store elements of the same class, but they carry a _dimension_ attribute (number of rows by number of columns). A matrix can be created with `matrix()`:

```yaml
matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE, ...)

data: an optional data vector (including a list or expression vector).
nrow: the desired number of rows.
ncol: the desired number of columns.
byrow: logical. If FALSE (the default) the matrix is filled by columns, otherwise the matrix is filled by rows.
```


```r
m = matrix(nrow=2, ncol=3) # empty matrix
m
```

```
##      [,1] [,2] [,3]
## [1,]   NA   NA   NA
## [2,]   NA   NA   NA
```

We can fill every entry of a matrix with the same scalar value:


```r
m = matrix(0, nrow=2, ncol=3) # matrix filled with zeros
m
```

```
##      [,1] [,2] [,3]
## [1,]    0    0    0
## [2,]    0    0    0
```

We can also create a fully populated matrix by passing a vector with exactly (number of rows {{<math>}}$\times${{</math>}} number of columns) elements.

```r
m = matrix(1:6, nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


The elements of the vector `1:6` fill all rows of the first column before moving to the next column (_column-wise_). To fill the matrix by row instead, use `byrow=TRUE`:

```r
m = matrix(1:6, nrow=2, ncol=3, byrow=TRUE)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
```


In many cases, it is redundant to specify both the number of rows and the number of columns:

```r
m = matrix(1:6, nrow=2, byrow=TRUE)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
```

We can create row vectors or column vectors by setting `nrow=1` or `ncol=1`, respectively:

```r
# row vector
vrow = matrix(1:3, nrow=1)
vrow
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
```

```r
# column vector
vcol = matrix(1:3, ncol=1)
vcol
```

```
##      [,1]
## [1,]    1
## [2,]    2
## [3,]    3
```


We can create identity matrices easily with `diag()` by specifying the number of elements on the main diagonal:

```r
I = diag(3) # identity matrix with 3 diagonal elements
I
```

```
##      [,1] [,2] [,3]
## [1,]    1    0    0
## [2,]    0    1    0
## [3,]    0    0    1
```


</br>

Another way to create matrices is to combine vectors by column (_column-binding_) or by row (_row-binding_) using `cbind()` and `rbind()`:


```r
# Creating 2 vectors
x = 1:3
y = 10:12

# Creating / displaying matrices
X = cbind(x, y) # binding vectors by column
X
```

```
##      x  y
## [1,] 1 10
## [2,] 2 11
## [3,] 3 12
```

```r
Y = rbind(x, y) # binding vectors by row
Y
```

```
##   [,1] [,2] [,3]
## x    1    2    3
## y   10   11   12
```

```r
# If we combine a scalar with a vector, the scalar is replicated:
Z = cbind(1, y) # binding a scalar and a vector by column
Z
```

```
##         y
## [1,] 1 10
## [2,] 1 11
## [3,] 1 12
```


### Matrix Operations
- [Vectorized operations (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/nobfZ/vectorized-operations)
- When we use standard arithmetic operations on vectors, each element is combined with the element in the same position in the other vector.

```r
# Creating column vectors
x = matrix(1:4, ncol=1) # column vector
y = matrix(6:9, ncol=1) # column vector

x + y # addition of elements in the same position
```

```
##      [,1]
## [1,]    7
## [2,]    9
## [3,]   11
## [4,]   13
```

```r
x + 2 # adding the same scalar to each element
```

```
##      [,1]
## [1,]    3
## [2,]    4
## [3,]    5
## [4,]    6
```

```r
x * y # multiplication of elements in the same position
```

```
##      [,1]
## [1,]    6
## [2,]   14
## [3,]   24
## [4,]   36
```

```r
x / y # division of elements in the same position
```

```
##           [,1]
## [1,] 0.1666667
## [2,] 0.2857143
## [3,] 0.3750000
## [4,] 0.4444444
```
- To compute a matrix product, we use `%*%`. By default, R interprets the first vector as a row vector and the second as a column vector.

```r
t(x) %*% y # Inner product: x as a row vector / y as a column vector
```

```
##      [,1]
## [1,]   80
```

```r
x %*% t(y) # Outer product: x as a column vector / y as a row vector
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```

- The same logic applies to matrices, and we can compute the inverse of a square matrix with `solve()`:

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
X + Y # Addition of elements in the same position
```

```
##      [,1] [,2]
## [1,]   16   13
## [2,]   15   12
## [3,]   14   11
```

```r
X + 2 # Add the same scalar to each matrix element
```

```
##      [,1] [,2]
## [1,]    8    5
## [2,]    7    4
## [3,]    6    3
```

```r
X * Y # Multiplication of elements in the same position
```

```
##      [,1] [,2]
## [1,]   60   30
## [2,]   50   20
## [3,]   40   10
```

```r
t(X) %*% X # Matrix multiplication
```

```
##      [,1] [,2]
## [1,]   77   32
## [2,]   32   14
```

```r
solve( t(X) %*% X ) # inverse of X'X
```

```
##            [,1]       [,2]
## [1,]  0.2592593 -0.5925926
## [2,] -0.5925926  1.4259259
```

- And of course, we can also perform operations involving a vector and a matrix:

```r
# Creating the objects
X = matrix(6:1, nrow=3, ncol=2) # 3x2 matrix
X
```

```
##      [,1] [,2]
## [1,]    6    3
## [2,]    5    2
## [3,]    4    1
```

```r
e = matrix(-1:1, ncol=1) # 3x1 column vector
e
```

```
##      [,1]
## [1,]   -1
## [2,]    0
## [3,]    1
```

```r
t(X) %*% e # Matrix multiplication
```

```
##      [,1]
## [1,]   -2
## [2,]   -2
```



## Data Frames
- [Data types - Data frames (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/kz1Lh/data-types-data-frames)

- Unlike matrices, each column of a _data frame_ can have a different class.
- In practice, a data frame is often created by reading a `.txt` or `.csv` dataset with `read.table()` or `read.csv()`.


### Importing Data Files
- [Reading tabular data (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/bQ5B9/reading-tabular-data)
- The most commonly used functions for reading tabular data are `read.table()` and `read.csv()`.
- `read.table()` takes the following main arguments, which also appear in related import functions:
    - `file`: full file path, including the extension
    - `header`: `TRUE` or `FALSE`, indicating whether the first row is a header
    - `sep`: how columns are separated
    - `stringAsFactors`: `TRUE` or `FALSE`, indicating whether text variables should be converted to _factors_
```r
data_txt = read.table("mtcars.txt") # also reads .csv
data_csv = read.csv("mtcars.csv")
```
- If you want to test this, download the files [mtcars.txt](../mtcars.txt) and [mtcars.csv](../mtcars.csv).
- If you have not set the working directory, or if you want to download directly from the internet, you need to provide the full path or URL of the dataset you want to import:

```r
data = read.csv("C:/Users/Fabio/OneDrive/FEA-RP/mtcars.csv")
data = read.csv("https://fhnishida.netlify.app/project/rec2312/mtcars.csv")
```

### Loading Datasets from Packages
Some datasets are already available in R's `base` environment. We can list them with `data()`:
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

We can access them simply by typing their names. For example, here are the first 6 rows of one of the listed datasets using `head()`:

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

We can also install a package and load one of its datasets with `data()`. Below, we install the `wooldridge` package and load its dataset `gpa1`:

```r
install.packages("wooldridge") # installing the package
```

```r
data(gpa1, package="wooldridge") # loading a dataset from the wooldridge package
head(gpa1) # displaying the first 6 rows
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



### Extracting Subsets of Data Frames
- [Subsetting - Matrices (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/4gSc1/subsetting-matrices)
- To extract a subset of a matrix or data frame, we specify rows and columns inside `[]`.
- As an example, we use the `mtcars` dataset:

```r
head(mtcars) # displaying the first 6 rows
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
mtcars[1, 2] # row 1 and column 2
```

```
## [1] 6
```

```r
mtcars[1:2, 3:4] # rows 1 to 2 and columns 3 to 4
```

```
##               disp  hp
## Mazda RX4      160 110
## Mazda RX4 Wag  160 110
```

- We can select entire rows or columns by leaving one set of indices blank:

```r
mtcars[1, ] # row 1 and all columns
```

```
##           mpg cyl disp  hp drat   wt  qsec vs am gear carb
## Mazda RX4  21   6  160 110  3.9 2.62 16.46  0  1    4    4
```

```r
mtcars[, c(1, 4)] # all values from columns 1 and 4
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

- We can also select columns by name:

```r
# 1st method: put a vector of column names inside []
mtcars[, c("mpg", "hp")] # all values from the mpg and hp columns
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
# 2nd method: using $ (only one column at a time)
mtcars$mpg
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```


### New Variables in Data Frames

- We can create new variables with `$` to name a new column and `=` to assign a vector.
- Usually, the new variable is constructed from information already stored in existing variables.
- Using the `mtcars` dataset, we create the following variables:
  - `mpg2`: the squared value of `mpg`
  - `mpg_neg`: the negative of `mpg`
  - `mpg_neg_abs`: the absolute value of `mpg_neg`
  - `mpg_am`: the interaction between `mpg` and `am`, where `am` is a dummy variable (its values are only 0 and 1)


```r
mtcars$mpg2 = mtcars$mpg ^ 2 # mpg squared
mtcars$mpg_neg = mtcars$mpg * (-1) # negative of mpg
mtcars$mpg_neg_abs = abs(mtcars$mpg_neg) # absolute value of negative mpg
mtcars$mpg_am = mtcars$mpg * mtcars$am # interaction between mpg and am

head(mtcars) # first 6 rows of mtcars
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


{{< cta cta_text="👉 Proceed to Ordinary Least Squares (OLS)" cta_link="../sec2" >}}
