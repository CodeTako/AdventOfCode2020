s = open("input.txt") do file
    readlines(file);
end

nums = map(x-> parse(Int, x), s);

invalidNum = 248131121;

function FindRange(nums, invalidNum)
    rangeStart = 1;
    rangeEnd = 2;
    curSum = sum(nums[1:2]);
    next = 3;

    while rangeEnd <= length(nums)
        rangeEnd += 1;
        curSum += nums[rangeEnd];

        while curSum > invalidNum
            curSum -= nums[rangeStart];
            rangeStart += 1;
        end

        if curSum == invalidNum
            return nums[rangeStart:rangeEnd]
        end
    end
end

sumRange = FindRange(nums, invalidNum);
println(minimum(sumRange) + maximum(sumRange))
