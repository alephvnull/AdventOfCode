function locations(coordinates)
    loc = zeros(Int64, length(coordinates), 2)
    mx  = 0
    for (i, line) in enumerate(coordinates)
        pt = parse.(Int64, split(line, ','))     
        any(pt .> mx) ? mx = maximum(pt) : nothing
        loc[i, :] = pt
    end
    return mx, loc
end

function areas(mx, locations)
    areas = Dict()
    bidx  = Set()
    stop  = mx
    start = 0
    for i in start:stop
        for j in start:stop
            dist = abs.(locations[:, 1] .- i) .+ abs.(locations[:, 2] .- j)
            mdist = minimum(dist)
            if sum(dist .== mdist) == 1
                idx = argmin(dist)
                (idx in keys(areas)) ? nothing : areas[idx] = 0           
                areas[idx] += 1
                (i == start || i == stop || j == start || j == stop) ? push!(bidx, idx) : nothing
            end
        end
    end
    for idx in bidx
        delete!(areas, idx)
    end
    return areas
end

function containing(mx, locations)
    tdist = 10000
    stop  = mx + 10
    start = -10
    Δ     = 0
    for i in start:stop
        for j in start:stop
            dist = abs.(locations[:, 1] .- i) .+ abs.(locations[:, 2] .- j)
            Δ += sum(dist) < tdist
        end
    end
    return Δ
end

@time part1 = "data/2018/input06.txt" |> readlines |> locations |> areas |> values |> maximum
@time part2 = "data/2018/input06.txt" |> readlines |> locations |> containing 

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
