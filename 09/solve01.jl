s = open("input.txt") do file
    readlines(file);
end

nums = map(x-> parse(Int, x), s);

preambleLength = 25;

function ValidNum(nums, i)
    lookingFor = Set();
    for j = i-preambleLength:i-1
        if in(nums[j], lookingFor)
            return true;
        end

        if nums[i] - nums[j] > 0
            push!(lookingFor, nums[i] - nums[j])
        end
    end

    return false;
end

for i = preambleLength+1:length(nums)
    if !ValidNum(nums, i)
        println(nums[i])
    end
end
