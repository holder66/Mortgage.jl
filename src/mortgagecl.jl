using Mortgage

include("mortgageArguments.jl")

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
	p = parse_commandline(args)
	if p["output"] == nothing
		printsummary(mortgagecalc(p["principal"], p["rate"], p["amortization"], p["frequency"], p["compounding"], p["startdate"], p["term"], p["payment"])...)
	else
		printtable(mortgagecalc(p["principal"], p["rate"], p["amortization"], p["frequency"], p["compounding"], p["startdate"], p["term"], p["payment"])...)
	end
end

main()