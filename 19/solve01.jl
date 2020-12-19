s = open("input.txt") do file
    readlines(file);
end

t = open("test.txt") do file
    readlines(file);
end

function ParseRules(lines)
    rules = Dict();

    for line in lines
        if length(line) < 2
            break;
        end

        parts = split(line, ": ");
        id = parse(Int, parts[1]);
        options = []

        if occursin("|", parts[2])
            ruleBits = split(parts[2]," | ")
        else
            ruleBits = [parts[2]]
        end

        m = match(r"\"([ab])\"", line);
        if m != nothing
            # This is a base rule
            push!(options, String(m.captures[1]));
        else
            println(ruleBits);
            options = map(x->map(y->parse(Int,y), split(x)), ruleBits);
        end

        rules[id] = options;
    end

    return rules;
end

function SolveRule!(id, rules, solved)
    if haskey(solved, id)
        return;
    end

    # println(id);
    r = rules[id];
    # println(r);
    if length(r) == 1 && typeof(r[1]) == String
        solved[id] = r[1];
        return;
    else
        for ruleOpt in r
            for rule in ruleOpt
                SolveRule!(rule, rules, solved);
            end
        end

        trueForms = map(rule -> map(x->solved[x], rule), r);
        # println(trueForms)
        if length(r) == 2
            part1 = *(trueForms[1]...);
            part2 = *(trueForms[2]...);
            newRule = "("*part1*"|"*part2*")";
        else
            newRule = *(trueForms[1]...);
        end

        solved[id] = newRule;
        println("$(id):$(r) => $(newRule)");
    end
end

function SolveAllRules(rules)
    solved = Dict();
    SolveRule!(0, rules, solved);

    println(length(solved));
    return (Regex("^"*solved[0]*"\$"), solved);
end

rules = ParseRules(s)
(realRule, solved) = SolveAllRules(rules)

messages = s[length(rules)+2:end]
uncorrupt = GetCount(messages, realRule)

# test
# rules_t = ParseRules(t)
# realRule_t = GetFinalRule(rules_t)
# realRule_t = Regex("^"*rules_t[0]*"b\$");
#
# messages_t = t[length(rules_t)+2:end]
# uncorrupt_t = map(x->occursin(realRule_t, x), messages_t)
