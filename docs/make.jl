using Documenter, Mortgage
 
makedocs(modules=[Mortgage],
        doctest=true)
 
deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo = "github.com/holder66/Mortgage.jl.git",
    julia  = "0.4.5",
    osname = "macos")