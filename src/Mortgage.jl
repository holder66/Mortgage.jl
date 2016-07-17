#!/Applications/Julia-0.4.6.app/Contents/Resources/julia/bin/julia
# Mortgage Calculator
# This calculator works in any decimal-based currency.

module Mortgage

export mortgage, mortgagecalc, printsummary, printtable

include("mortgageParameters.jl") # uses dictionaries to expand on input arguments
include("mortgageFunctions.jl")
include("mortgagePrintouts.jl")

using DateParser, DecFP

"""
    mortgage(<keyword arguments>)

    (principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table) = mortgage(principal, rate, amortization, frequency, compounding, startdate, term, payment)

Return calculated values for mortgages or other loans.

# Arguments
* `principal::Number`: the principal amount of the loan or mortgage, in any decimal-based currency. Default: principal=100000
* `rate::Number`: annual interest rate, in percent, eg 3.26 . Default: rate=10.0
* `amortization::Number`: the number of years over which the entire loan or mortgage would be paid off. Default is amortization=25
* `frequency::String`: "m" for monthly (default); "w" for weekly; "t" for two weeks; "b" for bimonthly. Note that for bimonthly payments, they will occur on the first and the fifteenth of each month, and the mortgage should start on the first or fifteenth of the month.
* `compounding::String`: "s" for none (simple interest; note that interest accrues daily but is not compounded); "m" for monthly (ie American) (this is the default); "c" for Canadian (ie semi-annual. Note that variable rate mortgages often compound monthly - check the fine print.)
* `startdate::String`: start date for the mortgage; default is today's date.
* `term::String`: specify the term in years; use "1/4" for 3 months and "1/2" for 6 months; enter "a" to indicate for the entire amortization interval (ie until paid off); default is 5 years. A term greater than the amortization will generate an error.
* `payment::Number`: payment amount; if not specified, it will be calculated based on the amortization interval. Note that for simple interest mortgages, the payment will be calculated as for monthly compounded mortgages.

# table
This value returned by mortgage() is a one-dimensional array with eight values for each payment. The values are: 
	paymentNumber, paymentDate, principalAmount, interestAmount, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance.
These values are used by printtable() to print out a listing with one line for each payment.

# Examples
```
julia> mortgage(principal=54000.00, rate=2.125, amortization=20, frequency="w", compounding="c", startdate="2016-6-29", term="a")

(+54000E+0,2.125,20,"w","c",2016-06-29,"until paid off",+6350799378958492E-14,2016-07-06,1044,+5400000000000002E-11,+1222976652815350E-11,+6622976652815349E-11,0,+5443699940613216E-14,2036-06-25,Any[1,2016-07-06,+4161279659644555E-14,+2189519719313937E-14,+4161279659644555E-14,+2189519719313937E-14,+6350799378958492E-14,+5395838720340355E-11,2,2016-07-13  …  +6617532952874735E-11,+5441493596625747E-14,1043,2036-06-25,+6348593034971023E-14,+2206343987468998E-17,+5400907099438347E-11,+1222976652815350E-11,+6623883752253694E-11,-907099438345276E-14])
```
```
julia> printsummary(mortgage(startdate=Date(2016,6,29))...)

Principal: 100000.00; Annual Interest Rate 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-29 and is amortized over (ie would be fully paid off in) 25.00 years.
Your first payment of 908.70 will be on 2016-07-30.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-29.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.
```
```
julia> printtable(mortgage(startdate=Date(2016,6,29), term="1/4")...)
                       Mortgage Schedule of Payments

Mortgage Principal: 100000.00 at 10.000% annual interest, amortized over 25.00 years,
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

# Usage
Commonly used with printsummary() or printtable(), which are part of this package.
"""
function mortgage(; principal::Number=100000, rate::Number=10.0, amortization::Number=25, frequency::ASCIIString="m", compounding::ASCIIString="m", startdate=today(), term::ASCIIString="5", payment=nothing)
	startdate = typeof(startdate) == Date ? startdate : get(tryparse(Date, startdate))
	principal = typeof(principal) == Dec64 ? principal : Dec64(principal)
	payment = typeof(payment) != Void ? Dec64(payment) : payment
	return mortgagecalc(principal, rate, amortization, frequency, compounding, startdate, term, payment)
end

function mortgagecalc(principal::Dec64, rate::Number, amortization::Number, frequency::ASCIIString, compounding::ASCIIString, startdate, term::ASCIIString, payment)
	# obtain the length of the term in years
	termLength = termlength(term, amortization)
	# string suitable for printing
	termString = haskey(mortgageTermDescriptors, term) ? mortgageTermDescriptors[term][1] : "$(term) years"
	firstPaymentDate = nextpaymentdate(startdate, frequency, startdate)
	# how many payments will be made over the term of the mortgage
	numberOfPayments = numberofperiods(frequency, termLength, startdate)
	if payment == nothing # if payment size was not specified, calculate it based on amortization and other parameters
		paymentSize = paymentsizecalc(rate, principal, amortization, compounding, frequency, startdate)
	else
		paymentSize = payment
	end
	accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table = dotablerows(principal, rate, frequency, compounding, startdate, firstPaymentDate, paymentSize, numberOfPayments)
	return principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table
end

function main()
	printsummary(mortgage()...)
	printtable(mortgage()...)
end

# uncomment the line below, to run this module from the command line. However, it is preferable 
# to use the mortgagecl.jl when one wants to use the command line.
# main()

end # module
