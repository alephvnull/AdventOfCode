function parse_file(file_path :: String) :: Array{Int64, 1}
    ln :: Array{Int64, 1} = Int64[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, parse(Int, line))
        end
    end
    return ln
end

function increases(ln :: Array{Int64, 1}) :: Int64
    return [ 1 for i in 2:length(ln) if ln[i] > ln[i-1]] |> length
end

function threesumincreases(ln :: Array{Int64, 1}) :: Int64
    return [ 1 for i in 4:length(ln) if ln[i] > ln[i-3]] |> length
end

@time part1 = "2021/input/input01.txt" |> parse_file |> increases
@time part2 = "2021/input/input01.txt" |> parse_file |> threesumincreases 


println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
