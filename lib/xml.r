# Uvoz s spletne strani

library(XML)

# Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

uvozi.obcine <- function() {
  url.obcine <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  doc.obcine <- htmlTreeParse(url.obcine, useInternalNodes=TRUE)
  
  # Poiščemo vse tabele v dokumentu
  tabele <- getNodeSet(doc.obcine, "//table")
  
  # Iz druge tabele dobimo seznam vrstic (<tr>) neposredno pod
  # trenutnim vozliščem
  vrstice <- getNodeSet(tabele[[2]], "./tr")
  
  # Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
  # s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
  seznam <- lapply(vrstice[2:length(vrstice)], stripByPath, "./td")
  
  # Iz seznama vrstic naredimo matriko
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  
  # Imena stolpcev matrike dobimo iz celic (<th>) glave (prve vrstice) prve tabele
  colnames(matrika) <- gsub("\n", " ", stripByPath(tabele[[2]][[1]], ".//th"))
  
  # Podatke iz matrike spravimo v razpredelnico
  return(data.frame(apply(gsub("\\*", "",
                          gsub(",", ".",
                          gsub("\\.", "", matrika[,2:5]))),
                    2, as.numeric), row.names=matrika[,1]))
}
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

#Moja datoteka:

stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

uvozi.regije <- function() {
  url.regije <- "podatki/RegijeHTML.htm"
  doc.regije <- htmlTreeParse(url.regije, useInternalNodes=TRUE, encoding = "Windows-1250")
  
  # Poiščemo vse tabele v dokumentu
  tabele1 <- getNodeSet(doc.regije, "//table")
  
  # Iz druge tabele dobimo seznam vrstic (<tr>) neposredno pod
  # trenutnim vozliščem
  vrstice1 <- getNodeSet(tabele1[[1]], "./tr")
  
  # Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
  # s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
  seznam1 <- lapply(vrstice1[5:length(vrstice1)-1], stripByPath, "./td")
  
  stolpci <- stripByPath(tabele1[[1]][[3]], "./th")[-1]
  
  # Iz seznama vrstic naredimo matriko
  matrika1 <- matrix(unlist(seznam1), nrow=length(seznam1), byrow=TRUE)
  
  # Imena stolpcev matrike dobimo iz celic (<th>) glave (prve vrstice) prve tabele
  colnames(matrika1) <- gsub("\n", " ", paste(stolpci, c(rep(2012, 6), rep(2013, 6))))
  
  # Podatke iz matrike spravimo v razpredelnico
  return(
    data.frame(apply(matrika1, 2, as.numeric),
               row.names = sapply(vrstice1[5:length(vrstice1)-1], stripByPath, "./th"))
  )
  
}

uvoziREGIJE<-uvozi.regije()

