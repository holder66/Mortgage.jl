__precompile__()

"Dictionary with text strings for printing out mortgage terms, and term values in years, where meaningful."
mortgageTermDescriptors = Dict("1/4"=>("3 months",1//4),
	"1/2"=>("6 months",1//2),
	"1"=>("1 year",1),
	"a"=>("until paid off","a"))

"Dictionary with text strings for printouts of payment frequency."
frequencyDescriptors = Dict("m"=>"monthly", "b"=>"bimonthly", "w"=>"weekly", "t"=>"every 2 weeks")

"Dictionary with text strings for printouts of compounding."
compoundingDescriptors = Dict("s"=>"simple interest (no compounding, but accrued daily)",
	"m"=>"monthly (American) compounding",
	"c"=>"Canadian, or semi-annual, compounding")

"Dictionary for durations of payment intervals corresponding to payment frequencies."
timeValues = Dict("m"=>1//12, "b"=>1//24, "w"=>7, "t"=>14)
