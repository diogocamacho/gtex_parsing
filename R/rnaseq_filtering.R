#' Gene filtering
#' 
#' Filtering genes based on their count data across experimental set
#' 
#' @param data_matrix Count data
#' @param min_counts Minimal number of counts to consider (defaults to 5)
#' @param min_samples Minimal percentage of samples where gene needs to gave `min_counts` (defaults to 75%)
#' @return Indices of genes to keep
rnaseq_filtering <- function(data_matrix, min_counts, min_samples) {
  
  if(missing(min_counts)) min_counts <- 5
  if(missing(min_samples)) min_samples <- 0.75
  
  scount <- ceiling(ncol(data_matrix) * min_samples)
  
  xx <- apply(data_matrix, 1, function(y) length(which(y > min_counts)))
  
  gids <- which(xx >= scount)
  
  return(gids)
} 