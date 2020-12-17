s = open("input.txt") do file
    read(file, String);
end


function ParseInput(s)
    startStateFlat = map(x->x=='#', replace(s,"\n"=>"") |> collect);
    dim = length(split(s,"\n")[1])
    startState = reshape(startStateFlat, (dim,dim));

    simSpace = falses(21, 21, 21);

    halfDim = dim ÷ 2;

    simSpace[11-halfDim:11+halfDim - ifelse(dim%2==0,1,0),
        11-halfDim:11+halfDim - ifelse(dim%2==0,1,0),
        11] .= startState;

    return simSpace;
end

function numNeighbors(space, loc)
    count = 0;
    for i = -1:1
        for j = -1:1
            for k = -1:1
                tempLoc = loc .+ [i,j,k];
                if all(tempLoc .== loc)
                    continue;
                end

                if all(tempLoc.>0) && all(tempLoc.<22)
                    if space[tempLoc[1], tempLoc[2], tempLoc[3]]
                        count += 1;
                    end
                end
            end
        end
    end

    return count;
end

function BootUp(simSpace)
    nextSpace = falses(21,21,21);
    for step = 1:6
        for k = 1:21
            for i = 1:21
                for j = 1:21
                    nCount = numNeighbors(simSpace, [i, j, k]);

                    active = simSpace[i, j, k];
                    if active
                        # println(nCount);
                        if 1 < nCount < 4
                            nextSpace[i, j, k] = true;
                        else
                            nextSpace[i, j, k] = false;
                        end
                    else
                        if nCount == 3
                            nextSpace[i, j, k] = true;
                        else
                            nextSpace[i, j, k] = false;
                        end
                    end
                end
            end

            # println(k);
            # println(simSpace[:,:,k])
        end
        println("--------");
        simSpace .= nextSpace;
    end

    totalActive = sum(simSpace);
    println(totalActive);

    return totalActive;
end

simSpace = ParseInput(s);
# simSpace = ParseInput(".#.\n..#\n###");
BootUp(simSpace)
