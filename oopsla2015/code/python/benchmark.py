import csv
import timeit
import numpy as np

execfile("./lucompletepiv.py")

timings = []
for n in [10, 20, 50, 100, 200, 500, 1000, 2000, 5000]:
    A = np.rand.randn(n,n)
    t = np.zeros(5)
    for i in range(1,5):
        t[i] = timeit.timeit(lucompletepiv(A))
    timings.append((n, t[0], t[1], t[2], t[3], t[4], t.min(), t.mean(), t.std()))


with open("benchmark.csv", "wb") as fh:
    benchwriter = csv.writer(fh)
    for t in timings:
        benchwriter.writerow(t)
