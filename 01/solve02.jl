s = open("input") do file
    readlines(file)
end

nums = map(x->parse(Int64,x), s);

lookingFor = Dict();
secondarySum = Set();

for num in nums
    if(haskey(lookingFor, num))
        println(num * lookingFor[num][1] * lookingFor[num][2]);
        break;
    end

    for secondSum in secondarySum
        if secondSum <= num
            continue
        end

        lookingFor[secondSum-num] = [num, 2020-secondSum];
    end

    push!(secondarySum, 2020-num);
end
