

function PlayGame(startingStr, endStep)
    startingNums = map(x->parse(Int, x),split(startingStr,","));

    memory = Dict{Int128, Int128}();
    currentStep::Int128 = 1;

    for num in startingNums
        memory[num] = currentStep;
        currentStep += 1;
    end

    lastNum = Int128(startingNums[end]);
    seenBefore::Int128 = -1;

    while currentStep <= endStep
        curNum::Int128 = 0;

        if seenBefore > 0
            curNum = currentStep - seenBefore - 1;
            seenBefore = -1;
        end
        #println("$(currentStep) $(curNum)");

        if haskey(memory, curNum)
            seenBefore = memory[curNum];
        end

        memory[curNum] = currentStep;
        currentStep += 1;
        lastNum = curNum;
    end

    println(lastNum);
    return lastNum;
end

PlayGame("0,3,6", 10);
PlayGame("1,3,2", 2020);

answer = PlayGame("9,6,0,10,18,2,1", 30000000)
