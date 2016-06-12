using Mortgage
using Base.Test

# write your own tests here
@test 1 == 1
# @test 1 == .9

```@meta
    DocTestSetup = quote
        using DataFrames
        df = DataFrame(A = 1:10, B = 2:2:20)
    end
    ```
```julia
a = 1
b = 2
a + b

# output

3