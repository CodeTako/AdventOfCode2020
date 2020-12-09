s = open("input.txt") do file
    readlines(file);
end

function RunProgramUntilRepeat(program)
    seen = Set()

    i = 1;
    acc = 0;
    while !in(i, seen) && i <= length(program)
        push!(seen, i);
        parts = split(program[i], " ");

        cmd = parts[1];
        num = parse(Int, parts[2]);

        if cmd == "nop"
            i += 1;
        elseif cmd == "acc"
            acc += num;
            i += 1;
        elseif cmd == "jmp"
            i += num
        end
    end

    if i == length(program) + 1
        return acc
    end

    return -999999;
end

function FixProgram(program)
    for i = 1:length(program)
        if occursin("nop", program[i])
            program[i] = replace(program[i], "nop"=>"jmp");
            val = RunProgramUntilRepeat(program);

            if val != -999999
                return val
            end
            program[i] = replace(program[i], "jmp"=>"nop");

        elseif occursin("jmp", program[i])
            program[i] = replace(program[i], "jmp"=>"nop");
            val = RunProgramUntilRepeat(program);

            if val != -999999
                return val
            end
            program[i] = replace(program[i], "nop"=>"jmp");
        end
    end
end

FixProgram(s)
