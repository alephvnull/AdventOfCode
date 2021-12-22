const input = readlines("data/2021/input22.txt")

function prs(line)
    op, cube = split(line, " ")
    x, y, z = split(cube,",")
    _, xx = split(x, "=")
    _, yy = split(y, "=")
    _, zz = split(z, "=")

    xmin, xmax = parse.(Int, split(xx, ".."))
    ymin, ymax = parse.(Int, split(yy, ".."))
    zmin, zmax = parse.(Int, split(zz, ".."))

    op , (xmin:xmax), (ymin:ymax), (zmin:zmax)
end

⩣(x,n) = length(x) == n

vol((x,y,z)) = [x,y,z] .|> length |> prod

function subr(crange, low, high)
    c0,c1 = crange[1], crange[end]
    c1 < low ||  c0 > high ? (return []) : 
    min(max(c0, low), high):min(max(c1, low), high)
end

function ovrlp((x,y,z), rest)
    overlap = []
    for r ∈ rest
        op, rx, ry, rz = r
        sx = subr(rx, x[1], x[end])
        sy = subr(ry, y[1], y[end])
        sz = subr(rz, z[1], z[end])
        sx ⩣ 0 || sy ⩣ 0 || sz ⩣ 0 ? continue : nothing
        push!(overlap, (op, sx, sy, sz))
    end
    overlap
end

function countincube(step, rest)
    overlap = ovrlp(step[2:4], rest)
    reduce(-, [countincube(o, overlap[i+1:end]) for (i,o) ∈ enumerate(overlap)], init = 0) + vol(step[2:4])
end

const cubes = prs.(input)

f((t, s)) = s[1] == "off" ? 0 : countincube(s, cubes[t+1:end])
proc(inp) = inp |> enumerate .|> f |> sum

@time cubes[1:20] |> proc |> x-> "p1: $(x)" |> println
@time cubes |> proc |> x-> "p2: $(x)" |> println