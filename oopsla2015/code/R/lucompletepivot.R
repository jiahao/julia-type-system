lu_complete_pivoting <- function(A) {
  n <- nrow(A)
  rowpiv <- rep(0, n - 1)
  colpiv <- rep(0, n - 1)
  for (k in 1:(n - 1)) {
    ind <- which.max(A[k:n,k:n])
    i <- ((ind - 1) %% (n - k + 1)) + k
    j <- ((ind - 1) %/% (n - k + 1)) + k
    rowpiv[k] <- i
    A[c(i,k),1:n] <- A[c(k,i),1:n]
    colpiv[k] <- j
    A[1:n,c(j,k)] <- A[1:n,c(k,j)]
    if (A[k,k] != 0) {
      rho <- (k + 1):n
      A[rho,k] <- A[rho,k]/A[k,k]
      A[rho,rho] <- A[rho,rho] - A[rho,k,drop = FALSE]%*%A[k,rho,drop=FALSE]
    }
  }
  list(A, rowpiv, colpiv)
}