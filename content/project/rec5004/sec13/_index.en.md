---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Panel Data
summary: This page includes a section on panel data estimation with R and provides examples of data structures and models. The content is based on the book ??oPanel Data Econometrics with R??? by Croissant & Millo (2018) and adapted from lecture notes on Econometrics I (2022).
title: Panel Data Estimation
weight: 13
output: md_document
type: book
---



## Grava��es REC2312

- **Monitoria 4**: Dados em Painel e Matriz de Covari�ncias dos Erros | [Script](https://fhnishida.netlify.app/project/rec2312/monitoria04.R)
    [<img src="https://img.youtube.com/vi/6hZqBAGTNTc/maxresdefault.jpg" alt="img" width=50%/>](https://www.youtube.com/watch?v=6hZqBAGTNTc)

- **Monitoria 5**: Estima��o da Matriz de Covari�ncias dos Erros e Estimador de MQE | [Script](https://fhnishida.netlify.app/project/rec2312/monitoria05.R)
[<img src="https://img.youtube.com/vi/uxEXcGDL_zM/maxresdefault.jpg" alt="img" width=50%/>](https://www.youtube.com/watch?v=uxEXcGDL_zM)

- **Monitoria 6**: Estimador de MQGF | [Script](https://fhnishida.netlify.app/project/rec2312/monitoria06.R)
[<img src="https://img.youtube.com/vi/G-1AVqDQBqY/maxresdefault.jpg" alt="img" width=50%/>](https://www.youtube.com/watch?v=G-1AVqDQBqY)

- **Monitoria 7**: Matrizes de Transforma��o e Estimador Between | [Script](https://fhnishida.netlify.app/project/rec2312/monitoria07.R)
[<img src="https://img.youtube.com/vi/kh69ZHE8DNY/maxresdefault.jpg" alt="img" width=50%/>](https://www.youtube.com/watch?v=kh69ZHE8DNY)

- **Monitoria 8**: Estimadores Within e de Primeiras Diferen�as | [Script](https://fhnishida.netlify.app/project/rec2312/monitoria08.R)
[<img src="https://img.youtube.com/vi/KbOV12t_Ki0/maxresdefault.jpg" alt="img" width=50%/>](https://www.youtube.com/watch?v=KbOV12t_Ki0)



## Estrutura dos Dados

- Se��o 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- A maioria das nota��es foram adaptadas de acordo com as notas de aula de Econometria I.


### Corte Transversal
At� agora, utilizamos bases de dados em corte transversal (ou _cross-section_, em ingl�s), ou seja, em que cada linha representava um indiv�duo {{<math>}}$i  = 1, ..., N${{</math>}} e observamos as realiza��es da vari�vel dependente {{<math>}}$y${{</math>}} e das vari�veis explicativas {{<math>}}$k = 1, 2, ..., K${{</math>}}:

<img src="../data_crosssection.png" alt="">


#### Exemplo
Considerando {{<math>}}$N = 4${{</math>}} indiv�duos e {{<math>}}$K = 2${{</math>}} covariadas, segue o exemplo:

<img src="../data_crosssection_example.png" alt="">



### Painel
Tamb�m � comum utilizarmos dados em painel, isto �, uma base de dados em que observamos os indiv�duos {{<math>}}$i = 1, ..., N${{</math>}} nos {{<math>}}$t = 1, ..., T${{</math>}} per�odos.

Este tipo de estrutura de dado permite, al�m de fazer compara��es inter-indiv�duos (_between_), avaliar diferen�as intra-indiv�duos (_within_) a partir das varia��es ocorridas ao longo do tempo para um mesmo indiv�duo.

Por simplicidade, consideramos que todos indiv�duos possuem {{<math>}}$T${{</math>}} observa��es ao longo do tempo (**painel balanceado**). Al�m disso, dados em painel podem estar dispostos de duas formas: longa ou curta.


##### Painel longo (_long_, em ingl�s)
Aqui, cada indiv�duo aparece em {{<math>}}$T${{</math>}} linhas. Cada observa��o � indicada pela dupla {{<math>}}$i${{</math>}} e {{<math>}}$t${{</math>}} (vari�veis-chave da base de dados). Essa � a forma padr�o utilizada em Econometria.

<img src="../data_panellong.png" alt="">


##### Painel curto (_wide_, em ingl�s)
Na forma curta, as informa��es das vari�veis dependentes e independentes aparecem repetidamente por {{<math>}}$T${{</math>}} vezes, sendo que cada repeti��o corresponde a um dos {{<math>}}$T${{</math>}} per�odos:

<img src="../data_panelwide.png" alt="">



#### Exemplos
Como exemplo, consideramos {{<math>}}$N = 4${{</math>}} indiv�duos e {{<math>}}$K = 2${{</math>}} covariadas e {{<math>}}$T = 2${{</math>}} per�odos. As bases de dados em paineis longo e curto, respectivamente, teriam as seguintes estruturas:

<img src="../data_panellong_example.png" alt="">

<img src="../data_panelwide_example.png" alt="">



## Modelo em Painel

Para a observa��o do indiv�duo {{<math>}}$i \in \{1, ..., N\}${{</math>}} no per�odo {{<math>}}$t \in \{1, ..., T\}${{</math>}}, podemos escrever o modelo como:

{{<math>}}$$ y_{it} = \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{1} $$ {{</math>}}
em que {{<math>}}$\boldsymbol{\beta}${{</math>}} � um vetor-coluna de {{<math>}}$K${{</math>}} par�metros

{{<math>}}$$ \boldsymbol{\beta} = \left[ \begin{array}{c} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_K \end{array} \right], $${{</math>}}

{{<math>}}$y_{it}${{</math>}} � a vari�vel dependente, {{<math>}}$\boldsymbol{x}'_{it}${{</math>}} � o vetor-linha de dimens�o {{<math>}}$K+1${{</math>}}:

{{<math>}}$$ \boldsymbol{x}'_{it} = \left[ \begin{array}{c} 1 & x^1_{it} & x^2_{it} & \cdots & x^K_{it} \end{array} \right],  $${{</math>}}

e o erro {{<math>}}$\varepsilon_{it}${{</math>}} pode ser escrito como:

{{<math>}}$$ \varepsilon_{it} = u_i + v_{it},  $${{</math>}}
sendo {{<math>}}$u_i${{</math>}} o erro individual para o indiv�duo {{<math>}}$i${{</math>}} e {{<math>}}$v_{it}${{</math>}} � o erro idiossincr�tico (residual).

Empilhando as equa��es (1) para todo indiv�duo {{<math>}}$i = 1, 2, ..., N${{</math>}} e todo per�odo {{<math>}}$t = 1, 2, ..., T ${{</math>}}, temos

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
As linhas horizontais foram inseridas apenas para facilitar a visualiza��o dos valores referentes a cada indiv�duo {{<math>}}$i${{</math>}}.


</br>

## Matriz de Vari�ncias-Covari�ncias dos Erros
- Se��o 2.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

A Matriz de Vari�ncias-Covari�ncias dos Erros relaciona um termo de erro, {{<math>}}$\varepsilon_{it}${{</math>}}, com todos os demais termos de erro {{<math>}}$\varepsilon_{js}${{</math>}}, para todo {{<math>}}$j = 1, ..., N${{</math>}} e todo {{<math>}}$a = 1, ..., T${{</math>}}.

Na matriz de covari�ncia de erro, cada linha representa um {{<math>}}$\varepsilon_{it}${{</math>}} e cada coluna representa um {{<math>}}$\varepsilon_{jt}${{</math>}}. Seus elementos representam a covari�ncia entre 
{{<math>}}$\varepsilon_{it}${{</math>}} e {{<math>}}$\varepsilon_{jt}${{</math>}}, sendo que pode haver {{<math>}}$\varepsilon_{it} = \varepsilon_{jt}${{</math>}} (que, neste caso, torna-se vari�ncia):

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

Note que a Matriz de Vari�ncias-Covari�ncias dos Erros possui matrizes menores que relacionam os erros do indiv�duo {{<math>}}$i${{</math>}} (linha) e do indiv�duo {{<math>}}$j${{</math>}} (coluna). Para escrever mais facilmente {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, podemos preench�-la com matrizes menores de {{<math>}}$\boldsymbol{\Sigma}_{ij}${{</math>}}:


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


Como assumimos amostragem aleat�ria em que a covari�ncia entre dois indiv�duos distintos {{<math>}}($i \neq j$){{</math>}} �  
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

Assumimos tamb�m que a Matriz de Vari�ncias-Covari�ncias dos Erros do indiv�duo {{<math>}}$i${{</math>}} depende apenas dos par�metros {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}}, j� que:

- Vari�ncia de um erro: {{<math>}}$ var(\varepsilon_{it}) = \sigma^2_u + \sigma^2_v ${{</math>}}
- Covari�ncia de dois erros de um mesmo indiv�duo {{<math>}}$i${{</math>}} em dois per�odos  {{<math>}}$t \neq s${{</math>}}: {{<math>}}$ cov(\varepsilon_{it}, \varepsilon_{is}) = \sigma^2_u ${{</math>}}

Substituindo em (2), segue que

{{<math>}}$$ \underset{T \times T}{\boldsymbol{\Sigma}_i} = \left[ \begin{array}{cccc} 
\sigma^2_u + \sigma^2_v & \sigma^2_u & \cdots & \sigma^2_u \\
\sigma^2_u & \sigma^2_u + \sigma^2_v & \cdots & \sigma^2_u \\
\vdots & \vdots & \ddots & \vdots \\
\sigma^2_u & \sigma^2_u & \cdots & \sigma^2_u + \sigma^2_v
\end{array} \right] \tag{2'} $${{</math>}}


##### Exemplo
Por simplicidade, considere que {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}. Logo, a Matriz de Vari�ncias-Covari�ncias dos Erros pode ser escrita como;

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

Note que acima foram utilizadas linhas verticais e horizontais apenas para facilitar a visualiza��o dos elementos que substitu�ram cada matriz.


#### Calculando no R

Primeiro, denote {{<math>}}$I_p${{</math>}} a matriz identidade de dimens�o {{<math>}}$p \times p${{</math>}}:

{{<math>}}$$ \boldsymbol{I}_p= \left[ \begin{array}{cccc}
    1 & 0 & 0 & \cdots & 0 \\
    0 & 1 & 0 & \cdots & 0 \\
    0 & 0 & 1 & \cdots & 0 \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    0 & 0 & 0 & \cdots & 1
\end{array} \right]_{p \times p}, $$ {{</math>}}

e considere {{<math>}}$\boldsymbol{\iota}_q${{</math>}} um vetor-coluna de 1's de tamanho {{<math>}}$q${{</math>}}:
{{<math>}}$$ \boldsymbol{\iota}_q = \left[ \begin{array}{c} 1 \\ 1 \\ \vdots \\ 1 \end{array} \right]_{q \times 1} $${{</math>}}


Com dados em **corte transversal**, era f�cil calcular a Matriz de Vari�ncias-Covari�ncias dos Erros, pois s� havia um termo de erro e, portanto, t�nhamos {{<math>}}$\sigma^2${{</math>}} apenas na diagonal principal:

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


Agora, para **dados em painel**, como visto acima, possu�mos duas vari�ncias de termos de erro, sendo que {{<math>}}$\sigma^2_v${{</math>}} aparece na diagonal principal, cujos elementos (e seus "vizinhos") precisam ser somados por {{<math>}}$\sigma^2_u${{</math>}}. Logo, a Matriz de Vari�ncias-Covari�ncias dos Erros com dados em painel pode ser escrita na forma matricial como:

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


Agora, "s�" precisamos somar {{<math>}}$\sigma^2_u${{</math>}} "na proximidade" dessa diagonal.

Por enquanto, vamos ignorar {{<math>}}$T \sigma^2_u${{</math>}} e vamos chamar a parte entre colchetes de matriz de transforma��o **inter-indiv�duos (_between_)**:

{{<math>}}$$ \boldsymbol{B}\ \equiv\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}

Note que a matriz {{<math>}}$\boldsymbol{B}${{</math>}} � chamada de  {{<math>}}$\boldsymbol{N}${{</math>}} nas notas de aula de Econometria II (2021) do prof. Daniel.

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

em que {{<math>}}$\otimes${{</math>}} � o produto de Kronecker. Agora, ao multiplicar por {{<math>}}$T \sigma^2_u${{</math>}}, todos elementos {{<math>}}$1/T${{</math>}} tornam-se {{<math>}}$\sigma^2_u${{</math>}}:

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


Somando os dois termos de (4), conseguimos obter a Matriz de Vari�ncias-Covari�ncias dos Erros:

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
Considere o caso com {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}. Vamos, ent�o, obter a seguinte Matriz de Vari�ncias-Covari�ncias dos Erros:

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
N = 2 # n�mero de indiv�duos
T = 3 # n�meros de per�odos
sig2u = 2 # vari�ncia do termo de erro do indiv�duo
sig2v = 3 # vari�ncia do termo de erro idiossincr�tico 
```


O primeiro termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}} �

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

Para o 2� termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, temos que criar a matriz identidade e o vetor de 1's primeiro:

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
iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T) # pr� e p�s-multiplicar por iotas
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

Multiplicando {{<math>}}$\boldsymbol{B}${{</math>}} por {{<math>}}$T \sigma^2_u${{</math>}}, obtemos o 2� termo de {{<math>}}$\boldsymbol{\Sigma}${{</math>}}:

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

Ent�o, a Matriz de Vari�ncias-Covari�ncias dos Erros � dada por:

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




### Estima��o dos Componentes de Erro
- Note que n�o temos {{<math>}}$\sigma^2_v${{</math>}} e {{<math>}}$\sigma^2_u${{</math>}} e, logo, {{<math>}}$\boldsymbol{\Sigma}${{</math>}} � desconhecido.

- Primeiro, considere a **matriz de transforma��o _within_**, dada por

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
em que {{<math>}}$p${{</math>}} � um escalar.
- Essa f�rmula ser� importante para calcularmos {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-1}${{</math>}} ou {{<math>}}$ \hat{\boldsymbol{\Sigma}}^{-0,5}${{</math>}} mais adiante.


</br>

- Se {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} fosse conhecido, ent�o poder�amos estimar as duas vari�ncias usando:

{{<math>}}\begin{align}
    \hat{\sigma}^2_v &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{W} \boldsymbol{\varepsilon}}{N(T-1)} \tag{2.35} \\
    \\
    \hat{\sigma}^2_v + T \hat{\sigma}^2_u &= \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} \tag{2.34} \\
    \hat{\sigma}^2_u &= \frac{1}{T} \left( \frac{\boldsymbol{\varepsilon}' \boldsymbol{B} \boldsymbol{\varepsilon}}{N} - \hat{\sigma}^2_v \right)
\end{align}{{</math>}}

- Como {{<math>}}$\boldsymbol{\varepsilon}${{</math>}} � desconhecido, ent�o podemos usar res�duos de estimadores consistentes em seu lugar.

- **Wallace e Hussain (1969)**: usam res�duos MQO

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} 
    \quad \text{ e } \quad 
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}

- **Amemiya (1971)**: usa res�duos _within_
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1)}
    \quad \text{ e } \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Hausman e Taylor (1981)**: propuseram ajuste ao m�todo de Amemiya (1971), em que {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}${{</math>}} s�o regredidos em todas vari�veis invariantes no tempo no modelo e s�o utilizados os res�duos dessa regress�o, {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{HT}}${{</math>}}.

- **Swamy e Arora (1972)**: usam res�duos _between_ e _within_ para calcular:
{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{N(T-1) - K}
    \quad \text{ e } \quad
    \hat{\sigma}^2_u = \frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{B}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}}{N - K - 1} - \hat{\sigma}^2_v \right)$${{</math>}}
    
- **Nerlove (1971)**: computa {{<math>}}$\sigma^2_u${{</math>}} emp�rica dos efeitos fixos do modelo _within_

{{<math>}}\begin{align}
    \hat{u}_i &= \bar{y}_{i\cdot} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\bar{x}_{i\cdot} \\
    \hat{\sigma}^2_u &= \sum^N_{i=1}{(\hat{u}_i - \bar{\hat{u}}) / (N-1)} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{NT}
\end{align}{{</math>}}


Ap�s obter {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}}, s� precisamos calcular {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}:



</br>

<!-- ## Estimadores MQO em painel -->
<!-- - Supomos que ambos componentes de erros s�o n�o-correlacionados com as covariadas: -->
<!-- {{<math>}}$$ E(u|X) = E(v|X) = 0 $${{</math>}} -->
<!-- - A variabilidade em um painel tem 2 componentes: -->
<!--     - a _between_ ou inter-indiv�duos, em que a variabilidade das vari�veis s�o mensuradas em m�dias individuais, como {{<math>}}$\bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$BZ${{</math>}} -->
<!--     - a _within_ ou intra-indiv�duos, em que a variabilidade das vari�veis s�o mensuradas em desvios das m�dias individuais, como {{<math>}}$z_{it} - \bar{z}_i${{</math>}} ou na forma matricial {{<math>}}$\boldsymbol{WX} = \boldsymbol{X} - \boldsymbol{BX}${{</math>}} -->
<!--     - Lembre-se que {{<math>}}$\boldsymbol{X} \equiv (\boldsymbol{\iota}, X)${{</math>}} -->
<!-- - H� tr�s estimadores por MQO que podem ser utilizados: -->
<!--     1. *M�nimos Quadrados Empilhados (MQE)*: usando a base de dados bruta (empilhada) -->
<!--     2. *Estimador Between*: usando as m�dias individuais -->
<!--     3. *Estimador Within (Efeitos Fixos)*: usando os desvios das m�dias individuais -->



## Estimador MQE
- Se��o 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- M�nimos Quadrados Empilhados (MQE) faz a estima��o igual ao MQO, por�m a infer�ncia considera {{<math>}}$\boldsymbol{\Sigma} \neq \sigma^2 \boldsymbol{I}${{</math>}}, considera correla��o entre as observa��es de um mesmo indiv�duo {{<math>}}$i${{</math>}}.


O modelo a ser estimado �
{{<math>}}$$ \boldsymbol{y} = \boldsymbol{X\beta} + \boldsymbol{\varepsilon} $${{</math>}}


- O estimador {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} de MQE (igual ao de MQO) � dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}} = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{y} $${{</math>}}

- Note que a Matriz de Vari�ncias-Covari�ncias do Estimador de MQO, que sup�e {{<math>}}$ \boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I} ${{</math>}}, simplifica para:

{{<math>}}\begin{align} V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}) 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\ 
&= (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \left[ \sigma^2 \boldsymbol{I} \right] \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \sigma^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} \\
&= \hat{\sigma}^2 (\boldsymbol{X}'\boldsymbol{X})^{-1} \end{align}{{</math>}}


- A Matriz de Vari�ncias-Covari�ncias do Estimador de MQE, que considera a correla��o entre observa��es de um mesmo indiv�duo, � dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQE}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


### Estima��o via `plm()`
Para ilustrar as estima��es MQO dos estimadores vistos anteriormente, usaremos a base de dados `TobinQ` do pacote `pder`, que conta com dados de 188 firmas por 35 anos (6580 observa��es).

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
- `qn`: Q de Tobin (raz�o entre valor da firma e o custo de reposi��o de seu capital f�sico). Se {{<math>}}$Q > 1${{</math>}}, ent�o o lucro do investimento � maior do que seu custo.

Queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta_1 + \varepsilon $${{</math>}}


Usaremos a fun��o `plm()` (do pacote de mesmo nome) para estimar modelos lineares em dados em painel. Seus principais argumentos s�o:

- `formula`: equa��o do modelo
- `data`: base de dados em `data.frame` (precisa preencher `index`) ou `pdata.frame` (formato pr�prio do pacote que j� indexa as colunas de indiv�duos e de tempo)
- `model`: estimador a ser computado 'pooling' (MQE), 'between', 'within' (Efeitos Fixos) ou 'random' (Efeitos Aleat�rios/MQGF)
- `index`: vetor de nomes das colunas dos identificadores de indiv�duo e de tempo

Note que a estima��o do MQE (_pooled_) via `plm()`, faz a estima��o considerando {{<math>}}$\boldsymbol{\Sigma} = \sigma^2 \boldsymbol{I}${{</math>}} e, portanto, estar� erroneamente desconsiderando as correla��es entre erros de um mesmo indiv�duo:


```r
library(plm)

# Transformando no formato pdata frame, com indentificador de indiv�duo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��o MQO
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")
Q.ols = lm(ikn ~ qn, TobinQ)

# Comparando ambos outputs
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


- Precisamos fazer a infer�ncia considerando uma Matriz de Vari�ncias-Covari�ncias dos Erros apropriada. Para isto, vamos usar o argumento `vcov=vcovBK` dentro da fun��o `summary()`:

```r
# Estima��o MQE - matriz de var-cov dos erros com correla��o intra-indiv
summary(Q.pooling, vcov=vcovBK)$coef
```

```
##               Estimate   Std. Error  t-value     Pr(>|t|)
## (Intercept) 0.15799969 0.0034686968 45.55016 0.000000e+00
## qn          0.00439197 0.0003774606 11.63557 5.458161e-31
```



### Estima��o Anal�tica
A estima��o anal�tica do MQE � equivalente ao MQO vista anteriormente, mas no contexto de dados em painel. As principais diferen�as s�o: o n�mero de graus de liberdade � {{<math>}}$NT - K - 1${{</math>}} (pois possui {{<math>}}$NT${{</math>}} observa��es) e a modelagem da matriz de vari�ncias-covari�ncias dos erros, {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, para o contexto de painel.

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
N # n� de indiv�duos i
```

```
## [1] 188
```

```r
T = length( unique(TobinQ$year) )
T # n� de per�odos t
```

```
## [1] 35
```

```r
K = ncol(X) - 1
K # n� de covariadas
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

d) Res�duos {{<math>}}$\hat{\boldsymbol{\varepsilon}}${{</math>}}

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

e) Vari�ncias dos termos de erro

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Como {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}} s�o escalares, � conveniente transformar as "matrizes 1x1" em n�meros usando `as.numeric()`:

```r
# Criando matrizes between e within
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
I_NT = diag(N*T) # matriz identidade de tamanho NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Calculando vari�ncias dos termos de erro (Wallace & Hussain)
sig2v = as.numeric( (t(ehat) %*% W %*% ehat) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat) %*% B %*% ehat)/N - sig2v ) )
```


f) Matriz de Vari�ncias-Covari�ncias dos Erros
{{<math>}}$$\hat{\boldsymbol{\Sigma}} = \hat{\sigma}^2_v \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u) \boldsymbol{B}$${{</math>}}


```r
# Calculando a Matriz de Vari�ncias-Covari�ncias dos Erros
Sigma = sig2v * W + (sig2v + T*sig2u) * B
```



g) Matriz de Vari�ncias-Covari�ncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}) = (\boldsymbol{X}'\boldsymbol{X})^{-1} \boldsymbol{X}' \hat{\boldsymbol{\Sigma}} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{X})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
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


h) Erros-padr�o do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034936352 0.0003366365
```

i) Estat�stica _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_bhat = bhat / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 45.22501
## [2,] 13.04663
```

j) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


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

- Se��o 2.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Tamb�m conhecido como **estimador de efeitos aleat�rios**, pois considera que os efeitos individuais s�o aleat�rios: {{<math>}}$E(\boldsymbol{u}) = 0${{</math>}}
- Erros s�o relacionados pela Matriz de Vari�ncias-Covari�ncias dos Erros {{<math>}}$\boldsymbol{\Sigma}${{</math>}}.
- O estimador de MQGF � dado por
{{<math>}}$$ {\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} = (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' {\boldsymbol{\Sigma}}^{-1} \boldsymbol{y}) \tag{2.27} $${{</math>}}

- A matriz de vari�ncias-covari�ncias do estimador � dada por
{{<math>}}$$ V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \tag{2.28} $${{</math>}}
- A matriz {{<math>}}$\boldsymbol{\Sigma}${{</math>}} depende apenas de dois par�metros: {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}}, temos:
{{<math>}}$$ \boldsymbol{\Sigma}^p = ({\sigma}^2_v)^p \boldsymbol{W} + ({\sigma}^2_v + T {\sigma}^2_u)^p \boldsymbol{B} \tag{2.29} $${{</math>}}

</br>

- Como desconhecemos {{<math>}}$\boldsymbol{\Sigma}${{</math>}}, podemos calcular {{<math>}}$\boldsymbol{\hat{\Sigma}}${{</math>}} por meio da estima��o dos componentes de erro usando, por exemplo, Wallace e Hussain (1969):

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} 
    \quad \text{ e } \quad 
    \hat{\sigma}^2_u =\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right)$${{</math>}}



### Estima��o via `plm()`
- Usaremos novamente a fun��o `plm()`, mas definiremos `model = random` para que seja estimado via MQGF
- em `random.method` podemos escolher o m�todo de c�lculo dos par�metros de erro:
    1. `"walhus"` para Wallace e Hussain (1969)
    2. `"amemiya"` para Amemiya (1971)
    3. `"ht"` para Hausman e Taylor (1981)
    4. `"swar"` para Swamy e Arora (1972) [padr�o]
    5. `"nerlove"` para Nerlove (1971)


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��es MQGF
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "nerlove")

# Resumindo 5 estima��es em �nica tabela
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

Neste caso espec�fico, os resultados s�o praticamente id�nticos.



### Estima��o Anal�tica
- Aqui, faremos a estima��o anal�tica do MQGF usando o m�todo de Wallace e Hussain (1969).
- Primeiro, precisamos encontrar {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}${{</math>}} e {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}, para estimar {{<math>}}$\hat{\sigma}^2_{u}${{</math>}}, {{<math>}}$\hat{\sigma}^2_{v}${{</math>}} e {{<math>}}$\hat{\boldsymbol{\Sigma}}${{</math>}}
- Depois, fazemos a estima��o de {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}} e de {{<math>}}$V_{\hat{\boldsymbol{\beta}}_{\tiny{MQGF}}}${{</math>}}


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
bhat_OLS = solve( t(X) %*% X ) %*% t(X) %*% y
```

c) Valores ajustados/preditos de MQO {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
yhat_OLS = X %*% bhat_OLS
```

d) Res�duos de MQO {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
ehat_OLS = y - yhat_OLS
```

e) Vari�ncias dos termos de erro

{{<math>}}\begin{align} \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N(T-1)} \\
    \hat{\sigma}^2_u &=\frac{1}{T} \left( \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N} - \hat{\sigma}^2_v \right) \end{align}{{</math>}}

Como {{<math>}}$\hat{\sigma}^2_u${{</math>}} e {{<math>}}$\hat{\sigma}^2_v${{</math>}} s�o escalares, � conveniente transformar as "matrizes 1x1" em n�meros usando `as.numeric()`:

```r
# Criando matrizes between e within
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
I_NT = diag(N*T) # matriz identidade de tamanho NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Calculando vari�ncias dos termos de erro (Wallace & Hussain)
sig2v = as.numeric( (t(ehat_OLS) %*% W %*% ehat_OLS) / (N*(T-1)) )
sig2u = as.numeric( (1/T) * ( (t(ehat_OLS) %*% B %*% ehat_OLS)/N - sig2v ) )
```


f) Matriz de Vari�ncias-Covari�ncias dos Erros

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Calculando a Matriz de Vari�ncias-Covari�ncias dos Erros
Sigma = sig2v * W + (sig2v + T*sig2u) * B

# Inversa da Matriz
Sigma_1 = sig2v^(-1) * W + (sig2v + T*sig2u)^(-1) * B
```

*Note que usar `solve()` na matriz `Sigma` demora mais tempo de processamento do que usar a f�rmula


g) Estimativas de MQGF {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} $${{</math>}}

```r
bhat_FGLS = solve( t(X) %*% Sigma_1 %*% X ) %*% t(X) %*% Sigma_1 %*% y
bhat_FGLS
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```


h) Matriz de Vari�ncias-Covari�ncias do Estimador

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) = (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vbhat = solve( t(X) %*% Sigma_1 %*% X )
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.167208e-05 -7.100808e-08
## [2,] -7.100808e-08  2.834259e-08
```


i) Erros-padr�o do estimador {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_bhat = sqrt( diag(Vbhat) )
se_bhat
```

```
## [1] 0.0034164422 0.0001683526
```

j) Estat�stica _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_bhat = bhat_FGLS / se_bhat
t_bhat
```

```
##          [,1]
## [1,] 46.63503
## [2,] 22.94370
```

k) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(NT-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


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

l) Tabela-resumo

```r
cbind(bhat_FGLS, se_bhat, t_bhat, p_bhat) # resultado MQE correto
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



#### Transformando e estimando por MQO
Al�m da forma mostrada anteriormente, podemos tamb�m transformar as vari�veis e resolver por MQO, pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{\Sigma}^{-0.5}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}$${{</math>}}

f') Matriz de Vari�ncias-Covari�ncias dos Erros

{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B} $${{</math>}}


```r
# Matriz de Vari�ncias-Covari�ncias dos Erros ^ (-0.5)
Sigma_05 = sig2v^(-0.5) * W + (sig2v + T*sig2u)^(-0.5) * B

# Vari�veis transformadas
X_til = Sigma_05 %*% X
y_til = Sigma_05 %*% y
```


g') Estimativas de MQGF via MQO

{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= (\boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} \boldsymbol{X}' \boldsymbol{\Sigma}'^{-0.5} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{y} \\
&= ([\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}])^{-1} [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{X}]' [\boldsymbol{\Sigma}^{-0.5} \boldsymbol{y}] \\
&\equiv (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}}= \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}}
\end{align}{{</math>}}

Note que {{<math>}}$\boldsymbol{\Sigma}'^{-0.5} = \boldsymbol{\Sigma}^{-0.5}${{</math>}}.


```r
bhat_OLS = solve( t(X_til) %*% X_til ) %*% t(X_til) %*% y_til
bhat_OLS
```

```
##             [,1]
## [1,] 0.159325869
## [2,] 0.003862631
```

h') Valores Ajustados e Res�duos MQO
{{<math>}}$$\tilde{\hat{y}} = \tilde{\boldsymbol{X}} \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}} \qquad \text{e} \qquad  \tilde{\hat{\boldsymbol{\varepsilon}}} = \boldsymbol{y} - \tilde{\hat{y}} $${{</math>}}


```r
yhat_OLS = X_til %*% bhat_OLS # Valores Ajustados
ehat_OLS = y_til - yhat_OLS # Res�duos
```


i') Vari�ncia do termo de erro MQO
{{<math>}}$$\hat{\sigma}^2 =  \frac{\tilde{\hat{\boldsymbol{\varepsilon}}}'\tilde{\hat{\boldsymbol{\varepsilon}}}}{NT - K - 1} $${{</math>}}

```r
sig2hat = as.numeric( t(ehat_OLS) %*% ehat_OLS / (N*T - K - 1) )
```


j') Matriz de Vari�ncias-Covari�ncias dos Erros MQO
{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
Vbhat_OLS = sig2hat * solve(t(X_til) %*% X_til)
Vbhat_OLS
```

```
##               [,1]          [,2]
## [1,]  1.165808e-05 -7.092295e-08
## [2,] -7.092295e-08  2.830861e-08
```


k') Erro Padr�o das Estimativas, Estat�stica t e P-valor

```r
se_bhat_OLS = sqrt( diag(Vbhat_OLS) )
t_bhat_OLS = bhat_OLS / se_bhat_OLS
p_bhat_OLS = 2 * pt(-abs(t_bhat_OLS), N*T-K-1)
```

l') Comparativo

```r
# MQGF via MQO Anal�tico
cbind(bhat_OLS, se_bhat_OLS, t_bhat_OLS, p_bhat_OLS)
```

```
##                   se_bhat_OLS                       
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

## Matrizes de Transforma��o
- Se��o 2.1.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)


### Modelo em Painel (2)

- Agora, iremos diferenciar as vari�veis explicativas invariantes no tempo das variantes no tempo.
- Considere que, das {{<math>}}$K${{</math>}} vari�veis explicativas, temos {{<math>}}$J${{</math>}} vari�veis invariantes no tempo e {{<math>}}$L${{</math>}} s�o variantes no tempo:

O modelo (1) �:
{{<math>}}\begin{align} y_{it} &= \boldsymbol{x}'_{it} \boldsymbol{\beta} + \varepsilon_{it} \tag{1} \\
&= 1.\beta_0 + x^1_{it} \beta_1 + ... + x^J_{it} \beta_J + x^{J+1}_{it} \beta_{J+1} + ... + x^K_{it} \beta_K + \varepsilon_{it} \end{align}{{</math>}}
e pode ser reescrito como:
{{<math>}}\begin{align} y_{it} &= \boldsymbol{x}'_{i} \boldsymbol{\Gamma} + \boldsymbol{x}^{*\prime}_{it} \boldsymbol{\delta} + \varepsilon_{it} \tag{2} \\
&= 1.\Gamma_0 + x^1_{i} \Gamma_1 + ... + x^J_{i} \Gamma_J + x^{*1}_{it} \delta_{1} + ... + x^{*L}_{it} \delta_L + \varepsilon_{it} \end{align}{{</math>}}
em que:

- {{<math>}}$\boldsymbol{x}'_{it} = [\boldsymbol{x}'_{i}, \boldsymbol{x}^{*\prime}_{it}] ${{</math>}}

- {{<math>}}$\boldsymbol{x}'_{i}${{</math>}} s�o as realiza��es das {{<math>}}$J${{</math>}} vari�veis invariantes no tempo, junto de 1:
{{<math>}}$$ \boldsymbol{x}'_{i} = \begin{bmatrix} 1 & x^1_i & x^2_i & \cdots & x^J_i \end{bmatrix}  $${{</math>}}

- {{<math>}}$\boldsymbol{x}^{*\prime}_{it}${{</math>}} s�o as realiza��es das {{<math>}}$L${{</math>}} vari�veis variantes no tempo:
{{<math>}}$$ \boldsymbol{x}^{*\prime}_{it} = \begin{bmatrix} x^{*1}_{it} & x^{*2}_{it} & \cdots & x^{*L}_{it} \end{bmatrix} $${{</math>}}

- {{<math>}}$\varepsilon_{it} = u_i + v_{it}${{</math>}}.
- {{<math>}}$\boldsymbol{\Gamma}${{</math>}} e {{<math>}}$\boldsymbol{\delta}${{</math>}} s�o, respectivamente, os par�metros das vari�veis invariantes e variantes no tempo, tal que
{{<math>}}\begin{align} \boldsymbol{\beta}\quad\ &\equiv \begin{bmatrix} \ \boldsymbol{\Gamma}\  \\ \ \boldsymbol{\delta}\  \end{bmatrix} \\
\begin{bmatrix} \beta_0 \\ \beta_1 \\ \beta_2 \\ \vdots \\ \beta_J \\\hline \beta_{J+1} \\ \beta_{J+2} \\ \vdots \\ \beta_{K} \end{bmatrix} &\equiv \begin{bmatrix} \Gamma_0 \\ \Gamma_1 \\ \Gamma_2 \\ \vdots \\ \Gamma_J \\\hline \delta_1 \\ \delta_2 \\ \vdots \\ \delta_L \end{bmatrix} \end{align}{{</math>}}


Empilhando as equa��es (2) para todo {{<math>}}$i${{</math>}} e {{<math>}}$t${{</math>}}, segue que
{{<math>}}$$ \boldsymbol{y}\ =\ \boldsymbol{X} \boldsymbol{\beta} + \boldsymbol{\varepsilon} \ =\ \boldsymbol{X}_0 \boldsymbol{\Gamma} + \boldsymbol{X}^{*} \boldsymbol{\delta} + \boldsymbol{\varepsilon} $${{</math>}}
ou, usando

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
A matriz de transforma��o **inter-indiv�duos (_between_)** � denotada por:
{{<math>}}$$ \boldsymbol{B}\ =\ \boldsymbol{I}_N \otimes \Big[ \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big] $${{</math>}}
Note que a matriz {{<math>}}$\boldsymbol{B}${{</math>}} � equivalente a {{<math>}}$\boldsymbol{N}${{</math>}} nas notas de aula de Econometria II.

Pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} pela matriz de transforma��o _between_ {{<math>}}$\boldsymbol{B}${{</math>}}, temos:
{{<math>}}$$ x^k_{it}\ \overset{\boldsymbol{B}}{\Longrightarrow}\ \bar{x}^k_{i}\ =\ \frac{1}{T} \sum^T_{i=1}{x^k_{it}}, \qquad \forall i, t, k $${{</math>}}

Logo,

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

Por exemplo, para {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}, segue que:

{{<math>}}$$ \boldsymbol{B} = \left[ \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right]_{6 \times 6}, $${{</math>}}


Por exemplo, suponha a matriz {{<math>}}$\boldsymbol{X}${{</math>}}, com {{<math>}}$J=1${{</math>}} vari�vel invariante no tempo, e {{<math>}}$P=3${{</math>}} variantes: 

{{<math>}}$$ \boldsymbol{X} = \begin{bmatrix} \boldsymbol{X}_0 & \boldsymbol{X}^{*} \end{bmatrix} = \left[ \begin{array}{cc|ccc}
1 & 3 & 1 & 3 & 6 \\
1 & 3 & 9 & 5 & 4 \\
1 & 3 & 8 & 7 & 2 \\ \hline
1 & 7 & 6 & 6 & 8 \\
1 & 7 & 8 & 6 & 1 \\
1 & 7 & 1 & 9 & 9
\end{array} \right]_{6 \times 5} $${{</math>}}

Note que a linha horizontal na matriz acima foi colocada apenas para deixar claro que as tr�s primeiras linhas correspondem ao mesmo indiv�duo {{<math>}}$i=1${{</math>}}, e as tr�s �ltimas correspondem ao indiv�duo {{<math>}}$i=2${{</math>}}. S�o tr�s linhas para cada um, pois assumimos {{<math>}}$t=1,2,3${{</math>}} per�odos.

Logo, temos:

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

Note que, para cada indiv�duo {{<math>}}$i${{</math>}} e coluna {{<math>}}$k${{</math>}}, os elementos foram "preenchidos" com a m�dia dos valores em {{<math>}}$t=1,2,3${{</math>}}.


</br>


Agora, vamos definir uma matriz de covariadas `X` e p�s-multiplicar pela matriz `B`

```r
N = 2 # n� indiv�duos
T = 3 # n� per�odos
K = 4 # n� vari�veis explicativas

# Calculando matriz de transforma��o between
iota_T = matrix(1, nrow=T, ncol=1) # vetor de 1's de dimens�o T
I_N = diag(N) # Matriz identidade de dimens�o N
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
B # matriz de transforma��o between
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
# Matriz de covariadas X
X = matrix(c(rep(1, 6), # 1a coluna de 1's
             rep(3, 3), rep(7, 3), # 2a coluna
             1,9,8,6,8,1, # 3a coluna
             3,5,7,6,6,9, # 4a coluna
             6,4,2,8,1,9  # 5a coluna
             ), ncol=K+1) # matriz covariadas NT x (K+1)
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
# Pr�-multiplicando X por B
B %*% X # matriz de m�dias das covariadas dado indiv�duo (NT x K)
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

Note que:
- as colunas 1 e 2 permaneceram iguais ap�s a transforma��o _between_, pois s�o invariantes no tempo (m�dia de algo constante � a pr�pria constante).
- dada uma vari�vel {{<math>}}$k${{</math>}}, temos um �nico valor (m�dia) dentro de um mesmo indiv�duo {{<math>}}$i${{</math>}};
- por isso, a amostra com {{<math>}}$NT${{</math>}} observa��es distintas, agora, **passa a possuir apenas {{<math>}}$N${{</math>}} observa��es distintas**, o que faz com que percamos graus de liberdade (perde {{<math>}}$N(T-1)${{</math>}} graus de liberdade)


</br>

### _Within_
J� a matriz de transforma��o **intra-indiv�duos (_within_)** � dada por:
{{<math>}}$$ \boldsymbol{W}\ =\ \boldsymbol{I}_{NT} - \boldsymbol{B}\ =\ \boldsymbol{I}_{NT} - \Big[ \boldsymbol{I}_N \otimes \boldsymbol{\iota}_T (\boldsymbol{\iota}'_T \boldsymbol{\iota}_T)^{-1} \boldsymbol{\iota}'_T \Big]. $${{</math>}}

Note que a matriz {{<math>}}$\boldsymbol{W}${{</math>}} � equivalente a {{<math>}}$\boldsymbol{M}${{</math>}} nas notas de aula de Econometria II (2021).

Pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} pela matriz de transforma��o _within_ {{<math>}}$\boldsymbol{W}${{</math>}}, temos:
{{<math>}}$$ x^{k}_{it}\ \overset{\boldsymbol{W}}{\Longrightarrow}\ x^{k}_{it} - \bar{x}^{k}_i\ =\ x^{k}_{it} - \frac{1}{T} \sum^T_{i=1}{x^{k}_{it}}, \qquad \forall i, t, l=1,...,L $${{</math>}}

Logo,
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


Por exemplo, para {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}, segue que:

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


Logo, temos:

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

Note que perdemos toda variabilidade das duas primeiras colunas que eram invariantes no tempo. Portanto, "jogamos fora" toda submatriz {{<math>}}$\boldsymbol{X}_0${{</math>}}, sobrando apenas {{<math>}}$\boldsymbol{X}^{*}${{</math>}} (com covariadas variantes no tempo).



```r
I_NT = diag(N*T) # Matriz identidade de dimens�o NT
W = I_NT - B 
W # matriz de transforma��o within
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
# Pr�-multiplicando X por W
round(W %*% X, 10) # arredondando
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

- dada uma vari�vel {{<math>}}$k${{</math>}}, temos os desvios em rela��o � m�dia de um mesmo indiv�duo;
- colunas 1 e 2, invariantes no tempo, viraram apenas 0 ap�s a transforma��o _within_, fazendo com que as percamos em uma regress�o.
- coluna de 0's, no R, ficou muito pr�xima de 0 ({{<math>}}$1,11 \times 10^{-16}${{</math>}}), ent�o foi necess�rio arredondar.


</br>

### Primeiras-diferen�as
- A matriz de primeiras diferen�as permite transformar as vari�veis para as diferen�as entre as realiza��o entre os per�odos {{<math>}}$t+1${{</math>}} e {{<math>}}$t${{</math>}}, e tem a seguinte forma (n�o-quadrada):
{{<math>}}$$\boldsymbol{D} = \boldsymbol{I}_N \otimes \boldsymbol{D}_i $${{</math>}}
em que {{<math>}}$\boldsymbol{I}_N${{</math>}} � uma matriz identidade de tamanho {{<math>}}$N${{</math>}}, e

{{<math>}}$$\boldsymbol{D}_i = \begin{bmatrix}
-1 & 1 & 0 & \cdots & 0 & 0 \\
0 & -1 & 1 & \cdots & 0 & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & 0 & \cdots & -1 & 1
\end{bmatrix}_{(T-1)\times T}$${{</math>}}
� n�o � uma matriz quadrada e possui "diagonais principais" iguais a {{<math>}}$-1${{</math>}} e a {{<math>}}$1${{</math>}}.


Pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} pela matriz de transforma��o de _primeiras-diferen�as_ {{<math>}}$\boldsymbol{D}${{</math>}}, temos:
{{<math>}}$$ x^{k}_{it}\ \overset{\boldsymbol{D}}{\Longrightarrow}\ \Delta x^{k}_{it} \ =\ x^{k}_{i,t+1} - x^{k}_{it}, \qquad \forall i, k, t = 1, 2, ..., T-1 $${{</math>}}

Logo,
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

Por exemplo, para {{<math>}}$N = 2${{</math>}} e {{<math>}}$T = 3${{</math>}}, segue que:

{{<math>}}$$ \boldsymbol{D}_i = \begin{bmatrix} 
-1 &  1 &  0 \\
 0 & -1 &  1 \end{bmatrix}_{2 \times 3},\quad i=1,2 $${{</math>}}

Logo, temos que

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

Note que perdemos toda variabilidade das duas primeiras colunas que eram invariantes no tempo {{<math>}}$(\boldsymbol{X}_0)${{</math>}}. Al�m disso, perdemos um per�odo para cada indiv�duo {{<math>}}$i${{</math>}}.



Para construir {{<math>}}$\boldsymbol{D}_i${{</math>}} no R, vamos:

a) criar uma matriz identidade de tamanho {{<math>}}$T${{</math>}} e multiplicar por {{<math>}}$-1${{</math>}}
{{<math>}}$$ -\boldsymbol{I}_T = \begin{bmatrix}
-1 &  0 &  0 \\
 0 & -1 &  0 \\
 0 &  0 & -1
\end{bmatrix} $${{</math>}}.

```r
Di = -diag(T) # diagonal -1
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    0    0
## [2,]    0   -1    0
## [3,]    0    0   -1
```


b) alterar o valor da superdiagonal (� a diagonal da matriz identidade de tamanho {{<math>}}$T-1${{</math>}} (submatriz que exclui a primeira coluna e �ltima linha da matriz de tamanho {{<math>}}$T${{</math>}})
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
diag(Di[-nrow(Di),-1]) = 1 # supradiagonal
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    1    0
## [2,]    0   -1    1
## [3,]    0    0   -1
```

c) excluir a �ltima linha, tornando a matriz de dimens�o {{<math>}}$(T-1)\times T${{</math>}}
{{<math>}}$$ \Longrightarrow \boldsymbol{D}_i = \left[ \begin{array}{ccc}
-1 &  1 &  0 \\
 0 & -1 &  1 
\end{array} \right]_{2 \times 3} $${{</math>}}

```r
Di = Di[-nrow(Di),] # retira �ltima linha
Di
```

```
##      [,1] [,2] [,3]
## [1,]   -1    1    0
## [2,]    0   -1    1
```

Depois, basta fazer o produto de Kronecker, {{<math>}}$\otimes${{</math>}}, entre a matriz identidade de tamanho {{<math>}}$N${{</math>}}, {{<math>}}$\boldsymbol{I}_N${{</math>}},e a matriz {{<math>}}$\boldsymbol{D}_i${{</math>}}:


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
I_N = diag(N) # matriz identidade de tamanho N
D = I_N %x% Di
D # matriz de primeiras-diferen�as
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]   -1    1    0    0    0    0
## [2,]    0   -1    1    0    0    0
## [3,]    0    0    0   -1    1    0
## [4,]    0    0    0    0   -1    1
```

```r
# Transforma��o DX
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

- colunas 1 e 2, invariantes no tempo, viraram apenas 0 ap�s a transforma��o de primeiras-diferen�as, fazendo com que as percamos em uma regress�o.
- tamb�m perdemos uma linha por indiv�duo para calcular a varia��o entre os per�odos




</br>

## Estimador _Between_

O modelo a ser estimado � o MQO pr�-multiplicado por {{<math>}}$\boldsymbol{B} = \boldsymbol{I}_N \otimes \boldsymbol{\iota} (\boldsymbol{\iota}' \boldsymbol{\iota})^{-1} \boldsymbol{\iota}'${{</math>}}:
{{<math>}}$$ \boldsymbol{By}\ =\ \boldsymbol{BX\beta} + \boldsymbol{B\varepsilon} $${{</math>}}

- O estimador _between_ � dado por
{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}\ =\ (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} y $${{</math>}}

- Defina
{{<math>}}$$ \hat{\sigma}^2_l \equiv \hat{\sigma}^2_v + T \hat{\sigma}^2_u  $${{</math>}}

- A matriz de covari�ncias do estimador pode ser obtida usando
{{<math>}}\begin{align}
    V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}) &= (\boldsymbol{X}'\boldsymbol{BX})^{-1} \boldsymbol{X}' \boldsymbol{B}\boldsymbol{\Sigma} \boldsymbol{B} \boldsymbol{X} (\boldsymbol{X}'\boldsymbol{BX})^{-1} \\
    &\ \ \vdots \\
    &= \hat{\sigma}^2_l (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X})^{-1},
\end{align}{{</math>}}


- O estimador n�o-viesado de {{<math>}}$\sigma^2_l${{</math>}} �
{{<math>}}$$ \hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}}}{N-K-1} $${{</math>}}
em que {{<math>}}$\boldsymbol{\varepsilon}_{\scriptscriptstyle{B}}${{</math>}} s�o os res�duos obtidos a partir da estima��o {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}${{</math>}}.

- O estimador _between_ tamb�m pode ser estimado por MQO, transformando as vari�veis por pr�-multiplica��o da matriz _between_ {{<math>}}$(\boldsymbol{B})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}} \equiv \boldsymbol{BX} \qquad \text{ e } \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{By} $${{</math>}} 

Ent�o
{{<math>}}\begin{align} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}} &= (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} y \\
&= (\boldsymbol{X}' \boldsymbol{B} \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B} \boldsymbol{B} y \\
&= (\boldsymbol{X}' \boldsymbol{B}' \boldsymbol{B} \boldsymbol{X} )^{-1} \boldsymbol{X}' \boldsymbol{B}' \boldsymbol{B} y \\
&= ([\boldsymbol{B} \boldsymbol{X}]' \boldsymbol{B} \boldsymbol{X} )^{-1} [\boldsymbol{B} \boldsymbol{X}]' \boldsymbol{B} y \\
&\equiv ( \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}} )^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}} \end{align}{{</math>}}

Note que usamos:
{{<math>}}$$ \boldsymbol{B} = \boldsymbol{B}\boldsymbol{B} \qquad \text{e} \qquad \boldsymbol{B}=\boldsymbol{B}' $${{</math>}}


<!-- ```{r} -->
<!-- # Exemplo N = 2 e T = 3 -->
<!-- N = 2 -->
<!-- T = 3 -->

<!-- # Calculando matriz de transforma��o between -->
<!-- iota_T = matrix(1, nrow=T, ncol=1) # vetor de 1's de dimens�o T -->
<!-- I_N = diag(N) # Matriz identidade de dimens�o N -->
<!-- B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T)) -->
<!-- B # matriz between -->
<!-- B %*% B # multiplica��o matricial de matrizes between -->
<!-- t(B) # transposta da matriz between -->
<!-- ``` -->


### Estima��o via `plm()`
Novamente, usaremos a base de dados `TobinQ` do pacote `pder` e queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta_1 + \varepsilon $${{</math>}}


```r
# Carregando pacote e base de dados necess�rios
library(plm)
data(TobinQ, package="pder")

# Transformando no formato pdata frame, com indentificador de indiv�duo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��es
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




<!-- ### Estima��o via lm() -->

<!-- N�s podemos construir as vari�veis de m�dia diretamente no data frame e fazer a estima��o _between_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "na m�o" as vari�veis de m�dias para cada indiv�duo -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (indiv�duo) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transforma��o" between de ikn -->
<!--         qn_bar = mean(qn), # "transforma��o" between de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estima��o between via lm() -->
<!-- Q.between.ols = lm(ikn_bar ~ qn_bar, TobinQ) -->

<!-- # Comparando as estimativas -->
<!-- summary(Q.between.ols)$coef # between via MQO -->
<!-- summary(Q.between)$coef # between ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note que o erro padr�o est� subestimado no output gerado por `lm()`. -->
<!-- - A rotina padr�o de MQO retorna {{<math>}}$\hat{\sigma}^2_l = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, � necess�rio fazer ajuste dos graus de liberdade multiplicando a Matriz de Vari�ncias-Covari�ncias dos Erros por {{<math>}}$(NT-K-1) / (N-K-1)${{</math>}}. -->
<!--   - _Between_ perde {{<math>}}$N(T-1)${{</math>}} observa��es pois cada indiv�duo fica apenas com 1 observa��o.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de vari�ncia covari�ncia do estimador -->
<!-- vcov.ols = vcov(Q.between.ols) -->
<!-- vcov.between = vcov.ols * (N*T - K - 1) / (N - K - 1) -->
<!-- se.between = sqrt( diag(vcov.between) ) -->
<!-- se.between -->
<!-- ``` -->



### Estima��o Anal�tica

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # juntando 1's com as covariadas

# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1
```


b) Calculando a matriz _between_

{{<math>}}$$ \boldsymbol{B} = \boldsymbol{I}_{N} \otimes \left[ \boldsymbol{\iota}_T \left( \boldsymbol{\iota}'_T \boldsymbol{\iota}_T  \right)^{-1} \boldsymbol{\iota}'_T \right] $${{</math>}}


```r
# Criando matrizes between
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
```


c) Estimativas _Between_ {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}${{</math>}}

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

d) Valores ajustados/preditos _Between_ {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{B}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{B}} = \boldsymbol{X} \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}} $${{</math>}}


```r
yhat_B = X %*% bhat_B
```

e) Res�duos _Between_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{B}} $${{</math>}}


```r
ehat_B = y - yhat_B
```

f) Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2_l \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{B}} \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{B}}}{N - K - 1} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2_l${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2l = as.numeric( (t(ehat_B) %*% B %*% ehat_B) / (N - K - 1) )
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _between_ para {{<math>}}$N - K - 1${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g) Matriz de Vari�ncias-Covari�ncias do Estimador _Between_

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}}) = \hat{\sigma}^2_l (\boldsymbol{X}' B \boldsymbol{X})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vbhat_B = sig2l * solve( t(X) %*% B %*% X )
Vbhat_B
```

```
##               [,1]          [,2]
## [1,]  1.507017e-05 -1.405770e-06
## [2,] -1.405770e-06  5.611075e-07
```


i) Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{B}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_bhat_B = sqrt( diag(Vbhat_B) )
se_bhat_B
```

```
## [1] 0.0038820321 0.0007490711
```

j) Estat�stica _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_bhat_B = bhat_B / se_bhat_B
t_bhat_B
```

```
##           [,1]
## [1,] 40.188625
## [2,]  6.921555
```

k) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_bhat_B = 2 * pt(-abs(t_bhat_B), N-K-1)
p_bhat_B
```

```
##              [,1]
## [1,] 1.227764e-93
## [2,] 7.012814e-11
```

l) Tabela-resumo

```r
cbind(bhat_B, se_bhat_B, t_bhat_B, p_bhat_B) # resultado Between
```

```
##                     se_bhat_B                       
## [1,] 0.156013534 0.0038820321 40.188625 1.227764e-93
## [2,] 0.005184737 0.0007490711  6.921555 7.012814e-11
```

```r
summary(Q.between)$coef # resultado Between via plm()
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```



#### Transformando e estimando por MQO
Al�m da forma mostrada anteriormente, podemos tamb�m transformar as vari�veis e resolver por MQO, pr�-multiplicando {{<math>}}$\boldsymbol{X}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{B}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}} \equiv \boldsymbol{B} \boldsymbol{X} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{B} \boldsymbol{y}$${{</math>}}

c') Estimativas _between_ via MQO

{{<math>}}$$ \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}} = (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}' \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transformando vari�veis
X_til = B %*% X
y_til = B %*% y

# Estimando
bhat_OLS = solve( t(X_til) %*% X_til ) %*% t(X_til) %*% y_til
bhat_OLS
```

```
##             [,1]
## [1,] 0.156013534
## [2,] 0.005184737
```

d') Valores ajustados/preditos _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} = \tilde{\boldsymbol{X}} \tilde{\hat{\boldsymbol{\beta}}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
yhat_OLS = X_til %*% bhat_OLS
```

e') Res�duos MQO

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{N - K - 1} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N - K - 1) )
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _between_ para {{<math>}}$N - K - 1${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g) Matriz de Vari�ncias-Covari�ncias do Estimador MQO

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQO}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}}' \tilde{\boldsymbol{X}})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vbhat_OLS = sig2hat * solve( t(X_til) %*% X_til )
Vbhat_OLS
```

```
##               [,1]          [,2]
## [1,]  1.507017e-05 -1.405770e-06
## [2,] -1.405770e-06  5.611075e-07
```


i) Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{OLS}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_bhat_OLS = sqrt( diag(Vbhat_OLS) )
se_bhat_OLS
```

```
## [1] 0.0038820321 0.0007490711
```

j) Estat�stica _t_

{{<math>}}$$ t_{\hat{\beta}_k} = \frac{\hat{\beta}_k}{\text{se}(\hat{\beta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_bhat_OLS = bhat_OLS / se_bhat_OLS
t_bhat_OLS
```

```
##           [,1]
## [1,] 40.188625
## [2,]  6.921555
```

k) P-valor

{{<math>}}$$ p_{\hat{\beta}_k} = 2.\Phi_{t_{(N-K-1)}}(-|t_{\hat{\beta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_bhat_OLS = 2 * pt(-abs(t_bhat_OLS), N-K-1)
p_bhat_OLS
```

```
##              [,1]
## [1,] 1.227764e-93
## [2,] 7.012814e-11
```

l) Tabela-resumo

```r
cbind(bhat_OLS, se_bhat_OLS, t_bhat_OLS, p_bhat_OLS) # resultado Between via MQO
```

```
##                   se_bhat_OLS                       
## [1,] 0.156013534 0.0038820321 40.188625 1.227764e-93
## [2,] 0.005184737 0.0007490711  6.921555 7.012814e-11
```

```r
summary(Q.between)$coef # resultado Between via plm()
```

```
##                Estimate   Std. Error   t-value     Pr(>|t|)
## (Intercept) 0.156013534 0.0038820321 40.188625 1.227764e-93
## qn          0.005184737 0.0007490711  6.921555 7.012814e-11
```


</br>

## Estimador _Within_ (Efeitos Fixos)
- Tamb�m conhecido como estimador de **Efeitos Fixos**
- **N�o assume que {{<math>}}$E(u | X) = 0${{</math>}}**
- Ou seja, flexibilizamos o modelo para **{{<math>}}$E(u | X) \neq ${{</math>}} constante**
- Avalia desvios em rela��o �s m�dias individuais

O modelo a ser estimado � o MQO pr�-multiplicado por {{<math>}}$\boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B}${{</math>}}:
{{<math>}}$$ \boldsymbol{Wy}\ =\ \boldsymbol{WX\beta} + \boldsymbol{W\varepsilon}\ =\ \boldsymbol{WX}^* \boldsymbol{\beta} + \boldsymbol{Wv}. $${{</math>}}
Note que a transforma��o _within_ remove as vari�veis invariantes no tempo, a coluna de 1's e o termo de erro individual {{<math>}}$u${{</math>}} (sobrando apenas {{<math>}}$\varepsilon = v${{</math>}}).

- O estimador _within_ � dado por
{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}\ =\ (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} $${{</math>}}


- A matriz de covari�ncias do estimador pode ser obtida usando
{{<math>}}\begin{align}
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}) &= (\boldsymbol{X}^{*\prime}\boldsymbol{WX}^*)^{-1} \boldsymbol{X}' \boldsymbol{W}\boldsymbol{\Sigma} \boldsymbol{W} \boldsymbol{X} (\boldsymbol{X}^{*\prime}\boldsymbol{WX}^*)^{-1} \\
    &\ \ \vdots \\
    &= \sigma^2_v (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1}.
\end{align}{{</math>}}

- O estimador n�o-viesado de {{<math>}}$\sigma^2_v${{</math>}} �
{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}

- O estimador _within_ tamb�m pode ser estimado por MQO, transformando as vari�veis por pr�-multiplica��o da matriz _within_ {{<math>}}$(\boldsymbol{W})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}}^* \equiv \boldsymbol{WX}^* \qquad \text{ e } \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{Wy} $${{</math>}} 

Ent�o

{{<math>}}\begin{align} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} &= (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} \\
&= (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{W} \boldsymbol{y} \\
&= (\boldsymbol{X}^{*\prime} \boldsymbol{W}' \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W}' \boldsymbol{W} \boldsymbol{y} \\
&= ([\boldsymbol{W} \boldsymbol{X}^{*}]' \boldsymbol{W} \boldsymbol{X}^{*} )^{-1} [\boldsymbol{W} \boldsymbol{X}^{*}]' \boldsymbol{W} \boldsymbol{y} \\
&\equiv ( \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}} )^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} \end{align}{{</math>}}

Note que usamos:
{{<math>}}$$ \boldsymbol{W} = \boldsymbol{W}\boldsymbol{W} \qquad \text{e} \qquad \boldsymbol{W}=\boldsymbol{W}' $${{</math>}}


<!-- ```{r} -->
<!-- # Exemplo N = 2 e T = 3 -->
<!-- N = 2 -->
<!-- T = 3 -->
<!-- I_NT = diag(N*T) # Matriz identidade de dimens�o N -->
<!-- W = I_NT - B -->

<!-- W # matriz within -->
<!-- W %*% W # multiplica��o matricial de matrizes within -->
<!-- t(W) # transposta da matriz within -->
<!-- ``` -->


### Estima��o via `plm()`
Novamente, usaremos a base de dados `TobinQ` do pacote `pder` e queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta + \varepsilon $${{</math>}}


```r
# Carregando pacote e base de dados necess�rios
library(plm)
data(TobinQ, package="pder")

# Transformando no formato pdata frame, com indentificador de indiv�duo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Comparando as estimativas
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
- Observe que:
    - as vari�veis entram na estima��o sem nenhuma transforma��o e
    - cada m�todo possui diferentes graus de liberdade


<!-- ### Estima��o via lm() -->

<!-- N�s podemos construir as vari�veis de m�dia e de desvios de m�dia diretamente no data frame e fazer a estima��o _within_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "na m�o" as vari�veis de desvios da m�dia para cada indiv�duo -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (indiv�duo) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transforma��o" between de ikn -->
<!--         qn_bar = mean(qn), # "transforma��o" between de qn -->
<!--         ikn_desv = ikn - ikn_bar, # "transforma��o" within de ikn -->
<!--         qn_desv = qn - qn_bar # "transforma��o" within de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estima��o within via lm() -->
<!-- Q.within.ols = lm(ikn_desv ~ 0 + qn_desv, TobinQ) # retira intercepto com 0 -->

<!-- # Comparando as estimativas -->
<!-- summary(Q.within.ols)$coef # within via MQO -->
<!-- summary(Q.within)$coef # within ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note que o erro padr�o est� subestimado no output gerado por `lm()`. -->
<!-- - A rotina padr�o de MQO retorna {{<math>}}$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, � necess�rio fazer ajuste dos graus de liberdade multiplicando a Matriz de Vari�ncias-Covari�ncias dos Erros por {{<math>}}$(NT-K-1) / (NT-K-N)${{</math>}}. -->
<!--   - _Within_ estima mais {{<math>}}$N${{</math>}} par�metros (efeitos fixos dos indiv�duos) e deixa de estimar o intercepto.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de vari�ncia covari�ncia do estimador -->
<!-- vcov.ols = vcov(Q.within.ols) -->
<!-- vcov.within = vcov.ols * (N*T - K - 1) / (N*(T-1) - K) -->
<!-- se.within = sqrt( diag(vcov.within) ) -->
<!-- se.within -->
<!-- ``` -->



### Estima��o Anal�tica

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz

# Criando a matriz/vetor de covariadas variantes no tempo Xt
Xt = as.matrix( TobinQ[, "qn"] ) # n�o junta com coluna de 1's

# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(Xt) # n�o subtrai 1
```


b) Calculando as matrizes _between_ e _within_

{{<math>}}$$ \boldsymbol{B} = \boldsymbol{I}_{N} \otimes \left[ \boldsymbol{\iota}_T \left( \boldsymbol{\iota}'_T \boldsymbol{\iota}_T  \right)^{-1} \boldsymbol{\iota}'_T \right] \qquad \text{e} \qquad \boldsymbol{W} = \boldsymbol{I}_{NT} - \boldsymbol{B} $${{</math>}}


```r
# Criando matrizes between
iota_T = matrix(1, T, 1) # vetor coluna de 1's de tamanho T
I_N = diag(N) # matriz identidade de tamanho N
I_NT = diag(N*T) # matriz identidade de tamanho NT

B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B
```


c) Estimativas _Within_ {{<math>}}$\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} = (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{y} $${{</math>}}

```r
dhat_W = solve( t(Xt) %*% W %*% Xt ) %*% t(Xt) %*% W %*% y
dhat_W
```

```
##             [,1]
## [1,] 0.003791948
```

d) Valores ajustados/preditos _Within_ {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{W}} = \boldsymbol{X}^{*} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}} $${{</math>}}


```r
yhat_W = Xt %*% dhat_W
```


e) Res�duos _Within_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{W}} $${{</math>}}


```r
ehat_W = y - yhat_W
```

f) Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2_v =  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{W}}}{NT - K - N} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2_v${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2v = as.numeric( (t(ehat_W) %*% W %*% ehat_W) / (N*T - K - N) )
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _within_ para {{<math>}}$NT - K - N${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g) Matriz de Vari�ncias-Covari�ncias do Estimador _Within_

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}}) = \hat{\sigma}^2_v (\boldsymbol{X}^{*\prime} \boldsymbol{W} \boldsymbol{X}^{*})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vdhat_W = sig2v * solve( t(Xt) %*% W %*% Xt )
Vdhat_W
```

```
##             [,1]
## [1,] 2.98062e-08
```


i) Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{W}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_dhat_W = sqrt( diag(Vdhat_W) )
se_dhat_W
```

```
## [1] 0.0001726447
```

j) Estat�stica _t_

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_dhat_W = dhat_W / se_dhat_W
t_dhat_W
```

```
##          [,1]
## [1,] 21.96388
```

k) P-valor

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_dhat_W = 2 * pt(-abs(t_dhat_W), N*T-K-N)
p_dhat_W
```

```
##               [,1]
## [1,] 3.854128e-103
```

l) Tabela-resumo

```r
cbind(dhat_W, se_dhat_W, t_dhat_W, p_dhat_W) # resultado Within
```

```
##                     se_dhat_W                       
## [1,] 0.003791948 0.0001726447 21.96388 3.854128e-103
```

```r
summary(Q.within)$coef # resultado Within via plm()
```

```
##       Estimate   Std. Error  t-value      Pr(>|t|)
## qn 0.003791948 0.0001726447 21.96388 3.854128e-103
```



#### Transformando e estimando por MQO
Al�m da forma mostrada anteriormente, podemos tamb�m transformar as vari�veis e resolver por MQO, pr�-multiplicando {{<math>}}$\boldsymbol{X}^{*}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{W}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}^{*}} \equiv \boldsymbol{W} \boldsymbol{X}^{*} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{W} \boldsymbol{y}$${{</math>}}

c') Estimativas _within_ via MQO

{{<math>}}$$ \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} = (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transformando vari�veis
Xt_til = W %*% Xt
y_til = W %*% y

# Estimando
dhat_OLS = solve( t(Xt_til) %*% Xt_til ) %*% t(Xt_til) %*% y_til
dhat_OLS
```

```
##             [,1]
## [1,] 0.003791948
```

d') Valores ajustados/preditos _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} = \tilde{\boldsymbol{X}^{*}} \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
yhat_OLS = Xt_til %*% dhat_OLS
```

e') Res�duos MQO

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{NT - K - N} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N*T - K - N) )
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _within_ para {{<math>}}$NT - K - N${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g') Matriz de Vari�ncias-Covari�ncias do Estimador MQO

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{MQO}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vdhat_OLS = sig2hat * solve( t(Xt_til) %*% Xt_til )
Vdhat_OLS
```

```
##             [,1]
## [1,] 2.98062e-08
```


h') Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_dhat_OLS = sqrt( diag(Vdhat_OLS) )
se_dhat_OLS
```

```
## [1] 0.0001726447
```

i') Estat�stica _t_

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_dhat_OLS = dhat_OLS / se_dhat_OLS
t_dhat_OLS
```

```
##          [,1]
## [1,] 21.96388
```

j') P-valor

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_dhat_OLS = 2 * pt(-abs(t_dhat_OLS), N*T-K-N)
p_dhat_OLS
```

```
##               [,1]
## [1,] 3.854128e-103
```

k') Tabela-resumo

```r
cbind(dhat_OLS, se_dhat_OLS, t_dhat_OLS, p_dhat_OLS) # resultado Within via MQO
```

```
##                   se_dhat_OLS                       
## [1,] 0.003791948 0.0001726447 21.96388 3.854128e-103
```

```r
summary(Q.within)$coef # resultado Within via plm()
```

```
##       Estimate   Std. Error  t-value      Pr(>|t|)
## qn 0.003791948 0.0001726447 21.96388 3.854128e-103
```



### Efeitos Fixos do _Within_
- Para o estimador _within_, podemos usar a fun��o `fixef()` para computar os efeitos individuais. ?? poss�vel visualizar os efeitos fixos de tr�s formas por meio do argumento `type`:
    - `level`: valor padr�o que retorna os interceptos individuais
    - `dfirst`: em desvios do 1� indiv�duo
    - `dmean`: em desvios da m�dia de efeitos individuais


```r
# 6 primeiros efeitos individuais de cada tipo
head( fixef(Q.within, type="level") ) # 6 primeiros valores em n�vel
```

```
##      2824      6284      9158     13716     17372     19411 
## 0.1452896 0.1280547 0.2580836 0.1100110 0.1267251 0.1694891
```

```r
head( fixef(Q.within, type="dfirst") ) # 6 primeiros valores em rela��o ao 1� indiv.
```

```
##        6284        9158       13716       17372       19411       19519 
## -0.01723488  0.11279400 -0.03527859 -0.01856442  0.02419952 -0.01038237
```

```r
head( fixef(Q.within, type="dmean") ) # 6 primeiros valores em desvios da m�dia
```

```
##         2824         6284         9158        13716        17372        19411 
## -0.014213401 -0.031448285  0.098580596 -0.049491991 -0.032777823  0.009986116
```
- Note que, como o `dfirst` retorna valores em rela��o ao 1� indiv�duo e, portanto, este n�o aparece no output do `fixef()`.
- No caso linear, o estimador _within_ � equivalente � estima��o por MQO com inclus�o de dummies para cada indiv�duo (efeitos fixos dos indiv�duos):

```r
# Estimando MQO com dummies individuais - factor() tranforma cusip em var. categ.
Q.dummies1 = lm(ikn ~ 0 + qn + factor(cusip), TobinQ)

# Comparando as estimativas de qn e efeitos individuais
cbind(
  Q.dummies1$coef[1:7], # coef MQO incluindo dummies
  c(Q.within$coef, fixef(Q.within, type="level")[1:6]) # coef within + 6 efeitos fixos
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

- Se estim�ssemos o MQO com efeitos fixos usando um intercepto, o intercepto seria o valor do efeito fixo do 1� indiv�duo e os valores dos efeitos fixos dos demais indiv�duos seriam em rela��o a este.
  - A dummy do 1� indiv�duo seria retirado para n�o haver multicolinearidade perfeita


```r
# Estimando MQO com dummies individuais - factor() tranforma cusip em var. categ.
Q.dummies2 = lm(ikn ~ qn + factor(cusip), TobinQ)

# Comparando as estimativas de qn e efeitos individuais
cbind(
  Q.dummies2$coef[1:7], # coef MQO incluindo dummies
  c(NA, Q.within$coef, fixef(Q.within, type="dfirst")[1:5]) # coef within + 6 efeitos fixos
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

## Estimador de Primeiras-Diferen�as

- **N�o assume que {{<math>}}$E(u | X) = 0${{</math>}}**
- Ou seja, flexibilizamos o modelo para **{{<math>}}$E(u | X) \neq ${{</math>}} constante**
- Avalia as varia��es de uma observa��o em rela��o � observa��o do per�odo imediatamente seguinte

O modelo a ser estimado � o MQO pr�-multiplicado por {{<math>}}$\boldsymbol{D}${{</math>}}:
{{<math>}}$$ \boldsymbol{Dy}\ =\ \boldsymbol{DX\beta} + \boldsymbol{D\varepsilon}\ =\ \boldsymbol{DX}^* \boldsymbol{\delta} + \boldsymbol{Dv}. $${{</math>}}
Note que a transforma��o de primeiras-diferen�as remove as vari�veis invariantes no tempo, a coluna de 1's e o termo de erro individual {{<math>}}$\boldsymbol{u}${{</math>}} (sobrando apenas {{<math>}}$\boldsymbol{\varepsilon} = \boldsymbol{v}${{</math>}}).

- O estimador de primeiras-diferen�as � dado por
{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}\ =\ (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} $${{</math>}}

- O estimador n�o-viesado de {{<math>}}$\sigma^2_v${{</math>}} �
{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{D}' \boldsymbol{D} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}


- A matriz de covari�ncias do estimador pode ser obtida usando
{{<math>}}$$`
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}) = \sigma^2_v \Big[  (\boldsymbol{X}^{*\prime}  \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \boldsymbol{X}' \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X} (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \Big]
`$${{</math>}}

- O estimador de primeiras-diferen�as tamb�m pode ser estimado por MQO, transformando as vari�veis por pr�-multiplica��o da matriz primeiras-diferen�as {{<math>}}$(\boldsymbol{D})${{</math>}}:
{{<math>}}$$ \tilde{\boldsymbol{X}}^* \equiv \boldsymbol{DX}^* \qquad \text{ e } \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{Dy} $${{</math>}} 

Ent�o

{{<math>}}\begin{align} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} &= (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} \\
&= ([\boldsymbol{D} \boldsymbol{X}^{*}]' \boldsymbol{D} \boldsymbol{X}^{*} )^{-1} [\boldsymbol{D} \boldsymbol{X}^{*}]' \boldsymbol{D} \boldsymbol{y} \\
&\equiv ( \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}} )^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} = \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} \end{align}{{</math>}}

Note que {{<math>}}$\boldsymbol{D}${{</math>}} n�o � uma matriz quadrada como as demais matrizes de transforma��o e, portanto:
{{<math>}}$$ \boldsymbol{D} \neq \boldsymbol{D}\boldsymbol{D} \qquad \text{e} \qquad \boldsymbol{D} \neq \boldsymbol{D}' $${{</math>}}


### Estima��o via `plm()`
Novamente, usaremos a base de dados `TobinQ` do pacote `pder` e queremos estimar o seguinte modelo:
{{<math>}}$$ \text{ikn} = \beta_0 + \text{qn} \beta + \varepsilon $${{</math>}}


```r
# Carregando pacote e base de dados necess�rios
library(plm)
data(TobinQ, package="pder")

# Transformando no formato pdata frame, com indentificador de indiv�duo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��es
Q.fd = plm(ikn ~ 0 + qn, pTobinQ, model = "fd") # estima��o primeiras-diferen�as
Q.within = plm(ikn ~ qn, pTobinQ, model = "within") # estima��o within

# Comparando as estimativas
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
- Observe que:
    - as vari�veis entram na estima��o sem nenhuma transforma��o e
    - ambos m�todos possuem mesmos graus de liberdade


<!-- ### Estima��o via lm() -->

<!-- N�s podemos construir as vari�veis de m�dia e de desvios de m�dia diretamente no data frame e fazer a estima��o _within_ via `lm()` -->

<!-- ```{r message=FALSE, warning=FALSE} -->
<!-- # Pacote para manipular base de dados -->
<!-- library(dplyr) -->

<!-- # Criando "na m�o" as vari�veis de desvios da m�dia para cada indiv�duo -->
<!-- TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip (indiv�duo) -->
<!--     mutate( -->
<!--         ikn_bar = mean(ikn), # "transforma��o" between de ikn -->
<!--         qn_bar = mean(qn), # "transforma��o" between de qn -->
<!--         ikn_desv = ikn - ikn_bar, # "transforma��o" within de ikn -->
<!--         qn_desv = qn - qn_bar # "transforma��o" within de qn -->
<!--     ) %>% ungroup() -->

<!-- # Estima��o within via lm() -->
<!-- Q.within.ols = lm(ikn_desv ~ 0 + qn_desv, TobinQ) # retira intercepto com 0 -->

<!-- # Comparando as estimativas -->
<!-- summary(Q.within.ols)$coef # within via MQO -->
<!-- summary(Q.within)$coef # within ajustando graus de liberdade -->
<!-- ``` -->

<!-- - Note que o erro padr�o est� subestimado no output gerado por `lm()`. -->
<!-- - A rotina padr�o de MQO retorna {{<math>}}$\hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{NT-K-1}${{</math>}} e, portanto, � necess�rio fazer ajuste dos graus de liberdade multiplicando a Matriz de Vari�ncias-Covari�ncias dos Erros por {{<math>}}$(NT-K-1) / (NT-K-N)${{</math>}}. -->
<!--   - _Within_ estima mais {{<math>}}$N${{</math>}} par�metros (efeitos fixos dos indiv�duos) e deixa de estimar o intercepto.  -->
<!-- ```{r} -->
<!-- # Pegando valores de N, T e K -->
<!-- N = 188 -->
<!-- T = 35 -->
<!-- K = 1 -->

<!-- # Ajustando a matriz de vari�ncia covari�ncia do estimador -->
<!-- vcov.ols = vcov(Q.within.ols) -->
<!-- vcov.within = vcov.ols * (N*T - K - 1) / (N*(T-1) - K) -->
<!-- se.within = sqrt( diag(vcov.within) ) -->
<!-- se.within -->
<!-- ``` -->


### Estima��o Anal�tica

a) Criando vetores/matrizes e definindo _N_, _T_ e _K_

```r
data("TobinQ", package="pder")

# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz

# Criando a matriz/vetor de covariadas variantes no tempo Xt
Xt = as.matrix( TobinQ[, "qn"] ) # n�o junta com coluna de 1's

# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(Xt) # n�o subtrai 1
```


b) Calculando a matrizes de primeiras diferen�as

{{<math>}}$$\boldsymbol{D} = \boldsymbol{I}_N \otimes \boldsymbol{D}_i $${{</math>}}
em que
{{<math>}}$$\boldsymbol{D}_i = \begin{bmatrix}
-1 & 1 & 0 & \cdots & 0 & 0 \\
0 & -1 & 1 & \cdots & 0 & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & 0 & \cdots & -1 & 1
\end{bmatrix}_{(T-1)\times T}$${{</math>}}


```r
Di = -diag(T) # diagonal -1
diag(Di[-nrow(Di),-1]) = 1 # supradiagonal
Di = Di[-nrow(Di),] # retira �ltima linha

I_N = diag(N) # matriz identidade de tamanho N
D = I_N %x% Di
```


c) Estimativas  de Primeiras-Diferen�as {{<math>}}$\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} = (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^{*})^{-1} \boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{y} $${{</math>}}

```r
dhat_FD = solve( t(Xt) %*% t(D) %*% D %*% Xt ) %*% t(Xt) %*% t(D) %*% D %*% y
dhat_FD
```

```
##             [,1]
## [1,] 0.004012382
```

d) Valores ajustados/preditos de Primeiras-Diferen�as {{<math>}}$\hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}} = \boldsymbol{X}^{*} \hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}} $${{</math>}}


```r
yhat_FD = Xt %*% dhat_FD
```


e) Res�duos de Primeiras-Diferen�as {{<math>}}$\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{FD}}${{</math>}}

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{FD}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{FD}} $${{</math>}}


```r
ehat_FD = y - yhat_FD
```


f) Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2_v = \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{D}' \boldsymbol{D} \hat{\boldsymbol{\varepsilon}}}{NT-K-N} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2_v${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2v = as.numeric( (t(ehat_FD) %*% t(D) %*% D %*% ehat_FD) / (N*T - K - N) )
sig2v
```

```
## [1] 0.006167647
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _within_ para {{<math>}}$NT - K - N${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g) Matriz de Vari�ncias-Covari�ncias do Estimador _Within_

{{<math>}}$$`
    V(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}}) = \sigma^2_v \Big[  (\boldsymbol{X}^{*\prime}  \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \boldsymbol{X}' \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X} (\boldsymbol{X}^{*\prime} \boldsymbol{D}' \boldsymbol{D} \boldsymbol{X}^*)^{-1} \Big]
`$${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
bread = solve( t(Xt) %*% t(D) %*% D %*% Xt )
meat = t(Xt) %*% t(D) %*% D %*% Xt
Vdhat_FD = sig2v * (bread %*% meat %*% bread) # sandwich
Vdhat_FD
```

```
##              [,1]
## [1,] 9.413949e-08
```


i) Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{FD}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_dhat_FD = sqrt( diag(Vdhat_FD) )
se_dhat_FD
```

```
## [1] 0.0003068216
```

j) Estat�stica _t_

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_dhat_FD = dhat_FD / se_dhat_FD
t_dhat_FD
```

```
##          [,1]
## [1,] 13.07725
```

k) P-valor

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_dhat_FD = 2 * pt(-abs(t_dhat_FD), N*T-K-N)
p_dhat_FD
```

```
##              [,1]
## [1,] 1.385139e-38
```

l) Tabela-resumo

```r
cbind(dhat_FD, se_dhat_FD, t_dhat_FD, p_dhat_FD) # resultado Within
```

```
##                    se_dhat_FD                      
## [1,] 0.004012382 0.0003068216 13.07725 1.385139e-38
```

```r
summary(Q.fd)$coef # resultado Within via plm()
```

```
##       Estimate   Std. Error  t-value     Pr(>|t|)
## qn 0.004012382 0.0003068216 13.07725 1.385139e-38
```



#### Transformando e estimando por MQO
Al�m da forma mostrada anteriormente, podemos tamb�m transformar as vari�veis e resolver por MQO, pr�-multiplicando {{<math>}}$\boldsymbol{X}^{*}${{</math>}} e {{<math>}}$\boldsymbol{y}${{</math>}} por {{<math>}}$ \boldsymbol{D}${{</math>}}, e definindo:

{{<math>}}$$\tilde{\boldsymbol{X}^{*}} \equiv \boldsymbol{D} \boldsymbol{X}^{*} \qquad \text{e} \qquad \tilde{\boldsymbol{y}} \equiv \boldsymbol{D} \boldsymbol{y}$${{</math>}}

c') Estimativas _within_ via MQO

{{<math>}}$$ \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} = (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} \tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{y}} $${{</math>}}

```r
# Transformando vari�veis
Xt_til = D %*% Xt
y_til = D %*% y

# Estimando
dhat_OLS = solve( t(Xt_til) %*% Xt_til ) %*% t(Xt_til) %*% y_til
dhat_OLS
```

```
##             [,1]
## [1,] 0.004012382
```

d') Valores ajustados/preditos _OLS_

{{<math>}}$$ \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} = \tilde{\boldsymbol{X}^{*}} \tilde{\hat{\boldsymbol{\delta}}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
yhat_OLS = Xt_til %*% dhat_OLS
```

e') Res�duos MQO

{{<math>}}$$ \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} = \boldsymbol{y} - \hat{\boldsymbol{y}}_{\scriptscriptstyle{MQO}} $${{</math>}}


```r
ehat_OLS = y_til - yhat_OLS
```

f') Vari�ncia do termo de erro

{{<math>}}$$ \hat{\sigma}^2 \equiv  \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}}{NT - K - N} $${{</math>}}

Como {{<math>}}$\hat{\sigma}^2${{</math>}} � escalar, � conveniente transformar em "matriz 1x1" em n�mero usando `as.numeric()`:

```r
# Calculando vari�ncias dos termos de erro
sig2hat = as.numeric( (t(ehat_OLS) %*% ehat_OLS) / (N*T - K - N) )
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _within_ para {{<math>}}$NT - K - 1${{</math>}} (ao inv�s de {{<math>}}$NT - K - 1${{</math>}})


g') Matriz de Vari�ncias-Covari�ncias do Estimador MQO

{{<math>}}$$ \widehat{\text{Var}}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{MQO}}) = \hat{\sigma}^2 (\tilde{\boldsymbol{X}^{*\prime}} \tilde{\boldsymbol{X}^{*}})^{-1} $${{</math>}}


```r
# Calculando a Matriz de vari�ncia-covari�ncia dos estimadores
Vdhat_OLS = sig2hat * solve( t(Xt_til) %*% Xt_til )
Vdhat_OLS
```

```
##              [,1]
## [1,] 9.413949e-08
```


h') Erros-padr�o {{<math>}}$\text{se}(\hat{\boldsymbol{\delta}}_{\scriptscriptstyle{OLS}})${{</math>}}

?? a raiz quadrada da diagonal principal da Matriz de Vari�ncias-Covari�ncias do Estimador

```r
se_dhat_OLS = sqrt( diag(Vdhat_OLS) )
se_dhat_OLS
```

```
## [1] 0.0003068216
```

i') Estat�stica _t_

{{<math>}}$$ t_{\hat{\delta}_k} = \frac{\hat{\delta}_k}{\text{se}(\hat{\delta}_k)} \tag{4.6}
$$ {{</math>}}


```r
# C�lculo da estat�stica t
t_dhat_OLS = dhat_OLS / se_dhat_OLS
t_dhat_OLS
```

```
##          [,1]
## [1,] 13.07725
```

j') P-valor

{{<math>}}$$ p_{\hat{\delta}_k} = 2.\Phi_{t_{(NT-K-N)}}(-|t_{\hat{\delta}_k}|), \tag{4.7} $${{</math>}}


```r
# p-valor
p_dhat_OLS = 2 * pt(-abs(t_dhat_OLS), N*T-K-N)
p_dhat_OLS
```

```
##              [,1]
## [1,] 1.385139e-38
```

k') Tabela-resumo

```r
cbind(dhat_OLS, se_dhat_OLS, t_dhat_OLS, p_dhat_OLS) # resultado FD via MQO
```

```
##                   se_dhat_OLS                      
## [1,] 0.004012382 0.0003068216 13.07725 1.385139e-38
```

```r
summary(Q.fd)$coef # resultado FD via plm()
```

```
##       Estimate   Std. Error  t-value     Pr(>|t|)
## qn 0.004012382 0.0003068216 13.07725 1.385139e-38
```



</br>

## Comparativo dos Estimadores

### MQGF: jun��o MQE e _Within_
- Combina��o de MQE (Efeitos Aleat�rios) e de _Within_ (Efeitos Fixos)
- Lembre-se que a Matriz de Vari�ncias-Covari�ncias dos Erros � dada por
{{<math>}}$$ \hat{\boldsymbol{\Sigma}}^p = (\hat{\sigma}^2_v)^p \boldsymbol{W} + (\hat{\sigma}^2_v + T \hat{\sigma}^2_u)^p \boldsymbol{B}, \tag{2.29} $${{</math>}}
em que {{<math>}}$p${{</math>}} � um escalar.

- Usando {{<math>}}$p=-0.5${{</math>}} em (2.29), tem-se
{{<math>}}$$ \boldsymbol{\Sigma}^{-0.5} = \frac{1}{\sigma_v + T \sigma_u} \boldsymbol{B} + \frac{1}{\sigma_v} \boldsymbol{W} $${{</math>}}

- Anteriormente, transformamos MQGF usando {{<math>}}$\tilde{\boldsymbol{y}} \equiv \boldsymbol{\Sigma}^{-0.5}y${{</math>}} e {{<math>}}$\tilde{\boldsymbol{X}} \equiv \boldsymbol{\Sigma}^{-0.5}Z${{</math>}}:

{{<math>}}\begin{align}
    \hat{\boldsymbol{\beta}} &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1} (\boldsymbol{X}' \boldsymbol{\Sigma}^{-1} \boldsymbol{y}) \tag{2.27} \\
    &= (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5\prime} \boldsymbol{\Sigma}^{-0.5} \boldsymbol{X})^{-1} (\boldsymbol{X}' \boldsymbol{\Sigma}^{-0.5}\boldsymbol{\Sigma}^{-0.5\prime} \boldsymbol{y}) \\
    &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}} \tilde{\boldsymbol{y}}
\end{align}{{</math>}}

Sem perda de generalidade, podemos pr�-multiplicar o modelo por {{<math>}}$\sigma_v \boldsymbol{\Sigma}^{-0.5}${{</math>}} (ao inv�s de {{<math>}}$\boldsymbol{\Sigma}^{-0.5})${{</math>}}, logo:

{{<math>}}\begin{align} \boldsymbol{\Sigma}^{-0.5} &= \sqrt{\frac{1}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \frac{1}{\sigma_v} \boldsymbol{W} \\
&= \frac{1}{\sigma_v} \left[ \sigma_v \sqrt{\frac{1}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \boldsymbol{W} \right] \\
&= \frac{1}{\sigma_v} \left[ \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + \boldsymbol{W} \right] \\
&= \frac{1}{\sigma_v} \left[ \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} + (\boldsymbol{I} - \boldsymbol{B}) \right] \\
&= \frac{1}{\sigma_v} \left[ \boldsymbol{I} + \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \boldsymbol{B} - \boldsymbol{B} \right] \\
&=\frac{1}{\sigma_v} \left[ \boldsymbol{I} - \left( 1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right) \boldsymbol{B} \right] \\
\end{align}{{</math>}}




Logo, quando pr�-multiplicamos as vari�veis por {{<math>}}$\boldsymbol{\Sigma}^{-0.5}${{</math>}}, para uma vari�vel explicativa {{<math>}}$k${{</math>}} do indiv�duo {{<math>}}$i${{</math>}} no tempo {{<math>}}$t${{</math>}}, segue que:
{{<math>}}$$ \tilde{x}^k_{it}\ =\ \frac{1}{\sigma_v} \left[ x^k_{it} + \left(1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right) \bar{x}^k_{i}\right]\ \equiv\ \frac{1}{\sigma_v} \left[ x_{it} - \theta \bar{x}^k_{i}\right], $${{</math>}}
em que {{<math>}}$$\theta \equiv \left( 1 - \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T \sigma^2_u}} \right)$${{</math>}}

    
Note que, quando:

- {{<math>}}$\theta \rightarrow 1${{</math>}}
  - os efeitos individuais dominam {{<math>}}$\sigma_u \rightarrow \infty${{</math>}}
  - vari�vel transformada se aproxima da em desvios: {{<math>}}$x^k_{it} - \bar{x}^k_{i}${{</math>}}
  - MQGF se aproxima do estimador _within_
- {{<math>}}$\theta \rightarrow 0${{</math>}}
  - os efeitos individuais somem: {{<math>}}$\sigma_u \rightarrow 0${{</math>}}
  - vari�vel transformada se aproxima da n�o transformada: {{<math>}}$x^k_{it}${{</math>}}
  - MQGF se aproxima do MQE 



### Exemplo 1


```r
library(plm)
data("TobinQ", package = "pder")
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��es MQGF
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
summary(Q.walhus) # output da estima��o MQGF por Wallace e Hussain (1969)
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
Note que {{<math>}}$\theta = 73\%${{</math>}}, o que indica que, neste caso, o estimativa MQGF � mais pr�xima de _within_ ({{<math>}}$\theta=1${{</math>}}) do que de _between_ ({{<math>}}$\theta=0${{</math>}}). A grande quantidade de per�odos ({{<math>}}$T = 35${{</math>}}) provavelmente influencia este alto valor.



### Exemplo 2
- Se��o 2.4.4 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Usado por Kinal e Lahiri (1993) 
- Queremos estabelecer rela��o entre importa��es (_imports_) e produto nacional (_gnp_)

```r
data("ForeignTrade", package = "pder")
FT = pdata.frame(ForeignTrade, index=c("country", "year"))

# Estima��es MQGF
FT.between = plm(imports ~ gnp, FT, model = "between")
FT.pooled = plm(imports ~ gnp, FT, model = "pooling")
FT.fgls = plm(imports ~ gnp, FT, model = "random", random.method = "walhus")
FT.within = plm(imports ~ gnp, FT, model = "within")

# Resumindo 4 estima��es em �nica tabela
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
# Resumo do MQGF
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
- O estimador MQGF remove grande parte da varia��o inter-indiv�duos, pois subtrai, da covariada, 94\% da m�dia individual:
{{<math>}}$$ \tilde{x}_{it}\ =\ x_{it} - \theta \bar{x}_{i}\ =\ x_{it} - 0,94 \bar{x}_{i} $${{</math>}}


<center><img src="../example_panel-1.png"></center>

- MQGF e _within_ s�o bastante parecidos
- MQE � parecido com _between_, pois maior peso fica na variabilidade entre indiv�duos


</br>

## Estimador MV
- Se��o 3.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Uma alternativa aos estimadores de MQGF � o de m�xima verossimilhan�a (MV).
- Assume-se que a distribui��o dos dois componentes de erro s�o normais:
{{<math>}}$$ u | X \sim N(0, \sigma^2_u) \quad \text{ e } \quad v | u, X \sim N(0, \sigma^2_v) $${{</math>}}

- Ao inv�s de estimar {{<math>}}$\sigma^2_u${{</math>}} e {{<math>}}$\sigma^2_v${{</math>}} para depois calcular {{<math>}}$\boldsymbol{\beta}${{</math>}}, ambos s�o estimados simultaneamente.

- Denote 
{{<math>}}$\phi \equiv \sqrt{\frac{\sigma^2_v}{\sigma^2_v + T\sigma^2_u}},${{</math>}}
a fun��o de log-verossimilhan�a para um painel balanceado �:


<!-- {{<math>}}$$ \ln{L} = -\frac{NT}{2} \ln{2\pi} - \frac{NT}{2}\ln{\sigma^2_v} + \frac{N}{2} \ln{\phi^2} - \frac{1}{2\sigma^2_v} \left( \varepsilon' \boldsymbol{W} \varepsilon + \phi^2 \varepsilon' \boldsymbol{B} \varepsilon \right) $${{</math>}} -->


e considere a transforma��o de vari�vel pela pr�-multiplica��o por {{<math>}}$(\boldsymbol{I} - \phi \boldsymbol{B})${{</math>}}:

{{<math>}}$$\tilde{\boldsymbol{X}}\ \equiv\ (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{X}\ =\ \boldsymbol{X} - \phi \boldsymbol{B} \boldsymbol{X}$${{</math>}}

Logo,

{{<math>}}\begin{align}
    \hat{\boldsymbol{\beta}} &= (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{\boldsymbol{X}}'\tilde{\boldsymbol{y}} \tag{3.12} \\
    \hat{\sigma}^2_v &= \frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}} + \hat{\phi}^2 \hat{\boldsymbol{\varepsilon}}' \boldsymbol{B} \hat{\boldsymbol{\varepsilon}}}{NT} \tag{3.13} \\
    \hat{\phi}^2 &=\frac{\hat{\boldsymbol{\varepsilon}}' \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}}{(T-1) \hat{\boldsymbol{\varepsilon}}'\boldsymbol{B}\hat{\boldsymbol{\varepsilon}}} \tag{3.14}
\end{align}{{</math>}}

A estima��o pode ser feita iterativamente por FIML (Full Information Maximum Likelihood):


1. Chute inicial de {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}}
2. Calcular {{<math>}}$\hat{\phi}^2${{</math>}} usando (3.14)
3. Calcular {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} usando (3.12) 
4. Verificar converg�ncia: se n�o convergiu, volta para o passo 2, usando o {{<math>}}$\hat{\boldsymbol{\beta}}${{</math>}} calculado no passo 3.
5. Calcular {{<math>}}$\sigma^2_v${{</math>}} usando (3.13)


### Estima��o via `pglm()`


```r
library(pglm)
library(dplyr)
data("TobinQ", package = "pder")

# Transformando no formato pdata frame, com indentificador de indiv�duo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estima��o MV
Q.ml = pglm(ikn ~ qn, pTobinQ, family = "gaussian") # Estima��o MV
Q.fgls = plm(ikn ~ qn, pTobinQ, model="random",
             random.method="walhus") # Estima��o FGLS

summary(Q.ml)$estimate # Coef. MV
```

```
##                Estimate   Std. error   t value       Pr(> t)
## (Intercept) 0.159327956 0.0034343786  46.39208  0.000000e+00
## qn          0.003861798 0.0001683923  22.93334 2.160874e-116
## sd.id       0.045073677 0.0025010701  18.02176  1.315002e-72
## sd.idios    0.073023338 0.0006452452 113.17145  0.000000e+00
```

```r
summary(Q.fgls)$coef # Coef. MQGF
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```
- Note que o resultado por ML foi bem pr�ximo ao do obtido por MQGF



### Estima��o Anal�tica

a) Chutar valores iniciais para as estimativas {{<math>}}$\hat{\beta}_{\scriptscriptstyle{ini}}${{</math>}} (pode usar tudo 0)


```r
data("TobinQ", package="pder")

# Criando o vetor y
y = as.matrix(TobinQ[,"ikn"]) # transformando coluna de data frame em matriz

# Criando a matriz de covariadas X com primeira coluna de 1's
X = as.matrix( cbind(1, TobinQ[, "qn"]) ) # juntando 1's com as covariadas

# Pegando valores N, T e K
N = length( unique(TobinQ$cusip) )
T = length( unique(TobinQ$year) )
K = ncol(X) - 1

# Matrizes Between e Within
iota_T = matrix(1, nrow=T, ncol=1)
I_N = diag(N)
I_NT = diag(N*T)
B = I_N %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = I_NT - B

# Iremos realizar itera��es at� a converg�ncia das estimativas
tol = 1e-10 # toler�ncia para converg�ncia
dist = 1 # dist�ncia inicial, apenas para entrar no loop/while
it = 0 # n�mero de itera��es

# (a) Chutar valores iniciais para as estimativas
bhat_ini = matrix(0, nrow=2, ncol=1) # chute inicial de 0's
bhat_ini
```

```
##      [,1]
## [1,]    0
## [2,]    0
```

b) Obter {{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}}${{</math>}} e calcular 
		{{<math>}}$$ \hat{\phi}^2 = \frac{\hat{\varepsilon}' \boldsymbol{W} \hat{\varepsilon}}{(T-1)\hat{\varepsilon}' \boldsymbol{B} \hat{\varepsilon}} \tag{3.14} $${{</math>}}
		
		
c) Calcular as novas estimativas {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}}${{</math>}} novo usando
		{{<math>}}$$ \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}} = (\tilde{\boldsymbol{X}}'\tilde{\boldsymbol{X}})^{-1} \tilde{X}'\tilde{y}, \tag{3.12} $${{</math>}}
		em que {{<math>}}$\tilde{\boldsymbol{X}} = (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{X}${{</math>}}, e {{<math>}}$\tilde{\boldsymbol{y}} = (\boldsymbol{I} - \phi \boldsymbol{B}) \boldsymbol{y}${{</math>}}


d) Verificar converg�ncia das estimativas de acordo com:
		{{<math>}}$$ \text{dist�ncia}\ =\ \max\{\text{abs}(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{ini}})\}\}\ <\ 1 \times 10^{-10}\ =\ \text{toler�ncia}$${{</math>}}
		Se n�o convergiu (i.e., express�o acima n�o foi satisfeita), volte ao passo (b), definindo {{<math>}}$\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{ini}} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{fim}}${{</math>}} e iniciando uma nova itera��o



```r
while (dist > tol) {
	# Mostrar a itera��o atual e as estimativas atuais beta
	print(paste0("itera��o ", it,
	      ": b0 = ", round(bhat_ini[1], 6),
        " | b1 = ", round(bhat_ini[2], 6)
	))
	
	# (b)  Obter valores ajustados, res�duos e estimar phi
	y_hat = X %*% bhat_ini
	e = y - y_hat
	phi2_hat = as.numeric((t(e) %*% W %*% e) / ((T-1) * (t(e) %*% B %*% e)))
	phi_hat = sqrt(phi2_hat)

	# (c) Calcular o novas estimativas
	X_til = (I_NT - phi_hat * B) %*% X
	y_til = (I_NT - phi_hat * B) %*% y
	bhat_fim = solve(t(X_til) %*% X_til) %*% t(X_til) %*% y_til
	
	# (d) Verificar converg�ncia das estimativas
	dist = max(abs(bhat_fim - bhat_ini)) # calculando dist�ncia
	bhat_ini = bhat_fim
	it = it + 1
}
```

```
## [1] "itera��o 0: b0 = 0 | b1 = 0"
## [1] "itera��o 1: b0 = 0.158127 | b1 = 0.004341"
## [1] "itera��o 2: b0 = 0.158491 | b1 = 0.004196"
## [1] "itera��o 3: b0 = 0.158491 | b1 = 0.004196"
## [1] "itera��o 4: b0 = 0.158491 | b1 = 0.004196"
```


e) Obter {{<math>}}$\hat{\boldsymbol{\varepsilon}} = \boldsymbol{y} - \hat{\boldsymbol{y}}${{</math>}} e {{<math>}}$ \hat{\phi}^2 ${{</math>}} para calcular
		{{<math>}}$$\hat{\sigma}^2_v = \frac{\hat{\varepsilon}' \boldsymbol{W} \hat{\varepsilon} + \hat{\phi}^2 \hat{\varepsilon}' \boldsymbol{B} \hat{\varepsilon}}{NT} \tag{3.13} \qquad \text{e} \qquad \sigma^2_l = \frac{\sigma^2_v}{\hat{\phi}^2}  $${{</math>}}


```r
# (e) Calcular phi, sigma^2_v, e sigma^2_l
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
# (g) Calcular V(bhat)
Vbhat = solve(c(1/sig2v) * t(X) %*% W %*% X + c(1/sig2l) * t(X) %*% B %*% X)
Vbhat
```

```
##               [,1]          [,2]
## [1,]  1.171015e-05 -7.095051e-08
## [2,] -7.095051e-08  2.831961e-08
```

h) Obter erros padr�o das estimativas, estat�sticas t e p-valores

```r
# (h) Erros padr�o, estatistica t e p-valores
se_bhat = sqrt(diag(Vbhat))
t_bhat = bhat_fim / se_bhat
p_bhat = pt(-abs(t_bhat), df = N*T-K-1) # NT - K - 1

cbind(bhat_fim, se_bhat, t_bhat, p_bhat) # Resultados
```

```
##                       se_bhat                      
## [1,] 0.158490653 0.0034220099 46.31508  0.00000e+00
## [2,] 0.004196004 0.0001682843 24.93402 1.68128e-131
```

```r
summary(Q.ml)$estimate # Estima��o MV via pglm()
```

```
##                Estimate   Std. error   t value       Pr(> t)
## (Intercept) 0.159327956 0.0034343786  46.39208  0.000000e+00
## qn          0.003861798 0.0001683923  22.93334 2.160874e-116
## sd.id       0.045073677 0.0025010701  18.02176  1.315002e-72
## sd.idios    0.073023338 0.0006452452 113.17145  0.000000e+00
```


</br>

## Testes de Presen�a de Efeitos Individuais

### Breusch-Pagan

- Se��o 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- ?? um teste baseado em multiplicadores de Lagrange (LM) nos res�duos de MQO, em que {{<math>}}$H_0: \sigma^2_u = 0${{</math>}} (aus�ncia de efeitos individuais)
- A estat�stica teste � dada por 
{{<math>}}$$ LM_u = \frac{NT}{2(T-1)} \left( T \frac{\hat{\boldsymbol{\varepsilon}}' B_u \hat{\boldsymbol{\varepsilon}}}{\hat{\boldsymbol{\varepsilon}}' \hat{\boldsymbol{\varepsilon}}} - 1 \right)^2  $${{</math>}}
que � assintoticamente distribu�da como ua `\(\chi^2\)` com 1 grau de liberdade.
- H� algumas varia��es deste teste:
    - Breusch and Pagan (1980),
    - Gourieroux et al. (1982),
    - Honda (1985), e
    - King and Wu (1997).


### Testes F
- Se��o 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Sejam a soma dos res�duos ao quadrado e os graus de liberdade do modelo _within_ {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W${{</math>}} e {{<math>}}$N(T-1) - K${{</math>}}, respectivamente.
- Sejam a soma dos res�duos ao quadrado e os graus de liberdade do modelo pooled MQO {{<math>}}$\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}}\hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}}${{</math>}} e {{<math>}}$NT - K - 1${{</math>}}, respectivamente.
- Sob hip�tese nula de que n�o h� efeitos individuais, a estat�stica teste � dada por
{{<math>}}$$ \frac{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{MQO}} \boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_{\scriptscriptstyle{MQO}} - \hat{\boldsymbol{\varepsilon}}'_W\hat{\boldsymbol{\varepsilon}}_W}{\hat{\boldsymbol{\varepsilon}}'_{\scriptscriptstyle{W}}\boldsymbol{W} \hat{\boldsymbol{\varepsilon}}_W} \frac{NT - K - N + 1}{N-1} $${{</math>}}
que segue uma distribui��o F de Fisher-Snedecor com {{<math>}}$N-1${{</math>}} e {{<math>}}$NT - K - N + 1${{</math>}} graus de liberdade.


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
- Se��o 4.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Continuamos assumindo que {{<math>}}$E(v|X) = 0${{</math>}}, em que {{<math>}}$v${{</math>}} � o termo de erro idiossincr�tico.
- Nestes testes, verificamos se {{<math>}}$E(u|X) = 0${{</math>}}, ou seja, se os efeitos individuais s�o ou n�o s�o correlacionados com as covariadas.

### Teste de Hausman
- O princ�pio geral do teste de Hausman consiste em comparar dois modelos {{<math>}}$A${{</math>}}e {{<math>}}$B${{</math>}} tal que
    - sob {{<math>}}$H_0${{</math>}}: {{<math>}}$A${{</math>}} e {{<math>}}$B${{</math>}} s�o ambos consistentes, mas {{<math>}}$B${{</math>}} � mais eficiente que {{<math>}}$A${{</math>}}
    - sob {{<math>}}$H_1${{</math>}}: apenas {{<math>}}$A${{</math>}} � consistente
- Se {{<math>}}$H_0${{</math>}} � verdadeiro, ent�o os coeficientes dos dois modelos n�o devem divergir.
- O teste � baseado em {{<math>}}$\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B${{</math>}} e Hausman mostrou que, sob {{<math>}}$H_0${{</math>}}, temos {{<math>}}$cov(\hat{\boldsymbol{\beta}}_A, \hat{\boldsymbol{\beta}}_B) = 0${{</math>}} e, logo, a vari�ncia dessa diferen�a � simplesmente {{<math>}}$V(\hat{\boldsymbol{\beta}}_A - \hat{\boldsymbol{\beta}}_B) = V(\hat{\boldsymbol{\beta}}_A) - V(\hat{\boldsymbol{\beta}}_B)${{</math>}}

- No contexto de dados em pain�is, compara-se o estimador _within_ (efeitos fixos) e o de MQGF (efeitos aleat�rios)
- Quando {{<math>}}$E(u|X) = 0${{</math>}} ambos estimadores s�o consistentes, ou seja,
{{<math>}}$$ \hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_W\ \overset{p}{\rightarrow}\ 0 $${{</math>}}
ent�o � prefer�vel usar o mais eficiente (MQGF, pois usa ambas varia��es inter e intra-indiv�duos).

- Se {{<math>}}$E(u|X) \neq 0${{</math>}}, ent�o {{<math>}}$\hat{q} \equiv \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}\neq 0${{</math>}} e apenas o modelo robusto a {{<math>}}$E(u|X) \neq 0${{</math>}} (_within_) � consistente.
- A vari�ncia � dada por 
{{<math>}}\begin{align}
    V(\hat{q}) &= V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}} - \hat{\boldsymbol{\beta}}_W) = V(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) + V(\hat{\boldsymbol{\beta}}_W) - 2 cov(\hat{\boldsymbol{\beta}}_{\scriptscriptstyle{W}}, \hat{\boldsymbol{\beta}}_{\scriptscriptstyle{MQGF}}) \\
    &= \sigma^2_v (\boldsymbol{X}' \boldsymbol{W X})^{-1} - (\boldsymbol{X}'\boldsymbol{\Sigma}^{-1} \boldsymbol{X})^{-1}
\end{align}{{</math>}}
- Logo, a estat�stica teste se torna
{{<math>}}$$ \hat{q}'\ V(\hat{q})^{-1}\ \hat{q} $${{</math>}}
que, sob {{<math>}}$H_0${{</math>}}, � distribuida como {{<math>}}$\chi^2${{</math>}} com {{<math>}}$K${{</math>}} graus de liberdade.


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
N�o se rejeita a hip�tese nula de que ambos modelos s�o consistentes a 5\%.


<!-- </br> -->

<!-- {{< cta cta_text="?Y'? Proceed to Instrumental Variable" cta_link="../sec11" >}} -->


