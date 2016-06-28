#!/Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Mortgage Calculator
# This calculator works in any decimal-based currency.

module Mortgage

export mortgage, printsummary, printtable

include("mortgageParameters.jl") # uses dictionaries to expand on input arguments
include("mortgageFunctions.jl")
include("mortgagePrintouts.jl")

"""
function mortgage

    (principal, rate, amortization, frequency, compounding, startdate, termString,paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate) = mortgage(principal, rate, amortization, frequency, compounding, startdate, term, payment)

Returns calculated values for mortgages or other loans.

# Arguments
* `principal::Number`: the principal amount of the loan or mortgage, in any decimal-based currency. Default: principal=100000
* `rate::Number`: annual interest rate, in percent, eg 3.26 . Default: rate=10.0
* `amortization::Number`: the number of years over which the entire loan or mortgage would be paid off. Default is amortization=25
* `frequency::String`: "m" = monthly (default); "w" = weekly; "t" = two weeks; "b" = bimonthly. Note that for bimonthly payments, they will occur on the first and the fifteenth of each month, and the mortgage should start on the first or fifteenth of the month.
* `compounding::String`: s = none (simple interest; note that interest accrues daily but is not compounded); m - monthly (ie American) (this is the default); c = Canadian (ie semi-annual. Note that variable rate mortgages often compound monthly - check the fine print.)
* `startdate::Date`: start date for the mortgage; default is today's date. Enter as: startdate=Date(2016,7,13)
* `term::String`: specify the term in years; use 1/4 for 3 months and 1/2 for 6 months; enter a to indicate for the entire amortization interval (ie until paid off); default is 5 years. A term greater than the amortization will generate an error.
* `payment::Number`: payment amount; if not specified, it will be calculated based on the amortization interval. Note that for simple interest mortgages, the payment will be calculated as for monthly compounded mortgages.
"""
function mortgage(; principal=100000, rate=10.0, amortization=25, frequency="m", compounding="m", startdate=today(), term="5", payment=nothing)
	# calculate length of the term in years
	termLength = termlength(term, amortization)
	termString = haskey(mortgageTermDescriptors, term) ? mortgageTermDescriptors[term][1] : "$(term) years"
	firstPaymentDate = nextpaymentdate(startdate, frequency, startdate)
	# how many payments will be made over the term of the mortgage
	numberOfPayments = numberofperiods(frequency, termLength, startdate)
	# payment size is either specified, or needs to be determined based on the amortization
	if payment == nothing
		paymentSize = paymentsizecalc(rate, principal, amortization, compounding, frequency, startdate)
	else
		paymentSize = payment
	end
	# @show termLength firstPaymentDate numberOfPayments paymentSize
	# @show rate
	accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table = dotablerows(principal, rate, frequency, compounding, startdate, firstPaymentDate, paymentSize, numberOfPayments)
	# @show paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate
	# @show table
	return principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table
end


function main()
	# printsummary(mortgage()...)
	printtable(mortgage(payment=1000, term="1/2")...)
end

main()

end # module
