program sol;

TYPE
    IntList = array of integer;
    Process = record
        rank: integer;
        data: IntList;
        cache: integer;
    end;
    WorkersType = record
        processList : array of Process;
    end;

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

FUNCTION getWorker(workers: WorkersType; rank: Integer): integer;
    VAR
        i: Integer;
    BEGIN
        for i := 0 to High(workers.processList) do
            if workers.processList[i].rank = rank then
                BEGIN
                    getWorker := i;
                    exit;
                exit;
            END;
        getWorker := -1
    END;

FUNCTION createWorkers(): WorkersType;
    VAR
        total: integer;
        i, j, rank, data_length: integer;
        workers: WorkersType;
    begin
        readln(total);
        SetLength(workers.processList, total);
        for i := 0 to total-1 do
        BEGIN
            read(rank);
            workers.processList[i].rank := rank;
            read(data_length);
            SetLength(workers.processList[i].data, data_length);
            for j := 0 to data_length-1 do
                read(workers.processList[i].data[j]);
            workers.processList[i].cache := workers.processList[i].data[rank]
        END;
        createWorkers := workers;
    end;

PROCEDURE sendToNext(var workers: WorkersType; var currentProcess: Process; dest_rank, dataIndex: Integer);
    VAR
        nextWorkerIndex: integer;
    BEGIN
    nextWorkerIndex := getWorker(workers, dest_rank);
    workers.processList[nextWorkerIndex].cache := currentProcess.data[dataIndex];
    currentProcess.data[DataIndex] := -1;  // assume -1 means no data
    END;

FUNCTION recv(currentProcess: Process): integer;
    BEGIN
    recv := currentProcess.cache;
    END;

PROCEDURE share(var workers: WorkersType; var currentProcess: Process; dest_rank, dataIndex: Integer);
    VAR
        nextWorkerIndex: integer;
    BEGIN
        nextWorkerIndex := getWorker(workers, dest_rank);
        workers.processList[nextWorkerIndex].data[dataIndex] := currentProcess.data[dataIndex];
    END;

FUNCTION solve(workers: WorkersType): WorkersType;
    VAR
        size, j, k, r, rank, right, idx, p, temp, first_p: integer;
        all_reduced, shared: boolean;
        recieved: integer;
    BEGIN
    size := length(workers.processList);
    all_reduced := false;
    shared := false;
    j := 0;

    //writeln('========Share-reduce phase========');
    while not all_reduced do
        BEGIN
            for r := 0 to size-1 do
                BEGIN
                    p := getWorker(workers, r);
                    rank := workers.processList[p].rank;
                    right := (rank + 1) mod size;
                    temp := getWorker(workers, right);
                    sendToNext(workers, workers.processList[temp], right, rank-j);
                    if rank <> 0 then
                        BEGIN
                            temp := getWorker(workers, rank-1);
                            recieved := recv(workers.processList[temp]);
                            //writeln('worker ', r, ' ', recieved, '+', workers.processList[p].data[rank-j-1]);
                            workers.processList[p].data[rank-j-1] := recieved + workers.processList[p].data[rank-j-1];
                            //writeln(p.data);
                        END;
                    if rank = size-1 then
                        BEGIN
                            first_p := getWorker(workers, 0);
                            recieved := recv(workers.processList[first_p]);
                            //writeln('worker ', first_p.rank, ' ', recieved, '+', first_p.data[0-j-1]);
                            workers.processList[first_p].data[0-j-1] := recieved + workers.processList[first_p].data[0-j-1];
                            //writeln(first_p.data);
                        END;
                    all_reduced := (Length(workers.processList[p].data)-1 = countNegOnes(workers.processList[p].data));
                END;
            j += 1;
            //writeln('========================');
        END;

    // Share-only phase
    //writeln('========Share-only phase========');
    k := 0;
    while not shared do
        BEGIN
{             for r := 0 to size-1 do
                BEGIN
                    p := getWorker(workers, r);
                    writeln('worker ', r, ': ', p.data);
                END; }
            for r := 0 to size-1 do
                BEGIN
                p := getWorker(workers, r);
                rank := workers.processList[p].rank;
                right := (rank + 1) mod size;
                idx := (rank+1-k) mod Length(workers.processList[p].data);
                temp := getWorker(workers, right);
                share(workers, workers.processList[p], right, idx);
                END;
            shared := (countNegOnes(workers.processList[p].data) = 0);
            k += 1;
            //writeln('========================');
        END;
    solve := workers;
    END;

PROCEDURE printSolution(workers: WorkersType);
    VAR 
        i, j: integer;
    BEGIN
        for i := 0 to High(workers.processList) do
            BEGIN
                write(workers.processList[i].rank, ' ');
                for j := 0 to High(workers.processList[i].data) do
                    write(workers.processList[i].data[j], '-');
                writeln()
            END;
    END;

VAR
    input, result: WorkersType;
BEGIN
    input := createWorkers();
    printSolution(input);
    writeln('------------------------------------------');
    result := solve(input);
    printSolution(result);
END.