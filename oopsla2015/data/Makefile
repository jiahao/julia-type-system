JULIABIN = julia
PYTHONBIN = python3.4
MATLABBIN = /Applications/MATLAB_R2014b.app/bin/matlab

lu/matlab.csv:
	$(MATLABBIN) -nosplash -nodesktop -nojvm -r 'cd ../code/matlab; benchmark; exit'

lu/julia.csv:
	cd ../code/julia; $(JULIABIN) benchmark.jl

lu/r.csv:
	echo Run ../code/R/benchmark manually

lu/python.csv:
	cd ../code/python; $(PYTHONBIN) benchmark.py

