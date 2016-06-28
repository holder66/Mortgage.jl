__precompile__()

"""
	printsummary(args)

Print a summary of the mortgage parameters, payment amount, starting date,
date and size of last payment, balance remaining, etc.

args = dictionary of arguments, including values for the keys: principal, rate, frequency, compounding, startdate, amortization, paymentSize,
firstPaymentDate, termString, numberOfPayments
"""
# function printsummary(args)
# 	# print out basic mortgage data
# 	# first, use dotablerows to calculate values by iteration out to the end of the term
# 	(accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate) = dotablerows(args)
# 	# print the summary statistics
# 	println()
# 	println("Principal: $(args["principal"]); Annual Interest Rate: $(args["rate"])%; Payment frequency: $(frequencyDescriptors[args["frequency"]])")
# 	println("Compounding: $(compoundingDescriptors[args["compounding"]])")
# 	println(@sprintf "Your mortgage starts on %s and is amortized over (ie would be fully paid off in) %0.1f years." args["startdate"] args["amortization"])
# 	println("Your first payment of $(@sprintf "%0.2f" args["paymentSize"]) will be on $(args["firstPaymentDate"]).")
# 	println(@sprintf "During the term of %s, you will make %d payments, with a final payment of %0.2f on %s." args["termString"] args["numberOfPayments"] finalPayment finalPaymentDate)
# 	println(@sprintf "At the end of the term, the balance remaining will be %0.2f. You will have paid a total of %0.2f" balance accumulatedTotal)
# 	println(@sprintf "of which %0.2f, or %0.1f%%, will be interest. This represents %0.1f%% of the principal amount." accumulatedInterest accumulatedInterest / accumulatedTotal * 100 accumulatedInterest / args["principal"] * 100)
# end

function printtable(args)
	# used when a tabular listing for each payment is desired
	printtableheader(args)
	printtablecolumnheadings()
	# use dotablerows to calculate and print each line of the table
	endingValues = dotablerows(args, printing=true)
	printtablefooter(endingValues..., args["principal"], args) # use "splat ..." to allow the tuple returned by one function to be used a multiple arguments in another function
end

function printtableheader(args)
	# println()
	print_with_color(:red, "                       Mortgage Schedule of Payments")
	println()
	println()
	s1 = @sprintf "Mortgage Principal: %0.2f at %0.2f%% annual interest, amortized over %0.1f years,\nusing %s, to be repaid with %d payments of %0.2f each,\nfor a term of %s. The mortgage start date is %s." args["principal"] args["rate"] args["amortization"] compoundingDescriptors[args["compounding"]] args["numberOfPayments"] args["paymentSize"] args["termString"] args["startdate"]
	println(s1)
end

function printtablecolumnheadings()
	println()
	println("                                                   Accumulated   Accumulated   Accumulated")
	println("Payment         Date    Principal     Interest       Principal      Interest         Total         Balance")
	println()
end

function printtablefooter(accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, finalPayment, finalPaymentDate, principal, args)
	s1 = @sprintf "At the end of the term, the outstanding balance will be %0.2f.\n" balance
	s2 = @sprintf "The last payment of the term will be on %s in the amount of %0.2f.\n" finalPaymentDate finalPayment
	s3 = @sprintf "Over the term, you will have paid a total of %0.2f of which %0.2f, or %0.2f%%, is interest. This\nrepresents %0.2f%% of the principal amount." accumulatedTotal accumulatedInterest accumulatedInterest / accumulatedTotal * 100 accumulatedInterest / principal * 100
	println("\n", s1, s2, s3, "\n\n\n")
end

function writefile(args)
	println("We write to a file here\n\n\n")
end
