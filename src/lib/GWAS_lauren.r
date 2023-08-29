path <- paste0(DATA_PATH, "new/NEW_GLDS-366_GWAS_processed_associations.csv")
ldset <- read.csv(path, header=T, stringsAsFactors=F)

si <- pca(ldset[,c("Bgd_Si.350.MeV.n_4", "Bgd_Si.350.MeV.n_8", "Bgd_Si.350.MeV.n_24", "Bgd_Si.350.MeV.n_48",
                    "FociPerGy_Si.350.MeV.n_4", "FociPerGy_Si.350.MeV.n_8", "FociPerGy_Si.350.MeV.n_24", "FociPerGy_Si.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
ar <- pca(ldset[,c("Bgd_Ar.350.MeV.n_4", "Bgd_Ar.350.MeV.n_8", "Bgd_Ar.350.MeV.n_24", "Bgd_Ar.350.MeV.n_48",
                    "FociPerGy_Ar.350.MeV.n_4", "FociPerGy_Ar.350.MeV.n_8", "FociPerGy_Ar.350.MeV.n_24", "FociPerGy_Ar.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
fe <- pca(ldset[,c("Bgd_Fe.600.MeV.n_4", "Bgd_Fe.600.MeV.n_8", "Bgd_Fe.600.MeV.n_24", "Bgd_Fe.600.MeV.n_48",
                    "FociPerGy_Fe.600.MeV.n_4", "FociPerGy_Fe.600.MeV.n_8", "FociPerGy_Fe.600.MeV.n_24", "FociPerGy_Fe.600.MeV.n_48")], nfactors = 1, scale. = TRUE)
xray <- pca(ldset[,c("Bgd_X.ray_4", "Bgd_X.ray_24", "Bgd_X.ray_48", "FociPerGy_X.ray_4", "FociPerGy_X.ray_24", "FociPerGy_X.ray_48")], nfactors = 1, scale. = TRUE)


ldset$si <- as.vector(si$scores)
ldset$ar <- as.vector(ar$scores)
ldset$fe <- as.vector(fe$scores)
ldset$xray <- as.vector(xray$scores)

subset <- ldset[, c("Autosomes.1_19", "Mitochondrial.M" ,"Sex.XY", "si", "ar", "fe", "xray")]
subset$Autosomes.1_19 <- as.numeric(subset$Autosomes.1_19)
subset$Mitochondrial.M <- as.numeric(subset$Mitochondrial.M)
subset$Sex.XY <- as.numeric(subset$Sex.XY)

dsub_set <- subset

title <- "Lauren"