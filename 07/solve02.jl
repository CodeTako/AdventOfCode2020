s = open("input.txt") do file
    readlines(file);
end

function ParseRule(rule)
    m = match(r"(\w+) (\w+) bags contain", rule);

    color = m.captures[1] * " " * m.captures[2];

    bags = [];
    counts = [];
    for m in eachmatch(r"(\d+) (\w+) (\w+) bag", rule)
        push!(bags, join(m.captures[2:3], " "))
        push!(counts, parse(Int, m.captures[1]))
    end

    return (color, bags, counts);
end

function CreateColorGraph(lines)
    bagGraph = Dict();
    for line in lines
        rule = ParseRule(line);

        bagGraph[rule[1]] = (rule[2], rule[3]);
    end

    return bagGraph;
end

graph = CreateColorGraph(s);


function GetContentCount(color, seen)
    contents = graph[color];
    colors = contents[1];
    counts = contents[2];

    myCount = 0;

    for i = 1:length(colors)
        if haskey(seen, colors[i])
            myCount += counts[i] * (1 + seen[colors[i]]);
        else
            childCount = GetContentCount(colors[i], seen);
            myCount += counts[i] * (1 + childCount);
        end
    end

    seen[color] = myCount;
    return myCount;
end

seen = Dict();
GetContentCount("shiny gold", seen)
