function parse_file(file_path :: String) :: Array{Int64, 1}
    ln :: Array{Int64, 1} = Int64[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, parse(Int, line))
        end
    end
    return ln
end

function find_hz(arr :: Array{Int64, 1}) :: Int64
    st  :: Set{Int64}   = Set([])
    n   :: Int64        = 0
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

file_name = "2018/input/input01.txt"

@time part1 = reduce(+, parse_file(file_name))
@time part2 = find_hz(parse_file(file_name))

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")