using Documenter, Mortgage
 
makedocs(
	doctest = true,
	clean = true,
)

deploydocs(
    deps  = Deps.pip("mkdocs", "python-markdown-math"),
    repo  = "github.com/holder66/Mortgage.jl.git",
    julia = "release",
)
