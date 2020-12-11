s = open("input.txt") do file
    readlines(file);
end

function testInput(inp, dims)
    return reshape(replace(inp, "\n"=>"")|>collect, dims)
end

function GetOccupiedNeighbors(i, j, board)
    count = 0;
    directions = [
        [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]
    ];

    for dir in directions
        # println(dir);
        loc = [i, j] .+ dir;
        while 0 < loc[1] <= size(board, 1) && 0 < loc[2] <= size(board, 2)
            # println(board[loc[1], loc[2]]);
            if board[loc[1], loc[2]] == '#'
                count += 1;
                break;
            elseif board[loc[1], loc[2]] == 'L'
                break;
            end

            loc .+= dir;
        end
    end

    return count;
end

function SimulateSeating(startState)
    simulating = true;
    curState = startState;
    nextState = Array{Char}(undef, 96, 91);
    nextState .= curState;
    lastChanges = -1;
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
                elseif curState[i, j] == '#' && nCount >= 5
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
