function dive(ln)
    depth    = 0
    horizont = 0
    for line ∈ ln
        key, value = split(line, ' ')
        x = parse(Int64, value)
        key == "forward" ? horizont += x : 
        key == "down" ? depth += x : 
        key == "up" ? depth -= x : nothing
    end
    return depth * horizont 
end

function divewithaim(ln)
    aim       = 0
    depth     = 0
    horizont  = 0
    for line ∈ ln
        key, value = split(line, ' ')
        x = parse(Int64, value)
        key == "forward" ? (horizont += x, depth += aim * x) : 
        key == "down" ? aim += x : 
        key == "up" ? aim -= x : nothing
    end
    return depth * horizont   
end

@time part1 = "data/2021/input02.txt" |> readlines |> dive
@time part2 = "data/2021/input02.txt" |> readlines |> divewithaim

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")