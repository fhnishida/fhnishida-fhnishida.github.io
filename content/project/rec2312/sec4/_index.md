---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: "Panel Data"
summary: "Panel data notes covering data structures, variance-covariance matrices, pooled OLS, random effects, fixed effects, and first-difference estimators in R."
title: "Panel Data Estimation in R"
weight: 4
output: md_document
type: book
---




## Data Structure

- Section 2.1.1 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Most notation follows the Econometrics I lecture notes.


### Cross-Section
So far, we have worked with cross-sectional datasets, that is, samples in which each row represents one individual {{<math>}}$i = 1, ..., N${{</math>}} and we observe realizations of the dependent variable {{<math>}}$y${{</math>}} and the explanatory variables {{<math>}}$k = 1, 2, ..., K${{</math>}}:

<img src="../data_crosssection.png" alt="">


#### Example
Consider {{<math>}}$N = 4${{</math>}} individuals and {{<math>}}$K = 2${{</math>}} covariates:

<img src="../data_crosssection_example.png" alt="">



### Panel Data
It is also common to work with panel data, that is, datasets in which we observe the same individuals {{<math>}}$i = 1, ..., N${{</math>}} over {{<math>}}$t = 1, ..., T${{</math>}} periods.

This type of structure allows us not only to compare individuals (_between_), but also to study within-individual variation (_within_) over time.

For simplicity, we assume a **balanced panel**, so every individual is observed for the same {{<math>}}$T${{</math>}} periods. Panel data can be organized in either long or wide format.


##### Panel Data in Long Format (_long_)
In long format, each individual appears in {{<math>}}$T${{</math>}} rows. Each observation is indexed by the pair {{<math>}}$i${{</math>}} and {{<math>}}$t${{</math>}}, which serve as the key identifiers in the dataset. This is the standard layout used in econometrics.

<img src="../data_panellong.png" alt="">


##### Panel Data in Wide Format (_wide_)
In wide format, the dependent and explanatory variables appear repeated across {{<math>}}$T${{</math>}} columns, with each repetition corresponding to one of the {{<math>}}$T${{</math>}} periods:

<img src="../data_panelwide.png" alt="">



#### Examples
As an example, consider {{<math>}}$N = 4${{</math>}} individuals, {{<math>}}$K = 2${{</math>}} covariates, and {{<math>}}$T = 2${{</math>}} periods. The corresponding long and wide panel layouts are:

<img src="../data_panellong_example.png" alt="">

<img src="../data_panelwide_example.png" alt="">



## Panel Data Model

For observation {{<math>}}$(i,t)${{</math>}}, we can write the model as:

{{<math>}}$$ y_{it} = \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{1} $$ {{</math>}}
where {{<math>}}$\boldsymbol{\beta}${{</math>}} is the column vector of parameters

{{<math>}}$$ \boldsymbol{\beta} = \left[ \begin{array}{c} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{array} \right], $${{</math>}}

{{<math>}}$y_{it}${{</math>}} is the dependent variable, and {{<math>}}$\boldsymbol{x}'_{it}${{</math>}} is the row vector of dimension {{<math>}}$K+1${{</math>}}:

{{<math>}}$$ \boldsymbol{x}'_{it} = \left[ \begin{array}{c} 1 & x^1_{it} & x^2_{it} & \cdots & x^K_{it} \end{array} \right],  $${{</math>}}

and the error {{<math>}}$\varepsilon_{it}${{</math>}} can be written as:

{{<math>}}$$ \varepsilon_{it} = u_i + v_{it},  $${{</math>}}
where {{<math>}}$u_i${{</math>}} is the individual-specific error component for individual {{<math>}}$i${{</math>}}, and {{<math>}}$v_{it}${{</math>}} is the idiosyncratic error.

Stacking equation (1) over all individuals {{<math>}}$i = 1, 2, ..., N${{</math>}} and periods {{<math>}}$t = 1, 2, ..., T${{</math>}}, we obtain

{{<math>}}$$ \underbrace{\boldsymbol{y}}_{NT \times 1} = \left[ \begin{array}{c}
    y_{11} \\ y_{12} \\ \vdots \\ y_{1T} \\\hline y_{21} \\ y_{22} \\ \vdots \\ y_{2T} \\\hline \vdots \\\hline y_{N1} \\ y_{N2} \\ \vdots \\ y_{NT}
\end{array} \right] \quad \text{and} \quad 
\underbrace{\boldsymbol{X}}_{NT \times K} = \left[ \begin{array}{c}
    \boldsymbol{x}'_{11} \\ \boldsymbol{x}'_{12} \\ \vdots \\ \boldsymbol{x}'_{1T} \\\hline
    \boldsymbol{x}'_{21} \\ \boldsymbol{x}'_{22} \\ \vdots \\ \boldsymbol{x}'_{2T} \\\hline
    \vdots \\\hline
    \boldsymbol{x}'_{N1} \\ \boldsymbol{x}'_{N2} \\ \vdots \\ \boldsymbol{x}'_{NT} 
    \end{array} \right]
  = \left[ \begin{array}{ccccc}
    1 & x^1_{11} & x^2_{11} & \cdots & x^K_{11} \\
    1 & x^1_{12} & x^2_{12} & \cdots & x^K_{12} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{1T} & x^2_{1T} & \cdots & x^K_{1T} \\\hline
    1 & x^1_{21} & x^2_{21} & \cdots & x^K_{21} \\
    1 & x^1_{22} & x^2_{22} & \cdots & x^K_{22} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{2T} & x^2_{2T} & \cdots & x^K_{2T} \\\hline
    \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    1 & x^1_{N1} & x^2_{N1} & \cdots & x^K_{N1} \\
    1 & x^1_{N2} & x^2_{N2} & \cdots & x^K_{N2} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{NT} & x^2_{NT} & \cdots & x^K_{NT}
\end{array} \right] $$ {{</math>}}
The horizontal separators are included only to make it easier to visualize the rows associated with each individual {{<math>}}$i${{</math>}}.


</br>

## Error Variance-Covariance Matrix
- Section 2.2 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

The error variance-covariance matrix links one error term, {{<math>}}$\varepsilon_{it}${{</math>}}, to every other error term {{<math>}}$\varepsilon_{js}${{</math>}}, for all {{<math>}}$j = 1, ..., N${{</math>}} and {{<math>}}$s = 1, ..., T${{</math>}}.

In this matrix, each row represents one {{<math>}}$\varepsilon_{it}${{</math>}} and each column represents one {{<math>}}$\varepsilon_{js}${{</math>}}. Each entry gives the covariance between {{<math>}}$\varepsilon_{it}${{</math>}} and {{<math>}}$\varepsilon_{js}${{</math>}}; when {{<math>}}$\varepsilon_{it} = \varepsilon_{js}${{</math>}}, the entry is a variance term:

{{<math>}}$$ cov(\boldsymbol{\varepsilon}) = \underset{NT \times NT}{\boldsymbol{\Sigma}} =$${{</math>}}
{{<math>}}$$ \left[ \tiny \begin{array}{cccc|ccc|c|ccc}
var(\varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}2}1}) & \cdots & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}2}T}) & \cdots & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}N}1}) & \cdots & cov(\varepsilon_{{\color{red}1}1}, \varepsilon_{{\color{red}N}T}) \\
cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}1}1}) & var(\varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}2}1}) & \cdots & cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}2}T}) & \cdots & cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}N}1}) & \cdots & cov(\varepsilon_{{\color{red}1}2}, \varepsilon_{{\color{red}N}T}) \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}1}2}) & \cdots & var(\varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}2}1}) & \cdots & cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}2}T}) & \cdots & cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}N}1}) & \cdots & cov(\varepsilon_{{\color{red}1}T}, \varepsilon_{{\color{red}N}T}) \\ \hline
cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}1}T}) & var(\varepsilon_{{\color{red}2}1}) & \cdots & 
cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}2}T}) & \cdots & cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}N}1}) & \cdots & cov(\varepsilon_{{\color{red}2}1}, \varepsilon_{{\color{red}N}T}) \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}2}1}) & \cdots & var(\varepsilon_{{\color{red}2}T}) & \cdots & 
cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}N}1}) & \cdots & cov(\varepsilon_{{\color{red}2}T}, \varepsilon_{{\color{red}N}T}) \\ \hline
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \ddots & \vdots \\ \hline
cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}2}1}) & \cdots & 
cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}2}T}) & \cdots & var(\varepsilon_{{\color{red}N}1}) & \cdots &
cov(\varepsilon_{{\color{red}N}1}, \varepsilon_{{\color{red}N}T}) \\
\vdots & \vdots & \ddots & \vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}1}1}) & cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}1}2}) & \cdots & cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}1}T}) & cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}2}1}) & \cdots & cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}2}T}) & \cdots & 
cov(\varepsilon_{{\color{red}N}T}, \varepsilon_{{\color{red}N}1}) & \cdots & var(\varepsilon_{{\color{red}N}T})
\end{array} \right]$${{</math>}}

Note that the error variance-covariance matrix can be partitioned into smaller blocks linking the errors of individual {{<math>}}$i${{</math>}} (row block) and individual {{<math>}}$j${{</math>}} (column block). To write {{<math>}}$\boldsymbol{\Sigma}${{</math>}} more compactly, we denote these blocks by {{<math>}}$\boldsymbol{\Sigma}_{ij}${{</math>}}:


{{<math>}}$$ \underset{NT \times NT}{\boldsymbol{\Sigma}} = \left[ \begin{matrix} 
\boldsymbol{\Sigma}_1 & \boldsymbol{\Sigma}_{12} & \cdots & \boldsymbol{\Sigma}_{1N} \\
\boldsymbol{\Sigma}_{21} & \boldsymbol{\Sigma}_{2} & \cdots & \boldsymbol{\Sigma}_{2N} \\
\vdots & \vdots & \ddots & \vdots \\
\boldsymbol{\Sigma}_{N1} & \boldsymbol{\Sigma}_{N2} & \cdots & \boldsymbol{\Sigma}_{N}
\end{matrix} \right] \tag{1} $${{</math>}} 

where, when {{<math>}}$i = j${{</math>}}, we have

{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_i} = \left[ \begin{matrix} 
var(\varepsilon_{i1}) & cov(\varepsilon_{i1}, \varepsilon_{i2}) & \cdots & cov(\varepsilon_{i1}, \varepsilon_{iT}) \\
cov(\varepsilon_{i1}, \varepsilon_{i2}) & var(\varepsilon_{i2}) & \cdots & cov(\varepsilon_{i2}, \varepsilon_{iT}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{i1}, \varepsilon_{iT}) & cov(\varepsilon_{i2}, \varepsilon_{iT}) & \cdots & var(\varepsilon_{iT})
\end{matrix} \right] \tag{2} $${{</math>}}


and, when {{<math>}}$i \neq j${{</math>}}, we have
{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_{ij}} = \left[ \begin{matrix} 
cov(\varepsilon_{i1}, \varepsilon_{j1}) & cov(\varepsilon_{i1}, \varepsilon_{j2}) & \cdots & cov(\varepsilon_{i1}, \varepsilon_{jT}) \\
cov(\varepsilon_{i1}, \varepsilon_{j2}) & cov(\varepsilon_{i2}, \varepsilon_{j2}) & \cdots & cov(\varepsilon_{i2}, \varepsilon_{jT}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{i1}, \varepsilon_{jT}) & cov(\varepsilon_{i2}, \varepsilon_{jT}) & \cdots & cov(\varepsilon_{iT}, \varepsilon_{jT})
\end{matrix} \right]. \tag{3} $${{</math>}}


Because we assume random sampling, the covariance between two distinct individuals {{<math>}}$(i \neq j)${{</math>}} is  
{{<math>}}$$ cov(\varepsilon_{it}, \varepsilon_{jt}) = cov(\varepsilon_{it}, \varepsilon_{js}) = 0,  \qquad \text{for all } i \neq j.$${{</math>}}

Therefore, {{<math>}}$\boldsymbol{\Sigma}_{ij} = \boldsymbol{0}${{</math>}} (the zero matrix):
{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_{ij}} =  \underset{T \times T}{\boldsymbol{0}} = \left[ \begin{matrix} 
0 & 0 & \cdots & 0 \\
0 & 0 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 0
\end{matrix} \right] $${{</math>}}


Therefore, we can rewrite (1) as

{{<math>}}$$ \underset{NT \times NT}{\boldsymbol{\Sigma}} = \left[ \begin{matrix} 
\boldsymbol{\Sigma}_1 & \boldsymbol{0} & \cdots & \boldsymbol{0} \\
\boldsymbol{0} & \boldsymbol{\Sigma}_2 & \cdots & \boldsymbol{0} \\
\vdots & \vdots & \ddots & \vdots \\
\boldsymbol{0} & \boldsymbol{0} & \cdots & \boldsymbol{\Sigma}_N
\end{matrix} \right]. \tag{1'} $${{</math>}}

We also assume that the individual-level error variance-covariance matrix depends only on {{<math>}}$\sigma^2_u${{</math>}} and {{<math>}}$\sigma^2_v${{</math>}}, because:

- Variance of a single error term: {{<math>}}$ var(\varepsilon_{it}) = \sigma^2_u + \sigma^2_v ${{</math>}}
- Covariance between two errors for the same individual {{<math>}}$i${{</math>}} across periods {{<math>}}$t \neq s${{</math>}}: {{<math>}}$ cov(\varepsilon_{it}, \varepsilon_{is}) = \sigma^2_u ${{</math>}}

Substituting into (2), we obtain

{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_i} = \left[ \begin{array}{cccc} 
\sigma^2_u + \sigma^2_v & \sigma^2_u & \cdots & \sigma^2_u \\
\sigma^2_u & \sigma^2_u + \sigma^2_v & \cdots & \sigma^2_u \\
\vdots & \vdots & \ddots & \vdots \\
\sigma^2_u & \sigma^2_u & \cdots & \sigma^2_u + \sigma^2_v
\end{array} \right] \tag{2'} $${{</math>}}


##### Example
For simplicity, let {{<math>}}$N = 2${{</math>}} and {{<math>}}$T = 3${{</math>}}. Then the error variance-covariance matrix can be written as:

{{<math>}}\begin{align} \underset{6 \times 6}{\boldsymbol{\Sigma}}
&= \left[ \begin{array}{cc}
\boldsymbol{\Sigma}_1 & \boldsymbol{0} \\
\boldsymbol{0} & \boldsymbol{\Sigma}_2
\end{array} \right] \\
&= \left[ \begin{array} {ccc|ccc}
\sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u & 0 & 0 & 0 \\
\sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u & 0 & 0 & 0 \\
\sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v & 0 & 0 & 0\\ \hline
0 & 0 & 0 & \sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u \\
0 & 0 & 0 & \sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u \\
0 & 0 & 0 & \sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v \\
\end{array} \right] \end{align} {{</math>}}

The vertical and horizontal separators above are included only to highlight which elements belong to each block matrix.


#### Computing It in R

First, let {{<math>}}$I_p${{</math>}} denote the identity matrix of dimension {{<math>}}$p \times p${{</math>}}:

{{<math>}}$$ \boldsymbol{I}_p= \left[ \begin{array}{cccc}
    1 & 0 & 0 & \cdots & 0 \\
    0 & 1 & 0 & \cdots & 0 \\
    0 & 0 & 1 & \cdots & 0 \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & 0 & 0 & \cdots & 1
\end{array} \right]_{p \times p}, $$ {{</math>}}

and let {{<math>}}$\boldsymbol{\iota}_q${{</math>}} denote a column vector of ones of length {{<math>}}$q${{</math>}}:
{{<math>}}$$ \boldsymbol{\iota}_q = \left[ \begin{array}{c} 1 \\ 1 \\ \vdots \\ 1 \end{array} \right]_{q \times 1} $${{</math>}}


With **cross-sectional data**, the error variance-covariance matrix is straightforward because there is only one error component, so {{<math>}}$\sigma^2${{</math>}} appears only on the main diagonal:

{{<math>}}\begin{align}
\boldsymbol{\Sigma}_{\scriptscriptstyle{OLS}} &= \sigma^2 \boldsymbol{I}_N \\
  &= \sigma^2 \left[ \begin{array}{cccc} 
1 & 0 & \cdots & 0 \\
0 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1
\end{array} \right] \\
  &= \left[ \begin{array}{cccc} 
\sigma^2 & 0 & \cdots & 0 \\
0 & \sigma^2 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2
\end{array} \right]_{N \times N} \end{align}{{</math>}}


For **panel data**, however, we have two error-component variances. The term {{<math>}}$\sigma^2_v${{</math>}} appears on the main diagonal, while the common individual effect adds {{<math>}}$\sigma^2_u${{</math>}} to all within-individual entries. Therefore, the panel-data error variance-covariance matrix can be written as:

{{<math>}}$$ \boldsymbol{\Sigma} = \sigma^2_v \boldsymbol{I}_{NT} + T \sigma^2_u [\boldsymbol{I}_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T] \tag{4} $${{</math>}}

Note that the first term in the sum creates a main diagonal of {{<math>}}$\sigma^2_v${{</math>}}.

{{<math>}}\begin{align}
\sigma^2_v \boldsymbol{I}_{NT} &= \sigma^2_v \left[ \begin{array}{cccc} 
1 & 0 & \cdots & 0 \\
0 & 1 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 1
\end{array} \right] \\
  &= \left[ \begin{array}{cccc} 
\sigma^2_v & 0 & \cdots & 0 \\
0 & \sigma^2_v & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2_v
\end{array} \right]_{NT \times NT} \end{align}{{</math>}}


Now we only need to add {{<math>}}$\sigma^2_u${{</math>}} to the entries around that diagonal.

For the moment, ignore {{<math>}}$T \sigma^2_u${{</math>}} and denote the bracketed term by the **between (inter-individual)** transformation matrix:

{{<math>}}$$ \boldsymbol{B}\ \equiv\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}

Note that the matrix {{<math>}}$\boldsymbol{B}${{</math>}} is denoted by {{<math>}}$\boldsymbol{N}${{</math>}} in Professor Daniel's 2021 Econometrics II lecture notes.

{{<math>}}\begin{align}
    \boldsymbol{B} &\equiv \boldsymbol{I}_{N} \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \\
    &= \left[ \begin{array}{cc} 1 & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ \vdots \\ 1 \end{array} \right] \left( \left[ \begin{array}{ccc} 1 & \cdots & 1 \end{array} \right] \left[ \begin{array}{c} 1 \\ \vdots \\ 1 \end{array} \right] \right)^{-1} \left[ \begin{array}{ccc} 1 & \cdots & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ \vdots \\ 1 \end{array} \right] \left( T \right)^{-1} \left[ \begin{array}{ccc} 1 & \cdots & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ \vdots \\ 1 \end{array} \right] \frac{1}{T} \left[ \begin{array}{ccc} 1 & \cdots & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & 1 \end{array} \right] \otimes \left( \frac{1}{T}  \left[ \begin{array}{c} 1 & \cdots & 1 \\ \vdots & \ddots & \vdots \\ 1 & \cdots & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & \cdots & 0 \\ \vdots & \ddots & \vdots \\ 0 & \cdots & 1 \end{array} \right]_{N \times N}  \otimes  \left( \begin{array}{ccc} 1/T & \cdots & 1/T \\ \vdots & \ddots & \vdots\\ 1/T & \cdots & 1/T \end{array} \right)_{T \times T}  \\
    &= \left[ \begin{array}{ccc} 1 \left( \begin{array}{ccc} 1/T & \cdots & 1/T \\
    \vdots & \ddots & \vdots\\ 1/T & \cdots & 1/T \end{array} \right) & \cdots & 0 \left( \begin{array}{ccc} 1/T & \cdots & 1/T \\ \vdots & \ddots & \vdots\\ 1/T & \cdots & 1/T \end{array} \right) \\ \vdots & \ddots & \vdots \\ 0 \left( \begin{array}{ccc} 1/T & \cdots & 1/T \\ \vdots & \ddots & \vdots\\ 1/T & \cdots & 1/T \end{array} \right) & \cdots & 1 \left( \begin{array}{ccc} 1/T & \cdots & 1/T \\ \vdots & \ddots & \vdots\\ 1/T & \cdots & 1/T \end{array} \right) \end{array} \right] \\
    &= \left[ \begin{array}{rrr|r|rrr} 
        1/T & \cdots & 1/T & \cdots & 0 & \cdots & 0 \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        1/T & \cdots & 1/T & \cdots & 0 & \cdots & 0 \\\hline
        \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots \\\hline
        0 & \cdots & 0 & \cdots & 1/T & \cdots & 1/T \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        0 & \cdots & 0 & \cdots & 1/T & \cdots & 1/T
    \end{array} \right]_{NT \times NT},
\end{align}{{</math>}}

where {{<math>}}$\otimes${{</math>}} is the Kronecker product. After multiplying by {{<math>}}$T \sigma^2_u${{</math>}}, every {{<math>}}$1/T${{</math>}} entry becomes {{<math>}}$\sigma^2_u${{</math>}}:

{{<math>}}$$ 
    T \sigma^2_u \boldsymbol{B} = \left[ \begin{array}{rrr|r|rrr} 
        \sigma^2_u & \cdots & \sigma^2_u & \cdots & 0 & \cdots & 0 \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        \sigma^2_u & \cdots & \sigma^2_u & \cdots & 0 & \cdots & 0 \\\hline
        \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots \\\hline
        0 & \cdots & 0 & \cdots & \sigma^2_u & \cdots & \sigma^2_u \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        0 & \cdots & 0 & \cdots & \sigma^2_u & \cdots & \sigma^2_u
    \end{array} \right]_{NT \times NT},
$${{</math>}}


Adding the two terms in (4), we obtain the error variance-covariance matrix:

{{<math>}}\begin{align}
    \boldsymbol{\Sigma} &= \sigma^2_v \boldsymbol{I}_{NT} + T \sigma^2_u \boldsymbol{B} \\
    &= \left[ \begin{array}{cccc} 
\sigma^2_v & 0 & \cdots & 0 \\
0 & \sigma^2_v & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & \sigma^2_v
\end{array} \right] + \left[ \begin{array}{ccc|c|ccc} 
        \sigma^2_u & \cdots & \sigma^2_u & \cdots & 0 & \cdots & 0 \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        \sigma^2_u & \cdots & \sigma^2_u & \cdots & 0 & \cdots & 0 \\\hline
        \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots \\\hline
        0 & \cdots & 0 & \cdots & \sigma^2_u & \cdots & \sigma^2_u \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        0 & \cdots & 0 & \cdots & \sigma^2_u & \cdots & \sigma^2_u
    \end{array} \right] \\
    &= \left[ \begin{array}{ccc|c|ccc} 
        \sigma^2_u + \sigma^2_v & \cdots & \sigma^2_u & \cdots & 0 & \cdots & 0 \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        \sigma^2_u & \cdots & \sigma^2_u + \sigma^2_v & \cdots & 0 & \cdots & 0 \\\hline
        \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots \\\hline
        0 & \cdots & 0 & \cdots & \sigma^2_u + \sigma^2_v & \cdots & \sigma^2_u \\
        \vdots & \ddots & \vdots & \cdots & \vdots & \ddots & \vdots \\
        0 & \cdots & 0 & \cdots & \sigma^2_u & \cdots & \sigma^2_u + \sigma^2_v
    \end{array} \right]
\end{align}{{</math>}}


##### Example
Consider the case {{<math>}}$N = 2${{</math>}} and {{<math>}}$T = 3${{</math>}}. Then we obtain the following error variance-covariance matrix:

{{<math>}}$$\boldsymbol{\Sigma} = \left[ \begin{array}{ccc|ccc} 
        \sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u & 0 & 0 & 0 \\
        \sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u & 0 & 0 & 0 \\
        \sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v & 0 & 0 & 0 \\\hline
        0 & 0 & 0 & \sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u \\
        0 & 0 & 0 & \sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u \\
        0 & 0 & 0 & \sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v
    \end{array} \right]$${{</math>}}

Assuming {{<math>}}$\sigma^2_u = 2${{</math>}} and {{<math>}}$\sigma^2_v = 3${{</math>}}, it follows that

{{<math>}}$$\boldsymbol{\Sigma} = \left[ \begin{array}{ccc|ccc} 
        5 & 2 & 2 & 0 & 0 & 0 \\
        2 & 5 & 2 & 0 & 0 & 0 \\
        2 & 2 & 5 & 0 & 0 & 0 \\\hline
        0 & 0 & 0 & 5 & 2 & 2 \\
        0 & 0 & 0 & 2 & 5 & 2 \\
        0 & 0 & 0 & 2 & 2 & 5
    \end{array} \right]$${{</math>}}



</br>


To compute this in R, define:

```r
N = 2 # number of individuals
T = 3 # number of periods
sig2u = 2 # variance of the individual error component
sig2v = 3 # variance of the idiosyncratic error component
```


The first term of {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is

```r
I_NT = diag(N*T) # identity matrix of size NT
I_NT
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    0    0    0    0    0
## [2,]    0    1    0    0    0    0
## [3,]    0    0    1    0    0    0
## [4,]    0    0    0    1    0    0
## [5,]    0    0    0    0    1    0
## [6,]    0    0    0    0    0    1
```

```r
termo1 = sig2v * I_NT
termo1
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    3    0    0    0    0    0
## [2,]    0    3    0    0    0    0
## [3,]    0    0    3    0    0    0
## [4,]    0    0    0    3    0    0
## [5,]    0    0    0    0    3    0
## [6,]    0    0    0    0    0    3
```

For the second term of {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, we first create the identity matrix and the vector of ones:

```r
iota_T = matrix(1, T, 1) # column vector of 1s of length T
iota_T
```

```
##      [,1]
## [1,]    1
## [2,]    1
## [3,]    1
```

```r
I_N = diag(N) # identity matrix of size N
I_N
```

```
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
```

We now compute {{<math>}}$\boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T${{</math>}}

```r
# To obtain a T x T matrix filled with 1/T, where T = 3, we proceed as follows:
t(iota_T) %*% iota_T # inner product of iotas equals T
```

```
##      [,1]
## [1,]    3
```

```r
solve(t(iota_T) %*% iota_T) # taking the inverse gives 1/T
```

```
##           [,1]
## [1,] 0.3333333
```

```r
iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T) # pre- and post-multiplying by the iota vector
```

```
##           [,1]      [,2]      [,3]
## [1,] 0.3333333 0.3333333 0.3333333
## [2,] 0.3333333 0.3333333 0.3333333
## [3,] 0.3333333 0.3333333 0.3333333
```

Now we compute {{<math>}}$\boldsymbol{B}\ =\ I_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T${{</math>}} using the Kronecker product operator `%x%`:

```r
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
round(B, 3)
```

```
##       [,1]  [,2]  [,3]  [,4]  [,5]  [,6]
## [1,] 0.333 0.333 0.333 0.000 0.000 0.000
## [2,] 0.333 0.333 0.333 0.000 0.000 0.000
## [3,] 0.333 0.333 0.333 0.000 0.000 0.000
## [4,] 0.000 0.000 0.000 0.333 0.333 0.333
## [5,] 0.000 0.000 0.000 0.333 0.333 0.333
## [6,] 0.000 0.000 0.000 0.333 0.333 0.333
```

Multiplying {{<math>}}$\boldsymbol{B}${{</math>}} by {{<math>}}$T \sigma^2_u${{</math>}}, we obtain the second term of {{<math>}}$\boldsymbol{\Sigma}${{</math>}}:

```r
termo2 = T * sig2u * B
termo2
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    2    2    2    0    0    0
## [2,]    2    2    2    0    0    0
## [3,]    2    2    2    0    0    0
## [4,]    0    0    0    2    2    2
## [5,]    0    0    0    2    2    2
## [6,]    0    0    0    2    2    2
```

Therefore, the error variance-covariance matrix is given by:

```r
Sigma = termo1 + termo2
Sigma
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    5    2    2    0    0    0
## [2,]    2    5    2    0    0    0
## [3,]    2    2    5    0    0    0
## [4,]    0    0    0    5    2    2
## [5,]    0    0    0    2    5    2
## [6,]    0    0    0    2    2    5
```




### Estimating the Error Components
- Note that {{<math>}}$\sigma^2_v${{</math>}} and {{<math>}}$\sigma^2_u${{</math>}} are unknown, so {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is also unknown.

- First, consider the **within transformation matrix**, given by

{{<math>}}$$ \boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} $${{</math>}}

- Note that we can rewrite
{{<math>}}\begin{align} \hat{\boldsymbol{\Sigma}} &= \hat{\sigma}^2_v \boldsymbol{I}_{NT} + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v (\boldsymbol{W} + \boldsymbol{B}) + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v \boldsymbol{W} + \hat{\sigma}^2_v \boldsymbol{B} + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u) \boldsymbol{B}
\end{align}{{</math>}}
where {{<math>}}$\boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} \iff \boldsymbol{I}_{NT} = \boldsymbol{W} + \boldsymbol{B} ${{</math>}}

</br>

- This can be generalized as:
{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B}, \tag{2.29} $${{</math>}}
where {{<math>}}$p${{</math>}} is a scalar.
- This formula will be useful later when computing {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-1}${{</math>}} and {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-0.5}${{</math>}}.


</br>

- If {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} were observed, we could estimate the two variances as follows:

{{<math>}}\begin{align}
    \hat{\sigma}^2_v &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{W} \boldsymbol{\varepsilon}}{N(T-1)} \tag{2.35} \\
    \\
    \hat{\sigma}^2_v + T \hat{\sigma}^2_u &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} \tag{2.34} \\
    \hat{\sigma}^2_u &= \frac{1}{T} \left( \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} - \hat{\sigma}^2_v \right)
\end{align}{{</math>}}

- Because {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} is unobserved, we instead use residuals from consistent estimators.

- **Wallace and Hussain (1969)**: use OLS residuals.

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N(T-1)} 
\quad \text{and} \quad
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}

- **Amemiya (1971)**: uses _within_ residuals.
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1)}
\quad \text{and} \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Hausman and Taylor (1981)**: adjust Amemiya's method by regressing {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}${{</math>}} on all time-invariant regressors in the model and then using the resulting residuals, {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{HT}}${{</math>}}.

- **Swamy and Arora (1972)**: use both _between_ and _within_ residuals to compute:
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1) - K}
\quad \text{and} \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{B}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}}{N - K - 1} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Nerlove (1971)**: computes {{<math>}}$\sigma^2_u${{</math>}} empirically from the fixed effects of the _within_ model.

{{<math>}}\begin{align}
    \hat{u}_i &= \bar{y}_{i\cdot} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\bar{x}_{i\cdot} \\
    \hat{\sigma}^2_u &= \sum^N_{i=1}{(\hat{u}_i - \bar{\hat{u}}) / (N-1)} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{NT}
\end{align}{{</math>}}


After obtaining {{<math>}}$\hat{\sigma}^2_u${{</math>}} and {{<math>}}$\hat{\sigma}^2_v${{</math>}}, we only need to compute {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}:



</br>

<!-- ## Estimadores OLS em painel -->
<!-- - Supomos que ambos componentes de erros são não-correlacionados com as covariates: -->
<!-- {{<math>}}$$ E(u|X) = E(v|X) = 0 $${{</math>}} -->
<!-- - A variabilidade em um painel tem 2 componentes: -->
<!--     - a _between_ ou inter-individuals, where a variabilidade das variáveis são mensuradas em médias individuais, como {{<math>}}$\bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$BZ${{</math>}} -->
<!--     - a _within_ ou intra-individuals, where a variabilidade das variáveis são mensuradas em desvios das médias individuais, como {{<math>}}$z_{it} - \bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$\boldsymbol{WX} = \boldsymbol{X} - \boldsymbol{BX}${{</math>}} -->
<!--     - Lembre-se que {{<math>}}$\boldsymbol{X} \equiv (\boldsymbol{\iota}, X)${{</math>}} -->
<!-- - Há três estimadores por OLS que podem ser utilizados: -->
<!--     1. *Mínimos Quadrados Empilhados (GLS)*: usando a base de dados bruta (empilhada) -->
<!--     2. *Estimador Between*: usando as médias individuais -->
<!--     3. *Estimador Within (Efeitos Fixos)*: usando os desvios das médias individuais -->



## GLS Estimator
- Section 2.1.1 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Pooled GLS uses the same point estimates as OLS, but inference is based on {{<math>}}$\boldsymbol{\Sigma} \neq \sigma^2 \boldsymbol{I}${{</math>}}, allowing correlation among observations from the same individual {{<math>}}$i${{</math>}}.


The model to be estimated is
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X\beta} + \boldsymbol{\varepsilon} $${{</math>}}


- The GLS estimator {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} (which coincides with OLS in point estimation) is given by
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

- Note that the OLS estimator variance-covariance matrix, under {{<math>}}$ \boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I} ${{</math>}}, simplifies to:

{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}) 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\ 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \left[ \sigma^2 \boldsymbol{I} \right] \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \sigma^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \hat{\sigma}^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \end{align}{{</math>}}


- The GLS estimator variance-covariance matrix, which allows correlation among observations from the same individual, is given by
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


### Estimation via `plm()`
To illustrate the estimators discussed above, we use the `TobinQ` dataset from the `pder` package, which contains data for 188 firms over 35 years (6,580 observations).

```r
data("TobinQ", package = "pder")
str(TobinQ)
```

```
## 'data.frame':	6580 obs. of  15 variables:
##  $ cusip : int  2824 2824 2824 2824 2824 2824 2824 2824 2824 2824 ...
##  $ year  : num  1951 1952 1953 1954 1955 ...
##  $ isic  : int  2835 2835 2835 2835 2835 2835 2835 2835 2835 2835 ...
##  $ ikb   : num  0.2295 0.0403 0.0404 0.0518 0.055 ...
##  $ ikn   : num  0.2049 0.1997 0.1103 0.1258 0.0682 ...
##  $ qb    : num  5.61 6.01 4.19 4 4.47 ...
##  $ qn    : num  10.91 12.23 7.41 6.78 7.37 ...
##  $ kstock: num  27.3 30.5 31.7 32.6 32.3 ...
##  $ ikicb : num  NA 0.193156 0.002919 -0.007656 -0.000145 ...
##  $ ikicn : num  0.012 0.02448 0.09763 -0.00635 0.06144 ...
##  $ omphi : num  0.1841 0.0968 0.0745 0.0727 0.0558 ...
##  $ qicb  : num  NA 0.245 1.9 0.421 -0.166 ...
##  $ qicn  : num  NA 0.066 4.685 0.947 -0.135 ...
##  $ sb    : num  NA 1.98 1.55 1.65 1.64 ...
##  $ sn    : num  NA 4.02 3.3 3.09 2.94 ...
```
- `cusip`: Firm identifier
- `year`: Year
- `ikn`: Investment divided by capital
- `qn`: Tobin's Q (the ratio between firm value and the replacement cost of physical capital). If {{<math>}}$Q > 1${{</math>}}, the return on investment exceeds its cost.

We want to estimate the following model:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta_1 + \varepsilon $${{</math>}}


We use the `plm()` function from the package of the same name to estimate linear panel-data models. Its main arguments are:

- `formula`: model equation
- `data`: the dataset, either as a `data.frame` (in which case `index` must be supplied) or as a `pdata.frame` (the package's indexed panel-data format)
- `model`: estimator to compute: `pooling` (GLS), `between`, `within` (fixed effects), or `random` (random effects / FGLS)
- `index`: vector with the names of the individual and time identifiers

Note that pooled estimation via `plm()` still uses {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}}, so it incorrectly ignores within-individual error correlation:


```r
library(plm)

# Converting to `pdata.frame` format with individual and time identifiers
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# OLS estimation
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")
Q.ols = lm(ikn ~ qn, TobinQ)

# Comparing both outputs
stargazer::stargazer(Q.pooling, Q.ols, type="text", omit.stat="f")
```

```
## 
## ================================================
##                         Dependent variable:     
##                     ----------------------------
##                                 ikn             
##                       panel           OLS       
##                       linear                    
##                        (1)            (2)       
## ------------------------------------------------
## qn                   0.004***      0.004***     
##                      (0.0002)      (0.0002)     
##                                                 
## Constant             0.158***      0.158***     
##                      (0.001)        (0.001)     
##                                                 
## ------------------------------------------------
## Observations          6,580          6,580      
## R2                    0.111          0.111      
## Adjusted R2           0.111          0.111      
## Residual Std. Error            0.086 (df = 6578)
## ================================================
## Note:                *p<0.1; **p<0.05; ***p<0.01
```


- We need to conduct inference using an appropriate error variance-covariance matrix. For that, we use the argument `vcov=vcovBK` inside `summary()`: 

```r
# GLS estimation with an error covariance matrix allowing within-individual correlation
summary(Q.pooling, vcov=vcovBK)$coef
```

```
##               Estimate   Std. Error  t-value     Pr(>|t|)
## (Intercept) 0.15799969 0.0034686968 45.55016 0.000000e+00
## qn          0.00439197 0.0003774606 11.63557 5.458161e-31
```



### Analytical Estimation
The analytical GLS derivation is the same as OLS, but adapted to the panel-data setting. The main differences are the degrees of freedom, {{<math>}}$NT - K - 1${{</math>}}, and the panel-specific structure of the error variance-covariance matrix {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix
head(y)
```

```
##            [,1]
## [1,] 0.20488372
## [2,] 0.19974634
## [3,] 0.11033265
## [4,] 0.12583384
## [5,] 0.06819211
## [6,] 0.09540332
```

```r
# Creating the covariate matrix X with a first column of ones
X = cbind( 1, TobinQ[, "qn"] ) # adding a column of ones to the covariates
X = as.matrix(X) # converting to a matrix
head(X)
```

```
##      [,1]      [,2]
## [1,]    1 10.910007
## [2,]    1 12.234629
## [3,]    1  7.410110
## [4,]    1  6.779812
## [5,]    1  7.372266
## [6,]    1  6.097779
```

```r
# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
N # number of individuals
```

```
## [1] 188
```

```r
T = length( unique(TobinQ$year) )
T # number of periods
```

```
## [1] 35
```

```r
K = ncol(X) - 1
K # number of covariates
```

```
## [1] 1
```

b) GLS estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{GLS}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

```r
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
bhat
```

```
##            [,1]
## [1,] 0.15799969
## [2,] 0.00439197
```

c) Fitted values {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}} = \boldsymbol{X} \hat{\boldsymbol{\beta}} $${{</math>}}


```r
yhat = X %*% bhat
head(yhat)
```

```
##           [,1]
## [1,] 0.2059161
## [2,] 0.2117338
## [3,] 0.1905447
## [4,] 0.1877764
## [5,] 0.1903785
## [6,] 0.1847810
```

d) Residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}} $${{</math>}}


```r
ehat = y - yhat
head(ehat)
```

```
##              [,1]
## [1,] -0.001032395
## [2,] -0.011987475
## [3,] -0.080212022
## [4,] -0.061942582
## [5,] -0.122186352
## [6,] -0.089377633
```

e) Error-term variances

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Because {{<math>}}$\hat{\sigma}^2_u${{</math>}} and {{<math>}}$\hat{\sigma}^2_v${{</math>}} are scalars, it is convenient to convert the resulting "1x1 matrices" into numbers with `as.numeric()`: 

```r
# Creating the between and within matrices
iota_T = matrix(1, T, 1) # column vector of 1s of length T
I_N = diag(N) # identity matrix of size N
I_NT = diag(N*T) # identity matrix of size NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Computing the error-component variances (Wallace and Hussain)
sig2v = as.numeric( (t(ehat) %*% W %*% ehat) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat) %*% B %*% ehat)/N - sig2v ) )
```


f) Error Variance-Covariance Matrix
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = \hat{\sigma}^2_v \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u) \boldsymbol{B}$${{</math>}}


```r
# Computing the error variance-covariance matrix
Sigma = sig2v * W + (sig2v + T*sig2u) * B
```



g) Estimator Variance-Covariance Matrix

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
bread = solve( t(X) %*% X )
meat = t(X) %*% Sigma %*% X
Vbhat = bread %*% meat %*% bread # sandwich
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.220549e-05 -2.839164e-07
## [2,] -2.839164e-07  1.133241e-07
```


h) Standard errors of the estimator {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034936352 0.0003366365
```

i) _t_ statistic

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_bhat = bhat / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 45.22501
## [2,] 13.04663
```

j) p-value

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)
p_bhat
```

```
##              [,1]
## [1,] 0.000000e+00
## [2,] 1.986019e-38
```

k) Summary table

```r
data.frame(bhat, se_bhat, t_bhat, p_bhat) # correct GLS result
```

```
##         bhat      se_bhat   t_bhat       p_bhat
## 1 0.15799969 0.0034936352 45.22501 0.000000e+00
## 2 0.00439197 0.0003366365 13.04663 1.986019e-38
```

```r
summary(Q.pooling)$coef # OLS result via `plm()` or `lm()`
```

```
##               Estimate  Std. Error   t-value      Pr(>|t|)
## (Intercept) 0.15799969 0.001124399 140.51928  0.000000e+00
## qn          0.00439197 0.000152940  28.71694 5.789663e-171
```

```r
summary(Q.pooling, vcov=vcovBK)$coef # with the adjusted error covariance matrix
```

```
##               Estimate   Std. Error  t-value     Pr(>|t|)
## (Intercept) 0.15799969 0.0034686968 45.55016 0.000000e+00
## qn          0.00439197 0.0003774606 11.63557 5.458161e-31
```


</br>


## FGLS Estimator

- Section 2.3 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Also known as the **random-effects estimator**, because it treats individual effects as random: {{<math>}}$E(\boldsymbol{u}) = 0${{</math>}}
- Errors are linked through the error variance-covariance matrix {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- The FGLS estimator is given by
{{<math>}}$$ {\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} = (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) \tag{2.27} $${{</math>}}

- The variance-covariance matrix of the estimator is given by
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \tag{2.28} $${{</math>}}
- The matrix {{<math>}}$\boldsymbol{\Sigma}${{</math>}} depends on only two parameters, {{<math>}}$\sigma^2_u${{</math>}} and {{<math>}}$\sigma^2_v${{</math>}}:
{{<math>}}$$ \boldsymbol{\Sigma}^p = ({\sigma}^2_v)^p \boldsymbol{W} + ({\sigma}^2_v + T {\sigma}^2_u)^p \boldsymbol{B} \tag{2.29} $${{</math>}}

</br>

- Because {{<math>}}$\boldsymbol{\Sigma}${{</math>}} is unknown, we can estimate {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}} by estimating the error components using, for example, Wallace and Hussain (1969):

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N(T-1)} 
\quad \text{and} \quad
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}



### Estimation via `plm()`
- We use `plm()` again, this time setting `model = "random"` so the model is estimated by FGLS.
- In `random.method`, we can choose the procedure used to estimate the error-component parameters:
    1. `"walhus"` for Wallace and Hussain (1969)
    2. `"amemiya"` for Amemiya (1971)
    3. `"ht"` for Hausman and Taylor (1981)
    4. `"swar"` for Swamy and Arora (1972) [default]
    5. `"nerlove"` for Nerlove (1971)


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# FGLS estimations
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "nerlove")

# Summarizing the five estimations in a single table
stargazer::stargazer(Q.walhus, Q.amemiya, Q.ht, Q.swar, Q.nerlove,
                     digits=5, type="text", omit.stat="f")
```

```
## 
## ===================================================================
##                               Dependent variable:                  
##              ------------------------------------------------------
##                                       ikn                          
##                 (1)        (2)        (3)        (4)        (5)    
## -------------------------------------------------------------------
## qn           0.00386*** 0.00386*** 0.00386*** 0.00386*** 0.00386***
##              (0.00017)  (0.00017)  (0.00017)  (0.00017)  (0.00017) 
##                                                                    
## Constant     0.15933*** 0.15933*** 0.15933*** 0.15933*** 0.15934***
##              (0.00341)  (0.00344)  (0.00344)  (0.00342)  (0.00361) 
##                                                                    
## -------------------------------------------------------------------
## Observations   6,580      6,580      6,580      6,580      6,580   
## R2            0.07418    0.07412    0.07412    0.07415    0.07376  
## Adjusted R2   0.07404    0.07398    0.07398    0.07401    0.07362  
## ===================================================================
## Note:                                   *p<0.1; **p<0.05; ***p<0.01
```

In this particular case, the results are virtually identical.



### Analytical Estimation
- Here, we derive the analytical FGLS estimator using the Wallace and Hussain (1969) method.
- First, we compute {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}${{</math>}} and {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}${{</math>}} in order to estimate {{<math>}}$\hat{\sigma}^2_{u}${{</math>}}, {{<math>}}$\hat{\sigma}^2_{v}${{</math>}}, and {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}.
- Then we estimate {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}} and its variance matrix {{<math>}}$V_{\hat{\boldsymbol{\beta}}_{\tiny{FGLS}}}${{</math>}}.


a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix

# Creating the covariate matrix X with a first column of ones
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # adding a column of ones to the covariates

# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1
```

b) OLS estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

```r
bhat_OLS = solve( t(X) %*% X ) %*% t(X) %*% y
```

c) OLS fitted values {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
yhat_OLS = X %*% bhat_OLS
```

d) OLS residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
ehat_OLS = y - yhat_OLS
```

e) Error-term variances

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Because {{<math>}}$\hat{\sigma}^2_u${{</math>}} and {{<math>}}$\hat{\sigma}^2_v${{</math>}} are scalars, it is convenient to convert the resulting "1x1 matrices" into numbers with `as.numeric()`: 

```r
# Creating the between and within matrices
iota_T = matrix(1, T, 1) # column vector of 1s of length T
I_N = diag(N) # identity matrix of size N
I_NT = diag(N*T) # identity matrix of size NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Computing the error-component variances (Wallace and Hussain)
sig2v = as.numeric( (t(ehat_OLS) %*% W %*% ehat_OLS) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat_OLS) %*% B %*% ehat_OLS)/N - sig2v ) )
```


f) Error Variance-Covariance Matrix

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Computing the error variance-covariance matrix
Sigma = sig2v * W + (sig2v + T*sig2u) * B

# Matrix inverse
Sigma_1 = sig2v^(-1) * W + (sig2v + T*sig2u)^(-1) * B
```

*Note that using `solve()` on the `Sigma` matrix is computationally slower than using the formula


g) FGLS estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} $${{</math>}}

```r
bhat_FGLS = solve( t(X) %*% Sigma_1 %*% X ) %*% t(X) %*% Sigma_1 %*% y
bhat_FGLS
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```


h) Estimator Variance-Covariance Matrix

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vbhat = solve( t(X) %*% Sigma_1 %*% X )
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.167208e-05 -7.100808e-08
## [2,] -7.100808e-08  2.834259e-08
```


i) Standard errors of the estimator {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034164422 0.0001683526
```

j) _t_ statistic

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_bhat = bhat_FGLS / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 46.63503
## [2,] 22.94370
```

k) p-value

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)
p_bhat
```

```
##               [,1]
## [1,]  0.000000e+00
## [2,] 3.904386e-112
```

l) Summary table

```r
data.frame(bhat_FGLS, se_bhat, t_bhat, p_bhat) # correct GLS result
```

```
##     bhat_FGLS      se_bhat   t_bhat        p_bhat
## 1 0.159325869 0.0034164422 46.63503  0.000000e+00
## 2 0.003862631 0.0001683526 22.94370 3.904386e-112
```

```r
summary(Q.walhus)$coef # FGLS result via `plm()`
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```



#### Transforming and Estimating by OLS
In addition to the form shown above, we can transform the variables and solve by OLS after premultiplying {{<math>}}$\boldsymbol{X}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}}, defining:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X} \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}$${{</math>}}

f') Error Variance-Covariance Matrix

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Error Variance-Covariance Matrix ^ (-0.5)
Sigma_05 = sig2v^(-0.5) * W + (sig2v + T*sig2u)^(-0.5) * B

# Transformed variables
X_til = Sigma_05 %*% X
y_til = Sigma_05 %*% y
```


g') FGLS estimates via OLS

{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= ([\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}])^{-1} [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}] \\
&\equiv (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}}= \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}}
\end{align}{{</math>}}

Note that {{<math>}}$\boldsymbol{\Sigma}'^{-0.5} = \boldsymbol{\Sigma}^{-0.5}${{</math>}}.


```r
bhat_OLS = solve( t(X_til) %*% X_til ) %*% t(X_til) %*% y_til
bhat_OLS
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```

h') Valores Ajustados e Residuals OLS
{{<math>}}$$\tilde{\hat{y}} = \tilde{\boldsymbol{X}} \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} \qquad \text{and} \qquad  \tilde{\hat{\boldsymbol{\varepsilon}}} = \boldsymbol{y} - \tilde{\hat{y}} $${{</math>}}


```r
yhat_OLS = X_til %*% bhat_OLS # Fitted values
ehat_OLS = y_til - yhat_OLS # Residuals
```


i') Error-term variance OLS
{{<math>}}$$\hat{\sigma}^2 =  \frac{\tilde{\hat{\boldsymbol{\varepsilon}}}'\tilde{\hat{\boldsymbol{\varepsilon}}}}{NT - K - 1} $${{</math>}}

```r
sig2hat = as.numeric( t(ehat_OLS) %*% ehat_OLS / (N*T - K - 1) )
```


j') Error Variance-Covariance Matrix OLS
{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
Vbhat_OLS = sig2hat * solve(t(X_til) %*% X_til)
Vbhat_OLS
```

```
##               [,1]          [,2]
## [1,]  1.165808e-05 -7.092295e-08
## [2,] -7.092295e-08  2.830861e-08
```


k') Standard errors, t statistics, and p-values

```r
se_bhat_OLS = sqrt( diag(Vbhat_OLS) )
t_bhat_OLS = bhat_OLS / se_bhat_OLS
p_bhat_OLS = 2 * pt(-abs(t_bhat_OLS), N*T-K-1)
```

l') Comparativo

```r
# Analytical FGLS via OLS
data.frame(bhat_OLS, se_bhat_OLS, t_bhat_OLS, p_bhat_OLS)
```

```
##      bhat_OLS  se_bhat_OLS t_bhat_OLS    p_bhat_OLS
## 1 0.159325869 0.0034143937   46.66300  0.000000e+00
## 2 0.003862631 0.0001682516   22.95747 2.912584e-112
```

```r
# FGLS via plm
summary(Q.walhus)$coef
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```



</br>

## Transformation Matrices
- Section 2.1.2 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)


### Panel Data Model (2)

- We now distinguish time-invariant explanatory variables from time-varying ones.
- Suppose that among the {{<math>}}$K${{</math>}} explanatory variables, {{<math>}}$J${{</math>}} are time-invariant and {{<math>}}$L${{</math>}} are time-varying:

Model (1) is:
{{<math>}}\begin{align} y_{it} &= \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{1} \\
&= 1.\beta_0 + x^1_{it} \beta_1 + ... + x^J_{it} \beta_J + x^{J+1}_{it} \beta_{J+1} + ... + x^K_{it} \beta_K + \varepsilon_{it} \end{align}{{</math>}}
and it can be rewritten as:
{{<math>}}\begin{align} y_{it} &= \boldsymbol{x}'_{i} \boldsymbol{\Gamma} + \boldsymbol{x}^{*\prime}_{it} \boldsymbol{\delta} + \varepsilon_{it} \tag{2} \\
&= 1.\Gamma_0 + x^1_{i} \Gamma_1 + ... + x^J_{i} \Gamma_J + x^{*1}_{it} \delta_{1} + ... + x^{*L}_{it} \delta_L + \varepsilon_{it} \end{align}{{</math>}}
where:

- {{<math>}}$\boldsymbol{x}'_{it} = [\boldsymbol{x}'_{i}, \boldsymbol{x}^{*\prime}_{it}] ${{</math>}}

- {{<math>}}$\boldsymbol{x}'_{i}${{</math>}} collects the realizations of the {{<math>}}$J${{</math>}} time-invariant variables, together with the intercept:
{{<math>}}$$ \boldsymbol{x}'_{i} = \begin{bmatrix} 1 & x^1_i & x^2_i & \cdots & x^J_i \end{bmatrix}  $${{</math>}}

- {{<math>}}$\boldsymbol{x}^{*\prime}_{it}${{</math>}} collects the realizations of the {{<math>}}$L${{</math>}} time-varying variables:
{{<math>}}$$ \boldsymbol{x}^{*\prime}_{it} = \begin{bmatrix} x^{*1}_{it} & x^{*2}_{it} & \cdots & x^{*L}_{it} \end{bmatrix} $${{</math>}}

- {{<math>}}$\varepsilon_{it} = u_i + v_{it}${{</math>}}.
- {{<math>}}$\boldsymbol{\Gamma}${{</math>}} and {{<math>}}$\boldsymbol{\delta}${{</math>}} are the parameter vectors for time-invariant and time-varying variables, respectively, so that
{{<math>}}\begin{align} \boldsymbol{\beta}\quad\ &\equiv \begin{bmatrix} \ \boldsymbol{\Gamma}\  \\ \ \boldsymbol{\delta}\  \end{bmatrix} \\
\begin{bmatrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_J \\\hline \beta_{J+1} \\ \beta_{J+2} \\ \vdots \\ \beta_{K} \end{bmatrix} &\equiv \begin{bmatrix} \Gamma_0 \\ \Gamma_1 \\ \Gamma_2 \\ \vdots \\ \Gamma_J \\\hline \delta_1 \\ \delta_2 \\ \vdots \\ \delta_L \end{bmatrix} \end{align}{{</math>}}


Stacking equation (2) over all {{<math>}}$i${{</math>}} and {{<math>}}$t${{</math>}}, we obtain
{{<math>}}$$ \boldsymbol{y}\ =\ \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \ =\ \boldsymbol{X}_0 \boldsymbol{\Gamma} + \boldsymbol{X}^{*} \boldsymbol{\delta} + \boldsymbol{\varepsilon} $${{</math>}}
or, using

{{<math>}}\begin{align} \boldsymbol{X} &= \left[ \begin{array}{ccccc|cccc}
    1 & x^1_{11} & x^2_{11} & \cdots & x^J_{11} & x^{J+1}_{11} & x^{J+2}_{11} & \cdots & x^K_{11} \\
    1 & x^1_{12} & x^2_{12} & \cdots & x^J_{12} & x^{J+1}_{12} & x^{J+2}_{12} & \cdots & x^K_{12} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{1T} & x^2_{1T} & \cdots & x^J_{1T} & x^{J+1}_{1T} & x^{J+2}_{1T} & \cdots & x^K_{1T} \\\hline
    1 & x^1_{21} & x^2_{21} & \cdots & x^J_{21} & x^{J+1}_{21} & x^{J+2}_{21} & \cdots & x^K_{21} \\
    1 & x^1_{22} & x^2_{22} & \cdots & x^J_{22} & x^{J+1}_{22} & x^{J+2}_{22} & \cdots & x^K_{22} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{2T} & x^2_{2T} & \cdots & x^J_{2T} & x^{J+1}_{2T} & x^{J+2}_{2T} & \cdots & x^K_{2T} \\\hline
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    1 & x^1_{N1} & x^2_{N1} & \cdots & x^J_{N1} & x^{J+1}_{N1} & x^{J+2}_{N1} & \cdots & x^K_{21} \\
    1 & x^1_{N2} & x^2_{N2} & \cdots & x^J_{N2} & x^{J+1}_{N2} & x^{J+2}_{N2} & \cdots & x^K_{N2} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{NT} & x^2_{NT} & \cdots & x^J_{NT} & x^{J+1}_{NT} & x^{J+2}_{NT} & \cdots & x^K_{NT}
\end{array} \right] \\\\
\equiv \begin{bmatrix} \boldsymbol{X}_0, \boldsymbol{X}^{*} \end{bmatrix} &= \left[ \begin{array}{ccccc|cccc}
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & x^{*1}_{11} & x^{*2}_{11} & \cdots & x^{*L}_{11} \\
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & x^{*1}_{12} & x^{*2}_{12} & \cdots & x^{*L}_{12} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & x^{*1}_{1T} & x^{*2}_{1T} & \cdots & x^{*L}_{1T} \\\hline
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & x^{*1}_{21} & x^{*2}_{21} & \cdots & x^{*L}_{21} \\
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & x^{*1}_{22} & x^{*2}_{22} & \cdots & x^{*L}_{22} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & x^{*1}_{2T} & x^{*2}_{2T} & \cdots & x^{*L}_{2T} \\\hline
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    1 & x^1_{N} & x^2_{N} & \cdots & x^J_{N} & x^{*1}_{N1} & x^{*2}_{N1} & \cdots & x^{*L}_{21} \\
    1 & x^1_{N} & x^2_{N} & \cdots & x^J_{N} & x^{*1}_{N2} & x^{*2}_{N2} & \cdots & x^{*L}_{N2} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{N\ \ \ } & x^2_{N\ \ \ } & \cdots & x^J_{N\ \ \ } & x^{*1}_{NT} & x^{*2}_{NT} & \cdots & x^{*L}_{NT}
\end{array} \right] \end{align}{{</math>}}


<!-- {{<math>}}\begin{align} \underbrace{\boldsymbol{\delta}}_{(K+1) \times 1} &\equiv \left[ \begin{array}{c} \alpha \\ \boldsymbol{\beta} \end{array} \right] =  -->
<!--  \left[ \begin{array}{c} \alpha \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{array} \right] \quad \text{ e }\\  -->
<!-- \underbrace{\boldsymbol{X}}_{NT \times (K+1)} &\equiv \left[ \begin{array}{c} \boldsymbol{\iota} & \boldsymbol{X} \end{array} \right] -->
<!--   = \left[ \begin{array}{cccc} -->
<!--     1 & x^1_{11} & x^2_{11} & \cdots & x^K_{11} \\ -->
<!--     1 & x^1_{12} & x^2_{12} & \cdots & x^K_{12} \\ -->
<!--     \vdots & \vdots & \vdots & \ddots & \vdots \\ -->
<!--     1 & x^1_{1T} & x^2_{1T} & \cdots & x^K_{1T} \\ \hline -->
<!--     1 & x^1_{21} & x^2_{21} & \cdots & x^K_{21} \\ -->
<!--     1 & x^1_{22} & x^2_{22} & \cdots & x^K_{22} \\ -->
<!--     \vdots & \vdots & \vdots & \ddots & \vdots \\  -->
<!--     1 & x^1_{2T} & x^2_{2T} & \cdots & x^K_{2T} \\ \hline -->
<!--     \vdots & \vdots & \vdots & \ddots & \vdots \\ \hline -->
<!--     1 & x^1_{N1} & x^2_{N1} & \cdots & x^K_{N1} \\ -->
<!--     1 & x^1_{N2} & x^2_{N2} & \cdots & x^K_{N2} \\ -->
<!--     \vdots & \vdots & \vdots & \ddots & \vdots \\ -->
<!--     1 & x^1_{NT} & x^2_{NT} & \cdots & x^K_{NT} -->
<!-- \end{array} \right], \end{align} {{</math>}} -->

<!-- podemos reescrever como -->
<!-- {{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\delta} + \boldsymbol{\varepsilon}. $${{</math>}} -->



### _Between_
The **between (inter-individual)** transformation matrix is denoted by:
{{<math>}}$$ \boldsymbol{B}\ =\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}
Note that the matrix {{<math>}}$\boldsymbol{B}${{</math>}} corresponds to {{<math>}}$\boldsymbol{N}${{</math>}} in the Econometrics II lecture notes.

Premultiplying {{<math>}}$\boldsymbol{X}${{</math>}} by the _between_ transformation matrix {{<math>}}$\boldsymbol{B}${{</math>}} yields:
{{<math>}}$$ x^k_{it}\ \overset{\boldsymbol{B}}{\Longrightarrow}\ \bar{x}^k_{i}\ =\ \frac{1}{T} \sum^T_{i=1}{x^k_{it}}, \qquad \forall i, t, k $${{</math>}}

Thus,

{{<math>}}$$ \boldsymbol{BX} = \left[ \begin{array}{ccccc|cccc}
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & \bar{x}^{*1}_{1} & \bar{x}^{*2}_{1} & \cdots & \bar{x}^{*L}_{1} \\
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & \bar{x}^{*1}_{1} & \bar{x}^{*2}_{1} & \cdots & \bar{x}^{*L}_{1} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{1} & x^2_{1} & \cdots & x^J_{1} & \bar{x}^{*1}_{1} & \bar{x}^{*2}_{1} & \cdots & \bar{x}^{*L}_{1} \\\hline
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & \bar{x}^{*1}_{2} & \bar{x}^{*2}_{2} & \cdots & \bar{x}^{*L}_{2} \\
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & \bar{x}^{*1}_{2} & \bar{x}^{*2}_{2} & \cdots & \bar{x}^{*L}_{2} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{2} & x^2_{2} & \cdots & x^J_{2} & \bar{x}^{*1}_{2} & \bar{x}^{*2}_{2} & \cdots & \bar{x}^{*L}_{2} \\\hline
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    1 & x^1_{N} & x^2_{N} & \cdots & x^J_{N} & \bar{x}^{*1}_{N} & \bar{x}^{*2}_{N} & \cdots & \bar{x}^{*L}_{2} \\
    1 & x^1_{N} & x^2_{N} & \cdots & x^J_{N} & \bar{x}^{*1}_{N} & \bar{x}^{*2}_{N} & \cdots & \bar{x}^{*L}_{N} \\
    \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{N} & x^2_{N} & \cdots & x^J_{N} & \bar{x}^{*1}_{N} & \bar{x}^{*2}_{N} & \cdots & \bar{x}^{*L}_{N}
\end{array} \right]_{NT \times (K+1)} $${{</math>}}

</br>

For example, when {{<math>}}$N = 2${{</math>}} and {{<math>}}$T = 3${{</math>}}, we have:

{{<math>}}$$ \boldsymbol{B} = \left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right]_{6 \times 6}, $${{</math>}}


For instance, suppose {{<math>}}$\boldsymbol{X}${{</math>}} has {{<math>}}$J=1${{</math>}} time-invariant variable and {{<math>}}$P=3${{</math>}} time-varying variables: 

{{<math>}}$$ \boldsymbol{X} = \begin{bmatrix} \boldsymbol{X}_0 & \boldsymbol{X}^{*} \end{bmatrix} = \left[ \begin{array}{cc|ccc}
1 & 3 & 1 & 3 & 6 \\
1 & 3 & 9 & 5 & 4 \\
1 & 3 & 8 & 7 & 2 \\ \hline
1 & 7 & 6 & 6 & 8 \\
1 & 7 & 8 & 6 & 1 \\
1 & 7 & 1 & 9 & 9
\end{array} \right]_{6 \times 5} $${{</math>}}

The horizontal separator is included only to emphasize that the first three rows refer to individual {{<math>}}$i=1${{</math>}} and the last three rows to individual {{<math>}}$i=2${{</math>}}. There are three rows for each because we assume {{<math>}}$t=1,2,3${{</math>}}.

Thus, we have:

{{<math>}}\begin{align} \boldsymbol{BX} &=  
\left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\\hline
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right] \left[ \begin{array}{cc|ccc}
1 & 3 & 1 & 3 & 6 \\
1 & 3 & 9 & 5 & 4 \\
1 & 3 & 8 & 7 & 2 \\ \hline
1 & 7 & 6 & 6 & 8 \\
1 & 7 & 8 & 6 & 1 \\
1 & 7 & 1 & 9 & 9
\end{array} \right] \\
&= \left[ \begin{array}{cc|ccc}
1 & 3 & 6 & 5 & 4 \\
1 & 3 & 6 & 5 & 4 \\
1 & 3 & 6 & 5 & 4 \\ \hline
1 & 7 & 5 & 7 & 6 \\
1 & 7 & 5 & 7 & 6 \\
1 & 7 & 5 & 7 & 6
\end{array} \right]_{6 \times 5} \end{align}{{</math>}}

Note that, for each individual {{<math>}}$i${{</math>}} and column {{<math>}}$k${{</math>}}, the entries are filled with that individual's time average over {{<math>}}$t=1,2,3${{</math>}}.


</br>


Now let us define a covariate matrix `X` and premultiply it by `B`.

```r
N = 2 # nº individuals
T = 3 # nº periods
K = 4 # nº explanatory variables

# Computing the between transformation matrix
iota_T = matrix(1, nrow=T, ncol=1) # vector of ones of dimension T
I_N = diag(N) # identity matrix of dimension N
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
B # between transformation matrix
```

```
##           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
## [1,] 0.3333333 0.3333333 0.3333333 0.0000000 0.0000000 0.0000000
## [2,] 0.3333333 0.3333333 0.3333333 0.0000000 0.0000000 0.0000000
## [3,] 0.3333333 0.3333333 0.3333333 0.0000000 0.0000000 0.0000000
## [4,] 0.0000000 0.0000000 0.0000000 0.3333333 0.3333333 0.3333333
## [5,] 0.0000000 0.0000000 0.0000000 0.3333333 0.3333333 0.3333333
## [6,] 0.0000000 0.0000000 0.0000000 0.3333333 0.3333333 0.3333333
```

```r
# Covariate matrix X
X = matrix(c(rep(1, 6), # 1st column of 1s
             rep(3, 3), rep(7, 3), # 2a coluna
             1,9,8,6,8,1, # 3a coluna
             3,5,7,6,6,9, # 4a coluna
             6,4,2,8,1,9  # 5a coluna
             ), ncol=K+1) # covariate matrix of dimension NT x (K+1)
X
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    1    3    6
## [2,]    1    3    9    5    4
## [3,]    1    3    8    7    2
## [4,]    1    7    6    6    8
## [5,]    1    7    8    6    1
## [6,]    1    7    1    9    9
```

```r
# Premultiplying X by B
B %*% X # matrix of individual-specific covariate means (NT x K)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    3    6    5    4
## [2,]    1    3    6    5    4
## [3,]    1    3    6    5    4
## [4,]    1    7    5    7    6
## [5,]    1    7    5    7    6
## [6,]    1    7    5    7    6
```

Note that:
- Columns 1 and 2 remain unchanged after the _between_ transformation because they are time-invariant (the average of a constant is the constant itself).
- for a given variable {{<math>}}$k${{</math>}}, each individual {{<math>}}$i${{</math>}} is represented by a single average value;
- as a result, a sample with {{<math>}}$NT${{</math>}} observations is reduced to only {{<math>}}$N${{</math>}} distinct observations, so we lose {{<math>}}$N(T-1)${{</math>}} degrees of freedom.


</br>

### _Within_
The **within (intra-individual)** transformation matrix is given by:
{{<math>}}$$ \boldsymbol{W}\ =\ \boldsymbol{I}_{NT} - \boldsymbol{B}\ =\ \boldsymbol{I}_{NT} - \Big[ \boldsymbol{I}_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big]. $${{</math>}}

Note that the matrix {{<math>}}$\boldsymbol{W}${{</math>}} corresponds to {{<math>}}$\boldsymbol{M}${{</math>}} in the Econometrics II lecture notes (2021).

Premultiplying {{<math>}}$\boldsymbol{X}${{</math>}} by the _within_ transformation matrix {{<math>}}$\boldsymbol{W}${{</math>}} yields:
{{<math>}}$$ x^{k}_{it}\ \overset{\boldsymbol{W}}{\Longrightarrow}\ x^{k}_{it} - \bar{x}^{k}_i\ =\ x^{k}_{it} - \frac{1}{T} \sum^T_{i=1}{x^{k}_{it}}, \qquad \forall i, t, l=1,...,L $${{</math>}}

Thus,
{{<math>}}\begin{align} \boldsymbol{WX} &= \left[ \begin{array}{ccc|cccc}
    0 & \cdots & 0 & x^{*1}_{11} - \bar{x}^{*1}_{1} & x^{*2}_{11} - \bar{x}^{*2}_{1} & \cdots & x^{*L}_{11} - \bar{x}^{*L}_{1} \\
    0 & \cdots & 0 & x^{*1}_{12} - \bar{x}^{*1}_{1} & x^{*2}_{12} - \bar{x}^{*2}_{1} & \cdots & x^{*2}_{1T} - \bar{x}^{*L}_{1} \\
    \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & \cdots & 0 & x^{*1}_{1T} - \bar{x}^{*1}_{1} & x^{*2}_{1T} - \bar{x}^{*2}_{1} & \cdots & x^{*L}_{1T} - \bar{x}^{*L}_{1} \\\hline
    0 & \cdots & 0 & x^{*1}_{21} - \bar{x}^{*1}_{2} & x^{*2}_{21} - \bar{x}^{*2}_{2} & \cdots & x^{*L}_{21} - \bar{x}^{*L}_{2} \\
    0 & \cdots & 0 & x^{*1}_{22} - \bar{x}^{*1}_{2} & x^{*2}_{22} - \bar{x}^{*2}_{2} & \cdots & x^{*2}_{22} - \bar{x}^{*L}_{2} \\
    \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & \cdots & 0 & x^{*1}_{2T} - \bar{x}^{*1}_{2} & x^{*2}_{2T} - \bar{x}^{*2}_{2} & \cdots & x^{*L}_{2T} - \bar{x}^{*L}_{2} \\\hline
    \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    0 & \cdots & 0 & x^{*1}_{N1} - \bar{x}^{*1}_{N} & x^{*2}_{N1} - \bar{x}^{*2}_{N} & \cdots & x^{*L}_{N1} - \bar{x}^{*L}_{N} \\
    0 & \cdots & 0 & x^{*1}_{N2} - \bar{x}^{*1}_{N} & x^{*2}_{N2} - \bar{x}^{*2}_{N} & \cdots & x^{*2}_{N2} - \bar{x}^{*L}_{N} \\
    \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & \cdots & 0 & x^{*1}_{NT} - \bar{x}^{*1}_{N} & x^{*2}_{NT} - \bar{x}^{*2}_{N} & \cdots & x^{*L}_{NT} - \bar{x}^{*L}_{N} 
\end{array} \right]_{NT \times L}  \\
&= \boldsymbol{WX}^* \end{align}{{</math>}}


For example, when {{<math>}}$N = 2${{</math>}} and {{<math>}}$T = 3${{</math>}}, we have:

{{<math>}}\begin{align}
    \boldsymbol{W} &= \boldsymbol{I}_{6} - \boldsymbol{B} \\
    &= \left[ \begin{array}{cccccc} 
        1 & 0 & 0 & 0 & 0 & 0 \\
        0 & 1 & 0 & 0 & 0 & 0 \\
        0 & 0 & 1 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1 & 0 & 0 \\
        0 & 0 & 0 & 0 & 1 & 0 \\
        0 & 0 & 0 & 0 & 0 & 1
    \end{array} \right] - \left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right] \\
    &= \left[ \begin{array}{rrrrrr} 
         2/6 & -1/3 & -1/3 &    0 &    0 &    0 \\
        -1/3 &  2/6 & -1/3 &    0 &    0 &    0 \\
        -1/3 & -1/3 &  2/6 &    0 &    0 &    0 \\
           0 &    0 &    0 &  2/6 & -1/3 & -1/3 \\
           0 &    0 &    0 & -1/3 &  2/6 & -1/3 \\
           0 &    0 &    0 & -1/3 & -1/3 &  2/6
    \end{array} \right]_{6 \times 6} , 
\end{align}{{</math>}}


Thus, we have:

{{<math>}}\begin{align} \boldsymbol{WX} =  
&\left[ \begin{array}{rrrrrr} 
         2/6 & -1/3 & -1/3 &    0 &    0 &    0 \\
        -1/3 &  2/6 & -1/3 &    0 &    0 &    0 \\
        -1/3 & -1/3 &  2/6 &    0 &    0 &    0 \\
           0 &    0 &    0 &  2/6 & -1/3 & -1/3 \\
           0 &    0 &    0 & -1/3 &  2/6 & -1/3 \\
           0 &    0 &    0 & -1/3 & -1/3 &  2/6
    \end{array} \right] \\ 
    &\left[ \begin{array}{cc|ccc}
1 & 3 & 1 & 3 & 6 \\
1 & 3 & 9 & 5 & 4 \\
1 & 3 & 8 & 7 & 2 \\ \hline
1 & 7 & 6 & 6 & 8 \\
1 & 7 & 8 & 6 & 1 \\
1 & 7 & 1 & 9 & 9
\end{array} \right] \\
= &\left[ \begin{array}{cc|ccc}
0 & 0 & -5 & -2 &  2 \\
0 & 0 &  3 &  0 &  0 \\
0 & 0 &  2 &  2 & -2 \\ \hline
0 & 0 &  1 & -1 &  2 \\
0 & 0 &  3 & -1 & -5 \\
0 & 0 & -4 &  2 &  3
\end{array} \right]_{6 \times 5} = \boldsymbol{WX}^* \end{align}{{</math>}}

Note that we lose all variation in the first two columns, which are time-invariant. In other words, the entire submatrix {{<math>}}$\boldsymbol{X}_0${{</math>}} drops out, leaving only {{<math>}}$\boldsymbol{X}^{*}${{</math>}} with the time-varying covariates.



```r
I_NT = diag(N*T) # identity matrix of dimension NT
W = I_NT - B 
W # within transformation matrix
```

```
##            [,1]       [,2]       [,3]       [,4]       [,5]       [,6]
## [1,]  0.6666667 -0.3333333 -0.3333333  0.0000000  0.0000000  0.0000000
## [2,] -0.3333333  0.6666667 -0.3333333  0.0000000  0.0000000  0.0000000
## [3,] -0.3333333 -0.3333333  0.6666667  0.0000000  0.0000000  0.0000000
## [4,]  0.0000000  0.0000000  0.0000000  0.6666667 -0.3333333 -0.3333333
## [5,]  0.0000000  0.0000000  0.0000000 -0.3333333  0.6666667 -0.3333333
## [6,]  0.0000000  0.0000000  0.0000000 -0.3333333 -0.3333333  0.6666667
```

```r
# Premultiplying X by W
round(W %*% X, 10) # rounding
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    0    0   -5   -2    2
## [2,]    0    0    3    0    0
## [3,]    0    0    2    2   -2
## [4,]    0    0    1   -1    2
## [5,]    0    0    3   -1   -5
## [6,]    0    0   -4    2    3
```
Observe que:

- for each variable {{<math>}}$k${{</math>}}, we obtain deviations from the individual-specific mean;
- columns 1 and 2, which are time-invariant, become zero after the _within_ transformation and therefore drop out of the regression.
- the zero column in R is numerically very close to zero ({{<math>}}$1.11 \times 10^{-16}${{</math>}}), so rounding is useful.


</br>

### First Differences
- The first-difference matrix transforms variables into changes between periods {{<math>}}$t+1${{</math>}} and {{<math>}}$t${{</math>}}, and has the following non-square form:
{{<math>}}$$\boldsymbol{D} = \boldsymbol{I}_N \otimes \boldsymbol{D}_i $${{</math>}}
where {{<math>}}$\boldsymbol{I}_N${{</math>}} is the identity matrix of size {{<math>}}$N${{</math>}}, and

{{<math>}}$$\boldsymbol{D}_i = \begin{bmatrix}
-1 & 1 & 0 & \cdots & 0 & 0 \\
0 & -1 & 1 & \cdots & 0 & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & 0 & \cdots & -1 & 1
\end{bmatrix}_{(T-1)\times T}$${{</math>}}
This is not a square matrix and has the main off-diagonals equal to {{<math>}}$-1${{</math>}} and {{<math>}}$1${{</math>}}.


Premultiplying {{<math>}}$\boldsymbol{X}${{</math>}} by the first-difference transformation matrix {{<math>}}$\boldsymbol{D}${{</math>}} yields:
{{<math>}}$$ x^{k}_{it}\ \overset{\boldsymbol{D}}{\Longrightarrow}\ \Delta x^{k}_{it} \ =\ x^{k}_{i,t+1} - x^{k}_{it}, \qquad \forall i, k, t = 1, 2, ..., T-1 $${{</math>}}

Thus,
{{<math>}}\begin{align} \boldsymbol{DX} &= \left[ \begin{array}{c|cccc}
    0 \cdots 0 & x^{*1}_{12} - x^{*1}_{11} & x^{*2}_{12} - x^{*2}_{11} & \cdots & x^{*L}_{12} - x^{*L}_{11} \\
    0 \cdots 0 & x^{*1}_{13} - x^{*1}_{12} & x^{*2}_{13} - x^{*2}_{12} & \cdots & x^{*2}_{13} - x^{*L}_{12} \\
    \vdots \ddots \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 \cdots 0 & x^{*1}_{1T} - x^{*1}_{1,T-1} & x^{*2}_{1T} - x^{*2}_{1,T-1} & \cdots & x^{*L}_{1T} - x^{*L}_{1,T-1} \\\hline
    0 \cdots 0 & x^{*1}_{22} - x^{*1}_{21} & x^{*2}_{22} - x^{*2}_{21} & \cdots & x^{*L}_{22} - x^{*L}_{21} \\
    0 \cdots 0 & x^{*1}_{23} - x^{*1}_{2} & x^{*2}_{22} - x^{*2}_{2} & \cdots & x^{*2}_{23} - x^{*L}_{22} \\
    \vdots \ddots \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 \cdots 0 & x^{*1}_{2T} - x^{*1}_{2,T-1} & x^{*2}_{2T} - x^{*2}_{2,T-1} & \cdots & x^{*L}_{2T} - x^{*L}_{2,T-1} \\\hline
    \vdots \ddots \vdots & \vdots & \vdots & \ddots & \vdots \\\hline
    0 \cdots 0 & x^{*1}_{N2} - x^{*1}_{N1} & x^{*2}_{N2} - x^{*2}_{N1} & \cdots & x^{*L}_{N2} - x^{*L}_{N1} \\
    0 \cdots 0 & x^{*1}_{N3} - x^{*1}_{N2} & x^{*2}_{N3} - x^{*2}_{N2} & \cdots & x^{*2}_{N3} - x^{*L}_{N2} \\
    \vdots \ddots \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 \cdots 0 & x^{*1}_{NT} - x^{*1}_{N,T-1} & x^{*2}_{NT} - x^{*2}_{N,T-1} & \cdots & x^{*L}_{NT} - x^{*L}_{N,T-1} 
\end{array} \right]  \\
&= \underset{N(T-1) \times L}{\boldsymbol{DX}^*} \end{align}{{</math>}}

</br>

For example, when {{<math>}}$N = 2${{</math>}} and {{<math>}}$T = 3${{</math>}}, we have:

{{<math>}}$$ \boldsymbol{D}_i = \begin{bmatrix} 
-1 &  1 &  0 \\
 0 & -1 &  1 \end{bmatrix}_{2 \times 3},\quad i=1,2 $${{</math>}}

Thus, we have

{{<math>}}\begin{align} \boldsymbol{DX} &=  
\left[ \begin{array}{rrr|rrr} 
         -1 &  1 &  0 &  0 &  0 &  0 \\
          0 & -1 &  1 &  0 &  0 &  0 \\\hline
          0 &  0 &  0 & -1 &  1 &  0 \\
          0 &  0 &  0 &  0 & -1 &  1 
    \end{array} \right]  
    \left[ \begin{array}{cc|ccc}
1 & 3 & 1 & 3 & 6 \\
1 & 3 & 9 & 5 & 4 \\
1 & 3 & 8 & 7 & 2 \\ \hline
1 & 7 & 6 & 6 & 8 \\
1 & 7 & 8 & 6 & 1 \\
1 & 7 & 1 & 9 & 9
\end{array} \right] \\
&= \left[ \begin{array}{cc|ccc}
0 & 0 &  8 & 2 & -2 \\
0 & 0 & -1 & 2 & -2 \\\hline
0 & 0 &  2 & 0 & -7 \\
0 & 0 & -7 & 3 &  8
\end{array} \right]_{4 \times 5} = \boldsymbol{DX}^* \end{align}{{</math>}}

Note that we lose all variation in the first two columns, which are time-invariant {{<math>}}$(\boldsymbol{X}_0)${{</math>}}. In addition, we lose one period for each individual {{<math>}}$i${{</math>}}.



To build {{<math>}}$\boldsymbol{D}_i${{</math>}} in R, we:

a) create an identity matrix of size {{<math>}}$T${{</math>}} and multiply it by {{<math>}}$-1${{</math>}}
{{<math>}}$$ -\boldsymbol{I}_T = \begin{bmatrix}
-1 &  0 &  0 \\
 0 & -1 &  0 \\
 0 &  0 & -1
\end{bmatrix} $${{</math>}}.

```r
Di = -diag(T) # main diagonal set to -1
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    0    0
## [2,]    0   -1    0
## [3,]    0    0   -1
```


b) modify the superdiagonal, which is the diagonal of the {{<math>}}$(T-1)${{</math>}} identity submatrix obtained by excluding the first column and the last row of the {{<math>}}$T \times T${{</math>}} matrix
{{<math>}}$$ \left[ \begin{array}{c|cc}
-1 &  0 &  0 \\
 0 & -1 &  0 \\\hline
 0 &  0 & -1
\end{array} \right] \Longrightarrow \left[ \begin{array}{ccc}
-1 &  1 &  0 \\
 0 & -1 &  1 \\
 0 &  0 & -1
\end{array} \right] $${{</math>}}

```r
diag(Di[-nrow(Di),-1]) = 1 # superdiagonal
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    1    0
## [2,]    0   -1    1
## [3,]    0    0   -1
```

c) drop the last row, leaving a matrix of dimension {{<math>}}$(T-1)\times T${{</math>}}
{{<math>}}$$ \Longrightarrow \boldsymbol{D}_i = \left[ \begin{array}{ccc}
-1 &  1 &  0 \\
 0 & -1 &  1 
\end{array} \right]_{2 \times 3} $${{</math>}}

```r
Di = Di[-nrow(Di),] # dropping the last row
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    1    0
## [2,]    0   -1    1
```

Then we simply take the Kronecker product, {{<math>}}$\otimes${{</math>}}, between the identity matrix {{<math>}}$\boldsymbol{I}_N${{</math>}} and {{<math>}}$\boldsymbol{D}_i${{</math>}}:


{{<math>}}\begin{align}\boldsymbol{D} &= \boldsymbol{I}_N \otimes \boldsymbol{D}_i \\
&= \begin{bmatrix}
1 & 0 \\
0 & 1 
\end{bmatrix}_{2 \times 2} \otimes \begin{pmatrix}
1 & -1 & 0 \\
0 & 1 & -1 
\end{pmatrix}_{2 \times 3} \\
&= \begin{bmatrix}
1\begin{pmatrix}
1 & -1 & 0 \\
0 & 1 & -1 
\end{pmatrix} & 0\begin{pmatrix}
1 & -1 & 0 \\
0 & 1 & -1 
\end{pmatrix} \\
0\begin{pmatrix}
1 & -1 & 0 \\
0 & 1 & -1 
\end{pmatrix} & 1\begin{pmatrix}
1 & -1 & 0 \\
0 & 1 & -1 
\end{pmatrix} 
\end{bmatrix} \\
&= \left[\begin{array}{ccc|ccc}
1 & -1 &  0 & 0 &  0 &  0 \\
0 &  1 & -1 & 0 &  0 &  0 \\\hline
0 &  0 &  0 & 1 & -1 &  0 \\
0 &  0 &  0 & 0 &  1 & -1 \\
\end{array}\right]_{4 \times 6} \end{align}{{</math>}}



```r
I_N = diag(N) # identity matrix of size N
D = I_N %x% Di
D # first-difference matrix
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]   -1    1    0    0    0    0
## [2,]    0   -1    1    0    0    0
## [3,]    0    0    0   -1    1    0
## [4,]    0    0    0    0   -1    1
```

```r
# DX transformation
D %*% X
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    0    0    8    2   -2
## [2,]    0    0   -1    2   -2
## [3,]    0    0    2    0   -7
## [4,]    0    0   -7    3    8
```

Observe que:

- columns 1 and 2, which are time-invariant, become zero after first differencing and therefore drop out of the regression.
- we also lose one row per individual in order to compute changes across periods.




</br>

## _Between_ Estimator

The model to be estimated is OLS premultiplied by {{<math>}}$\boldsymbol{B} = \boldsymbol{I}_N \otimes \boldsymbol{\iota} (\boldsymbol{\iota}' \boldsymbol{\iota})^{-1} \boldsymbol{\iota}'${{</math>}}:
{{<math>}}$$ \boldsymbol{By}\ =\ \boldsymbol{BX\beta} + \boldsymbol{B\varepsilon} $${{</math>}}

- The _between_ estimator is given by
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}\ =\ (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} y $${{</math>}}

- Defina
{{<math>}}$$ \hat{\sigma}^2_l \equiv \hat{\sigma}^2_v + T \hat{\sigma}^2_u  $${{</math>}}

- The covariance matrix of the estimator can be written as
{{<math>}}\begin{align}
    V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}) &= (\boldsymbol{X}'\boldsymbol{BX})^{-1} \boldsymbol{X}' \boldsymbol{B}\boldsymbol{\Sigma} \boldsymbol{B} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{BX})^{-1} \\
    &\ \ \vdots \\
    &= \hat{\sigma}^2_l (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X})^{-1},
\end{align}{{</math>}}


- The unbiased estimator of {{<math>}}$\sigma^2_l${{</math>}} is
{{<math>}}$$ \hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}}}{N-K-1} $${{</math>}}
where {{<math>}}$\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}${{</math>}} denotes the residual vector obtained from {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}${{</math>}}.

- The _between_ estimator can also be obtained by OLS after premultiplying the variables by the _between_ matrix {{<math>}}$(\boldsymbol{B})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}} \equiv \boldsymbol{BX} \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{By} $${{</math>}}

Then
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}} &= (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} y \\
&= (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} \boldsymbol{B} y \\
&= (\boldsymbol{X}' \boldsymbol{B}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B}' \boldsymbol{B} y \\
&= ([\boldsymbol{B} \boldsymbol{X}]' \boldsymbol{B} \boldsymbol{X} )^{-1} [\boldsymbol{B} \boldsymbol{X}]' \boldsymbol{B} y \\
&\equiv ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} \end{align}{{</math>}}

Note that we use:
{{<math>}}$$ \boldsymbol{B} = \boldsymbol{B}\boldsymbol{B} \qquad \text{and} \qquad \boldsymbol{B}=\boldsymbol{B}' $${{</math>}}


<!-- ```{r} -->
<!-- # Example N = 2 e T = 3 -->
<!-- N = 2 -->
<!-- T = 3 -->

<!-- # Computing the between transformation matrix -->
<!-- iota_T = matrix(1, nrow=T, ncol=1) # vector of ones of dimension T -->
<!-- I_N = diag(N) # identity matrix of dimension N -->
<!-- B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T)) -->
<!-- B # matriz between -->
<!-- B %*% B # multiplicação matricial de matrizes between -->
<!-- t(B) # transposta da matriz between -->
<!-- ``` -->


### Estimation via `plm()`
Again, we use the `TobinQ` dataset from the `pder` package and estimate the following model:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta_1 + \varepsilon $${{</math>}}


```r
# Loading the required package and dataset
library(plm)
data(TobinQ, package="pder")

# Converting to `pdata.frame` format with individual and time identifiers
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimations
Q.between = plm(ikn ~ qn, pTobinQ, model = "between")
summary(Q.between)
```

```
## Oneway (individual) effect Between Model
## 
## Call:
## plm(formula = ikn ~ qn, data = pTobinQ, model = "between")
## 
## Balanced Panel: n = 188, T = 35, N = 6580
## Observations used in estimation: 188
## 
## Residuals:
##      Min.   1st Qu.    Median   3rd Qu.      Max. 
## -0.109457 -0.027820 -0.009795  0.024550  0.193177 
## 
## Coefficients:
##               Estimate Std. Error t-value  Pr(>|t|)    
## (Intercept) 0.15601353 0.00388203 40.1886 < 2.2e-16 ***
## qn          0.00518474 0.00074907  6.9216 7.013e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    0.50783
## Residual Sum of Squares: 0.40382
## R-Squared:      0.20482
## Adj. R-Squared: 0.20054
## F-statistic: 47.9079 on 1 and 186 DF, p-value: 7.0128e-11
```




<!-- ### Estimação via lm() -->

<!-- Nós podemos construir as variáveis de média diretamente no data frame e fazer a estimação _between_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "by hand" as variáveis de médias para cada individual -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (individual) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transformação" between de ikn -->
<!--         qn_bar = mean(qn), # "transformação" between de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estimação between via lm() -->
<!-- Q.between.ols = lm(ikn_bar ~ qn_bar, TobinQ) -->

<!-- # Comparing the estimates -->
<!-- summary(Q.between.ols)$coef # between via OLS -->
<!-- summary(Q.between)$coef # between ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note quand the error padrão está subestimado no output gerado por `lm()`. -->
<!-- - A rotina padrão de OLS retorna {{<math>}}$\hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a Error Variance-Covariance Matrix por {{<math>}}$(NT-K-1) / (N-K-1)${{</math>}}. -->
<!--   - _Between_ perde {{<math>}}$N(T-1)${{</math>}} observations pois cada individual fica apenas com 1 observation.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de variância covariância do estimador -->
<!-- vcov.ols = vcov(Q.between.ols) -->
<!-- vcov.between = vcov.ols * (N*T - K - 1) / (N - K - 1) -->
<!-- se.between = sqrt( diag(vcov.between) ) -->
<!-- se.between -->
<!-- ``` -->



### Analytical Estimation

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix

# Creating the covariate matrix X with a first column of ones
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # adding a column of ones to the covariates

# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1
```


b) Calculando a matriz _between_

{{<math>}}$$ \boldsymbol{B} = \boldsymbol{I}_{N} \otimes \left[ \boldsymbol{\iota}_T \left( \boldsymbol{\iota}'_T \boldsymbol{\iota}_T  \right)^{-1} \boldsymbol{\iota}'_T \right] $${{</math>}}


```r
# Creating the between matrix
iota_T = matrix(1, T, 1) # column vector of 1s of length T
I_N = diag(N) # identity matrix of size N
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
```


c) _Between_ estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}} = (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{B} \boldsymbol{y} $${{</math>}}

```r
bhat_B = solve( t(X) %*% B %*% X ) %*% t(X) %*% B %*% y
bhat_B
```

```
##             [,1]
## [1,] 0.156013534
## [2,] 0.005184737
```

d) Fitted values _Between_ {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{B}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{B}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}} $${{</math>}}


```r
yhat_B = X %*% bhat_B
```

e) Residuals _Between_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{B}} $${{</math>}}


```r
ehat_B = y - yhat_B
```

f) Error-term variance

{{<math>}}$$ \hat{\sigma}^2_l \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{B}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}}{N - K - 1} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2_l${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2l = as.numeric( (t(ehat_B) %*% B %*% ehat_B) / (N - K - 1) )
```
**IMPORTANT**: Adjust the degrees of freedom of the _between_ estimator to {{<math>}}$N - K - 1${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g) Estimator Variance-Covariance Matrix _Between_

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}) = \hat{\sigma}^2_l (\boldsymbol{X}' B \boldsymbol{X})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vbhat_B = sig2l * solve( t(X) %*% B %*% X )
Vbhat_B
```

```
##               [,1]          [,2]
## [1,]  1.507017e-05 -1.405770e-06
## [2,] -1.405770e-06  5.611075e-07
```


i) Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_bhat_B = sqrt( diag(Vbhat_B) )
se_bhat_B
```

```
## [1] 0.0038820321 0.0007490711
```

j) _t_ statistic

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_bhat_B = bhat_B / se_bhat_B
t_bhat_B
```

```
##           [,1]
## [1,] 40.188625
## [2,]  6.921555
```

k) p-value

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_bhat_B = 2 * pt(-abs(t_bhat_B), N-K-1)
p_bhat_B
```

```
##              [,1]
## [1,] 1.227764e-93
## [2,] 7.012814e-11
```

l) Summary table

```r
data.frame(bhat_B, se_bhat_B, t_bhat_B, p_bhat_B) # _Between_ result
```

```
##        bhat_B    se_bhat_B  t_bhat_B     p_bhat_B
## 1 0.156013534 0.0038820321 40.188625 1.227764e-93
## 2 0.005184737 0.0007490711  6.921555 7.012814e-11
```

```r
summary(Q.between)$coef # _Between_ result via plm()
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```



#### Transforming and Estimating by OLS
In addition to the form shown above, we can transform the variables and solve by OLS after premultiplying {{<math>}}$\boldsymbol{X}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$\boldsymbol{B}${{</math>}}, defining:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{B} \boldsymbol{X} \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{B} \boldsymbol{y}$${{</math>}}

c') _Between_ estimates via OLS

{{<math>}}$$ \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} = (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transforming the variables
X_til = B %*% X
y_til = B %*% y

# Estimating
bhat_OLS = solve( t(X_til) %*% X_til ) %*% t(X_til) %*% y_til
bhat_OLS
```

```
##             [,1]
## [1,] 0.156013534
## [2,] 0.005184737
```

d') Fitted values _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} = \tilde{\boldsymbol{X}} \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
yhat_OLS = X_til %*% bhat_OLS
```

e') Residuals OLS

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Error-term variance

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{N - K - 1} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N - K - 1) )
```
**IMPORTANT**: Adjust the degrees of freedom of the _between_ estimator to {{<math>}}$N - K - 1${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g) Estimator Variance-Covariance Matrix OLS

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vbhat_OLS = sig2hat * solve( t(X_til) %*% X_til )
Vbhat_OLS
```

```
##               [,1]          [,2]
## [1,]  1.507017e-05 -1.405770e-06
## [2,] -1.405770e-06  5.611075e-07
```


i) Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_bhat_OLS = sqrt( diag(Vbhat_OLS) )
se_bhat_OLS
```

```
## [1] 0.0038820321 0.0007490711
```

j) _t_ statistic

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_bhat_OLS = bhat_OLS / se_bhat_OLS
t_bhat_OLS
```

```
##           [,1]
## [1,] 40.188625
## [2,]  6.921555
```

k) p-value

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_bhat_OLS = 2 * pt(-abs(t_bhat_OLS), N-K-1)
p_bhat_OLS
```

```
##              [,1]
## [1,] 1.227764e-93
## [2,] 7.012814e-11
```

l) Summary table

```r
data.frame(bhat_OLS, se_bhat_OLS, t_bhat_OLS, p_bhat_OLS) # _Between_ result via OLS
```

```
##      bhat_OLS  se_bhat_OLS t_bhat_OLS   p_bhat_OLS
## 1 0.156013534 0.0038820321  40.188625 1.227764e-93
## 2 0.005184737 0.0007490711   6.921555 7.012814e-11
```

```r
summary(Q.between)$coef # _Between_ result via plm()
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```


</br>

## _Within_ Estimator (Fixed Effects)
- Also known as the **fixed-effects estimator**
- **It does not assume that {{<math>}}$E(u \mid X) = 0${{</math>}}**
- In other words, it allows the individual effect to be correlated with the regressors.
- It works with deviations from individual means.

The model to be estimated is OLS premultiplied by {{<math>}}$\boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B}${{</math>}}:
{{<math>}}$$ \boldsymbol{Wy}\ =\ \boldsymbol{WX\beta} + \boldsymbol{W\varepsilon}\ =\ \boldsymbol{WX}^* \boldsymbol{\beta} + \boldsymbol{Wv}. $${{</math>}}
Note that the _within_ transformation removes time-invariant variables, the intercept, and the individual effect {{<math>}}$u${{</math>}}, leaving only the idiosyncratic error {{<math>}}$\varepsilon = v${{</math>}}.

- The _within_ estimator is given by
{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}\ =\ (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} $${{</math>}}


- The covariance matrix of the estimator can be written as
{{<math>}}\begin{align}
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}) &= (\boldsymbol{X}^{*\prime}\boldsymbol{WX}^*)^{-1} \boldsymbol{X}' \boldsymbol{W}\boldsymbol{\Sigma} \boldsymbol{W} \boldsymbol{X} (\boldsymbol{X}^{*\prime}\boldsymbol{WX}^*)^{-1} \\
    &\ \ \vdots \\
    &= \sigma^2_v (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1}.
\end{align}{{</math>}}

- The unbiased estimator of {{<math>}}$\sigma^2_v${{</math>}} is
{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}

- The _within_ estimator can also be obtained by OLS after premultiplying the variables by the _within_ matrix {{<math>}}$(\boldsymbol{W})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}}^* \equiv \boldsymbol{WX}^* \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{Wy} $${{</math>}}

Then

{{<math>}}\begin{align} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} &= (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} \\
&= (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{W} \boldsymbol{y} \\
&= (\boldsymbol{X}^{*\prime} \boldsymbol{W}' \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W}' \boldsymbol{W} \boldsymbol{y} \\
&= ([\boldsymbol{W} \boldsymbol{X}^{*}]' \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} [\boldsymbol{W} \boldsymbol{X}^{*}]' \boldsymbol{W} \boldsymbol{y} \\
&\equiv ( \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}} )^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} \end{align}{{</math>}}

Note that we use:
{{<math>}}$$ \boldsymbol{W} = \boldsymbol{W}\boldsymbol{W} \qquad \text{and} \qquad \boldsymbol{W}=\boldsymbol{W}' $${{</math>}}


<!-- ```{r} -->
<!-- # Example N = 2 e T = 3 -->
<!-- N = 2 -->
<!-- T = 3 -->
<!-- I_NT = diag(N*T) # identity matrix of dimension N -->
<!-- W = I_NT - B -->

<!-- W # matriz within -->
<!-- W %*% W # multiplicação matricial de matrizes within -->
<!-- t(W) # transposta da matriz within -->
<!-- ``` -->


### Estimation via `plm()`
Again, we use the `TobinQ` dataset from the `pder` package and estimate the following model:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta + \varepsilon $${{</math>}}


```r
# Loading the required package and dataset
library(plm)
data(TobinQ, package="pder")

# Converting to `pdata.frame` format with individual and time identifiers
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Comparing the estimates
Q.within = plm(ikn ~ qn, pTobinQ, model = "within")
summary(Q.within)
```

```
## Oneway (individual) effect Within Model
## 
## Call:
## plm(formula = ikn ~ qn, data = pTobinQ, model = "within")
## 
## Balanced Panel: n = 188, T = 35, N = 6580
## 
## Residuals:
##       Min.    1st Qu.     Median    3rd Qu.       Max. 
## -0.2163093 -0.0452458 -0.0084941  0.0336543  0.6184391 
## 
## Coefficients:
##      Estimate Std. Error t-value  Pr(>|t|)    
## qn 0.00379195 0.00017264  21.964 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    36.657
## Residual Sum of Squares: 34.084
## R-Squared:      0.070185
## Adj. R-Squared: 0.042833
## F-statistic: 482.412 on 1 and 6391 DF, p-value: < 2.22e-16
```
- Note that:
    - the variables enter the estimation without any manual transformation; and
    - each method has different degrees of freedom.


<!-- ### Estimação via lm() -->

<!-- Nós podemos construir as variáveis de média e de desvios de média diretamente no data frame e fazer a estimação _within_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "by hand" as variáveis de desvios da média para cada individual -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (individual) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transformação" between de ikn -->
<!--         qn_bar = mean(qn), # "transformação" between de qn -->
<!--         ikn_desv = ikn - ikn_bar, # "transformação" within de ikn -->
<!--         qn_desv = qn - qn_bar # "transformação" within de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estimação within via lm() -->
<!-- Q.within.ols = lm(ikn_desv ~ 0 + qn_desv, TobinQ) # retira intercepto com 0 -->

<!-- # Comparing the estimates -->
<!-- summary(Q.within.ols)$coef # within via OLS -->
<!-- summary(Q.within)$coef # within ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note quand the error padrão está subestimado no output gerado por `lm()`. -->
<!-- - A rotina padrão de OLS retorna {{<math>}}$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a Error Variance-Covariance Matrix por {{<math>}}$(NT-K-1) / (NT-K-N)${{</math>}}. -->
<!--   - _Within_ estima mais {{<math>}}$N${{</math>}} parâmetros (efeitos fixos dos individuals) e deixa de estimar o intercepto.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de variância covariância do estimador -->
<!-- vcov.ols = vcov(Q.within.ols) -->
<!-- vcov.within = vcov.ols * (N*T - K - 1) / (N*(T-1) - K) -->
<!-- se.within = sqrt( diag(vcov.within) ) -->
<!-- se.within -->
<!-- ``` -->



### Analytical Estimation

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix

# Creating the matrix/vector Xt of time-varying covariates
Xt = as.matrix( TobinQ[, "qn"] ) # no intercept column is added

# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(Xt) # no intercept is subtracted
```


b) Calculando as matrizes _between_ e _within_

{{<math>}}$$ \boldsymbol{B} = \boldsymbol{I}_{N} \otimes \left[ \boldsymbol{\iota}_T \left( \boldsymbol{\iota}'_T \boldsymbol{\iota}_T  \right)^{-1} \boldsymbol{\iota}'_T \right] \qquad \text{and} \qquad \boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} $${{</math>}}


```r
# Creating the between matrix
iota_T = matrix(1, T, 1) # column vector of 1s of length T
I_N = diag(N) # identity matrix of size N
I_NT = diag(N*T) # identity matrix of size NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B
```


c) _Within_ estimates {{<math>}}$\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} = (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} $${{</math>}}

```r
dhat_W = solve( t(Xt) %*% W %*% Xt ) %*% t(Xt) %*% W %*% y
dhat_W
```

```
##             [,1]
## [1,] 0.003791948
```

d) Fitted values _Within_ {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{W}} = \boldsymbol{X}^{*} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} $${{</math>}}


```r
yhat_W = Xt %*% dhat_W
```


e) Residuals _Within_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{W}} $${{</math>}}


```r
ehat_W = y - yhat_W
```

f) Error-term variance

{{<math>}}$$ \hat{\sigma}^2_v =  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{NT - K - N} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2_v${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2v = as.numeric( (t(ehat_W) %*% W %*% ehat_W) / (N*T - K - N) )
```
**IMPORTANT**: Adjust the degrees of freedom of the _within_ estimator to {{<math>}}$NT - K - N${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g) Estimator Variance-Covariance Matrix _Within_

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}) = \hat{\sigma}^2_v (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vdhat_W = sig2v * solve( t(Xt) %*% W %*% Xt )
Vdhat_W
```

```
##             [,1]
## [1,] 2.98062e-08
```


i) Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_dhat_W = sqrt( diag(Vdhat_W) )
se_dhat_W
```

```
## [1] 0.0001726447
```

j) _t_ statistic

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_dhat_W = dhat_W / se_dhat_W
t_dhat_W
```

```
##          [,1]
## [1,] 21.96388
```

k) p-value

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_dhat_W = 2 * pt(-abs(t_dhat_W), N*T-K-N)
p_dhat_W
```

```
##               [,1]
## [1,] 3.854128e-103
```

l) Summary table

```r
cbind(dhat_W, se_dhat_W, t_dhat_W, p_dhat_W) # _Within_ result
```

```
##                     se_dhat_W                       
## [1,] 0.003791948 0.0001726447 21.96388 3.854128e-103
```

```r
summary(Q.within)$coef # _Within_ result via plm()
```

```
##       Estimate   Std. Error  t-value      Pr(>|t|)
## qn 0.003791948 0.0001726447 21.96388 3.854128e-103
```



#### Transforming and Estimating by OLS
In addition to the form shown above, we can transform the variables and solve by OLS after premultiplying {{<math>}}$\boldsymbol{X}^{*}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$\boldsymbol{W}${{</math>}}, defining:

{{<math>}}$$\tilde{\boldsymbol{X}^{*}} \equiv \boldsymbol{W} \boldsymbol{X}^{*} \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W} \boldsymbol{y}$${{</math>}}

c') _Within_ estimates via OLS

{{<math>}}$$ \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} = (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transforming the variables
Xt_til = W %*% Xt
y_til = W %*% y

# Estimating
dhat_OLS = solve( t(Xt_til) %*% Xt_til ) %*% t(Xt_til) %*% y_til
dhat_OLS
```

```
##             [,1]
## [1,] 0.003791948
```

d') Fitted values _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} = \tilde{\boldsymbol{X}^{*}} \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
yhat_OLS = Xt_til %*% dhat_OLS
```

e') Residuals OLS

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Error-term variance

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{NT - K - N} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N*T - K - N) )
```
**IMPORTANT**: Adjust the degrees of freedom of the _within_ estimator to {{<math>}}$NT - K - N${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g') Estimator Variance-Covariance Matrix OLS

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vdhat_OLS = sig2hat * solve( t(Xt_til) %*% Xt_til )
Vdhat_OLS
```

```
##             [,1]
## [1,] 2.98062e-08
```


h') Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_dhat_OLS = sqrt( diag(Vdhat_OLS) )
se_dhat_OLS
```

```
## [1] 0.0001726447
```

i') _t_ statistic

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_dhat_OLS = dhat_OLS / se_dhat_OLS
t_dhat_OLS
```

```
##          [,1]
## [1,] 21.96388
```

j') p-value

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_dhat_OLS = 2 * pt(-abs(t_dhat_OLS), N*T-K-N)
p_dhat_OLS
```

```
##               [,1]
## [1,] 3.854128e-103
```

k') Summary table

```r
cbind(dhat_OLS, se_dhat_OLS, t_dhat_OLS, p_dhat_OLS) # _Within_ result via OLS
```

```
##                   se_dhat_OLS                       
## [1,] 0.003791948 0.0001726447 21.96388 3.854128e-103
```

```r
summary(Q.within)$coef # _Within_ result via plm()
```

```
##       Estimate   Std. Error  t-value      Pr(>|t|)
## qn 0.003791948 0.0001726447 21.96388 3.854128e-103
```



### Fixed Effects from the _Within_ Estimator
- For the _within_ estimator, we can use `fixef()` to compute individual effects. The `type` argument lets us report these fixed effects in three ways:
    - `level`: the default option, which returns the individual intercepts
    - `dfirst`: em desvios do 1º individual
    - `dmean`: deviations from the mean individual effect


```r
# first 6 individual effects of each type
head( fixef(Q.within, type="level") ) # first 6 level values
```

```
##      2824      6284      9158     13716     17372     19411 
## 0.1452896 0.1280547 0.2580836 0.1100110 0.1267251 0.1694891
```

```r
head( fixef(Q.within, type="dfirst") ) # first 6 values relative to the first individual
```

```
##        6284        9158       13716       17372       19411       19519 
## -0.01723488  0.11279400 -0.03527859 -0.01856442  0.02419952 -0.01038237
```

```r
head( fixef(Q.within, type="dmean") ) # first 6 values as deviations from the mean
```

```
##         2824         6284         9158        13716        17372        19411 
## -0.014213401 -0.031448285  0.098580596 -0.049491991 -0.032777823  0.009986116
```
- Because `dfirst` reports effects relative to the first individual, that individual does not appear in the `fixef()` output.
- In the linear case, the _within_ estimator is equivalent to OLS with a dummy for each individual (individual fixed effects):

```r
# Estimating OLS with individual dummies - `factor()` turns `cusip` into a categorical variable
Q.dummies1 = lm(ikn ~ 0 + qn + factor(cusip), TobinQ)

# Comparing the `qn` coefficient and individual effects
cbind(
  Q.dummies1$coef[1:7], # coef OLS incluindo dummies
  c(Q.within$coef, fixef(Q.within, type="level")[1:6]) # within coefficient + 6 fixed effects
)
```

```
##                           [,1]        [,2]
## qn                 0.003791948 0.003791948
## factor(cusip)2824  0.145289553 0.145289553
## factor(cusip)6284  0.128054670 0.128054670
## factor(cusip)9158  0.258083550 0.258083550
## factor(cusip)13716 0.110010964 0.110010964
## factor(cusip)17372 0.126725132 0.126725132
## factor(cusip)19411 0.169489071 0.169489071
```

- If we estimated OLS with fixed effects and an intercept, the intercept would correspond to the fixed effect of the first individual, and all other fixed effects would be measured relative to it.
  - The dummy for the first individual would be omitted to avoid perfect multicollinearity.


```r
# Estimating OLS with individual dummies - `factor()` turns `cusip` into a categorical variable
Q.dummies2 = lm(ikn ~ qn + factor(cusip), TobinQ)

# Comparing the `qn` coefficient and individual effects
cbind(
  Q.dummies2$coef[1:7], # coef OLS incluindo dummies
  c(NA, Q.within$coef, fixef(Q.within, type="dfirst")[1:5]) # within coefficient + 6 fixed effects
)
```

```
##                            [,1]         [,2]
## (Intercept)         0.145289553           NA
## qn                  0.003791948  0.003791948
## factor(cusip)6284  -0.017234884 -0.017234884
## factor(cusip)9158   0.112793997  0.112793997
## factor(cusip)13716 -0.035278589 -0.035278589
## factor(cusip)17372 -0.018564422 -0.018564422
## factor(cusip)19411  0.024199517  0.024199517
```


</br>

## First-Difference Estimator

- **It does not assume that {{<math>}}$E(u \mid X) = 0${{</math>}}**
- In other words, it allows the individual effect to be correlated with the regressors.
- It uses changes in an observation relative to the immediately preceding period.

The model to be estimated is OLS premultiplied by {{<math>}}$\boldsymbol{D}${{</math>}}:
{{<math>}}$$ \boldsymbol{Dy}\ =\ \boldsymbol{DX\beta} + \boldsymbol{D\varepsilon}\ =\ \boldsymbol{DX}^* \boldsymbol{\delta} + \boldsymbol{Dv}. $${{</math>}}
Note that first differencing removes time-invariant variables, the intercept, and the individual effect {{<math>}}$\boldsymbol{u}${{</math>}}, leaving only {{<math>}}$\boldsymbol{\varepsilon} = \boldsymbol{v}${{</math>}}.

- The first-difference estimator is given by
{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}\ =\ (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} $${{</math>}}

- The unbiased estimator of {{<math>}}$\sigma^2_v${{</math>}} is
{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{D}' \boldsymbol{D} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}


- The covariance matrix of the estimator can be written as
{{<math>}}$$
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}) = \sigma^2_v \Big[  (\boldsymbol{X}^{*\prime}  \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \boldsymbol{X}' \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X} (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \Big]
$${{</math>}}

- The first-difference estimator can also be obtained by OLS after premultiplying the variables by the first-difference matrix {{<math>}}$(\boldsymbol{D})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}}^* \equiv \boldsymbol{DX}^* \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{Dy} $${{</math>}}

Then

{{<math>}}\begin{align} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} &= (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} \\
&= ([\boldsymbol{D} \boldsymbol{X}^{*}]' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} [\boldsymbol{D} \boldsymbol{X}^{*}]' \boldsymbol{D} \boldsymbol{y} \\
&\equiv ( \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}} )^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} \end{align}{{</math>}}

Note that {{<math>}}$\boldsymbol{D}${{</math>}} is not square, unlike the other transformation matrices, and therefore:
{{<math>}}$$ \boldsymbol{D} \neq \boldsymbol{D}\boldsymbol{D} \qquad \text{and} \qquad \boldsymbol{D} \neq \boldsymbol{D}' $${{</math>}}


### Estimation via `plm()`
Again, we use the `TobinQ` dataset from the `pder` package and estimate the following model:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta + \varepsilon $${{</math>}}


```r
# Loading the required package and dataset
library(plm)
data(TobinQ, package="pder")

# Converting to `pdata.frame` format with individual and time identifiers
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimations
Q.fd = plm(ikn ~ 0 + qn, pTobinQ, model = "fd") # first-difference estimation
Q.within = plm(ikn ~ qn, pTobinQ, model = "within") # within estimation

# Comparing the estimates
stargazer::stargazer(Q.fd, Q.within, type="text")
```

```
## 
## =======================================================
##                                Dependent variable:     
##                            ----------------------------
##                                        ikn             
##                                 (1)            (2)     
## -------------------------------------------------------
## qn                            0.004***      0.004***   
##                               (0.0003)      (0.0002)   
##                                                        
## -------------------------------------------------------
## Observations                   6,392          6,580    
## R2                             0.026          0.070    
## Adjusted R2                    0.026          0.043    
## F Statistic (df = 1; 6391)   171.014***    482.412***  
## =======================================================
## Note:                       *p<0.1; **p<0.05; ***p<0.01
```
- Note that:
    - the variables enter the estimation without any manual transformation; and
    - both methods have the same degrees of freedom.


<!-- ### Estimação via lm() -->

<!-- Nós podemos construir as variáveis de média e de desvios de média diretamente no data frame e fazer a estimação _within_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "by hand" as variáveis de desvios da média para cada individual -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (individual) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transformação" between de ikn -->
<!--         qn_bar = mean(qn), # "transformação" between de qn -->
<!--         ikn_desv = ikn - ikn_bar, # "transformação" within de ikn -->
<!--         qn_desv = qn - qn_bar # "transformação" within de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estimação within via lm() -->
<!-- Q.within.ols = lm(ikn_desv ~ 0 + qn_desv, TobinQ) # retira intercepto com 0 -->

<!-- # Comparing the estimates -->
<!-- summary(Q.within.ols)$coef # within via OLS -->
<!-- summary(Q.within)$coef # within ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note quand the error padrão está subestimado no output gerado por `lm()`. -->
<!-- - A rotina padrão de OLS retorna {{<math>}}$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a Error Variance-Covariance Matrix por {{<math>}}$(NT-K-1) / (NT-K-N)${{</math>}}. -->
<!--   - _Within_ estima mais {{<math>}}$N${{</math>}} parâmetros (efeitos fixos dos individuals) e deixa de estimar o intercepto.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de variância covariância do estimador -->
<!-- vcov.ols = vcov(Q.within.ols) -->
<!-- vcov.within = vcov.ols * (N*T - K - 1) / (N*(T-1) - K) -->
<!-- se.within = sqrt( diag(vcov.within) ) -->
<!-- se.within -->
<!-- ``` -->


### Analytical Estimation

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix

# Creating the matrix/vector Xt of time-varying covariates
Xt = as.matrix( TobinQ[, "qn"] ) # no intercept column is added

# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(Xt) # no intercept is subtracted
```


b) Computing the first-difference matrices

{{<math>}}$$\boldsymbol{D} = \boldsymbol{I}_N \otimes \boldsymbol{D}_i $${{</math>}}
em que
{{<math>}}$$\boldsymbol{D}_i = \begin{bmatrix}
-1 & 1 & 0 & \cdots & 0 & 0 \\
0 & -1 & 1 & \cdots & 0 & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & 0 & \cdots & -1 & 1
\end{bmatrix}_{(T-1)\times T}$${{</math>}}


```r
Di = -diag(T) # main diagonal set to -1
diag(Di[-nrow(Di),-1]) = 1 # superdiagonal
Di = Di[-nrow(Di),] # dropping the last row

I_N = diag(N) # identity matrix of size N
D = I_N %x% Di
```


c) First-difference estimates {{<math>}}$\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} = (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*})^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} $${{</math>}}

```r
dhat_FD = solve( t(Xt) %*% t(D) %*% D %*% Xt ) %*% t(Xt) %*% t(D) %*% D %*% y
dhat_FD
```

```
##             [,1]
## [1,] 0.004012382
```

d) First-difference fitted values {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}} = \boldsymbol{X}^{*} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} $${{</math>}}


```r
yhat_FD = Xt %*% dhat_FD
```


e) First-difference residuals {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{FD}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}} $${{</math>}}


```r
ehat_FD = y - yhat_FD
```


f) Error-term variance

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{D}' \boldsymbol{D} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2_v${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2v = as.numeric( (t(ehat_FD) %*% t(D) %*% D %*% ehat_FD) / (N*T - K - N) )
sig2v
```

```
## [1] 0.006167647
```
**IMPORTANT**: Adjust the degrees of freedom of the _within_ estimator to {{<math>}}$NT - K - N${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g) Estimator Variance-Covariance Matrix _Within_

{{<math>}}$$
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}) = \sigma^2_v \Big[  (\boldsymbol{X}^{*\prime}  \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \boldsymbol{X}' \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X} (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \Big]
$${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
bread = solve( t(Xt) %*% t(D) %*% D %*% Xt )
meat = t(Xt) %*% t(D) %*% D %*% Xt
Vdhat_FD = sig2v * (bread %*% meat %*% bread) # sandwich
Vdhat_FD
```

```
##              [,1]
## [1,] 9.413949e-08
```


i) Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_dhat_FD = sqrt( diag(Vdhat_FD) )
se_dhat_FD
```

```
## [1] 0.0003068216
```

j) _t_ statistic

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_dhat_FD = dhat_FD / se_dhat_FD
t_dhat_FD
```

```
##          [,1]
## [1,] 13.07725
```

k) p-value

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_dhat_FD = 2 * pt(-abs(t_dhat_FD), N*T-K-N)
p_dhat_FD
```

```
##              [,1]
## [1,] 1.385139e-38
```

l) Summary table

```r
cbind(dhat_FD, se_dhat_FD, t_dhat_FD, p_dhat_FD) # _Within_ result
```

```
##                    se_dhat_FD                      
## [1,] 0.004012382 0.0003068216 13.07725 1.385139e-38
```

```r
summary(Q.fd)$coef # _Within_ result via plm()
```

```
##       Estimate   Std. Error  t-value     Pr(>|t|)
## qn 0.004012382 0.0003068216 13.07725 1.385139e-38
```



#### Transforming and Estimating by OLS
In addition to the form shown above, we can transform the variables and solve by OLS after premultiplying {{<math>}}$\boldsymbol{X}^{*}${{</math>}} and {{<math>}}$\boldsymbol{y}${{</math>}} by {{<math>}}$\boldsymbol{D}${{</math>}}, defining:

{{<math>}}$$\tilde{\boldsymbol{X}^{*}} \equiv \boldsymbol{D} \boldsymbol{X}^{*} \qquad \text{and} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{D} \boldsymbol{y}$${{</math>}}

c') First-difference estimates via OLS

{{<math>}}$$ \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} = (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transforming the variables
Xt_til = D %*% Xt
y_til = D %*% y

# Estimating
dhat_OLS = solve( t(Xt_til) %*% Xt_til ) %*% t(Xt_til) %*% y_til
dhat_OLS
```

```
##             [,1]
## [1,] 0.004012382
```

d') Fitted values _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} = \tilde{\boldsymbol{X}^{*}} \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
yhat_OLS = Xt_til %*% dhat_OLS
```

e') Residuals OLS

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{OLS}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Error-term variance

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}}{NT - K - N} $${{</math>}}

Because {{<math>}}$\hat{\sigma}^2${{</math>}} is a scalar, it is convenient to convert the "1x1 matrix" into a number using `as.numeric()`: 

```r
# Computing the error-term variances
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N*T - K - N) )
```
**IMPORTANT**: adjust the degrees of freedom of the first-difference estimator to {{<math>}}$NT - K - N${{</math>}} (instead of {{<math>}}$NT - K - 1${{</math>}}).


g') Estimator Variance-Covariance Matrix OLS

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} $${{</math>}}


```r
# Computing the variance-covariance matrix of the estimators
Vdhat_OLS = sig2hat * solve( t(Xt_til) %*% Xt_til )
Vdhat_OLS
```

```
##              [,1]
## [1,] 9.413949e-08
```


h') Standard errors {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}})${{</math>}}

It is the square root of the main diagonal of the estimator variance-covariance matrix.

```r
se_dhat_OLS = sqrt( diag(Vdhat_OLS) )
se_dhat_OLS
```

```
## [1] 0.0003068216
```

i') _t_ statistic

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Computing the t statistic
t_dhat_OLS = dhat_OLS / se_dhat_OLS
t_dhat_OLS
```

```
##          [,1]
## [1,] 13.07725
```

j') p-value

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-value
p_dhat_OLS = 2 * pt(-abs(t_dhat_OLS), N*T-K-N)
p_dhat_OLS
```

```
##              [,1]
## [1,] 1.385139e-38
```

k') Summary table

```r
cbind(dhat_OLS, se_dhat_OLS, t_dhat_OLS, p_dhat_OLS) # first-difference result via OLS
```

```
##                   se_dhat_OLS                      
## [1,] 0.004012382 0.0003068216 13.07725 1.385139e-38
```

```r
summary(Q.fd)$coef # first-difference result via `plm()`
```

```
##       Estimate   Std. Error  t-value     Pr(>|t|)
## qn 0.004012382 0.0003068216 13.07725 1.385139e-38
```



</br>

## Comparing the Estimators

### FGLS: Combining GLS and _Within_
- A blend of GLS (random effects) and _within_ (fixed effects).
- Recall that the error variance-covariance matrix is given by
{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B}, \tag{2.29} $${{</math>}}
where {{<math>}}$p${{</math>}} is a scalar.

- Setting {{<math>}}$p=-0.5${{</math>}} in (2.29), we obtain
{{<math>}}$$ \boldsymbol{\Sigma}^{-0.5} = \frac{1}{\sigma_v + T \sigma_u} \boldsymbol{B} + \frac{1}{\sigma_v} \boldsymbol{W} $${{</math>}}

- Earlier, we wrote FGLS using the transformed variables {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5}y${{</math>}} and {{<math>}}$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5}X${{</math>}}:

{{<math>}}\begin{align}
    \hat{\boldsymbol{\beta}} &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y}) \tag{2.27} \\
    &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5\prime} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5}\boldsymbol{\Sigma}^{-0.5\prime} \boldsymbol{y}) \\
    &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}} \tilde{\boldsymbol{y}}
\end{align}{{</math>}}

Without loss of generality, we can premultiply the model by {{<math>}}$\sigma_v \boldsymbol{\Sigma}^{-0.5}${{</math>}} instead of {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}}, so:

{{<math>}}\begin{align} \boldsymbol{\Sigma}^{-0.5} &= \sqrt{\frac{1}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \frac{1}{\sigma_v} \boldsymbol{W} \\
&= \frac{1}{\sigma_v} \left[ \sigma_v \sqrt{\frac{1}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \boldsymbol{W} \right] \\
&= \frac{1}{\sigma_v} \left[ \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \boldsymbol{W} \right] \\
&= \frac{1}{\sigma_v} \left[ \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + (\boldsymbol{I} - \boldsymbol{B}) \right] \\
&= \frac{1}{\sigma_v} \left[ \boldsymbol{I} + \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} - \boldsymbol{B} \right] \\
&=\frac{1}{\sigma_v} \left[ \boldsymbol{I} - \left( 1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right) \boldsymbol{B} \right] \\
\end{align}{{</math>}}




Thus, when we premultiply variables by {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}}, an explanatory variable {{<math>}}$x^k_{it}${{</math>}} becomes:
{{<math>}}$$ \tilde{x}^k_{it}\ =\ \frac{1}{\sigma_v} \left[ x^k_{it} + \left(1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right) \bar{x}^k_{i}\right]\ \equiv\ \frac{1}{\sigma_v} \left[ x_{it} - \theta \bar{x}^k_{i}\right], $${{</math>}}
where {{<math>}}$$\theta \equiv \left( 1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right)$${{</math>}}

    
Note that, when:

- {{<math>}}$\theta \rightarrow 1${{</math>}}
  - individual effects dominate, {{<math>}}$\sigma_u \rightarrow \infty${{</math>}};
  - the transformed variable approaches the demeaned form {{<math>}}$x^k_{it} - \bar{x}^k_{i}${{</math>}};
  - FGLS approaches the _within_ estimator.
- {{<math>}}$\theta \rightarrow 0${{</math>}}
  - individual effects vanish, {{<math>}}$\sigma_u \rightarrow 0${{</math>}};
  - the transformed variable approaches the untransformed regressor {{<math>}}$x^k_{it}${{</math>}};
  - FGLS approaches GLS. 



### Example 1


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# FGLS estimations
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
summary(Q.walhus) # FGLS output using Wallace and Hussain (1969)
```

```
## Oneway (individual) effect Random Effect Model 
##    (Wallace-Hussain's transformation)
## 
## Call:
## plm(formula = ikn ~ qn, data = pTobinQ, model = "random", random.method = "walhus")
## 
## Balanced Panel: n = 188, T = 35, N = 6580
## 
## Effects:
##                    var  std.dev share
## idiosyncratic 0.005342 0.073091 0.727
## individual    0.002008 0.044814 0.273
## theta: 0.7342
## 
## Residuals:
##      Min.   1st Qu.    Median   3rd Qu.      Max. 
## -0.233092 -0.047491 -0.010282  0.033577  0.621136 
## 
## Coefficients:
##               Estimate Std. Error z-value  Pr(>|z|)    
## (Intercept) 0.15932587 0.00341439  46.663 < 2.2e-16 ***
## qn          0.00386263 0.00016825  22.957 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    37.912
## Residual Sum of Squares: 35.1
## R-Squared:      0.074179
## Adj. R-Squared: 0.074038
## Chisq: 527.045 on 1 DF, p-value: < 2.22e-16
```
Note that {{<math>}}$\theta = 73\%${{</math>}}, which indicates that in this case the FGLS estimate is closer to _within_ ({{<math>}}$\theta=1${{</math>}}) than to _between_ ({{<math>}}$\theta=0${{</math>}}). The large number of periods ({{<math>}}$T = 35${{</math>}}) likely contributes to this high value.



### Example 2
- Section 2.4.4 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Used by Kinal and Lahiri (1993) 
- We want to study the relationship between imports (`imports`) and gross national product (`gnp`).

```r
data("ForeignTrade", package = "pder")
FT = pdata.frame(ForeignTrade, index=c("country", "year"))

# FGLS estimations
FT.between = plm(imports ~ gnp, FT, model = "between")
FT.pooled = plm(imports ~ gnp, FT, model = "pooling")
FT.fgls = plm(imports ~ gnp, FT, model = "random", random.method = "walhus")
FT.within = plm(imports ~ gnp, FT, model = "within")

# Summarizing the four estimations in a single table
stargazer::stargazer(FT.between, FT.pooled, FT.fgls, FT.within,
                     digits=3, type="text", omit.stat="f")
```

```
## 
## ===================================================
##                       Dependent variable:          
##              --------------------------------------
##                             imports                
##                 (1)       (2)       (3)      (4)   
## ---------------------------------------------------
## gnp            0.049   0.064***  0.675***  0.902***
##               (0.080)   (0.017)   (0.033)  (0.035) 
##                                                    
## Constant     -6.368*** -6.321*** -4.403***         
##               (0.313)   (0.066)   (0.183)          
##                                                    
## ---------------------------------------------------
## Observations    31        744       744      744   
## R2             0.013     0.019     0.358    0.488  
## Adjusted R2   -0.021     0.018     0.357    0.466  
## ===================================================
## Note:                   *p<0.1; **p<0.05; ***p<0.01
```

```r
# Resumo do FGLS
summary(FT.fgls)
```

```
## Oneway (individual) effect Random Effect Model 
##    (Wallace-Hussain's transformation)
## 
## Call:
## plm(formula = imports ~ gnp, data = FT, model = "random", random.method = "walhus")
## 
## Balanced Panel: n = 31, T = 24, N = 744
## 
## Effects:
##                  var std.dev share
## idiosyncratic 0.1573  0.3966 0.135
## individual    1.0063  1.0032 0.865
## theta: 0.9196
## 
## Residuals:
##       Min.    1st Qu.     Median    3rd Qu.       Max. 
## -1.4043348 -0.1920097 -0.0017737  0.2230540  0.9444870 
## 
## Coefficients:
##              Estimate Std. Error z-value  Pr(>|z|)    
## (Intercept) -4.403331   0.182589 -24.116 < 2.2e-16 ***
## gnp          0.675111   0.033209  20.329 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Total Sum of Squares:    125.04
## Residual Sum of Squares: 80.312
## R-Squared:      0.35773
## Adj. R-Squared: 0.35686
## Chisq: 413.271 on 1 DF, p-value: < 2.22e-16
```
- The FGLS transformation removes a large share of between-individual variation, subtracting 94\% of the individual mean from the covariate:
{{<math>}}$$ \tilde{x}_{it}\ =\ x_{it} - \theta \bar{x}_{i}\ =\ x_{it} - 0,94 \bar{x}_{i} $${{</math>}}


<center><img src="../example_panel-1.png"></center>

- FGLS and _within_ are quite similar.
- GLS is closer to _between_, because it places more weight on between-individual variation.


</br>

## Maximum Likelihood Estimator
- Section 3.3 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- An alternative to FGLS is maximum likelihood (ML) estimation.
- The two error components are assumed to be normally distributed:
{{<math>}}$$ u | X \sim N(0, \sigma^2_u) \quad \text{and} \quad v | u, X \sim N(0, \sigma^2_v) $${{</math>}}

- Instead of estimating {{<math>}}$\sigma^2_u${{</math>}} and {{<math>}}$\sigma^2_v${{</math>}} first and then computing {{<math>}}$\boldsymbol{\beta}${{</math>}}, ML estimates them jointly.

- Denote 
{{<math>}}$\phi \equiv \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T\sigma^2_u}},${{</math>}}
the log-likelihood function for a balanced panel is:


<!-- {{<math>}}$$ \ln{L} = -\frac{NT}{2} \ln{2\pi} - \frac{NT}{2}\ln{\sigma^2_v} + \frac{N}{2} \ln{\phi^2} - \frac{1}{2\sigma^2_v} \left( \varepsilon' \boldsymbol{W} \varepsilon + \phi^2 \varepsilon' \boldsymbol{B} \varepsilon \right) $${{</math>}} -->


and consider the variable transformation obtained by premultiplying by {{<math>}}$(\boldsymbol{I} - \phi \boldsymbol{B})${{</math>}}:

{{<math>}}$$\tilde{\boldsymbol{X}}\ \equiv\ (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{X}\ =\ \boldsymbol{X} - \phi \boldsymbol{B} \boldsymbol{X}$${{</math>}}

Thus,

{{<math>}}\begin{align}
    \hat{\boldsymbol{\beta}} &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}'\tilde{\boldsymbol{y}} \tag{3.12} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}} + \hat{\phi}^2 \hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT} \tag{3.13} \\
    \hat{\phi}^2 &=\frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{(T-1) \hat{\boldsymbol{\varepsilon}}'\boldsymbol{B}\hat{\boldsymbol{\varepsilon}}} \tag{3.14}
\end{align}{{</math>}}

Estimation can be implemented iteratively by FIML (Full Information Maximum Likelihood):


1. Start with an initial guess for {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}}.
2. Compute {{<math>}}$\hat{\phi}^2${{</math>}} using (3.14).
3. Update {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} using (3.12).
4. Check convergence. If the procedure has not converged, return to step 2 using the updated {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} from step 3.
5. Compute {{<math>}}$\sigma^2_v${{</math>}} using (3.13).


### Estimation via `pglm()`


```r
library(pglm)
library(dplyr)
data("TobinQ", package = "pder")

# Converting to `pdata.frame` format with individual and time identifiers
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# ML estimation
Q.ml = pglm(ikn ~ qn, pTobinQ, family = "gaussian") # ML estimation
Q.fgls = plm(ikn ~ qn, pTobinQ, model="random",
             random.method="walhus") # FGLS estimation

summary(Q.ml)$estimate # ML coefficients
```

```
##                Estimate   Std. error   t value       Pr(> t)
## (Intercept) 0.159327956 0.0034343786  46.39208  0.000000e+00
## qn          0.003861798 0.0001683923  22.93334 2.160874e-116
## sd.id       0.045073677 0.0025010701  18.02176  1.315002e-72
## sd.idios    0.073023338 0.0006452452 113.17145  0.000000e+00
```

```r
summary(Q.fgls)$coef # FGLS coefficients
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```
- Note that the ML result is very close to the FGLS estimate.



### Analytical Estimation

a) Choose initial values for {{<math>}}$\hat{\beta}_{\scriptscriptstyle{ini}}${{</math>}} (you can start from zeros)


```r
data("TobinQ", package="pder")

# Creating the y vector
y = as.matrix(TobinQ[,"ikn"]) # converting the data frame column into a matrix

# Creating the covariate matrix X with a first column of ones
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # adding a column of ones to the covariates

# Retrieving N, T, and K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1

# Between and within matrices
iota_T = matrix(1, nrow=T, ncol=1)
I_N = diag(N)
I_NT = diag(N*T)
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Iterating until the estimates converge
tol = 1e-10 # convergence tolerance
dist = 1 # initial distance, used only to enter the while loop
it = 0 # number of iterations

# (a) Initial guesses for the parameter estimates
bhat_ini = matrix(0, nrow=2, ncol=1) # initial zero vector
bhat_ini
```

```
##      [,1]
## [1,]    0
## [2,]    0
```

b) Obtain {{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}}${{</math>}} and compute
		{{<math>}}$$ \hat{\phi}^2 = \frac{\hat{\varepsilon}' \boldsymbol{W} \hat{\varepsilon}}{(T-1)\hat{\varepsilon}' \boldsymbol{B} \hat{\varepsilon}} \tag{3.14} $${{</math>}}
		
		
c) Compute the updated estimates {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}}${{</math>}} using
		{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}} = (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{X}'\tilde{y}, \tag{3.12} $${{</math>}}
where {{<math>}}$\tilde{\boldsymbol{X}} = (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{X}${{</math>}}, and {{<math>}}$\tilde{\boldsymbol{y}} = (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{y}${{</math>}}


d) Check convergence according to:
		{{<math>}}$$ \text{distance} = \max\{\text{abs}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{ini}})\} < 1 \times 10^{-10} = \text{tolerance}$${{</math>}}
		If convergence has not been reached, return to step (b), redefine {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{ini}} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}}${{</math>}}, and start a new iteration.



```r
while (dist > tol) {
	# Display the current iteration and current beta estimates
	print(paste0("iteration ", it,
	      ": b0 = ", round(bhat_ini[1], 6),
        " | b1 = ", round(bhat_ini[2], 6)
	))
	
	# (b) Obtain fitted values, residuals, and estimate phi
	y_hat = X %*% bhat_ini
	e = y - y_hat
	phi2_hat = as.numeric((t(e) %*% W %*% e) / ((T-1) * (t(e) %*% B %*% e)))
	phi_hat = sqrt(phi2_hat)

	# (c) Compute the updated estimates
	X_til = (I_NT - phi_hat * B) %*% X
	y_til = (I_NT - phi_hat * B) %*% y
	bhat_fim = solve(t(X_til) %*% X_til) %*% t(X_til) %*% y_til
	
	# (d) Check convergence of the estimates
	dist = max(abs(bhat_fim - bhat_ini)) # computing the distance
	bhat_ini = bhat_fim
	it = it + 1
}
```

```
## [1] "iteration 0: b0 = 0 | b1 = 0"
## [1] "iteration 1: b0 = 0.158127 | b1 = 0.004341"
## [1] "iteration 2: b0 = 0.158491 | b1 = 0.004196"
## [1] "iteration 3: b0 = 0.158491 | b1 = 0.004196"
## [1] "iteration 4: b0 = 0.158491 | b1 = 0.004196"
```


e) Obtain {{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}}${{</math>}} and {{<math>}}$\hat{\phi}^2${{</math>}} in order to compute
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\varepsilon}' \boldsymbol{W} \hat{\varepsilon} + \hat{\phi}^2 \hat{\varepsilon}' \boldsymbol{B} \hat{\varepsilon}}{NT} \tag{3.13} \qquad \text{and} \qquad \sigma^2_l = \frac{\sigma^2_v}{\hat{\phi}^2}  $${{</math>}}


```r
# (e) Compute phi, sigma^2_v, and sigma^2_l
y_hat = X %*% bhat_fim
e = y - y_hat
phi2_hat = as.numeric((t(e) %*% W %*% e) / ((T-1)*(t(e) %*% B %*% e)))
phi_hat = sqrt(phi2_hat)

sig2v = as.numeric((t(e) %*% W %*% e + phi2_hat * t(e) %*% B %*% e) / (N*T))
sig2l = sig2v / phi2_hat
```

g) Calcular {{<math>}}$V(\hat{\beta})${{</math>}} usando:
		{{<math>}}$$ V(\hat{\beta}) = \left( \frac{1}{\hat{\sigma}^2_v} \boldsymbol{X}' \boldsymbol{W X} + \frac{1}{\hat{\sigma}^2_l} \boldsymbol{X}' \boldsymbol{B X}\right)^{-1} $${{</math>}}

```r
# (g) Compute V(bhat)
Vbhat = solve(c(1/sig2v) * t(X) %*% W %*% X + c(1/sig2l) * t(X) %*% B %*% X)
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.171015e-05 -7.095051e-08
## [2,] -7.095051e-08  2.831961e-08
```

h) Obtain the standard errors, t statistics, and p-values

```r
# (h) Standard errors, t statistics, and p-values
se_bhat = sqrt(diag(Vbhat))
t_bhat = bhat_fim / se_bhat
p_bhat = pt(-abs(t_bhat), df = N*T-K-1) # NT - K - 1

data.frame(bhat_fim, se_bhat, t_bhat, p_bhat) # Results
```

```
##      bhat_fim      se_bhat   t_bhat       p_bhat
## 1 0.158490653 0.0034220099 46.31508  0.00000e+00
## 2 0.004196004 0.0001682843 24.93402 1.68128e-131
```

```r
summary(Q.ml)$estimate # ML estimation via pglm()
```

```
##                Estimate   Std. error   t value       Pr(> t)
## (Intercept) 0.159327956 0.0034343786  46.39208  0.000000e+00
## qn          0.003861798 0.0001683923  22.93334 2.160874e-116
## sd.id       0.045073677 0.0025010701  18.02176  1.315002e-72
## sd.idios    0.073023338 0.0006452452 113.17145  0.000000e+00
```


</br>

## Tests for the Presence of Individual Effects

### Breusch-Pagan

- Section 4.1 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- This is a Lagrange multiplier (LM) test based on OLS residuals, with {{<math>}}$H_0: \sigma^2_u = 0${{</math>}} (no individual effects).
- The test statistic is given by
{{<math>}}$$ LM_u = \frac{NT}{2(T-1)} \left( T \frac{\hat{\boldsymbol{\varepsilon}}' B_u \hat{\boldsymbol{\varepsilon}}}{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}} - 1 \right)^2  $${{</math>}}
which is asymptotically distributed as a `\(\chi^2\)` with 1 degree of freedom.
- There are several variants of this test:
    - Breusch and Pagan (1980),
    - Gourieroux et al. (1982),
    - Honda (1985), and
    - King and Wu (1997).


### F Tests
- Section 4.1 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Let the residual sum of squares and degrees of freedom for the _within_ model be {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W${{</math>}} and {{<math>}}$N(T-1) - K${{</math>}}, respectively.
- Let the residual sum of squares and degrees of freedom for pooled OLS be {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}}\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}}${{</math>}} and {{<math>}}$NT - K - 1${{</math>}}, respectively.
- Under the null of no individual effects, the test statistic is
{{<math>}}$$ \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{OLS}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{OLS}} - \hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W}{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_W} \frac{NT - K - N + 1}{N-1} $${{</math>}}
which follows an F distribution with {{<math>}}$N-1${{</math>}} and {{<math>}}$NT - K - N + 1${{</math>}} degrees of freedom.


### Implementing in R

```r
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

Q.within = plm(ikn ~ qn, pTobinQ, model = "within")
Q.gls = plm(ikn ~ qn, pTobinQ, model = "random")
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")

# Breusch-Pagan / LM test
plmtest(Q.pooling, effect="individual") # Honda (1985)
```

```
## 
## 	Lagrange Multiplier Test - (Honda)
## 
## data:  ikn ~ qn
## normal = 91.377, p-value < 2.2e-16
## alternative hypothesis: significant effects
```
The LM (Breusch-Pagan) test indicates significant individual effects.


```r
# F test
pFtest(Q.within, Q.pooling)
```

```
## 
## 	F test for individual effects
## 
## data:  ikn ~ qn
## F = 14.322, df1 = 187, df2 = 6391, p-value < 2.2e-16
## alternative hypothesis: significant effects
```
As with the LM test, the F test also indicates significant individual effects.


</br>

## Tests for Correlated Effects
- Section 4.2 of "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- We continue to assume {{<math>}}$E(v \mid X) = 0${{</math>}}, where {{<math>}}$v${{</math>}} is the idiosyncratic error term.
- These tests examine whether {{<math>}}$E(u \mid X) = 0${{</math>}}, that is, whether individual effects are correlated with the covariates.

### Hausman Test
- The general idea of the Hausman test is to compare two models, {{<math>}}$A${{</math>}} and {{<math>}}$B${{</math>}}, such that
    - under {{<math>}}$H_0${{</math>}}: both {{<math>}}$A${{</math>}} and {{<math>}}$B${{</math>}} are consistent, but {{<math>}}$B${{</math>}} is more efficient than {{<math>}}$A${{</math>}};
    - under {{<math>}}$H_1${{</math>}}: only {{<math>}}$A${{</math>}} is consistent.
- If {{<math>}}$H_0${{</math>}} is true, the coefficients from the two models should not differ systematically.
- The test is based on {{<math>}}$\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B${{</math>}}. Hausman showed that under {{<math>}}$H_0${{</math>}}, {{<math>}}$cov(\hat{\boldsymbol{\beta}}_A, \hat{\boldsymbol{\beta}}_B) = 0${{</math>}}, so the variance of the difference is simply {{<math>}}$V(\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B) = V(\hat{\boldsymbol{\beta}}_A) - V(\hat{\boldsymbol{\beta}}_B)${{</math>}}.

- In panel-data applications, the comparison is typically between the _within_ estimator (fixed effects) and FGLS (random effects).
- When {{<math>}}$E(u \mid X) = 0${{</math>}}, both estimators are consistent, that is,
{{<math>}}$$ \hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} - \hat{\boldsymbol{\beta}}_W\ \overset{p}{\rightarrow}\ 0 $${{</math>}}
so we prefer the more efficient estimator, namely FGLS, because it uses both between- and within-individual variation.

- If {{<math>}}$E(u \mid X) \neq 0${{</math>}}, then {{<math>}}$\hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}} \neq 0${{</math>}}, and only the estimator robust to this correlation, the _within_ estimator, remains consistent.
- Its variance is given by
{{<math>}}\begin{align}
    V(\hat{q}) &= V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}} - \hat{\boldsymbol{\beta}}_W) = V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) + V(\hat{\boldsymbol{\beta}}_W) - 2 cov(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}, \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{FGLS}}) \\
    &= \sigma^2_v (\boldsymbol{X}' \boldsymbol{W X})^{-1} - (\boldsymbol{X}'\boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1}
\end{align}{{</math>}}
- Therefore, the test statistic becomes
{{<math>}}$$ \hat{q}'\ V(\hat{q})^{-1}\ \hat{q} $${{</math>}}
which, under {{<math>}}$H_0${{</math>}}, is distributed as {{<math>}}$\chi^2${{</math>}} with {{<math>}}$K${{</math>}} degrees of freedom.


```r
# Hausman test
phtest(Q.within, Q.gls)
```

```
## 
## 	Hausman Test
## 
## data:  ikn ~ qn
## chisq = 3.3044, df = 1, p-value = 0.06909
## alternative hypothesis: one model is inconsistent
```
We do not reject the null that both models are consistent at the 5\% level.


</br>


{{< cta cta_text="👉 Proceed to Panel Data Manipulation" cta_link="../sec5" >}}








