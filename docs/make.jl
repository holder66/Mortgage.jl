using Documenter, Mortgage
 
makedocs(
	doctest = true,
	clean = false,
)

deploydocs(
    deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo   = "github.com/holder66/Mortgage.jl.git",
)