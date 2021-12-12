const input   = readlines("data/2021/input12.txt")

small_cave(c) = all(islowercase.(collect(c)))

function link!(c, from, to)
    !haskey(c, from) ? push!(c,from => [])  :  nothing     
    push!(c[from],to)
end

function graph(input)
    links = Dict()
    for (from, to) in split.(input,"-")
        link!(links,from,to)
        link!(links,to,from) 
    end
    links
end

function count_paths(links, vv, visited, from, to)
    from == to ? (return 1) : nothing
    if from in visited
        vv || from == "start" ? (return 0) : nothing
        vv = true
    end
    map(links[from]) do next
        count_paths(links, vv, (small_cave(from) ? vcat(visited,from) : visited), next, to )
    end |> sum  
end

const links = graph(input)

@time part1 = count_paths(links, true, [], "start", "end")
@time part2 = count_paths(links, false, [], "start", "end")

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")