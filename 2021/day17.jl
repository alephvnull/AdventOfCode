vx(v, t) = v - t ≤ 0 ? 0 : v - t
vy(v,t) = v - t

xmin, xmax, ymin , ymax  = 14,50,-267,-225

inbox(x,y) = xmin ≤ x ≤ xmax && ymin ≤ y ≤ ymax

function shoot()
    mx,c = -Inf,0
    for vyy in -300:300, vxx in 1:300
        sxx, syy, lmx,inbx ,i = 0, 0, -Inf, false, 0
        while true
            i += 1
            sxx += vx(vxx,i); syy += vy(vyy, i)
            syy < ymin || sxx > xmax ? break : 
            lmx < syy ? lmx = syy : nothing
            if inbox(sxx, syy)
                inbx = true
                c+=1
                break
            end
        end
        lmx > mx && inbx ? mx = lmx : nothing
    end
    mx,c
end
@time shoot() |> x -> "Part 1 : $(x[1])\nPart 2 : $(x[2])" |> println
