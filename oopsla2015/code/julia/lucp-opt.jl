x ↔ y = for i = 1:length(x) #Define swap function
    x[i], y[i] = y[i], x[i]
end

function idxmaxabs(A, r, s)
    μ = λ = r[1]; themax = abs(A[r[1], r[1]])
    for j in s, i in r
        Aij = A[i,j]
        if abs(Aij) > themax
            μ, λ, themax = i, j, Aij
        end
    end
    return μ, λ
end

function lucompletepiv!(A)
    n = size(A, 1)
    rowpiv = zeros(Int, n - 1)
    colpiv = zeros(Int, n - 1)
    for k = 1:n - 1
        μ, λ = idxmaxabs(A, k:n, k:n)
        rowpiv[k] = μ
        A[k, 1:n] ↔ A[μ, 1:n]
        colpiv[k] = λ
        A[1:n, k] ↔ A[1:n, λ]
        if A[k,k] ≠ 0
            ρ = k + 1:n
            scale!(1/A[k,k], sub(A, ρ, k))
            for j in ρ
                Akj = A[k, j]
                for i in ρ
                    A[i, j] -= A[i, k] * Akj
                end
            end
        end
    end
    return (A, rowpiv, colpiv)
end
