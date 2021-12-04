function parse_file(file_path)
    ln = Int64[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, parse(Int, line))
        end
    end
    return ln
end

function find_hz(arr)
    st = Set([])
    n  = 0
    while true
        for x in arr
            n += x
            if ⊆(n, st)
                return n
            end
            union!(st,n)
        end
    end
    return nothing
end

file_name = "data/2018/input01.txt"

@time part1 = reduce(+, parse_file(file_name))
@time part2 = find_hz(parse_file(file_name))

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")