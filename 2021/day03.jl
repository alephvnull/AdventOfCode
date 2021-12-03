function bitarrtoint(arr)
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end

function powerconsumption(ln)
    len    = length(ln)
    binarr = zeros(Int64, 12)
    for ii in ln
        for (oo,xx) in enumerate(ii)
            binarr[oo] += parse(Bool, xx)
        end
    end
    γ = (binarr ./ len) .|> x -> x > 0.5 ? true : false
    return bitarrtoint(γ) * bitarrtoint(.!γ)
end

function ratingwrapper(pref)
    function reccheck(ln, bit, pos)
        sbit = false
        arr  = Array([])

        sum([parse(Bool, ii[pos]) for ii in ln]) >= (length(ln) / 2) ? 
        sbit = pref : sbit = !pref

        for ii in ln
            parse(Bool, ii[pos]) == sbit ? push!(arr, ii) : nothing 
        end

        length(arr) == 1 ? (return arr[1]) : (return reccheck(arr, bit, pos + 1))
    end
    return reccheck
end

function lifesupportrating(ln)
    oxygen   = ratingwrapper(true)
    scrubber = ratingwrapper(false)

    x = parse(Int64, oxygen(ln, true, 1),    base = 2)
    y = parse(Int64, scrubber(ln, false, 1), base = 2)

    return x * y
end

@time part1 = "data/2021/input03.txt" |> readlines |> powerconsumption
@time part2 = "data/2021/input03.txt" |> readlines |> lifesupportrating

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
