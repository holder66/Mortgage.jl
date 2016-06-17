#Mortgage.jl DocTests

```@meta
DocTestSetup = quote
    using Mortgage
end
```
## Getting help
```julia
julia> mortgage(help="y")

This mortgage and loan calculator will work in any decimal-based currency.
All the parameters are keyword parameters, and have default values; try it out: mortgage()
Example parameters: principal=250000, rate=4.25, amortization=30, term="5",
payment=3750, startdate=Date(2013,7,27)
The term can be specified as "1/4", for 3 months; "1/2", for 6 months;
"a", which makes the term the same as the amortization; or just enter the years.
Compounding takes the values "m", for monthly (American) compounding;
"c", for Canadian (biannual) compounding; or "s", for simple interest (no compounding).
Payment frequency takes values "m" for monthly;
"b" for bimonthly (twice a month, on the first and the fifteenth);
"w" for weekly; and "t" for every two weeks.
For bimonthly payments, please specify a starting date which is the first of the month.
Default starting date is today's date.
If amortization is specified, the payment amount will be calculated.
If you specify a payment amount, then the amortization will be calculated.
If you specify both, amortization will be ignored.
The default output is a summary. To obtain a tabular listing of each payment,
specify output="list". To write the listing to a text file, provide the file name, eg output="fileName.txt".
This calculator can also be run on the command line, eg julia mortgage.jl commandLineArguments
```
## Default values
```julia
julia> mortgage()

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-16 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-16.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-16.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```
## Testing each parameter individually
### principal
```julia
julia> mortgage(principal=381692)

Principal: 381692; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-16 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 3468.44 will be on 2016-07-16.
During the term of 5 years, you will make 60 payments, with a final payment of 3468.44 on 2021-06-16.
At the end of the term, the balance remaining will be 359415.57. You will have paid a total of 208106.28
of which 185829.85, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```
### rate
```julia
julia> mortgage(principal=381692, rate=3.27)

Principal: 381692; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-16 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 1864.08 will be on 2016-07-16.
During the term of 5 years, you will make 60 payments, with a final payment of 1864.08 on 2021-06-16.
At the end of the term, the balance remaining will be 328061.73. You will have paid a total of 111844.93
of which 58214.66, or 52.0%, will be interest. This represents 15.3% of the principal amount.
```
### payment
```julia
julia> mortgage(principal=381692, rate=3.27, payment=2150)

Principal: 381692; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-16 and is amortized over (ie would be fully paid off in) 20.1 years.
Your first payment of 2150.00 will be on 2016-07-16.
During the term of 5 years, you will make 60 payments, with a final payment of 2150.00 on 2021-06-16.
At the end of the term, the balance remaining will be 309452.05. You will have paid a total of 129000.00
of which 56760.05, or 44.0%, will be interest. This represents 14.9% of the principal amount.
```

```julia
julia> mortgage(principal=381692, rate=3.27, payment=2150.43)

Principal: 381692; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-16 and is amortized over (ie would be fully paid off in) 20.1 years.
Your first payment of 2150.43 will be on 2016-07-16.
During the term of 5 years, you will make 60 payments, with a final payment of 2150.43 on 2021-06-16.
At the end of the term, the balance remaining will be 309424.06. You will have paid a total of 129025.80
of which 56757.86, or 44.0%, will be interest. This represents 14.9% of the principal amount.
```

