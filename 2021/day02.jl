function dive(ln :: Array{String,1}) :: Int64
    depth    :: Int64 = 0
    horizont :: Int64 = 0
    for line ∈ ln
        key, value = split(line, ' ')
        x = parse(Int64, value)
        key == "forward" ? horizont += x : 
        key == "down" ? depth += x : 
        key == "up" ? depth -= x : nothing
    end
    return depth * horizont 
end

function divewithaim(ln :: Array{String,1}) :: Int64
    aim      :: Int64 = 0
    depth    :: Int64 = 0
    horizont :: Int64 = 0
    for line ∈ ln
        key, value = split(line, ' ')
        x = parse(Int64, value)
        key == "forward" ? (horizont += x, depth += aim * x) : 
        key == "down" ? aim += x : 
        key == "up" ? aim -= x : nothing
    end
    return depth * horizont   
end

@time part1 = "2021/input/input02.txt" |> readlines |> dive
@time part2 = "2021/input/input02.txt" |> readlines |> divewithaim

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")