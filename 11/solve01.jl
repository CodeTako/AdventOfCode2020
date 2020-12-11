s = open("input.txt") do file
    readlines(file);
end

function GetOccupiedNeighbors(i, j, board)
    count = 0;
    for x in -1:1
        for y = -1:1
            if x == y == 0
                continue
            end

            if 0 < i + x <= size(board, 1) &&  0 < j + y <= size(board, 2)
                # println("$(i+x) $(j+y) $(board[i,j])")
                count += board[i+x,j+y] == '#';
                # println(count)
            end
        end
    end

    return count;
end

function SimulateSeating(startState)
    simulating = true;
    curState = startState;
    nextState = Array{Char}(undef, 96, 91);
    nextState .= curState;
    while simulating
        changes = 0;
        for i = 1:size(startState,1)
            for j = 1:size(startState,2)
                if curState[i, j] == '.'
                    continue
                end

                nCount = GetOccupiedNeighbors(i, j, curState);

                if curState[i, j] == 'L' && nCount == 0
                    nextState[i, j] = '#';
                    changes += 1;
                elseif curState[i, j] == '#' && nCount >= 4
                    nextState[i, j] = 'L';
                    changes += 1;
                else
                    nextState[i,j] = curState[i, j];
                end
            end
        end
        println(changes);

        if all(nextState .== curState)
            simulating = false;
            break;
        end

        curState .= nextState;
    end

    println("=================");
    println(sum(map(x->x=='#', curState)));
end

rowLen = length(s[1]);
seating = vcat(map(collect, s)...);
seatingV = reshape(seating, (rowLen,91));
SimulateSeating(seatingV)
