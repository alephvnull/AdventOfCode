const input = readlines("data/2021/input14.txt")

const template = input[1]
const rules = input[3:end]

subtract(x) = max(values(x)...)-min(values(x)...)

function link(rules)
    links = Dict()
    for (from, to) ∈ split.(rules," -> ")
        push!(links,from => to)
    end
    links
end

function mod!(dict, k, v)
    !haskey(dict, k) ? push!(dict, k => 0) : nothing
    dict[k] += v
end

function pair(template)
    pairs = Dict()
    for i ∈ 1:length(template)-1
        pair = template[i:i+1]
        mod!(pairs, pair, 1)
    end
    pairs
end

function polymer(pairs, links)
    new = Dict()
    for (pair,value) ∈ pairs
        if pair ∈ keys(links)
            vv = links[pair]
            mod!(new, pair[1] * vv, value)
            mod!(new, vv * pair[2], value)
        end
    end
    new 
end

function gletters(pairs)
    letters = Dict()
    for (pair,value) ∈ pairs
        mod!(letters, pair[1] ,value)
    end
    letters[template[end]] += 1
    letters
end

function simulate(steps)
    links = link(rules)
    pairs = pair(template)
    for _ ∈ 1:steps
        pairs = polymer(pairs, links)
    end
    gletters(pairs) |> subtract
end

@time part1 = simulate(10)
@time part2 = simulate(40)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")

