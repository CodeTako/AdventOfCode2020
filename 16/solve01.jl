s = open("input.txt") do file
    read(file, String);
end

parts = split(s, "\n\n");

rules = split(parts[1],"\n")[2:end];
myticket = parts[2];
otherTickets = split(parts[3],"\n")[2:end];

function GetValidRanges(rules)
    validRanges = [];

    for rule in rules
        m = match(r": (\d+)-(\d+) or (\d+)-(\d+)", rule);
        nums = map(x->parse(Int,x), m.captures);
        push!(validRanges, nums[1:2])
        push!(validRanges, nums[3:4])
    end

    return validRanges;
end

function CheckTickets(ranges, tickets)
    scanningError = 0;
    for ticket in tickets
        if length(ticket) == 0
            continue
        end

        vals = map(x->parse(Int,x), split(ticket,","));

        for val in vals
            valid = false;
            for range in ranges
                if range[1] <= val <= range[2]
                    valid = true;
                    break;
                end
            end

            if !valid
                scanningError += val;
            end
        end
    end

    println(scanningError);
    return scanningError;
end

validRanges = GetValidRanges(rules);

ans = CheckTickets(validRanges, otherTickets)
