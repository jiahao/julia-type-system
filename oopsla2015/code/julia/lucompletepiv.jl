x ↔ y = for i=1:length(x) #Define swap function
  x[i], y[i] = y[i], x[i]
end
function lucompletepiv!(A)
  n=size(A, 1)
  rowpiv=zeros(Int, n-1)
  colpiv=zeros(Int, n-1)
  for k=1:n-1
    μ, λ = ind2sub(size(A[k:n, k:n]), indmax(A[k:n, k:n]))
    μ += k-1; λ += k-1
    rowpiv[k] = μ
    A[k, 1:n] ↔ A[μ, 1:n]
    colpiv[k] = λ
    A[1:n, k] ↔ A[1:n, λ]
    if A[k,k] ≠ 0
      ρ = k+1:n
      A[ρ, k] = A[ρ, k]/A[k, k]
      A[ρ, ρ] = A[ρ, ρ] - A[ρ, k] * A[k, ρ]
    end
  end
  return (A, rowpiv, colpiv)
end

