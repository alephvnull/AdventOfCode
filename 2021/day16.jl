cutoff(str, x) = str[x:end]

bit2int(x) = parse(Int, x, base = 2)

parser(x) = string.(parse.(Int, x, base = 16), base = 2, pad = 4)

transform(x) = split.(x,"") .|> parser |> xx -> reduce.(*, xx)[1]

const input = readlines("data/2021/input16.txt") |> transform

op = Dict(
    0 => sum,
    1 => prod,
    2 => minimum,
    3 => maximum,
    5 => x -> x[1] > x[2],
    6 => x -> x[1] < x[2],
    7 => x -> x[1] == x[2]
)

function parse_value(inp)
    oo, num = inp, ""
    while oo[1] == '1' 
        num *= oo[2:5]
        oo = cutoff(oo,6)
    end
    num *= oo[2:5]
    oo = cutoff(oo,6)
    oo, parse(Int, num, base = 2)
end

function parse_operator(inp)
    xx, ii, vec, sum = inp, inp[1], [], 0
    xx = cutoff(inp, 2)
    if ii == '0'
        ll = xx[1:15]
        xx = cutoff(xx,16)
        subs = xx[1:bit2int(ll)]
        while !isempty(subs)
            subs,val, dd = packetaize(subs)
            sum += val
            push!(vec, dd)
        end
        xx[bit2int(ll)+1:end], sum, vec

    else      
        ll = xx[1:11]
        xx = cutoff(xx,12)
        for _ ∈ 1:parse(Int, ll, base = 2)
            xx,val, dd = packetaize(xx[1:end])
            sum += val
            push!(vec, dd)
        end
        xx, sum, vec
    end
end

function packetaize(inp)
    packet, sum, val = inp, 0, 0
    V = packet[1:3]
    T = packet[4:6]
    packet = cutoff(packet,7)
    if T == "100"       
        packet, val= parse_value(packet)            
    else
        packet, sum, vec = parse_operator(packet) 
        val = op[bit2int(T)](vec)            
    end
    packet, bit2int(V) + sum, val
end

@time input |> packetaize |> x -> "Part 1 : $(x[2])\nPart 2 : $(x[3])" |> println



