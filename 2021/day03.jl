function bitarrtoint(arr :: BitArray{1}) :: Int64
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end

function strtobinarr(str :: String) :: BitArray{1}
    return [parse(Int64, x) for x in str]
end

function powerconsumption(ln :: Array{String,1}) :: Int64
    len :: Int64 = length(ln)
    binarr :: Array{Int64, 1} = zeros(Int64, 12)
    for ii in ln
        for (oo,xx) in enumerate(ii)
            binarr[oo] += parse(Bool, xx)
        end
    end
    γ :: BitArray{1} = (binarr ./ len) .|> x -> x > 0.5 ? true : false
    return bitarrtoint(γ) * bitarrtoint(.!γ)
end

function ratingwrapper(pref :: Bool) :: Function
    function reccheck(ln :: Array{String,1}, bit :: Bool, pos :: Int64) :: String
        sbit    :: Bool = false
        arr     :: Array{String, 1} = Array([])

        sum([parse(Bool, ii[pos]) for ii in ln]) >= (length(ln) / 2) ? 
        sbit = pref : sbit = !pref

        for ii in ln
            parse(Bool, ii[pos]) == sbit ? push!(arr, ii) : nothing 
        end

        length(arr) == 1 ? (return arr[1]) : (return reccheck(arr, bit, pos + 1))
    end
    return reccheck
end

function lifesupportrating(ln :: Array{String,1}) :: Int64
    oxygen   :: Function = ratingwrapper(true)
    scrubber :: Function = ratingwrapper(false)

    x :: Int64 = oxygen(ln, true, 1)    |> strtobinarr |> bitarrtoint
    y :: Int64 = scrubber(ln, false, 1) |> strtobinarr |> bitarrtoint

    return x * y
end

@time part1 = "2021/input/input03.txt" |> readlines |> powerconsumption
@time part2 = "2021/input/input03.txt" |> readlines |> lifesupportrating

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
