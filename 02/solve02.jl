s = open("input.txt") do file
    readlines(file)
end

function getGoodCount(s)
    goodCount = 0;
    for line in s
        m = match(r"(\d+)-(\d+) (.): (.*)", line);

        pos1 = parse(Int32, m.captures[1]);
        pos2 = parse(Int32, m.captures[2]);
        letter = Char(m.captures[3][1]);

        password = m.captures[4];

        if (password[pos1] == letter) ⊻ (password[pos2] == letter)
            goodCount += 1;
        end
    end

    return goodCount;
end

println(getGoodCount(s));
