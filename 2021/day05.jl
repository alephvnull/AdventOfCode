input = readlines("data/2021/input05.txt")

zz = zeros(Int, 1000, 1000)

hvline(x1, y1, x2, y2) = (x1 == x2) ||  (y1 == y2)

for ll in input 
    x1y1, x2y2 = split(ll, " -> ")
    x1, y1 = parse.(Int, split(x1y1, ","))
    x2, y2 = parse.(Int, split(x2y2, ","))
    x1, x2 = min(x1,x2), max(x1,x2)
    y1, y2 = min(y1,y2), max(y1,y2)

    if hvline(x1,y1,x2,y2)
        zz[x1+1:x2+1, y1+1:y2+1] .+= 1
    end

end
println(count(zz .> 1))

function diagonal(x1,y1,x2,y2)
    xinc = x2 > x1 ? 1 : -1
    yinc = y2 > y1 ? 1 : -1
    return x1:xinc:x2, y1:yinc:y2
end

zz = zeros(Int, 1000, 1000)

for ll in input 
    x1y1, x2y2 = split(ll, " -> ")
    x1, y1 = parse.(Int, split(x1y1, ","))
    x2, y2 = parse.(Int, split(x2y2, ","))

    if hvline(x1,y1,x2,y2)
        x1, x2 = min(x1,x2), max(x1,x2)
        y1, y2 = min(y1,y2), max(y1,y2)
        zz[x1+1:x2+1, y1+1:y2+1] .+= 1
    else
        diag = diagonal(x1,y1,x2,y2)
        for (x,y) in zip(collect(diag[1]), collect(diag[2]))
            zz[x+1, y+1] += 1
        end
    end
end
println(count(zz .> 1))
