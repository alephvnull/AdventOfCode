input = readlines("data/2021/input14.txt")

template = input[1]
rules = input[3:end]


function link(rules)
    links = Dict()
    for (from, to) ∈ split.(rules," -> ")
        push!(links,from => to)
    end
    links
end

function pair(template)
    pairs = Dict()
    for i in 1:length(template)-1
        pair = template[i:i+1]
        !haskey(pairs, pair) ? push!(pairs, pair => 0) : nothing
        pairs[pair] +=1
    end
    pairs
end

function mod!(dict, k, v)
    !haskey(dict, k) ? push!(dict, k => 0) : nothing
    dict[k] += v
end

function polymer(pairs, links)
    new = Dict()
    for (pair,value) in pairs
        if pair in keys(links)
            vv = links[pair]
            mod!(new, pair[1] * vv, value)
            mod!(new, vv * pair[2], value)
        else
            mod!(new, pair, value )
        end
    end
    new 
end

function gletters(pairs)
    letters = Dict()
    for (k,v) in pairs
        mod!(letters, k[1] ,v)
    end
    letters[template[end]] += 1
    letters
end

function simulate(steps)
    links = link(rules)
    pairs = pair(template)

    for _ in 1:steps
        pairs = polymer(pairs, links)
    end

    letters = gletters(pairs)
    max(values(letters)...)-min(values(letters)...)
end

@time part1 = simulate(10)
@time part2 = simulate(40)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")

