procedure sol(max_seats, first_station, last_station: integer; stations : Array of integer);
var i : integer;
begin

    for i:=first_station to last_station do
    begin
        if (stations[i] >= max_seats) then
        begin
            writeln('false');
            Exit();
        end;
    end;

    writeln('true');
end;

var
    max_seats : integer;
    first_station : integer;
    last_station : integer;
    stations : Array of integer;
    input_int : integer;
    i : integer;
begin
    // get input
    read(max_seats);
    read(first_station);
    read(last_station);

    i:=-1;
    repeat
        read(input_int);
        Inc(i);
        setLength(stations, i + 1);
        stations[i] := input_int;
    until EOLN;

    sol(max_seats, first_station, last_station, stations)
end.