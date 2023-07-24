# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 4

## Base de Dados
library(dplyr)
sw = starwars

# retirar coluna da classe list
sw[,c("films", "vehicles", "starships")] = NULL


# Resumo
dim(sw) # dimensões
head(sw) # 6 primeiras
tail(sw) # 6 últimas
str(sw) # estrutura
summary(sw) # resumo

table(sw$hair_color) # contagem
prop.table(table(sw$hair_color)) # proporção
table(sw$hair_color, sw$gender) # contagem cruzada


# apply
?apply
x = matrix(1:20, nrow=5)
apply(x, 1, mean)
apply(x, 2, summary)


# lapply
?lapply
lapply(sw, summary, na.rm=TRUE)
summary(sw)

lapply(sw, unique, na.rm=TRUE) # vetor de valores únicos
lapply(lapply(sw, unique, na.rm=TRUE), length) # quantidade de valores único

sapply(sw, unique, na.rm=TRUE) # vetor de valores únicos
sapply(lapply(sw, unique, na.rm=TRUE), length) # quantidade de valores único


## Filtro
sw$hair_color == "blond"

sw[sw$hair_color == "blond",] # expressão lógica simples
sw[sw$hair_color == "blond" & !is.na(sw$hair_color),] # expressão composta

with(
  sw,
  sw[hair_color == "blond" & !is.na(hair_color),]
)

sw$hair_color %in% c("blond", "white")

sw = sw[sw$hair_color %in% c("blond", "white"),]

## Ordenação de linhas
sort(sw$height) # ord crescente
sort(sw$height, decreasing=TRUE) # ord decrescente

order(sw$height)

sw = sw[order(sw$height),]


## Seleção de colunas
sw$name
sw[,"name"]
sw[,c("name", "height")]

sw = sw[,1:6]


## Renomeação de colunas
names(sw)
colnames(sw)

colnames(sw)[4] = "haircolor"
colnames(sw)[5:6] = c("skincolor", "eyecolor")


## Modificação ou adição de coluna
sw$height = sw$height/100
sw$const = 1
sw$BMI = sw$mass / sw$height^2

# função para transformação de variáveis
sw$BMI[1:4]

abs(sw$BMI[1:4])
sqrt(sw$BMI[1:4])
ceiling(sw$BMI[1:4])
floor(sw$BMI[1:4])
round(sw$BMI[1:4], 2)
sin(sw$BMI[1:4])
cos(sw$BMI[1:4])
log(sw$BMI[1:4])
log10(sw$BMI[1:4])
exp(sw$BMI[1:4])


## Junção de bases
bd1 = starwars[1:6, c(1, 3, 11)]
bd2 = starwars[c(2, 4, 7:10), c(1:2, 6)]

intersect( names(bd1), names(bd2) )

# Inner-join
merge(bd1, bd2, all=FALSE, by="name")

# Full-join
merge(bd1, bd2, all=TRUE, by="name")

# Left-join
merge(bd1, bd2, all.x=TRUE, by="name")

# Right-join
merge(bd1, bd2, all.y=TRUE, by="name")



# # # # # # # # # # # # # # # # # # # #
#### dplyr
sw = starwars

## filter()
sw1 = filter(sw, species=="Human" & height>=100)


## arrange()
sw2 = arrange(sw1, height, desc(mass))


## select()
sw3 = select(sw2, name:eye_color, sex:species)


## rename()
sw4 = rename(sw3,
             haircolor = hair_color,
             skincolor = skin_color,
             eyecolor = eye_color,
             )



## mutate()
sw5 = mutate(sw4,
             height = height / 100,
             const = 1,
             BMI = mass / height^2)



## Operador Pipe %>%
exemplo = sw %>% filter(species=="Human" & height>=100)

sw_pipe = sw %>% filter(species=="Human" & height>=100) %>%
  arrange(height, desc(mass)) %>%
  select(name:eye_color, sex:species) %>%
  rename(haircolor = hair_color,
         skincolor = skin_color,
         eyecolor = eye_color,
  ) %>%
  mutate(height = height / 100,
         const = 1,
         BMI = mass / height^2)


## summarise() / summarize()
starwars %>% summarise(
  n_obs = n(),
  height_mean = mean(height, na.rm=TRUE),
  mass_mean = mean(mass, na.rm=TRUE),
)


## group_by()
grouped_sw = starwars %>% group_by(gender) %>% mutate(
  height_mean = mean(height, na.rm=TRUE),
  mass_mean = mean(mass, na.rm=TRUE)
) %>% ungroup() %>%
  mutate(
    year_mean = mean(birth_year, na.rm=TRUE)
  )

sw = starwars %>% mutate(
  height_mean = mean(height, na.rm=TRUE),
  mass_mean = mean(mass, na.rm=TRUE)
)


## group_by() %>% summarise()
starwars %>% group_by(gender, hair_color) %>%
  summarise(
    n_obs = n(),
    height_mean = mean(height, na.rm=TRUE),
    mass_mean = mean(mass, na.rm=TRUE)
  )

cut(starwars$birth_year, breaks=5)
unique(cut(starwars$birth_year, breaks=5))

starwars %>% group_by(cut(birth_year, breaks=5)) %>%
  summarise(
    n_obs = n(),
    height_mean = mean(height, na.rm=TRUE),
    mass_mean = mean(mass, na.rm=TRUE)
  )




