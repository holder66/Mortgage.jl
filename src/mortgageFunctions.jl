__precompile__()

# Mortgage calculator functions

using Base.Dates

"Return length of the mortgage or loan term in years."
function termlength(term, amortization)
	# use a ? : construct as an if - then - else oneliner
	termLength = haskey(mortgageTermDescriptors, term) ? mortgageTermDescriptors[term][2] : parse(Int, term)
	if termLength == "a"
		termLength = amortization
	elseif termLength > amortization
		error("The specified term exceeds the amortization!")
	end
	return termLength
end


"Recurse to calculate for each payment."
function tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber, numberOfPayments, paymentDate, principalPortion, interestPortion, accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, table)
	if balance == 0 # no more payments to process
		return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate, table
	else # get values for next payment
		nextPaymentDate = nextpaymentdate(paymentDate, frequency, startdate)
		interestPortion = interest(balance, rate, timeValues[frequency], compounding, paymentDate)
		principalPortion = paymentSize - interestPortion
		if principalPortion > balance # ie, we would be overpaying the loan
			return tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber + 1, numberOfPayments, nextPaymentDate, balance, interestPortion, accumulatedPrincipal + balance, accumulatedInterest + interestPortion, accumulatedTotal + balance + interestPortion, 0, append!(table, [paymentNumber + 1, nextPaymentDate, principalPortion, interestPortion, accumulatedPrincipal + principalPortion, accumulatedInterest + interestPortion, accumulatedTotal + paymentSize, balance - principalPortion]))
		elseif paymentNumber < numberOfPayments # still more payments to go...
			return tablerow(rate, frequency, compounding, startdate, paymentSize, paymentNumber + 1, numberOfPayments, nextPaymentDate, principalPortion, interestPortion, accumulatedPrincipal + principalPortion, accumulatedInterest + interestPortion, accumulatedTotal + principalPortion + interestPortion, balance - principalPortion, append!(table, [paymentNumber + 1, nextPaymentDate, principalPortion, interestPortion, accumulatedPrincipal + principalPortion, accumulatedInterest + interestPortion, accumulatedTotal + paymentSize, balance - principalPortion]))
		else # ie the number of payments == paymentNumber, thus we're done
			return accumulatedPrincipal, accumulatedInterest, accumulatedTotal, balance, principalPortion + interestPortion, paymentDate, table
		end
	end
end

"Call tablerow with arguments initialized to starting values."
function dotablerows(principal, rate, frequency, compounding, startdate, firstPaymentDate, paymentSize, numberOfPayments)
	interestAmount = interest(principal, rate, timeValues[frequency], compounding, firstPaymentDate)
	table = [1, firstPaymentDate, paymentSize - interestAmount, interestAmount, paymentSize - interestAmount, interestAmount, paymentSize, principal - (paymentSize -interestAmount)]
	return tablerow(rate, frequency, compounding, startdate, paymentSize, 1, numberOfPayments, firstPaymentDate, paymentSize - interestAmount, interestAmount, paymentSize - interestAmount, interestAmount, paymentSize, principal - (paymentSize - interestAmount), table)
end

"""
Calculate the interest amount for a single time period.
Simple interest formula is I = principal x rate x time
"""
function interest(principal, rate, timeValue, compounding, paymentDate)

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

"""
Return the size of each payment, when not specified by the user.
For compound interest, the formula is: 
P = r(PV) / (1 - (1+r)e(-n))
where P = payment, PV = Present Value, r = rate per period, n = number of periods

For simple interest, the formula is: 
payment = (principal + interestAmount) / number of periods, where
interestAmount = principal x interest x amortization
"""
function paymentsizecalc(annualRate, principal, amortization, compounding, frequency, startDate)
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
		return num / denom
	elseif compounding == "c" # ie, Canadian, or semi-annual, compounding
		mi = (1 + interest/2)^(2 * timeValue)
		return principal * (mi - 1) / (1 - mi ^ (-amortization / timeValue))
	else
		error("The compounding specified as '$compounding' is not defined.")
	end
end

"""
Return the number of payment periods, given frequency and duration.
Starting date is needed to deal with leap years.
For monthly or bimonthly payment frequencies, use 12 or 24 periods per year, respectively.
For weekly or two-weekly payment frequencies, calculate the number of periods over the
total amortization interval: get the number of days, and divide by 7 or 14, respectively.
Duration is specified in years or a fraction thereof.
"""
function numberofperiods(frequency, duration, startDate)
	if 	frequency == "m"
		n = 12 * duration
	elseif frequency == "b"
		n = 24 * duration
	else
		if duration < 1 # calculate using months instead of years
			days = (startDate + Month(duration * 12)) - startDate
		else
			days = (startDate + Year(duration)) - startDate
		end
		if frequency == "w"
			n = Int(days) / 7
		elseif frequency == "t"
			n = Int(days) / 14
		else error("The payment frequency specified as '$frequency' is not defined!")
		end
	end
	return round(Int, n)
end

"Return date for the next payment."
function nextpaymentdate(paymentDate, frequency, startDate)
	if frequency == "m" # ie, monthly payments
		# test if the starting date is on or after the 28th of the month
		if 28 <= day(startDate) <= daysinmonth(startDate) 
			days = daysinmonth(paymentDate) - day(paymentDate)
			# set a payment date which is the same number of days before month's end
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
