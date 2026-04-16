---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Visualização de Dados"
summary: "Notas introdutórias de visualização de dados com gráficos base do R, análise exploratória e exemplos com ggplot2."
title: "Visualização de Dados no R"
weight: 5
output: md_document
type: book
---



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
    

## Análise Exploratória de Dados (EDA)
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

Como exemplo, usaremos dados da Agência de Proteção Ambiental dos EUA (EPA), [avgpm25.csv](https://fhnishida-rec5004.netlify.app/docs/avgpm25.csv), que informa a quantidade de poluição por partícula fina (PM2.5). A média anual de PM2.5 que não pode exceder 12 `\(\mu g/m^3\)`. 


```r
library(dplyr)
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
pollution = read.csv("https://fhnishida-rec5004.netlify.app/docs/avgpm25.csv")
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

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-2-1.png" width="672" />
- Para múltiplos boxplots, usamos `<variável_numérica> ~ <variável categórica>`:


```r
boxplot(pollution$pm25 ~ pollution$region, col="blue")
abline(h=12, col="red") # Linha horizontal no valor 12
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-3-1.png" width="672" />



### Histograma

```r
hist(pollution$pm25, col="green")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-4-1.png" width="672" />

```r
hist(pollution$pm25, col="green", breaks=100) # 100 quebras
rug(pollution$pm25) # Traços dos valores da amostra abaixo do histograma 
abline(v=12, col="red") # Linha vertical no valor 12
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-4-2.png" width="672" />
- Podemos colocar mais de um gráfico numa figura usando a função `par(mfrow, mar)`:

```r
par(mfrow=c(2, 1), mar=c(4, 4, 2, 1)) # Criando figura com 2 linhas e 1 coluna + margens

pol_west = pollution %>% filter(region == "west")
pol_east = pollution %>% filter(region == "east")

hist(pol_west$pm25, col="green")
hist(pol_east$pm25, col="green")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-5-1.png" width="672" />

- Note que você precisa usar `par(mfrow=c(1, 1))` para voltar a incluir apenas 1 gráfico na figura. 


### Gráfico de barra (_Barplot_)

```r
barplot(table(pollution$region), col="wheat",
        main="Nº de países em cada região")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-6-1.png" width="672" />



### Gráfico de dispersão (_Scatterplot_)
- Gera gráficos sob 2 dimensões

```r
plot(pollution$latitude, pollution$pm25)
abline(h=12, lwd=1.5, lty=2, col="red")
abline(lm(pm25 ~ latitude, data=pollution), col="blue")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-7-1.png" width="672" />


```r
par(mfrow=c(1, 2), mar=c(4, 4, 2, 1)) # Criando figura com 1 linha e 2 colunas + margens

plot(pol_west$latitude, pol_west$pm25, main="West")
plot(pol_east$latitude, pol_east$pm25, main="East")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-8-1.png" width="672" />

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

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-9-1.png" width="672" />


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



## Grammar of Graphics (`ggplot2`)
- [_ggplot2_ - Part 3 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/idcsq/ggplot2-part-3)
- [_ggplot2_ - Part 4 (John Hopkins/Coursera)](https://www.coursera.org/learn/exploratory-data-analysis/lecture/cj6RA/ggplot2-part-4)
- [_ggplot2_ Cheat Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf)
- [Aplicações _ggplot2_ (The R Graph Gallery)](https://r-graph-gallery.com/ggplot2-package.html)


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

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-11-1.png" width="672" />

3. Layer geomético (`geom`)
    - incluindos formas, linhas e pontos
    - caso não sejam informadas novas variáveis, a função para criar um objeto geométrico irá usar as variáveis-base definidas na função `ggplot()` inicial
    - Junta-se a base do gráfico com outras layers usando o sinal `+`

```r
g + geom_point()
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-12-1.png" width="672" />

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
g + geom_point() + geom_smooth(method="lm") # suavização a partir de OLS
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-13-1.png" width="672" />



5. Layers condicionais
Facets (usar `cyl`)


```r
g + geom_point() + geom_smooth(method="lm") + facet_grid(. ~ cyl) # agrupando por nº cilindros horizontalmente
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-14-1.png" width="672" />

```r
g + geom_point() + geom_smooth(method="lm") + facet_grid(cyl ~ .) # agrupando por nº cilindros verticalmente
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-14-2.png" width="672" />

6. Anotações
    - Rótulos: `xlab()`, `ylab()`, `labs()`, `ggtitle()`
    - Cada _geom_ tem opções para modificar, mas use `theme()` para opções globais do gráfico. Use `?theme` e veja a quantidade de configurações você pode fazer no seu gráfico.
    - Se quiser temas pré-definidos, há 2 templates padrão `theme_gray()` e `theme_bw()` (preto/branco). Também é possível usar outros usando o pacote `ggthemes`.

```r
g + geom_point() + ggthemes::theme_economist() + 
    ylab("Peso (libras)") + xlab("Milhas por galão") +
    ggtitle("Milhas por galão X Peso do carro")
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-15-1.png" width="672" />


7. Modificando Estética
    - Dentro de cada _geom_, podemos definir a cor (`color`), o tamanho (`size`) e a transparência (`alpha`)

```r
g + geom_point(color="steelblue", size=9, alpha=0.4)
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-16-1.png" width="672" />

```r
g + geom_point(aes(color=cyl), size=9, alpha=0.4) # colorindo por variável - precisa usar aes()
```

<img src="/project/rec2301/sec5/_index_files/figure-html/unnamed-chunk-16-2.png" width="672" />



{{< cta cta_text="👉 Seguir para Revisão de Estatística" cta_link="../sec6" >}}
