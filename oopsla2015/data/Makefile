JULIABIN = julia
#PyPy does not work. Fail.
#PYPYBIN = pypy
PYTHONBIN = python3.4
MATLABBIN = /Applications/MATLAB_R2014b.app/bin/matlab
RBIN = R

all: lu/matlab-nojit.csv lu/matlab.csv lu/julia.csv lu/R.csv lu/python.csv

lu/matlab-nojit.csv:
	cd ../code/matlab; $(MATLABBIN) -singleCompThread -nosplash -nodesktop -nojvm -r 'feature accel off; benchmark; exit'

lu/matlab.csv:
	cd ../code/matlab; $(MATLABBIN) -singleCompThread -nosplash -nodesktop -nojvm -r 'benchmark; exit'

lu/julia.csv:
	cd ../code/julia; $(JULIABIN) benchmark.jl

lu/R.csv:
	cd ../code/R; $(RBIN) --vanilla --file=benchmark.R

lu/pypy.csv:
	cd ../code/python; $(PYPYBIN) benchmark.py

lu/python.csv:
	cd ../code/python; $(PYTHONBIN) benchmark.py

lu/python-numba.csv:
	cd ../code/python; $(PYTHONBIN) benchmark-numba.py

