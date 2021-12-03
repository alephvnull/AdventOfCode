function parse_file(file_path) 
    ln = Int64[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, parse(Int, line))
        end
    end
    return ln
end

function increases(ln)
    return [ 1 for i in 2:length(ln) if ln[i] > ln[i-1]] |> length
end

function threesumincreases(ln)
    return [ 1 for i in 4:length(ln) if ln[i] > ln[i-3]] |> length
end

@time part1 = "data/2021/input01.txt" |> parse_file |> increases
@time part2 = "data/2021/input01.txt" |> parse_file |> threesumincreases 

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
