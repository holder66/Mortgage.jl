# DocTests for mortgage()

Note that in all the tests, startdate is provided. If startdate were not supplied, the default of today's date would be used, causing doctests that were specified on a different date to fail. Thanks to the DateParser package, a variety of date formats can be used. See below for some examples.

```@meta
DocTestSetup = quote
    using Mortgage
end
```
