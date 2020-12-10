s = open("input") do file
    readlines(file);
end

nums = map(x->parse(Int, x), s);

sort!(nums);

function GetDist(nums)
    counts = [0, 0, 0];
    last = 0;
    for i = 1:length(nums)
        dif = nums[i] - last;
        counts[dif] += 1;
        last = nums[i];
    end

    counts[3] += 1;

    return counts;
end

dist = GetDist(nums);

dist[1] * dist[3]
