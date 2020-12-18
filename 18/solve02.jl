s = open("input.txt") do file
    readlines(file);
end

function EvalExpression(expr)
    # println("=====")
    # println(expr);
    newExp = expr;
    m = match(r"(\d+) \+ (\d+)", expr)
    while m != nothing
        println(m.captures);
        val = parse(Int, m.captures[1]) + parse(Int, m.captures[2]);
        newExp = replace(newExp, string(m.match)=>"$(val)", count=1);

        m = match(r"(\d+) \+ (\d+)", newExp)
    end

    # println(newExp)

    nums = [];
    for m in eachmatch(r"\d+", newExp)
        push!(nums, parse(Int, m.match));
    end
    # println(nums);
    return *(nums...);
end

function DoTheMath(expression)
    println(expression);
    expressionStack = [];
    currentExpr = "";
    for i = 1:length(expression)
        if expression[i] == '('
            push!(expressionStack, currentExpr);
            currentExpr = "";
        elseif expression[i] == ')'
            val = EvalExpression(currentExpr);
            currentExpr = pop!(expressionStack) * "$(val)";
        else
            currentExpr *= string(expression[i])
        end
    end
    # println(currentExpr);

    val = EvalExpression(currentExpr);
    # println(val)
    # println("----------")
    return Int128(val);
end

eachAns = map(DoTheMath, s);

answer = sum(eachAns)
