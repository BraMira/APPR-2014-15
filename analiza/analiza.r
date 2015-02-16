# 4. faza: Analiza podatkov

m <- match(rownames(EkoRast), rownames(PovpR))
PovpR <- PovpR[m,]

x_tocke <-c(2005:2013)
barve <- c("green4","blue","purple","orange","snow4","violet","red1","green","violetred1","turquoise1","brown","black")

cat("Rišem graf s podatki o plačah...\n")

cairo_pdf("slike/Povprečne_plače.pdf", family="Arial", onefile = TRUE)
#Graf spreminjanja neto plače v regijah

matplot(x_tocke,t(PovpR), type="b",col=barve, lty="solid",pch=1:12,
        main="Povprečna mesečna neto plača v regijah",
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
        main = "Povprečna mesečna neto plača v večjih mestih regij",
        xlim = c(2005,2015.5))
text(2014.5,glavna_mesta[,9]+c(0,-5,3,5,45,22,0,5,30,0,-5,5,0,0),
     c(mesta,rownames(PovpPl[which.min(PovpPl$Povprecje),]),rownames(PovpPl[which.max(PovpPl$Povprecje),])),
cex=0.7,col=c(barve,rep("black",2)))
dev.off()

#Grafi s podatki o podjetjih

cairo_pdf("slike/Podjetja.pdf",family="Arial",onefile=TRUE)

zap.R <- as.matrix(Podjetja[,seq(4,length(Podjetja),4)])
matplot(c(2008:2013),t(zap.R),type="l",col=barve,lty="solid",
        xlab="Leta 2008-2013",ylab="Število oseb, ki delajo na podjetje v regiji",
        xlim=c(2008,2014.5))
text(2013.75,Podjetja[,24]+c(0,-0.07,-0.07,0.06,0,0.04,-0.01,0,0,0.1,-0.03,0) ,
     rownames(Podjetja),cex=0.7,col=barve)

attach(Podjetja)
st_podjetij <- c(Število.podjetij_2008,Število.podjetij_2009,Število.podjetij_2010,
                 Število.podjetij_2011,Število.podjetij_2012,Število.podjetij_2013)
st_zaposlenih <- c(Število.oseb.ki.delajo_2008,Število.oseb.ki.delajo_2009,Število.oseb.ki.delajo_2010,
                   Število.oseb.ki.delajo_2011,Število.oseb.ki.delajo_2012,Število.oseb.ki.delajo_2013)
plot(range(st_zaposlenih),range(st_podjetij),"n",
     ylab="Število podjetij 2008-2013",xlab="Število zaposlenih 2008-2013")
points(Število.oseb.ki.delajo_2008,Število.podjetij_2008,col="green")
points(Število.oseb.ki.delajo_2009,Število.podjetij_2009,col="blue")
points(Število.oseb.ki.delajo_2010,Število.podjetij_2010,col="red")
points(Število.oseb.ki.delajo_2011,Število.podjetij_2011,col="cyan")
points(Število.oseb.ki.delajo_2012,Število.podjetij_2012,col="black")
points(Število.oseb.ki.delajo_2013,Število.podjetij_2013,col="violet")

lin <-lm(st_podjetij~st_zaposlenih)
abline(lin,col="purple")
legend("bottomright",legend=c(2008:2013), y.intersp=1,
       pch=1,col=c("green","blue","red","cyan","black","violet"))
dev.off()

cat("Rišem grafe z napovedmi...\n")

#Povezave med podatki in napovedi
cairo_pdf("slike/Napovedi.pdf", family="Arial", onefile = TRUE)

attach(ZadRegije[-1,])
zad <- c(Povprecje.2012, Povprecje.2013)
pod <- c(Število.podjetij_2012,Število.podjetij_2013)
zap <-c(Število.oseb.ki.delajo_2012,Število.oseb.ki.delajo_2013)

plot(range(zad),range(pod),"n",xlab="Zadovoljstvo",ylab="Število podjetij")
points(Povprecje.2012,Število.podjetij_2012)
points(Povprecje.2013,Število.podjetij_2013,pch=19)
abline(lm(pod~zad),col="blue")
legend("topleft",legend=c(2013,2012),pch=c(1,19),col="black")

plot(range(zad),range(zap),"n",xlab="Zadovoljstvo",ylab="Število zaposlenih")
points(Povprecje.2012,Število.oseb.ki.delajo_2012)
points(Povprecje.2013,Število.oseb.ki.delajo_2013,pch=19)
abline(lm(zap~zad),col="green")
legend("topleft",legend=c(2013,2012),pch=c(1,19),col="black")

# plot(Povprecje.2013,Število.podjetij_2013)
# abline(lm(Število.podjetij_2013 ~Povprecje.2013),col="blue")
# plot(Povprecje.2013,Število.oseb.ki.delajo_2013)
# abline(lm(Število.oseb.ki.delajo_2013 ~Povprecje.2013),col="green")

#Ni zanimiv?
# plot(Povprecje.2013,Število.oseb.ki.delajo.na.podjetje.v.regiji_2013)
# abline(lm(Število.oseb.ki.delajo.na.podjetje.v.regiji_2013 ~Povprecje.2013),col="red")

detach(Podjetja)

#attach(ZadRegije[-1,])
attach(PovpR)
povp.r <- c(X2012, X2013)

plot(range(zad), range(povp.r), "n",
     xlab="Zadovoljstvo z življenjem",ylab="Povprečje neto mesečne plače") # pripravimo koordinatni sistem
points(Povprecje.2013, X2013, col = "black")
points(Povprecje.2012, X2012, col = "black",pch=19)
legend("topleft",legend=c(2013,2012),pch=c(1,19),col="black")
# lin <- lm(X2013 ~ Povprecje.2013)
# abline(lin, col="blue")

lin2 <- lm(povp.r ~ zad)
abline(lin2,col="red")

#predict(lin2,data.frame(zad=seq(1,5,1)))

tri <- lowess(zad,povp.r)
# points(tri,col="green",pch=19)
lines(tri, col="green")

# library(mgcv)
# los <- loess(povp.r~zad)
# curve(predict(los,data.frame(zad=x)),
#               add=TRUE,col="cyan")


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