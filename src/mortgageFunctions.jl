__precompile__()

# Mortgage calculator functions

using Base.Dates

function termlength(term, amortization)
	termLength = haskey(mortgageTermDescriptors, term) ? mortgageTermDescriptors[term][2] : parse(Int, term)
	if termLength == "a"
		termLength = amortization
	elseif termLength > amortization
		error("The specified term exceeds the amortization!")
	end
	return termLength
end

function tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber, numberOfPayments, paymentDate, principalPortion, interestPortion, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, table)
	# this is a recursive function to calculate values for each mortgage payment
	if balance == 0
		return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate, table
	else
		interestPortion = interest(balance, rate, timeValues[frequency], compounding, paymentDate)
		principalPortion = paymentSize - interestPortion
		paymentDate = nextpaymentdate(paymentDate, frequency, startdate)
		table = append!(table, [paymentNumber + 1, paymentDate, principalPortion, interestPortion, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance])
		
		if principalPortion > balance # ie, we would be overpaying the loan
			return tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber + 1, numberOfPayments, paymentDate, balance, interestPortion, accumulatedPrincipal + balance, accumulatedInterest + interestPortion, accumulatedTotal + balance + interestPortion, 0, table)
		elseif paymentNumber < numberOfPayments
			# @show interestPortion interestPortion+accumulatedInterest
			return tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber + 1, numberOfPayments, paymentDate, principalPortion, interestPortion, accumulatedPrincipal + principalPortion, accumulatedInterest + interestPortion, accumulatedTotal + principalPortion + interestPortion, balance - principalPortion, table)
		else
			return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate, table
		end
	end
end

function dotablerows(principal, rate, frequency, compounding, startdate, firstPaymentDate, paymentSize, numberOfPayments)
	# call tablerow with the arguments initialized to starting values
	interestAmount = interest(principal, rate, timeValues[frequency], compounding, firstPaymentDate)
	table = [1, startdate, paymentSize - interestAmount, interestAmount, paymentSize - interestAmount, interestAmount, paymentSize, principal - (paymentSize -interestAmount)]
	return tablerow(rate, frequency, compounding, startdate, paymentSize, 1, numberOfPayments, firstPaymentDate, paymentSize - interestAmount, interestAmount, paymentSize - interestAmount, interestAmount, paymentSize, principal - (paymentSize - interestAmount), table)
end


function calculateamortization(args)
	# if the payment amount is specified, then we must calculate the amortization. Let's do it iteratively.
	# We'll simply calculate each payment, and stop when the balance goes to zero or becomes negative.
	interestAmount = interest(args["principal"], args["rate"], timeValues[args["frequency"]], args["compounding"], args["firstPaymentDate"])
	return processpayment(startdate, interestAmount, principal - payment - interestAmount)
end

function processpayment(paymentDate, interestPortion, balance)
	# @show paymentDate balance
	interestPortion = interest(balance, rate, timeValues[frequency], compounding, paymentDate)
	principalPortion = paymentSize - interestPortion
	if principalPortion > balance # ie we've gone too far
		return paymentDate
	else
		return processpayment(nextpaymentdate(paymentDate, frequency, startdate), interestPortion, balance - principalPortion)
	end
end

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
	# @show annualRate principal amortization compounding frequency startDate
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
