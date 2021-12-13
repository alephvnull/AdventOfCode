const input = readlines("data/2021/input13.txt")
const points = input[1:839]
const instructions = input[841:end]

function print_code(st)
    zz = fill(" ",40,10)
    for (x,y) ∈ st
        zz[x+1,y+10] = "\u001b[31m#"
    end
    for i ∈ reverse(5:10)
        println(reduce(*, zz[1:end, i]))
    end
end

fold_along_x(paper, x,y, vv) = x > vv ? push!(paper, (2vv - x,y)) : nothing
fold_along_y(paper, x,y, vv) = y < -vv ? push!(paper, (x, -2vv - y)) : nothing

fold_along(test) = test == "fold along x" ? fold_along_x : fold_along_y

function fold_set(paper, (comm, val))
    vv = parse(Int,val)
    for (x,y) ∈ paper
        fold_along(comm)(paper, x,y, vv) ≠ nothing ? delete!(paper, (x,y)) : nothing
    end
    paper
end

function make_paper(points)
    paper = Set()
    for pt ∈ points
        x,y = parse.(Int,(split(pt, ",")))
        push!(paper, (x,-y))
    end
    paper
end

function code(paper, instructions)
    for ii ∈ instructions 
        fold_set!(paper, split(ii,"="))
    end
    print_code(paper)
end


@time part1 = length(fold_set!(make_paper(points),split(instructions[1],"=")))

println("Part 1 : $(part1)")

@time code(make_paper(points), instructions)

