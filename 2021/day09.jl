const input = readlines("data/2021/input09.txt")

N(z,i,j) = z[i,j] < z[i, j-1]
S(z,i,j) = z[i,j] < z[i, j+1]
E(z,i,j) = z[i,j] < z[i+1, j]
W(z,i,j) = z[i,j] < z[i-1, j]

NSWE(z,i,j) = E(z,i,j) && W(z,i,j) && N(z,i,j) && S(z,i,j) 

function parse_to_matrix(input)
    imax = length(input)
    jmax = length(input[1])
    zz = zeros(Int, imax + 2, jmax + 2)
    zz[1:end, 1:end] .+= 100000
    for (i,xx) ∈ enumerate(input)
        zz[i+1, 2:end-1] .= parse.(Int,split(xx, ""))
    end
    zz
end

function sum_of_risk(zz)
    counter = 0
    (jmax, imax) = size(zz)
    for j ∈ 2:jmax-1
        for i ∈ 2:imax-1 
            NSWE(zz,i,j) ? counter += (zz[i,j] + 1) : nothing
        end
    end
    counter
end

function simulation(zz)
    moves = 1000
    (jmax, imax) = size(zz)
    for j ∈ 2:jmax-1
        for i ∈ 2:imax-1
            if zz[i,j] == 9
                zz[i,j] = 100000
            else
                zz[i,j] = 1
            end
        end
    end
    for _ ∈ 1:moves
        for j ∈ 2:jmax-1
            for i ∈ 2:imax-1
                if zz[i,j] ≠ 0 && zz[i,j] ≠ 100000 
                    xx = rand((1,2,3,4))
                    if xx == 1
                        if  zz[i,j-1] ≠ 100000
                            zz[i,j-1] += zz[i,j]
                            zz[i,j]  =  0
                        end
                    elseif xx == 2
                        if  zz[i,j+1] ≠ 100000
                            zz[i,j+1] += zz[i,j]
                            zz[i,j]  =  0
                        end
                    elseif xx == 3
                        if  zz[i-1,j] ≠ 100000
                            zz[i-1,j] += zz[i,j]
                            zz[i,j]  =  0
                        end
                    elseif xx == 4
                        if  zz[i+1,j] ≠ 100000
                            zz[i+1,j] += zz[i,j]
                            zz[i,j]  =  0
                        end
                    end
                end 
            end
        end
    end
    arr = [zz[i,j] for j ∈ 1:jmax-2 for i ∈ 1:imax-2 if (zz[i,j] ≠ 100000)&&(zz[i,j] ≠ 0)]
    reduce(*,sort!(arr)[end-2:end])
end

@time part1 = input |> parse_to_matrix |> sum_of_risk
@time part2 = input |> parse_to_matrix |> simulation

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
