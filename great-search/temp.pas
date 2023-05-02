program sol;

TYPE
    IntList = array of integer;
    Process = record
        rank: integer;
        data: IntList;
        cache: integer;
    end;
    WorkersArray = array of Process;


FUNCTION countNegOnes(arr: array of integer): integer;
    VAR
    i, count: integer;
    BEGIN
    count := 0;
        for i := 0 to High(arr) do
            if arr[i] = -1 then
                count := count + 1;
        CountNegOnes := count;
    END;

FUNCTION isEqualProcesses(a, b: Process): Boolean;
    VAR 
        i:integer;
    BEGIN
        if ((a.rank <> b.rank) or (Length(a.data) <> Length(b.data))) or (a.cache <> b.cache) then
            BEGIN
                isEqualProcesses := false;
                exit;
            END;

        for i := 0 to High(a.data) do
            BEGIN
                if a.data[i] <> b.data[i] then
                    BEGIN
                        isEqualProcesses := false;
                        exit;
                    END;
            END;
        isEqualProcesses := true;
    END;

FUNCTION getWorker(workers: WorkersArray; rank: Integer): integer;
    VAR
        i: Integer;
    BEGIN
        for i := 0 to High(workers) do
            if workers[i].rank = rank then
                BEGIN
                    getWorker := i;
                    exit;
                exit;
            END;
        getWorker := -1
    END;

FUNCTION stringToList(input: string): IntList;
    VAR
        i, e: integer;
        temp: string;
        result: IntList;
    BEGIN
        SetLength(result, 0);
        temp := '';
        for i := 1 to Length(input) do
        if (input[i] = ' ') or (i = Length(input)) then
            BEGIN
            if i = Length(input) then temp := temp + input[i];
            SetLength(result, Length(result)+1);
            Val(temp, e);
            result[High(result)] := e;
            temp := '';
            END
        else temp := temp + input[i];
        stringToList := result;
    END;
  
FUNCTION createWorkers(): WorkersArray;
    VAR
        total: integer;
        tempArr: IntList;
        i, j: integer;
        workers: WorkersArray;
        line: string;
    BEGIN
        readln(total);
        SetLength(workers, total);
        for i := 0 to total-1 do
        BEGIN
            readln(line);
            tempArr := stringToList(line);
            workers[i].rank := tempArr[0];
            SetLength(workers[i].data, Length(tempArr)-1);
            for j := 1 to High(tempArr) do
                workers[i].data[j] := tempArr[j];
            workers[i].cache := workers[i].data[tempArr[0]]
        END;
        createWorkers := workers;
    END;

PROCEDURE sendToNext(var workers: WorkersArray; var currentProcess: Process; dest_rank, dataIndex: Integer);
    VAR
        nextWorkerIndex: integer;
    BEGIN
    nextWorkerIndex := getWorker(workers, dest_rank);
    workers[nextWorkerIndex].cache := currentProcess.data[dataIndex];
    currentProcess.data[DataIndex] := -1;  // assume -1 means no data
    END;

FUNCTION recv(currentProcess: Process): integer;
    BEGIN
    recv := currentProcess.cache;
    END;

PROCEDURE share(var workers: WorkersArray; var currentProcess: Process; dest_rank, dataIndex: Integer);
    VAR
        nextWorkerIndex: integer;
    BEGIN
        nextWorkerIndex := getWorker(workers, dest_rank);
        workers[nextWorkerIndex].data[dataIndex] := currentProcess.data[dataIndex];
    END;

FUNCTION solve(workers: WorkersArray): WorkersArray;
    VAR
        size, j, k, r, rank, right, idx, p, temp, first_p: integer;
        all_reduced, shared: boolean;
        recieved: integer;
    BEGIN
    size := length(workers);
    all_reduced := false;
    shared := false;
    j := 0;

    writeln('========Share-reduce phase========');
    readln();
    while not all_reduced do
        BEGIN
            for r := 0 to size-1 do
                BEGIN
                    p := getWorker(workers, r);
                    rank := workers[p].rank;
                    right := (rank + 1) mod size;
                    temp := getWorker(workers, right);
                    sendToNext(workers, workers[temp], right, rank-j);
                    if rank <> 0 then
                        BEGIN
                            temp := getWorker(workers, rank-1);
                            recieved := recv(workers[temp]);
                            writeln('worker ', r, ' ', recieved, '+', workers[p].data[rank-j-1]);
                            readln();
                            workers[p].data[rank-j-1] := recieved + workers[p].data[rank-j-1];
                            //writeln(workers[p].da);
                            readln();
                        END;
                    if rank = size-1 then
                        BEGIN
                            first_p := getWorker(workers, 0);
                            recieved := recv(workers[first_p]);
                            writeln('worker ', workers[first_p].rank, ' ', recieved, '+', workers[first_p].data[0-j-1]);
                            readln();
                            workers[first_p].data[0-j-1] := recieved + workers[first_p].data[0-j-1];
                            writeln(workers[first_p].data);
                            readln();
                        END;
                    all_reduced := (Length(workers[p].data)-1 = countNegOnes(workers[p].data));
                END;
            j += 1;
            writeln('========================');
            readln();
        END;

    // Share-only phase
    writeln('========Share-only phase========');
    readln();
    k := 0;
    while not shared do
        BEGIN
             {for r := 0 to size-1 do
                BEGIN
                    p := getWorker(workers, r);
                    writeln('worker ', r, ': ', p.data);
                END; }
            for r := 0 to size-1 do
                BEGIN
                p := getWorker(workers, r);
                rank := workers[p].rank;
                right := (rank + 1) mod size;
                idx := (rank+1-k) mod Length(workers[p].data);
                temp := getWorker(workers, right);
                share(workers, workers[p], right, idx);
                END;
            shared := (countNegOnes(workers[p].data) = 0);
            k += 1;
            writeln('========================');
            readln();
        END;
    solve := workers;
    END;


PROCEDURE printSolution(workers: WorkersArray);
    VAR 
        i, j: integer;
    BEGIN
        for i := 0 to High(workers) do
            BEGIN
                write(workers[i].rank, ' ');
                for j := 0 to High(workers[i].data) do
                    write(workers[i].data[j], '-');
                writeln()
            END;
    END;

VAR
    input, result: WorkersArray;
BEGIN
    input := createWorkers();
    writeln('------------------------------------------');
    printSolution(input);
    writeln('------------------------------------------');
    result := solve(input);
    printSolution(result);
END.