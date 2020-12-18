s = open("input.txt") do file
    readlines(file);
end

function EvalExpression(expr)
    parts = split(expr, " ");
    curVal = parse(Int, parts[1])

    i = 2;
    while i <= length(parts)
        op = parts[i];
        num = parse(Int, parts[i+1]);

        if op == "+"
            curVal += num;
        else
            curVal *= num;
        end

        i += 2;
    end

    return curVal
end

function DoTheMath(expression)
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

    val = EvalExpression(currentExpr);
    return val;
end

answer = sum(map(DoTheMath, s))
