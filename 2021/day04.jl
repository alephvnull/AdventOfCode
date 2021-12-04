function single_bingo_sets(input)
    xx = Array([])
    yy = zeros(Int, 5, 5)
    oo = 1
    for ii in input
        if ii == "" 
            push!(xx,yy)
            yy = zero(yy)
            oo = 1
            continue
        end
        yy[oo,1:end] = parse.(Int, split(ii, " ", keepempty = false))
        oo+=1
    end
    return xx
end

function rowsandcol(matrix)
    xx = Array([])
    for ii in 1:5
        push!(xx, matrix[ii, 1:end])
        push!(xx, matrix[1:end, ii])
    end
    return xx
end

function data_parse(input)
    drawn = parse.(Int,split(input[1], ","))
    sets = input[3:end] |> single_bingo_sets .|> rowsandcol
    return drawn, sets
end

function winingqueue(ff, bingosets,drawn)
    minsum = Array([])
    minvec = Array([])
    for set in bingosets
        sums = Array([])
        vec = Array([])
        for rorc in set
            match = filter( x -> x ≠ nothing, indexin(rorc, drawn))
            length(match) != 5 ? continue :
            push!(vec, match) 
            push!(sums, max(match...))
        end
        locmin = argmin(sums)
        push!(minvec, vec[locmin])
        push!(minsum, sums[locmin])
    end
    ptr = ff(minsum)
    seq = minvec[ptr]
    return (ptr, seq)
end

function findbingo(ff, drawn,sets)
    (p, v) = winingqueue(ff, sets, drawn)
    kk = getindex(drawn,v)[argmax(v)]
    return sum(filter(x -> !(x in drawn[1:max(v...)]), unique(vcat(sets[p]...)))) * kk
end

drawn, sets = "data/2021/input04.txt" |> readlines |> data_parse

@time part1 = findbingo(x -> argmin(x), drawn, sets)
@time part2 = findbingo(x -> argmax(x), drawn, sets)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
