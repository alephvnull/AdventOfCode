function parse_file(file_path :: String) :: Array{String, 1}
    ln :: Array{String, 1} = String[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, line)
        end
    end
    return ln
end

function locations(coordinates :: Array{String, 1}) :: Tuple{Int64, Array{Int64, 2}}
    loc :: Array{Int64, 2} = zeros(Int64, length(coordinates), 2)
    mx  :: Int64 = 0
    for (i, line) in enumerate(coordinates)

        pt = parse.(Int64, split(line, ','))     

        any(pt .> mx) ? mx = maximum(pt) : nothing

        loc[i, :] = pt
    end

    return mx, loc
end

function areas((mx, locations) :: Tuple{Int64, Array{Int64, 2}}) :: Dict{Int64, Int64}
    areas   :: Dict{Int64, Int64} = Dict()
    bidx    :: Set{Int64} = Set()
    stop    :: Int64 = mx
    start   :: Int64 = 0

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

function containing((mx, locations) :: Tuple{Int64, Array{Int64, 2}}) :: Int64
    tdist :: Int64 = 10000
    stop  :: Int64 = mx + 10
    start :: Int64 = -10
    Δ     :: Int64 = 0
    for i in start:stop
        for j in start:stop
            dist = abs.(locations[:, 1] .- i) .+ abs.(locations[:, 2] .- j)
            Δ += sum(dist) < tdist
        end
    end
    return Δ
end


@time part1 = "2018/input/input06.txt" |> parse_file |> locations |> areas |> values |> maximum
@time part2 = "2018/input/input06.txt" |> parse_file |> locations |> containing 

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
