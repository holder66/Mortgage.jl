# Mortgage.jl

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

	julia> Pkg.clone("https://github.com/holder66/Mortgage.jl")
	julia> Pkg.build("Mortgage")


## Quick start

Here is a quick example of using Mortgage, with default values:

	julia> using Mortgage

	julia> mortgage()

	Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
	Compounding: monthly (American) compounding
	Your mortgage starts on 2016-06-12 and is amortized over (ie would be fully paid off in) 25.0 years.
	Your first payment of 908.70 will be on 2016-07-12.
	During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-12.
	At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04 
	of which 48685.81, or 89.3%, will be interest.This represents 48.7% of the principal amount.

## Documentation

Documentation is built automatically with help from *MkDocs* on *Travis CI* and hosted by *GitHub Pages*.

[![][docs-latest-img]][docs-latest-url] [![][docs-stable-img]][docs-stable-url]

## Project Status

`Mortgage.jl` will eventually be tested against Julia `0.4` and *current* `0.5-dev` on Linux, OS X, and Windows.

[![][travis-img]][travis-url] [![][appveyor-img]][appveyor-url] [![][codecov-img]][codecov-url]

## Contributing and Questions

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue][issues-url] if you encounter any problems or would just like to ask a question.


[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://holder66.github.io/Mortgage.jl.

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://holder66.github.io/Mortgage.jl

[travis-img]: https://travis-ci.org/holder66/Mortgage.jl.svg?branch=master
[travis-url]: https://travis-ci.org/holder66/Mortgage.jl

[appveyor-img]: https://ci.appveyor.com/api/projects/status/h227adt6ovd1u3sx/branch/master?svg=true
[appveyor-url]: https://ci.appveyor.com/project/holder66/Mortgage-jl/branch/master

[codecov-img]: https://codecov.io/gh/holder66/Mortgage.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/holder66/Mortgage.jl

[issues-url]: https://github.com/holder66/Mortgage.jl/issues

