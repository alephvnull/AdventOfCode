const input = split.(readlines("data/2021/input08.txt")[1:end],"|")

function output_values(input)
    count = 0
    for (_, outputs) ∈ input
        for dgt ∈ length.(split(outputs, " "))
            if dgt == 2 || dgt == 3 || dgt == 4 || dgt == 7
                count += 1
            end
        end
    end
    count
end

function all_output_values(input)
    count = 0
    for (patterns, outputs) ∈ input
        seven = Set()
        four = Set()
        for hint ∈ split(patterns, " ")
            if length(hint) == 3
                seven = Set(hint)
            elseif length(hint) == 4
                four = Set(hint)
            end
        end
        digits = ""
        for dgt ∈ split(outputs, " ")
            lendigit = length(dgt)
            if lendigit == 2 
                digits *= "1"
            elseif lendigit == 3
                digits *= "7"
            elseif lendigit == 4
                digits *= "4"
            elseif lendigit == 7
                digits *= "8"
            elseif lendigit == 6
                if (Set(dgt) ∩ four) == four
                    digits *= "9"
                elseif (Set(dgt) ∩ seven) == seven
                    digits *= "0"
                else
                    digits *= "6"
                end
            elseif lendigit == 5 
                if (Set(dgt) ∩ seven) == seven
                    digits *= "3"
                elseif length(Set(dgt) ∩ four) == 3
                    digits *= "5"
                else
                    digits *= "2"
                end
            end
        end
        count += parse(Int, digits)
    end
    count
end

@time part1 = input |> output_values
@time part2 = input |> all_output_values

println("Part 1 : $(part1)")
println("Part 2 : $(part2)")
