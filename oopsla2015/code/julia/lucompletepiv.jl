function lucompletepiv!(A)
  n=size(A, 1)
  rowpiv=zeros(Int, n-1)
  colpiv=zeros(Int, n-1)
  for k=1:n-1
    As = abs(A[k:n, k:n])
    μ, λ = ind2sub(size(As), indmax(As))
    μ += k-1; λ += k-1
    rowpiv[k] = μ
    A[[k,μ], 1:n] = A[[μ,k], 1:n]
    colpiv[k] = λ
    A[1:n, [k,λ]] = A[1:n, [λ,k]]
    if A[k,k] ≠ 0
      ρ = k+1:n
      A[ρ, k] = A[ρ, k]/A[k, k]
      A[ρ, ρ] = A[ρ, ρ] - A[ρ, k] * A[k, ρ]
    end
  end
  return (A, rowpiv, colpiv)
end
