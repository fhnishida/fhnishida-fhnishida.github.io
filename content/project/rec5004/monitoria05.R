# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
## MONITORIA 5

### GRÁFICOS DO PACOTE BASE
pollution = read.csv("https://fhnishida.netlify.app/project/rec5004/avgpm25.csv")
summary(pollution)

## Boxplot
boxplot(pollution$pm25, col="blue")
boxplot(pollution$pm25 ~ pollution$region, col="blue")
abline(h=12, col="red")


## Histograma
hist(pollution$pm25, col="green")
hist(pollution$pm25, col="green", breaks=100)
rug(pollution$pm25)
abline(h=12, col="red")
abline(v=10, col="red")
abline(a=10, b=1, col="blue")

par(mfrow=c(1,1))


## Barplot
barplot(table(pollution$region), col="wheat", main="Titulo")


## Scatterplot
plot(pollution$latitude, pollution$pm25)
abline(h=12, col="red")



### GGPLOT2
library(ggplot2)
summary(mtcars)

g = ggplot(data=mtcars, aes(mpg, wt))
g

g + geom_point()

g + geom_point() + geom_smooth(method="lm")

g + geom_point() + geom_smooth(method="lm") + facet_grid(cyl ~ .)

g + geom_point() + geom_smooth(method="lm") + facet_grid(am ~ cyl)


g + geom_point() + ggthemes::theme_economist() +
  ylab("Peso") + xlab("milhas por galao") +
  ggtitle("Milhas por galao X Peso")

g + geom_point(color="steelblue", size=7, alpha=.8) +
  ggthemes::theme_economist() +
  ylab("Peso") + xlab("milhas por galao") +
  ggtitle("Milhas por galao X Peso")

g + geom_point(aes(color=cyl), size=7, alpha=.8) +
  ggthemes::theme_economist() +
  ylab("Peso") + xlab("milhas por galao") +
  ggtitle("Milhas por galao X Peso")




# # # # # # # # # # # # # # # # # # # # # # # #
## DISTRIBUIÇÕES
set.seed(1)
rnorm(5, mean=0, sd=1)

runif(5, 0, 10)

N = 100
x = runif(N, 0, 10)

e = rnorm(N)
y = 10 - 2*x + e

plot(x, y)
abline(a=10, b=-2)


## Amostragem
?sample()

sample(1:10, 5)

sample(1:10, 10, replace=T)



