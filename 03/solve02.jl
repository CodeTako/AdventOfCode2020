s = open("input.txt") do file
    readlines(file)
end

function CountTrees(lines, deltax, deltay)
    treeCount = 0;

    repeat = length(lines[1]);
    x = 1 + deltax;
    i = 1 + deltay;
    while i <= length(lines)
        if lines[i][x] == '#'
            treeCount += 1;
        end
        x = ((x + deltax - 1) % (repeat)) + 1;
        i += deltay;
    end

    return treeCount;
end

mult = 1;
mult *= CountTrees(s, 1, 1);
mult *= CountTrees(s, 3, 1);
mult *= CountTrees(s, 5, 1);
mult *= CountTrees(s, 7, 1);
mult *= CountTrees(s, 1, 2);
mult
