pdf("slike/grafi.pdf",paper="a4r")
#Graf za ZDRAVSTEVNO STAJNE PO SKUPNI STAROSTI

# pripravimo matriko iz ustreznih stolpcev, gledamo prvih 6. znakov == "SKupaj"
zdr <- as.matrix(ZdrStarost[substr(names(ZdrStarost), 1, 6) == "Skupaj"])
# v imenih stolpcev lahko pustimo samo leta
colnames(zdr) <- 2005:2013
# narišemo graf
barplot(zdr, beside = TRUE, 
        col =c("aliceblue","antiquewhite1","lavenderblush3","lavenderblush","darkseagreen1"),
        legend.text = rownames(zdr), 
        xlim = c(0,70), ylim=c(0,50))

#Graf za zdravstveno stanje po vseh spolih

skupaj <- as.matrix(ZdrSpol[substr(names(ZdrSpol),1,2)=="S."])
colnames(skupaj)<-2005:2013
barplot(skupaj, beside=TRUE,
        col =c("lightblue", "mistyrose","lightcyan", "lavender","snow3"),
        legend.text = rownames(skupaj),
        xlim = c(0,70),ylim=c(0,50))

dev.off()


