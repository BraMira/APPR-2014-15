# 4. faza: Analiza podatkov


x_tocke <-c(2005:2013)
mesta <- c("Murska Sobota", "Maribor","Ljubljana","Kranj","Novo mesto","Postojna",
           "Celje","Trbovlje","Nova Gorica","Koper","Krško","Slovenj Gradec")
glavna_mesta <- as.matrix(PovpPl[mesta,])
barve <- c("green4","blue","purple","orange","snow4","violet","red1","green","violetred1","turquoise1","brown","black")


#Graf spreminjanja neto plače v regijah

matplot(x_tocke,t(PovpR), type="b",col=barve, lty="solid",pch=1:12,
        main="Povprečna mesečna neto plača v regijah",
        xlab= "Leta 2005-2013", ylab= "Plača v EUR",
        xlim=c(2005,2013.75))
text(2013.55, PovpR[,9]+c(2,-8,-7,5,7,12,6,-8,4,-3,0,-1),rownames(PovpR),cex=0.7, col = barve)


#Graf spreminjanja neto plače v večjih mestih

matplot(x_tocke,t(glavna_mesta),type="b",
        col=barve,lty="solid",pch=1:12,
        ylab = "Plača v EUR", xlab= "Leta 2005-2013",
        main = "Povprečna mesečna neto plača v večjih mestih regij",
        xlim = c(2005,2013.5))
text(2013.5,glavna_mesta[,9]+c(0,-4,0,7,0,6,1,15,-10,-5,5,-2),mesta,cex=0.7,col=barve)

#Povezave med podatki in napovedi

attach(ZadRegije[-1,])
# attach(PovpR)
# plot(Povprecje.2013,X2013)
# lin <- lm(X2013 ~ Povprecje.2013)
# abline(lin, col="blue")
# detach(PovpR)

attach(EkoRast)
plot(Povprecje.2012,X2012)
lin1 <- lm(X2012~Povprecje.2012)
abline(lin1, col="green")
predict(lin, data.frame(Povprecje.2012=seq(100, 800, 100)))
# dva <- lowess(Povprecje.2012, X2012)
# points(dva, col = "green", cex = 0.7)
# lines(dva, col = "green")
detach(EkoRast)
detach(ZadRegije[-1,])

