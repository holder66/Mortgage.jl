
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

