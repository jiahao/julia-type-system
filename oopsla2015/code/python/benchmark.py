import csv
import timeit
import numpy as np

exec(open("./lucompletepiv.py").read())

timings = []
for n in [10, 20, 50, 100, 200, 500, 1000, 2000, 5000]:
    A = np.random.randn(n,n)
    t = np.ones(5)
    for i in range(1,5):
        tic = time.time()
        lucompletepiv(A)
        t[i] = time.time() - tic # time in seconds
    timings.append((n, t[0], t[1], t[2], t[3], t[4], t.min(), t.mean(), t.std()))

with open("benchmark.csv", "w", newline="") as fh:
    benchwriter = csv.writer(fh)
    benchwriter.writerows(timings)
