# 2. faza: Uvoz podatkov

#Pred začetkom zaženi naslednje funkcije:

procenti <- c("0-4 (%)","5-6 (%)","7-8 (%)","9-10 (%)","Neznano (%)","Povprečje")
procenti[1:5]<-  c("Povsem nezadovoljen","Nezadovoljen", "Zadovoljen","Zelo zadovoljen", "Neznano")
starosti <- c("Starostne skupine - SKUPAJ","16-25 let","26-35 let","36-45 let","46-55 let","56-65 let","66 ali več let")
stanja <- c("Zelo slabo", "Slabo","Srednje","Dobro","Zelo dobro")
stanja1 <- rev(stanja)

"Uvoz tabel HTML"

source("lib/xml.r", encoding="UTF-8")
ZdrStarost <- uvozi.starost()
ZdrSpol <- uvozi.spol()
ZadRegije<-uvozi.regije()

#TABELA 1
#Tabela zadovoljstva z življenjem glede na zdravstveno stanje

uvoziSTANJE <- function(){
  t <- read.table("podatki/ZadovoljstvoSTANJE1213.csv", sep = ";",as.is = TRUE, skip = 7,na.strings= "NA",
                    col.names=c("Spol", "Zdravstveno stanje",paste0(procenti, "_2012"), 
                                paste0(procenti, "_2013")),
                    fileEncoding = "Windows-1250")[c(-6,-12:-17),c(-1,-2)]
  row.names(t) <- c(paste("M",stanja1),paste("Z",stanja1))
  return(t)
}
  
cat("Uvažam podatke o splošnem zadovoljstvu z življenjem glede na ZDRAVSTVENO STANJE ...\n")
ZadStanje <- uvoziSTANJE()

#TABELA 2
#Tabela zadovoljstva z življenjem glede na starosti

uvoziSTAROST <- function(){
  r <- read.table("podatki/ZadovoljstvoSTAROST1213.csv", sep = ";", skip= 15,as.is = TRUE, na.strings= "NA",
                  blank.lines.skip=TRUE,
                  
                  col.names = c("Spol","Starostne skupine",paste0(procenti, "_2012"), paste0(procenti, "_2013")),
                  fileEncoding = "Windows-1250")[-8,c(-1,-2)]
  row.names(r) <- c(paste("M", starosti),paste("Z", starosti))
  return(r)
}
ZadStarosti <- uvoziSTAROST()





#Za drugo fazo:

# uvoziSTANJE <- function(){
#   # preberemo tabelo, pri čemer izpustimo prazne vrstice ter vsote in povprečja
#   ZadStanje <- read.table("podatki/ZadovoljstvoSTANJE1213.csv", sep = ";",as.is = TRUE, skip = 6,na.strings= "NA",
#                           col.names=c("Spol", "Zdravstveno stanje",paste0(procenti, "_2012"), paste0(procenti, "_2013")),
#                           fileEncoding = "Windows-1250", nrows = 12)[c(-1, -7), c(-8, -14)]
#   # pripravimo vsebino novih stolpcev
#   frekvence <- unlist(ZadStanje[3:12])
#   # poberemo podatke iz imen dobljenega  vektorja
#   stolpci <- matrix(unlist(strsplit(gsub("(_[0-9]{4}).*$", "\\1",
#                                          gsub("\\.", " ", names(frekvence))), "_")),
#                     ncol = 2, byrow = TRUE)
#   # naredimo faktor za zdravstvena stanja
#   Stanja <- factor(ZadStanje$Zdravstveno.stanje, levels = stanja, ordered = TRUE)
#   # naredimo faktor za zadovoljstvo, pri čemer vrednosti "Neznano" ne upoštevamo
#   Zadovoljstvo <- factor(stolpci[,1], levels = procenti[1:4], ordered = TRUE)
#   # podatke zberemo v novo tabelo brez imen vrstic
#   return(
#     data.frame(Spol = c(rep("Moški", 5), rep("Ženske", 5)),
#                Zdravstveno.stanje = Stanja,
#                Zadovoljstvo = Zadovoljstvo,
#                Leto = as.numeric(stolpci[,2]),
#                Frekvenca = frekvence,
#                row.names = NULL)
#   )
# }
#ZadStanje <- uvoziSTANJE()



#Funkcije, ki so dodane kot html, ne csv  

# uvoziSTAROST2 <- function(){
#   return(read.table("podatki/SplZdrStSTAROST.csv", sep = ";", as.is = TRUE,skip = 5,
#                     row.names=1,
#                     col.names = c("Starosti",paste0(stanja1,"_", 2005),paste0(stanja1, "_", 2006),paste0(stanja1, "_", 2007),paste0(stanja1, "_", 2008),paste0(stanja1, "_", 2009),paste0(stanja1, "_", 2010),paste0(stanja1, "_", 2011),paste0(stanja1, "_", 2012),paste0(stanja1, "_", 2013)),
#                     fileEncoding = "Windows-1250"))
#   
# }
# 
# cat("Uvažam podatke o zdravstvenem stanju glede na STAROST ...\n")
# ZdrStarost <- uvoziSTAROST2()



# uvoziSPOL <- function(){
#   return(read.table("podatki/SPOL/SplZdrStSPOL.csv", sep=";", as.is = TRUE, skip = 4,
#                     row.names=1,
#                     col.names = c("Stanje",paste0("S", 2005:2013), paste0("M", 2005:2013), paste0("Z",2005:2013)),
#                     fileEncoding = "Windows-1250"))
# }
# cat("Uavažam podatke o zdravstvenem stanju oseb glede na SPOL... \n")

# uvoziREGIJE <- function(){
#   return(read.table("podatki/SplZadZivljREGIJE.csv", sep = ";", as.is = TRUE,
#                     
#                     fileEncoding = "Windows-1250"))
#   
# }
# cat("Uvažam podatke o splošnem zadovoljstvu z življenjem po REGIJAH ...\n")
# SplZadZivljREGIJE <- uvoziREGIJE()

# ZdrSpol <- uvoziSPOL()