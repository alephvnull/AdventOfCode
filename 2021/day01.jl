const input = "data/2021/input01.txt" |> readlines .|> x -> parse(Int, x)

increases(ln) = [1 for i ∈ 2:length(ln) if ln[i] > ln[i-1]] |> length

threesumincreases(ln) = [1 for i ∈ 4:length(ln) if ln[i] > ln[i-3]] |> length

@time input |> increases |> x-> "p1: $(x)" |> println
@time input |> threesumincreases |> x-> "p2: $(x)" |> println