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

# function CheckRule(id, msg, rules, solved, depth)
#     r = rules[id];
#
#     if length(r) == 1 && typeof(r[1]) == String
#         rule = Regex("^"*solved[id]);
#         m = match(rule, msg);
#         println("Checking $(msg) vs $(id)");
#         if m == nothing
#             return -1;
#         else
#             println("$(msg) : $(id)");
#             return length(m.match);
#         end
#     elseif depth > 5 && length(r) < 4
#         rule = Regex("^"*solved[id]);
#         m = match(rule, msg);
#         println("Checking $(msg) vs $(id)");
#         if m == nothing
#             return -1;
#         else
#             println("$(msg) : $(id)");
#             return length(m.match);
#         end
#     else
#         len = CheckRule(r[1], msg, rules, solved, depth+1);
#         if len > 0
#             len2 = CheckRule(r[2], msg[len+1:end], rules, solved, depth+1);
#
#             if len2 > 0
#                 println("$(msg) : $(id)");
#                 return len + len2;
#             end
#         end
#
#         if length(r) < 3
#             return -1
#         end
#
#         len = CheckRule(r[3], msg, rules, solved, depth+1);
#         if len > 0
#             len2 = CheckRule(r[4], msg[len+1:end], rules, solved, depth+1);
#
#             if len2 > 0
#                 println("$(msg) : $(id)");
#                 return len + len2;
#             end
#         end
#
#         return -1;
#     end
# end

function GetCount(messages, rule)
    count = 0;
    matched = [];
    for msg in messages
        if occursin(rule, msg)
            count += 1;
            push!(matched, true)
        else
            push!(matched, false)
        end
    end

    println(">>>> $(count)");
    return matched;
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
