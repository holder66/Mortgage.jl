# DocTests for mortgage()

Note that in all the tests, startdate is provided. If startdate were not supplied, the default of today's date would be used, causing doctests that were specified on a different date to fail. Thanks to the DateParser package, a variety of date formats can be used. See below for some examples.

```@meta
DocTestSetup = quote
    using Mortgage
end
```
## mortgage() as a standalone function
```julia
julia> mortgage(principal=54000, rate=2.125, amortization=20, frequency="w", compounding="c", startdate="2016-6-29", term="a")

(54000,2.125,20,"w","c",2016-06-29,"until paid off",63.50799378958494,2016-07-06,1044,54000.00000000001,12229.766528153477,66229.76652815354,0,54.43699940601391,2036-06-25,Any[1,2016-07-06,41.61279659644556,21.89519719313937,41.61279659644556,21.89519719313937,63.50799378958494,53958.38720340355,2,2016-07-13  …  66175.32952874753,54.41493596613927,1043,2036-06-25,63.485930349710294,0.022063439874642057,54009.070994383575,12229.766528153477,66238.83752253711,-9.070994383571026])
```

# DocTests for printsummary()

## Testing each parameter individually

### startdate
```julia
julia> printsummary(mortgage(startdate="2016/6/28")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 202), frequency="w")...)
1-06-28.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```

### principal
```julia
julia> printsummary(mortgage(startdate="28 june 2016", principal=4503.21)...)

Principal: 4503.21; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 40.92 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 40.92 on 2021-06-28.
At the end of the term, the balance remaining will be 4240.39. You will have paid a total of 2455.24
of which 2192.42, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```

### rate
```julia
julia> printsummary(mortgage(startdate="28-6-2016", rate=3.27)...)

Principal: 100000; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 488.37 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 488.37 on 2021-06-28.
At the end of the term, the balance remaining will be 85949.33. You will have paid a total of 29302.40
of which 15251.74, or 52.0%, will be interest. This represents 15.3% of the principal amount.
```

### amortization
```julia
julia> printsummary(mortgage(startdate="28th jun, 2016", amortization=6.25)...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 6.3 years.
Your first payment of 1798.49 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 1798.49 on 2021-06-28.
At the end of the term, the balance remaining will be 25260.76. You will have paid a total of 107909.66
of which 33170.42, or 30.7%, will be interest. This represents 33.2% of the principal amount.
```

### frequency
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28
Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: weekly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 208.98 will be on 2016-07-05.
During the term of 5 years, you will make 261 payments, with a final payment of 208.98 on 2021-06-29.
At the end of the term, the balance remaining will be 94182.61. You will have paid a total of 54542.66
of which 48725.27, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```

### compounding
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), compounding="c")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: Canadian, or semi-annual, compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 894.49 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 894.49 on 2021-06-28.
At the end of the term, the balance remaining will be 93991.87. You will have paid a total of 53669.23
of which 47661.11, or 88.8%, will be interest. This represents 47.7% of the principal amount.
```

### term
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), term="1/4")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-29.
During the term of 3 months, you will make 3 payments, with a final payment of 908.70 on 2016-09-28.
At the end of the term, the balance remaining will be 99772.01. You will have paid a total of 2726.10
of which 2498.11, or 91.6%, will be interest. This represents 2.5% of the principal amount.
```

### payment
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), payment=953.21)...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 953.21 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 953.21 on 2021-06-28.
At the end of the term, the balance remaining will be 90717.10. You will have paid a total of 57192.60
of which 47909.70, or 83.8%, will be interest. This represents 47.9% of the principal amount.
```
## possible values for frequency
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), frequency="w")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: weekly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 208.98 will be on 2016-07-05.
During the term of 5 years, you will make 261 payments, with a final payment of 208.98 on 2021-06-29.
At the end of the term, the balance remaining will be 94182.61. You will have paid a total of 54542.66
of which 48725.27, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), frequency="t")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: every 2 weeks
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 418.04 will be on 2016-07-12.
During the term of 5 years, you will make 130 payments, with a final payment of 418.04 on 2021-06-22.
At the end of the term, the balance remaining will be 94202.87. You will have paid a total of 54345.34
of which 48548.20, or 89.3%, will be interest. This represents 48.5% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), frequency="b")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: bimonthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 454.14 will be on 2016-07-01.
During the term of 5 years, you will make 120 payments, with a final payment of 454.14 on 2021-06-15.
At the end of the term, the balance remaining will be 94181.25. You will have paid a total of 54496.65
of which 48677.90, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```

## possible values for compounding
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), compounding="c")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: Canadian, or semi-annual, compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 894.49 will be on 2016-07-15.
During the term of 5 years, you will make 60 payments, with a final payment of 894.49 on 2021-06-15.
At the end of the term, the balance remaining will be 93991.87. You will have paid a total of 53669.23
of which 47661.11, or 88.8%, will be interest. This represents 47.7% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), compounding="s")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: simple interest (no compounding, but accrued daily)
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 1166.67 will be on 2016-07-15.
During the term of 5 years, you will make 60 payments, with a final payment of 1166.67 on 2021-06-15.
At the end of the term, the balance remaining will be 74189.47. You will have paid a total of 70000.00
of which 44189.47, or 63.1%, will be interest. This represents 44.2% of the principal amount.
```

## possible values for term
```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), term="1/4")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-15.
During the term of 3 months, you will make 3 payments, with a final payment of 908.70 on 2016-09-15.
At the end of the term, the balance remaining will be 99772.01. You will have paid a total of 2726.10
of which 2498.11, or 91.6%, will be interest. This represents 2.5% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), term="1/2")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-15.
During the term of 6 months, you will make 6 payments, with a final payment of 908.70 on 2016-12-15.
At the end of the term, the balance remaining will be 99538.27. You will have paid a total of 5452.20
of which 4990.47, or 91.5%, will be interest. This represents 5.0% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), term="1")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-15.
During the term of 1 year, you will make 12 payments, with a final payment of 908.70 on 2017-06-15.
At the end of the term, the balance remaining will be 99052.97. You will have paid a total of 10904.41
of which 9957.37, or 91.3%, will be interest. This represents 10.0% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), term="3")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-15.
During the term of 3 years, you will make 36 payments, with a final payment of 908.70 on 2019-06-15.
At the end of the term, the balance remaining will be 96851.01. You will have paid a total of 32713.23
of which 29564.24, or 90.4%, will be interest. This represents 29.6% of the principal amount.
```

```julia
julia> printsummary(mortgage(startdate=Date(2016,6,15), term="a")...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-15 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-15.
During the term of until paid off, you will make 300 payments, with a final payment of 908.70 on 2041-06-15.
At the end of the term, the balance remaining will be 0.00. You will have paid a total of 272610.22
of which 172610.22, or 63.3%, will be interest. This represents 172.6% of the principal amount.
```

# DocTests for printtable()

```julia
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
```
