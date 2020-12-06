s = open("input.txt") do file
    read(file, String);
end

groups = split(s,"\n\n");

function GetQuestionCount(group)
    questions = Set(replace(group, "\n"=>""));
    return length(questions);
end

sum(map(GetQuestionCount, groups))
