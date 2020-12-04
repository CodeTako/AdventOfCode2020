s = open("input.txt") do file
    read(file, String)
end

passports = split(s, "\n\n");

function ValidPassport(passport)
    requiredFields = [
        r"byr:(19[2-9]\d|200[0-2])(\s|$)",
        r"iyr:20(1\d|20)(\s|$)",
        r"eyr:20(2\d|30)(\s|$)",
        r"hgt:(1([5-8]\d|9[0-3])cm|(59|6\d|7[0-6])in)(\s|$)",
        r"hcl:#[0-9a-f]{6}(\s|$)",
        r"ecl:(amb|blu|brn|gry|grn|hzl|oth)(\s|$)",
        r"pid:\d{9}(\s|$)"
    ];

    for field in requiredFields
        if !occursin(field, passport)
            return 0;
        end
    end

    return 1;
end

sum(map(ValidPassport, passports))
ValidPassport("eyr:1972 cid:100\nhcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926")

ValidPassport("iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946")

ValidPassport("hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277")

ValidPassport("hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007")

ValidPassport("pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f")

ValidPassport("eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm")

ValidPassport("hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022")

ValidPassport("iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719")

    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    # hgt (Height) - a number followed by either cm or in:
    #     If cm, the number must be at least 150 and at most 193.
    #     If in, the number must be at least 59 and at most 76.
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    # cid (Country ID) - ignored, missing or not.
