function simulation(values, days)
    nums = [count(==(i), values) for i ∈ 0:8]
    for _ ∈ 1:days
        newday = zero(nums)
        for (cycle, cc) ∈ enumerate(nums)
            cycle == 1 ? newday[[7,9]] += [cc,cc] : newday[cycle-1] += cc
            newday[cycle] -= cc
        end
        nums += newday
    end
    sum(nums)
end

input = parse.(Int, split(readlines("data/2021/input06.txt")[1],","))

@time part1 = simulation(input, 80)
@time part2 = simulation(input, 256)

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
