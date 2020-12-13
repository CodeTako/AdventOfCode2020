s = open("input.txt") do file
    readlines(file);
end

startTime = parse(Int, s[1])

nums = split(s[2], ',');
getnums = function(x)
    if x == "x"
        return -1;
    else
        return parse(Int, x);
    end
end
busNums = map(getnums, nums);

notX = busNums.!=-1;
routeNums = busNums[notX];

cur = zeros(length(routeNums));

while all(cur .< startTime)
    cur .+= routeNums;
end

final = maximum(cur);
index = findall(x->x>=startTime, cur)

routeNums[3] * (final-startTime)
