using DataStructures

printsol(part) = x -> "Part $(part) : $(x)" |> println
const input = parse.(Int, reduce(hcat, collect.(readlines("data/2021/input15.txt"))))
const adjset  = [(-1,0),(1,0), (0,-1),(0,1)]

transform(x) = ([
        x    x.+1 x.+2 x.+3 x.+4
        x.+1 x.+2 x.+3 x.+4 x.+5
        x.+2 x.+3 x.+4 x.+5 x.+6
        x.+3 x.+4 x.+5 x.+6 x.+7
        x.+4 x.+5 x.+6 x.+7 x.+8
    ] .- 1) .% 9 .+ 1

function dijkstra(input)
    height, width = size(input)
    adjacent(x,y) = [(x,y).+adj for adj ∈ adjset if x+adj[1] ∈ 1:height && y+adj[2] ∈ 1:width]

    queue = PriorityQueue((1, 1) => 0)
    visited = Set(((1, 1),))
    while !isempty(queue)
        (xx, yy), len = dequeue_pair!(queue)
        push!(visited, (xx, yy))
        (xx, yy) == (height, width) ? (return len) : nothing
        for (nxx, nyy) ∈ adjacent(xx,yy)
            if (nxx, nyy) ∉ visited
                newlen = len + input[nxx, nyy]
                newlen < get(queue, (nxx, nyy), Inf) ? queue[(nxx, nyy)] = newlen : nothing
            end
        end
    end
end

@time input |> dijkstra |> printsol(1) 
@time input |> transform |> dijkstra |> printsol(2) 

