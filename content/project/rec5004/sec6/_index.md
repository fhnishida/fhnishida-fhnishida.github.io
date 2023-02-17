---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Distributions
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Distributions
weight: 6
output: md_document
type: book
---



- [Probability Distributions in R (Examples): PDF, CDF & Quantile Function (Statistics Globe)](https://statisticsglobe.com/probability-distributions-in-r)
- [Basic Probability Distributions in R (Greg Graham)](https://rstudio-pubs-static.s3.amazonaws.com/100906_8e3a32dd11c14b839468db756cee7400.html)

- As funções relacionadas a distribuições são dadas por `<prefixo><nome da distribuição>`
- Existem 4 prefixos que indicam qual ação será realizada:
    - `d`: calcula a densidade da distribuição dada uma estatística
    - `p`: calcula a probabilidade acumulada dada uma estatística
    - `q`: calcula a estatística da distribuição (quantil) dada uma probabilidade 
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
| Binomial           | `dbinom(x, size, prob)`        | `pbinom(q, size, prob)`    | `qbinom(p, size, prob)` |
| Poisson            | `dpois(x, lambda)`             | `pnorm(q, lambda)`         | `qnorm(p, lambda)`      |
| Qui-Quadrado       | `dchisq(x, df)`                | `pchisq(q, df)`            | `qchisq(p, df)`         |
| t-Student          | `dt(x, df)`                    | `pt(q, df)`                | `qt(p, df)`             |
| F                  | `df(x, df1, df2)`              | `pf(q, df1, df2)`          | `qf(p, df1, df2)`       |

em que `x` e `q` são estatísticas de cada distribuição (quantis), e `p` é probabilidade.


## Distribuição Normal
- Criaremos gráficos com média {{<math>}}$\mu = 0${{</math>}} e desvio padrão {{<math>}}$\sigma=1${{</math>}}
- Então, neste caso, os quantis em `x` e `q` são escores padrão Z

```r
# Gerando sequências de valores de escores Z e de probabilidades
Z = seq(-3.5, 3.5, by=0.1)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_norm = dnorm(Z, mean=0, sd=1)
cdf_norm = pnorm(Z, mean=0, sd=1)
qt_norm = qnorm(probs, mean=0, sd=1)

# Gerando gráficos
plot(Z, pdf_norm, type="l", col="blue", xlab="Escores padrão Z") # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-1-1.png" width="672" />

```r
plot(Z, cdf_norm, type="l", col="blue", xlab="Escores padrão Z") # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-1-2.png" width="672" />

```r
plot(probs, qt_norm, type="l", col="blue", ylab="Escores padrão Z") # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-1-3.png" width="672" />

## Distribuição Binomial
- Criaremos gráficos com taxa de sucesso de 50\% (`prob = 0.5`) e número de tentativas `size = 100`
- Os quantis `x` e `q` são quantidades de sucessos

```r
# Gerando sequências de valores de quantis e de probabilidades
quantis = seq(35, 65, by=1)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_binom = dbinom(quantis, size=100, prob=0.5)
cdf_binom = pbinom(quantis, size=100, prob=0.5)
qt_binom = qbinom(probs, size=100, prob=0.5)

# Gerando gráficos
plot(quantis, pdf_binom, type="l", col="blue", xlab="Sucessos") # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-2-1.png" width="672" />

```r
plot(quantis, cdf_binom, type="l", col="blue", xlab="Sucessos") # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-2-2.png" width="672" />

```r
plot(probs, qt_binom, type="l", col="blue", ylab="Sucessos") # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-2-3.png" width="672" />

## Distribuição de Poisson
- Criaremos gráficos com {{<math>}}$\lambda = 2.5${{</math>}}
- Os quantis `x` e `q` são números de ocorrências

```r
# Gerando sequências de valores de quantis e de probabilidades
quantis = seq(0, 9, by=1)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_pois = dpois(quantis, lambda=2.5)
cdf_pois = ppois(quantis, lambda=2.5)
qt_pois = qpois(probs, lambda=2.5)

# Gerando gráficos
plot(quantis, pdf_pois, type="l", col="blue", xlab="Ocorrências") # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-3-1.png" width="672" />

```r
plot(quantis, cdf_pois, type="l", col="blue", xlab="Ocorrências") # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-3-2.png" width="672" />

```r
plot(probs, qt_pois, type="l", col="blue", ylab="Ocorrências") # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-3-3.png" width="672" />


## Distribuição Qui-Quadrado
- Criaremos gráficos com 10 graus de liberdade (`df = 10`)
- Os quantis `x` e `q` são estatísticas de teste cumulativas de Pearson ({{<math>}}$\chi^2${{</math>}})

```r
# Gerando sequências de valores de quantis e de probabilidades
quantis = seq(1, 30, by=0.1)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_chisq = dchisq(quantis, df=10)
cdf_chisq = pchisq(quantis, df=10)
qt_chisq = qchisq(probs, df=10)

# Gerando gráficos
plot(quantis, pdf_chisq, type="l", col="blue", xlab=expression(chi^2)) # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-4-1.png" width="672" />

```r
plot(quantis, cdf_chisq, type="l", col="blue", xlab=expression(chi^2)) # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-4-2.png" width="672" />

```r
plot(probs, qt_chisq, type="l", col="blue", ylab=expression(chi^2)) # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-4-3.png" width="672" />


## Distribuição t-Student
- Criaremos gráficos com 10 graus de liberdade (`df = 10`)
- Os quantis `x` e `q` são estatísticas _t_
- Quanto maior os graus de liberdade, mais se aproxima de uma normal (0, 1)


```r
# Gerando sequências de valores de quantis e de probabilidades
quantis = seq(-4.1437, 4.1437, length=100)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_t = dt(quantis, df=10)
cdf_t = pt(quantis, df=10)
qt_t = qt(probs, df=10)

# Gerando gráficos
plot(quantis, pdf_t, type="l", col="blue", xlab="Estatística t") # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-5-1.png" width="672" />

```r
plot(quantis, cdf_t, type="l", col="blue", xlab="Estatística t") # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-5-2.png" width="672" />

```r
plot(probs, qt_t, type="l", col="blue", ylab="Estatística t") # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-5-3.png" width="672" />



## Distribuição F
- Criaremos gráficos com 10 e 15 graus de liberdade (`df1 = 10` e `df2 = 10`)
- Os quantis `x` e `q` são estatísticas _F_

```r
# Gerando sequências de valores de quantis e de probabilidades
quantis = seq(0.1230193, 6.080778, length=100)
probs = seq(0.001, 0.999, by=0.001)

# Calculando densidade, distribuição acumulada e quantis
pdf_f = df(quantis, df1=10, df2=15)
cdf_f = pf(quantis, df1=10, df2=15)
qt_f = qf(probs, df1=10, df2=15)

# Gerando gráficos
plot(quantis, pdf_f, type="l", col="blue", xlab="Estatística F") # pdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-6-1.png" width="672" />

```r
plot(quantis, cdf_f, type="l", col="blue", xlab="Estatística F") # cdf
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-6-2.png" width="672" />

```r
plot(probs, qt_f, type="l", col="blue", ylab="Estatística F") # quantis
```

<img src="/project/rec5004/sec6/_index_files/figure-html/unnamed-chunk-6-3.png" width="672" />



{{< cta cta_text="👉 Proceed to OLS Estimation" cta_link="../sec7" >}}
