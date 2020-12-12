s = open("input.txt") do file
    readlines(file);
end

function FollowPath(instructions)
    pos = [0, 0];
    waypointPos = [10, 1];
    dir = 1;
    directions = [
        [1,0], [0,-1], [-1, 0], [0, 1]
    ];
    for command in instructions
        action = command[1];
        num = parse(Int, command[2:end]);

        if action == 'F'
            pos .+= waypointPos.*num;
        elseif action == 'N'
            waypointPos .+= directions[4]*num;
        elseif action == 'S'
            waypointPos .+= directions[2]*num;
        elseif action == 'E'
            waypointPos .+= directions[1]*num;
        elseif action == 'W'
            waypointPos .+= directions[3]*num;
        elseif action == 'R'
            turns = Int(num/90);
            for i = 1:turns
                waypointPos = [waypointPos[2], -waypointPos[1]];
            end
        elseif action == 'L'
            turns = Int(num/90);
            for i = 1:turns
                waypointPos = [-waypointPos[2], waypointPos[1]];
            end
        end
    end

    return sum(abs.(pos));
end

FollowPath(s)
