path <- paste0(DATA_PATH, "new/GLDS-366_GWAS_processed_associations.csv")
ldset <- read.csv(path, header=T, stringsAsFactors=F, na.strings=c("NA"))


subset <- ldset[rowSums(is.na(ldset[, 3:ncol(ldset)])) < ncol(ldset) - 2, ] # Grab Non-NA data
subset <- subset[, -2]                                                      # Remove 2nd col only
subset <- subset[, -c(34:ncol(subset))]                                     # Omit repeated data entry columns
subset$chromosome[subset$chromosome == "X"] <- 20                           # Replace "X" with 20 in the 'chromosome' column


# Omit Xrays since PCA is not applicable due to incomplete dataset
subset <- subset[, !names(subset) %in% c(
    "Bgd_X.ray_4", "Bgd_X.ray_8", "Bgd_X.ray_24", "Bgd_X.ray_48",
    "FociPerGy_X.ray_4", "FociPerGy_X.ray_8", "FociPerGy_X.ray_24", "FociPerGy_X.ray_48"
    )
]


# background_energy <- list(
#     c("Bgd_Si.350.MeV.n_4", "Bgd_Si.350.MeV.n_8", "Bgd_Si.350.MeV.n_24", "Bgd_Si.350.MeV.n_48"),
#     c("Bgd_Ar.350.MeV.n_4", "Bgd_Ar.350.MeV.n_8", "Bgd_Ar.350.MeV.n_24", "Bgd_Ar.350.MeV.n_48"),
#     c("Bgd_Fe.600.MeV.n_4", "Bgd_Fe.600.MeV.n_8", "Bgd_Fe.600.MeV.n_24", "Bgd_Fe.600.MeV.n_48")
#     # c("Bgd_X.ray_4", "Bgd_X.ray_8", "Bgd_X.ray_24", "Bgd_X.ray_48")
# )

# exp_foci_per_gray <- list(
#     c("FociPerGy_Si.350.MeV.n_4", "FociPerGy_Si.350.MeV.n_8", "FociPerGy_Si.350.MeV.n_24", "FociPerGy_Si.350.MeV.n_48"),
#     c("FociPerGy_Ar.350.MeV.n_4", "FociPerGy_Ar.350.MeV.n_8", "FociPerGy_Ar.350.MeV.n_24", "FociPerGy_Ar.350.MeV.n_48"),
#     c("FociPerGy_Fe.600.MeV.n_4", "FociPerGy_Fe.600.MeV.n_8", "FociPerGy_Fe.600.MeV.n_24", "FociPerGy_Fe.600.MeV.n_48")
#     # c("FociPerGy_X.ray_4", "FociPerGy_X.ray_8", "FociPerGy_X.ray_24", "FociPerGy_X.ray_48")
# )

# names <- list("si", "ar", "fe", "xray")
# pca_list <- list()


# for (i in seq_along(background_energy)) {
#     bdg_names <- background_energy[[i]]
#     exp_names <- exp_foci_per_gray[[i]]

#     bdg_res <- pca(subset[,bdg_names], nfactors = 1, scale. = TRUE)
#     exp_res <- pca(subset[,exp_names], nfactors = 1, scale. = TRUE)

#     bdg_col <- paste0(names[[i]],"_bdg")
#     exp_col <- paste0(names[[i]],"_exp")

#     pca_list[[bdg_col]] <- bdg_res
#     pca_list[[exp_col]] <- exp_res
# }


# si_bdg <- pca(subset[,c("Bgd_Si.350.MeV.n_4", "Bgd_Si.350.MeV.n_8", "Bgd_Si.350.MeV.n_24", "Bgd_Si.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
# ar_bdg <- pca(subset[,c("Bgd_Ar.350.MeV.n_4", "Bgd_Ar.350.MeV.n_8", "Bgd_Ar.350.MeV.n_24", "Bgd_Ar.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
# fe_bdg <- pca(subset[,c("Bgd_Fe.600.MeV.n_4", "Bgd_Fe.600.MeV.n_8", "Bgd_Fe.600.MeV.n_24", "Bgd_Fe.600.MeV.n_48")], nfactors = 1, scale. = TRUE)

# si_exp <- pca(subset[,c("FociPerGy_Si.350.MeV.n_4", "FociPerGy_Si.350.MeV.n_8", "FociPerGy_Si.350.MeV.n_24", "FociPerGy_Si.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
# ar_exp <- pca(subset[,c("FociPerGy_Ar.350.MeV.n_4", "FociPerGy_Ar.350.MeV.n_8", "FociPerGy_Ar.350.MeV.n_24", "FociPerGy_Ar.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
# fe_exp <- pca(subset[,c("FociPerGy_Fe.600.MeV.n_4", "FociPerGy_Fe.600.MeV.n_8", "FociPerGy_Fe.600.MeV.n_24", "FociPerGy_Fe.600.MeV.n_48")], nfactors = 1, scale. = TRUE)

# subset$si_bdg <- as.vector(si_bdg$scores[,1])
# subset$ar_bdg <- as.vector(ar_bdg$scores[,1])
# subset$fe_bdg <- as.vector(fe_bdg$scores[,1])
# subset$si_exp <- as.vector(si_exp$scores[,1])
# subset$ar_exp <- as.vector(ar_exp$scores[,1])
# subset$fe_exp <- as.vector(fe_exp$scores[,1])


# subset <- subset[, c("si_bdg", "ar_bdg", "fe_bdg", "si_exp", "ar_exp", "fe_exp")]


si <- pca(subset[,c("Bgd_Si.350.MeV.n_4", "Bgd_Si.350.MeV.n_8", "Bgd_Si.350.MeV.n_24", "Bgd_Si.350.MeV.n_48",
                    "FociPerGy_Si.350.MeV.n_4", "FociPerGy_Si.350.MeV.n_8", "FociPerGy_Si.350.MeV.n_24", "FociPerGy_Si.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
ar <- pca(subset[,c("Bgd_Ar.350.MeV.n_4", "Bgd_Ar.350.MeV.n_8", "Bgd_Ar.350.MeV.n_24", "Bgd_Ar.350.MeV.n_48",
                    "FociPerGy_Ar.350.MeV.n_4", "FociPerGy_Ar.350.MeV.n_8", "FociPerGy_Ar.350.MeV.n_24", "FociPerGy_Ar.350.MeV.n_48")], nfactors = 1, scale. = TRUE)
fe <- pca(subset[,c("Bgd_Fe.600.MeV.n_4", "Bgd_Fe.600.MeV.n_8", "Bgd_Fe.600.MeV.n_24", "Bgd_Fe.600.MeV.n_48",
                    "FociPerGy_Fe.600.MeV.n_4", "FociPerGy_Fe.600.MeV.n_8", "FociPerGy_Fe.600.MeV.n_24", "FociPerGy_Fe.600.MeV.n_48")], nfactors = 1, scale. = TRUE)

subset$si <- as.vector(si$scores[,1])
subset$ar <- as.vector(ar$scores[,1])
subset$fe <- as.vector(fe$scores[,1])

subset <- subset[, c("si", "ar", "fe")]

dsub_set <- subset
title <- "Lauren"