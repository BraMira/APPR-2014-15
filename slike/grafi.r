pdf("slike/grafi.pdf",paper="a4r")
#Graf za ZDRAVSTEVNO STAJNE PO SKUPNI STAROSTI

# pripravimo matriko iz ustreznih stolpcev, gledamo prvih 6. znakov == "SKupaj"
zdr <- as.matrix(ZdrStarost[substr(names(ZdrStarost), 1, 6) == "Skupaj"])
# v imenih stolpcev lahko pustimo samo leta
colnames(zdr) <- 2005:2013
# narišemo graf
barplot(zdr, beside = TRUE, 
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr), 
        xlim = c(0,70), ylim=c(0,50), main = "Zdravstveno stanje oseb po vseh starostih")

#zdr2013 <- as.matrix(ZdrStarost[substr(names(ZdrStarost), ,) == "2013"])

#Graf za zdravstveno stanje po vseh spolih

skupaj <- as.matrix(ZdrSpol[substr(names(ZdrSpol),1,2)=="S."])
colnames(skupaj)<-2005:2013
barplot(skupaj, beside=TRUE,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(skupaj), main = "Zdravstveno stanje obeh spolov skupaj",
        xlim = c(0,70),ylim=c(0,50))

Leto2013 <- as.matrix(ZdrSpol[substr(names(ZdrSpol),3,6)=="2013"])
colnames(Leto2013) <- c("Skupaj", "Moški", "Ženske")
barplot(Leto2013 , beside =TRUE, 
        legend.text = rownames(Leto2013), xlim=c(0,30),ylim=c(0,50),
        main = "Zdravstveno stanje oseb v letu 2013",
        col = c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"))

regijePovprecje <- as.matrix(ZadRegije[substr(names(ZadRegije),1,5)=="Povpr"])
colnames(regijePovprecje)<- c(2012:2013)
barplot(regijePovprecje, beside=TRUE,names.arg = rep(rownames(regijePovprecje),2),
        main = "Povprečna samoocena zadovoljstva z življenjem oseb glede na regije", 
        xlim=c(0,30),ylim=c(0,10))
dev.off()


