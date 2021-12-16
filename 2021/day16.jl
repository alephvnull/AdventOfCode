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
    packet, num = inp, ""
    while packet[1] == '1' 
        num *= packet[2:5]
        packet = cutoff(packet,6)
    end
    cutoff(packet,6), bit2int(num * packet[2:5])
end

function parse_operator(inp)
    packet, I, vec, sum = inp, inp[1], [], 0
    packet = cutoff(inp, 2)
    if I == '0'
        L, packet = packet[1:15], cutoff(packet,16)
        subs = packet[1:bit2int(L)]
        while !isempty(subs)
            subs,val, dd = packetaize(subs)
            sum += val
            push!(vec, dd)
        end
        cutoff(packet, bit2int(L)+1), sum, vec
    else      
        L,packet = packet[1:11],cutoff(packet,12)
        for _ ∈ 1:bit2int(L)
            packet,val, dd = packetaize(packet[1:end])
            sum += val
            push!(vec, dd)
        end
        packet, sum, vec
    end
end

function packetaize(inp)
    packet, sum, val = inp, 0, 0
    V = packet[1:3]
    T = packet[4:6]
    packet = cutoff(packet,7)
    if T == "100"       
        packet, val = parse_value(packet)            
    else
        packet, sum, vec = parse_operator(packet) 
        val = op[bit2int(T)](vec)            
    end
    packet, bit2int(V) + sum, val
end

@time input |> packetaize |> x -> "Part 1 : $(x[2])\nPart 2 : $(x[3])" |> println



