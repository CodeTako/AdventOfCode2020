s = open("input.txt") do file
    readlines(file);
end

function ParseLine(line)
    m = match(r"mem\[(\d+)\] = (\d+)", line);
    if m != nothing
        return map(x->parse(UInt64,x), m.captures);
    end

    m = match(r"mask = ([01X]+)", line);
    if m != nothing
        return (m.captures|>collect);
    end

    return ();
end

function SetAllAddresses(address, val, mask, mem)
    numX = sum(mask);
    toSet = findall(x->x==1, mask).+28;
    bAddress = bitstring(address)|>collect;

    # println(mask);
    # println(toSet)
    # println(numX);

    for i::UInt64 = 1:2^numX
        bAddress = bitstring(address)|>collect;
        bAddress[toSet] .= collect(bitstring(i))[end-numX+1:end];
        # println(String(bAddress));
        tempAddress = parse(UInt64, String(bAddress), base=2);
        mem[tempAddress] = val;
    end
    # println("Set to $(val)");
end

function SumMem(program)
    mem = Dict();
    oneMask = 0;
    xMask = -1;
    for line in program
        parsed = ParseLine(line);
        if length(parsed) == 0
            println(line);
            continue;
        end

        if length(parsed) == 1
            # new mask
            oneMask = parse(UInt64, String(map(x->ifelse(x=='1', '1', '0'), parsed[1])), base=2);
            xMask = map(x->ifelse(x=='X', 1, 0), parsed[1]|>collect);
            # println(parsed[1]);
        else
            # put in mem
            address = parsed[1];
            address |= oneMask;

            SetAllAddresses(address, parsed[2], xMask, mem);
        end
    end

    return sum(map(UInt64,values(mem)));
end

println(Int(SumMem(s[1:2])))
println(Int(SumMem(s)))
