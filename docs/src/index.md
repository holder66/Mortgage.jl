# Mortgage.jl

Mortgage is a software package for loan and mortgage calculations, maintained by Henry Olders.
It is written in [julia](http://www.julialang.org).


- [https://github.com/holder66/Mortgage.jl](https://github.com/holder66/Mortgage.jl) (Source code)

Mortgage provides the following features:

  - Works in any decimal-based currency
  - Supports monthly compounding (American); bi-annual (Canadian); or no compounding (simple interest, accrued daily)
  - Supports monthly, twice monthly, weekly, or two-week payment intervals
  - Terms can range from quarter, half-year, year, multiple years, or equal to the amortization period
  - Will calculate the payment amount, if none is supplied
  - function printsummary() generates a summary printout
  - function printtable() generates a table of payments

## Installation

To use Mortgage, a julia version of 0.4 or higher is necessary (the latest stable julia version will do).
Please see [http://julialang.org/downloads](http://julialang.org/downloads/) for instructions on how to obtain julia for your system.
Once a suitable julia version is installed, use the following steps at the julia prompt to install Mortgage:

	julia> Pkg.clone("https://github.com/holder66/Mortgage.jl")
	julia> Pkg.build("Mortgage")


## Quick start

Here are two  quick examples of using Mortgage, with default values:

	julia> printsummary(mortgage()...)
	
	Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
	Compounding: monthly (American) compounding
	Your mortgage starts on 2016-06-29 and is amortized over (ie would be fully paid off in) 25.0 years.
	Your first payment of 908.70 will be on 2016-07-30.
	During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-29.
	At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
	of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
	
	
	julia> printtable(mortgage(startdate=Date(2016,6,29), term="1/4")...)
	
	                       Mortgage Schedule of Payments
						   
	Mortgage Principal: 100000.00 at 10.00% annual interest, amortized over 25.0 years,
	using monthly (American) compounding, to be repaid with 3 payments of 908.70 each,
	for a term of 3 months. The mortgage start date is 2016-06-29.
		
	                                                   Accumulated   Accumulated   Accumulated
	Payment         Date    Principal     Interest       Principal      Interest         Total         Balance
	
	      1   2016-07-30        75.37       833.33           75.37        833.33        908.70        99924.63
	      2   2016-08-30        76.00       832.71          151.36       1666.04       1817.40        99848.64
	      3   2016-09-29        76.63       832.07          227.99       2498.11       2726.10        99772.01
		  
	At the end of the term, the outstanding balance will be 99772.01.
	The last payment of the term will be on 2016-09-29 in the amount of 908.70.
	Over the term, you will have paid a total of 2726.10 of which 2498.11, or 91.64%, is interest. This
	represents 2.50% of the principal amount.


## Documentation

Documentation is built automatically with help from *MkDocs* on *Travis CI* and hosted by *GitHub Pages*.

## Project Status

`Mortgage.jl` will eventually be tested against Julia `0.4` and *current* `0.5-dev` on Linux, OS X, and Windows.

## Contributing and Questions

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue][issues-url] if you encounter any problems or would just like to ask a question.



[issues-url]: https://github.com/holder66/Mortgage.jl/issues

