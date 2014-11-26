# 2. faza: Uvoz podatkov

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvoziDruzine <- function() {
  return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
                      row.names = 1,
                      col.names = c("obcina", "en", "dva", "tri", "stiri"),
                      fileEncoding = "Windows-1250"))
}

# Zapišimo podatke v razpredelnico druzine.
cat("Uvažam podatke o družinah...\n")
druzine <- uvoziDruzine()

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.

uvoziSPOL <- function(){
  return(read.table("podatki/SplZdrStSPOL.csv", sep = ";", as.is = TRUE,
                    row.names = 1,
                    col.names = c(" ",rep("2005",5),rep("2006",5),rep("2007",5),rep("2008",5),rep("2009",5),rep("2010",5),rep("2011",5),rep("2012",5),rep("2013",5)),
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o splošnem zdr. stanju po SPOLU ...\n")
SplZdrStSPOL <- uvoziSPOL()

uvoziREGIJE <- function(){
  return(read.table("podatki/SplZadZivljREGIJE.csv", sep = ";", as.is = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o splošnem zadovoljstvu z življ. po REGIJAH ...\n")
SplZadZivljREGIJE <- uvoziREGIJE()

# uvoziSTAROST1 <- function(){
#   return(read.table("podatki/SplZadZivljSTAROST.csv", sep = ";", as.is = TRUE,
#                     row.names = 1,
#                     fileEncoding = "Windows-1250"))
#   
# }
# 
# cat("Uvažam podatke o splošnem zadovoljstvu z življ. po STAROSTI ...\n")
# SplZadZivljSTAROST <- uvoziSTAROST1()

uvoziSTAROST2 <- function(){
  return(read.table("podatki/SplZdrStSTAROST.csv", sep = ";", as.is = TRUE,
                    row.names = 1,
                    fileEncoding = "Windows-1250"))
  
}

cat("Uvažam podatke o splošnem zdravstvenem stanju glede na STAROST ...\n")
SplZdrStSTAROST <- uvoziSTAROST2()

uvoziSPOL1 <- function(){
  return(read.table("podatki/skupajSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                      row.names = 1,
                      col.names = c("Stanje",paste0("S", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju po SPOLU skupaj...\n")
skupajSPOL <- uvoziSPOL1()

uvoziSPOL2 <- function(){
  return(read.table("podatki/moskiSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                    row.names = 1,
                    col.names = c("Stanje",paste0("M", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju po SPOLU moški...\n")
moskiSPOL <- uvoziSPOL2()

uvoziSPOL3 <- function(){
  return(read.table("podatki/zenskeSPOL.csv", sep=";", as.is= TRUE, skip= 2,
                    row.names = c("Zelo dobro","Dobro","Srednje","Slabo","Zelo slabo"),
                    col.names = c("Stanje",paste0("Z", 2005:2013)),fileEncoding = "Windows-1250"))
}

cat("Uvažam podatke o zdravstvenem stanju po SPOLU ženski...\n")
zenskeSPOL <- uvoziSPOL3()
#zenskeSPOL <- zenskeSPOL
# #Združimo vse spole
#  SPOL1<- merge(moskiSPOL, zenskeSPOL, by=0 ,all = TRUE)
# SPOL <- merge(SPOL1, skupajSPOL, by = 0, all = FALSE)
