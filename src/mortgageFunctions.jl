__precompile__()

# Mortgage calculator functions

function initialization(args)
	termLength = haskey(mortgageTermDescriptors,args["term"]) ? mortgageTermDescriptors[args["term"]][2] : parse(Int, args["term"])
	if termLength == "a"
		termLength = args["amortization"]
	end
	if termLength > args["amortization"]
		error("The specified term exceeds the amortization!")
	end
	get!(args, "termLength", termLength)
	termString = haskey(mortgageTermDescriptors,args["term"]) ? mortgageTermDescriptors[args["term"]][1] : "$(args["term"]) years"
	get!(args, "termString", termString)
	firstPaymentDate = nextpaymentdate(args["startdate"],args["frequency"], args["startdate"])
	get!(args, "firstPaymentDate", firstPaymentDate)
	numberOfPayments = numberofperiods(args["frequency"], args["termLength"], args["startdate"])
	get!(args, "numberOfPayments", numberOfPayments)
	if args["payment"] == nothing
		paymentSize = paymentsizecalc(args["rate"], args["principal"], args["amortization"], args["compounding"], args["frequency"], args["startdate"])
	else
		paymentSize = args["payment"]
		amortization = Int(calculateamortization(args) - args["startdate"]) / 365.25
		args["amortization"] = amortization
	end
	get!(args, "paymentSize", paymentSize)
	# get!(args, "amortization", amortization)
	return args
end

function tablerow(paymentNumber, paymentDate, principalPortion, interestPortion, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, args, printing)
	# @show accumulatedInterest interestPortion
	# this is a recursive function to calculate and print out values for each mortgage payment
	if printing
		s1 = @sprintf "%7d %12s %12.2f %12.2f" paymentNumber paymentDate principalPortion interestPortion
		s2 = @sprintf "%16.2f %13.2f %13.2f %15.2f" accumulatedPrincipal accumulatedInterest accumulatedTotal balance
		println(s1,s2)
	end
	if balance == 0
		if printing
			println(@sprintf "The final payment (payment number %d) on %s will be %0.2f." paymentNumber paymentDate principalPortion + interestPortion)
		end
		return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate
	else
		interestPortion = interest(balance, args["rate"], timeValues[args["frequency"]], args["compounding"], paymentDate)
		principalPortion = args["paymentSize"] - interestPortion

		if principalPortion > balance # ie, we would be overpaying the loan
			return tablerow(paymentNumber + 1, nextpaymentdate(paymentDate, args["frequency"], args["startdate"]), balance, interestPortion, accumulatedPrincipal + balance, accumulatedInterest + interestPortion, accumulatedTotal + balance + interestPortion, 0, args, printing)
		elseif paymentNumber < args["numberOfPayments"]
			# @show interestPortion interestPortion+accumulatedInterest
			return tablerow(paymentNumber + 1, nextpaymentdate(paymentDate,args["frequency"], args["startdate"]), principalPortion, interestPortion, accumulatedPrincipal + principalPortion, accumulatedInterest + interestPortion, accumulatedTotal + principalPortion + interestPortion, balance - principalPortion, args, printing)
		else
			return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate
		end
	end
end

function dotablerows(args; printing=false)
	# call tablerow with the arguments initialized to starting values
	interestAmount = interest(args["principal"], args["rate"], timeValues[args["frequency"]], args["compounding"], args["firstPaymentDate"])
	# @show interestAmount
	return tablerow(1, args["firstPaymentDate"], args["paymentSize"] - interestAmount, interestAmount, args["paymentSize"] - interestAmount, interestAmount, args["paymentSize"], args["principal"] - ((args["paymentSize"] - interestAmount)), args, printing)
end


function calculateamortization(args)
	# if the payment amount is specified, then we must calculate the amortization. Let's do it iteratively.
	# We'll simply calculate each payment, and stop when the balance goes to zero or becomes negative.
	interestAmount = interest(args["principal"], args["rate"], timeValues[args["frequency"]], args["compounding"], args["firstPaymentDate"])
	return processpayment(args["startdate"], interestAmount, args["principal"] - (args["payment"] - interestAmount), args)
end

function processpayment(paymentDate, interestPortion, balance, args)
	# @show paymentDate balance
	interestPortion = interest(balance, args["rate"], timeValues[args["frequency"]], args["compounding"], paymentDate)
	principalPortion = args["payment"] - interestPortion
	if principalPortion > balance # ie we've gone too far
		return paymentDate
	else
		return processpayment(nextpaymentdate(paymentDate,args["frequency"], args["startdate"]), interestPortion, balance - principalPortion, args)
	end
end

# function paymentsize(args)
# 	# if no payment amount was specified, calculate the amount
# 	if args["payment"] == nothing
# 		return paymentsizecalc(args["rate"], args["principal"], args["amortization"], args["compounding"], args["frequency"], args["startdate"])
# 	else
# 		return args["payment"]
# 	end
# end

function interest(principal, rate, timeValue, compounding, paymentDate)
	# calculates the interest amount for a single time period
	# simple interest formula is I = principal x rate x time
	# @show principal rate time compounding
	rate = rate * 0.01 # convert percent to fraction
	if compounding == "s"
		rate = rate / 365 # calculate daily interest rate; note that for some commercial mortgages, this value should be 360
		if timeValue == 1//12 || timeValue == 1//24 # in these situations, the amount of interest depends on how many days in the month
			daysInMonth = daysinmonth(paymentDate - Month(1)) # get the number of days in the preceding month
			if timeValue == 1//12
				return  daysInMonth * rate * principal
			else # ie timeValue is 1//24
				paymentDay = day(paymentDate)
				if paymentDay == 1
					return (daysInMonth - 15) * rate * principal
				else
					return 15 * rate * principal
				end
			end
		else
			# @show timeValue rate principal timeValue * rate * principal
			return timeValue * rate * principal
		end
	else
		if timeValue > 1 # ie 7 or 14 days
			timeValue = timeValue / 365
		end
		if compounding == "m" # ie american (monthly) compounding or simple interest
			return principal * rate * timeValue
		elseif compounding == "c" # for Canadian (semi-annual) compounding
			return ((1 + rate / 2) ^ (2 * timeValue) - 1) * principal
		end
	end
end

# calculate the size of each payment, when not specified by the user.
function paymentsizecalc(annualRate, principal, amortization, compounding, frequency, startDate)
	# println("paymentsize parameters: $annualRate, $principal, $amortization, $compounding, $frequency, $startDate")
	
	# for compound interest, the formula is: 
	# P = r(PV) / (1 - (1+r)e(-n))
	# where P = payment, PV = Present Value, r = rate per period, n = number of periods
	
	# for simple interest, the formula is: 
	# payment = (principal + interestAmount) / number of periods, where
	# interestAmount = principal x interest x amortization
		
	interest = annualRate / 100 # convert percentage to decimal
	timeValue = timeValues[frequency]
	if timeValue > 1 # ie if 7 or 14 days
		timeValue = timeValue / 365
	end
		
	if compounding == "s" # ie, simple interest (no compounding, but interest accrues daily)
		return (principal + (principal * interest * amortization)) / numberofperiods(frequency, amortization, startDate)
	elseif compounding == "m" # ie, monthly, or American, compounding
		num = interest * timeValue * principal
		denom = 1 - (1 + interest * timeValue) ^ (- amortization / timeValue)
		# @show interest timeValue principal num denom num/denom
		return num / denom
	elseif compounding == "c" # ie, Canadian, or semi-annual, compounding
		mi = (1 + interest/2)^(2 * timeValue)
		# @show interest mi
		return principal * (mi - 1) / (1 - mi ^ (-amortization / timeValue))
	else
		error("The compounding specified as '$compounding' is not defined.")
	end
	interestAmount = principal * (interest * timeValue) * amortization
	println("interestAmount", interestAmount)
	(principal + interestAmount) / (amortization * timeValue)
end

function numberofperiods(frequency, duration, startDate)
	# for monthly or bimonthly payment frequencies, use 12 or 24 periods per year, respectively
	# for weekly or two-weekly payment frequencies, calculate the number of periods over the
	# total amortization interval: get the number of days, and divide by 7 or 14, respectively
	# duration is specified in years or a fraction thereof
	if 	frequency == "m"
		n = 12 * duration
	elseif frequency == "b"
		n = 24 * duration
	else
		# @show duration
		if duration < 1 # calculate using months instead of years
			days = (startDate + Month(duration * 12)) - startDate
		else
			days = (startDate + Year(duration)) - startDate
		end
		# @show days
		if frequency == "w"
			n = Int(days) / 7
		elseif frequency == "t"
			n = Int(days) / 14
		else error("The payment frequency specified as '$frequency' is not defined!")
		end
	end
	return round(Int, n)
end

function numberofpayments(args)
	return numberofperiods(args["frequency"], args["termLength"], args["startdate"])
end

function nextpaymentdate(paymentDate, frequency, startDate)
	# compute the date for the next payment
	if frequency == "m" # ie, monthly payments
		if 28 <= day(startDate) <= daysinmonth(startDate) # if it will fit all months
			days = daysinmonth(paymentDate) - day(paymentDate)
			return lastdayofmonth(paymentDate + Month(1)) - Day(days)
		else
			return paymentDate + Month(1)
		end
			
	elseif frequency == "b" # ie, payments twice a month
		if day(paymentDate) ==1 
			return paymentDate + Day(14)
		elseif day(paymentDate) == 15
			return paymentDate - Day(14) + Month(1)
		else
			error("bimonthly payments can only be on the 1st or 15th of each month. If necessary, set the starting date to either the 1st or the 15th.")
		end
	elseif frequency == "w"
		return paymentDate + Week(1)
	elseif frequency == "t"
		return paymentDate + Week(2)
	else
		error("not defined")
	end
end
