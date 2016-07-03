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
	@show p
	k=collect(keys(p))
	v=collect(values(p))
	s=string(k[1] ,"=", v[1])
	for i = 2:length(k)
		s = string(s, ", ", k[i] ,"=", v[i])
	end
	@show s
	# parsed_args = initialization(parse_commandline(args))
	# output = get(parsed_args, "output", "") # returns the value stored for key "output"; if no value provided, returns ""
	# if output == nothing
	# 	printsummary(mortgage(parsed_args)...)
	# else
	# 	printtable(parsed_args)
	# 	if output != "list" # ie use the argument value as a filename
	# 		writefile(parsed_args)
	# 	end
	# end
	@show mortgage(p)
end

main()