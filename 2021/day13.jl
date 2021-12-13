input = readlines("data/2021/input13.txt")

points = input[1:839]
instructions = input[841:end]

println(instructions)

function fold_set!(st, (comm, val))
    vv = parse(Int,val)
    if comm == "fold along x"
        for (x,y) in st
            if x > vv
                push!(st, (vv - (x - vv),y))
                delete!(st, (x,y))
            end
        end
    else
        for (x,y) in st
            if y < -vv
                push!(st, (x,-vv + (-vv - y)))
                delete!(st, (x,y))
            end
        end
    end
end

function print_code(st)
    zz = zeros(Int, 40, 10)

    for (x,y) in st
        zz[x+1,y+10] = 1
    end
    for i in 1:40
        println(zz[i, 5:end])

    end
end

function sol()
    st = Set()
    for pt in points
        x,y = parse.(Int,(split(pt, ",")))
        push!(st, (x,-y))
    end

    for ii in instructions 
        fold_set!(st, split(ii,"="))
    end
    println(length(st))
    print_code(st)
end

sol()
