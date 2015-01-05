# 3. faza: Izdelava zemljevida

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
regije <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/SVN_adm.zip",
                          "Slovenija", "SVN_adm1.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")

# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.regije <- c()
  manjkajo <- ! nove.regije %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.regije[manjkajo]
  podatki <- rbind(podatki, M)
  
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}

Regije <- preuredi(ZadRegije[-1,],regije)

#Uredim koordinate in imena

koordinate <- coordinates(regije)
imena <- as.character(regije$NAME_1)
rownames(koordinate)<-imena
names(imena)<-imena

koordinate["Obalno-kraška",1] <- koordinate["Obalno-kraška",1] +0.1
koordinate["Obalno-kraška",2] <- koordinate["Obalno-kraška",2] +0.025
koordinate["Goriška",1]<- koordinate["Goriška",1]+0.08
koordinate["Zasavska",1] <- koordinate["Zasavska",1]+0.008
koordinate["Zasavska",2] <- koordinate["Zasavska",2]+0.02
koordinate["Spodnjeposavska",1] <- koordinate["Spodnjeposavska",1]+0.06
koordinate["Spodnjeposavska",2] <- koordinate["Spodnjeposavska",2] +0.008
imena["Jugovzhodna Slovenija"] <- "Jugovzhodna\nSlovenija"
imena["Notranjsko-kraška"] <- "Notranjsko-\nkraška"
imena["Obalno-kraška"]<-"Obalno-\nkraška"

#Koordinate za številke

koordinate1 <- koordinate
koordinate1[,2]<- koordinate1[,2] - 0.06
koordinate1["Zasavska",1] <- koordinate1["Zasavska",1]+0.02
koordinate1["Obalno-kraška",2] <- koordinate1["Obalno-kraška",2] -0.02
koordinate1["Notranjsko-kraška",2] <- koordinate1["Notranjsko-kraška",2] -0.02
koordinate1["Jugovzhodna Slovenija",2] <- koordinate1["Jugovzhodna Slovenija",2] -0.02
cat("Rišem zemeljvid regij...\n")

#Zemljevid 1

pdf("slike/zemljevid1.pdf")
regije$povprecje <- Regije$Povprecje.2013
plot(regije,col = topo.colors(12))
text(koordinate1,labels=Regije$Povprecje.2013,cex = 0.45)
text(koordinate,labels=imena,cex = 0.4)
title("Povprečno zadovoljstvo z življenjem v letu 2013")
dev.off()
#Zemljevid 2
pdf("slike/zemljevid2.pdf")
regije$Povsem.nezadovoljen <- Regije$Povsem.nezadovoljen.2013
regije$Nezadovoljen <- Regije$Nezadovoljen.2013
regije$Zadovoljen <- Regije$Zadovoljen.2013
regije$Zelo.zadovoljen <- Regije$Zelo.zadovoljen.2013

print(spplot(regije,"Povsem.nezadovoljen",col.regions=topo.colors(50),
             main = "Ljudje povsem nezadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))
             
print(spplot(regije,"Nezadovoljen",col.regions=topo.colors(50),
             main = "Ljudje nezadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))
print(spplot(regije,"Zadovoljen",col.regions=topo.colors(50),
             main = "Ljudje zadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))
print(spplot(regije,"Zelo.zadovoljen",col.regions=topo.colors(50),
             main = "Ljudje zelo zadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))

dev.off()

#Zemljevid Evrope
cat("Rišem zemljevid Evrope...\n")
evr <- uvozi.zemljevid("http://geocommons.com/overlays/174267.zip",
                          "Evropa", "europe.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")

nocemo <- c("Russia","Svalbard","Man, Isle of","Faroe Islands","Liechtenstein","Guernsey","Jan Mayen","Jersey","Andorra","Gibraltar","San Marino")
evropa <- evr[!evr$CntryName %in% nocemo,]

preuredi1 <- function(podatki, zemljevid) {
  nove.drzave <- c("Albania","Bosnia and Herzegovina","Byelarus","Macedonia","Moldova","Monaco","Serbia","Ukraine")
  manjkajo1 <- ! nove.drzave %in% rownames(podatki)
  M1 <- as.data.frame(matrix(nrow=sum(manjkajo1), ncol=length(podatki)))
  names(M1) <- names(podatki)
  row.names(M1) <- nove.drzave[manjkajo1]
  podatki <- rbind(podatki, M1)
  
  out1 <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$CntryName)[rank(zemljevid$CntryName)]), ]
  if (ncol(podatki) == 1) {
    out1 <- data.frame(out1)
    names(out1) <- names(podatki)
    rownames(out1) <- rownames(podatki)
  }
  return(out1)
}
Evropa <- preuredi1(ZivZad,evropa)

koord <- coordinates(evropa)
imena1 <- as.character(evropa$CntryName)
rownames(koord)<-imena1
names(imena1)<-imena1

#Uredim koordinate
koord["Norway",1] <- koord["Norway",1] - 4.8
koord["Norway",2] <- koord["Norway",2] - 3

#koord["Cyprus",2] <- koord["Cyprus",2] - 1
koord["United Kingdom",1] <- koord["United Kingdom",1]+1
koord["United Kingdom",2] <- koord["United Kingdom",2]-1
koord["Ireland",1] <- koord["Ireland",1]+0.8
koord["Sweden",1] <- koord["Sweden",1]-1
koord["Greece",1] <- koord["Greece",1]-0.8
imena1["United Kingdom"] <- "United\nKingdom"
pdf("slike/zemljevidE.pdf")
evropa$Povprečje.2004 <- Evropa$Povprecje_2004
print(spplot(evropa,"Povprečje.2004",col.regions=topo.colors(50),
             main = "Povprečna pričakovana starost v letu 2004",
             sp.layout = list(list("sp.text",koord,imena1,cex=0.4))))

evropa$Povprečje.2012 <- Evropa$Povprecje_2012
print(spplot(evropa,"Povprečje.2012",col.regions=topo.colors(50),
             main = "Povprečna pričakovana starost v letu 2012",
             sp.layout = list(list("sp.text",koord,imena1,cex=0.4))))
dev.off()

# cat("Uvažam zemljevid sveta...\n")
# svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
#                         "europa", "ne_110m_admin_0_countries.shp", mapa = "zemljevid",
#                         encoding = "Windows-1250")
# 
# #Dodamo mankajoče države
# manjkajoce.drzave <- c("Albania", "Belarus", "Kosovo", "Moldova", "Russian Federation", "Ukraine")
# drzave <- c(rownames(ZivZad), manjkajoce.drzave)
# drzave <- drzave[drzave %in% svet$name_long]
# EU <- svet[svet$name_long %in% drzave,]
# # Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.
# manjkajo <- ! manjkajoce.drzave %in% rownames(ZivZad)
# M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(ZivZad)))
# names(M) <- names(ZivZad)
# row.names(M) <- manjkajoce.drzave[manjkajo]
# eeuro <- rbind(ZivZad, M)[as.character(EU$name_long),]
# izbor12 <- !is.na(eeuro[,6])
# koordinate3 <- coordinates(EU[izbor12,])
# imena3 <- as.character(EU$name[izbor12])
# rownames(koordinate3) <- imena3
# names(imena3) <- imena3
# izbor4 <- !is.na(eeuro[,3])
# koordinate1 <- coordinates(EU[izbor4,])
# imena1 <- as.character(EU$name[izbor4])
# rownames(koordinate1) <- imena1
# names(imena1) <- imena1
# 
# EU$Popvrečje2004 <- eeuro[,3]
# EU$Povprečje2012 <- eeuro[,6]
# pdf("slike/evropa.pdf")
# print(spplot(EU, "Povprečje2004", xlim=c(-25, 40), ylim=c(33, 73),
#              main = "Popvrečje za 2004",
#              col.regions = topo.colors(100),
#              sp.layout = list(
#                list("sp.polygons", EU[is.na(eeuro[,3]),], fill = "white"),
#                list("sp.text", koordinate1, imena1, cex = 0.3)),
#              par.settings = list(panel.background=list(col="lightyellow"))))
# # 
# # print(spplot(EU, "Povprečje2012", xlim=c(-25, 40), ylim=c(33, 73),
# #              main = "Povprečje za 2012",
# #              col.regions = topo.colors(100),
# #              sp.layout = list(
# #                list("sp.polygons", EU[is.na(eeuro[,6]),], fill = "white"),
# #                list("sp.text", koordinate, imena, cex = 0.3)),
# #              par.settings = list(panel.background=list(col="lightyellow"))))
# dev.off()
