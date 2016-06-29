
<a id='DocTests-for-mortgage()-1'></a>

# DocTests for mortgage()


Note that in all the tests, startdate is provided. If startdate were not supplied, the default of today's date would be used, causing doctests that were specified on a different date to fail.




<a id='mortgage()-as-a-standalone-function-1'></a>

## mortgage() as a standalone function


<a id='DocTests-for-printsummary()-1'></a>

# DocTests for printsummary()


<a id='Testing-each-parameter-individually-1'></a>

## Testing each parameter individually


<a id='startdate-1'></a>

### startdate


```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28))...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 908.70 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-28.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='principal-1'></a>

### principal


```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), principal=4503.21)...)

Principal: 4503.21; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 40.92 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 40.92 on 2021-06-28.
At the end of the term, the balance remaining will be 4240.39. You will have paid a total of 2455.24
of which 2192.42, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```


<a id='rate-1'></a>

### rate


```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), rate=3.27)...)

Principal: 100000; Annual Interest Rate: 3.27%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 25.0 years.
Your first payment of 488.37 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 488.37 on 2021-06-28.
At the end of the term, the balance remaining will be 85949.33. You will have paid a total of 29302.40
of which 15251.74, or 52.0%, will be interest. This represents 15.3% of the principal amount.
```


<a id='amortization-1'></a>

### amortization


```julia
julia> printsummary(mortgage(startdate=Date(2016,6,28), amortization=6.25)...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-28 and is amortized over (ie would be fully paid off in) 6.3 years.
Your first payment of 1798.49 will be on 2016-07-29.
During the term of 5 years, you will make 60 payments, with a final payment of 1798.49 on 2021-06-28.
At the end of the term, the balance remaining will be 25260.76. You will have paid a total of 107909.66
of which 33170.42, or 30.7%, will be interest. This represents 33.2% of the principal amount.
```


<a id='frequency-1'></a>

### frequency


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


<a id='compounding-1'></a>

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


<a id='term-1'></a>

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


<a id='payment-1'></a>

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


<a id='possible-values-for-frequency-1'></a>

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


<a id='possible-values-for-compounding-1'></a>

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


<a id='possible-values-for-term-1'></a>

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

