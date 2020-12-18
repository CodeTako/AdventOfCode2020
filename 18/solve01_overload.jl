# Much hackier / cleverer solution from reddit, porting to Julia

s = open("input.txt") do file
    readlines(file);
end

function DoTheMath(expression)
    newExpr = replace(expression, "*"=>"-");
    - = *;
    return eval(Meta.parse(newExpr));
end

answer = sum(map(DoTheMath, s))
