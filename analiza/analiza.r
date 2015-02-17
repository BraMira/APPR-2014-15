# 4. faza: Analiza podatkov

m <- match(rownames(Prebivalstvo), rownames(PovpR))
PovpR <- PovpR[m,]
l<- match(rownames(Prebivalstvo),rownames(Podjetja))
Podjetja<-Podjetja[l,]
x_tocke <-c(2005:2013)
barve <- c("green4","blue","purple","orange","snow4","violet","red1","green","violetred1","turquoise1","brown","black")

cat("Rišem graf s podatki o plačah...\n")

cairo_pdf("slike/Povprecne_place.pdf", family="Arial", onefile = TRUE)
#Graf spreminjanja neto plače v regijah

matplot(x_tocke,t(PovpR), type="b",col=barve, lty="solid",pch=1:12,
        main="Graf 7: Povprečna mesečna neto plača v regijah",
        xlab= "Leta 2005-2013", ylab= "Plača v EUR",
        xlim=c(2005,2015))
text(2014.25, PovpR[,9]+c(2,-8,-7,5,7,12,6,-8,4,-6,0,-1),rownames(PovpR),cex=0.7, col = barve)


#Graf spreminjanja neto plače v večjih mestih
dolzina <- length(rownames(PovpPl))
PovpPl$Povprecje <- apply(PovpPl,1 ,function(x) mean(x,na.rm=TRUE))


mesta <- c("Murska Sobota","Maribor",
           "Ravne na Koroškem","Celje",
           "Trbovlje","Krško","Novo mesto",
           "Ljubljana","Kranj","Postojna",
           "Nova Gorica","Koper")

glavna_mesta <- as.matrix(PovpPl[mesta,])
glavna_mesta <- rbind(glavna_mesta,PovpPl[which.min(PovpPl$Povprecje),])
glavna_mesta <- rbind(glavna_mesta,PovpPl[which.max(PovpPl$Povprecje),])
matplot(x_tocke,t(glavna_mesta[,-length(PovpPl)]),type=c(rep("b",length(mesta)),rep("l",2)),
        col=c(barve,"red","red"),lty=c(rep("solid",length(mesta)),rep("dashed",2)),pch=1:12,
        ylab = "Plača v EUR", xlab= "Leta 2005-2013",
        main = "Graf 8: Povprečna mesečna neto plača v večjih mestih regij",
        xlim = c(2005,2015.5))
text(2014.5,glavna_mesta[,9]+c(0,-5,3,5,45,22,0,5,30,0,-5,5,0,0),
     c(mesta,rownames(PovpPl[which.min(PovpPl$Povprecje),]),rownames(PovpPl[which.max(PovpPl$Povprecje),])),
cex=0.7,col=c(barve,rep("black",2)))
dev.off()

#Grafi s podatki o podjetjih

cairo_pdf("slike/Podjetja.pdf",family="Arial",onefile=TRUE)

st_podjetij <- as.matrix(Podjetja[,seq(1,length(Podjetja),4)])
st_podjetij <- st_podjetij/Prebivalstvo[,4:9]
matplot(c(2008:2013),t(st_podjetij),type="l",col=barve,lty="solid",lwd=2,
        xlab="Leta 2008-2013",ylab="Število podjetij/Število prebivalcev",
        ylim=c(0.05,0.12),
        main="Graf 9: Število podjetij v regijah v letih 2008-2013")
legend("topleft",legend=rownames(Podjetja),lty="solid",col=barve,cex=0.7,ncol=3,lwd=2)

st_zaposlenih <- as.matrix(Podjetja[,seq(2,length(Podjetja),4)])
st_zaposlenih <- st_zaposlenih/Prebivalstvo[,4:9]
matplot(c(2008:2013),t(st_zaposlenih),type="l",col=barve, lty="solid",lwd=2,
        xlab= "Leta 2008-2013",ylab="Število zaposlenih/Število prebivalcev",
        main="Graf 10: Število zaposlenih v podjetjih v letih 2008-2013")
legend(2007.8, 0.6, legend=rownames(Podjetja),lty="solid",col=barve,cex=0.7,lwd=2)

zap.R <- as.matrix(Podjetja[,seq(4,length(Podjetja),4)])
matplot(c(2008:2013),t(zap.R),type="l",col=barve,lty="solid",lwd=2,
        xlab="Leta 2008-2013",ylab="Število oseb, ki delajo na podjetje v regiji",
        xlim=c(2008,2013),
        main="Graf 11: Število oseb, ki delajo na podjetje v regiji v letih 2008-2013")
legend("topright",legend=rownames(Podjetja),lty="solid",col=barve,cex=0.7,ncol=2,lwd=2)

dev.off()

cat("Rišem grafe z napovedmi...\n")

#Povezave med podatki in napovedi
cairo_pdf("slike/Napovedi1.pdf", family="Arial", onefile = TRUE)
attach(st_podjetij)
attach(ZadRegije[-1,])

zad <- c(Povprecje.2012, Povprecje.2013)
leta <-c(X2012,X2013)
plot(range(zad),range(leta),"n",xlab="Zadovoljstvo",ylab="Število podjetij/Število prebivalcev",
     main="Graf 12: Povezava med zadovoljstvom z življenjem \n in številom podjetij v regijah")
points(Povprecje.2012,X2012)
points(Povprecje.2013,X2013,pch=19)
lin <-lm(leta~zad)
koef <- coefficients(lin)
abline(lin,col="blue")
kv <-lm(leta~I(zad^2)+zad)
koef1 <- coefficients(kv)
curve(predict(kv,data.frame(zad=x)),add=TRUE,col="violet")

library(mgcv)
loess <- loess(leta~zad)
curve(predict(loess, data.frame(zad=x)),add=TRUE,col="orange")
legend("bottomright",legend=c(2013,2012),pch=c(1,19),col="black")
legend("topleft",legend=c("Linearna","Kvadratična","Loess"),
       lty="solid",col=c("blue","violet","orange"),title="Prileganje podatkov:")
resid <- sapply(list(lin,kv,loess), function(x) sum(x$residuals^2)) #Tisti ki ima manj je boljši model
napoved <- function(x, model){predict(model,data.frame(zad=x))}
plot(range(zad),range(leta),"n",xlab="Zadovoljstvo",ylab="Število podjetij/Število prebivalcev",
     xlim=c(6.6,10),ylim=c(0.06,0.15),main="Napoved 1")
points(Povprecje.2012,X2012)
points(Povprecje.2013,X2013,pch=19)
curve(napoved(x, lin),col="blue",add=TRUE)
curve(napoved(x, kv),col="violet",add=TRUE)
legend("topleft",legend=c("Linearna","Kvadratična"),lty="solid",col=c("blue","violet"))
detach(st_podjetij)
dev.off()

cairo_pdf("slike/Napovedi2.pdf", family="Arial", onefile = TRUE)
attach(st_zaposlenih)
leta <-c(X2012,X2013)
plot(range(zad),range(leta),"n",xlab="Zadovoljstvo",ylab="Število zaposlenih/Število prebivalcev",
     main="Graf 13: Povezava med zadovoljstvom z življenjem \n in številom zaposlenih v regijah")
points(Povprecje.2012,X2012)
points(Povprecje.2013,X2013,pch=19)
lin1 <-lm(leta~zad)
koef3 <- coefficients(lin1)
abline(lin1,col="blue")
kv1 <-lm(leta~I(zad^2)+zad)
koef4 <- coefficients(kv1)
curve(predict(kv1,data.frame(zad=x)),add=TRUE,col="violet")
loess1 <- loess(leta~zad)
curve(predict(loess1, data.frame(zad=x)),add=TRUE,col="orange")
resid1 <- sapply(list(lin1,kv1,loess1), function(x) sum(x$residuals^2))
legend("left",legend=c(2013,2012),pch=c(1,19),col="black")
legend("topleft",legend=c("Linearna","Kvadratična","Loess"),
       lty="solid",col=c("blue","violet","orange"),title="Prileganje podatkov:")
plot(range(zad),range(leta),"n",xlab="Zadovoljstvo",ylab="Število zaposlenih/Število prebivalcev",
     xlim=c(6.6,10),ylim=c(0.25,0.9),main="Napoved 2")
points(Povprecje.2012,X2012)
points(Povprecje.2013,X2013,pch=19)
curve(napoved(x, lin1),col="blue",add=TRUE)
curve(napoved(x, kv1),col="violet",add=TRUE)
legend("topleft",legend=c("Linearna","Kvadratična"),lty="solid",col=c("blue","violet"))
detach(st_zaposlenih)
dev.off()
# zap_pod <- c(as.numeric(zap.R[,5]),as.numeric(zap.R[,6]))
# plot(range(zad),range(zap_pod),"n",
#      xlab= "Zadovoljstvo",ylab="Število oseb, ki delajo na podjetje v regiji")
# points(Povprecje.2012,as.numeric(zap.R[,5]))
# points(Povprecje.2013,as.numeric(zap.R[,6]),pch=19)
# abline(lm(zap_pod~zad),col="cyan")
# legend("topleft",legend=c(2013,2012),pch=c(1,19),col="black")

cairo_pdf("slike/Napovedi3.pdf", family="Arial", onefile = TRUE)
attach(PovpR)
povp.r <- c(X2012, X2013)

plot(range(zad), range(povp.r), "n",
     xlab="Zadovoljstvo z življenjem",ylab="Povprečje neto mesečne plače",
     main="Graf 14: Povezava med zadovoljstvom z življenjem \n in povprečno mesečno neto plačo v regijah") # pripravimo koordinatni sistem
points(Povprecje.2013, X2013, col = "black")
points(Povprecje.2012, X2012, col = "black",pch=19)
legend("left",legend=c(2013,2012),pch=c(1,19),col="black")
legend("topleft",legend=c("Linearna","Kvadratična","Loess","Prileganje z zlepki"),
       lty="solid",col=c("blue","violet","orange","green"),title="Prileganje podatkov:")
# lin <- lm(X2013 ~ Povprecje.2013)
# abline(lin, col="blue")

lin2 <- lm(povp.r ~ zad)
koef5 <- coefficients(lin2)
abline(lin2,col="blue")
kv2 <-lm(povp.r~I(zad^2)+zad)
koef6 <-coefficients(kv2)
curve(predict(kv2,data.frame(zad=x)),add=TRUE,col="violet")
loess2 <- loess(povp.r~zad)
curve(predict(loess2, data.frame(zad=x)),add=TRUE,col="orange")
resid2 <- sapply(list(lin2,kv2,loess2), function(x) sum(x$residuals^2))
tri <- lowess(zad,povp.r)
lines(tri, col="green")

napoved <- function(x, model){predict(model,data.frame(zad=x))}
plot(range(zad),range(povp.r),"n",xlab="Zadovoljstvo",ylab="Povprečje neto mesečne plače",
     xlim=c(6.6,10),ylim=c(900,1100),main="Napoved 3")
points(Povprecje.2012,X2012)
points(Povprecje.2013,X2013,pch=19)
curve(napoved(x, lin2),col="blue",add=TRUE)
curve(napoved(x, kv2),col="violet",add=TRUE)
legend("topright",legend=c("Linearna","Kvadratična"),lty="solid",col=c("blue","violet"))
detach(PovpR)
#SE SPLAČA VKLJUČITI?

# attach(EkoRast)
# plot(Povprecje.2012,X2012, xlab= "Zadovoljstvo z življenjem",ylab="Ekonomska rast")
# lin1 <- lm(X2012~Povprecje.2012)
# abline(lin1, col="green")
# predict(lin1, data.frame(Povprecje.2012=seq(100, 800, 100)))
# dva <- lowess(Povprecje.2012, X2012)
# points(dva, col = "purple", cex = 0.7,pch=9)
# lines(dva, col = "purple")
# detach(EkoRast)
detach(ZadRegije[-1,])

dev.off()
cat("Analiza podatkov končana!\n")