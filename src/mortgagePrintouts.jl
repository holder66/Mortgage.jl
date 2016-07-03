__precompile__()

"""
    printsummary()

    printsummary(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)

Print out a seven-line summary of the given and calculated mortgage parameters, eg:

julia> printsummary(mortgage(startdate=Date(2016,6,29))...)

Principal: 100000; Annual Interest Rate: 10.0%; Payment frequency: monthly
Compounding: monthly (American) compounding
Your mortgage starts on 2016-06-29 and is amortized over (ie would be fully paid off in) 25.0 years.
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
	println("Principal: $(principal); Annual Interest Rate: $(rate)%; Payment frequency: $(frequencyDescriptors[frequency])")
	println("Compounding: $(compoundingDescriptors[compounding])")
	println(@sprintf "Your mortgage starts on %s and is amortized over (ie would be fully paid off in) %0.1f years." startdate amortization)
	println("Your first payment of $(@sprintf "%0.2f" paymentSize) will be on $(firstPaymentDate).")
	println(@sprintf "During the term of %s, you will make %d payments, with a final payment of %0.2f on %s." termString numberOfPayments finalPayment finalPaymentDate)
	println(@sprintf "At the end of the term, the balance remaining will be %0.2f. You will have paid a total of %0.2f" balance accumulatedTotal)
	println(@sprintf "of which %0.2f, or %0.1f%%, will be interest. This represents %0.1f%% of the principal amount." accumulatedInterest accumulatedInterest / accumulatedTotal * 100 accumulatedInterest / principal * 100)
end

"""
    function printtable

    printtable(principal, rate, amortization, frequency, compounding, startdate, termString, paymentSize, firstPaymentDate, numberOfPayments, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, table)

Print out a header, then a table with a row for each payment, and then a summary footer, eg:

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
	# println()
	print_with_color(:red, "                       Mortgage Schedule of Payments")
	println()
	println()
	s1 = @sprintf "Mortgage Principal: %0.2f at %0.2f%% annual interest, amortized over %0.1f years,\nusing %s, to be repaid with %d payments of %0.2f each,\nfor a term of %s. The mortgage start date is %s." principal rate amortization compoundingDescriptors[compounding] numberOfPayments paymentSize termString startdate
	println(s1)
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
		s1 = @sprintf "%7d %12s %12.2f %12.2f" table[j] table[j + 1] table[j + 2] table[j + 3]
		s2 = @sprintf "%16.2f %13.2f %13.2f %15.2f" table[j + 4] table[j + 5] table[j + 6] table[j + 7]
		println(s1, s2)
	end
end

function printtablefooter(accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, principal)
	s1 = @sprintf "At the end of the term, the outstanding balance will be %0.2f.\n" balance
	s2 = @sprintf "The last payment of the term will be on %s in the amount of %0.2f.\n" finalPaymentDate finalPayment
	s3 = @sprintf "Over the term, you will have paid a total of %0.2f of which %0.2f, or %0.2f%%, is interest. This\nrepresents %0.2f%% of the principal amount." accumulatedTotal accumulatedInterest accumulatedInterest / accumulatedTotal * 100 accumulatedInterest / principal * 100
	println("\n", s1, s2, s3, "\n\n\n")
end
