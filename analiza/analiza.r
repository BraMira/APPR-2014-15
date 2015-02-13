# 4. faza: Analiza podatkov

m <- match(rownames(EkoRast), rownames(PovpR))
PovpR <- PovpR[m,]

x_tocke <-c(2005:2013)
mesta <- c("Murska Sobota", "Maribor","Ljubljana","Kranj","Novo mesto","Postojna",
           "Celje","Trbovlje","Nova Gorica","Koper","Krško","Slovenj Gradec")
glavna_mesta <- as.matrix(PovpPl[mesta,])
barve <- c("green4","blue","purple","orange","snow4","violet","red1","green","violetred1","turquoise1","brown","black")

cairo_pdf("slike/Povprečne_plače.pdf", family="Arial", onefile = TRUE)
#Graf spreminjanja neto plače v regijah

matplot(x_tocke,t(PovpR), type="b",col=barve, lty="solid",pch=1:12,
        main="Povprečna mesečna neto plača v regijah",
        xlab= "Leta 2005-2013", ylab= "Plača v EUR",
        xlim=c(2005,2015))
text(2014.25, PovpR[,9]+c(2,-8,-7,5,7,12,6,-8,4,-6,0,-1),rownames(PovpR),cex=0.7, col = barve)


#Graf spreminjanja neto plače v večjih mestih

matplot(x_tocke,t(glavna_mesta),type="b",
        col=barve,lty="solid",pch=1:12,
        ylab = "Plača v EUR", xlab= "Leta 2005-2013",
        main = "Povprečna mesečna neto plača v večjih mestih regij",
        xlim = c(2005,2015))
text(2014.25,glavna_mesta[,9]+c(0,-4,0,7,0,6,1,15,-10,-5,5,-2),mesta,cex=0.7,col=barve)
dev.off()
#Povezave med podatki in napovedi
cairo_pdf("slike/Napovedi.pdf", family="Arial", onefile = TRUE)

attach(ZadRegije[-1,])
attach(PovpR)
plot(Povprecje.2013,X2013)
par(new=TRUE)
plot(Povprecje.2012,X2012,axes=FALSE)
lin <- lm(X2013 ~ Povprecje.2013)
abline(lin, col="blue")
povp.r <- c(X2012, X2013)
zad <- c(Povprecje.2012, Povprecje.2013)
lin2 <- lm(povp.r ~ zad)
abline(lin2,col="red")
plot(zad,povp.r)
tri <- lowess(zad,povp.r)
points(tri,col="orangered4",pch=19)
lines(tri, col="orangered2")
library(mgcv)
los <- loess(povp.r~zad)
curve(predict(los,data.frame(zad=x)),
              add=TRUE,col="cyan")
gam1 <- gam(povp.r~s(zad))
curve(predict(gam1,data.frame(zad=x)),
      add=TRUE,col="brown")

detach(PovpR)
attach(EkoRast)
plot(Povprecje.2012,X2012)
lin1 <- lm(X2012~Povprecje.2012)
abline(lin1, col="green")
predict(lin1, data.frame(Povprecje.2012=seq(100, 800, 100)))
dva <- lowess(Povprecje.2012, X2012)
points(dva, col = "purple", cex = 0.7,pch=9)
lines(dva, col = "purple")
detach(EkoRast)
detach(ZadRegije[-1,])

dev.off()
