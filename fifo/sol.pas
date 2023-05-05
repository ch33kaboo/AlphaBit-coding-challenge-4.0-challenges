procedure sol(capacity: integer; items : Array of integer);
    var current_capacity : integer;
        oldest_index : integer;
        item : integer;
begin
    current_capacity := 0;
    oldest_index := 0;

    for item in items do
    begin
        while(current_capacity + item > capacity) do
        begin
            current_capacity := current_capacity - items[oldest_index];
            Inc(oldest_index);
        end;

        current_capacity := current_capacity + item;
    end;

    writeln(current_capacity);
    writeln(oldest_index);
end;

var
    capacity : integer;
    items : Array of integer;
    input_int : integer;
    i : integer;
begin
    // read capacity, items
    read(capacity);

    i:=-1;
    repeat
        read(input_int);
        Inc(i);
        setLength(items, i + 1);
        items[i] := input_int;
    until EOLN;

    sol(capacity, items)
end.