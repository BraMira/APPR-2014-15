pdf("slike/grafi.pdf",paper="a4r")
#Graf za ZDRAVSTEVNO STAJNE PO SKUPNI STAROSTI


zdr <- as.matrix(ZdrStarost[substr(names(ZdrStarost), 1, 6) == "Skupaj"])
colnames(zdr) <- 2005:2013
barplot(zdr, beside = TRUE, 
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr), 
        xlim = c(0,70), ylim=c(0,50), main = "Zdravstveno stanje oseb po vseh starostih")

VseStarosti <- c("Skupaj", "16-25","26-35","36-45","46-55","56-65","66+")


zdr2013 <- as.matrix(ZdrStarost[grep("2013$", names(ZdrStarost))])
colnames(zdr2013) <- VseStarosti
barplot(zdr2013, beside = TRUE,
        col =c("lightskyblue1","antiquewhite1","lavenderblush3","lavenderblush","lightpink3"),
        legend.text = rownames(zdr2013), 
        xlim = c(0,60), ylim=c(0,60), main = "Zdravstveno stanje oseb po starostih v letu 2013")

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


dev.off()


