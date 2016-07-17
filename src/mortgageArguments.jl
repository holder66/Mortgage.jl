__precompile__()

using ArgParse,
	Base.Dates,
	DecFP

function parse_commandline(args)
	s = ArgParseSettings()

	@add_arg_table s begin
		"--rate", "-r"
			help = "annual rate of interest in percent, eg 3.25"
			arg_type = Float64
			default = 10.
		"--principal", "-p"
			help = "principal amount, in any currency"
			arg_type = Dec64
			default = Dec64(100000)
		"--amortization", "-a"
			help = "amortization interval, in years; defaults to 25 years (note: if a payment amount is specified, amortization interval is ignored)"
			arg_type = Int
			default = 25
		"--payment", "-y"
			help = "payment amount; if not specified, it will be calculated based on the amortization interval. Note that for simple interest mortgages, the payment will be calculated as for monthly compounded mortgages."
			arg_type = Dec64
		"--frequency", "-f"
			help = "payment frequency: m = monthly (default); w = weekly; t = two weeks; b = bimonthly. Note that for bimonthly payments, they will occur on the first and the fifteenth of each month, and the mortgage should start on the first or fifteenth of the month."
			arg_type = AbstractString
			default = "m"
		"--compounding", "-c"
			help = "compounding: s = none (simple interest; note that interest accrues daily but is not compounded); m - monthly (ie American) (this is the default); c = Canadian (ie semi-annual. Note that variable rate mortgages often compound monthly - check the fine print.)"
			arg_type = AbstractString
			default = "m"
		"--startdate", "-s"
			help = "start date for the mortgage; default is today's date"
			arg_type = Date
			default = today()
		"--term","-t"
			help = "specify the term in years; use 1/4 for 3 months and 1/2 for 6 months; enter a to indicate for the entire amortization interval (ie until paid off); default is 5 years. A term greater than the amortization will generate an error."
			arg_type =AbstractString
			default = "5"
		"output"
		help = "specify 'list' for a formatted listing, or a filename; if left blank, only a summary will be printed"
	end
	return parse_args(args, s)
end