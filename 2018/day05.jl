polymer = file_path -> convert.(Char, read(open(file_path, "r"))) 

function react(polymer) 
    chars = Array([])
    for char in polymer
        !(isempty(chars)) && (lowercase(char) == lowercase(chars[end])) && (chars[end] != char) ? pop!(chars) : push!(chars, char)
    end
    return chars
end


function full_react(polymer)
    mln = typemax(Int64)
    for char in 'a':'z'
        len = filter(c -> lowercase(c) ≠ char, polymer) |> react |> join |> length 
        mln > len ? mln = len : nothing
    end
    return mln
end

@time part1 = "data/2018/input05.txt" |> polymer |> react |> join |> length 
@time part2 = "data/2018/input05.txt" |> polymer |> react |> full_react

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
