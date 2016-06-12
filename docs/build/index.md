# Mortgage.jl

[![Build Status](https://travis-ci.org/holder66/Mortgage.jl.svg?branch=master)](https://travis-ci.org/holder66/Mortgage.jl)

## About

Mortgage is a software package for loan and mortgage calculations, maintained by Henry Olders.
It is written in [julia](http://www.julialang.org).

- [https://github.com/holder66/Mortgage.jl](https://github.com/holder66/Mortgage.jl) (Source code)

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

Here is a quick example of using Mortgage, with default values:

```julia
julia> using Mortgage

julia> mortgage()

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-12 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-12.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-12.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04 
of which 48685.81, or 89.3%, will be interest.This represents 48.7% of the principal amount.
```

## Documentation

<http://holder66.github.io/Mortgage.jl>