function parse_file(file_path :: String) :: Array{String, 1}
    ln :: Array{String, 1} = String[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, line)
        end
    end
    return ln
end

function parse_line(line :: String) :: Tuple{Int64, Int64, Int64, Int64}
    _,_,γ,δ = split(line, " ")

    x, y = parse.(Int, split(γ[1:end-1], ',')) .+ 1
    w, h = parse.(Int, split(δ, 'x')) .- 1

    return x, y, w, h
end

function intersections(arr :: Array{String, 1}) :: Tuple{Array{Int64, 2}, Int64}
    claim :: Array{Int64, 2} = zeros(Int64, 1000, 1000)
    for line :: String in arr
        x,y,w,h = parse_line(line)
        claim[x:x+w, y:y+h] .+= 1
    end
    return claim, sum(claim .> 1)
end

function not_overlap(  arr :: Array{String, 1}, 
                     claim :: Array{Int64, 2}) :: String
    for line in arr
        id, = split(line, ' ')
        x, y, w, h = parse_line(line)
        if all(claim[x:x+w, y:y+h] .== 1)
            return id[2:end]
        end
    end

end

parsed = "2018/input/input03.txt" |> parse_file

@time claim, part1 =  parsed |> intersections
@time part2 = not_overlap(parsed, claim)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")