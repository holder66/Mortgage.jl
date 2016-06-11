#!/Applications/Julia-0.4.5.app/Contents/Resources/julia/bin/julia
# Mortgage Calculator
# This calculator works in any decimal-based currency.

module Mortgage

export mortgage, p

include("mortgageArguments.jl") # specifies the command line arguments and defaults
include("mortgageParameters.jl") # uses dictionaries to expand on input arguments
include("mortgageFunctions.jl")
include("mortgagePrintouts.jl")


# using Base.Dates,
# 	MortgagePrintouts,
# 	MortgageArguments,
# 	MortgageFunctions,
# 	MortgageParameters

macro p(ex)
	# this macro facilitates specifying command line arguments when in the Julia REPL
	# to use: after including mortgage.jl, type @p followed by a quoted string of arguments and parameters
	quote
		main($ex)
	end
end

function mortgage(; principal=100000, rate=10.0, amortization=25, frequency="m", compounding="m", startdate=today(), term="5", output=nothing, payment=nothing, help=nothing)
	if help=="y"
		println(helpText)
		return
	end
	args = Dict("principal"=>principal, "rate"=>rate, "amortization"=>amortization, "frequency"=>frequency, "compounding"=>compounding, "startdate"=>startdate, "term"=>term, "payment"=>payment, "output"=>output)
	args = initialization(args)
	if output == nothing
		printsummary(args)
	else
		printtable(args)
	end
end

function main(x...)
	if !isempty(x)
		args = split(x[1])
	else
		if isempty(ARGS)
			println("Please enter command line arguments for mortgage.jl, or hit \"enter\" for defaults:")
			args = split(readline(STDIN))
		else
			args = ARGS
		end
	end
	# parsed_args = parse_commandline(args)
	parsed_args = initialization(parse_commandline(args))
	output = get(parsed_args, "output", "") # returns the value stored for key "output"; if no value provided, returns ""
	if output == nothing
		printsummary(parsed_args)
	else
		printtable(parsed_args)
		if output != "list" # ie use the argument value as a filename
			writefile(parsed_args)
		end
	end
end

# main()

end # module
