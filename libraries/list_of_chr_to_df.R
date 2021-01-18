#X<-go.gs_toy
list_of_chr_to_df<-function(X){
  # function that converts a list of character vectors to a data frame filled up with NA in blank spaces
  # X is one list of characters 
  #X <- go.gs_toy
  
  length_pathways <- lapply(X,length)
  max_length <- max( unlist( length_pathways ) )
  
  padding_char_vector_with_NAs <- function(W){ N_faltantes <- max_length-length( W )
  return(c( W,rep("NA",N_faltantes)))
  } # required function to pad the vector to the same length
  
  X_padded <- lapply( X, padding_char_vector_with_NAs )
  
  
  dd <- data.frame( matrix( nrow= length(X_padded), ncol= max_length ) )
  for(i in 1:length(X_padded) ){
    dd[i,] <- X_padded[[i]]
  }
  rownames(dd) <- names( X_padded )
  return(dd)
}


