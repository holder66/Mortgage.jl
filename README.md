# Mortgage

[![Build Status](https://travis-ci.org/holder66/Mortgage.jl.svg?branch=master)](https://travis-ci.org/holder66/Mortgage.jl)

## About

Mortgage is a software package for loan and mortgage calculations, maintained by Henry Olders.
It is written in [julia](http://www.julialang.org).

- [https://github.com/thofma/Hecke.jl](https://github.com/thofma/Hecke.jl) (Source code)
- [http://hecke.readthedocs.org/en/latest/](http://hecke.readthedocs.org/en/latest/) (Online documentation)

So far, Mortgage provides the following features:

  - Works in any decimal-based currency
  - Generates a summary printout
  - Can generate a table of payments

## Installation

To use Mortgage, a julia version of 0.4 or higher is necessary (the latest stable julia version will do).
Please see [http://julialang.org/downloads](http://julialang.org/downloads/) for instructions on how to obtain julia for your system.
Once a suitable julia version is installed, use the following steps at the julia prompt to install Mortgage:

```julia
julia> Pkg.clone("https://github.com/holder66/Mortgage.jl")
julia> Pkg.build("Mortgage")
```

## Quick start

Here is a quick example of using Mortgage:

```julia
julia> using Mortgage
...

julia> mortgage()
```

## Documentation

The online documentation can be found here: [http://hecke.readthedocs.org/en/latest/]

The documentation of the single functions can also be accessed at the julia prompt. Here is an example:

```
help?> signature
search: signature

  ----------------------------------------------------------------------------

  signature(O::NfMaximalOrder) -> Tuple{Int, Int}

  |  Returns the signature of the ambient number field of \mathcal O.
```
