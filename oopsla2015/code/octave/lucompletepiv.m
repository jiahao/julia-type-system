function [A, rowpiv, colpiv] = lucompletepiv(A)
  n = size(A, 1);
  rowpiv = zeros(n-1,1);
  colpiv = zeros(n-1,1);
  for k=1:n-1
    Asub = abs(A(k:n, k:n));
    [mu, lambda] = find(Asub == max(Asub(:)));
    mu = mu + k-1; lambda = lambda + k-1;
    rowpiv(k) = mu;
    A([k,mu], 1:n) = A([mu,k], 1:n);
    colpiv(k) = lambda;
    A(1:n, [k,lambda]) = A(1:n, [lambda,k]);
    if A(k,k) ~= 0
      rho = k+1:n;
      A(rho, k) = A(rho, k)/A(k, k);
      A(rho, rho) = A(rho, rho) - A(rho, k) * A(k, rho);
    end
  end
end
