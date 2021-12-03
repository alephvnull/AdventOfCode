function bitarrtoint(arr :: BitArray{1}) :: Int64
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end

function strtobintarr(str :: String) :: Array{Int64, 1}
    return [parse(Int64, x) for x in str]
end

function powerconsumption(ln :: Array{String,1}) :: Int64
    len :: Int64 = length(ln)
    binarr :: Array{Int64, 1} = zeros(Int64, 12)
    for ii in ln
        for (i,xx) in enumerate(ii)
            binarr[i] += parse(Int64, xx)
        end
    end
    γ :: BitArray{1} = (binarr ./ len) .|> x -> x > 0.5 ? true : false
    return bitarrtoint(γ) * bitarrtoint(.!γ)
end

function ratingwrapper(pref :: Bool) :: Function
    function reccheck(ln :: Array{String,1}, bit :: Bool, pos :: Int64)
        sbit    :: Bool = false
        arr     :: Array{String, 1} = Array([])
        counter :: Int64 = 0
        len     :: Int64  = length(ln)

        for ii in ln
            parse(Int64, ii[pos]) == 1 ? counter += 1 : nothing
        end

        counter >= (len / 2) ? sbit = pref : sbit = !pref

        for ii in ln
            parse(Int64, ii[pos]) == sbit ? push!(arr, ii) : nothing 
        end

        length(arr) == 1 ? (return arr[1]) : (return reccheck(arr, bit, pos + 1))
    end
    return reccheck
end

function lifesupportrating(ln :: Array{String,1}) :: Int64
    oxygenrating   :: Function = ratingwrapper(true)
    scrubberrating :: Function = ratingwrapper(false)

    x = oxygenrating(ln, true, 1) |> strtobintarr |> bitarrtoint
    y = scrubberrating(ln, false, 1) |> strtobintarr |> bitarrtoint
    
    return x * y
end

@time part1 = "2021/input/input03.txt" |> readlines |> powerconsumption
@time part2 = "2021/input/input03.txt" |> readlines |> lifesupportrating

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
