---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Ferramentas do R
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Ferramentas do R
weight: 1
output: md_document
type: book
---



- Baseado, principalmente, nos cursos da [_Especialização em Data Science_](https://www.coursera.org/specializations/jhu-data-science) da universidade John Hopkins (disponível no Coursera).
- Não é possível fazer a Especialização gratuitamente, mas é possível "participar como ouvinte" (_audit course_), o que permite acessar quase todo material (mas não pode fazer os testes e, portanto, não ganha certificado ao concluí-lo). 
- Em cada tema abordado serão citadas as fontes, além de incluir aos vídeos dos cursos citados acima para que possam aprofundar nos estudos.


## Instalando R
- [Installing R (John Hopkins/Coursera)](https://www.coursera.org/learn/data-scientists-tools/lecture/y6mU2/installing-r)

1. Instalação da base do R ([CRAN](https://cran.r-project.org))
    - Download R for Windows > base > Download R X.X.X for Windows
    - Se o computador for 64-bits, opte pela versão 64-bits

2. Instalação do Rtools ([CRAN](https://cran.r-project.org))
    - Download R for Windows > Rtools > Installing Rtools > rtools40-x86_XX.exe
    - É um conjunto de ferramentas de compilação de várias linguagens (C, C++ e Fortran) que são necessários em alguns pacotes no R

3. Instalação do RStudio ([RStudio Dowload](https://www.rstudio.com/products/rstudio/download/#download))
    - Download RStudio Desktop
    - É uma interface de usuário para facilitar o uso do R


## Usando R Studio
- [RStudio Tour (John Hopkins/Coursera)](https://www.coursera.org/learn/data-scientists-tools/lecture/0fUNC/rstudio-tour)

RStudio é dividido em 4 quadrantes:

- superior/esquerdo: source - onde ficam "blocos de nota" (scripts) com comandos a serem salvos
- superior/direito: ambiente - visualizar variáveis
- inferior/esquerdo: console - executar os comandos e ver resultados (é o R "bruto")
- inferior/direito: arquivos/gráficos/pacotes/ajuda

> **Dica**: Alterar o tema do RStudio (fundo branco pode cansar mais a visão num tempo mais longo)<br/>  
Tools > Global Options... > Appearance > Editor theme > Cobalt (meu preferido)


### Diretório de trabalho
Definir um diretório de trabalho facilita o acesso aos arquivos da pasta (base de dados, etc.).

> Session > Set Working Directory > Choose Directory...

```r
setwd("C:/Users/Fabio/OneDrive/FEA-RP")
```

> **Dica**: O comando para definir o diretório de trabalho aparecerá no console. Copie e cole no seu script para não precisar definir toda vez que abre o R Studio.

- Note que usa o "slash" (/) ao invés do "backslash" (\\), então não dá para copiar diretamente o endereço de uma pasta e colar no R sem fazer ajustes:
```r
setwd("C:\Users\Fabio\OneDrive\FEA-RP") # ERRADO!
```

```r
setwd("C:/Users/Fabio/OneDrive/FEA-RP") # CORRETO!
setwd("C:\\Users\\Fabio\\OneDrive\\FEA-RP") # CORRETO!
```

Você pode trocar _backslash_ por _slash_, ou duplicar os _backslashs_.


### Executando comandos
- Execução direta no console: escreva `1 + 1` no console e dê \<Enter\>

```r
1 + 1
```

```
## [1] 2
```
- Execução pelo script: escreva o seguinte código abaixo, e dê `Ctrl + Enter` na linha ou no código destacado. Note que o código do script é "jogado" no console.

```r
rnorm(n=10, mean=0, sd=1)  # Gerar 10 números ~ N(0, 1)
```

```
##  [1] -2.4753553 -1.7254668 -0.6607834 -0.6169755 -1.2807018 -0.7161177
##  [7] -1.2834356 -0.6774113  0.9275769 -0.3290734
```

```r
hist(rnorm(n=1000, mean=0, sd=1))  # Histograma dos números gerados
```

<img src="/project/rec2301/sec1/_index_files/figure-html/unnamed-chunk-2-1.png" width="672" />



### Ajuda para comandos
```r
?rnorm
```

```yaml
rnorm(n, mean = 0, sd = 1)

n: number of observations. If length(n) > 1, the length is taken to be the number required.
mean: vector of means.
sd: vector of standard deviations.
```

- Note acima em "Usage" que já há valores pré-definidos para `mean = 0` e `sd = 1`. Portanto, se você só informar o `n`, a função irá funcionar, considerando os valores pré-definidos para os demais argumentos.
- É possível escrever o código sem os nomes dos argumentos, mas devem ser inseridos na mesma ordem do descrito na Ajuda.
```r
rnorm(10, 0, 1)
```
- Também podemos trocar a ordem explicitando o nome do argumento (NÃO RECOMENDADO)
```r
rnorm(mean=0, n=10, sd=1)
```


## Pacotes no R
- Pacotes são coleções de funções, dados e códigos escritos por outras pessoas
- Por ser um software _open source_, o R possui muitos pacotes disponibilizados pela internet e muitos economistas (principalmente econometristas) já desenvolvem e disponibilizam pacotes com as implementações de seus novos métodos.
- A instalação de um pacote só precisa ser feita uma única vez.
- No entanto, caso você atualize uma nova versão do R, é necessário instalar novamente todos os pacotes.
- Os pacotes podem ser obtidos em bibliotecas (_libraries_), como CRAN, e de indivíduos (normalmente disponibilizados no GitHub)
- O CRAN é administrado e, como existe uma curadoria para inserção e manutenção de pacotes, garante qualidade dos pacotes disponibilizados
- Tome cuidado com pacotes disponibilizados por individuos! É possível executar, dentro do R, códigos para criar e apagar arquivos, por exemplo.


### Instalação via CRAN
> quadrante inferior/direito > Packages > Install > (Nomes dos pacotes)

```r
install.packages("ggplot2") # Pacote para criar graficos
```

### Instalação via GitHub
- Primeiro, é necessário instalar o pacote `devtools`
```r
install.packages("devtools")
```
- Depois, é preciso obter o nome do author (do GitHub) e nome do pacote. Como exemplo, iremos baixar o pacote `dplyr` do autor `hadley` (este pacote, na realidade, pode ser baixado direto do CRAN).
- Para executar uma função de um pacote, podemos usar `<pacote>::<funcao>`
```r
devtools::install_github("hadley/dplyr")
```

- Ou é possível carregar o pacote no ambiente e, depois, chamar a função do pacote carregado
```r
library(devtools)
install_github("hadley/dplyr")
```

- CUIDADO! Ao carregar varios pacotes, talvez tenha 2 funções com mesmo nome
    - R prioriza a função do pacote carregado por último

```r
library(dplyr) # Pacote para manipulacao de base de dados
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
library(MASS) # Normalmente nao eh carregado diretamente (via outro pacote)
```

```
## Warning: package 'MASS' was built under R version 4.2.2
```

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

- Uma forma de contornar o problema é usar `<pacote>::<funcao>`
```r
select(obj) # do pacote MASS
dplyr::select(.data, ...) # do pacote dplyr
```

### Atualizando pacotes
> quadrante inferior/direito > Packages > Update > Select All > Install Updates



## Ajuda
- Caso saiba o nome da função, é possível olhar sua documentação escrevendo `?<nome_da_funcao>` (como visto anteriormente)
- Caso saiba o nome do pacote, em alguns casos funciona `?<nome_do_pacote>`, mas o ideal é buscar sua documentação no CRAN (diretamente no site ou via Google)
- Por exemplo, podemos acessar a página do [pacote `dplyr` no CRAN](https://cran.r-project.org/web/packages/dplyr/index.html):
- Nela é possível ver a partir de qual versão do R funciona, os pacotes necessários para o seu funcionamento (Imports), os autores e sites.
- Em Documentação, é possível ver o seu 'Reference manual' onde são expostos o objetivo do pacotes e as funções, incluindo explicações de seu funcionamento.

<center><img src="../dplyr_cran.png"></center>


- Além disso, pode ser interessante ver aplicações do pacote e suas funções nas 'vignettes'. Normalmente são expostas de maneira que podem ser replicadas no seu computador, o que acaba auxiliando na sua aplicação (verificar estrutura de base de dados necessária, sintaxes, etc.). Também pode ser acessada diretamente do R usando a função `browseVignettes()`:

    
```r
browseVignettes("dplyr") # Abrirá uma página com vignettes no seu navegador
```

- Caso não saiba quais funções/pacotes são utilizados para resolver um problema, muitas vezes é possível encontrar a solução no Google utilizando palavras-chave (preferencialmente em inglês) junto de "R".

<center><img src="../google_help.png"></center>

- Além de sites especializados em R e vídeos com exemplos de aplicações, é comum aparecer questões no site Stack Overflow (ou em Cross Validated, pertencente ao mesmo grupo) que é o site mais utilizado por programadores em diversas linguagens para esclarecer dúvidas.

- Por R ser uma linguagem open source, há muitos usuários e, portanto, é comum achar perguntas/respostas que já solucionam o seu problema. Eventualmente, você pode fazer a sua pergunta, caso não encontre uma satisfatória.

<center><img src="../stackoverflow_help.png"></center>



## Sincornização no GitHub
Não será detalhado aqui, mas é algo interessante para olhar.

- [Criação de projetos](https://www.coursera.org/learn/data-scientists-tools/lecture/2o9zr/projects-in-r)
- [Controle de versão](https://www.coursera.org/learn/data-scientists-tools/lecture/PjlHw/version-control)
- [GitHub e Git](https://www.coursera.org/learn/data-scientists-tools/lecture/VOh24/github-and-git)
- [Projetos sob controle de versões](https://www.coursera.org/learn/data-scientists-tools/lecture/wbfrX/projects-under-version-control)



{{< cta cta_text="👉 Seguir para Programação em R" cta_link="../sec2" >}}

