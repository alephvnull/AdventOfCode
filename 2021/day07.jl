const input = parse.(Int, split(readlines("data/2021/input07.txt")[1],","))

ff1(x,y) = abs.(x .- y)
ff2(x,y) = abs.(x .- y) .* ((abs.(x.-y).+1) .* 0.5)

function align(ff, positions)
    minval = Inf
    for position in 1:max(positions...)
        minloc = ff(positions,position) |> sum
        minloc < minval ? (minval = minloc) : nothing
    end
    return minval
end

@time part1 = align(ff1, input)
@time part2 = align(ff2, input)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")