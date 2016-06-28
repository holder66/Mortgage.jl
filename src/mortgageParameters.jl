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
