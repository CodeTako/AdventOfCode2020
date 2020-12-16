nums = map(x->parse(Int, x),split("9,6,0,10,18,2,1",","))

function PlayGame(startingStr, endStep)
    startingNums = map(x->parse(Int, x),split(startingStr,","));

    memory = Dict();
    currentStep = 1;

    for num in startingNums
        memory[num] = currentStep;
        currentStep += 1;
    end

    lastNum = startingNums[end];
    seenBefore = -1;

    while currentStep <= endStep
        curNum = 0;

        if seenBefore > 0
            curNum = currentStep - seenBefore - 1;
            seenBefore = -1;
        end
        # println("$(currentStep) $(curNum)");

        if haskey(memory, curNum)
            seenBefore = memory[curNum];
        end

        memory[curNum] = currentStep;
        currentStep += 1;
        lastNum = curNum;
    end

    println(lastNum);
end

PlayGame("0,3,6", 10);
PlayGame("1,3,2", 2020);

PlayGame("9,6,0,10,18,2,1", 2020)
