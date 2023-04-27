---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Dados em Painel
summary: This page includes a section on panel data estimation with R and provides examples of data structures and models. The content is based on the book “Panel Data Econometrics with R” by Croissant & Millo (2018) and adapted from lecture notes on Econometrics I.
title: Estimação com Dados em Painel
weight: 4
output: md_document
type: book
---




## Estrutura dos Dados

- Seção 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- A maioria das notações foram adaptadas de acordo com as notas de aula de Econometria I.


### Corte Transversal
Até agora, utilizamos bases de dados em corte transversal (ou _cross-section_, em inglês), ou seja, em que cada linha representava um indivíduo {{<math>}}$i  = 1, ..., N${{</math>}} e observamos as realizações da variável dependente {{<math>}}$y${{</math>}} e das variáveis explicativas {{<math>}}$k = 1, 2, ..., K${{</math>}}:

<img src="../data_crosssection.png" alt="">


#### Exemplo
Considerando {{<math>}}$N = 4${{</math>}} indivíduos e {{<math>}}$K = 2${{</math>}} covariadas, segue o exemplo:

<img src="../data_crosssection_example.png" alt="">



### Painel
Também é comum utilizarmos dados em painel, isto é, uma base de dados em que observamos os indivíduos {{<math>}}$i = 1, ..., N${{</math>}} nos {{<math>}}$t = 1, ..., T${{</math>}} períodos.

Este tipo de estrutura de dado permite, além de fazer comparações inter-indivíduos (_between_), avaliar diferenças intra-indivíduos (_within_) a partir das variações ocorridas ao longo do tempo para um mesmo indivíduo.

Por simplicidade, consideramos que todos indivíduos possuem {{<math>}}$T${{</math>}} observações ao longo do tempo (**painel balanceado**). Além disso, dados em painel podem estar dispostos de duas formas: longa ou curta.


##### Painel longo (_long_, em inglês)
Aqui, cada indivíduo aparece em {{<math>}}$T${{</math>}} linhas. Cada observação é indicada pela dupla {{<math>}}$i${{</math>}} e {{<math>}}$t${{</math>}} (variáveis-chave da base de dados). Essa é a forma padrão utilizada em Econometria.

<img src="../data_panellong.png" alt="">


##### Painel curto (_wide_, em inglês)
Na forma curta, as informações das variáveis dependentes e independentes aparecem repetidamente por {{<math>}}$T${{</math>}} vezes, sendo que cada repetição corresponde a um dos {{<math>}}$T${{</math>}} períodos:

<img src="../data_panelwide.png" alt="">



#### Exemplos
Como exemplo, consideramos {{<math>}}$N = 4${{</math>}} indivíduos e {{<math>}}$K = 2${{</math>}} covariadas e {{<math>}}$T = 2${{</math>}} períodos. As bases de dados em paineis longo e curto, respectivamente, teriam as seguintes estruturas:

<img src="../data_panellong_example.png" alt="">

<img src="../data_panelwide_example.png" alt="">



## Modelo em Painel

Para a observação do indivíduo {{<math>}}$i \in \{1, ..., N\}${{</math>}} no período {{<math>}}$t \in \{1, ..., T\}${{</math>}}, podemos escrever o modelo como:

{{<math>}}$$ y_{it} = \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{1} $$ {{</math>}}
em que {{<math>}}$\boldsymbol{\beta}${{</math>}} é um vetor-coluna de {{<math>}}$K${{</math>}} parâmetros

{{<math>}}$$ \boldsymbol{\beta} = \left[ \begin{array}{c} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{array} \right], $${{</math>}}

{{<math>}}$y_{it}${{</math>}} é a variável dependente, {{<math>}}$\boldsymbol{x}'_{it}${{</math>}} é o vetor-linha de dimensão {{<math>}}$K+1${{</math>}}:

{{<math>}}$$ \boldsymbol{x}'_{it} = \left[ \begin{array}{c} 1 & x^1_{it} & x^2_{it} & \cdots & x^K_{it} \end{array} \right],  $${{</math>}}

e o erro {{<math>}}$\varepsilon_{it}${{</math>}} pode ser escrito como:

{{<math>}}$$ \varepsilon_{it} = u_i + v_{it},  $${{</math>}}
sendo {{<math>}}$u_i${{</math>}} o erro individual para o indivíduo {{<math>}}$i${{</math>}} e {{<math>}}$v_{it}${{</math>}} é o erro idiossincrático (residual).

Empilhando as equações (1) para todo indivíduo {{<math>}}$i = 1, 2, ..., N${{</math>}} e todo período {{<math>}}$t = 1, 2, ..., T ${{</math>}}, temos

{{<math>}}$$ \underbrace{\boldsymbol{y}}_{NT \times 1} = \left[ \begin{array}{c}
    y_{11} \\ y_{12} \\ \vdots \\ y_{1T} \\\hline y_{21} \\ y_{22} \\ \vdots \\ y_{2T} \\\hline \vdots \\\hline y_{N1} \\ y_{N2} \\ \vdots \\ y_{NT}
\end{array} \right] \quad \text{ e } \quad 
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
As linhas horizontais foram inseridas apenas para facilitar a visualização dos valores referentes a cada indivíduo {{<math>}}$i${{</math>}}.


</br>

## Matriz de Variâncias-Covariâncias dos Erros
- Seção 2.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

A Matriz de Variâncias-Covariâncias dos Erros relaciona um termo de erro, {{<math>}}$\varepsilon_{it}${{</math>}}, com todos os demais termos de erro {{<math>}}$\varepsilon_{js}${{</math>}}, para todo {{<math>}}$j = 1, ..., N${{</math>}} e todo {{<math>}}$a = 1, ..., T${{</math>}}.

Na matriz de covariância de erro, cada linha representa um {{<math>}}$\varepsilon_{it}${{</math>}} e cada coluna representa um {{<math>}}$\varepsilon_{jt}${{</math>}}. Seus elementos representam a covariância entre 
{{<math>}}$\varepsilon_{it}${{</math>}} e {{<math>}}$\varepsilon_{jt}${{</math>}}, sendo que pode haver {{<math>}}$\varepsilon_{it} = \varepsilon_{jt}${{</math>}} (que, neste caso, torna-se variância):

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

Note que a Matriz de Variâncias-Covariâncias dos Erros possui matrizes menores que relacionam os erros do indivíduo {{<math>}}$i${{</math>}} (linha) e do indivíduo {{<math>}}$j${{</math>}} (coluna). Para escrever mais facilmente {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, podemos preenchê-la com matrizes menores de {{<math>}}$\boldsymbol{\Sigma}_{ij}${{</math>}}:


{{<math>}}$$ \underset{NT \times NT}{\boldsymbol{\Sigma}} = \left[ \begin{matrix} 
\boldsymbol{\Sigma}_1 & \boldsymbol{\Sigma}_{12} & \cdots & \boldsymbol{\Sigma}_{1N} \\
\boldsymbol{\Sigma}_{21} & \boldsymbol{\Sigma}_{2} & \cdots & \boldsymbol{\Sigma}_{2N} \\
\vdots & \vdots & \ddots & \vdots \\
\boldsymbol{\Sigma}_{N1} & \boldsymbol{\Sigma}_{N2} & \cdots & \boldsymbol{\Sigma}_{N}
\end{matrix} \right] \tag{1} $${{</math>}} 

em que, quando {{<math>}}$i = j${{</math>}}, temos

{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_i} = \left[ \begin{matrix} 
var(\varepsilon_{i1}) & cov(\varepsilon_{i1}, \varepsilon_{i2}) & \cdots & cov(\varepsilon_{i1}, \varepsilon_{iT}) \\
cov(\varepsilon_{i1}, \varepsilon_{i2}) & var(\varepsilon_{i2}) & \cdots & cov(\varepsilon_{i2}, \varepsilon_{iT}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{i1}, \varepsilon_{iT}) & cov(\varepsilon_{i2}, \varepsilon_{iT}) & \cdots & var(\varepsilon_{iT})
\end{matrix} \right] \tag{2} $${{</math>}}


e, quando {{<math>}}$i \neq j${{</math>}}, temos
{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_{ij}} = \left[ \begin{matrix} 
cov(\varepsilon_{i1}, \varepsilon_{j1}) & cov(\varepsilon_{i1}, \varepsilon_{j2}) & \cdots & cov(\varepsilon_{i1}, \varepsilon_{jT}) \\
cov(\varepsilon_{i1}, \varepsilon_{j2}) & cov(\varepsilon_{i2}, \varepsilon_{j2}) & \cdots & cov(\varepsilon_{i2}, \varepsilon_{jT}) \\
\vdots & \vdots & \ddots & \vdots \\
cov(\varepsilon_{i1}, \varepsilon_{jT}) & cov(\varepsilon_{i2}, \varepsilon_{jT}) & \cdots & cov(\varepsilon_{iT}, \varepsilon_{jT})
\end{matrix} \right]. \tag{3} $${{</math>}}


Como assumimos amostragem aleatória em que a covariância entre dois indivíduos distintos {{<math>}}($i \neq j$){{</math>}} é  
{{<math>}}$$ cov(\varepsilon_{it}, \varepsilon_{jt}) = cov(\varepsilon_{it}, \varepsilon_{js}) = 0,  \qquad \text{para todo } i \neq j.$${{</math>}}

Logo, {{<math>}}$\boldsymbol{\Sigma}_{ij} = \boldsymbol{0}${{</math>}} (matriz de zeros):
{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_{ij}} =  \underset{T \times T}{\boldsymbol{0}} = \left[ \begin{matrix} 
0 & 0 & \cdots & 0 \\
0 & 0 & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & 0
\end{matrix} \right] $${{</math>}}


Logo, podemos reescrever (1) como

{{<math>}}$$ \underset{NT \times NT}{\boldsymbol{\Sigma}} = \left[ \begin{matrix} 
\boldsymbol{\Sigma}_1 & \boldsymbol{0} & \cdots & \boldsymbol{0} \\
\boldsymbol{0} & \boldsymbol{\Sigma}_2 & \cdots & \boldsymbol{0} \\
\vdots & \vdots & \ddots & \vdots \\
\boldsymbol{0} & \boldsymbol{0} & \cdots & \boldsymbol{\Sigma}_N
\end{matrix} \right]. \tag{1'} $${{</math>}}

Assumimos também que a Matriz de Variâncias-Covariâncias dos Erros do indivíduo {{<math>}}$i${{</math>}} depende apenas dos parâmetros {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}}, já que:

- Variância de um erro: {{<math>}}$ var(\varepsilon_{it}) = \sigma^2_u + \sigma^2_v ${{</math>}}
- Covariância de dois erros de um mesmo indivíduo {{<math>}}$i${{</math>}} em dois períodos  {{<math>}}$t \neq s${{</math>}}: {{<math>}}$ cov(\varepsilon_{it}, \varepsilon_{is}) = \sigma^2_u ${{</math>}}

Substituindo em (2), segue que

{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_i} = \left[ \begin{array}{cccc} 
\sigma^2_u + \sigma^2_v & \sigma^2_u & \cdots & \sigma^2_u \\
\sigma^2_u & \sigma^2_u + \sigma^2_v & \cdots & \sigma^2_u \\
\vdots & \vdots & \ddots & \vdots \\
\sigma^2_u & \sigma^2_u & \cdots & \sigma^2_u + \sigma^2_v
\end{array} \right] \tag{2'} $${{</math>}}


##### Exemplo
Por simplicidade, considere que {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}. Logo, a Matriz de Variâncias-Covariâncias dos Erros pode ser escrita como;

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

Note que acima foram utilizadas linhas verticais e horizontais apenas para facilitar a visualização dos elementos que substituíram cada matriz.


#### Calculando no R

Primeiro, denote {{<math>}}$I_p${{</math>}} a matriz identidade de dimensão {{<math>}}$p \times p${{</math>}}:

{{<math>}}$$ \boldsymbol{I}_p= \left[ \begin{array}{cccc}
    1 & 0 & 0 & \cdots & 0 \\
    0 & 1 & 0 & \cdots & 0 \\
    0 & 0 & 1 & \cdots & 0 \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & 0 & 0 & \cdots & 1
\end{array} \right]_{p \times p}, $$ {{</math>}}

e considere {{<math>}}$\boldsymbol{\iota}_q${{</math>}} um vetor-coluna de 1's de tamanho {{<math>}}$q${{</math>}}:
{{<math>}}$$ \boldsymbol{\iota}_q = \left[ \begin{array}{c} 1 \\ 1 \\ \vdots \\ 1 \end{array} \right]_{q \times 1} $${{</math>}}


Com dados em **corte transversal**, era fácil calcular a Matriz de Variâncias-Covariâncias dos Erros, pois só havia um termo de erro e, portanto, tínhamos {{<math>}}$\sigma^2${{</math>}} apenas na diagonal principal:

{{<math>}}\begin{align}
\boldsymbol{\Sigma}_{\scriptscriptstyle{MQO}} &= \sigma^2 \boldsymbol{I}_N \\
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


Agora, para **dados em painel**, como visto acima, possuímos duas variâncias de termos de erro, sendo que {{<math>}}$\sigma^2_v${{</math>}} aparece na diagonal principal, cujos elementos (e seus "vizinhos") precisam ser somados por {{<math>}}$\sigma^2_u${{</math>}}. Logo, a Matriz de Variâncias-Covariâncias dos Erros com dados em painel pode ser escrita na forma matricial como:

{{<math>}}$$ \boldsymbol{\Sigma} = \sigma^2_v \boldsymbol{I}_{NT} + T \sigma^2_u [\boldsymbol{I}_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T] \tag{4} $${{</math>}}

Note que o primeiro termo da soma cria uma diagonal principal de {{<math>}}$\sigma^2_v${{</math>}}.

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


Agora, "só" precisamos somar {{<math>}}$\sigma^2_u${{</math>}} "na proximidade" dessa diagonal.

Por enquanto, vamos ignorar {{<math>}}$T \sigma^2_u${{</math>}} e vamos chamar a parte entre colchetes de matriz de transformação **inter-indivíduos (_between_)**:

{{<math>}}$$ \boldsymbol{B}\ \equiv\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}

Note que a matriz {{<math>}}$\boldsymbol{B}${{</math>}} é chamada de  {{<math>}}$\boldsymbol{N}${{</math>}} nas notas de aula de Econometria II (2021) do prof. Daniel.

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

em que {{<math>}}$\otimes${{</math>}} é o produto de Kronecker. Agora, ao multiplicar por {{<math>}}$T \sigma^2_u${{</math>}}, todos elementos {{<math>}}$1/T${{</math>}} tornam-se {{<math>}}$\sigma^2_u${{</math>}}:

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
`$${{</math>}}


Somando os dois termos de (4), conseguimos obter a Matriz de Variâncias-Covariâncias dos Erros:

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


##### Exemplo
Considere o caso com {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}. Vamos, então, obter a seguinte Matriz de Variâncias-Covariâncias dos Erros:

{{<math>}}$$\boldsymbol{\Sigma} = \left[ \begin{array}{ccc|ccc} 
        \sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u & 0 & 0 & 0 \\
        \sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u & 0 & 0 & 0 \\
        \sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v & 0 & 0 & 0 \\\hline
        0 & 0 & 0 & \sigma^2_u + \sigma^2_v & \sigma^2_u & \sigma^2_u \\
        0 & 0 & 0 & \sigma^2_u & \sigma^2_u + \sigma^2_v & \sigma^2_u \\
        0 & 0 & 0 & \sigma^2_u & \sigma^2_u & \sigma^2_u + \sigma^2_v
    \end{array} \right]$${{</math>}}

Assumindo {{<math>}}$\sigma^2_u = 2${{</math>}} e {{<math>}}$\sigma^2_v = 3${{</math>}}, segue que

{{<math>}}$$\boldsymbol{\Sigma} = \left[ \begin{array}{ccc|ccc} 
        5 & 2 & 2 & 0 & 0 & 0 \\
        2 & 5 & 2 & 0 & 0 & 0 \\
        2 & 2 & 5 & 0 & 0 & 0 \\\hline
        0 & 0 & 0 & 5 & 2 & 2 \\
        0 & 0 & 0 & 2 & 5 & 2 \\
        0 & 0 & 0 & 2 & 2 & 5
    \end{array} \right]$${{</math>}}



</br>


Para calcular no R, vamos definir:

```r
N = 2 # número de indivíduos
T = 3 # números de períodos
sig2u = 2 # variância do termo de erro do indivíduo
sig2v = 3 # variância do termo de erro idiossincrático 
```


O primeiro termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}} é

```r
I_NT = diag(N*T) # matriz identidade de tamanho NT
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

Para o 2º termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, temos que criar a matriz identidade e o vetor de 1's primeiro:

```r
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
iota_T
```

```
##      [,1]
## [1,]    1
## [2,]    1
## [3,]    1
```

```r
I_N = diag(N) # matriz identidade de tamanho N
I_N
```

```
##      [,1] [,2]
## [1,]    1    0
## [2,]    0    1
```

Vamos obter {{<math>}}$\boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T${{</math>}}

```r
# Para obter matriz T x T preenchida por 1/T, sendo T = 3, temos que:
t(iota_T) %*% iota_T # produto interno de iotas = quantidade T
```

```
##      [,1]
## [1,]    3
```

```r
solve(t(iota_T) %*% iota_T) # tomar a inversa = 1/T
```

```
##           [,1]
## [1,] 0.3333333
```

```r
iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T) # pré e pós-multiplicar por iotas
```

```
##           [,1]      [,2]      [,3]
## [1,] 0.3333333 0.3333333 0.3333333
## [2,] 0.3333333 0.3333333 0.3333333
## [3,] 0.3333333 0.3333333 0.3333333
```

Agora, vamos calcular {{<math>}}$\boldsymbol{B}\ =\ I_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T${{</math>}} usando o operador de produto de Kronecker `%x%`:

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

Multiplicando {{<math>}}$\boldsymbol{B}${{</math>}} por {{<math>}}$T \sigma^2_u${{</math>}}, obtemos o 2º termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}}:

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

Então, a Matriz de Variâncias-Covariâncias dos Erros é dada por:

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




### Estimação dos Componentes de Erro
- Note que não temos {{<math>}}$\sigma^2_v${{</math>}} e {{<math>}}$\sigma^2_u${{</math>}} e, logo, {{<math>}}$\boldsymbol{\Sigma}${{</math>}} é desconhecido.

- Primeiro, considere a **matriz de transformação _within_**, dada por

{{<math>}}$$ \boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} $${{</math>}}

- Note que podemos reescrever
{{<math>}}\begin{align} \hat{\boldsymbol{\Sigma}} &= \hat{\sigma}^2_v \boldsymbol{I}_{NT} + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v (\boldsymbol{W} + \boldsymbol{B}) + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v \boldsymbol{W} + \hat{\sigma}^2_v \boldsymbol{B} + T \hat{\sigma}^2_u \boldsymbol{B}\\ 
&= \hat{\sigma}^2_v \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u) \boldsymbol{B}
\end{align}{{</math>}}
em que {{<math>}}$\boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} \iff \boldsymbol{I}_{NT} = \boldsymbol{W} + \boldsymbol{B} ${{</math>}}

</br>

- Isso pode ser generalizado para:
{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B}, \tag{2.29} $${{</math>}}
em que {{<math>}}$p${{</math>}} é um escalar.
- Essa fórmula será importante para calcularmos {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-1}${{</math>}} ou {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-0,5}${{</math>}} mais adiante.


</br>

- Se {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} fosse conhecido, então poderíamos estimar as duas variâncias usando:

{{<math>}}\begin{align*}
    \hat{\sigma}^2_v &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{W} \boldsymbol{\varepsilon}}{N(T-1)} \tag{2.35} \\
    \\
    \hat{\sigma}^2_v + T \hat{\sigma}^2_u &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} \tag{2.34} \\
    \hat{\sigma}^2_u &= \frac{1}{T} \left( \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} - \hat{\sigma}^2_v \right)
\end{align*}{{</math>}}

- Como {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} é desconhecido, então podemos usar resíduos de estimadores consistentes em seu lugar.

- **Wallace e Hussain (1969)**: usam resíduos MQO

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} 
    \quad \text{ e } \quad 
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}

- **Amemiya (1971)**: usa resíduos _within_
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1)}
    \quad \text{ e } \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Hausman e Taylor (1981)**: propuseram ajuste ao método de Amemiya (1971), em que {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}${{</math>}} são regredidos em todas variáveis invariantes no tempo no modelo e são utilizados os resíduos dessa regressão, {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{HT}}${{</math>}}.

- **Swamy e Arora (1972)**: usam resíduos _between_ e _within_ para calcular:
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1) - K}
    \quad \text{ e } \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{B}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}}{N - K - 1} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Nerlove (1971)**: computa {{<math>}}$\sigma^2_u${{</math>}} empírica dos efeitos fixos do modelo _within_

{{<math>}}\begin{align*}
    \hat{u}_i &= \bar{y}_{i\cdot} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\bar{x}_{i\cdot} \\
    \hat{\sigma}^2_u &= \sum^N_{i=1}{(\hat{u}_i - \bar{\hat{u}}) / (N-1)} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{NT}
\end{align*}{{</math>}}


Após obter {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}}, só precisamos calcular {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}:



</br>

<!-- ## Estimadores MQO em painel -->
<!-- - Supomos que ambos componentes de erros são não-correlacionados com as covariadas: -->
<!-- {{<math>}}$$ E(u|X) = E(v|X) = 0 $${{</math>}} -->
<!-- - A variabilidade em um painel tem 2 componentes: -->
<!--     - a _between_ ou inter-indivíduos, em que a variabilidade das variáveis são mensuradas em médias individuais, como {{<math>}}$\bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$BZ${{</math>}} -->
<!--     - a _within_ ou intra-indivíduos, em que a variabilidade das variáveis são mensuradas em desvios das médias individuais, como {{<math>}}$z_{it} - \bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$\boldsymbol{WX} = \boldsymbol{X} - \boldsymbol{BX}${{</math>}} -->
<!--     - Lembre-se que {{<math>}}$\boldsymbol{X} \equiv (\boldsymbol{\iota}, X)${{</math>}} -->
<!-- - Há três estimadores por MQO que podem ser utilizados: -->
<!--     1. *Mínimos Quadrados Empilhados (MQE)*: usando a base de dados bruta (empilhada) -->
<!--     2. *Estimador Between*: usando as médias individuais -->
<!--     3. *Estimador Within (Efeitos Fixos)*: usando os desvios das médias individuais -->



## Estimador MQE
- Seção 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Mínimos Quadrados Empilhados (MQE) faz a estimação igual ao MQO, porém a inferência considera {{<math>}}$\boldsymbol{\Sigma} \neq \sigma^2 \boldsymbol{I}${{</math>}}, considera correlação entre as observações de um mesmo indivíduo {{<math>}}$i${{</math>}}.


O modelo a ser estimado é
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X\beta} + \boldsymbol{\varepsilon} $${{</math>}}


- O estimador {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} de MQE (igual ao de MQO) é dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

- Note que a Matriz de Variâncias-Covariâncias do Estimador de MQO, que supõe {{<math>}}$ \boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I} ${{</math>}}, simplifica para:

{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}) 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\ 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \left[ \sigma^2 \boldsymbol{I} \right] \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \sigma^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \hat{\sigma}^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \end{align}{{</math>}}


- A Matriz de Variâncias-Covariâncias do Estimador de MQE, que considera a correlação entre observações de um mesmo indivíduo, é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


### Estimação MQE via `plm()`
Para ilustrar as estimações MQO dos estimadores vistos anteriormente, usaremos a base de dados `TobinQ` do pacote `pder`, que conta com dados de 188 firmas por 35 anos (6580 observações).

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
- `cusip`: Identificador da empresa
- `year`: Ano
- `ikn`: Investimento dividido pelo capital
- `qn`: Q de Tobin (razão entre valor da firma e o custo de reposição de seu capital físico). Se {{<math>}}$Q > 1${{</math>}}, então o lucro do investimento é maior do que seu custo.

Queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta_1 + \varepsilon $${{</math>}}


Usaremos a função `plm()` (do pacote de mesmo nome) para estimar modelos lineares em dados em painel. Seus principais argumentos são:

- `formula`: equação do modelo
- `data`: base de dados em `data.frame` (precisa preencher `index`) ou `pdata.frame` (formato próprio do pacote que já indexa as colunas de indivíduos e de tempo)
- `model`: estimador a ser computado 'pooling' (MQE), 'between', 'within' (Efeitos Fixos) ou 'random' (Efeitos Aleatórios/MQGF)
- `index`: vetor de nomes das colunas dos identificadores de indivíduo e de tempo

Note que a estimação do MQE (_pooled_) via `plm()`, faz a estimação considerando {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}} e, portanto, estará erroneamente desconsiderando as correlações entre erros de um mesmo indivíduo:


```r
library(plm)

# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimação MQO
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")
Q.ols = lm(ikn ~ qn, TobinQ)

# Comparando ambos outputs
stargazer::stargazer(Q.pooling, Q.ols, type="text")
```

```
## 
## =======================================================
##                                Dependent variable:     
##                            ----------------------------
##                                        ikn             
##                              panel           OLS       
##                              linear                    
##                               (1)            (2)       
## -------------------------------------------------------
## qn                          0.004***      0.004***     
##                             (0.0002)      (0.0002)     
##                                                        
## Constant                    0.158***      0.158***     
##                             (0.001)        (0.001)     
##                                                        
## -------------------------------------------------------
## Observations                 6,580          6,580      
## R2                           0.111          0.111      
## Adjusted R2                  0.111          0.111      
## Residual Std. Error                   0.086 (df = 6578)
## F Statistic (df = 1; 6578) 824.663***    824.663***    
## =======================================================
## Note:                       *p<0.1; **p<0.05; ***p<0.01
```


- Precisamos fazer a inferência considerando uma Matriz de Variâncias-Covariâncias dos Erros apropriada. Para isto, vamos usar o argumento `vcov=vcovBK` dentro da função `summary()`:

```r
# Estimação MQE - matriz de var-cov dos erros com correlação intra-indiv
summary(Q.pooling, vcov=vcovBK)$coef
```

```
##               Estimate   Std. Error  t-value     Pr(>|t|)
## (Intercept) 0.15799969 0.0034686968 45.55016 0.000000e+00
## qn          0.00439197 0.0003774606 11.63557 5.458161e-31
```



### Estimação MQE Analítica
A estimação analítica do MQE é equivalente ao MQO vista anteriormente, mas no contexto de dados em painel. As principais diferenças são: o número de graus de liberdade é {{<math>}}$NT - K - 1${{</math>}} (pois possui {{<math>}}$NT${{</math>}} observações) e a modelagem da matriz de variâncias-covariâncias dos erros, {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, para o contexto de painel.

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz
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
# Criando a matriz de covariadas X com primeira coluna de 1's
X = cbind( 1, TobinQ[, "qn"] ) # juntando 1's com as covariadas
X = as.matrix(X) # transformando em matriz
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
# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
N # nº de indivíduos i
```

```
## [1] 188
```

```r
T = length( unique(TobinQ$year) )
T # nº de períodos t
```

```
## [1] 35
```

```r
K = ncol(X) - 1
K # nº de covariadas
```

```
## [1] 1
```

b) Estimativas de MQE {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

```r
bhat = solve( t(X) %*% X ) %*% t(X) %*% y
bhat
```

```
##            [,1]
## [1,] 0.15799969
## [2,] 0.00439197
```

c) Valores ajustados/preditos {{<math>}}$\hat{\boldsymbol{y}}${{</math>}}

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

d) Resíduos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

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

e) Variâncias dos termos de erros

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Como {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}} são escalares, é conveniente transformar as "matrizes 1x1" em números usando `as.numeric()`:

```r
# Criando matrizes between e within
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
I_NT = diag(N*T) # matriz identidade de tamanho NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Calculando variâncias dos termos de erro (Wallace & Hussain)
sig2v = as.numeric( (t(ehat) %*% W %*% ehat) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat) %*% B %*% ehat)/N - sig2v ) )
```


f) Matriz de Variâncias-Covariâncias dos Erros
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = \hat{\sigma}^2_v \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u) \boldsymbol{B}$${{</math>}}


```r
# Calculando a Matriz de Variâncias-Covariâncias dos Erros
Sigma = sig2v * W + (sig2v + T*sig2u) * B
```



g) Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


```r
# Calculando a Matriz de variância-covariância dos estimadores
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


h) Erros-padrão do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}})${{</math>}}

É a raiz quadrada da diagonal principal da Matriz de Variâncias-Covariâncias do Estimador

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034936352 0.0003366365
```

i) Estatística _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Cálculo da estatística t
t_bhat = bhat / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 45.22501
## [2,] 13.04663
```

j) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.F_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)
p_bhat
```

```
##              [,1]
## [1,] 0.000000e+00
## [2,] 1.986019e-38
```

k) Tabela-resumo

```r
cbind(bhat, se_bhat, t_bhat, p_bhat) # resultado MQE correto
```

```
##                      se_bhat                      
## [1,] 0.15799969 0.0034936352 45.22501 0.000000e+00
## [2,] 0.00439197 0.0003366365 13.04663 1.986019e-38
```

```r
summary(Q.pooling)$coef # resultado MQO via plm() ou lm()
```

```
##               Estimate  Std. Error   t-value      Pr(>|t|)
## (Intercept) 0.15799969 0.001124399 140.51928  0.000000e+00
## qn          0.00439197 0.000152940  28.71694 5.789663e-171
```

```r
summary(Q.pooling, vcov=vcovBK)$coef # com matriz cov erros ajustada
```

```
##               Estimate   Std. Error  t-value     Pr(>|t|)
## (Intercept) 0.15799969 0.0034686968 45.55016 0.000000e+00
## qn          0.00439197 0.0003774606 11.63557 5.458161e-31
```


</br>


## Estimador MQGF

- Seção 2.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Também conhecido como **estimador de efeitos aleatórios**, pois considera que os efeitos individuais são aleatórios: {{<math>}}$E(\boldsymbol{u}) = 0${{</math>}}
- Erros são relacionados pela Matriz de Variâncias-Covariâncias dos Erros {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- O estimador de MQGF é dado por
{{<math>}}$$ {\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} = (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) \tag{2.27} $${{</math>}}

- A variância do estimador é dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \tag{2.28} $${{</math>}}
- A matriz {{<math>}}$\boldsymbol{\Sigma}${{</math>}} depende apenas de dois parâmetros: {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}}, temos:
{{<math>}}$$ \boldsymbol{\Sigma}^p = ({\sigma}^2_v)^p \boldsymbol{W} + ({\sigma}^2_v + T {\sigma}^2_u)^p \boldsymbol{B} \tag{2.29} $${{</math>}}

</br>

- Como desconhecemos {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, podemos calcular {{<math>}}$\boldsymbol{\hat{\Sigma}}${{</math>}} por meio da estimação dos componentes de erro usando, por exemplo, Wallace e Hussain (1969):

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} 
    \quad \text{ e } \quad 
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}



### Estimação MQGF via `plm()`
- Usaremos novamente a função `plm()`, mas definiremos `model = random` para que seja estimado via MQGF
- em `random.method` podemos escolher o método de cálculo dos parâmetros de erro:
    1. `"walhus"` para Wallace e Hussain (1969)
    2. `"amemiya"` para Amemiya (1971)
    3. `"ht"` para Hausman e Taylor (1981)
    4. `"swar"` para Swamy e Arora (1972) [padrão]
    5. `"nerlove"` para Nerlove (1971)


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimações MQGF
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "nerlove")

# Resumindo 5 estimações em única tabela
stargazer::stargazer(Q.walhus, Q.amemiya, Q.ht, Q.swar, Q.nerlove,
                     digits=5, type="text")
```

```
## 
## =============================================================================
##                                    Dependent variable:                       
##              ----------------------------------------------------------------
##                                            ikn                               
##                  (1)          (2)          (3)          (4)          (5)     
## -----------------------------------------------------------------------------
## qn            0.00386***   0.00386***   0.00386***   0.00386***   0.00386*** 
##               (0.00017)    (0.00017)    (0.00017)    (0.00017)    (0.00017)  
##                                                                              
## Constant      0.15933***   0.15933***   0.15933***   0.15933***   0.15934*** 
##               (0.00341)    (0.00344)    (0.00344)    (0.00342)    (0.00361)  
##                                                                              
## -----------------------------------------------------------------------------
## Observations    6,580        6,580        6,580        6,580        6,580    
## R2             0.07418      0.07412      0.07412      0.07415      0.07376   
## Adjusted R2    0.07404      0.07398      0.07398      0.07401      0.07362   
## F Statistic  527.04530*** 526.62180*** 526.62180*** 526.85440*** 523.83190***
## =============================================================================
## Note:                                             *p<0.1; **p<0.05; ***p<0.01
```

Neste caso específico, os resultados são praticamente idênticos.



### Estimação MQGF Analítica
- Aqui, faremos a estimação analítica do MQGF usando o método de Wallace e Hussain (1969).
- Consiste no uso dos desvios estimados por pooled MQO para calcular {{<math>}}$\hat{\sigma}^2_u${{</math>}}, {{<math>}}$\hat{\sigma}^2_v${{</math>}}, possibilitando encontrar {{<math>}}$\hat{\boldsymbol{\Sigma}}^{-1}${{</math>}} para estimar por MQGF.
- Primeiro, precisamos encontrar {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}${{</math>}} e {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}, para estimar {{<math>}}$\hat{\sigma}^2_{u}${{</math>}}, {{<math>}}$\hat{\sigma}^2_{v}${{</math>}} e {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}


a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # juntando 1's com as covariadas

# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1
```

b) Estimativas de MQO {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

```r
bhat_MQO = solve( t(X) %*% X ) %*% t(X) %*% y
```

c) Valores ajustados/preditos de MQO {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
yhat_MQO = X %*% bhat_MQO
```

d) Resíduos de MQO {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
ehat_MQO = y - yhat_MQO
```

e) Variâncias dos termos de erros

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Como {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}} são escalares, é conveniente transformar as "matrizes 1x1" em números usando `as.numeric()`:

```r
# Criando matrizes between e within
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
I_NT = diag(N*T) # matriz identidade de tamanho NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Calculando variâncias dos termos de erro (Wallace & Hussain)
sig2v = as.numeric( (t(ehat_MQO) %*% W %*% ehat_MQO) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat_MQO) %*% B %*% ehat_MQO)/N - sig2v ) )
```


f) Matriz de Variâncias-Covariâncias dos Erros

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Calculando a Matriz de Variâncias-Covariâncias dos Erros
Sigma = sig2v * W + (sig2v + T*sig2u) * B

# Inversa da Matriz
Sigma_1 = sig2v^(-1) * W + (sig2v + T*sig2u)^(-1) * B
```

*Note que usar `solve()` na matriz `Sigma` demora mais tempo de processamento do que usar a fórmula


g) Estimativas de MQGF {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} $${{</math>}}

```r
bhat_MQGF = solve( t(X) %*% Sigma_1 %*% X ) %*% t(X) %*% Sigma_1 %*% y
bhat_MQGF
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```

h) Valores ajustados/preditos de MQGF {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{MQGF}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQGF}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} $${{</math>}}


```r
yhat_MQGF = X %*% bhat_MQGF
head(yhat_MQGF)
```

```
##           [,1]
## [1,] 0.2014672
## [2,] 0.2065837
## [3,] 0.1879484
## [4,] 0.1855138
## [5,] 0.1878022
## [6,] 0.1828793
```



i) Matriz de Variâncias-Covariâncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} $${{</math>}}


```r
# Calculando a Matriz de variância-covariância dos estimadores
Vbhat = solve( t(X) %*% Sigma_1 %*% X )
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.167208e-05 -7.100808e-08
## [2,] -7.100808e-08  2.834259e-08
```


j) Erros-padrão do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}})${{</math>}}

É a raiz quadrada da diagonal principal da Matriz de Variâncias-Covariâncias do Estimador

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034164422 0.0001683526
```

k) Estatística _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# Cálculo da estatística t
t_bhat = bhat_MQGF / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 46.63503
## [2,] 22.94370
```

l) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.F_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)
p_bhat
```

```
##               [,1]
## [1,]  0.000000e+00
## [2,] 3.904386e-112
```

m) Tabela-resumo

```r
cbind(bhat_MQGF, se_bhat, t_bhat, p_bhat) # resultado MQE correto
```

```
##                       se_bhat                       
## [1,] 0.159325869 0.0034164422 46.63503  0.000000e+00
## [2,] 0.003862631 0.0001683526 22.94370 3.904386e-112
```

```r
summary(Q.walhus)$coef # resultado MQGF via plm()
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```



### Transformando as variáveis e resolvendo por MQO
Além da forma mostrada anteriormente, podemos também transformar as variáveis e resolver por MQO, pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{\Sigma}^{-0.5}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}$${{</math>}}

f') Matriz de Variâncias-Covariâncias dos Erros

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Matriz de Variâncias-Covariâncias dos Erros ^ (-0.5)
Sigma_05 = sig2v^(-0.5) * W + (sig2v + T*sig2u)^(-0.5) * B

# Variáveis transformadas
X_til = Sigma_05 %*% X
y_til = Sigma_05 %*% y
```


g') Estimativas de MQGF via MQO

{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= ([\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}])^{-1} [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}] \\
&\equiv (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} 
\end{align}{{</math>}}

Note que {{<math>}}$\boldsymbol{\Sigma}'^{-0.5} = \boldsymbol{\Sigma}^{-0.5}${{</math>}}.


```r
bhat_MQGF = solve( t(X_til) %*% X_til ) %*% t(X_til) %*% y_til
bhat_MQGF
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```

h') Valores Ajustados e Resíduos


```r
yhat = X_til %*% bhat_MQGF # Valores Ajustados
ehat = y_til - yhat # Resíduos
```


i') Variância do termo de erro 

```r
sig2hat = as.numeric( t(ehat) %*% ehat / (N*T - K - 1) )
```


j') Matriz de Variâncias-Covariâncias dos Erros

```r
Vbhat = sig2hat * solve(t(X_til) %*% X_til)
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.165808e-05 -7.092295e-08
## [2,] -7.092295e-08  2.830861e-08
```


k') Erro Padrão das Estimativas, Estatística t e P-valor

```r
se_bhat = sqrt( diag(Vbhat) )
t_bhat = bhat_MQGF / se_bhat
p_bhat = 2 * pt(-abs(t_bhat), N*T-K-1)
```

l') Comparativo

```r
# MQGF via MQO Analítico
cbind(bhat_MQGF, se_bhat, t_bhat, p_bhat)
```

```
##                       se_bhat                       
## [1,] 0.159325869 0.0034143937 46.66300  0.000000e+00
## [2,] 0.003862631 0.0001682516 22.95747 2.912584e-112
```

```r
# MQGF via plm
summary(Q.walhus)$coef
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```



</br>

## Estimadores _Between_ e _Within_

- A variabilidade em um painel tem 2 componentes:
    - a _between_ ou inter-indivíduos, em que a variabilidade das variáveis são mensuradas em médias individuais, como {{<math>}}$\bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$BZ${{</math>}}
    - a _within_ ou intra-indivíduos, em que a variabilidade das variáveis são mensuradas em desvios das médias individuais, como {{<math>}}$z_{it} - \bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$\boldsymbol{WX} = \boldsymbol{X} - \boldsymbol{BX}${{</math>}}

### Modelo em Painel (2)
Note que o modelo anterior não possui uma constante, {{<math>}}$\alpha${{</math>}}. Podemos incluir uma constante no modelo (1) e reescrever esse novo modelo como:
{{<math>}} \begin{align} y_{it} &= 1.\alpha + \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{2} \end{align} {{</math>}}



Empilhando todas equações (2) para todo {{<math>}}$i${{</math>}} e {{<math>}}$t${{</math>}}, segue que
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{\iota} \alpha + X \boldsymbol{\beta} + \boldsymbol{\varepsilon} $${{</math>}}
ou, usando

{{<math>}}\begin{align} \underbrace{\boldsymbol{\gamma}}_{(K+1) \times 1} &\equiv \left[ \begin{array}{c} \alpha \\ \boldsymbol{\beta} \end{array} \right] = 
 \left[ \begin{array}{c} \alpha \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{array} \right] \quad \text{ e }\\ 
\underbrace{\boldsymbol{X}}_{NT \times (K+1)} &\equiv \left[ \begin{array}{c} \boldsymbol{\iota} & \boldsymbol{X} \end{array} \right]
  = \left[ \begin{array}{cccc}
    1 & x^1_{11} & x^2_{11} & \cdots & x^K_{11} \\
    1 & x^1_{12} & x^2_{12} & \cdots & x^K_{12} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{1T} & x^2_{1T} & \cdots & x^K_{1T} \\ \hline
    1 & x^1_{21} & x^2_{21} & \cdots & x^K_{21} \\
    1 & x^1_{22} & x^2_{22} & \cdots & x^K_{22} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\ 
    1 & x^1_{2T} & x^2_{2T} & \cdots & x^K_{2T} \\ \hline
    \vdots & \vdots & \vdots & \ddots & \vdots \\ \hline
    1 & x^1_{N1} & x^2_{N1} & \cdots & x^K_{N1} \\
    1 & x^1_{N2} & x^2_{N2} & \cdots & x^K_{N2} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    1 & x^1_{NT} & x^2_{NT} & \cdots & x^K_{NT}
\end{array} \right], \end{align} {{</math>}}

podemos reescrever como
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X} \boldsymbol{\gamma} + \boldsymbol{\varepsilon}. $${{</math>}}

### Transformações _between_ e _within_
- Seção 2.1.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)



A matriz de transformação **inter-indivíduos (_between_)** é denotada por:
{{<math>}}$$ \boldsymbol{B}\ =\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}
Note que a matriz {{<math>}}$\boldsymbol{B}${{</math>}} é equivalente a {{<math>}}$\boldsymbol{N}${{</math>}} nas notas de aula de Econometria II.

Pré-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} pela matriz de transformação {{<math>}}$\boldsymbol{B}${{</math>}}, "preenchemos" a matriz com as médias para cada {{<math>}}$i${{</math>}} e cada coluna (variável):

{{<math>}}$$ \boldsymbol{BX} = \left[ \begin{matrix} 
1 & \bar{\boldsymbol{x}}^1_1 & \bar{\boldsymbol{x}}^2_1 & \cdots & \bar{\boldsymbol{x}}^K_1 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & \bar{\boldsymbol{x}}^1_1 & \bar{\boldsymbol{x}}^2_1 & \cdots & \bar{\boldsymbol{x}}^K_1 \\
1 & \bar{\boldsymbol{x}}^1_2 & \bar{\boldsymbol{x}}^2_2 & \cdots & \bar{\boldsymbol{x}}^K_2 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & \bar{\boldsymbol{x}}^1_2 & \bar{\boldsymbol{x}}^2_2 & \cdots & \bar{\boldsymbol{x}}^K_2 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & \bar{\boldsymbol{x}}^1_N & \bar{\boldsymbol{x}}^2_N & \cdots & \bar{\boldsymbol{x}}^K_N \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & \bar{\boldsymbol{x}}^1_N & \bar{\boldsymbol{x}}^2_N & \cdots & \bar{\boldsymbol{x}}^K_N
\end{matrix} \right]_{NT \times (K+1)} $${{</math>}}

</br>

Por exemplo, para {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}, segue que:

{{<math>}}\begin{align*}
    \boldsymbol{B} &= \boldsymbol{I}_2 \otimes \boldsymbol{\iota}_3 (\boldsymbol{\iota}'_3 \boldsymbol{\iota}_3)^{-1} \boldsymbol{\iota}'_3 \\
    &= \left[ \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ 1 \\ 1 \end{array} \right] \left( \left[ \begin{array}{ccc} 1 & 1 & 1 \end{array} \right] \left[ \begin{array}{c} 1 \\ 1 \\ 1 \end{array} \right] \right)^{-1} \left[ \begin{array}{ccc} 1 & 1 & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ 1 \\ 1 \end{array} \right] \left( 3 \right)^{-1} \left[ \begin{array}{ccc} 1 & 1 & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right] \otimes \left( \left[ \begin{array}{c} 1 \\ 1 \\ 1 \end{array} \right] \frac{1}{3} \left[ \begin{array}{ccc} 1 & 1 & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right] \otimes \left( \frac{1}{3}  \left[ \begin{array}{c} 1 & 1 & 1 \\ 1 & 1 & 1 \\ 1 & 1 & 1 \end{array} \right] \right) \\
    &= \left[ \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right]_{2 \times 2}  \otimes  \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right)_{3 \times 3}  \\
    &= \left[ \begin{array}{cc} 1 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) & 0 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) \\ 0 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) & 1 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) \end{array} \right] \\
    &= \left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right]_{6 \times 6},
\end{align*}{{</math>}}

em que {{<math>}}$\otimes${{</math>}} é o produto de Kronecker.

Por exemplo, suponha a matriz {{<math>}}$\boldsymbol{X}${{</math>}}: 

{{<math>}}$$ \boldsymbol{X} = \left[ \begin{matrix} 
1 & 1 & 7 & 13 \\
1 & 2 & 8 & 14 \\
1 & 3 & 9 & 15 \\ \hline
1 & 4 & 10 & 16 \\
1 & 5 & 11 & 17 \\
1 & 6 & 12 & 18
\end{matrix} \right]_{6 \times 4} $${{</math>}}

Note que a linha horizontal na matriz acima foi colocada apenas para deixar claro que as três primeiras linhas correspondem ao mesmo indivíduo {{<math>}}$i=1${{</math>}}, e as três últimas correspondem ao indivíduo {{<math>}}$i=2${{</math>}}. São três linhas para cada um, pois assumimos {{<math>}}$t=1,2,3${{</math>}} períodos.

Logo, temos:

{{<math>}}\begin{align} \boldsymbol{BX} &=  
\left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right] \left[ \begin{matrix} 
1 & 1 & 7 & 13 \\
1 & 2 & 8 & 14 \\
1 & 3 & 9 & 15 \\
1 & 4 & 10 & 16 \\
1 & 5 & 11 & 17 \\
1 & 6 & 12 & 18
\end{matrix} \right] \\
&= \left[ \begin{matrix} 
1 & 2 & 8 & 14 \\
1 & 2 & 8 & 14 \\
1 & 2 & 8 & 14 \\ \hline
1 & 5 & 11 & 17 \\
1 & 5 & 11 & 17 \\
1 & 5 & 11 & 17
\end{matrix} \right]_{6 \times 4} \end{align}{{</math>}}

Note que, para cada indivíduo {{<math>}}$i${{</math>}} e coluna {{<math>}}$k${{</math>}}, os elementos foram "preenchidos" com a média dos valores em {{<math>}}$t=1,2,3${{</math>}}.


</br>

Agora, vamos definir uma matriz de covariadas `X` e pós-multiplicar pela matriz `B`

```r
# K = 3 # número de covariadas
# X = matrix(1:(N*T*K), N*T, K) # matriz covariadas NT x K
# Z = cbind(1, X) # incluindo coluna de 1's
# Z
# 
# B %*% Z # matriz de médias das covariadas dado indivíduo (NT x K)
```

Note que:
- a coluna de 1's permaneceu igual após a transformação _between_.
- dada uma variável {{<math>}}$k${{</math>}}, temos um único valor (média) dentro de um mesmo indivíduo;
- por isso, a amostra com {{<math>}}$NT${{</math>}} observações distintas possui, agora, apenas {{<math>}}$N${{</math>}} observações distintas


</br>


Já a matriz de transformação **intra-indivíduos (_within_)** é dada por:
{{<math>}}$$ \boldsymbol{W}\ =\ \boldsymbol{I}_{NT} - \boldsymbol{B}\ =\ \boldsymbol{I}_{NT} - \Big[ \boldsymbol{I}_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big]. $${{</math>}}

Note que a matriz {{<math>}}$\boldsymbol{W}${{</math>}} é equivalente a {{<math>}}$M${{</math>}} nas notas de aula de Econometria II.

Por exemplo, para {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}, segue que:

{{<math>}}\begin{align*}
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
    \end{array} \right]_{6 \times 6}, 
\end{align*}{{</math>}}


```r
# I_NT = diag(N*T) # matriz identidade com NT elementos na diagonal
# W = I_NT - B # matriz de transformação within
# W
# ```
# ```{r}
# round(W %*% Z, 3) # matriz de desvios das médias das covariadas dado indivíduo (NT x K)
```
Observe que:

- dada uma variável {{<math>}}$k${{</math>}}, temos os desvios em relação à média de um mesmo indivíduo;
- coluna 1's virou de 0's após a transformação _within_.
- coluna de 0's, no R, ficou muito próxima de 0 ({{<math>}}$1,11 \times 10^{-16}${{</math>}}), então foi necessário arredondar.


### Estimador _Between_

O modelo a ser estimado é o MQO pré-multiplicado por {{<math>}}$\boldsymbol{B} = \boldsymbol{I}_N \otimes \boldsymbol{\iota} (\boldsymbol{\iota}' \boldsymbol{\iota})^{-1} \boldsymbol{\iota}'${{</math>}}:
{{<math>}}$$ \boldsymbol{By}\ =\ \boldsymbol{BX\gamma} + \boldsymbol{B\varepsilon}\ =\ \alpha \boldsymbol{\iota} + \boldsymbol{BX} \boldsymbol{\beta} + \boldsymbol{B\varepsilon} $${{</math>}}

- O estimador {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} é dado por
{{<math>}}$$ \hat{\boldsymbol{\gamma}}_{\scriptscriptstyle{B}}\ =\ (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} y $${{</math>}}
- A matriz de covariâncias pode ser obtida usando

{{<math>}}\begin{align*}
    V(\hat{\boldsymbol{\gamma}}_{\scriptscriptstyle{B}}) &= (\boldsymbol{X}'\boldsymbol{BX})^{-1} \boldsymbol{X}' \boldsymbol{B}\boldsymbol{\Sigma} \boldsymbol{B} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{BX})^{-1} \\
    &= \sigma^2_\varepsilon (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X})^{-1},
\end{align*}{{</math>}}
em que {{<math>}}$$\sigma^2_\varepsilon = \sigma^2_v + T \sigma^2_u $${{</math>}}

- O estimador não-viesado de {{<math>}}$\sigma^2_\varepsilon${{</math>}} é
{{<math>}}$$ \hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}

- O estimador _between_ também pode ser estimado por MQO, transformando as variáveis por pré-multiplicação da matriz _between_ ({{<math>}}$B${{</math>}}):
{{<math>}}$$ \tilde{\boldsymbol{X}} \equiv \boldsymbol{BX} \qquad \text{ e } \qquad \tilde{\boldsymbol{y}} = \boldsymbol{By} $${{</math>}} 
tal que 
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}
e assim por diante.
- Note que, a rotina padrão de MQO retorna {{<math>}}$\hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a Matriz de Variâncias-Covariâncias dos Erros por {{<math>}}$(NT-K-1) / (N-K-1)${{</math>}}.  


### Estimador _Within_ (Efeitos Fixos)
- Também conhecido como estimador de **Efeitos Fixos**
- Não assume que {{<math>}}$E(u | X) = 0${{</math>}}
- Estima efeitos individuais para, "limpando" efeito inter-indivíduos nas demais covariadas

O modelo a ser estimado é o MQO pré-multiplicado por {{<math>}}$\boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B}${{</math>}}:
{{<math>}}$$ \boldsymbol{Wy}\ =\ \boldsymbol{WX\gamma} + \boldsymbol{W\varepsilon}\ =\ \boldsymbol{WX \beta} + \boldsymbol{Wv}. $${{</math>}}
Note que a transformação within remove vetor de 1's associado ao intercepto, além das covariadas invariantes no tempo e o termo de erro individual {{<math>}}$u${{</math>}} (sobrando apenas {{<math>}}$\varepsilon = v${{</math>}}).

- O estimador {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} é dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\ =\ (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{W} \boldsymbol{y} $${{</math>}}
- A matriz de covariâncias pode ser obtida usando
{{<math>}}\begin{align*}
    V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}) &= (\boldsymbol{X}'\boldsymbol{WX})^{-1} \boldsymbol{X}' \boldsymbol{W}\boldsymbol{\Sigma} \boldsymbol{W} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{WX})^{-1} \\
    &= \sigma^2_v (\boldsymbol{X}' \boldsymbol{W} \boldsymbol{X})^{-1}.
\end{align*}{{</math>}}

- O estimador não-viesado de {{<math>}}$\sigma^2_v${{</math>}} é
{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}

- O estimador _within_ também pode ser estimado por MQO, transformando as variáveis por pré-multiplicação da matriz _within_ ({{<math>}}$W${{</math>}}):
{{<math>}}$$ \tilde{\boldsymbol{X}} \equiv \boldsymbol{WX} \qquad \text{ e } \qquad \tilde{\boldsymbol{y}} = \boldsymbol{Wy} $${{</math>}} 
tal que 
{{<math>}}$$ \hat{\boldsymbol{\gamma}} = ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}
e assim por diante.
- Note que, a rotina padrão de MQO retorna {{<math>}}$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a Matriz de Variâncias-Covariâncias dos Erros por {{<math>}}$(NT-K-1) / (NT-K-N)${{</math>}}.


### Estimação via `plm()`
Novamente, usaremos a base de dados `TobinQ` do pacote `pder` e queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \alpha + \text{qn} \beta + \varepsilon $${{</math>}}


```r
# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimações
Q.between = plm(ikn ~ qn, pTobinQ, model = "between")
Q.within = plm(ikn ~ qn, pTobinQ, model = "within")

# Resumindo 2 estimações em única tabela
stargazer::stargazer(Q.pooling, Q.between, Q.within, type="text")
```

```
## 
## ========================================================================================
##                                          Dependent variable:                            
##              ---------------------------------------------------------------------------
##                                                  ikn                                    
##                         (1)                      (2)                      (3)           
## ----------------------------------------------------------------------------------------
## qn                   0.004***                 0.005***                 0.004***         
##                      (0.0002)                  (0.001)                 (0.0002)         
##                                                                                         
## Constant             0.158***                 0.156***                                  
##                       (0.001)                  (0.004)                                  
##                                                                                         
## ----------------------------------------------------------------------------------------
## Observations           6,580                     188                     6,580          
## R2                     0.111                    0.205                    0.070          
## Adjusted R2            0.111                    0.201                    0.043          
## F Statistic  824.663*** (df = 1; 6578) 47.908*** (df = 1; 186) 482.412*** (df = 1; 6391)
## ========================================================================================
## Note:                                                        *p<0.1; **p<0.05; ***p<0.01
```
- Observe que:
    - as variáveis entram ns estimação sem nenhuma transformação as diferentes quantidades de observações e
    - cada método possui diferentes graus de liberdade


### Estimando _Within_ e _Between_ via MQO

Nós podemos construir as variáveis de média e de desvios de média diretamente no data frame e estimar o _between_ e _within_ via MQO


```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 4.2.3
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:plm':
## 
##     between, lag, lead
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
TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (indivíduo)
    mutate(
        ikn_bar = mean(ikn), # "transformação" between de ikn
        qn_bar = mean(qn), # "transformação" between de qn
        ikn_desv = ikn - ikn_bar, # "transformação" within de ikn
        qn_desv = qn - qn_bar # "transformação" within de qn
    ) %>% ungroup()

pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

Q.pooling_between = plm(ikn_bar ~ qn_bar, pTobinQ, model = "pooling")

summary(Q.pooling_between)$coef # between via MQO
```

```
##                Estimate   Std. Error   t-value Pr(>|t|)
## (Intercept) 0.156013534 0.0006527827 238.99764        0
## qn_bar      0.005184737 0.0001259600  41.16178        0
```

```r
summary(Q.between)$coef # between
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```
- Note que, embora as estimativas sejam as mesmas, acabamos subestimando os erros padrão e, portanto, superestimando os valores t.
- Ao estimar o _between_ via pooled MQO, ele não faz os ajustes dos graus de liberdade nas variâncias das estimativas
- Logo, vamos ajustar os graus de liberdade multiplicando a variância das estimativas por {{<math>}}$(NT - K - 1)${{</math>}} e dividindo por {{<math>}}$(N - K - 1)${{</math>}}

```r
std_error = summary(Q.pooling_between)$coef[, "Std. Error"]
variance = std_error^2
adj_variance = variance * (188*35 - 1 - 1) / (188 - 1 - 1)
adj_std_error = sqrt(adj_variance)
adj_std_error
```

```
##  (Intercept)       qn_bar 
## 0.0038820321 0.0007490711
```


### Efeitos Fixos da Estimação _Within_
- Para o estimador _within_, podemos usar a função `fixef()` para computar os efeitos individuais. É possível calcular 3 tipos por meio do argumento `type`:
    - `level`: valor padrão que retorna os interceptos individuais ({{<math>}}$\hat{\alpha} + \hat{u}_{i}${{</math>}})
    - `dfirst`: em desvios do 1º indivíduo ({{<math>}}$\hat{\alpha}${{</math>}} é o intercepto do 1º indivíduo)
    - `dmean`: em desvios da média de efeitos individuais ({{<math>}}$\hat{\alpha}${{</math>}} é a média)


```r
# 6 primeiros efeitos individuais de cada tipo
for (t in c("level", "dfirst", "dmean")) {
    print( head( fixef(Q.within, type=t) ) )
}
```

```
##      2824      6284      9158     13716     17372     19411 
## 0.1452896 0.1280547 0.2580836 0.1100110 0.1267251 0.1694891 
##        6284        9158       13716       17372       19411       19519 
## -0.01723488  0.11279400 -0.03527859 -0.01856442  0.02419952 -0.01038237 
##         2824         6284         9158        13716        17372        19411 
## -0.014213401 -0.031448285  0.098580596 -0.049491991 -0.032777823  0.009986116
```
- Note que, como o `dfirst` retorna valores em relação ao 1º indivíduo, este não aparece no output do `fixef()`, diferente dos demais.
- No caso linear, o estimador _within_ é equivalente à estimação por MQO com inclusão de dummies para cada indivíduo:

```r
# Estimando MQO com dummies individuais - factor() tranforma cusip em var. categ.
Q.dummies = lm(ikn ~ qn + factor(cusip), pTobinQ)

# Comparando as estimativas de qn
cbind(Q.within$coef, Q.dummies$coef["qn"])
```

```
##           [,1]        [,2]
## qn 0.003791948 0.003791948
```

```r
# Comparando efeitos fixos (dfirst) e dummies
cbind(head(fixef(Q.within, type="dfirst")),
      Q.dummies$coef[3:8])
```

```
##              [,1]        [,2]
## 6284  -0.01723488 -0.01723488
## 9158   0.11279400  0.11279400
## 13716 -0.03527859 -0.03527859
## 17372 -0.01856442 -0.01856442
## 19411  0.02419952  0.02419952
## 19519 -0.01038237 -0.01038237
```


</br>


#### Estimação Analítica _Between_

```r
data("TobinQ", package="pder")
TobinQ = TobinQ %>% mutate(constant = 1) # criando vetor de 1's

y = TobinQ %>% select(ikn) %>% as.matrix() # vetor y
X = TobinQ %>% select(qn) %>% as.matrix() # vetor X
Z = cbind(TobinQ$constant, X) # vetor \boldsymbol{X} = (iota, X)

N = TobinQ %>% select(cusip) %>% unique() %>% nrow()
T = TobinQ %>% select(year) %>% unique() %>% nrow()
iota_T = rep(1, T)

# Calculando matrizes de tranformação B e W
B = diag(N) %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = diag(N*T) - B
```


{{<math>}}$$ \hat{\boldsymbol{\gamma}} = (\hat{\alpha}, \hat{\boldsymbol{\beta}}) = (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{By}  $${{</math>}}


```r
# vetor de estimativas gamma_hat = (alpha, beta)
gamma_hat = solve(t(Z) %*% B %*% Z) %*% t(Z) %*% B %*% y
gamma_hat
```

```
##            ikn
##    0.156013534
## qn 0.005184737
```


{{<math>}}$$ \hat{\boldsymbol{y}} = \boldsymbol{X} \hat{\boldsymbol{\gamma}} \qquad \text{ e } \qquad  \hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}} $${{</math>}}

```r
# valores ajustados e erros
y_hat = Z %*% gamma_hat
e_hat = y - y_hat
```


{{<math>}}$$ \hat{\sigma}^2 = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{N-K-1} $${{</math>}}

```r
## Estimando variancia do termo de erro
sigma2_l = t(e_hat) %*% B %*% e_hat / (N - ncol(Z)) # N - K - 1 graus de liberdade!
sigma2_l
```

```
##            ikn
## ikn 0.07598735
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _between_ para {{<math>}}$N - K - 1${{</math>}} (ao invés de {{<math>}}$NT - K - 1${{</math>}})

{{<math>}}$$ \widehat{V}(\hat{\boldsymbol{\gamma}}) = \hat{\sigma}^2_l (\boldsymbol{X}'\boldsymbol{BX})^{-1} $${{</math>}}

```r
## Estimando a matriz de variancia/covariancia das estimativas gamma
vcov_hat = c(sigma2_l) * solve(t(Z) %*% B %*% Z)
vcov_hat
```

```
##                             qn
##     1.507017e-05 -1.405770e-06
## qn -1.405770e-06  5.611075e-07
```

```r
## Calculando erros padrao das estimativas gamma
std_error = sqrt(diag(vcov_hat)) # Raiz da diagonal da matriz de covariâncias

## Calculando estatisticas t das estimativas gamma
t_stat = gamma_hat / std_error

## Calculando p-valores das estimativas gamma
p_value = 2 * pt(q = -abs(t_stat), df = N - ncol(Z))  # N - K - 1 graus de liberdade!

## Organizando os resultados da regressao em uma matriz
results = cbind(gamma_hat, std_error, t_stat, p_value)

## Nomeando as colunas da matriz de resultados
colnames(results) = c('Estimate', 'Std. Error', 't stat', 'Pr(>|t|)')
results
```

```
##       Estimate   Std. Error    t stat     Pr(>|t|)
##    0.156013534 0.0038820321 40.188625 1.227764e-93
## qn 0.005184737 0.0007490711  6.921555 7.012814e-11
```

```r
summary(Q.between)$coef # comparando com estimado via plm()
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```


#### Estimação Analítica _Within_
(Exercício)

</br>

## Comparativo dos Estimadores


### MQGF: junção MQE e _Within_
- Combinação de MQE (Efeitos Aleatórios) e de _Within_ (Efeitos Fixos)
- Pode-se computar mais eficientemente por MQO, que necessita transformação das variáveis usando a matriz {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}}, tal que {{<math>}}$\boldsymbol{\Sigma}^{-0.5\prime}\boldsymbol{\Sigma}^{-0.5} = \boldsymbol{\Sigma}^{-1}${{</math>}}.
- Denotando {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5}y${{</math>}} e {{<math>}}$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5}Z${{</math>}}, o modelo com variáveis transformadas é dado por
{{<math>}}\begin{align*}
    \hat{\boldsymbol{\beta}} &= (Z' \boldsymbol{\Sigma}^{-1} Z)^{-1} (Z' \boldsymbol{\Sigma}^{-1} y) \tag{2.27} \\
    &= (Z' \boldsymbol{\Sigma}^{-0.5\prime} \boldsymbol{\Sigma}^{-0.5} Z)^{-1} (Z' \boldsymbol{\Sigma}^{-0.5}\boldsymbol{\Sigma}^{-0.5\prime} y) \\
    &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}} \tilde{\boldsymbol{y}}
\end{align*}{{</math>}}

Usando (2.29), {{<math>}}$p=-0.5${{</math>}} em (2.29), tem-se
{{<math>}}$$ \boldsymbol{\Sigma}^{-0.5} = \frac{1}{\sigma_\varepsilon} \boldsymbol{B} + \frac{1}{\sigma_v} \boldsymbol{W} $${{</math>}}

Essa transformação evidencia uma combinação linear entre as matrizes de transformação _between_ e _within_ ponderadas pelo inverso dos desvios padrão dos 2 componentes de erro ({{<math>}}$\sigma^2_v${{</math>}} e {{<math>}}$\sigma^2_u = (\sigma^2_v + \sigma^2_\varepsilon)/T${{</math>}})

Pré-multiplicando as variáveis por {{<math>}}$\sigma_v \boldsymbol{\Sigma}^{-0.5}${{</math>}} (ao invés de {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}} para simplificação e sem perda de generalidade), as covariadas transformadas para o indivíduo {{<math>}}$i${{</math>}} no tempo {{<math>}}$t${{</math>}} são dadas por:
{{<math>}}$$ \tilde{z}_{it}\ =\ \frac{\sigma_v}{\sigma_\varepsilon} \bar{z}_{i\cdot} + (z_{it} - \bar{z}_{i\cdot})\ =\ z_{it} + \left(1 - \frac{\sigma_v}{\sigma_\varepsilon} \right) \bar{z}_{i\cdot}\ \equiv\ z_{it} - \theta \bar{z}_{i\cdot} $${{</math>}}
em que
{{<math>}}$$ \theta\ \equiv\ 1 - \frac{\sigma_v}{\sigma_\varepsilon}\ \equiv\ 1 - \phi $${{</math>}}

    
Note que, quando:

- {{<math>}}$\theta \rightarrow 1${{</math>}}, os efeitos individuais {{<math>}}$\sigma_u${{</math>}} dominam {{<math>}}$\implies${{</math>}} MQGF se aproxima do estimador _within_; e
- {{<math>}}$\theta \rightarrow 0${{</math>}}, os efeitos individuais {{<math>}}$\sigma_u${{</math>}} somem {{<math>}}$\implies${{</math>}} MQGF se aproxima do pooled MQO



### Exemplo 1 - Retornando...


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimações MQGF
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "nerlove")

summary(Q.walhus) # output da estimação MQGF por Wallace e Hussain (1969)
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
Note que {{<math>}}$\theta = 73\%${{</math>}}, o que indica que, neste caso, o estimativa MQGF é mais próxima de _within_ ({{<math>}}$\theta=1${{</math>}}) do que de _between_ ({{<math>}}$\theta=0${{</math>}}). A grande quantidade de períodos ({{<math>}}$T = 35${{</math>}}) provavelmente influencia este alto valor.


{{<math>}}$\theta${{</math>}}'s:


```r
# Podemos visualizar o theta usando ercomp()$theta
ercomp(Q.walhus)$theta
```

```
##        id 
## 0.7342249
```

```r
# Criaremos uma lista com todos objetos de estimação MQGF
Q.models = list(walhus = Q.walhus, amemiya = Q.amemiya, ht = Q.ht,
                swar = Q.swar, nerlove = Q.nerlove)

# Aplicaremos sapply() com a lista criada e a função ercomp()
sapply(Q.models, function(model) ercomp(model)$theta)
```

```
##  walhus.id amemiya.id      ht.id    swar.id nerlove.id 
##  0.7342249  0.7361186  0.7361186  0.7350771  0.7489177
```


Observe que poderíamos ter obtido informações sobre as variâncias de covariadas por meio de `summary()` sobre uma variável no formato `pdata.frame`:

```r
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year")) # transf. em pdata.frame
summary(pTobinQ$qn) # resumo sobre variável qn
```

```
## total sum of squares: 314349.9 
##         id       time 
## 0.43080609 0.09393499 
## 
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -68.8663  -0.8254   0.3976   2.5053   2.9961  89.8933
```

Também é possível verificar o mesmo para a variância do erro na estimação em MQGF:

```r
ercomp(ikn ~ qn, TobinQ) # padrão method = "swar"
```

```
##                    var  std.dev share
## idiosyncratic 0.005333 0.073028 0.725
## individual    0.002019 0.044930 0.275
## theta: 0.7351
```


### Exemplo 2
- Seção 2.4.4 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Usado por Kinal e Lahiri (1993) 
- Queremos estabelecer relação entre importações (_imports_) e produto nacional (_gnp_)

```r
data("ForeignTrade", package = "pder")
FT = pdata.frame(ForeignTrade, index=c("country", "year"))

# Variâncias 
ercomp(imports ~ gnp, FT) # variância do erro na estimação MQGF
```

```
##                   var std.dev share
## idiosyncratic 0.08634 0.29383 0.074
## individual    1.07785 1.03820 0.926
## theta: 0.9423
```
- Variância do erro da estimação MQGF é dada por 93\% de variação inter-indivíduos
- O estimador MQGF remove grande parte da variação inter-indivíduos, pois subtrai, da covariada, 94\% da média individual:

{{<math>}}$$ \tilde{z}_{it}\ =\ z_{it} + \left(1 - \frac{\sigma_v}{\sigma_\varepsilon} \right) \bar{z}_{i\cdot}\ \equiv\ z_{it} - \theta \bar{z}_{i\cdot}\ =\ z_{it} - 0,94 \bar{z}_{i\cdot} $${{</math>}}


```r
# Estimações
models = c("within", "random", "pooling", "between")
sapply(models, function(x) round(
    coef(summary(plm(imports ~ gnp, FT, model=x)))["gnp",], 4))
```

```
##             within  random pooling between
## Estimate    0.9024  0.7682  0.0637  0.0487
## Std. Error  0.0346  0.0338  0.0168  0.0802
## t-value    26.0616 22.7595  3.7789  0.6076
## Pr(>|t|)    0.0000  0.0000  0.0002  0.5482
```

<center><img src="../example_panel-1.png"></center>

- MQGF e _within_ são bastante parecidos
- MQO, que considera variação inter-indivíduos, é parecido com _between_


</br>

## Estimador MV
- Seção 3.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Uma alternativa aos estimadores de MQGF é o de máxima verossimilhança (ML).
- Assume-se que a distribuição dos dois componentes de erro são normais:
{{<math>}}$$ u | X \sim N(0, \sigma^2_u) \quad \text{ e } \quad v | u, X \sim N(0, \sigma^2_v) $${{</math>}}

- O modelo a ser estimado é o
{{<math>}}$$ y_{it} = \alpha \boldsymbol{\iota} + \beta' x_i + u_i + v_{it} = \boldsymbol{\gamma}' z_i + u_i + v_{it} $${{</math>}}

- Ao invés de estimar {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}} para depois calcular {{<math>}}$\boldsymbol{\beta}${{</math>}}, ambos são estimados simultaneamente.

- Denotando 
{{<math>}}$\phi = \frac{\sigma_v}{\sigma_{l}},${{</math>}}
a função de log-verossimilhança para um painel balanceado é:

{{<math>}}$$ \ln{L} = -\frac{NT}{2} \ln{2\pi} - \frac{NT}{2}\ln{\sigma^2_v} + \frac{N}{2} \ln{\phi^2} - \frac{1}{2\sigma^2_v} \left( \varepsilon' \boldsymbol{W} \varepsilon + \phi^2 \varepsilon' \boldsymbol{B} \varepsilon \right) $${{</math>}}

Denotando 

{{<math>}}$$\tilde{\boldsymbol{X}}\ \equiv\ (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{X}\ =\ \boldsymbol{X} - \phi \boldsymbol{B} \boldsymbol{X}$${{</math>}}
e resolvendo as CPO's da log-verossimilhança, segue que:

{{<math>}}\begin{align*}
    \hat{\boldsymbol{\beta}} &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}'\tilde{\boldsymbol{y}} \tag{3.12} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}} + \hat{\phi}^2 \hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT} \tag{3.13} \\
    \hat{\phi}^2 &=\frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{(T-1) \hat{\boldsymbol{\varepsilon}}'\boldsymbol{B}\hat{\boldsymbol{\varepsilon}}} \tag{3.14}
\end{align*}{{</math>}}

A estimação pode ser feita iterativamente por FIML (Full Information Maximum Likelihood):


1. Chute inicial de {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} (por exemplo, estimativa _within_)
2. Calcular {{<math>}}$\hat{\phi}^2${{</math>}} usando (3.14)
3. Calcular {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} usando (3.12) 
4. Verificar convergência: se não convergiu, volta para o passo 2, usando o {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} calculado no passo 3.
5. Calcular {{<math>}}$\sigma^2_v${{</math>}} usando (3.13)


### Estimação MV via `pglm()`


```r
library(pglm)
library(dplyr)
data("TobinQ", package = "pder")

# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimação pooled MQO
Q.ml = pglm(ikn ~ qn, pTobinQ, family = "gaussian")
summary(Q.ml)
```

```
## --------------------------------------------
## Maximum Likelihood estimation
## Newton-Raphson maximisation, 3 iterations
## Return code 8: successive function values within relative tolerance limit (reltol)
## Log-Likelihood: 7632.794 
## 4  free parameters
## Estimates:
##              Estimate Std. error t value Pr(> t)    
## (Intercept) 0.1593280  0.0034344   46.39  <2e-16 ***
## qn          0.0038618  0.0001684   22.93  <2e-16 ***
## sd.id       0.0450737  0.0025011   18.02  <2e-16 ***
## sd.idios    0.0730233  0.0006452  113.17  <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## --------------------------------------------
```

```r
summary(Q.swar)$coef # Comparando com estimação MQGF-swar
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159326945 0.0034249012 46.52016  0.000000e+00
## qn          0.003862202 0.0001682634 22.95331 1.365529e-116
```
- Note que o resultado por ML foi bem próximo ao do obtido por MQGF


</br>

## Testes de Presença de Efeitos Individuais

### Breusch-Pagan

- Seção 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- É um teste baseado em multiplicadores de Lagrange (LM) nos resíduos de MQO, em que {{<math>}}$H_0: \sigma^2_u = 0${{</math>}} (ausência de efeitos individuais)
- A estatística teste é dada por 
{{<math>}}$$ LM_u = \frac{NT}{2(T-1)} \left( T \frac{\hat{\boldsymbol{\varepsilon}}' B_u \hat{\boldsymbol{\varepsilon}}}{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}} - 1 \right)^2  $${{</math>}}
que é assintoticamente distribuída como ua `\(\chi^2\)` com 1 grau de liberdade.
- Há algumas variações deste teste:
    - Breusch and Pagan (1980),
    - Gourieroux et al. (1982),
    - Honda (1985), e
    - King and Wu (1997).



### Testes F
- Seção 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Sejam a soma dos resíduos ao quadrado e os graus de liberdade do modelo _within_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W${{</math>}} e {{<math>}}$N(T-1) - K${{</math>}}, respectivamente.
- Sejam a soma dos resíduos ao quadrado e os graus de liberdade do modelo pooled MQO {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}}\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}} e {{<math>}}$NT - K - 1${{</math>}}, respectivamente.
- Sob hipótese nula de que não há efeitos individuais, a estatística teste é dada por
{{<math>}}$$ \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} - \hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W}{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_W} \frac{NT - K - N + 1}{N-1} $${{</math>}}
que segue uma distribuição F de Fisher-Snedecor com {{<math>}}$N-1${{</math>}} e {{<math>}}$NT - K - N + 1${{</math>}} graus de liberdade.


### Aplicando no R

```r
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

Q.within = plm(ikn ~ qn, pTobinQ, model = "within")
Q.gls = plm(ikn ~ qn, pTobinQ, model = "random")
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")

# Teste de Breusch-Pagan/LM
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
O teste LM (Breusch-Pagan) acusou efeitos individuais significativos.


```r
# Teste F
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
Assim como o teste LM, Pelo teste F, observam-se efeitos individuais significativos.


</br>

## Testes de Efeitos Correlacionados
- Seção 4.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Continuamos assumindo que {{<math>}}$E(v|X) = 0${{</math>}}, em que {{<math>}}$v${{</math>}} é o termo de erro idiossincrático.
- Nestes testes, verificamos se {{<math>}}$E(u|X) = 0${{</math>}}, ou seja, se os efeitos individuais são ou não são correlacionados com as covariadas.

### Teste de Hausman
- O princípio geral do teste de Hausman consiste em comparar dois modelos {{<math>}}$A${{</math>}}e {{<math>}}$B${{</math>}} tal que
    - sob {{<math>}}$H_0${{</math>}}: {{<math>}}$A${{</math>}} e {{<math>}}$B${{</math>}} são ambos consistentes, mas {{<math>}}$B${{</math>}} é mais eficiente que {{<math>}}$A${{</math>}}
    - sob {{<math>}}$H_1${{</math>}}: apenas {{<math>}}$A${{</math>}} é consistente
- Se {{<math>}}$H_0${{</math>}} é verdadeiro, então os coeficientes dos dois modelos não devem divergir.
- O teste é baseado em {{<math>}}$\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B${{</math>}} e Hausman mostrou que, sob {{<math>}}$H_0${{</math>}}, temos {{<math>}}$cov(\hat{\boldsymbol{\beta}}_A, \hat{\boldsymbol{\beta}}_B) = 0${{</math>}} e, logo, a variância dessa diferença é simplesmente {{<math>}}$V(\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B) = V(\hat{\boldsymbol{\beta}}_A) - V(\hat{\boldsymbol{\beta}}_B)${{</math>}}

- No contexto de dados em painéis, compara-se o estimador _within_ (efeitos fixos) e o de MQGF (efeitos aleatórios)
- Quando {{<math>}}$E(u|X) = 0${{</math>}} ambos estimadores são consistentes, ou seja,
{{<math>}}$$ \hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_W\ \overset{p}{\rightarrow}\ 0 $${{</math>}}
então é preferível usar o mais eficiente (MQGF, pois usa ambas variações inter e intra-indivíduos).

- Se {{<math>}}$E(u|X) \neq 0${{</math>}}, então {{<math>}}$\hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\neq 0${{</math>}} e apenas o modelo robusto a {{<math>}}$E(u|X) \neq 0${{</math>}} (_within_) é consistente.
- A variância é dada por 
{{<math>}}\begin{align*}
    V(\hat{q}) &= V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_W) = V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) + V(\hat{\boldsymbol{\beta}}_W) - 2 cov(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}, \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) \\
    &= \sigma^2_v (Z' \boldsymbol{W} Z)^{-1} - (Z'\boldsymbol{\Sigma}^{-1} Z)^{-1}
\end{align*}{{</math>}}
- Logo, a estatística teste se torna
{{<math>}}$$ \hat{q}'\ V(\hat{q})^{-1}\ \hat{q} $${{</math>}}
que, sob {{<math>}}$H_0${{</math>}}, é distribuida como {{<math>}}$\chi^2${{</math>}} com {{<math>}}$K${{</math>}} graus de liberdade.


```r
# Teste de Hausman
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
Não se rejeita a hipótese nula de que ambos modelos são consistentes a 5\%.


</br>


{{< cta cta_text="👉 Seguir para Manipulação de Dados em Painel" cta_link="../sec5" >}}

