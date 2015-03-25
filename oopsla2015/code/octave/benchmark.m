timings = [];
for n = [10, 20, 50, 100, 200, 500, 1000, 2000]
    A = randn(n);
    t = zeros(5,1);
    for i = 1:5
        tic;
        [lu, c, r] = lucompletepiv(A);
        t(i) = toc;
    end
    timings = [timings; [n t' min(t) mean(t) std(t)]];
end
dlmwrite('../../data/lu/octave.csv', timings, 'precision', 15)
