function parse_file(file_path :: String) :: Array{String, 1}
    ln :: Array{String, 1} = String[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, line)
        end
    end
    return ln
end

function records(arr :: Array{String, 1}) :: Dict{Int, Array{Int64, 1}}
    lines :: Array{String, 1} = sort(arr)
    sleep :: Dict{Int64, Array{Int64, 1}} = Dict()
    guard :: Int64 = -1

    pminute = x :: String -> parse(Int, x[16:17]) :: Int64

    for line in lines
        if occursin("Guard", line)
            start = findfirst(isequal('#'), line)
            stop  = findnext(isequal(' '), line, start)
            guard = parse(Int, line[start+1:stop-1])

            (guard in keys(sleep)) ? nothing : sleep[guard] = zeros(Int, 60)

        elseif occursin("falls", line)
            start = pminute(line) + 1
            sleep[guard][start:end] .+= 1

        elseif occursin("wakes", line)
            start = pminute(line) + 1
            sleep[guard][start:end] .-=1
        end
    end
    return sleep
end

function sleepiest_guard(records :: Dict{Int, Array{Int64, 1}}) :: Int64

    sguard :: Int64 = -1
    asleep :: Int64 = -1

    for (guard :: Int64, sleep :: Array{Int64, 1}) in records
        ∑ = sum(sleep)

        if ∑ > asleep
            sguard = guard
            asleep = ∑
        end
    end

    mmin :: Int64 = argmax(records[sguard]) - 1
    return sguard * mmin
end

function most_frequently(records :: Dict{Int, Array{Int64, 1}}) :: Int64
    sguard :: Int64 = -1
    asleep :: Int64 = -1
    mmin   :: Int64 = -1

    for (guard :: Int64, sleep :: Array{Int64, 1}) in records
        Θₘₐₓ = maximum(sleep)
        if Θₘₐₓ > asleep
            sguard = guard
            asleep = Θₘₐₓ
            mmin = argmax(sleep) - 1
        end
    end
    return sguard * mmin 
end

@time part1 = "2018/input/input04.txt" |> parse_file |> records |> sleepiest_guard
@time part2 = "2018/input/input04.txt" |> parse_file |> records |> most_frequently

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
