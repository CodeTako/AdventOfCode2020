s = open("input.txt") do file
    readlines(file);
end

startTime = parse(Int, s[1]);

nums = split(s[2], ',');
offsets = findall(x->x!="x", nums) .- 1;
busNums = map(x->parse(Int,x), nums[offsets.+1]);

function FindNextMatchup(startTime, iter, offset, num)
    curTime = startTime;
    while (curTime+offset)%num != 0
        curTime += iter;
    end
    println((curTime, iter*num));
    return (curTime, iter*num);
end

function GetPatternTime(start, startIter, indOrder, offsets, nums)
    iter = startIter;
    time = start;
    for i = 1:length(indOrder)
        curInd = indOrder[i];
        time, iter = FindNextMatchup(time, iter, offsets[curInd], nums[curInd]);
    end

    return (time, iter);
end

function CheckTime(time, offsets, nums)
    println(time);
    times = offsets .+ time;
    mods = times.%nums;
    println(mods);

    return all(mods.==0);
end

startTime = 100000000000000;
while startTime % busNums[1] != 0
    startTime += 1
end

# The start time came from past brute force efforts,
# But you could just use the above
sortedIndices = sortperm(busNums[2:end]);
theTime, bigIter = GetPatternTime(141883788274894, busNums[1], sortedIndices, offsets[2:end], busNums[2:end]);
CheckTime(theTime, offsets, busNums)
