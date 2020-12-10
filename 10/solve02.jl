s = open("input") do file
    readlines(file);
end

nums = map(x->parse(Int, x), s);

sort!(nums);

function GetPathCount(nums)
    if nums[1] != 0
        pushfirst!(nums, 0);
    end

    combos = ones(Int128, length(nums));
    for i = 2:length(nums)
        count::Int128 = combos[i-1];
        for j = i-3:i-2
            if j > 0
                if nums[i] - nums[j] <= 3
                    count += combos[j];
                end
            end
        end

        combos[i] = max(1, count);
    end

    return combos[end];
end

println(GetPathCount(nums))
