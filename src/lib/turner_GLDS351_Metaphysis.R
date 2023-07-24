g351 <- paste0(DATA_PATH, "turner/GLDS-351.csv")
glds <- read.csv(g351, header = TRUE, stringsAsFactors = FALSE)
glds$expose <- ifelse(glds$Teatment == "Ground Control", 0, 1)
glds_meta <- glds[7:30, c(5:7, 11, 13, 16:19, 22:25)]

# Make component variables
mass <- pca(r = glds_meta[, c("DXA_BMC_mg", "DXA_BMD_mg_per_mmsq")], nfactors = 1, scores = TRUE)
trab_meta <- pca(r = glds_meta[, c("metaphysis_canc_Tb_Sp_micrometer", "metaphysis_canc_Tb_N_1per_mm")], nfactors = 1, scores = TRUE)

glds_meta$mass <- as.vector(mass$scores)
glds_meta$trab_meta <- as.vector(trab_meta$scores)

# Standardize site-specific/single variable mass measures
names(glds_meta)[5] <- "mass_meta"
glds_meta$mass_meta <- scale(glds_meta$mass_meta)

# Final dataset for metaphysis-related variables
glds_meta <- glds_meta[, c("expose", "mass", "mass_meta", "trab_meta")]
rm(list = c("mass", "trab_meta"))

dsub_set <- glds_meta
title <- "Turner GLDS-351 (Metaphysis)"