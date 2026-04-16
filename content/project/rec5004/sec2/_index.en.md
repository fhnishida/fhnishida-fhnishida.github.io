---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "R Programming"
summary: "R programming notes covering objects, vectors, matrices, lists, data frames, missing values, control flow, and core coding tools used in econometrics problem sets."
title: "R Programming for Econometrics"
weight: 2
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

```r
# Integer division
6 %/% 4
```

```
## [1] 1
```

```r
# Remainder
6 %% 4
```

```
## [1] 2
```

```r
# Exponentiation
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


## Objects in R
 - [Data types, R objects and attributes (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/OS8hs/data-types-r-objects-and-attributes)

To create an object, we assign something, in this case a value, to a name using the assignment operator `<-` or `=`:

```r
obj1 <- 5
obj2 = 5 + 2
```

Notice that both objects have been created and appear in the upper-right pane (_Environment_). We can print their values by executing the object name:

```r
obj1
```

```
## [1] 5
```
or by printing the value explicitly with the `print()` function:

```r
print(obj2)
```

```
## [1] 7
```

We can also modify an object by assigning a new value to it:

```r
obj1 = obj2
obj1
```

```
## [1] 7
```

A very common way to update an object is to use its current value as the starting point:

```r
obj1 = obj1 + 3
obj1
```

```
## [1] 10
```
> This will become especially relevant when we work with loops.


We can inspect the object type using the `class()` function:

```r
class(obj1)
```

```
## [1] "numeric"
```

Therefore, `obj1` is a real number. There are five atomic object classes in R, that is, objects containing a single value:

 - `character`: text
 - `numeric`: real number
 - `integer`: integer
 - `complex`: complex number
 - `logical`: true/false (1 or 0)
 

```r
num_real = 3
class(num_real)
```

```
## [1] "numeric"
```

```r
num_inteiro = 3L # use the suffix L for integers
class(num_inteiro)
```

```
## [1] "integer"
```

```r
texto = "Hi"
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
boolean2 = T # alternatively, you could write TRUE
print(boolean2)
```

```
## [1] TRUE
```

```r
boolean3 = F # alternatively, you could write FALSE
print(boolean3)
```

```
## [1] FALSE
```


### Logical/Boolean expressions
These are expressions that return either TRUE or FALSE:

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
T + F + T + F + F # sum of 1s (TRUE) and 0s (FALSE)
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

We can write compound expressions using `|` (or) and `&` (and):

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

> **Operator precedence table**
> 
> - Level 6 - exponentiation: `^`
> - Level 5 - multiplication/division: `*`, `/`, `%/%`, `%%`
> - Level 4 - addition/subtraction: `+`, `-`
> - Level 3 - relational operators: `==`, `!=`, `<=`, `>=`, `>`, `<`
> - Level 2 - logical: `&` (and)
> - Level 1 - logical: `|` (or)


### Vectors
- [Data types - Vectors and lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/wkAHm/data-types-vectors-and-lists)

After the five object classes introduced above, the most basic multi-element structures are vectors and lists. A vector requires all elements to belong to the same class. We can create a vector with the `c()` function by separating the elements with commas:

```r
x = c(0.5, 0.6) # numeric
x = c(TRUE, FALSE) # logical
x = c("a", "b", "c") # character
x = 9:12 # integer (equivalent to c(9, 10, 11, 12))
x = c(1+0i, 2+4i) # complex
```


If we use the `c()` function with elements from different classes, R coerces the object into the most general class:

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

> **Note**:
>
> character > complex > numeric > integer > logical

We can also force a conversion toward a less general class, which typically leads to:

- the more general elements becoming missing values (`NA`s),

```r
as.numeric(c(1.7, "a")) # (numeric, character)
```

```
## Warning: NAs introduced by coercion
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
- [exception] a _character_ entry containing a number, such as `"9"`, can be coerced to _numeric_

```r
as.numeric(c(1.7, "9")) # (numeric, character number)
```

```
## [1] 1.7 9.0
```
- [exception] a nonzero _numeric_ value becomes TRUE when coerced to _logical_
- [exception] a zero-valued _numeric_ entry becomes FALSE when coerced to _logical_

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
- [exception] logical _character_ values such as `"TRUE"`, `"T"`, `"FALSE"`, and `"F"` can be coerced to _logical_ values, whereas `"0"` and `"1"` become `NA`

```r
as.logical(c("T", "FALSE", "1", TRUE)) # (character TRUE/FALSE, logical) 
```

```
## [1]  TRUE FALSE    NA  TRUE
```

#### Building sequence vectors
- A convenient way to build a numeric sequence is to use the `seq()` function.

```yaml
seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, ...)

from, to: the starting and (maximal) end values of the sequence. Of length 1 unless just from is supplied as an unnamed argument.
by:	number, increment of the sequence.
length.out: desired length of the sequence. A non-negative number, which for seq and seq.int will be rounded up if fractional.
```
- Notice that the arguments already have default values, so sequences can be defined in different ways.
- Once `from` and `to` are specified, we can either:
    - define `by` to determine the step between consecutive elements, or
    - define `length.out` (or simply `length`) to determine how many elements the sequence should contain

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

#### Building vectors with repeated elements
- We can build vectors with repeated elements using the `rep()` function.
```yaml
rep(x, times)

x: a vector (of any mode including a list) or a factor or (for rep only) a POSIXct or POSIXlt or Date object.
```

```r
rep(0, 10) # repetition of 10 zeros
```

```
##  [1] 0 0 0 0 0 0 0 0 0 0
```

```r
rep(c("a", "b"), 2) # repeat the vector c("a", "b")
```

```
## [1] "a" "b" "a" "b"
```


### Matrices
Matrices are vectors and therefore contain elements from the same class, but with a _dimension_ attribute, that is, a number of rows by a number of columns. A matrix can be created with the `matrix()` function:

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

We can create a filled matrix by supplying a vector with the required number of entries (rows `\(\times\)` columns). By default, the vector fills the matrix column by column (_column-wise_):

```r
m = matrix(1:6, nrow=2, ncol=3)
m
```

```
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```


Another way to create matrices is by binding vectors by columns (_column-binding_) or by rows (_row-binding_) using `cbind()` and `rbind()`, respectively:

```yaml
cbind(...)
rbind(...)

... : (generalized) vectors or matrices. These can be given as named arguments. Other R objects may be coerced as appropriate, or S4 methods may be used: see sections Ã¢â‚¬ËœDetailsÃ¢â‚¬â„¢ and Ã¢â‚¬ËœValueÃ¢â‚¬â„¢. (For the "data.frame" method of cbind these can be further arguments to data.frame such as stringsAsFactors.)
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


### Lists
In contrast, a list allows its elements to belong to different classes and may even contain a vector as one of its elements. Lists can be created with the `list()` function:

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

- A data frame is a special type of list in which each element has the same length
- Each list element can be interpreted as a column in a dataset
- Unlike matrices, each element of a _data frame_ may belong to a different class
- It is often created automatically when we load a dataset from a `.txt` or `.csv` file with `read.table()` or `read.csv()`
- It can also be created manually with `data.frame()`

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
nrow(x) # Number of rows in x
```

```
## [1] 4
```

```r
ncol(x) # Number of columns in x
```

```
## [1] 2
```


#### Importing data frames
- [Reading tabular data (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/bQ5B9/reading-tabular-data)
- For reading tabular data, the most widely used functions are `read.table()` and `read.csv()`
- `read.table()` uses the following arguments, which also appear in other data import functions:
    - `file`: file path, including its extension
    - `header`: `TRUE` or `FALSE`, indicating whether the first row of the dataset is a header
    - `sep`: indicates how the columns are separated
    - `stringAsFactors`: `TRUE` or `FALSE`, depending on whether text variables should be converted to _factors_.
```r
data_txt = read.table("mtcars.txt") # also reads .csv files
data_csv = read.csv("mtcars.csv")
```
- If you want to test it, download the datasets [mtcars.txt](../mtcars.txt) and [mtcars.csv](../mtcars.csv).
- If you have not defined a working directory, you need to provide the full path of the file you want to import:
```r
data = read.table("C:/Users/Fabio/OneDrive/FEA-RP/mtcars.csv")
```
- `read.csv()` is similar to `read.table()`, but it assumes that the separator is a comma by default (`sep = ","`).
- To export a dataset, we typically use `write.csv()` or `write.table()`, supplying a data frame and the desired file name including its extension.


#### Importing other formats
- To open Excel files in `.xls` or `.xlsx` format, you need the [`xlsx` package](https://cran.r-project.org/web/packages/xlsx/xlsx.pdf).
```r
read.xlsx("mtcars.xlsx", sheetIndex=1) # Read the first worksheet of the Excel file
```
If you want to test it, download [mtcars.xlsx](../mtcars.xlsx).
- To open SPSS, Stata, and SAS files, use the `haven` package and the functions `read_spss()`, `read_dta()`, and `read_sas()`, respectively.

> Note that R uses a period (`.`) as the decimal separator, whereas Brazilian-formatted files often use a comma.
>
> This may lead to incorrect imports if the `.csv` or `.xlsx` file was generated with Brazilian formatting conventions.
>
> To handle this issue, use `read.csv2()` and `read.xlsx2()` so the data are imported correctly under Brazilian formatting conventions.
> If you want to test it, download [mtcars_br.csv](../mtcars_br.csv) and [mtcars_br.xlsx](../mtcars_br.xlsx).


## Extracting subsets
- [Subsetting - Basics (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/JDoLX/subsetting-basics)
- There are three basic operators for extracting subsets of objects in R:
    - `[]`: returns a sub-object of the same class as the original object
    - `[[]]`: used to extract elements from a list or data frame, where the extracted object is not necessarily of the same class as the original object
    - `$`: used to extract an element from a list or data frame by name


### Subsetting vectors

```r
x = c(1, 2, 3, 3, 4, 1)
x[1] # extract the first element of x
```

```
## [1] 1
```

```r
x[1:4] # extract the first through fourth elements of x
```

```
## [1] 1 2 3 3
```


- Notice that a logical expression applied to a vector returns a _logical vector_.

```r
x > 1
```

```
## [1] FALSE  TRUE  TRUE  TRUE  TRUE FALSE
```
- Using `[]`, we can extract a subset of the vector `x` using a condition. For example, we can extract only values greater than 1:

```r
x[x > 1]
```

```
## [1] 2 3 3 4
```

```r
x[c(F, T, T, T, T, F)] # Equivalent to x[x > 1] - keep only TRUE entries
```

```
## [1] 2 3 3 4
```

### Subsetting lists
- [Subsetting - Lists (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/hVKHm/subsetting-lists)
- Unlike vectors, extracting a specific value from a list requires `[[]]` together with the position of the list element.

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
x[1] # returns the list element foo
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
x[[1]] # returns the vector foo
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
- If you want to access an element inside that list element, you must follow it with `[]`.

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
- We can also use the element name to extract a subset of the object.

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


### Subsetting matrices and data frames
- [Subsetting - Matrices (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/4gSc1/subsetting-matrices)
- To extract part of a matrix or data frame, we specify the rows and columns inside `[]`.

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
x[1, 2] # row 1, column 2 of matrix x
```

```
## [1] 3
```

```r
x[1:2, 2:3] # rows 1-2 and columns 2-3 of matrix x
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```
- We can select rows or columns with a logical vector (`TRUE`s and `FALSE`s) of the appropriate length:

```r
x[, c(F, T, T)] # logical vector selecting the last two columns
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```
- We can select entire rows or columns by leaving out the corresponding index:

```r
x[1, ] # row 1 and all columns
```

```
## [1] 1 3 5
```

```r
x[, 2] # all rows and column 2
```

```
## [1] 3 4
```
- Notice that when the subset is a single value or a vector, the returned object stops being a matrix. We can force R to keep it as a matrix with `drop = FALSE`.

```r
x[1, 2, drop = FALSE]
```

```
##      [,1]
## [1,]    3
```

### Removing missing values (`NA`)
- [Subsetting - Removing missing values (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/Qy8bH/subsetting-removing-missing-values)
- Removing missing data is a common step in data manipulation.
- To check which entries are `NA`, use the `is.na()` function.

```r
x = c(1, 2, NA, 4, NA, NA)
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE  TRUE  TRUE
```

```r
sum(is.na(x)) # number of missing values
```

```
## [1] 3
```
- Recall that the `!` operator negates an expression, so `!is.na()` returns the elements that are **not** missing.

```r
x[ !is.na(x) ]
```

```
## [1] 1 2 4
```


## Vector and matrix operations
- [Vectorized operations (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/nobfZ/vectorized-operations)
- When standard arithmetic operations are applied to vectors, each element is combined with the element in the same position of the other vector.

```r
x = 1:4
y = 6:9

x + y # add elements in the same position
```

```
## [1]  7  9 11 13
```

```r
x + 2 # add the same scalar to each element
```

```
## [1] 3 4 5 6
```

```r
x * y # multiply elements in the same position
```

```
## [1]  6 14 24 36
```

```r
x / y # divide elements in the same position
```

```
## [1] 0.1666667 0.2857143 0.3750000 0.4444444
```
- The `%*%` operator is used for inner and matrix products. By default, R treats the first vector as a row vector and the second as a column vector.

```r
# Vector operations
x %*% y # x as row vector / y as column vector
```

```
##      [,1]
## [1,]   80
```

```r
x %*% t(y) # x as column vector / y as row vector (only the second is transposed)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```
- We can also explicitly force a vector to be represented as a row or column using `matrix()`.

```r
# Turning vectors into matrix objects
x_col = matrix(x, ncol=1) # column vector
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
# Vector operations
x_col %*% y_lin # x as column vector / y as row vector
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    6    7    8    9
## [2,]   12   14   16   18
## [3,]   18   21   24   27
## [4,]   24   28   32   36
```

```r
t(x_col) %*% t(y_lin) # x as row vector / y as column vector
```

```
##      [,1]
## [1,]   80
```
- The same logic applies to matrices:

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
x + y # add elements in the same position
```

```
##      [,1] [,2]
## [1,]   11   13
## [2,]   12   14
```

```r
x + 2 # add the same scalar to each matrix entry
```

```
##      [,1] [,2]
## [1,]    3    5
## [2,]    4    6
```

```r
x * y # multiply elements in the same position
```

```
##      [,1] [,2]
## [1,]   10   30
## [2,]   20   40
```

```r
x %*% y # matrix multiplication
```

```
##      [,1] [,2]
## [1,]   40   40
## [2,]   60   60
```


## Basic statistics for vectors and matrices
- **Absolute values**: `abs()`

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
- **Sum**: `sum(..., na.rm = FALSE)`

```r
sum(x)
```

```
## [1] 40
```
- **Mean**: `mean(x, trim = 0, na.rm = FALSE, ...)`

```r
mean(x)
```

```
## [1] 2
```
- **Standard deviation**: `sd(x, na.rm = FALSE)`

```r
sd(x)
```

```
## [1] 4.129483
```
- **Quantiles**: `quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE, ...)`

```r
# Minimum, first quartile, median, third quartile, and maximum
quantile(x, probs=c(0, .25, .5, .75, 1))
```

```
##    0%   25%   50%   75%  100% 
## -5.00 -0.50  2.00  4.25  8.00
```
- **Maximum** and **minimum**: `max(..., na.rm = FALSE)` and `min(..., na.rm = FALSE)`

```r
# Minimum, first quartile, median, third quartile, and maximum
max(x) # Maximum value
```

```
## [1] 8
```

```r
min(x) # Minimum value
```

```
## [1] -5
```
- Maximum and minimum values can also be studied with `which.max()` and `which.min()`, which return **the index of the first element** attaining the maximum or minimum in a **numeric vector**:

```r
which.max(x) # first index of the maximum value
```

```
## [1] 5
```

```r
which.min(x) # first index of the minimum value
```

```
## [1] 3
```

```r
x[which.max(x)] # extract the maximum value from vector x
```

```
## [1] 8
```
- To obtain the indices of all maximum or minimum elements, we use `which()`, which takes a **logical vector** (`TRUE`s and `FALSE`s) as input and returns a vector of indices:
```yaml
which(x, ...)
    
x: a logical vector or array. NAs are allowed and omitted (treated as if FALSE).
```

```r
x == max(x) # logical vector (TRUE entries mark the maxima)
```

```
##  [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

```r
which(x == max(x)) # vector of indices for elements attaining the maximum
```

```
## [1] 5 9
```

```r
x[which(x == max(x))] # maximum values
```

```
## [1] 8 8
```
- Notice that if missing values (`NA`) are present, the function returns `NA` by default. To exclude missing values, set `na.rm = TRUE`:

```r
x = c(1, 4, -5, 2, NA, -2, 4, 7, NA, 0, 2, 3, -5, NA, 4, -4, NA, 5, 2, NA)
mean(x) # without excluding missing values
```

```
## [1] NA
```

```r
mean(x, na.rm=TRUE) # excluding missing values
```

```
## [1] 1.2
```


### Example: univariate function optimization
- We want to find the value of {{<math>}}$x${{</math>}} that minimizes the univariate function {{<math>}}$f(x) = x^2 + 4x - 4${{</math>}}, that is,
    $$ \text{arg} \min_x (x^2 + 4x - 4) $$
- You can also inspect the function in [Wolfram](https://www.wolframalpha.com/input?i=solve+x%5E2+%2B+4x+-+4+%3D+0).
- To solve it numerically, we can evaluate many candidate values of {{<math>}}$x${{</math>}} and keep the smallest objective value.
- First, we build a grid of values for {{<math>}}$x${{</math>}} over the interval {{<math>}}$[-5, 5]${{</math>}}.

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
- Next, we evaluate {{<math>}}$f(x)${{</math>}} at each candidate value of {{<math>}}$x${{</math>}}.

```r
fx = x_grid^2 + 4*x_grid - 4 
```
- Notice that each value computed in `fx` corresponds to the value of {{<math>}}$x${{</math>}} in the same position of `x_grid`.

```r
head( cbind(x=x_grid, fx=fx), 6) # show the first six values
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
- We can now inspect both the value and the *position* of the {{<math>}}$x${{</math>}} that minimizes the function:

```r
min(fx) # minimum value of f(x)
```

```
## [1] -7.975069
```

```r
argmin_index = which.min(fx) # index of x that minimizes the function
argmin_index
```

```
## [1] 7
```
- To recover the value of {{<math>}}$x${{</math>}} that minimizes {{<math>}}$f(x)${{</math>}}, we use the index found above to access `x_grid`:

```r
x_grid[argmin_index]
```

```
## [1] -1.842105
```
- Accuracy can be improved by using a finer grid for `x_grid`. In more computationally intensive problems, however, that may substantially increase running time.



## Control structures
- Control structures in R determine the program flow.

### Conditional statements (`if`)
- [Control structures - If/Else (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/PDOOA/control-structures-if-else)

```r
x = 5
if (x > 10) {
    y = 10
    print("case x > 10")
} else if (x > 0) {
    y = 5
    print("case 10 >= x > 0")
} else {
    y = 0
    print("case x <= 0")
}
```

```
## [1] "case 10 >= x > 0"
```

```r
y
```

```
## [1] 5
```

- The same structure can also be used to assign a value to an object.

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


### `for` loops
- [Control structures - For loops (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/baydC/control-structures-for-loops)
- A `for` loop requires a vector and a name for the iteration variable.

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
- Above, we named the iteration variable `i` and supplied the integer vector from 3 to 7.
- At each iteration, `i` takes one value from the vector `3:7` until all elements have been used.
- Numeric sequences are especially useful inside `for` loops.

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


### `while` loops
- [Control structures - While loops (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/WWXg6/control-structures-while-loops)
- Unlike `for`, a `while` loop requires the indicator variable to be created before the loop starts.
- This happens because each loop iteration, including the first one, only runs if the condition is true.
- Since `while` does not automatically move through a vector as `for` does, **the indicator variable must be updated at each iteration to avoid an infinite loop**.
- A common way to use `while` is to define the indicator variable as a counter and stop after a predetermined number of iterations.

```r
counter = 0

while (counter <= 10) {
    print(counter)
    counter = counter + 1
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
- Another possibility is to use as the indicator variable a quantity that is repeatedly updated until convergence or until it crosses a threshold. In the example below, the variable `distance` is halved at each iteration and stops once it becomes smaller than `\(10^{-3}\)`.

```r
distance = 10
tolerance = 1e-3 # = 1 x 10^(-3) = 0.001

while (distance > tolerance) {
    distance = distance / 2
}

distance
```

```
## [1] 0.0006103516
```


### Example 1: multiplication table
- It is common to use one loop inside another loop (nested loops).
- As an example, we create an empty matrix and fill it with the multiplication table.


```r
times_table = matrix(NA, 10, 10)
times_table
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
# Fill the multiplication-table matrix
for (row in 1:10) {
    # Given one row value, fill all columns
    for (col in 1:10) {
        times_table[row, col] = row * col
    }
    # After finishing the columns, move to the next row
}
times_table
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

### Example 2: bivariate function optimization
- We now want to find the pair {{<math>}}$(x, z)${{</math>}} that minimizes the bivariate function {{<math>}}$f(x, z) = x^2 + 4z^2 - 4${{</math>}}, that is,
    $$ \text{arg} \min_{x, z} (x^2 + 4z^2 - 4) $$
- First, we create grids of candidate values for `\(x\)` and `\(z\)`.

```r
x_grid = seq(-5, 5, length=11)
z_grid = seq(-6, 6, length=11)
```
- Next, we create a matrix where each row represents a value of {{<math>}}$x${{</math>}} and each column represents a value of {{<math>}}$z${{</math>}}:

```r
# Create the matrix to be filled
fxz = matrix(NA, length(x_grid), length(z_grid))

# Name rows and columns
rownames(fxz) = x_grid
colnames(fxz) = z_grid

fxz
```

```
##    -6 -4.8 -3.6 -2.4 -1.2  0 1.2 2.4 3.6 4.8  6
## -5 NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## -4 NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## -3 NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## -2 NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## -1 NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 0  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 1  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 2  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 3  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 4  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
## 5  NA   NA   NA   NA   NA NA  NA  NA  NA  NA NA
```
- We then fill in each possible combination using nested loops.


```r
# Fill the fxz matrix
for (row_x in 1:length(x_grid)) {
    for (col_z in 1:length(z_grid)) {
        fxz[row_x, col_z] = x_grid[row_x]^2 + 4*z_grid[col_z]^2 -4
    }
}
fxz
```

```
##     -6   -4.8  -3.6  -2.4  -1.2  0   1.2   2.4   3.6    4.8   6
## -5 165 113.16 72.84 44.04 26.76 21 26.76 44.04 72.84 113.16 165
## -4 156 104.16 63.84 35.04 17.76 12 17.76 35.04 63.84 104.16 156
## -3 149  97.16 56.84 28.04 10.76  5 10.76 28.04 56.84  97.16 149
## -2 144  92.16 51.84 23.04  5.76  0  5.76 23.04 51.84  92.16 144
## -1 141  89.16 48.84 20.04  2.76 -3  2.76 20.04 48.84  89.16 141
## 0  140  88.16 47.84 19.04  1.76 -4  1.76 19.04 47.84  88.16 140
## 1  141  89.16 48.84 20.04  2.76 -3  2.76 20.04 48.84  89.16 141
## 2  144  92.16 51.84 23.04  5.76  0  5.76 23.04 51.84  92.16 144
## 3  149  97.16 56.84 28.04 10.76  5 10.76 28.04 56.84  97.16 149
## 4  156 104.16 63.84 35.04 17.76 12 17.76 35.04 63.84 104.16 156
## 5  165 113.16 72.84 44.04 26.76 21 26.76 44.04 72.84 113.16 165
```
- To recover the pair {{<math>}}$(x, z)${{</math>}} that minimizes {{<math>}}$f(x, z)${{</math>}}, we use the location of the minimum with the argument `arr.ind = TRUE`:

```r
argmin_index = which(fxz==min(fxz), arr.ind = TRUE)
argmin_index
```

```
##   row col
## 0   6   6
```

```r
argmin_x = x_grid[argmin_index[1]] # apply the x index to x_grid
argmin_z = z_grid[argmin_index[2]] # apply the z index to z_grid

paste0("The pair (x = ", argmin_x, ", z = ", argmin_z, ") minimizes the function f(x,z).")
```

```
## [1] "The pair (x = 0, z = 0) minimizes the function f(x,z)."
```



## Creating functions
- [Your first R function (John Hopkins/Coursera)](https://www.coursera.org/learn/r-programming/lecture/BM3dR/your-first-r-function)
- To create a function, we use `function(){}`:
    - inside the parentheses `()`, we include arbitrary variable names (arguments/inputs) that the function will use in calculations
    - inside the braces `{}`, we use those variable names to perform calculations and return an output, namely the last value inside the braces
- As an example, we create a function that takes two numbers as inputs and returns their sum.

```r
sum_two = function(a, b) {
    a + b
}
```
- Assigning the function to the object `sum_two` does not by itself generate output. To evaluate it, we call `sum_two()` and provide two numbers as inputs:

```r
sum_two(10, 4)
```

```
## [1] 14
```
- Note that the arbitrary variables `a` and `b` exist only inside the function.
```r
> a
Error: object 'a' not found
```

- We can also specify a default value for a function argument. For example, let us define a function that returns all elements of a vector greater than `n`:

```r
vector_x = 1:20
above = function(x, n = 10) {
    x[x > n]
}

above(vector_x) # all values above the default threshold of 10
```

```
##  [1] 11 12 13 14 15 16 17 18 19 20
```

```r
above(vector_x, 14) # all values above 14
```

```
## [1] 15 16 17 18 19 20
```




{{< cta cta_text="Proceed to Data Manipulation" cta_link="../sec3" >}}
