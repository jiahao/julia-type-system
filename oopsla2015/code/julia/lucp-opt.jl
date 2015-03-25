function swaprows!(A, i1, i2)
    @inbounds @simd for k = 1:size(A, 2)
        tmp = A[i1,k]
        A[i1,k] = A[i2,k]
        A[i2,k] = tmp
    end
end

function swapcols!(A, j1, j2)
    @inbounds @simd for k = 1:size(A, 1)
        tmp = A[k,j1]
        A[k,j1] = A[k,j2]
        A[k,j2] = tmp
    end
end

function idxmaxabs1(A, r, s)
    μ = λ = r[1]; themax = abs(A[r[1], r[1]])
    for j in s, i in r
        Aij = abs(A[i,j])
        if Aij > themax
            μ, λ, themax = i, j, Aij
        end
    end
    return μ, λ
end

function idxmaxabs2(A, r, s)
    μ = λ = r[1]; themax = abs(A[r[1], r[1]])
    @inbounds begin
        for j in s
            for i in r
                Aij = abs(A[i,j])
                if Aij > themax
                    μ, λ, themax = i, j, Aij
                end
            end
        end
    end
    return μ, λ
end

function lucompletepiv1!(A)
    n = size(A, 1)
    rowpiv = zeros(Int, n - 1)
    colpiv = zeros(Int, n - 1)
    for k = 1:n - 1
        μ, λ = idxmaxabs1(A, k:n, k:n)
        rowpiv[k] = μ
        A[[k,μ], 1:n] = A[[μ,k], 1:n]
        colpiv[k] = λ
        A[1:n, [k,λ]] = A[1:n, [λ,k]]
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

function lucompletepiv2!(A)
    n = size(A, 1)
    rowpiv = zeros(Int, n - 1)
    colpiv = zeros(Int, n - 1)
    @inbounds begin
        for k = 1:n - 1
            μ, λ = idxmaxabs2(A, k:n, k:n)
            rowpiv[k] = μ
            swaprows!(A, k, μ)
            colpiv[k] = λ
            swapcols!(A, k, λ)
            if A[k,k] ≠ 0
                ρ = k + 1:n
                scale!(1/A[k,k], sub(A, ρ, k))
                for j in ρ
                    Akj = A[k, j]
                    @simd for i in ρ
                        A[i, j] -= A[i, k] * Akj
                    end
                end
            end
        end
    end
    return (A, rowpiv, colpiv)
end

function lucompletepiv3!(A)
    n = size(A, 1)
    lda = stride(A, 2)
    rowpiv = zeros(Int, n - 1)
    colpiv = zeros(Int, n - 1)
    @inbounds begin
        for k = 1:n - 1
            offsetk = (k - 1)*lda
            μ, λ = idxmaxabs2(A, k:n, k:n)
            rowpiv[k] = μ
            swaprows!(A, k, μ)
            colpiv[k] = λ
            swapcols!(A, k, λ)
            if A[k,k] ≠ 0
                ρ = k + 1:n
                scale!(1/A[k + offsetk], sub(A, ρ, k))
                for j in ρ
                    offsetj = (j - 1)*lda
                    Akj = A[k + offsetj]
                    @simd for i in ρ
                        A[i + offsetj] -= A[i + offsetk] * Akj
                    end
                end
            end
        end
    end
    return (A, rowpiv, colpiv)
end
