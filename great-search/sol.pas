program sol;

VAR
    caches: array of longint;
    datas: array of array of longint;
    max_itter, total, i, j, data_length, rank, temp2 : integer;
    temp, line, operande: string;

FUNCTION max(a, b: longint): longint;
    BEGIN
        if a > b then
            max := a
        else
            max := b;
    END;

FUNCTION min(a, b: longint): longint;
    BEGIN
        if a < b then
            min := a
        else
            min := b;
    END;

FUNCTION fn(a, b: longint): longint;
    BEGIN
        case operande of
            '*': fn := a * b;
            '+': fn := a + b;
            'max': fn := max(a, b);
            'min': fn := min(a, b);
        end;
    END;

FUNCTION calc(a,b: longint):longint;
    BEGIN
        if (a<0) then
            BEGIN
                calc := a+b;
                exit;
            END;
        calc := a;
    END;


FUNCTION countNegOnes(arr: array of longint): integer;
    VAR
    i, count: integer;
    BEGIN
    count := 0;
        for i := 0 to High(arr) do
            if arr[i] = -1 then
                count := count + 1;
        CountNegOnes := count;
    END;

PROCEDURE sendToNext(currentProcessRank, dest_rank, dataIndex:integer);
    BEGIN
    caches[dest_rank] := datas[currentProcessRank][dataIndex];
    datas[currentProcessRank][dataIndex] := -1;  // assume -1 means no data
    END;

PROCEDURE share(currentProcessRank, dest_rank, dataIndex:integer);
    BEGIN
        datas[dest_rank][dataIndex] := datas[currentProcessRank][dataIndex];
    END;

PROCEDURE solve();
    VAR
        j, rank, right, temp, current_itter: integer;
        bool: boolean;
    BEGIN
    bool := false;
    j := 0;
    current_itter := 0;
    while (not bool)and(current_itter<max_itter) do
        BEGIN
            current_itter := current_itter +1;
            for rank := 0 to total-1 do
                BEGIN
                    right := (rank + 1) mod total;
                    sendToNext(rank, right, calc(rank-j, data_length));
                    if rank <> 0 then
                        BEGIN
                            datas[rank][calc(rank-j-1, data_length)] := fn(caches[rank], datas[rank][calc(rank-j-1, data_length)]);
                        END;
                    if rank = total-1 then
                        BEGIN
                            datas[0][calc(0-j-1, data_length)] := fn(caches[0], datas[0][calc(0-j-1, data_length)]);
                        END;
                    bool := (countNegOnes(datas[rank]) = data_length-1);
                END;
            j += 1;
        END;

    bool := false;
    j := 0;
    while (not bool)and(current_itter<max_itter) do
        BEGIN
            current_itter := current_itter +1;
            for rank := 0 to total-1 do
                BEGIN
                    right := (rank + 1) mod total;
                    temp := calc(rank-j+1, data_length) mod data_length;
                    share(rank, right, temp);
                END;
            bool := (countNegOnes(datas[rank]) = 0);
            j += 1;
        END;
    END;

PROCEDURE printSolution();
    VAR 
        i, j: longint;
    BEGIN
        for i := 0 to total-1 do
            BEGIN
                write(i);
                for j := 0 to High(datas[i]) do
                    write(' ',datas[i][j]);
                writeln();
            END;
        
    END;


BEGIN
    readln(operande);
    readln(max_itter);
    readln(total);

    SetLength(caches, total);
    SetLength(datas, total);
    for j := 0 to total-1 do
        BEGIN
            rank := -1;
            readln(line);
            temp := '';
            for i := 1 to Length(line) do
                if (line[i] = ' ') or (i = Length(line)) then
                    BEGIN
                        if i = Length(line) then 
                            temp := temp + line[i];
                        Val(temp, temp2);
                        if(rank = -1) then
                            BEGIN
                                rank := temp2;
                                SetLength(datas[rank], 0);
                            END
                        else 
                            BEGIN
                                SetLength(datas[rank], Length(datas[rank])+1);
                                datas[rank][High(datas[rank])] := temp2;
                            END;
                        temp := '';
                    END
                else temp := temp + line[i];
            caches[rank] := datas[rank][rank];
        END;
    data_length := Length(datas[0]);
    
    solve();
    printSolution();
END.