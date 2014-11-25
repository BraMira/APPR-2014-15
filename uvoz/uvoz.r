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