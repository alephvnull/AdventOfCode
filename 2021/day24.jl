permarr(f) = [parse.(Int, i) for i in split.(string.(f), "") if "0" ∉ i]

const largest = permarr(reverse(9000000:9999999))
const smallest = permarr(8400000:8999999)

const mod1 = [1, 1,16, 0, 0, 3, 2, 15, 0, 0, 0, 1, 0, 0]
const mod2 = [0, 0, 0, 8, 4, 0, 0, 0, 13, 3, 7, 0, 6, 8]

function process(x)
    z = 0
    out = zeros(Int, 14)
    idx = 1
    for i in 1:14
        t1, t2 = mod1[i], mod2[i]
        if t1 == 0
            out[i] = ((z % 26) - t2)
            z = Int(floor(z//26))
            if !(1 ≤ out[i] ≤ 9) return false end
        else
            z = z * 26 + x[idx] + t1
            out[i] = x[idx]
            idx += 1
        end
    end
    out
end

toprint(arr) = reduce(*, string.(arr))
function solve(inp)
    for x in inp
        res = process(x)
        if res != false
            return res
        end
    end
end

largest  |> solve |> toprint |> x -> "p1: $(x)" |> println
smallest |> solve |> toprint |> x -> "p2: $(x)" |> println

# def works(x):
#     z = 0
#     res = [0] * 14

#     x_idx = 0

#     for i in range(14):
#         increment, mod_req = steps[i], required[i]

#         if increment == nothing:
#             assert mod_req != nothing
#             res[i] = ((z % 26) - mod_req)
#             z //= 26
#             if not (1 <= res[i] <= 9):
#                 return False

#         else:
#             assert increment != nothing
#             z = z * 26 + x[x_idx] + increment
#             res[i] = x[x_idx]
#             x_idx += 1

#     return res




 
#println(dd())
