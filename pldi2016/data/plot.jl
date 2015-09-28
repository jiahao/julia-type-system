#Generate fig-scaling and fig-lang

using Color
using Gadfly

data = Dict()
data["R"] = readcsv("lu/R.csv")
data["R compiler"] = readcsv("lu/R-compiler.csv")
data["Julia"] = readcsv("lu/julia.csv")
data["Matlab"] = readcsv("lu/matlab.csv")
data["Matlab (no JIT)"] = readcsv("lu/matlab-nojit.csv")
data["Octave (JIT)"] = readcsv("lu/octave-nojit.csv")
data["Octave"] = readcsv("lu/octave-jit.csv")
data["Python"] = readcsv("lu/python.csv")

cm=distinguishable_colors(8, lchoices=[0:50])
langs = sort(collect(keys(data)))

#fig-scaling
layers = Any[]
for (i, k) in enumerate(langs)
    v = data[k]
    push!(layers, layer(x=v[:,1], y=v[:,7], Theme(default_color=cm[i]),
        Geom.line, Geom.point))
end

p = plot(layers..., Coord.Cartesian(xmin=1.0, xmax=3.5), Scale.x_log10,
    Scale.y_log10, Guide.manual_color_key("Language", langs, cm),
    Guide.xlabel("Matrix size"), Guide.ylabel("Execution time (s)"))

draw(PDF("fig-scaling.pdf", 6inch,4inch), p)

#fig-lang
#Plot execution time for constant N
fixedn = Float64[]
for k in langs
    @assert data[k][7,1] == 1000
    push!(fixedn, data[k][7,7]) #7th column is min time
end

#Manually insert line breaks in captions :(
shortlangs = ["Julia", "Matlab", "Matlab\n(no JIT)", "Octave", "Octave\n(JIT)",
        "Python", "R", "R\n(compiled)"]
p2 = plot(Geom.bar(position=:dodge), x=shortlangs, y=fixedn, color=langs,
    Scale.color_discrete_manual(cm...), Theme(key_position = :none),
    Guide.title("Textbook algorithm (matrix size N=1000)"),
    Guide.xlabel("Language"), Guide.ylabel("Execution time (s)"))

draw(PDF("fig-lang.pdf", 6inch,4inch), p2)

