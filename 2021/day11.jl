CI = CartesianIndex

const input   = parse.(Int, reduce(hcat, collect.(readlines("data/2021/input11.txt"))))
const indices = CartesianIndices(input)
const adjset  = CI(-1,-1):CI(1,1)

allequal(x) = all(y->y==x[1],x)

adjacent(pt) = [pt+adj for adj ∈ adjset if pt+adj ∈ indices]

function simulation()
    counter = 0
    step = 0
    cc = 0
    zz = copy(input)
    tf = zeros(Bool, 10, 10)
    while !allequal(zz)
        step += 1
        zz .+= 1
        for _ ∈ 1:100
            for ii ∈ indices
                if zz[ii] > 9 && tf[ii] == false
                    tf[ii] = true
                    cc += 1
                    zz[adjacent(ii)] .+=1
                end
            end
        end
        zz[zz .> 9 ] .= 0
        step == 100 ? counter = cc : nothing
        tf .= false             
    end
    counter, step
end

@time part1, part2 = simulation()

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")