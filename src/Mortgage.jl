#!/Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Mortgage Calculator
# This calculator works in any decimal-based currency.

module Mortgage

export mortgage, printsummary, printtable

include("mortgageParameters.jl") # uses dictionaries to expand on input arguments
include("mortgageFunctions.jl")
include("mortgagePrintouts.jl")

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
* `startdate::Date`: start date for the mortgage; default is today's date. Enter as: startdate=Date(2016,7,13)
* `term::String`: specify the term in years; use "1/4" for 3 months and "1/2" for 6 months; enter "a" to indicate for the entire amortization interval (ie until paid off); default is 5 years. A term greater than the amortization will generate an error.
* `payment::Number`: payment amount; if not specified, it will be calculated based on the amortization interval. Note that for simple interest mortgages, the payment will be calculated as for monthly compounded mortgages.

# table
This value returned by mortgage() is a one-dimensional array with eight values for each payment. The values are: 
	paymentNumber, paymentDate, principalAmount, interestAmount, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance.
These values are used by printtable() to print out a listing with one line for each payment.

# Example
```julia
julia> mortgage(principal=54000, rate=2.125, amortization=20, frequency="w", compounding="c", startdate=Date(2016,6,29), term="a") 

(54000,2.125,20,"w","c",2016-06-29,"until paid off",63.50799378958494,2016-07-06,1044,54000.00000000001,12229.766528153477,66229.76652815354,0,54.43699940601391,2036-06-25,Any[1,2016-07-06,41.61279659644556,21.89519719313937,41.61279659644556,21.89519719313937,63.50799378958494,53958.38720340355,2,2016-07-13  …  66175.32952874753,54.41493596613927,1043,2036-06-25,63.485930349710294,0.022063439874642057,54009.070994383575,12229.766528153477,66238.83752253711,-9.0709
```
# Usage
Commonly used with printsummary() or printtable(), which are part of this package.
"""
function mortgage(; principal=100000, rate=10.0, amortization=25, frequency="m", compounding="m", startdate=today(), term="5", payment=nothing)
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

# main()

end # module
