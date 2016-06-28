
#Mortgage.jl DocTests




<a id='Getting-help-1'></a>

## Getting help


```julia
julia> mortgage(help="y")

This mortgage and loan calculator will work in any decimal-based currency.
All the parameters are keyword parameters, and have default values; try it out: mortgage()
Example parameters: principal=250000, rate=4.25, amortization=30, term="5",
payment=3750, startdate=Date(2013,7,27), frequency="w", compounding="c"
The term can be specified as "1/4", for 3 months; "1/2", for 6 months;
"a", which makes the term the same as the amortization; or just enter the years.
compounding takes the values "m", for monthly (American) compounding;
"c", for Canadian (biannual) compounding; or "s", for simple interest (no compounding).
frequency takes values "m" for monthly;
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


<a id='Default-values-1'></a>

## Default values


```julia
julia> mortgage(startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-17.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='Testing-each-parameter-individually-1'></a>

## Testing each parameter individually


<a id='principal-1'></a>

### principal


```julia
julia> mortgage(principal=381692.21, startdate=Date(2016,6,17))

Principal: 381692.21; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 3468.44 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 3468.44 on 2021-06-17.
At the end of the term, the balance remaining will be 359415.77. You will have paid a total of 208106.40
of which 185829.96, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='rate-1'></a>

### rate


```julia
julia> mortgage(rate=3.27, startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 488.37 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 488.37 on 2021-06-17.
At the end of the term, the balance remaining will be 85949.33. You will have paid a total of 29302.40
of which 15251.74, or 52.0%, will be interest. This represents 15.3% of the principal amount.
```


<a id='amortization-1'></a>

### amortization


```julia
julia> mortgage(amortization=6.25, startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 6.3 years.
Your first payment of 1798.49 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 1798.49 on 2021-06-17.
At the end of the term, the balance remaining will be 25260.76. You will have paid a total of 107909.66
of which 33170.42, or 30.7%, will be interest. This represents 33.2% of the principal amount.
```


<a id='frequency-1'></a>

### frequency


```julia
julia> mortgage(frequency="w", startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: weekly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 208.98 will be on 2016-06-24.
During the term of 5 years, you will make 261 payments, with a final payment of 208.98 on 2021-06-18.
At the end of the term, the balance remaining will be 94182.61. You will have paid a total of 54542.66
of which 48725.27, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='compounding-1'></a>

### compounding


```julia
julia> mortgage(compounding="c", startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: Canadian, or semi-annual, compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 894.49 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 894.49 on 2021-06-17.
At the end of the term, the balance remaining will be 93991.87. You will have paid a total of 53669.23
of which 47661.11, or 88.8%, will be interest. This represents 47.7% of the principal amount.
```


<a id='startdate-1'></a>

### startdate


```julia
julia> mortgage(startdate=Date(2016,7,13))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-07-13 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-08-13.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-07-13.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='term-1'></a>

### term


```julia
julia> mortgage(term="1/2", startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-17.
During the term of 6 months, you will make 6 payments, with a final payment of 908.70 on 2016-12-17.
At the end of the term, the balance remaining will be 99538.27. You will have paid a total of 5452.20
of which 4990.47, or 91.5%, will be interest. This represents 5.0% of the principal amount.
```


<a id='output-1'></a>

### output


```julia
julia> mortgage(output="list", term="1/4", startdate=Date(2016,6,17))

                       Mortgage Schedule of Payments

Mortgage Principal: 100000.00 at 10.00% annual interest, amortized over 25.0 years,
using monthly (American) compounding, to be repaid with 3 payments of 908.70 each,
for a term of 3 months. The mortgage start date is 2016-06-17.

                                                   Accumulated   Accumulated   Accumulated
Payment         Date    Principal     Interest       Principal      Interest         Total         Balance

      1   2016-07-17        75.37       833.33           75.37        833.33        908.70        99924.63
      2   2016-08-17        76.00       832.71          151.36       1666.04       1817.40        99848.64
      3   2016-09-17        76.63       832.07          227.99       2498.11       2726.10        99772.01

At the end of the term, the outstanding balance will be 99772.01.
The last payment of the term will be on 2016-09-17 in the amount of 908.70.
Over the term, you will have paid a total of 2726.10 of which 2498.11, or 91.64%, is interest. This
represents 2.50% of the principal amount.
```


<a id='payment-1'></a>

### payment


```julia
julia> mortgage(payment=953.21, startdate=Date(2016,6,17))

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-17 and is amortized over (ie would be fully paid off in) 20.7 years.
Your first payment of 953.21 will be on 2016-07-17.
During the term of 5 years, you will make 60 payments, with a final payment of 953.21 on 2021-06-17.
At the end of the term, the balance remaining will be 90717.10. You will have paid a total of 57192.60
of which 47909.70, or 83.8%, will be interest. This represents 47.9% of the principal amount.
```


<a id='Boundary-conditions-1'></a>

## Boundary conditions


<a id='principal-2'></a>

### principal


<a id='zero-1'></a>

#### zero

