function parse_file(file_path :: String) :: Array{Int64, 1}
    ln :: Array{Int64, 1} = Int64[]
    open(file_path) do file
        for line in eachline(file)
            push!(ln, parse(Int, line))
        end
    end
    return ln
end


function increases(ln :: Array{Int64, 1}) :: Int64
    m :: Int64 = 0
    mprev :: Int64 = 0
    for (i,x) in enumerate(ln)
        
        if i == 1
            mprev = x
            continue
        end

        mprev < x ? m+=1 : nothing

        mprev = x
    end
    return m
    
end

function threesumsplit(ln :: Array{Int64, 1}) :: Array{Int64,1}
    Δ :: Array{Int64,1} = ln
    s :: Array{Array{Int64,1}} = Array([])

    while (length(Δ) != 2)
        push!(s, [Δ[1],Δ[2], Δ[3]])
        popfirst!(Δ)
    end    
    return sum.(s)   
end

@time part1 = "2021/input/input01.txt" |> parse_file |> increases
@time part2 = "2021/input/input01.txt" |> parse_file |> threesumsplit |> increases


println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
