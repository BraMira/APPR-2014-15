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

pdf("slike/zemljevid.pdf")
regije$povprecje <- Regije$Povprecje.2013
plot(regije,col = topo.colors(12))
text(koordinate1,labels=Regije$Povprecje.2013,cex = 0.45)
text(koordinate,labels=imena,cex = 0.4)
title("Povprečno zadovoljstvo z življenjem v letu 2013")

#Zemljevid 2

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
             main = "Ljudje nezadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))
print(spplot(regije,"Zelo.zadovoljen",col.regions=topo.colors(50),
             main = "Ljudje zelo zadovoljni z življenjem v 2013",
             sp.layout = list(list("sp.text",koordinate,imena,cex=0.5))))

dev.off()


