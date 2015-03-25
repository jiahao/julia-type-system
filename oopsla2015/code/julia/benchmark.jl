include("lucompletepiv.jl")
timings = zeros(0, 9);
for n = [10, 20, 50, 100, 200, 500, 1000, 2000, 5000]
    A = randn(n, n);
    t = zeros(5);
    for i = 1:5
        t[i] = @elapsed lucompletepiv!(A);
    end
    timings = [timings, [n, t..., minimum(t), mean(t), std(t)]']
    println(timings)
end
writecsv("../../data/lu/julia.csv", timings)
