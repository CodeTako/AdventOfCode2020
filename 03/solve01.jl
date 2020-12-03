s = open("input.txt") do file
    readlines(file)
end

function CountTrees(lines)
    treeCount = 0;

    repeat = length(lines[1]);
    x = 4;
    for i = 2:length(lines)
        println(x);
        if lines[i][x] == '#'
            treeCount += 1;
        end
        x = ((x+2) % (repeat)) + 1
    end

    return treeCount;
end

CountTrees(s)
