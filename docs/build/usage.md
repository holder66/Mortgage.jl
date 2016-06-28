
#Mortgage.jl Documentation

<a id='Mortgage.mortgage-Tuple{}' href='#Mortgage.mortgage-Tuple{}'>#</a>
**`Mortgage.mortgage`** &mdash; *Method*.



```
mortgage()
```

Prints out a summary of calculated values for the mortgage, or prints a table of individual mortgage payments.

**Arguments**

  * `principal::Number`: the principal amount of the loan or mortgage, in any decimal-based currency. Default: principal=100000
  * `rate::Number`: annual interest rate, in percent, eg 3.26 . Default: rate=10.0
  * `amortization::Number`: the number of years over which the entire loan or mortgage would be paid off. Default is amortization=25
  * `frequency::String`: "m" = monthly (default); "w" = weekly; "t" = two weeks; "b" = bimonthly. Note that for bimonthly payments, they will occur on the first and the fifteenth of each month, and the mortgage should start on the first or fifteenth of the month.
  * `compounding::String`: s = none (simple interest; note that interest accrues daily but is not compounded); m - monthly (ie American) (this is the default); c = Canadian (ie semi-annual. Note that variable rate mortgages often compound monthly - check the fine print.)
  * `startdate::Date`: start date for the mortgage; default is today's date. Enter as: startdate=Date(2016,7,13)
  * `term::String`: specify the term in years; use 1/4 for 3 months and 1/2 for 6 months; enter a to indicate for the entire amortization interval (ie until paid off); default is 5 years. A term greater than the amortization will generate an error.
  * `output::String`: specify 'list' for a formatted listing, or a filename; if left blank, only a summary will be printed.
  * `payment::Number`: payment amount; if not specified, it will be calculated based on the amortization interval. Note that for simple interest mortgages, the payment will be calculated as for monthly compounded mortgages.
  * `help::String`: if "y", a help text will be printed.

