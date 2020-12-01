s = open("input") do file
    readlines(file)
end

nums = map(x->parse(Int64,x), s);

lookingFor = Set();

for num in nums
    if(in(num, lookingFor))
        println(num * (2020-num));
        break;
    end

    push!(lookingFor, 2020-num);
end
