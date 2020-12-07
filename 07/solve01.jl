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

        for i = 1:length(rule[2])
            color = rule[2][i];
            count = rule[3][i];
            push!(get!(bagGraph, color, []), (rule[1], count));
        end
    end

    return bagGraph;
end

graph = CreateColorGraph(s);

colorStack = ["shiny gold"];
seen = Set();

while length(colorStack) > 0
    curColor = pop!(colorStack);
    parent = graph[curColor];
    for parentColor in parent
        if in(parentColor[1], seen)
            continue;
        end

        push!(seen, parentColor[1]);

        if !haskey(graph, parentColor[1])
            continue
        end

        push!(colorStack, parentColor[1]);
    end
end

println(length(seen));
