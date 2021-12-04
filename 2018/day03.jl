function parse_line(line) 
    _,_,γ,δ = split(line, " ")
    x, y = parse.(Int, split(γ[1:end-1], ',')) .+ 1
    w, h = parse.(Int, split(δ, 'x')) .- 1
    return x, y, w, h
end

function intersections(arr)
    claim = zeros(Int64, 1000, 1000)
    for line in arr
        x,y,w,h = parse_line(line)
        claim[x:x+w, y:y+h] .+= 1
    end
    return claim, sum(claim .> 1)
end

function not_overlap(arr, claim)
    for line in arr
        id, = split(line, ' ')
        x, y, w, h = parse_line(line)
        if all(claim[x:x+w, y:y+h] .== 1)
            return id[2:end]
        end
    end

end

parsed = "data/2018/input03.txt" |> readlines

@time claim, part1 =  parsed |> intersections
@time part2 = not_overlap(parsed, claim)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")