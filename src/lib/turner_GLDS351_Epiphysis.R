g351 <- paste0(DATA_PATH, "turner/GLDS-351.csv")
glds <- read.csv(g351, header = TRUE, stringsAsFactors = FALSE)
glds$expose <- ifelse(glds$Teatment == "Ground Control", 0, 1)
glds_epi <- glds[7:30, c(5:7, 11, 13, 16:19, 22:25)]

# Make component variables
mass <- pca(r = glds_epi[, c("DXA_BMC_mg", "DXA_BMD_mg_per_mmsq")], nfactors = 1, scores = TRUE)
trab_epiph <- pca(r = glds_epi[, c("epiphysis_canc_Tb_Sp_micrometer", "epiphysis_canc_Tb_N_1per_mm")], nfactors = 1, scores = TRUE)

glds_epi$mass <- as.vector(mass$scores)
glds_epi$trab_epiph <- as.vector(trab_epiph$scores)

# Standardize site-specific/single variable mass measures
names(glds_epi)[5] <- "mass_epiph"
glds_epi$mass_epiph <- scale(glds_epi$mass_epiph)

# Final dataset for epiphysis-related variables
glds_epi <- glds_epi[, c("expose", "mass", "mass_epiph", "trab_epiph")]
rm(list = c("mass", "trab_epiph"))

dsub_set <- glds_epi
title <- "Turner GLDS-351 (Epiphysis)"