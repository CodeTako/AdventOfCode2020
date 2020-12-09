s = open("input.txt") do file
    readlines(file);
end

function RunProgramUntilRepeat(program)
    seen = Set()

    i = 1;
    acc = 0;
    while !in(i, seen)
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

    return acc
end

RunProgramUntilRepeat(s)
