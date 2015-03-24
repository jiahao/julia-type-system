def lucompletepiv(A):
    assert np.size(A, 0) == np.size(A, 1)
    n = np.size(A, 1)
    rowpiv = np.zeros(n-1, dtype=int)
    colpiv = np.zeros(n-1, dtype=int)
    for k in range(n-1):
        Asub = A[k:n, k:n]
        mu, lam = np.unravel_index(np.argmax(Asub), np.shape(Asub)) 
        mu += k
        rowpiv[k] = mu
        A[[k, mu], :] = A[[mu, k], :]
        lam += k
        colpiv[k] = lam
        A[:, [k, lam]] = A[:, [lam, k]]
        if A[k, k] != 0:
            rho = slice(k+1, n)
            A[rho, k] = A[rho, k] / A[k, k]
            A[rho, rho] = A[rho, rho] - A[rho, k] * A[k, rho]
    return (A, rowpiv, colpiv)
