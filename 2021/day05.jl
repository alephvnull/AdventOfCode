hvline(x1, y1, x2, y2) = (x1 == x2) ||  (y1 == y2)
minmax(a,b) = (min(a,b), max(a,b))
fxy(line) = split(line, " -> ") .|> x -> parse.(Int, split(x, ","))

function only_hv(input)
    zz = zeros(Int, 1000, 1000)
    for line ∈ input
        (x1,y1),(x2,y2) = fxy(line)
        if hvline(x1,y1,x2,y2)
            x1, x2 = minmax(x1,x2)
            y1, y2 = minmax(y1,y2)
            zz[x1+1:x2+1, y1+1:y2+1] .+= 1
        end       
    end
    count(zz .> 1)
end

function diagonal(x1,y1,x2,y2)
    xinc = x2 > x1 ? 1 : -1
    yinc = y2 > y1 ? 1 : -1
    return x1:xinc:x2, y1:yinc:y2
end

function all_lines(input)
    zz = zeros(Int, 1000, 1000)
    for line ∈ input
        (x1,y1),(x2,y2) = fxy(line)
        if hvline(x1,y1,x2,y2)
            x1, x2 = minmax(x1,x2)
            y1, y2 = minmax(y1,y2)
            zz[x1+1:x2+1, y1+1:y2+1] .+= 1
        else
            diag = diagonal(x1,y1,x2,y2)
            for (x,y) in zip(collect(diag[1]), collect(diag[2]))
                zz[x+1, y+1] += 1
            end
        end
    end
    count(zz .> 1)
end

@time part1 = "data/2021/input05.txt" |> readlines |> only_hv
@time part2 = "data/2021/input05.txt" |> readlines |> all_lines

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")