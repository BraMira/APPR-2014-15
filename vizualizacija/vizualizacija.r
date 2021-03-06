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

koordinate["Obalno-kraška",1] <- koordinate["Obalno-kraška",1] +0.08
koordinate["Obalno-kraška",2] <- koordinate["Obalno-kraška",2] +0.025
koordinate["Goriška",1]<- koordinate["Goriška",1]+0.08
koordinate["Zasavska",1] <- koordinate["Zasavska",1]+0.008
koordinate["Zasavska",2] <- koordinate["Zasavska",2]+0.01
koordinate["Spodnjeposavska",1] <- koordinate["Spodnjeposavska",1]-0.021
koordinate["Spodnjeposavska",2] <- koordinate["Spodnjeposavska",2] +0.02
imena["Jugovzhodna Slovenija"] <- "Jugovzhodna\nSlovenija"
imena["Notranjsko-kraška"] <- "Notranjsko-\nkraška"
imena["Obalno-kraška"]<-"Obalno-\nkraška"
koordinate["Pomurska",1] <- koordinate["Pomurska",1]+0.04

#Koordinate za številke

koordinate1 <- koordinate
koordinate1[,2]<- koordinate1[,2] - 0.06
koordinate1["Zasavska",1] <- koordinate1["Zasavska",1]+0.02
koordinate1["Obalno-kraška",2] <- koordinate1["Obalno-kraška",2] -0.04
koordinate1["Notranjsko-kraška",2] <- koordinate1["Notranjsko-kraška",2] -0.04
koordinate1["Jugovzhodna Slovenija",2] <- koordinate1["Jugovzhodna Slovenija",2] -0.04
cat("Rišem zemeljvid regij...\n")

#Zemljevid 1

cairo_pdf("slike/zemljevid1.pdf", family= "Arial")
regije$povprecje <- Regije$Povprecje.2013
min.povprecje <- min(Regije[12],na.rm=TRUE)
max.povprecje <- max(Regije[12],na.rm=TRUE)
norm <- (Regije[12]-min.povprecje)/(max.povprecje-min.povprecje)
n=100
barve=rgb(1,1,(n:1)/n)[unlist(1+(n-1)*norm)]
plot(regije,col = barve)
text(koordinate1,labels=Regije$Povprecje.2013,cex = 0.55)
text(koordinate,labels=imena,cex = 0.65)
title("Zemljevid 1: Povprečno zadovoljstvo z življenjem v letu 2013")
dev.off()


#Zemljevid 2

cairo_pdf("slike/zemljevid2.pdf", family="Arial", onefile = TRUE)
regije$Povsem.nezadovoljen <- Regije$Povsem.nezadovoljen.2013
regije$Nezadovoljen <- Regije$Nezadovoljen.2013
regije$Zadovoljen <- Regije$Zadovoljen.2013
regije$Zelo.zadovoljen <- Regije$Zelo.zadovoljen.2013

print(spplot(regije,"Povsem.nezadovoljen",col.regions=topo.colors(50),
             main = "Zemljevid 2: Ljudje povsem nezadovoljni z življenjem v letu 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.8))))            
print(spplot(regije,"Nezadovoljen",col.regions=topo.colors(50),
             main = "Zemljevid 3: Ljudje nezadovoljni z življenjem v letu 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.8))))
print(spplot(regije,"Zadovoljen",col.regions=topo.colors(50),
             main = "Zemljevid 4: Ljudje zadovoljni z življenjem v letu 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.8))))
print(spplot(regije,"Zelo.zadovoljen",col.regions=topo.colors(50),
             main = "Zemljevid 5: Ljudje zelo zadovoljni z življenjem v letu 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.8))))

dev.off()

#Zemljevid Evrope
cat("Rišem zemljevid Evrope...\n")
evr <- uvozi.zemljevid("http://geocommons.com/overlays/174267.zip",
                          "Evropa", "europe.shp", mapa = "zemljevid",
                          encoding = "Windows-1250")

nocemo <- c("Russia","Svalbard","Man, Isle of","Faroe Islands","Liechtenstein","Guernsey","Jan Mayen","Jersey","Andorra","Gibraltar","San Marino")
evropa <- evr[!evr$CntryName %in% nocemo,]

preuredi1 <- function(podatki, zemljevid) {
  nove.drzave <- c("Albania","Bosnia and Herzegovina","Byelarus","Macedonia","Moldova","Monaco","Serbia","Ukraine","Montenegro")
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
Evropa <- preuredi1(ZivZad[rownames(ZivZad) != "Cyprus",],evropa)

koord <- coordinates(evropa)
imena1 <- as.character(evropa$CntryName)
rownames(koord)<-imena1
names(imena1)<-imena1

#Uredim koordinate
koord["Norway",1] <- koord["Norway",1] - 4.8
koord["Norway",2] <- koord["Norway",2] - 3
koord["United Kingdom",1] <- koord["United Kingdom",1]+1
koord["United Kingdom",2] <- koord["United Kingdom",2]-1.3
koord["Ireland",1] <- koord["Ireland",1]+0.6
koord["Sweden",1] <- koord["Sweden",1]-1.4
koord["Greece",1] <- koord["Greece",1]-1
koord["Greece",2] <- koord["Greece",2]+0.18
koord["Finland",1] <- koord["Finland",1]+0.9
koord["Latvia",1] <- koord["Latvia",1]+0.4
koord["Lithuania",1] <- koord["Lithuania",1]+0.4
koord["Italy",1] <- koord["Italy",1]-0.4
koord["Austria",1] <- koord["Austria",1]+0.5
koord["Croatia",2] <- koord["Croatia",2]+0.4
koord["Croatia",1] <- koord["Croatia",1]+0.3
koord["Slovakia",2] <- koord["Slovakia",2]+0.1
koord["Slovakia",1] <- koord["Slovakia",1]+0.2
koord["Slovenia",2] <- koord["Slovenia",2]-0.1
koord["Slovenia",1] <- koord["Slovenia",1]-0.2
koord["Malta",2] <- koord["Malta",2]-0.5
koord["Portugal",2] <- koord["Portugal",2]-0.1
imena1["United Kingdom"] <- "UK"
imena1["Slovenia"] <- "SLO"
imena1["Croatia"]<- "CRO"
imena1["Switzerland"]<- "CH"
imena1["Belgium"]<- "BEL"
imena1["Greece"]<- "GR"
imena1["Czech Republic"]<- "CZ"
imena1["Slovakia"]<- "SK"

lux <- koord[rep("Luxembourg",2),]
lux[1,]<-lux[1,] - c(1,1.5)
koord["Luxembourg",] <- lux[1,]
net <- koord[rep("Netherlands",2),]
net[1,]<-net[1,] - c(0,-2)
koord["Netherlands",] <- net[1,]
den <- koord[rep("Denmark",2),]
den[1,]<-den[1,] - c(3,-1.2)
koord["Denmark",] <- den[1,]
imena1["Luxembourg"]<-"LUX"
cairo_pdf("slike/zemljevidE.pdf",family ="Arial",onefile=TRUE)

rot <- ifelse(imena1 == "Portugal", 90, 0)
evropa$Povprečje.2004 <- Evropa$Povprecje_2004
p2004 <- !is.na(Evropa$Povprecje_2004)
print(spplot(evropa,"Povprečje.2004",col.regions=terrain.colors(50),
             main = "Zemljevid 6: Povprečna pričakovana starost v letu 2004",
             sp.layout = list(list("sp.text",koord[p2004,],imena1[p2004],cex=0.55,srt=rot[p2004]),
                              list("sp.polygons",evropa[is.na(Evropa[,3]),],fill="white"),
                              list("sp.lines",Line(lux),col="black"),
                              list("sp.lines",Line(den),col="black")),
             par.settings=list(panel.background=list(col="lightblue"))))

evropa$Povprečje.2012 <- Evropa$Povprecje_2012
p2012 <- !is.na(Evropa$Povprecje_2012)
print(spplot(evropa,"Povprečje.2012",col.regions=terrain.colors(50),
             main = "Zemljevid 7: Povprečna pričakovana starost v letu 2012",
             sp.layout = list(list("sp.text",koord[p2012,],imena1[p2012],cex=0.55, srt=rot[p2012]),
                              list("sp.polygons",evropa[is.na(Evropa[,6]),],fill="white"),
                              list("sp.lines",Line(lux),col="black"),
                              list("sp.lines",Line(net),col="black"),
                              list("sp.lines",Line(den),col="black")),
             par.settings=list(panel.background=list(col="lightblue"))))
dev.off()

cat("Zemljevidi so narisani! \n")
