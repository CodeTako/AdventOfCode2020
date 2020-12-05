s = open("input.txt") do file
    readlines(file)
end

function GetID(seatCode)
    charArr = seatCode |> collect;
    binString = String(map(x->ifelse(x=='F','0','1'),charArr[1:7]));


    row = parse(Int, binString, base=2);

    binString = String(map(x->ifelse(x=='L','0','1'),charArr[8:10]));
    col = parse(Int, binString, base=2);

    return row * 8 + col;
end

foundSeats = zeros(930);

for seat in s
    foundSeats[GetID(seat)] = 1;
end

for i = 2:929
    if foundSeats[i] == 0 && foundSeats[i-1] == 1 && foundSeats[i+1] == 1
        println(i)
    end
end
