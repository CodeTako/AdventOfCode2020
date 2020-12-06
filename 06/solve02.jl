s = open("input.txt") do file
    read(file, String);
end

groups = split(s,"\n\n");

function GetQuestionCount(group)
    people = split(strip(group),"\n");
    
    questions = Set(people[1]);

    for i = 2:length(people)
        intersect!(questions, Set(people[i]));
    end

    return length(questions);
end

sum(map(GetQuestionCount, groups))
