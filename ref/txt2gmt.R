# convert this silly mapman file into a gmt

ath <- read.table("Ath_AGI_LOCUS_TAIR10_Aug2012.txt",
  fill=TRUE, header=TRUE, sep="\t" )

ath <- subset(ath, TYPE == "T")

ath <- ath[,2:3]

ath$IDENTIFIER <- toupper(ath$IDENTIFIER)

athl <- lapply(unique(ath$NAME), function(x) {
  ath[which(ath$NAME==x),2]  
})

names(athl) <- unique(ath$NAME)

athl <- athl[which(unname(lapply(athl,length) >= 5))]

writeGMT <- function (object, fname ){
  if (class(object) != "list") stop("object should be of class 'list'")
  if(file.exists(fname)) unlink(fname)
  for (iElement in 1:length(object)){
    write.table(t(c(make.names(rep(names(object)[iElement],2)),object[[iElement]])),
                sep="\t",quote=FALSE,
                file=fname,append=TRUE,col.names=FALSE,row.names=FALSE)
  }
}

writeGMT(object=athl,fname="Ath_AGI_LOCUS_TAIR10_Aug2012.txt.gmt")
