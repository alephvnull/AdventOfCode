const input = split.(readlines("data/2021/input10.txt"), "")

const symmetry = Dict("}" => "{", ">" => "<", ")" => "(", "]" => "[")

const scorec = Dict("}" => 1197, ">" => 25137, ")" => 3, "]" => 57,
                    "{" => 3,    "<" => 4,     "(" => 1, "[" => 2)

opening(cc) = cc == "{" || cc == "(" || cc == "[" || cc == "<"


function corrupted(line)
    score = 0
    stack = String[]
    for cc ∈ line
        if length(stack) != 0
            if opening(cc)
                push!(stack,cc)
            else 
                pop!(stack) != symmetry[cc] ? score += scorec[cc] : nothing       
            end
        else
            push!(stack,cc)
        end
    end
    score
end

stack_score(st) = foldl((α,β) -> 5*α+β, map(x -> scorec[x],reverse(st)), init = 0)

function incomplete(input)
    score = input .|> corrupted |> t -> map([x for (i,x) ∈ enumerate(input) if t[i] == 0]) do line
        stack = String[]
        for cc ∈ line
            if length(stack) != 0 
                opening(cc) ? push!(stack,cc) : pop!(stack)   
            else
                push!(stack,cc)
            end
        end
        stack
    end  .|> stack_score |> sort 
    score[Int(ceil(end/2))] 
end

@time part1 = input .|> corrupted |> sum
@time part2 = input |> incomplete

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")


