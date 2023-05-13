function minNonZero(arr : Array of integer):integer;
    var min_index : integer;
        i : integer;
begin

    // find min non zero index
    min_index := -1;
    for i:=0 to Length(arr) - 1 do
        if (arr[i] <> 0) and((min_index = -1) or (arr[i] < arr[min_index])) then
            min_index := i;
    minNonZero := min_index;
end;

function sol(capacity: integer; weights : Array of integer; usess : Array of integer):integer;
    var frequencyMap : Array of integer;
        use : integer;
        current_capacity : integer;
        min_index : integer;
begin
    setLength(frequencyMap, Length(weights));
    current_capacity := 0;

    for use in usess do
    begin
        if frequencyMap[use] = 0 then
        begin
            while(current_capacity + weights[use] > capacity) do
            begin
                min_index := minNonZero(frequencyMap);
                frequencyMap[min_index] := 0;
                current_capacity := current_capacity - weights[min_index];
            end;
            current_capacity := current_capacity + weights[use];
        end;
        frequencyMap[use] := frequencyMap[use] + 1;
    end;

    sol:= current_capacity;
end;

var
    capacity : integer;
    weights : Array of integer;
    usess : Array of integer;
    input_int : integer;
    i : integer;
begin
    // read capacity, weights and uses
    read(capacity);

    i:=-1;
    repeat
        read(input_int);
        Inc(i);
        setLength(weights, i + 1);
        weights[i] := input_int;
    until EOLN;

    i:=-1;
    repeat
        read(input_int);
        Inc(i);
        setLength(usess, i + 1);
        usess[i] := input_int;
    until EOLN;

    writeln(sol(capacity, weights, usess));
end.