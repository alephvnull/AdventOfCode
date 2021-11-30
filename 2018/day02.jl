using StatsBase

function parse_file(file_path :: String) :: Array{String, 1}
    ln :: Array{String, 1} = String[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, line)
        end
    end
    return ln
end

function count2and3(arr :: Array{String, 1}) :: Int64
    count2 :: Int64 = 0
    count3 :: Int64 = 0
    for i :: String in arr
        tmp_2 :: Int64 = 0
        tmp_3 :: Int64 = 0
        for (k :: Char, v :: Int64) in countmap(i)
            v == 2 ?  tmp_2 += 1 : v == 3 ? tmp_3 += 1 : nothing
        end
        tmp_2 > 0 ? count2 += 1 : nothing
        tmp_3 > 0 ? count3 += 1 : nothing
    end
    return count2 * count3
end

function common_between(arr :: Array{String, 1}) :: String
    l :: Int64 = length(arr)
    for i in 1:l
        st :: Set{String} =  Set()
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


@time part1 = "input/input02.txt" |> parse_file |> count2and3
@time part2 = "input/input02.txt" |> parse_file |> common_between


println("Part 1 : $(part1)")
println("Part 2 : $(part2)")