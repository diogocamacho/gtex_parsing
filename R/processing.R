#' parse gtex data (v7)

#' count data
count_data <- readr::read_delim("~/work/data/gtex_rnaseq/gtex_v7_count_data.gct", 
                                delim = "\t", 
                                col_names = FALSE)

# genes
genes <- readr::read_delim(file = "~/work/data/gtex_rnaseq/gtex_v7_genes.txt", 
                           delim = "\t")

# samples
samples <- readr::read_delim(file = "~/work/data/gtex_rnaseq/gtex_v7_sample_ids.txt", 
                             delim = "\t", 
                             col_names = FALSE)

# subject phenotype descriptions
subject_annotations <- readr::read_delim(file = "~/work/data/gtex_rnaseq/GTEx_v7_Annotations_SubjectPhenotypesDS.txt", 
                                         delim = "\t")

# sample mappings
sample_annotations <- readr::read_delim(file = "~/work/data/gtex_rnaseq/GTEx_v7_Annotations_SampleAttributesDS.txt", 
                                        delim = "\t")


# add additional data to samples
samples <- samples %>%
  dplyr::select(., -type) %>%
  dplyr::mutate(., subject_id = sapply(X1, function(y) paste0(strsplit(y, "-")[[1]][c(1,2)], collapse = "-"))) %>%
  dplyr::select(., -X1) %>%
  dplyr::mutate(., gender = sapply(subject_id, function(y) subject_annotations$SEX[subject_annotations$SUBJID == y])) %>%
  dplyr::mutate(., age = sapply(subject_id, function(y) subject_annotations$AGE[subject_annotations$SUBJID == y])) %>%
  dplyr::mutate(., cause_death = sapply(subject_id, function(y) subject_annotations$DTHHRDY[subject_annotations$SUBJID == y])) %>% 
  dplyr::mutate(., gender = replace(gender, list = which(gender == 1), "male")) %>%
  dplyr::mutate(., gender = replace(gender, list = which(gender == 2), "female")) %>%
  dplyr::mutate(., cause_death = replace(cause_death, list = which(cause_death == 0), "ventilator")) %>%
  dplyr::mutate(., cause_death = replace(cause_death, list = which(cause_death == 1), "violent")) %>%
  dplyr::mutate(., cause_death = replace(cause_death, list = which(cause_death == 2), "natural")) %>%
  dplyr::mutate(., cause_death = replace(cause_death, list = which(cause_death == 3), "intermediate")) %>%
  dplyr::mutate(., cause_death = replace(cause_death, list = which(cause_death == 4), "slow"))
