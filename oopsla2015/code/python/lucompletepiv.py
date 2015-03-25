def lucompletepiv(A):
    assert np.size(A, 0) == np.size(A, 1)
    n = np.size(A, 1)
    rowpiv = np.zeros(n-1, dtype=int)
    colpiv = np.zeros(n-1, dtype=int)
    for k in range(n-1):
        Asub = A[k:n, k:n]
        mu, lam = np.unravel_index(np.argmax(Asub), np.shape(Asub))
        mu, lam = mu + k, lam + k
        rowpiv[k] = mu
        A[[k, mu], :n] = A[[mu, k], :n]
        colpiv[k] = lam
        A[:n, [k, lam]] = A[:n, [lam, k]]
        if A[k, k] != 0:
            rho = slice(k+1, n)
            A[rho, k] /= A[k, k]
            A[rho, rho] -= np.dot(np.reshape(A[rho, k], (n - (k + 1), 1)),
                                  np.reshape(A[k, rho], (1, n - (k + 1))))
    return (A, rowpiv, colpiv)
