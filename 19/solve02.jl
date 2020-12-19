s = open("input.txt") do file
    readlines(file);
end

t = open("input2.txt") do file
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
#
# function SolveRule!(id, rules, solved)
#     if haskey(solved, id)
#         return;
#     end
#
#     # println(id);
#     r = rules[id];
#     # println(r);
#     if length(r) == 1 && typeof(r[1]) == String
#         solved[id] = r[1];
#         return;
#     else
#         for ruleOpt in r
#             for rule in ruleOpt
#                 SolveRule!(rule, rules, solved);
#             end
#         end
#
#         trueForms = map(rule -> map(x->solved[x], rule), r);
#         # println(trueForms)
#         if length(r) == 2
#             part1 = *(trueForms[1]...);
#             part2 = *(trueForms[2]...);
#             newRule = "("*part1*"|"*part2*")";
#         else
#             newRule = *(trueForms[1]...);
#         end
#
#         solved[id] = newRule;
#         if id == 8
#             solved[id] = solved[id]*"+";
#         end
#
#         println("$(id):$(r) => $(newRule)");
#     end
# end
#
# function SolveAllRules(rules)
#     solved = Dict();
#     SolveRule!(0, rules, solved);
#
#     rules[11] = [[42, 11, 31], [42, 31]];
#
#     println(length(solved));
#     return (Regex("^"*solved[0]*"\$"), solved);
# end

function CheckRule(id, msg, rules)
    r = rules[id];

    if length(r) == 1 && typeof(r[1]) == String
        # base rule of 1 char
        rule = Regex("^"*solved[id]);
        m = match(rule, msg);

        if m == nothing
            return [];
        else
            # println("$(msg) : $(solved[id])");
            return [length(m.match)];
        end
    # elseif id != 11 && depth > 5 && length(r) == 1
    #     rule = Regex("^"*solved[id]);
    #     m = match(rule, msg);
    #     # println("Checking $(msg) vs $(id)");
    #     if m == nothing
    #         return -1;
    #     else
    #         println("$(m.match) : $(id)");
    #         return length(m.match);
    #     end
    else
        opts = [];
        for opt in r
            totalLen = [0]
            for rule in opt
                ruleLen = [];

                for tl in totalLen
                    len = CheckRule(rule, msg[(tl+1):end], rules);

                    if length(len) > 0
                        ruleLen = vcat(ruleLen, len.+tl);
                    end
                end

                totalLen = ruleLen;

                if length(ruleLen) == 0
                    break
                end
            end

            if length(totalLen) > 0
                # for tl in totalLen
                #     println("$(msg[1:tl]) : $(id)");
                # end

                opts = vcat(opts, totalLen);
            end
        end

        # if length(opts) == 0
        #     println("Failed: $(msg) : $(id)")
        # end

        return opts;
    end
end

function GetCount(messages, rules, solved)
    count = 0;
    matched = [];
    for msg in messages
        if any(CheckRule(0, msg, rules) .== length(msg))
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
# (realRule, solved) = SolveAllRules(rules)

rules[11] = [[42, 11, 31], [42, 31]];
rules[8] = [[42], [42, 8]];

messages = s[length(rules)+2:end]
uncorrupt = GetCount(messages, rules, solved)

# test
rules_t = ParseRules(t)
# realRule_t, solved_t = SolveAllRules(rules_t)

rules[11] = [[42, 11, 31], [42, 31]];
rules[8] = [[42], [42, 8]];

messages_t = t[length(rules_t)+2:end]
uncorrupt_t = GetCount(messages_t, rules_t, solved_t)
