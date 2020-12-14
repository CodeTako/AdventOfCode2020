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

function SumMem(program)
    mem = Dict();
    oneMask = 0;
    zeroMask = -1;
    for line in program
        parsed = ParseLine(line);
        if length(parsed) == 0
            println(line);
            continue;
        end

        if length(parsed) == 1
            # new mask
            oneMask = parse(UInt64, String(map(x->ifelse(x=='1', '1', '0'), parsed[1])), base=2);
            zeroMask = parse(UInt64, String(map(x->ifelse(x=='0', '0', '1'), parsed[1])), base=2);
        else
            # put in mem
            val = parsed[2];
            val |= oneMask;
            val &= zeroMask;

            mem[parsed[1]] = val;
        end
    end

    return sum(map(UInt64,values(mem)));
end

println(Int(SumMem(s)))
