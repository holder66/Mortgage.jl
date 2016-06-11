__precompile__()

# provides text to print out the mortgage term that was specified; also the length in years,
# for the term values which are not straightforward years. No term value is provided for the
# term "until paid off".
mortgageTermDescriptors = Dict("1/4"=>("3 months",1//4),
	"1/2"=>("6 months",1//2),
	"1"=>("1 year",1),
	"a"=>("until paid off","a"))

frequencyDescriptors = Dict("m"=>"monthly", "b"=>"bimonthly", "w"=>"weekly", "t"=>"every 2 weeks")

compoundingDescriptors = Dict("s"=>"simple interest (no compounding, but accrued daily)",
	"m"=>"monthly (American) compounding",
	"c"=>"Canadian, or semi-annual, compounding")
	
timeValues = Dict("m"=>1//12, "b"=>1//24, "w"=>7, "t"=>14)

# the help text below will be displayed when the parameter help="y" is provided.
helpText = """
This mortgage and loan calculator will work in any decimal-based currency.
All the parameters are keyword parameters, and have default values; try it out: mortgage()
Example parameters: principal=250000, rate=4.25, amortization=30, term="5", payment=3750, startingdate="2016-5-31"
The term can be specified as "1/4", for 3 months; "1/2", for 6 months; "a", which makes the term the same as the amortization; or just enter the years.
Compounding takes the values "m", for monthly (American) compounding; "c", for Canadian (biannual) compounding; or "s", for simple interest (no compounding).
Payment frequency takes values "m" for monthly; "b" for bimonthly (twice a month, on the first and the fifteenth); "w" for weekly; and "t" for every two weeks. For bimonthly payments, please specify a starting date which is the first of the month. 
Default starting date is today's date.
If amortization is specified, the payment amount will be calculated. If you specify a payment amount, then the amortization will be calculated. If you specify both, amortization will be ignored.
The default output is a summary. To obtain a tabular listing of each payment, specify output="list". To write the listing to a text file, provide the file name, eg output="fileName.txt".
This calculator can also be run on the command line, eg julia mortgage.jl commandLineArguments
"""
