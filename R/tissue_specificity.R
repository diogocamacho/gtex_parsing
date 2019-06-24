#' Tissue specificity
#' 
#' Calculating tissue specificity using Stouffer's method
#' 
#' @param data_matrix Count data
#' @return Tissue specificity matrix
tissue_specificity <- function(data_matrix) {
  
  z1 <- scale(data_matrix)
  z2 <- t(scale(t(data_matrix)))
  
  Z <- (z1 + z2) / sqrt(2)
  
  return(Z)
} 