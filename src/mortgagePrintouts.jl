# __precompile__()

"""
    printsummary()

    printsummary(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)

Print out a seven-line summary of the given and calculated mortgage parameters, eg:

julia> printsummary(mortgage(startdate=Date(2016,6,29))...)

Principal: 100000.00; Annual Interest Rate 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-29 and is amortized over (ie would be fully paid off in) 25.00 years.
Your first payment of 908.70 will be on 2016-07-30.
During the term of 5 years, you will make 60 payments, with a final payment of 908.70 on 2021-06-29.
At the end of the term, the balance remaining will be 94163.77. You will have paid a total of 54522.04
of which 48685.81, or 89.3%, will be interest. This represents 48.7% of the principal amount.

# usage
`printsummary(mortgage()...)`

where mortgage() takes arguments as defined for that function.
"""
function printsummary(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)
	# print out basic mortgage data
	println()
	@printf "Principal: %0.2f; Annual Interest Rate %s%%; Payment frequency: %s\n" dectofloat(principal) rate frequencyDescriptors[frequency]
	@printf "Compounding: %s\n" compoundingDescriptors[compounding]
	@printf "Your mortgage starts on %s and is amortized over (ie would be fully paid off in) %0.2f years.\n" startdate amortization
	@printf "Your first payment of %0.2f will be on %s.\n" dectofloat(paymentSize) firstPaymentDate
	@printf "During the term of %s, you will make %d payments, with a final payment of %0.2f on %s.\n" termString numberOfPayments dectofloat(finalPayment) finalPaymentDate
	@printf "At the end of the term, the balance remaining will be %0.2f. You will have paid a total of %0.2f\n" dectofloat(balance) dectofloat(accumulatedTotal)
	@printf "of which %0.2f, or %0.1f%%, will be interest. This represents %0.1f%% of the principal amount.\n\n" dectofloat(accumulatedInterest) dectofloat(accumulatedInterest / accumulatedTotal * 100) dectofloat(accumulatedInterest / principal * 100)
end

"""
    function printtable

    printtable(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)

Print out a header, then a table with a row for each payment, and then a summary footer, eg:

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


# usage
`printtable(mortgage()...)`

where mortgage() takes arguments as defined for that function.
"""
function printtable(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)
	# used when a tabular listing for each payment is desired
	printtableheader(principal, rate, amortization, compounding, numberOfPayments, paymentSize, termString, startdate)
	printtablecolumnheadings()
	printtablerows(numberOfPayments, table)
	printtablefooter(accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, principal) # use "splat ..." to allow the tuple returned by one function to be used a multiple arguments in another function
end

function printtableheader(principal, rate, amortization, compounding, numberOfPayments, paymentSize, termString, startdate)
	# @show principal rate amortization compounding numberOfPayments paymentSize termString startdate
	print_with_color(:red, "                       Mortgage Schedule of Payments")
	@printf "\n\nMortgage Principal: %0.2f at %0.3f%% annual interest, amortized over %0.2f years,\nusing %s, to be repaid with %d payments of %0.2f each,\nfor a term of %s. The mortgage start date is %s.\n" dectofloat(principal) rate amortization compoundingDescriptors[compounding] numberOfPayments dectofloat(paymentSize) termString startdate
end

function printtablecolumnheadings()
	println()
	println("                                                   Accumulated   Accumulated   Accumulated")
	println("Payment         Date    Principal     Interest       Principal      Interest         Total         Balance")
	println()
end

function printtablerows(numberOfPayments, table)
	for i = 0:numberOfPayments - 1
		j = i * 8 + 1
		@printf "%7d %12s %12.2f %12.2f" table[j] table[j + 1] dectofloat(table[j + 2]) dectofloat(table[j + 3])
		@printf "%16.2f %13.2f %13.2f %15.2f\n" dectofloat(table[j + 4]) dectofloat(table[j + 5]) dectofloat(table[j + 6]) dectofloat(table[j + 7])
	end
end

function printtablefooter(accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, principal)
	@printf "\nAt the end of the term, the outstanding balance will be %0.2f.\n" dectofloat(balance)
	@printf "The last payment of the term will be on %s in the amount of %0.2f.\n" finalPaymentDate dectofloat(finalPayment)
	@printf "Over the term, you will have paid a total of %0.2f of which %0.2f, or %0.2f%%, is interest. This\nrepresents %0.2f%% of the principal amount.\n\n\n" dectofloat(accumulatedTotal) dectofloat(accumulatedInterest) dectofloat(accumulatedInterest / accumulatedTotal * 100) dectofloat(accumulatedInterest / principal * 100)
end
