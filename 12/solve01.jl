s = open("input.txt") do file
    readlines(file);
end

function FollowPath(instructions)
    pos = [0,0];
    dir = 1;
    directions = [
        [1,0], [0,-1], [-1, 0], [0, 1]
    ];
    for command in instructions
        action = command[1];
        num = parse(Int, command[2:end]);

        if action == 'F'
            pos .+= directions[dir].*num;
        elseif action == 'N'
            pos .+= directions[4]*num;
        elseif action == 'S'
            pos .+= directions[2]*num;
        elseif action == 'E'
            pos .+= directions[1]*num;
        elseif action == 'W'
            pos .+= directions[3]*num;
        elseif action == 'R'
            dir += Int(num/90);
            while dir > 4
                dir -= 4;
            end
        elseif action == 'L'
            dir -= Int(num/90);
            while dir < 1
                dir += 4;
            end
        end
    end

    return sum(abs.(pos));
end

FollowPath(s)
