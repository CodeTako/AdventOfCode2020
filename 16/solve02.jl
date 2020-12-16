s = open("input.txt") do file
    read(file, String);
end

parts = split(s, "\n\n");

rules = split(parts[1],"\n")[1:end];
myticket = split(parts[2],"\n")[2];
otherTickets = split(parts[3],"\n")[2:end];

function GetFields(rules)
    fields = Dict();

    for rule in rules
        m = match(r"([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)", rule);
        name = m.captures[1];
        nums = map(x->parse(Int,x), m.captures[2:end]);

        fields[name] = nums;
    end

    return fields;
end

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

function CheckValidTickets(ranges, tickets)
    validTickets = falses(length(tickets));

    for i = 1:length(tickets)
        ticket = tickets[i]
        if length(ticket) == 0
            continue
        end

        vals = map(x->parse(Int,x), split(ticket,","));
        validTicket = true;
        for val in vals
            valid = false;
            for range in ranges
                if range[1] <= val <= range[2]
                    valid = true;
                    break;
                end
            end

            if !valid
                validTicket = false;
                break;
            end
        end

        validTickets[i] = validTicket;
    end

    return validTickets;
end

function CouldBeField(x, ranges)
    return ranges[1] <= x <= ranges[2] || ranges[3] <= x <= ranges[4]
end

function GetFieldOrder(tickets, fields)
    ticketNums = vcat(map(x->map(y->parse(Int,y),split(x,",")), tickets)...);
    ticketNums = reshape(ticketNums, (length(fields),length(tickets)));

    fieldOrder = [];

    for i = 1:length(fields)
        col = ticketNums[i,:];

        possibles = [];
        for (field, ranges) in fields
            if all(map(x->CouldBeField(x, ranges), col))
                push!(possibles, field)
            end
        end

        push!(fieldOrder, possibles);
    end

    println(fieldOrder)
    println(map(x->length(x), fieldOrder))
    return fieldOrder;
end

function DetermineFields!(allFieldPossibilities)
    lens = map(x->length(x), allFieldPossibilities);
    smallToBig = sortperm(lens);

    taken = Set()
    for i = 1:length(smallToBig)
        index = smallToBig[i];
        options = allFieldPossibilities[index];

        trueOptions = []
        for opt in options
            if !in(opt, taken)
                push!(trueOptions, opt);
            end
        end

        if length(trueOptions) == 1
            allFieldPossibilities[index] = trueOptions[1];
            push!(taken, trueOptions[1]);
        end

    end

    println(allFieldPossibilities)
    return allFieldPossibilities
end

validRanges = GetValidRanges(rules);
fields = GetFields(rules);

validTickets = CheckValidTickets(validRanges, otherTickets);

trueTickets = otherTickets[validTickets];

possibles = GetFieldOrder(trueTickets, fields);

realOrder = DetermineFields!(possibles);

myTicketVals = map(x->parse(Int,x), split(myticket,","));

departures = map(x->occursin("departure", x), realOrder);
answer = *(myTicketVals[departures]...)
