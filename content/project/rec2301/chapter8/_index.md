---
date: "2018-09-09T00:00:00Z"
# icon: book
# icon_pack: fas
linktitle: Dados em Painel
summary: Learn how to use Wowchemy's docs layout for publishing online courses, software
  documentation, and tutorials.
title: Dados em Painel
weight: 8
output: md_document
type: book
---




## Manipulação de dados em painel
- Para o que estamos estudando, é normalmente exigido que os dados estejam
    - no formato _long_: para cada indivíduo, temos uma linha para cada período;
    - _balanceados_: o tamanho da amostra é `\(N \times T\)`, com `\(N\)` indivíduos e `\(T\)` períodos; e
    - devidamente ordenados por indivíduos e, depois, por tempo.


<center><img src="https://www.theanalysisfactor.com/wp-content/uploads/2013/10/image002.jpg"></center>

- Em muitos casos, as informações são disponibilizadas em várias bases de dados de cortes transversais (_cross sections_), então é necessário estruturar a base de dados em painel.
- Isso por ser feito no R de, pelo menos, duas formas:
    - empilhando as bases de dados e filtrando apenas indivíduos que aparecem em todos períodos; ou
    - fazendo a junção interna (_inner join_) das bases por indivíduo e transformando do formato _wide_ para o _long_.
- Como exemplo, usaremos a PNAD Contínua que é publicada trimestralmente e possui o pacote `PNADcIBGE` que auxilia na sua utilização.
- Os dados podem ser obtidos via`read_pnadc(microdata, input_txt)` que necessita que você faça download das **bases de dados** e do **txt com informações das variáveis (_input_txt_)** no [FTP do IBGE](https://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2021):

```r
# install.packages("PNADcIBGE")
library(PNADcIBGE)
```

```
## Warning: package 'PNADcIBGE' was built under R version 4.2.2
```

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
- O arquivo compactado .zip é cerca de 12\% do arquivo descompactado .txt (133mb `\(\times\)` 1,08gb). Para não precisar manter o arquivo .txt no computador, podemos usar a função `unz()` para descompactar arquivos temporariamente:



```r
# Descompactando as bases da PNADc e carregando no R
pnad_012021 = read_pnadc(unz("PNADC_012021_20220224.zip", "PNADC_012021.txt"),
                         input_txt = "input_PNADC_trimestral.txt")

pnad_022021 = read_pnadc(unz("PNADC_022021_20220224.zip", "PNADC_022021.txt"),
                         input_txt = "input_PNADC_trimestral.txt")
```
- Ou também via `get_pnadc(year, quarter = NULL, design = TRUE)`, que faz o download diretamente do R e atribui para um objeto. É necessário informar a data da pesquisa (ano e trimestre) e, para retornar um data frame, altere o argumento para `design = FALSE` (caso contrário, irá retornar um objeto do tipo `survey.design`). Além disso, constrói automaticamente colunas com deflatores:
```r
# OU Carregando as bases da PNADc via get_pnadc()
pnad_012021 = get_pnadc(year=2021, quarter=1, design=FALSE)
pnad_022021 = get_pnadc(year=2021, quarter=2, design=FALSE)

```

- Para identificar um indivíduo na base do PNAD, o IBGE usa as seguintes [variáveis-chave](https://www.ibge.gov.br/estatisticas/downloads-estatisticas.html?caminho=Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/Documentacao):
    - _UPA_: Unidade Primária de Amostragem / UF (2) + Nº Sequencial (6) + DV (1)
    - _V1008_: Número do domicílio (01 a 14)
    - _V1014_: Painel/Grupo de amostra (01 a 99)
    - _V2003_: Número de ordem (01 a 30)
- Pesquisadores do Ipea ([Teixeira Júnior et al., 2020](http://repositorio.ipea.gov.br/bitstream/11058/9951/1/bmt_67_nt_pesos_longitudinais.pdf)) usam mais algumas variáveis-chave invariantes no tempo para tornar esse 
    - _V2007_: Sexo
    - _V2008_/_V20081_/_V20082_: Data de nascimento (dia/mês/ano)
- Além disso, vamos adicionar mais algumas variáveis:
    - _invariante no tempo_:
        - _UF_: Unidade da Federação
    - _variantes no tempo_:
        - _V2009_: Idade (em anos)
        - _VD4020_: Rendimento mensal efetivo de todos os trabalhos para pessoas de 14 anos ou mais de idade


```r
# Boas práticas (pricipalmente usando base de dados grandes):
# - Não manipular o objeto em que você carregou a base de dados -> crie um novo
# - Selecione apenas as variáveis que for utilizar

lista_var = c("Trimestre", "UPA", "V1008", "V1014", "V2003", "V2007", "V2008",
              "V20081", "V20082", "UF", "V2009", "VD4020")

# Selecionando e renomeando variáveis, e filtrando apenas maiores de 14 anos 
pnad_1 = pnad_012021 %>% select(all_of(lista_var)) %>%
    rename(DOMIC = V1008, PAINEL = V1014, ORDEM = V2003, SEXO = V2007, 
           DIA_NASC = V2008, MES_NASC = V20081, ANO_NASC = V20082, 
           IDADE = V2009, RENDA = VD4020) %>%
    filter(IDADE >= 14)

pnad_2 = pnad_022021 %>% select(all_of(lista_var)) %>%
    rename(DOMIC = V1008, PAINEL = V1014, ORDEM = V2003, SEXO = V2007, 
           DIA_NASC = V2008, MES_NASC = V20081, ANO_NASC = V20082, 
           IDADE = V2009, RENDA = VD4020) %>%
    filter(IDADE >= 14)
```



### Empilhando bases de dados e filtrando indivíduos que aparecem em todos os períodos
- Primeiro, empilharemos as bases de dados usando `rbind()`. É necessário garantir que tenham o mesmo número de colunas e estas sejam da mesma classe (_character_, _numeric_, etc.):

```r
pnad_bind = rbind(pnad_1, pnad_2)
head(pnad_bind)
```

```
## # A tibble: 6 × 12
##   Trimestre UPA     DOMIC PAINEL ORDEM SEXO  DIA_N…¹ MES_N…² ANO_N…³ UF    IDADE
##   <chr>     <chr>   <chr> <chr>  <chr> <chr> <chr>   <chr>   <chr>   <chr> <dbl>
## 1 1         110000… 01    08     01    2     16      05      1981    11       39
## 2 1         110000… 01    08     02    2     12      06      2000    11       20
## 3 1         110000… 01    08     03    2     15      05      2004    11       16
## 4 1         110000… 01    08     04    1     26      07      1947    11       73
## 5 1         110000… 01    08     05    2     15      08      1961    11       59
## 6 1         110000… 02    08     01    2     11      07      1983    11       37
## # … with 1 more variable: RENDA <dbl>, and abbreviated variable names
## #   ¹​DIA_NASC, ²​MES_NASC, ³​ANO_NASC
```
- Note que a 2ª observação não corresponde à mesma pessoa da 1º linha. Vamos criar uma variável `ID`, juntando informações de todas variáveis-chave, e rearranjar a base de dados de acordo com ela e o trimestre:

```r
pnad_bind = pnad_bind %>% mutate(
    ID = paste0(UPA, DOMIC, PAINEL, ORDEM, SEXO, DIA_NASC, MES_NASC, ANO_NASC)
    ) %>% select(ID, everything()) %>% # reordenando variáveis, começando com ID
    arrange(ID, Trimestre)
head(pnad_bind, 10)
```

```
## # A tibble: 10 × 13
##    ID       Trime…¹ UPA   DOMIC PAINEL ORDEM SEXO  DIA_N…² MES_N…³ ANO_N…⁴ UF   
##    <chr>    <chr>   <chr> <chr> <chr>  <chr> <chr> <chr>   <chr>   <chr>   <chr>
##  1 1100000… 1       1100… 01    08     01    2     16      05      1981    11   
##  2 1100000… 1       1100… 01    08     02    2     12      06      2000    11   
##  3 1100000… 1       1100… 01    08     03    2     15      05      2004    11   
##  4 1100000… 1       1100… 01    08     04    1     26      07      1947    11   
##  5 1100000… 1       1100… 01    08     05    2     15      08      1961    11   
##  6 1100000… 1       1100… 02    08     01    2     11      07      1983    11   
##  7 1100000… 2       1100… 02    08     01    2     11      07      1983    11   
##  8 1100000… 1       1100… 02    08     02    1     99      99      9999    11   
##  9 1100000… 2       1100… 02    08     02    1     99      99      9999    11   
## 10 1100000… 1       1100… 03    08     01    2     09      03      1976    11   
## # … with 2 more variables: IDADE <dbl>, RENDA <dbl>, and abbreviated variable
## #   names ¹​Trimestre, ²​DIA_NASC, ³​MES_NASC, ⁴​ANO_NASC
```
- Observe que o base de dados em painel não está balanceada, ou seja, nem todos os indivíduos aparecem nos 2 trimestres. Portanto, vamos criar um objeto auxiliar com a contagem de vezes que o `ID` aparece em `pnad_bind`

```r
cont_ID = pnad_bind %>% group_by(ID) %>% summarise(cont = n())
head(cont_ID, 10)
```

```
## # A tibble: 10 × 2
##    ID                        cont
##    <chr>                    <int>
##  1 110000016010801216051981     1
##  2 110000016010802212062000     1
##  3 110000016010803215052004     1
##  4 110000016010804126071947     1
##  5 110000016010805215081961     1
##  6 110000016020801211071983     2
##  7 110000016020802199999999     2
##  8 110000016030801209031976     2
##  9 110000016030802103092000     2
## 10 110000016030804118091954     2
```
- Em `cont_ID`, vamos filtrar apenas os caso que aparecem 2 vezes

```r
cont_ID = cont_ID %>% filter(cont == 2)
head(cont_ID, 10)
```

```
## # A tibble: 10 × 2
##    ID                        cont
##    <chr>                    <int>
##  1 110000016020801211071983     2
##  2 110000016020802199999999     2
##  3 110000016030801209031976     2
##  4 110000016030802103092000     2
##  5 110000016030804118091954     2
##  6 110000016040801105081969     2
##  7 110000016040802215011976     2
##  8 110000016040803110071994     2
##  9 110000016040804217051997     2
## 10 110000016050801105071965     2
```
- Voltando para a base `pnad_bind`, vamos filtrar apenas ID's que aparecem no vetor `cont_ID$ID`:

```r
pnad_bind = pnad_bind %>% filter(ID %in% cont_ID$ID)
head(pnad_bind)
```

```
## # A tibble: 6 × 13
##   ID        Trime…¹ UPA   DOMIC PAINEL ORDEM SEXO  DIA_N…² MES_N…³ ANO_N…⁴ UF   
##   <chr>     <chr>   <chr> <chr> <chr>  <chr> <chr> <chr>   <chr>   <chr>   <chr>
## 1 11000001… 1       1100… 02    08     01    2     11      07      1983    11   
## 2 11000001… 2       1100… 02    08     01    2     11      07      1983    11   
## 3 11000001… 1       1100… 02    08     02    1     99      99      9999    11   
## 4 11000001… 2       1100… 02    08     02    1     99      99      9999    11   
## 5 11000001… 1       1100… 03    08     01    2     09      03      1976    11   
## 6 11000001… 2       1100… 03    08     01    2     09      03      1976    11   
## # … with 2 more variables: IDADE <dbl>, RENDA <dbl>, and abbreviated variable
## #   names ¹​Trimestre, ²​DIA_NASC, ³​MES_NASC, ⁴​ANO_NASC
```

```r
N = pnad_bind$ID %>% unique() %>% length() # Nº de indivíduos únicos
T = pnad_bind$Trimestre %>% unique() %>% length() # Nº de trimestre únicos
paste0("N = ", N, ", T = ", T, ", NT = ", N*T)
```

```
## [1] "N = 174468, T = 2, NT = 348936"
```


### Juntado as bases e transformando de _wide_ para _long_
- Agora, juntaremos a base usando a função `inner_join()` que apenas mantém indivíduos que aparecem em ambas bases de dados:

```r
pnad_joined = inner_join(pnad_1, pnad_2, 
                         by=c("UPA", "DOMIC", "PAINEL", "ORDEM", "SEXO",
                              "DIA_NASC", "MES_NASC", "ANO_NASC"),
                         suffix=c("_1", "_2")) # evite usar . como separador
colnames(pnad_joined) # nomes das colunas
```

```
##  [1] "Trimestre_1" "UPA"         "DOMIC"       "PAINEL"      "ORDEM"      
##  [6] "SEXO"        "DIA_NASC"    "MES_NASC"    "ANO_NASC"    "UF_1"       
## [11] "IDADE_1"     "RENDA_1"     "Trimestre_2" "UF_2"        "IDADE_2"    
## [16] "RENDA_2"
```

```r
dim(pnad_joined) # dimensões da base de dados
```

```
## [1] 174468     16
```
- Note que obtivemos a base no formato _wide_ (1 linha para cada indivíduo) e as informações relativas aos 2 períodos (1º e 2º trimestres de 2021) estão em colunas:
    - Os sufixos foram utilizamos para duplicar colunas de informações contidas em ambas bases (e que não foram inseridas no argumento `by`).
    - A variável invariante no tempo _UF_ foi duplicada, então seria interessante incluí-la também como uma ``variável-chave''

```r
pnad_joined = inner_join(pnad_1, pnad_2, 
                         by=c("UPA", "DOMIC", "PAINEL", "ORDEM", "SEXO",
                              "DIA_NASC", "MES_NASC", "ANO_NASC", "UF"),
                         suffix=c("_1", "_2")) # evite usar . como separador
colnames(pnad_joined) # nomes das colunas
```

```
##  [1] "Trimestre_1" "UPA"         "DOMIC"       "PAINEL"      "ORDEM"      
##  [6] "SEXO"        "DIA_NASC"    "MES_NASC"    "ANO_NASC"    "UF"         
## [11] "IDADE_1"     "RENDA_1"     "Trimestre_2" "IDADE_2"     "RENDA_2"
```

```r
dim(pnad_joined) # dimensões da base de dados
```

```
## [1] 174468     15
```
- Observe que temos uma única coluna _UF_ agora e o número de observações manteve-se inalterado, pois os domicílios da amostra de fato não alteraram suas UFs entre estes trimestres.
    - Caso alterasse o número de linhas, a variável invariante no tempo possui algumas observações que alteraram entre os períodos e estas foram excluídas da amostra.
- Também podemos retirar as colunas "Trimestre.1" e "Trimestre.2":

```r
pnad_joined = pnad_joined %>% select(-Trimestre_1, -Trimestre_2)
```
- Estando no formato _wide_, precisamos transformar para o formato _long_


#### Transformando a base de _wide_ para _long_ via `tidyr`
- [Pivoting (_tidyr_)](https://tidyr.tidyverse.org/articles/pivot.html)

- Para fazer transformações em _wide_ ou _long_ usaremos o pacote `tidyr` e suas funções `pivot_longer()`, `pivot_wider()` e `separate()`

```r
library(tidyr)
```

```
## Warning: package 'tidyr' was built under R version 4.2.2
```
- `pivot_longer()`: transforma várias colunas em duas: de nomes e de valores (aumenta o nº de linhas e diminui o de colunas)
```yaml
pivot_longer(
  data,
  cols,
  names_to = "name",
  values_to = "value"
  ...
)
```
- `pivot_wider()`: transforma nomes (valores únicos) de uma variável em várias colunas (aumenta o nº de colunas e diminui o de linhas)
```yaml
pivot_wider(
  data,
  names_from = name,
  values_from = value,
  values_fill = NULL
  ...
)
```
- `separate()`: divide uma coluna em outras a partir de um caracter ``separador''
```yaml
separate(
  data,
  col,
  into,
  sep = "[^[:alnum:]]+"
  ...
)
```

- Primeiro, vamos transformar as colunas variantes no tempo (com sufixos _1 ou _2) em duas colunas

```r
library(tidyr)
pnad_joined2 = pnad_joined %>%
    pivot_longer(
        cols = c(ends_with("_1"), ends_with("_2") ),
        names_to = "VAR_TRI", # nome da coluna que vão os nomes das colunas antigas
        values_to = "VALUE" # nome da coluna com os valores das colunas transformadas
    )
head(pnad_joined2)
```

```
## # A tibble: 6 × 11
##   UPA       DOMIC PAINEL ORDEM SEXO  DIA_N…¹ MES_N…² ANO_N…³ UF    VAR_TRI VALUE
##   <chr>     <chr> <chr>  <chr> <chr> <chr>   <chr>   <chr>   <chr> <chr>   <dbl>
## 1 110000016 02    08     01    2     11      07      1983    11    IDADE_1    37
## 2 110000016 02    08     01    2     11      07      1983    11    RENDA_1    NA
## 3 110000016 02    08     01    2     11      07      1983    11    IDADE_2    37
## 4 110000016 02    08     01    2     11      07      1983    11    RENDA_2    NA
## 5 110000016 02    08     02    1     99      99      9999    11    IDADE_1    31
## 6 110000016 02    08     02    1     99      99      9999    11    RENDA_1    NA
## # … with abbreviated variable names ¹​DIA_NASC, ²​MES_NASC, ³​ANO_NASC
```
- Note que, ao invés de ter 2 linhas por indivíduo, temos 4 (pois temos 2 variáveis variantes no tempo).
- Precisamos jogar metade das linhas de volta para colunas. Vamos usar a função `separate()` para separar _VAR.TRI_ (com 4 valores únicos: _IDADE_1_, _IDADE_2_, _RENDA_1_ e _RENDA_2_) em 2 colunas: _VAR_ (2 valores únicos: _IDADE_ e _RENDA_) e _TRI_ (2 valores únicos: _1_ e _2_).

```r
pnad_joined3 = pnad_joined2[1:100,] %>%
    separate(
        col = "VAR_TRI",
        into = c("VAR", "TRI"), # nomes das colunas separadas
        sep = "_" # caracter que separa as valores da coluna VAR_TRI
    )
head(pnad_joined3)
```

```
## # A tibble: 6 × 12
##   UPA   DOMIC PAINEL ORDEM SEXO  DIA_N…¹ MES_N…² ANO_N…³ UF    VAR   TRI   VALUE
##   <chr> <chr> <chr>  <chr> <chr> <chr>   <chr>   <chr>   <chr> <chr> <chr> <dbl>
## 1 1100… 02    08     01    2     11      07      1983    11    IDADE 1        37
## 2 1100… 02    08     01    2     11      07      1983    11    RENDA 1        NA
## 3 1100… 02    08     01    2     11      07      1983    11    IDADE 2        37
## 4 1100… 02    08     01    2     11      07      1983    11    RENDA 2        NA
## 5 1100… 02    08     02    1     99      99      9999    11    IDADE 1        31
## 6 1100… 02    08     02    1     99      99      9999    11    RENDA 1        NA
## # … with abbreviated variable names ¹​DIA_NASC, ²​MES_NASC, ³​ANO_NASC
```

- Para finalizar, vamos transformar a coluna _VAR_ (com 2 valores únicos: _IDADE_ e _RENDA_) em 2 colunas (_IDADE_ e _RENDA_):

```r
pnad_joined4 = pnad_joined3 %>%
    pivot_wider(
        names_from = "VAR",
        values_from = "VALUE"
    )
pnad_joined4 %>% select(TRI, everything()) %>% head(20)
```

```
## # A tibble: 20 × 12
##    TRI   UPA       DOMIC PAINEL ORDEM SEXO  DIA_NASC MES_N…¹ ANO_N…² UF    IDADE
##    <chr> <chr>     <chr> <chr>  <chr> <chr> <chr>    <chr>   <chr>   <chr> <dbl>
##  1 1     110000016 02    08     01    2     11       07      1983    11       37
##  2 2     110000016 02    08     01    2     11       07      1983    11       37
##  3 1     110000016 02    08     02    1     99       99      9999    11       31
##  4 2     110000016 02    08     02    1     99       99      9999    11       31
##  5 1     110000016 03    08     01    2     09       03      1976    11       44
##  6 2     110000016 03    08     01    2     09       03      1976    11       45
##  7 1     110000016 03    08     02    1     03       09      2000    11       20
##  8 2     110000016 03    08     02    1     03       09      2000    11       20
##  9 1     110000016 03    08     04    1     18       09      1954    11       66
## 10 2     110000016 03    08     04    1     18       09      1954    11       66
## 11 1     110000016 04    08     01    1     05       08      1969    11       51
## 12 2     110000016 04    08     01    1     05       08      1969    11       51
## 13 1     110000016 04    08     02    2     15       01      1976    11       44
## 14 2     110000016 04    08     02    2     15       01      1976    11       45
## 15 1     110000016 04    08     03    1     10       07      1994    11       26
## 16 2     110000016 04    08     03    1     10       07      1994    11       26
## 17 1     110000016 04    08     04    2     17       05      1997    11       23
## 18 2     110000016 04    08     04    2     17       05      1997    11       23
## 19 1     110000016 05    08     01    1     05       07      1965    11       55
## 20 2     110000016 05    08     01    1     05       07      1965    11       55
## # … with 1 more variable: RENDA <dbl>, and abbreviated variable names
## #   ¹​MES_NASC, ²​ANO_NASC
```


#### Extra: Criação de dummies via `pivot_wider()`
- Primeiro, é necessário criar uma coluna de 1's
- Depois usar a função `pivot_wider()`, indicando a variável categórica e a coluna de 1's, preenchendo os NA's com zero (`fill = 0`) :

```r
dummies_sexo = pnad_1 %>% mutate(const = 1) %>% # criando coluna de 1's
    pivot_wider(names_from = SEXO,
                values_from = const,
                values_fill = 0)
head(dummies_sexo)
```

```
## # A tibble: 6 × 13
##   Trimestre UPA     DOMIC PAINEL ORDEM DIA_N…¹ MES_N…² ANO_N…³ UF    IDADE RENDA
##   <chr>     <chr>   <chr> <chr>  <chr> <chr>   <chr>   <chr>   <chr> <dbl> <dbl>
## 1 1         110000… 01    08     01    16      05      1981    11       39  1045
## 2 1         110000… 01    08     02    12      06      2000    11       20  1045
## 3 1         110000… 01    08     03    15      05      2004    11       16    NA
## 4 1         110000… 01    08     04    26      07      1947    11       73    NA
## 5 1         110000… 01    08     05    15      08      1961    11       59    NA
## 6 1         110000… 02    08     01    11      07      1983    11       37    NA
## # … with 2 more variables: `2` <dbl>, `1` <dbl>, and abbreviated variable names
## #   ¹​DIA_NASC, ²​MES_NASC, ³​ANO_NASC
```


#### Outro exemplo 1: _wide_ para _long_
- A base de dados abaixo possui informações de 5 condados com suas repectivas áreas territoriais, proporções de adultos com ensino superior e nº de vagas de emprego em 4 anos distintos:

```r
bd_counties = data.frame(
    county = c("Autauga", "Baldwin", "Barbour", "Bibb", "Blount"),
    area = c(599, 1578, 891, 625, 639),
    college_1970 = c(.064, .065, .073, .042, .027),
    college_1980 = c(.121, .121, .092, .049, .053),
    college_1990 = c(.145, .168, .118, .047, .070),
    college_2000 = c(.180, .231, .109, .071, .096),
    jobs_1970 = c(6853, 19749, 9448, 3965, 7587),
    jobs_1980 = c(11278, 27861, 9755, 4276, 9490),
    jobs_1990 = c(11471, 40809, 12163, 5564, 11811),
    jobs_2000 = c(16289, 70247, 15197, 6098, 16503)
)
bd_counties
```

```
##    county area college_1970 college_1980 college_1990 college_2000 jobs_1970
## 1 Autauga  599        0.064        0.121        0.145        0.180      6853
## 2 Baldwin 1578        0.065        0.121        0.168        0.231     19749
## 3 Barbour  891        0.073        0.092        0.118        0.109      9448
## 4    Bibb  625        0.042        0.049        0.047        0.071      3965
## 5  Blount  639        0.027        0.053        0.070        0.096      7587
##   jobs_1980 jobs_1990 jobs_2000
## 1     11278     11471     16289
## 2     27861     40809     70247
## 3      9755     12163     15197
## 4      4276      5564      6098
## 5      9490     11811     16503
```
- Queremos estruturar a base de dados de modo que, para cada condado, tenhamos 4 linhas (cada uma corresponde a um dos anos: 1970, 1980, 1990 ou 2020). Portanto, teremos 5 colunas: _county_, _year_, _area_, _college_ e _jobs_. Começamos transformando as colunas cujos nomes iniciam com `college_` e com `jobs_` em linhas via `pivot_longer()`:

```r
bd_counties2 = bd_counties %>%
    pivot_longer(
        cols = c( starts_with("college_"), starts_with("jobs_") ),
        names_to = "var_year", # nome da coluna que vão os nomes das colunas antigas
        values_to = "value" # nome da coluna com os valores das colunas transformadas
    )
head(bd_counties2, 10)
```

```
## # A tibble: 10 × 4
##    county   area var_year         value
##    <chr>   <dbl> <chr>            <dbl>
##  1 Autauga   599 college_1970     0.064
##  2 Autauga   599 college_1980     0.121
##  3 Autauga   599 college_1990     0.145
##  4 Autauga   599 college_2000     0.18 
##  5 Autauga   599 jobs_1970     6853    
##  6 Autauga   599 jobs_1980    11278    
##  7 Autauga   599 jobs_1990    11471    
##  8 Autauga   599 jobs_2000    16289    
##  9 Baldwin  1578 college_1970     0.065
## 10 Baldwin  1578 college_1980     0.121
```
- Note que, para cada condado, há duas linhas para cada ano, já que há 2 que variam no tempo (_college_ e _jobs_). Precisamos tirar essa duplicidade de anos. Começamos usando a função `separate()` para separar a variável `var_year` em duas colunas (que chamaremos de `var` e `year`):

```r
bd_counties3 = bd_counties2 %>%
    separate(
        col = "var_year",
        into = c("var", "year"), # nomes das colunas separadas
        sep = "_" # caracter que separa as valores na coluna antiga "var_year" 
    )
head(bd_counties3, 10)
```

```
## # A tibble: 10 × 5
##    county   area var     year      value
##    <chr>   <dbl> <chr>   <chr>     <dbl>
##  1 Autauga   599 college 1970      0.064
##  2 Autauga   599 college 1980      0.121
##  3 Autauga   599 college 1990      0.145
##  4 Autauga   599 college 2000      0.18 
##  5 Autauga   599 jobs    1970   6853    
##  6 Autauga   599 jobs    1980  11278    
##  7 Autauga   599 jobs    1990  11471    
##  8 Autauga   599 jobs    2000  16289    
##  9 Baldwin  1578 college 1970      0.065
## 10 Baldwin  1578 college 1980      0.121
```
- Agora, transformaremos a coluna `var` em 2 colunas (`college`, `jobs`), usando a função `pivot_wider()`:

```r
bd_counties4 = bd_counties3 %>%
    pivot_wider(
        names_from = "var",
        values_from = "value"
    )
bd_counties4 %>% select(county, year, everything()) %>% head(10)
```

```
## # A tibble: 10 × 5
##    county  year   area college  jobs
##    <chr>   <chr> <dbl>   <dbl> <dbl>
##  1 Autauga 1970    599   0.064  6853
##  2 Autauga 1980    599   0.121 11278
##  3 Autauga 1990    599   0.145 11471
##  4 Autauga 2000    599   0.18  16289
##  5 Baldwin 1970   1578   0.065 19749
##  6 Baldwin 1980   1578   0.121 27861
##  7 Baldwin 1990   1578   0.168 40809
##  8 Baldwin 2000   1578   0.231 70247
##  9 Barbour 1970    891   0.073  9448
## 10 Barbour 1980    891   0.092  9755
```
- Observe que, se só houvesse uma variável variante no tempo, não seria necessário usar o `pivot_wider()`, pois haveria 1 linha para cada ano para cada condado.


#### Outro exemplo 2: _long_ para _wide_
- Usaremos agora a base de dados `TravelMode` do pacote `AER` que possui 840 observações em que 210 indivíduos escolhem um modo de viagem entre 4 opções: carro, aéreo, trem ou ônibus.
- Note que cada um dos 210 indivíduos aparecem em 4 linhas, em que cada um corresponde a um dos modos de viagem.
- Há variáveis específicas de
    - indivíduo (_individual_, _income_ e _size_) que são repetidas nas 4 linhas em que aparece, e
    - escolha (_choice_, _wait_, _vcost_, _travel_ e _gcost_) que variam de acordo com os modos de viagem.

```r
data("TravelMode", package = "AER")
head(TravelMode, 8)
```

```
##   individual  mode choice wait vcost travel gcost income size
## 1          1   air     no   69    59    100    70     35    1
## 2          1 train     no   34    31    372    71     35    1
## 3          1   bus     no   35    25    417    70     35    1
## 4          1   car    yes    0    10    180    30     35    1
## 5          2   air     no   64    58     68    68     30    2
## 6          2 train     no   44    31    354    84     30    2
## 7          2   bus     no   53    25    399    85     30    2
## 8          2   car    yes    0    11    255    50     30    2
```
- Agora, vamos fazer com que haja apenas uma linha por indivíduo, retirando a coluna _mode_ e gerando diversas colunas para cada possível modo de viagem.

```r
TravelMode2 = TravelMode %>% 
    pivot_wider(
        names_from = "mode",
        values_from = c("choice":"gcost") # variáveis específicas do modo
    )
head(TravelMode2)
```

```
## # A tibble: 6 × 23
##   individ…¹ income  size choic…² choic…³ choic…⁴ choic…⁵ wait_…⁶ wait_…⁷ wait_…⁸
##   <fct>      <int> <int> <fct>   <fct>   <fct>   <fct>     <int>   <int>   <int>
## 1 1             35     1 no      no      no      yes          69      34      35
## 2 2             30     2 no      no      no      yes          64      44      53
## 3 3             40     1 no      no      no      yes          69      34      35
## 4 4             70     3 no      no      no      yes          64      44      53
## 5 5             45     2 no      no      no      yes          64      44      53
## 6 6             20     1 no      yes     no      no           69      40      35
## # … with 13 more variables: wait_car <int>, vcost_air <int>, vcost_train <int>,
## #   vcost_bus <int>, vcost_car <int>, travel_air <int>, travel_train <int>,
## #   travel_bus <int>, travel_car <int>, gcost_air <int>, gcost_train <int>,
## #   gcost_bus <int>, gcost_car <int>, and abbreviated variable names
## #   ¹​individual, ²​choice_air, ³​choice_train, ⁴​choice_bus, ⁵​choice_car,
## #   ⁶​wait_air, ⁷​wait_train, ⁸​wait_bus
```
- Note que, para cada modo de viagem, foram criadas 5 colunas, que correspondem às 5 variáveis específicas de escolha. No total, foram retiradas 6 colunas (_mode_ + 5 variáveis específicas de escolha) e foram criadas 20 (4 modos `\(\times\)` 5 variáveis específicas de escolha) colunas.
- Em algumas aplicações econométricas (e.g. logit multinomial) é necessário que haja apenas uma coluna indicando a escolha da opção. Então, criaremos a coluna `choice` indicando qual opção escolheu (_air_, _train_, _bus_ ou _car_) e vamos retirar as 4 colunas que começam com "choice_":

```r
TravelMode3 = TravelMode2 %>% 
    mutate(
        choice = case_when(
            choice_air == "yes" ~ "air",
            choice_train == "yes" ~ "train",
            choice_bus == "yes" ~ "bus",
            choice_car == "yes" ~ "car"
        )
    ) %>% select(individual, choice, 
                 starts_with("wait_"), starts_with("vcost_"),
                 starts_with("travel_"), starts_with("gcost_")
                 )

TravelMode3 %>% head(10)
```

```
## # A tibble: 10 × 18
##    individual choice wait_air wait_train wait_…¹ wait_…² vcost…³ vcost…⁴ vcost…⁵
##    <fct>      <chr>     <int>      <int>   <int>   <int>   <int>   <int>   <int>
##  1 1          car          69         34      35       0      59      31      25
##  2 2          car          64         44      53       0      58      31      25
##  3 3          car          69         34      35       0     115      98      53
##  4 4          car          64         44      53       0      49      26      21
##  5 5          car          64         44      53       0      60      32      26
##  6 6          train        69         40      35       0      59      20      13
##  7 7          air          45         34      35       0     148     111      66
##  8 8          car          69         34      35       0     121      52      50
##  9 9          car          69         34      35       0      59      31      25
## 10 10         car          69         34      35       0      58      31      25
## # … with 9 more variables: vcost_car <int>, travel_air <int>,
## #   travel_train <int>, travel_bus <int>, travel_car <int>, gcost_air <int>,
## #   gcost_train <int>, gcost_bus <int>, gcost_car <int>, and abbreviated
## #   variable names ¹​wait_bus, ²​wait_car, ³​vcost_air, ⁴​vcost_train, ⁵​vcost_bus
```



## Notações
- Seção 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- A maioria das notações foram adaptadas de acordo com as notas de aula de Econometria I.

Para a observação do indivíduo {{<math>}}$i \in \{1, ..., N\}${{</math>}} no período {{<math>}}$t \in \{1, ..., T\}${{</math>}}, podemos escrever o modelo a ser estimado como:
{{<math>}}\[ y_{it} = \alpha + x'_{it} \beta + \varepsilon_{it} \]{{</math>}}

em que {{<math>}}$y_{it}${{</math>}} é a variável dependente, {{<math>}}$x_{it}${{</math>}} é o vetor de {{<math>}}$K${{</math>}} covariadas, e o erro {{<math>}}$\varepsilon_{it}${{</math>}} pode ser escrito como:
{{<math>}}\[ \varepsilon_{it} = u_i + \nu_{it},  \]{{</math>}}
sendo {{<math>}}$u_i${{</math>}} o erro individual para o indivíduo {{<math>}}$i${{</math>}} e {{<math>}}$\nu_{it}${{</math>}} é o erro idiossincrático (residual).

Definindo {{<math>}}$\gamma \equiv (\alpha, \beta)${{</math>}} e {{<math>}}$Z_{it} \equiv (1, x_{it})${{</math>}}, o modelo pode ser reescrito como
{{<math>}}\[ y_{it} = z'_{it} \gamma + \varepsilon_{it}. \]{{</math>}}

Para a amostra inteira, supondo que o painel é balanceado, isto é, que possui o mesmo número de observações ({{<math>}}$T${{</math>}}) para todos os indivíduos ({{<math>}}$i${{</math>}}), temos que
{{<math>}}\[ \underbrace{y}_{NT \times 1} = \left( \begin{array}{c}
    y_{11} \\ y_{12} \\ \vdots \\ y_{1T} \\ y_{21} \\ y_{22} \\ \vdots \\ y_{2T} \\ \vdots \\ y_{N1} \\ y_{N2} \\ \vdots \\ y_{NT}
\end{array} \right) \qquad \text{ e } \qquad 
\underbrace{X}_{NT \times K} = \left( \begin{array}{cccc}
    x^1_{11} & x^2_{11} & \cdots & x^K_{11} \\
    x^1_{12} & x^2_{12} & \cdots & x^K_{12} \\
    \vdots & \vdots & \ddots & \vdots \\
    x^1_{1T} & x^2_{1T} & \cdots & x^K_{1T} \\
    x^1_{21} & x^2_{21} & \cdots & x^K_{21} \\
    x^1_{22} & x^2_{22} & \cdots & x^K_{22} \\
    \vdots & \vdots & \ddots & \vdots \\
    x^1_{2T} & x^2_{2T} & \cdots & x^K_{2T} \\
    \vdots & \vdots & \ddots & \vdots \\
    x^1_{N1} & x^2_{N1} & \cdots & x^K_{N1} \\
    x^1_{N2} & x^2_{N2} & \cdots & x^K_{N2} \\
    \vdots & \vdots & \ddots & \vdots \\
    x^1_{NT} & x^2_{NT} & \cdots & x^K_{NT}
\end{array} \right)\]{{</math>}}

Denotando {{<math>}}$\iota${{</math>}} um vetor de 1's de tamanho {{<math>}}$NT${{</math>}}, temos
{{<math>}}\[ y = \alpha \iota + X \beta + \varepsilon \]{{</math>}}
ou, usando {{<math>}}$Z \equiv (\iota,X)${{</math>}} e {{<math>}}$\gamma \equiv (\alpha, \beta)${{</math>}},
{{<math>}}\[ y = Z \gamma + \varepsilon \]{{</math>}}


## Transformações _between_ e _within_
- Seção 2.1.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

Denote {{<math>}}$I_p${{</math>}} a matriz identidade de dimensão {{<math>}}$p${{</math>}}, e {{<math>}}$\iota_q${{</math>}} um vetor de 1's de tamanho {{<math>}}$q${{</math>}}. 

A matriz de transformação **inter-indivíduos (_between_)** é denotada por:
{{<math>}}\[ B\ =\ I_N \otimes \iota_T (\iota'_T \iota_T)^{-1} \iota'_T \]{{</math>}}
Note que a matriz {{<math>}}$B${{</math>}} é equivalente a {{<math>}}$N${{</math>}} nas notas de aula de Econometria I.


Por exemplo, para `\(N = 2\)` e `\(T = 3\)`, segue que:
`\begin{align*}
    B &= \left( \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right) \otimes \left[ \left( \begin{array}{c} 1 \\ 1 \\ 1 \end{array} \right) \frac{1}{3} \left( \begin{array}{ccc} 1 & 1 & 1 \end{array} \right) \right] \\
    &= \left( \begin{array}{cc} 1 & 0 \\ 0 & 1 \end{array} \right) \otimes  \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right)  \\
    &= \left( \begin{array}{cc} 1 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) & 0 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) \\ 0 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) & 1 \left( \begin{array}{ccc} 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \\ 1/3 & 1/3 & 1/3 \end{array} \right) \end{array} \right) \\
    &= \left( \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right)_{NT \times NT},
\end{align*}`

em que `\(\otimes\)` é o produto de Kronecker. Então, temos
{{<math>}}\[ (Bx^k)' = \left( \bar{x}^k_1, \cdots, \bar{x}^k_1, \bar{x}^k_2, \cdots, \bar{x}^k_2, \cdots,\bar{x}^k_N, \cdots, \bar{x}^k_N \right). \]{{</math>}}

Para calcular no R, vamos definir:

```r
N = 2 # número de indivíduos
T = 3 # números de períodos

iota = matrix(rep(1, T), T, 1) # vetor coluna de 1's de tamanho T
iota
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

Vamos obter `\(\iota (\iota' \iota)^{-1} \iota'\)`

```r
# Para obter matriz T x T preenchida por 1/T, sendo T = 3, temos que:
t(iota) %*% iota # produto interno de iotas = quantidade T
```

```
##      [,1]
## [1,]    3
```

```r
solve(t(iota) %*% iota) # tomar a inversa = 1/T
```

```
##           [,1]
## [1,] 0.3333333
```

```r
iota %*% solve(t(iota) %*% iota) %*% t(iota) # pré e pós-multiplicar por iotas
```

```
##           [,1]      [,2]      [,3]
## [1,] 0.3333333 0.3333333 0.3333333
## [2,] 0.3333333 0.3333333 0.3333333
## [3,] 0.3333333 0.3333333 0.3333333
```

Agora, vamos calcular `\(B\ =\ I_N \otimes \iota (\iota' \iota)^{-1} \iota'\)` usando o operador de produto de Kronecker `%x%`:

```r
B = I_N %x% (iota %*% solve(t(iota) %*% iota) %*% t(iota))
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

Agora, vamos definir uma matriz de covariadas `X` e pós-multiplicar pela matriz `B`

```r
K = 3 # número de covariadas
X = matrix(1:(N*T*K), N*T, K) # matriz covariadas NT x K
Z = cbind(rep(1, N*T), X) # incluindo coluna de 1's
Z
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    1    7   13
## [2,]    1    2    8   14
## [3,]    1    3    9   15
## [4,]    1    4   10   16
## [5,]    1    5   11   17
## [6,]    1    6   12   18
```

```r
B %*% Z # matriz de médias das covariadas dado indivíduo (NT x K)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    2    8   14
## [2,]    1    2    8   14
## [3,]    1    2    8   14
## [4,]    1    5   11   17
## [5,]    1    5   11   17
## [6,]    1    5   11   17
```
Note que:

- dada uma variável `\(k\)`, temos um único valor (média) dentro de um mesmo indivíduo;
- coluna 1's permaneceu igual após a transformação _between_.


Já a matriz de transformação **intra-indivíduos (_within_)** é dada por:
{{<math>}}\[ W\ =\ I_{NT} - B\ =\ I_{NT} - \left[ I_N \otimes \iota (\iota' \iota)^{-1} \iota' \right]. \]{{</math>}}

Note que a matriz `\(W\)` é equivalente a `\(M\)` nas notas de aula de Econometria I.

Por exemplo, para `\(N = 2\)` e `\(T = 3\)`, segue que:
`\begin{align*}
    W &= I_{NT} - B \\
    &= \left( \begin{array}{cccccc} 
        1 & 0 & 0 & 0 & 0 & 0 \\
        0 & 1 & 0 & 0 & 0 & 0 \\
        0 & 0 & 1 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1 & 0 & 0 \\
        0 & 0 & 0 & 0 & 1 & 0 \\
        0 & 0 & 0 & 0 & 0 & 1
    \end{array} \right) - \left( \begin{array}{rrrrrr} 
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        1/3 & 1/3 & 1/3 & 0 & 0 & 0 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3 \\
        0 & 0 & 0 & 1/3 & 1/3 & 1/3
    \end{array} \right) \\
    &= \left( \begin{array}{rrrrrr} 
         2/6 & -1/3 & -1/3 &    0 &    0 &    0 \\
        -1/3 &  2/6 & -1/3 &    0 &    0 &    0 \\
        -1/3 & -1/3 &  2/6 &    0 &    0 &    0 \\
           0 &    0 &    0 &  2/6 & -1/3 & -1/3 \\
           0 &    0 &    0 & -1/3 &  2/6 & -1/3 \\
           0 &    0 &    0 & -1/3 & -1/3 &  2/6
    \end{array} \right)_{NT \times NT}, 
\end{align*}`


```r
I_NT = diag(N*T) # matriz identidade com NT elementos na diagonal
W = I_NT - B # matriz de transformação within
W
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
round(W %*% Z, 3) # matriz de desvios das médias das covariadas dado indivíduo (NT x K)
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    0   -1   -1   -1
## [2,]    0    0    0    0
## [3,]    0    1    1    1
## [4,]    0   -1   -1   -1
## [5,]    0    0    0    0
## [6,]    0    1    1    1
```
Observe que:

- dada uma variável `\(k\)`, temos os desvios em relação à média de um mesmo indivíduo;
- por isso, a amostra de tamanho `\(NT\)`, torna-se uma amostra de `\(N\)` observações distintas;
- coluna 1's virou de 0's após a transformação _within_.
- coluna de 0's, no R, ficou muito próxima de 0 ($1,11 \times 10^{-16}), então foi necessário arredondar.



## Matriz de covariâncias dos erros
- Seção 2.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

A matriz de covariâncias dos erros depende apenas de dois parâmetros: `\(\sigma^2_u\)` e `\(\sigma^2_\nu\)`. Então:

- Variância de um erro: 
{{<math>}}\[ E(\varepsilon^2_{it}) = \sigma^2_u + \sigma^2_\nu \]{{</math>}}
- Covariância de dois erros de um mesmo indivíduo `\(i\)` em dos períodos  `\(t \neq s\)`:
{{<math>}}\[ E(\varepsilon_{it} \varepsilon_{is}) = \varepsilon^2_u \]{{</math>}}
- Covariância entre dois diferentes indivíduos ($i \neq j$): 
{{<math>}}\[ E(\varepsilon_{it} \varepsilon_{jt}) = E(\varepsilon_{it} \varepsilon_{js}) = 0 \]{{</math>}}

A matriz de variância dos erros pode ser expressa por:
{{<math>}}\[ \Omega = \sigma^2_\nu I_{NT} + \sigma^2_u [I_N \otimes \iota (\iota'\iota)^{-1} \iota'] \]{{</math>}}
ou, em termos de `\(B\)` e `\(W\)`,
{{<math>}}\[ \Omega = \sigma^2_\nu W + T \sigma^2_u B \]{{</math>}}


## Estimadores OLS em painel
- Supomos que ambos componentes de erros são não-correlacionados com as covariadas:
{{<math>}}\[ E(u|x) = E(\nu|x) = 0 \]{{</math>}}
- A variabilidade em um painel tem 2 componentes:
    - a _between_ ou inter-indivíduos, em que a variabilidade das variáveis são mensuradas em médias individuais, como `\(\bar{z}_i\)` ou na forma matricial `\(BZ\)`
    - a _within_ ou intra-indivíduos, em que a variabilidade das variáveis são mensuradas em desvios das médias individuais, como `\(z_{it} - \bar{z}_i\)` ou na forma matricial `\(WZ = Z - BZ\)`
    - Lembre-se que `\(z_i \equiv (1, X_i)\)` e `\(Z \equiv (\iota, X)\)`
- Há três estimadores por OLS que podem ser utilizados:
    1. *Pooled OLS (MQE)*: usando a base de dados bruta (empilhada)
    2. *Estimador Between*: usando as médias individuais
    3. *Estimador Within (Efeitos Fixos)*: usando os desvios das médias individuais


### Pooled OLS (MQE)
- Seção 2.1.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)

O modelo a ser estimado é
{{<math>}}\[ y\ =\ Z\gamma + \varepsilon\ =\ \alpha \iota + X \beta + \varepsilon \]{{</math>}}

- O estimador `\(\hat{\gamma} = (\hat{\alpha}, \hat{\beta})\)` é dado por
{{<math>}}\[ \hat{\gamma}_{OLS} = (Z'Z)^{-1} Z' y \]{{</math>}}
- A matriz de covariâncias pode ser obtida usando
{{<math>}}\[ V(\hat{\gamma}_{OLS}) = (Z'Z)^{-1} Z' \Omega Z (Z'Z)^{-1} \]{{</math>}}



### Estimador _Between_
O modelo a ser estimado é o OLS pré-multiplicado por `\(B = I_N \otimes \iota (\iota' \iota)^{-1} \iota'\)`:
{{<math>}}\[ By\ =\ BZ\gamma + B\varepsilon\ =\ \alpha \iota + BX \beta + B\varepsilon \]{{</math>}}

- O estimador `\(\hat{\beta}\)` é dado por
{{<math>}}\[ \hat{\gamma}_{B}\ =\ (Z' B Z )^{-1} Z' B y \]{{</math>}}
- A matriz de covariâncias pode ser obtida usando
`\begin{align*}
    V(\hat{\gamma}_{B}) &= (Z'BZ)^{-1} Z' B\Omega B Z (Z'BZ)^{-1} \\
    &= \sigma^2_l (Z' B Z)^{-1},
\end{align*}`
em que $$\sigma^2_l = \sigma^2_\nu + T \sigma^2_u $$
- O estimador não-viesado de `\(\sigma^2_l\)` é
{{<math>}}\[ \hat{\sigma}^2_l = \frac{\hat{\varepsilon}' B \hat{\varepsilon}}{N-K-1} \]{{</math>}}
<!-- em que `\(\hat{q}_B = \ =\ \varepsilon'M_B \varepsilon\)`. -->
- O estimador _between_ também pode ser estimado por OLS, transformando as variáveis por pré-multiplicação da matriz _between_ ($B$):
{{<math>}}\[ \tilde{Z} \equiv BZ \qquad \text{ e } \qquad \tilde{y} = By \]{{</math>}} 
tal que 
{{<math>}}\[ \hat{\gamma} = ( \tilde{Z}' \tilde{Z} )^{-1} \tilde{Z}' \tilde{y} \]{{</math>}}
e assim por diante.
- Note que, a rotina padrão de OLS retorna `\(\hat{\sigma}^2_l = \frac{\hat{\varepsilon}' B \hat{\varepsilon}}{NT-K-1}\)` e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a matriz de covariâncias dos erros por `\((NT-K-1) / (N-K-1)\)`.  


### Estimador _Within_ (Efeitos Fixos)
- Não assume que `\(E(u | X) = 0\)`
- Estima efeitos individuais para, "limpando" efeito inter-indivíduos nas demais covariadas

O modelo a ser estimado é o OLS pré-multiplicado por `\(W = I_{NT} - B\)`:
{{<math>}}\[ Wy\ =\ WZ\gamma + W\varepsilon\ =\ WX \beta + W\nu. \]{{</math>}}
Note que a transformação within remove vetor de 1's associado ao intercepto, além das covariadas invariantes no tempo e o termo de erro individual `\(u\)` (sobrando apenas `\(\varepsilon = \nu\)`).

- O estimador `\(\hat{\beta}\)` é dado por
{{<math>}}\[ \hat{\beta}_{W}\ =\ (X' W X )^{-1} X' W y \]{{</math>}}
- A matriz de covariâncias pode ser obtida usando
`\begin{align*}
    V(\hat{\beta}_{W}) &= (X'WX)^{-1} X' W\Omega W X (X'WX)^{-1} \\
    &= \sigma^2_\nu (X' W X)^{-1}.
\end{align*}`
- O estimador não-viesado de `\(\sigma^2_\nu\)` é
{{<math>}}\[ \hat{\sigma}^2_\nu = \frac{\hat{\varepsilon}' W \hat{\varepsilon}}{NT-K-N} \]{{</math>}}
<!-- em que `\(\hat{q}_W = \ =\ \varepsilon'M_W \varepsilon\)`. -->
- O estimador _within_ também pode ser estimado por OLS, transformando as variáveis por pré-multiplicação da matriz _within_ ($W$):
{{<math>}}\[ \tilde{Z} \equiv WZ \qquad \text{ e } \qquad \tilde{y} = Wy \]{{</math>}} 
tal que 
{{<math>}}\[ \hat{\gamma} = ( \tilde{Z}' \tilde{Z} )^{-1} \tilde{Z}' \tilde{y} \]{{</math>}}
e assim por diante.
- Note que, a rotina padrão de OLS retorna `\(\hat{\sigma}^2_\nu = \frac{\hat{\varepsilon}' W \hat{\varepsilon}}{NT-K-1}\)` e, portanto, é necessário fazer ajuste dos graus de liberdade multiplicando a matriz de covariâncias dos erros por `\((NT-K-1) / (NT-K-N)\)`.


### Estimação OLS em painel
#### Estimação via `plm()`
Para ilustrar as estimações OLS dos estimadores vistos anteriormente, usaremos a base de dados `TobinQ` do pacote `pder`, que conta com dados de 188 firmas americanos por 35 anos (6580 observações).

```r
library(dplyr)
data("TobinQ", package = "pder")
summary(TobinQ %>% select(cusip, year, ikn, qn))
```

```
##      cusip             year           ikn               qn          
##  Min.   :  2824   Min.   :1951   Min.   :0.0000   Min.   :-68.8663  
##  1st Qu.:212570   1st Qu.:1959   1st Qu.:0.1086   1st Qu.: -0.8254  
##  Median :415690   Median :1968   Median :0.1530   Median :  0.3976  
##  Mean   :437124   Mean   :1968   Mean   :0.1690   Mean   :  2.5053  
##  3rd Qu.:690207   3rd Qu.:1977   3rd Qu.:0.2120   3rd Qu.:  2.9961  
##  Max.   :984121   Max.   :1985   Max.   :0.8024   Max.   : 89.8933
```
- `cusip`: Identificador da empresa
- `year`: Ano
- `ikn`: Investimento dividido pelo capital
- `qn`: Q de Tobin (razão entre valor da firma e o custo de reposição de seu capital físico). Se `\(Q > 1\)`, então o lucro investimento é maior do que seu custo.

Queremos estimar o seguinte modelo:
{{<math>}}\[ \text{ikn} = \alpha + \text{qn} \beta + \varepsilon \]{{</math>}}


Usaremos a função `plm()` (do pacote de mesmo nome) para estimar modelos lineares em dados em painel. Seus principais argumentos são:

- `formula`: equação do modelo
- `data`: base de dados em `data.frame` (precisa preencher `index`) ou `pdata.frame` (formato próprio do pacote que já indexa as colunas de indivíduos e de tempo)
- `model`: estimador a ser computado 'pooling' (MQE), 'between', 'within' (Efeitos Fixos) e 'random' (Efeitos Aleatórios/GLS)
- `index`: vetor de nomes dos identificadores de indivíduo e de tempo


```r
library(plm)
```

```
## 
## Attaching package: 'plm'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     between, lag, lead
```

```r
# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimações
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")
Q.between = plm(ikn ~ qn, pTobinQ, model = "between")
Q.within = plm(ikn ~ qn, pTobinQ, model = "within")

summary(Q.within) # output da estimação within
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

```r
# Resumindo 3 estimações em única tabela
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


##### Estimando _Within_ e _Between_ via Pooled OLS
- Nós podemos construir as variáveis de média e de desvios de média diretamente no data frame e estimar o _between_ e _within_ via (pooled) OLS

```r
TobinQ = TobinQ %>% group_by(cusip) %>% # agrupando por cusip
    mutate(
        ikn_bar = mean(ikn), # "transformação" between de ikn
        qn_bar = mean(qn), # "transformação" between de qn
        ikn_desv = ikn - ikn_bar, # "transformação" within de ikn
        qn_desv = qn - qn_bar # "transformação" within de qn
    ) %>% ungroup()

pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

Q.pooling_between = plm(ikn_bar ~ qn_bar, pTobinQ, model = "pooling")

summary(Q.pooling_between)$coef # between via pooled OLS
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
- Ao estimar o _between_ via pooled OLS, ele não faz os ajustes dos graus de liberdade nas variâncias das estimativas
- Logo, vamos ajustar os graus de liberdade multiplicando a variância das estimativas por `\((NT - K - 1)\)` e dividindo por `\((N - K - 1)\)`

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


##### Efeitos Fixos da Estimação _Within_
- Para o estimador _within_, podemos usar a função `fixef()` para computar os efeitos individuais. É possível calcular 3 tipos por meio do argumento `type`:
    - `level`: valor padrão que retorna os interceptos individuais ($\hat{\alpha} + \hat{u}_{i}$)
    - `dfirst`: em desvios do 1º indivíduo ($\hat{\alpha}$ é o intercepto do 1º indivíduo)
    - `dmean`: em desvios da média de efeitos individuais ($\hat{\alpha}$ é a média)


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
- No caso linear, o estimador _within_ é equivalente à estimação por OLS com inclusão de dummies para cada indivíduo:

```r
# Estimando OLS com dummies individuais - factor() tranforma cusip em var. categ.
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


#### Estimação Analítica Pooled OLS (MQE)
Igual a estimação analítica de MQO vista anteriormente.


#### Estimação Analítica _Between_

```r
data("TobinQ", package="pder")
TobinQ = TobinQ %>% mutate(constant = 1) # criando vetor de 1's

y = TobinQ %>% select(ikn) %>% as.matrix() # vetor y
X = TobinQ %>% select(qn) %>% as.matrix() # vetor X
Z = cbind(TobinQ$constant, X) # vetor Z = (iota, X)

N = TobinQ %>% select(cusip) %>% unique() %>% nrow()
T = TobinQ %>% select(year) %>% unique() %>% nrow()
iota_T = rep(1, T)

# Calculando matrizes de tranformação B e W
B = diag(N) %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = diag(N*T) - B
```


{{<math>}}\[ \hat{\gamma} = (\hat{\alpha}, \hat{\beta}) = (Z' B Z)^{-1} Z' By  \]{{</math>}}


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


{{<math>}}\[ \hat{y} = Z \hat{\gamma} \qquad \text{ e } \qquad  \hat{\varepsilon} = y - \hat{y} \]{{</math>}}

```r
# valores ajustados e erros
y_hat = Z %*% gamma_hat
e_hat = y - y_hat
```


{{<math>}}\[ \hat{\sigma}^2 = \frac{\hat{\varepsilon}' B \hat{\varepsilon}}{N-K-1} \]{{</math>}}

```r
## Estimando variancia do termo de erro
sigma2_l = t(e_hat) %*% B %*% e_hat / (N - ncol(Z)) # N - K - 1 graus de liberdade!
sigma2_l
```

```
##            ikn
## ikn 0.07598735
```
**IMPORTANTE**: Ajustar os graus de liberdade do estimador _between_ para `\(N - K - 1\)` (ao invés de `\(NT - K - 1\)`)

{{<math>}}\[ \widehat{V}(\hat{\gamma}) = \hat{\sigma}^2_l (Z'BZ)^{-1} \]{{</math>}}

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


## Estimadores GLS em painel
- Seção 2.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Ao contrário do estimador _within_ que retira os efeitos individuais, o estimador de **GLS** considera que os efeitos individuais como aleatórios a partir de uma distribuição específica.
- Erros não são correlacionados com as covariadas, e são caracterizados por uma matriz de covariâncias `\(\Omega\)`.
- O estimador de GLS é dado por
{{<math>}}\[ \hat{\gamma}_{GLS} = (Z' \Omega^{-1} Z)^{-1} (Z' \Omega^{-1} y) \tag{2.27} \]{{</math>}}
- A variância do estimador é dada por
{{<math>}}\[ V(\hat{\gamma}_{GLS}) = (Z' \Omega^{-1} Z)^{-1} \tag{2.28} \]{{</math>}}
- A matriz `\(\Omega\)` depende apenas de dois parâmetros: `\(\sigma^2_u\)` e `\(\sigma^2_\nu\)`, temos:
{{<math>}}\[ \Omega^p = (\sigma^2_l)^p B + (\sigma^2_\nu)^p W \tag{2.29} \]{{</math>}}
<!-- - Usando `\(p=-1\)` e substituindo `\(\Omega^{-1}\)` em (2.27) e (2.28), temos: -->
<!-- \begin{align*} -->
<!--     \hat{\gamma}_{GLS} &= \left(\frac{1}{\sigma^2_\nu} Z' W Z + \frac{1}{\sigma^2_l} Z' B Z \right)^{-1} \left(\frac{1}{\sigma^2_\nu} Z' W y + \frac{1}{\sigma^2_l} Z' B y \right) \tag{2.30} \\ -->
<!--     V(\hat{\gamma}_{GLS}) &= \left(\frac{1}{\sigma^2_\nu} Z' W Z + \frac{1}{\sigma^2_l} Z' B Z  \right)^{-1} \tag{2.31} -->
<!-- \end{align*} -->
- Lembre-se que $$\sigma^2_l = \sigma^2_\nu + T \sigma^2_u $$

### GLS: combinação de Pooled OLS (Ef. Aleatórios) e de _Within_ (Ef. Fixos)
- Pode-se computar mais eficientemente por OLS, que necessita transformação das variáveis usando a matriz `\(\Omega^{-0.5}\)`, tal que `\(\Omega^{-0.5\prime}\Omega^{-0.5} = \Omega^{-1}\)`.
- Denotando `\(\tilde{y} \equiv \Omega^{-0.5}y\)` e `\(\tilde{Z} \equiv \Omega^{-0.5}Z\)`, o modelo com variáveis transformadas é dado por
`\begin{align*}
    \hat{\gamma} &= (Z' \Omega^{-1} Z)^{-1} (Z' \Omega^{-1} y) \tag{2.27} \\
    &= (Z' \Omega^{-0.5\prime} \Omega^{-0.5} Z)^{-1} (Z' \Omega^{-0.5}\Omega^{-0.5\prime} y) \\
    &= (\tilde{Z}'\tilde{Z})^{-1} \tilde{Z} \tilde{y}
\end{align*}`

Usando (2.29), `\(p=-0.5\)` em (2.29), tem-se
{{<math>}}\[ \Omega^{-0.5} = \frac{1}{\sigma_l} B + \frac{1}{\sigma_\nu} W \]{{</math>}}

Essa transformação evidencia uma combinação linear entre as matrizes de transformação _between_ e _within_ ponderadas pelo inverso dos desvios padrão dos 2 componentes de erro ($\sigma^2_\nu$ e `\(\sigma^2_u = (\sigma^2_\nu + \sigma^2_l)/T\)`)

Pré-multiplicando as variáveis por `\(\sigma_\nu \Omega^{-0.5}\)` (ao invés de `\(\Omega^{-0.5}\)` para simplificação e sem perda de generalidade), as covariadas transformadas para o indivíduo `\(i\)` no tempo `\(t\)` são dadas por:
{{<math>}}\[ \tilde{z}_{it}\ =\ \frac{\sigma_\nu}{\sigma_l} \bar{z}_{i\cdot} + (z_{it} - \bar{z}_{i\cdot})\ =\ z_{it} + \left(1 - \frac{\sigma_\nu}{\sigma_l} \right) \bar{z}_{i\cdot}\ \equiv\ z_{it} - \theta \bar{z}_{i\cdot} \]{{</math>}}
em que
{{<math>}}\[ \theta\ \equiv\ 1 - \frac{\sigma_\nu}{\sigma_l}\ \equiv\ 1 - \phi \]{{</math>}}
    <!-- &= 1 - \frac{(\sqrt{\sigma_\nu})^2}{\sqrt{\sigma^2_\nu + T \sigma^2_u}}  \tag{$\sigma^2_l = \sigma^2_\nu + T \sigma^2_u$} \\ -->
    <!-- &= 1 - \frac{1}{\sqrt{1 + T \frac{\sigma^2_u}{\sigma^2_\nu}}} -->

    
Note que, quando:

- `\(\theta \rightarrow 1\)`, os efeitos individuais `\(\sigma_u\)` dominam `\(\implies\)` GLS se aproxima do estimador _within_
- `\(\theta \rightarrow 0\)`, os efeitos individuais `\(\sigma_u\)` somem `\(\implies\)` GLS se aproxima do pooled OLS


### Estimação dos Componentes de Erro `\(\sigma_u\)` e `\(\sigma_\nu\)`
- Note que não temos `\(\sigma^2_\nu\)` e `\(\sigma^2_u = (\sigma^2_\nu + \sigma^2_l)/T\)` e, logo, `\(\Omega\)` é desconhecido.
- Se `\(\varepsilon\)` fosse conhecido, então os estimadores para as duas variâncias seriam:
`\begin{align*}
    \hat{\sigma}^2_l &= \frac{\varepsilon' B \varepsilon}{N} \tag{2.34}\\
    \hat{\sigma}^2_\nu &= \frac{\varepsilon' W \varepsilon}{N(T-1)} \tag{2.35}
\end{align*}`
- Como `\(\varepsilon\)` é desconhecido, então usam-se resíduos de estimadores consistentes em seu lugar.
- O estimador obtido por esse processo é chamado de FGLS (ou GLS Factível)
- **Wallace e Hussain (1969)**: usam resíduos OLS
`\begin{align*}
    \hat{\sigma}^2_l &= \frac{\hat{\varepsilon}'_{OLS} B \hat{\varepsilon}_{OLS}}{N} \\
    \hat{\sigma}^2_\nu &= \frac{\hat{\varepsilon}'_{OLS} W \hat{\varepsilon}_{OLS}}{N(T-1)}
\end{align*}`
- **Amemiya (1971)**: usam resíduos _within_
`\begin{align*}
    \hat{\sigma}^2_l &= \frac{\hat{\varepsilon}'_{W} B \hat{\varepsilon}_{W}}{N}\\
    \hat{\sigma}^2_\nu &= \frac{\hat{\varepsilon}'_{W} W \hat{\varepsilon}_{W}}{N(T-1)}
\end{align*}`
Note que, a variância do efeito individual é sobre-estimado quando o modelo contém variáveis invariantes no tempo (somem com a transformação _within_)
- **Hausman e Taylor (1981)**: propuseram ajuste ao método de Amemiya (1971), em que `\(\hat{\varepsilon}_W\)` são regredidos em todas variáveis invariantes no tempo no modelo e são utilizados os resíduos dessa regressão, `\(\hat{\varepsilon}_{HT}\)`.
- **Swamy e Arora (1972)**: usam resíduos _between_ e _within_ para calcular, respectivamente, `\(\hat{\sigma}^2_l\)` e `\(\hat{\sigma}^2_\nu\)`
`\begin{align*}
    \hat{\sigma}^2_l &= \frac{\hat{\varepsilon}'_{B} B \hat{\varepsilon}_{B}}{N - K - 1}\\
    \hat{\sigma}^2_\nu &= \frac{\hat{\varepsilon}'_{W} W \hat{\varepsilon}_{W}}{N(T-1) - K}
\end{align*}`
- **Nerlove (1971)**: computam `\(\sigma^2_u\)` empírica dos efeitos fixos do modelo _within_
`\begin{align*}
    \hat{u}_i &= \bar{y}_{i\cdot} - \hat{\beta}_W \bar{x}_{i\cdot} \\
    \hat{\sigma}^2_u &= \sum^N_{i=1}{(\hat{u}_i - \bar{\hat{u}}) / (N-1)} \\
    \hat{\sigma}^2_\nu &= \frac{\hat{\varepsilon}'_W W \hat{\varepsilon}_W}{NT}
\end{align*}`


### Estimação GLS via `plm()`
- Usaremos novamente a função `plm()`, mas definiremos `model = random` para que seja estimado via GLS
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

# Estimações GLS
Q.walhus = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "walhus")
Q.amemiya = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "amemiya")
Q.ht = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "ht")
Q.swar = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "swar")
Q.nerlove = plm(ikn ~ qn, pTobinQ, model = "random", random.method = "nerlove")

summary(Q.walhus) # output da estimação GLS por Wallace e Hussain (1969)
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
Note que `\(\theta = 73\%\)`, o que indica que, neste caso, o estimativa GLS é mais próxima de _within_ ($\theta=1$) do que de _between_ ($\theta=0$). A grande quantidade de períodos ($T = 35$) provavelmente influencia este alto valor.



```r
# Resumindo 5 estimações em única tabela
stargazer::stargazer(Q.walhus, Q.amemiya, Q.ht, Q.swar, Q.nerlove, type="text")
```

```
## 
## ===================================================================
##                               Dependent variable:                  
##              ------------------------------------------------------
##                                       ikn                          
##                 (1)        (2)        (3)        (4)        (5)    
## -------------------------------------------------------------------
## qn            0.004***   0.004***   0.004***   0.004***   0.004*** 
##               (0.0002)   (0.0002)   (0.0002)   (0.0002)   (0.0002) 
##                                                                    
## Constant      0.159***   0.159***   0.159***   0.159***   0.159*** 
##               (0.003)    (0.003)    (0.003)    (0.003)    (0.004)  
##                                                                    
## -------------------------------------------------------------------
## Observations   6,580      6,580      6,580      6,580      6,580   
## R2             0.074      0.074      0.074      0.074      0.074   
## Adjusted R2    0.074      0.074      0.074      0.074      0.074   
## F Statistic  527.045*** 526.622*** 526.622*** 526.854*** 523.832***
## ===================================================================
## Note:                                   *p<0.1; **p<0.05; ***p<0.01
```
Os resultados são praticamente idênticos, assim como seus `\(\theta\)`'s:


```r
# Podemos visualizar o theta usando ercomp()$theta
ercomp(Q.walhus)$theta
```

```
##        id 
## 0.7342249
```

```r
# Criaremos uma lista com todos objetos de estimação GLS
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

Também é possível verificar o mesmo para a variância do erro na estimação em GLS:

```r
ercomp(ikn ~ qn, TobinQ) # padrão method = "swar"
```

```
##                    var  std.dev share
## idiosyncratic 0.005333 0.073028 0.725
## individual    0.002019 0.044930 0.275
## theta: 0.7351
```



#### Estimação Analítica GLS
- Aqui, faremos a estimação analítica do GLS usando o método de Wallace e Hussain (1969).
- Consiste no uso dos desvios estimados por pooled OLS para calcular `\(\hat{\sigma}^2_l\)`, `\(\hat{\sigma}^2_\nu\)` (e consequentemente `\(\hat{\sigma}^2_u\)`), possibilitando encontrar `\(\hat{\Omega}^{-1}\)` para estimar por FGLS.
- Para agilizar a estimação, vamos estimar o pooled OLS por `plm()`:

```r
library(plm)
data("TobinQ", package = "pder")

# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))
```

- Obtendo `\(\hat{\varepsilon}_{OLS}\)`


```r
# Estimação pooled OLS
Q.pooling = plm(ikn ~ qn, pTobinQ, model = "pooling")

# obtendo os resíduos OLS
e_OLS = Q.pooling$residuals %>% as.vector()
head(e_OLS)
```

```
## [1] -0.001032395 -0.011987475 -0.080212022 -0.061942582 -0.122186352
## [6] -0.089377633
```

- Precisamos calcular `\(\hat{\sigma}^2_l\)`, `\(\hat{\sigma}^2_\nu\)` e `\(\hat{\sigma}^2_u\)`


```r
TobinQ = TobinQ %>% mutate(constant = 1) # criando vetor de 1's

y = TobinQ %>% select(ikn) %>% as.matrix() # vetor y
X = TobinQ %>% select(qn) %>% as.matrix() # vetor X
Z = cbind(TobinQ$constant, X) # vetor Z = (iota, X)

N = TobinQ %>% select(cusip) %>% unique() %>% nrow() # núm. indivíduos
T = TobinQ %>% select(year) %>% unique() %>% nrow() # núm. períodos
iota_T = rep(1, T)

# Calculando matrizes de tranformação B e W
B = diag(N) %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T))
W = diag(N*T) - B

# Calculando os termos de erro
sigma2_l = (t(e_OLS) %*% B %*% e_OLS) / N
sigma2_nu = (t(e_OLS) %*% W %*% e_OLS) / (N * (T-1))
sigma2_u = (sigma2_l + sigma2_nu) / T

sigmas2 = cbind(sigma2_l, sigma2_nu, sigma2_u)
colnames(sigmas2) = c("sigma2_l", "sigma2_nu", "sigma2_u")
sigmas2
```

```
##        sigma2_l   sigma2_nu    sigma2_u
## [1,] 0.07563169 0.005342349 0.002313544
```

- Agora, conseguimos calcular:
{{<math>}}\[ \Omega^{-1} = \frac{1}{\sigma^2_l}B + \frac{1}{\sigma^2_\nu}W \]{{</math>}}

```r
Omega_1 = c(sigma2_l^(-1)) * B + c(sigma2_nu^(-1)) * W
dim(Omega_1) # NT x NT
```

```
## [1] 6580 6580
```

{{<math>}}\[ \hat{V}_{GLS} = (Z' \Omega^{-1} Z)^{-1} \]{{</math>}}
<!-- {{<math>}}\[ \hat{y} = Z\hat{\gamma} \qquad \text{e} \qquad \varepsilon = y - \hat{y} \]{{</math>}} -->


```r
## Estimando a matriz de variancia/covariancia das estimativas gamma
vcov_hat = solve(t(Z) %*% Omega_1 %*% Z)

# vetor de estimativas gamma_hat = (alpha, beta)
gamma_hat = solve(t(Z) %*% Omega_1 %*% Z) %*% (t(Z) %*% Omega_1 %*% y)
gamma_hat
```

```
##            ikn
##    0.159325869
## qn 0.003862631
```

```r
## Calculando erros padrao das estimativas gamma
std_err = sqrt(diag(vcov_hat)) # Raiz da diagonal da matriz de covariâncias

## Calculando estatisticas t das estimativas gamma
t_stat = gamma_hat / std_err

## Calculando p-valores das estimativas gamma
p_value = 2 * pt(q = -abs(t_stat), df = nrow(Z) - ncol(Z))  # NT - K - 1 graus de liberdade

## Organizando os resultados da regressao em uma matriz
results_walhus = cbind(gamma_hat, std_err, t_stat, p_value)

## Nomeando as colunas da matriz de resultados
colnames(results_walhus) = c('Estimate', 'Std. Error', 't stat', 'Pr(>|t|)')
rownames(results_walhus) = c("(Intercept)", "qn")
results_walhus
```

```
##                Estimate   Std. Error   t stat      Pr(>|t|)
## (Intercept) 0.159325869 0.0034164422 46.63503  0.000000e+00
## qn          0.003862631 0.0001683526 22.94370 3.904386e-112
```

```r
summary(Q.walhus)$coef # comparando com estimado via plm()
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159325869 0.0034143937 46.66300  0.000000e+00
## qn          0.003862631 0.0001682516 22.95747 1.240977e-116
```

## Comparativo dos Estimadores OLS e GLS - Exemplo
- Seção 2.4.4 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Usado por Kinal e Lahiri (1993) 
- Queremos estabelecer relação entre importações (_imports_) e produto nacional (_gnp_)

```r
data("ForeignTrade", package = "pder")
FT = pdata.frame(ForeignTrade, index=c("country", "year"))

# Variâncias 
ercomp(imports ~ gnp, FT) # variância do erro na estimação GLS
```

```
##                   var std.dev share
## idiosyncratic 0.08634 0.29383 0.074
## individual    1.07785 1.03820 0.926
## theta: 0.9423
```
- Variância do erro da estimação GLS é dada por 93\% de variação inter-indivíduos
- O estimador GLS remove grande parte da variação inter-indivíduos, pois subtrai, da covariada, 94\% da média individual:
{{<math>}}\[ \tilde{z}_{it}\ =\ z_{it} + \left(1 - \frac{\sigma_\nu}{\sigma_l} \right) \bar{z}_{i\cdot}\ \equiv\ z_{it} - \theta \bar{z}_{i\cdot}\ =\ z_{it} - 0,94 \bar{z}_{i\cdot} \]{{</math>}}


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


<center><img src="https://fhnishida.github.io/fearp/eco1/example_panel-1.png"></center>

- GLS e _within_ são bastante parecidos
- OLS, que considera variação inter-indivíduos, é parecido com _between_

## Estimador ML em painel
- Seção 3.3 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Uma alternativa aos estimadores de GLS é o de máxima verossimilhança (ML).
- Assume-se que a distribuição dos dois componentes de erro são normais:
{{<math>}}\[ u | X \sim N(0, \sigma^2_u) \quad \text{ e } \quad v | u, X \sim N(0, \sigma^2_\nu) \]{{</math>}}
- O modelo a ser estimado é o
{{<math>}}\[ y_{it} = \alpha \iota + \beta' x_i + u_i + \nu_{it} = \gamma' z_i + u_i + \nu_{it} \]{{</math>}}
- Ao invés de estimar `\(\sigma^2_u\)` e `\(\sigma^2_\nu\)` para depois calcular `\(\gamma\)`, ambos são estimados simultaneamente.
- Denotando `\(\phi = \frac{\sigma_\nu}{\sigma_{l}}\)`, a função de log-verossimilhança para um painel balanceado é:
{{<math>}}\[ \ln{L} = -\frac{NT}{2} \ln{2\pi} - \frac{NT}{2}\ln{\sigma^2_\nu} + \frac{N}{2} \ln{\phi^2} - \frac{1}{2\sigma^2_\nu} \left( \varepsilon' W \varepsilon + \phi^2 \varepsilon' B \varepsilon \right) \]{{</math>}}
- Denotando `$$\tilde{Z}\ \equiv\ (I - \phi B) Z\ =\ Z - \phi B Z$$` e resolvendo as CPO's da log-verossimilhança, segue que:
`\begin{align*}
    \hat{\gamma} &= (\tilde{Z}'\tilde{Z})^{-1} \tilde{Z}'\tilde{y} \tag{3.12} \\
    \hat{\sigma}^2_\nu &= \frac{\hat{\varepsilon}' W \hat{\varepsilon} + \hat{\phi}^2 \hat{\varepsilon}' B \hat{\varepsilon}}{NT} \tag{3.13} \\
    \hat{\phi}^2 &=\frac{\hat{\varepsilon}' W \hat{\varepsilon}}{(T-1) \hat{\varepsilon}'B\hat{\varepsilon}} \tag{3.14}
\end{align*}`
- A estimação pode ser feita iterativamente por FIML (Full Information Maximum Likelihood):
    1. Chute inicial de `\(\hat{\gamma}\)` (por exemplo, estimativa _within_)
    2. Calcular `\(\hat{\phi}^2\)` usando (3.14)
    3. Calcular `\(\hat{\gamma}\)` usando (3.12) 
    4. Verificar convergência: se não convergiu, volta para o passo 2, usando o `\(\hat{\gamma}\)` calculado no passo 3.
    5. Calcular `\(\sigma^2_\nu\)` usando (3.13)

### Estimação ML via `pglm()`

```r
library(pglm)
```

```
## Carregando pacotes exigidos: maxLik
```

```
## Carregando pacotes exigidos: miscTools
```

```
## 
## Please cite the 'maxLik' package as:
## Henningsen, Arne and Toomet, Ott (2011). maxLik: A package for maximum likelihood estimation in R. Computational Statistics 26(3), 443-458. DOI 10.1007/s00180-010-0217-1.
## 
## If you have questions, suggestions, or comments regarding the 'maxLik' package, please use a forum or 'tracker' at maxLik's R-Forge site:
## https://r-forge.r-project.org/projects/maxlik/
```

```r
library(dplyr)
data("TobinQ", package = "pder")

# Transformando no formato pdata frame, com indentificador de indivíduo e de tempo
pTobinQ = pdata.frame(TobinQ, index=c("cusip", "year"))

# Estimação pooled OLS
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
summary(Q.swar)$coef # Comparando com estimação GLS-swar
```

```
##                Estimate   Std. Error  z-value      Pr(>|z|)
## (Intercept) 0.159326945 0.0034249012 46.52016  0.000000e+00
## qn          0.003862202 0.0001682634 22.95331 1.365529e-116
```
- Note que o resultado por ML foi bem próximo ao do obtido por GLS


<!-- ### Estimação Numérica ML -->
<!-- ```{r} -->
<!-- TobinQ = TobinQ %>% mutate(constant = 1) # criando vetor de 1's -->

<!-- y = TobinQ %>% select(ikn) %>% as.matrix() # vetor y -->
<!-- X = TobinQ %>% select(qn) %>% as.matrix() # vetor X -->
<!-- Z = cbind(TobinQ$constant, X) # vetor Z = (iota, X) -->

<!-- N = TobinQ %>% select(cusip) %>% unique() %>% nrow() # núm. indivíduos -->
<!-- T = TobinQ %>% select(year) %>% unique() %>% nrow() # núm. períodos -->
<!-- iota_T = rep(1, T) -->

<!-- # Calculando matrizes de tranformação B e W -->
<!-- B = diag(N) %x% (iota_T %*% solve(t(iota_T) %*% iota_T) %*% t(iota_T)) -->
<!-- W = diag(N*T) - B -->
<!-- ``` -->

<!-- Agora, iremos realizar iterações até a convergência de `\(\hat{\gamma}\)` -->
<!-- ```{r} -->
<!-- gamma_ini = c(0, 0) # chute inicial -->
<!-- tol = 1e-10 # tolerância para convergência -->
<!-- dist = 1 # distância inicial - apenas para entrar no loop/while -->
<!-- it = 0 # número de iterações -->

<!-- while (dist > tol) { -->
<!--     print(paste0("iteração ", it, -->
<!--                  ": alpha = ", round(gamma_ini[1], 7), -->
<!--                  " | beta = ", round(gamma_ini[2], 7))) -->

<!--     # Encontrando erros e transformando em vetor -->
<!--     y_hat = Z %*% gamma_ini -->
<!--     e = as.vector(y - y_hat) -->

<!--     # Calculando \phi^2 -->
<!--     phi2_hat = (t(e) %*% W %*% e) / ((T-1) * (t(e) %*% B %*% e)) -->
<!--     phi_hat = as.vector(sqrt(phi2_hat)) -->

<!--     # Transformando variáveis -->
<!--     Z_til = Z - (phi_hat * B) %*% Z -->
<!--     y_til = y - (phi_hat * B) %*% y -->

<!--     # Calculando estimativas dos parâmetros -->
<!--     gamma_fim = solve(t(Z_til) %*% Z_til) %*% t(Z_til) %*% y_til -->

<!--     # Calculando distância entre as estimativas -->
<!--     dist = max(abs(gamma_fim - gamma_ini)) -->
<!--     gamma_ini = gamma_fim -->
<!--     it = it + 1 -->
<!-- } -->
<!-- ``` -->
<!-- ```{r} -->
<!-- y_hat = Z %*% gamma_fim -->
<!-- e = as.vector(y - y_hat) -->
<!-- phi2_hat = (t(e) %*% W %*% e) / ((T-1) * (t(e) %*% B %*% e)) -->
<!-- phi_hat = sqrt(phi2_hat) -->

<!-- # Calculando desvio padrão idiossincrático \nu -->
<!-- sigma2_nu = (t(e) %*% W %*% e  +  phi2_hat * t(e) %*% B %*% e) / (N*T) -->
<!-- print(paste0("sd_idios = ", round(sqrt(sigma2_nu), 6))) -->
<!-- ``` -->
<!-- Como `\(\phi = \sigma_\nu / \sigma_l\)` e `\(\sigma^2_\nu = (\sigma^2_\nu + \sigma^2_l) / T\)`, então: -->
<!-- ```{r} -->
<!-- sigma_l = sqrt(sigma2_nu) / phi_hat -->
<!-- sigma2_u = (sigma_l^2 + sigma2_nu) / T -->
<!-- print(paste0("sd_id = ", round(sqrt(sigma2_u), 6))) -->
<!-- ``` -->
<!-- Observe que obtivemos resultados próximos do obtido via `pglm()`. -->


## Testes de Presença de Efeitos Individuais

### Testes Breusch-Pagan
- Seção 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- É um teste baseado em multiplicadores de Lagrange (LM) nos resíduos de OLS, em que `\(H_0: \sigma^2_u = 0\)` (ausência de efeitos individuais)
- A estatística teste é dada por 
{{<math>}}\[ LM_u = \frac{NT}{2(T-1)} \left( T \frac{\hat{\varepsilon}' B_u \hat{\varepsilon}}{\hat{\varepsilon}' \hat{\varepsilon}} - 1 \right)^2  \]{{</math>}}
que é assintoticamente distribuída como ua `\(\chi^2\)` com 1 grau de liberdade.
- Há algumas variações deste teste:
    - Breusch and Pagan (1980),
    - Gourieroux et al. (1982),
    - Honda (1985), e
    - King and Wu (1997).



### Testes F
- Seção 4.1 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Sejam a soma dos resíduos ao quadrado e os graus de liberdade do modelo _within_ `\(\hat{\varepsilon}'_W\hat{\varepsilon}_W\)` e `\(N(T-1) - K\)`, respectivamente.
- Sejam a soma dos resíduos ao quadrado e os graus de liberdade do modelo pooled OLS `\(\hat{\varepsilon}'_{OLS}\hat{\varepsilon}_{OLS}\)` e `\(NT - K - 1\)`, respectivamente.
- Sob hipótese nula de que não há efeitos individuais, a estatística teste é dada por
{{<math>}}\[ \frac{\hat{\varepsilon}'_{OLS} W \hat{\varepsilon}_{OLS} - \hat{\varepsilon}'_W\hat{\varepsilon}_W}{\hat{\varepsilon}'_W W \hat{\varepsilon}_W} \frac{NT - K - N + 1}{N-1} \]{{</math>}}
que segue uma distribuição F de Fisher-Snedecor com `\(N-1\)` e `\(NT - K - N + 1\)` graus de liberdade.


### Implementando os Testes no R

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


## Testes de Efeitos Correlacionados
- Seção 4.2 de "Panel Data Econometrics with R" (Croissant \& Millo, 2018)
- Continuamos assumindo que `\(E(\nu|X) = 0\)`, em que `\(\nu\)` é o termo de erro idiossincrático.
- Nestes testes, verificamos se `\(E(u|X) = 0\)`, ou seja, se os efeitos individuais são ou não são correlacionados com as covariadas.

### Teste de Hausman
- O princípio geral do teste de Hausman consiste em comparar dois modelos `\(A\)` e `\(B\)` tal que
    - sob `\(H_0\)`: `\(A\)` e `\(B\)` são ambos consistentes, mas `\(B\)` é mais eficiente que `\(A\)`
    - sob `\(H_1\)`: apenas `\(A\)` é consistente
- Se `\(H_0\)` é verdadeiro, então os coeficientes dos dois modelos não devem divergir.
- O teste é baseado em `\(\hat{\beta}_A - \hat{\beta}_B\)` e Hausman mostrou que, sob `\(H_0\)`, temos `\(cov(\hat{\beta}_A, \hat{\beta}_B) = 0\)` e, logo, a variância dessa diferença é simplesmente `\(V(\hat{\beta}_A - \hat{\beta}_B) = V(\hat{\beta}_A) - V(\hat{\beta}_B)\)`

- No contexto de dados em painéis, compara-se o estimador _within_ (efeitos fixos) e o de GLS (efeitos aleatórios)
- Quando `\(E(u|X) = 0\)` ambos estimadores são consistentes, ou seja,
{{<math>}}\[ \hat{q} \equiv \hat{\beta}_{GLS} - \hat{\beta}_W\ \overset{p}{\rightarrow}\ 0 \]{{</math>}}
então é preferível usar o mais eficiente (GLS, pois usa ambas variações inter e intra-indivíduos).
- Se `\(E(u|X) \neq 0\)`, então `\(\hat{q} \equiv \hat{\beta}_{GLS} - \hat{\beta}_W \neq 0\)` e apenas o modelo robusto a `\(E(u|X) \neq 0\)` (_within_) é consistente.
- A variância é dada por 
`\begin{align*}
    V(\hat{q}) &= V(\hat{\beta}_{GLS} - \hat{\beta}_W) = V(\hat{\beta}_{GLS}) + V(\hat{\beta}_W) - 2 cov(\hat{\beta}_{W}, \hat{\beta}_{GLS}) \\
    &= \sigma^2_\nu (Z' W Z)^{-1} - (Z'\Omega^{-1} Z)^{-1}
\end{align*}`
- Logo, a estatística teste se torna
{{<math>}}\[ \hat{q}'\ V(\hat{q})^{-1}\ \hat{q} \]{{</math>}}
que, sob `\(H_0\)`, é distribuida como `\(\chi^2\)` com `\(K\)` graus de liberdade.


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


### Outros testes
- Ver Croissant \& Millo (2018):
    - Abordagem de Mundlak
    - Abordagem de Chamberlain

{{< cta cta_text="👉 Proceed to SESSION" cta_link="../chapter9" >}}
