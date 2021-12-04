using StatsBase

function count2and3(arr)
    count2 = 0
    count3 = 0
    for i :: String in arr
        tmp_2 = 0
        tmp_3 = 0
        for (_, v) in countmap(i)
            v == 2 ?  tmp_2 += 1 : v == 3 ? tmp_3 += 1 : nothing
        end
        tmp_2 > 0 ? count2 += 1 : nothing
        tmp_3 > 0 ? count3 += 1 : nothing
    end
    return count2 * count3
end

function common_between(arr)
    l = length(arr)
    for i in 1:l
        st =  Set()
        for line in arr
            if i == 1
                cut = line[2:end]
            elseif i == l
                cut = line[1:end-1]
            else 
                cut = line[1:i-1] * line[i+1:end]
            end
            cut in st ? (return cut) : nothing
            push!(st, cut)
        end
    end
end

@time part1 = "data/2018/input02.txt" |> readlines |> count2and3
@time part2 = "data/2018/input02.txt" |> readlines |> common_between

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")