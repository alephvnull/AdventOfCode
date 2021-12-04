function records(arr)
    lines = sort(arr)
    sleep = Dict()
    guard = -1
    pminute = x -> parse(Int, x[16:17]) 
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

function sleepiest_guard(records)
    sguard = -1
    asleep = -1
    for (guard, sleep) in records
        ∑ = sum(sleep)
        if ∑ > asleep
            sguard = guard
            asleep = ∑
        end
    end
    mmin = argmax(records[sguard]) - 1
    return sguard * mmin
end

function most_frequently(records)
    sguard  = -1
    asleep  = -1
    mmin    = -1
    for (guard, sleep) in records
        Θₘₐₓ = maximum(sleep)
        if Θₘₐₓ > asleep
            sguard = guard
            asleep = Θₘₐₓ
            mmin = argmax(sleep) - 1
        end
    end
    return sguard * mmin 
end

@time part1 = "data/2018/input04.txt" |> readlines |> records |> sleepiest_guard
@time part2 = "data/2018/input04.txt" |> readlines |> records |> most_frequently

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
