s = open("input.txt") do file
    readlines(file)
end

function getCount(password, letter::Char)
    count = 0;
    for i = 1:length(password)
        if password[i] == letter
            count += 1;
        end
    end

    return count;
end

function getGoodCount(s)
    goodCount = 0;
    for line in s
        m = match(r"(\d+)-(\d+) (.): (.*)", line);

        minCount = parse(Int32, m.captures[1]);
        maxCount = parse(Int32, m.captures[2]);
        letter = Char(m.captures[3][1]);

        password = m.captures[4];

        count = getCount(password, letter);

        if minCount <= count <= maxCount
            goodCount += 1;
        end
    end

    return goodCount;
end

println(getGoodCount(s));
