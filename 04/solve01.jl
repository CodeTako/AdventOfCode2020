s = open("input.txt") do file
    read(file, String)
end

passports = split(s, "\n\n");

function ValidPassport(passport)
    requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    for field in requiredFields
        if !occursin(field*":", passport)
            return 0;
        end
    end

    return 1;
end

sum(map(ValidPassport, passports))
