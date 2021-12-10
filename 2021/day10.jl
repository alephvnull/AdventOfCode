const input = split.(readlines("data/2021/input10.txt"), "")

const symmetry = Dict("}"=>"{", ">"=>"<", ")" => "(", "]" => "[")

const scorec = Dict("}"=>1197, ">"=>25137, ")" => 3, "]" => 57,
                    "{"=>3,    "<"=>4,     "(" => 1, "[" => 2)

opening(cc) = cc == "{" || cc == "(" || cc == "[" || cc == "<"

function corrupted()
    score = 0
    for line ∈ input
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
    end
    println(score)
end

function dd2()
    score = 0
    
    ax = Array([])
    for line ∈ input
        corrupted = false
        stack = String[]
        for cc ∈ line
            if length(stack) != 0
                if opening(cc)
                    push!(stack,cc)
                else 
                    pop!(stack) != symmetry[cc] ? (score += scorec[cc]; corrupted = true) : nothing       
                end
            else
                push!(stack,cc)
            end
        end

        if corrupted == false
            push!(ax, line)
        end
    end
    score2 = Array([])

    for line in ax 
        stack = Array([])
        for cc in line
            if length(stack) != 0 
                if opening(cc)
                    push!(stack,cc)
                elseif stack[end] == symmetry[cc]
                    pop!(stack)
                end    
            else
                push!(stack,cc)
            end
        end
        push!(score2, foldl((a,b) -> 5*a+b, map(x -> scorec[x],reverse(stack)), init = 0) )
    end
    sort(score2)[Int(ceil(end/2))]
end

corrupted()
@time dd2()


