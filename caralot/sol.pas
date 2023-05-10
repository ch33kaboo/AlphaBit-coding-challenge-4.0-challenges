PROGRAM sol;
TYPE 
    IntList = array of integer;
    ResultType = record
        len: integer;
        res: IntList;
        end;

PROCEDURE removeFromArray(var arr: IntList; 
    val: integer);
    VAR
        i, j: integer;
    BEGIN
        for i := 0 to High(arr) do
            if arr[i] = val then
            BEGIN
                for j := i to High(arr)-1 do
                BEGIN
                    arr[j] := arr[j+1];
                END;
                SetLength(arr, Length(arr)-1);
                break;
            END;
    END;

FUNCTION IsValueInArray(arr: IntList; value: integer): boolean;
    VAR
    i: integer;
    BEGIN
        for i := 0 to High(arr) do
            if arr[i] = value then 
                BEGIN
                    IsValueInArray := true;
                    exit;
                END;
        IsValueInArray := false;
    END;
    
FUNCTION solve(nString:string; events:string): ResultType;
        VAR
            stack, day, done: IntList;
            event, n, i: integer;
            eventStr: string;
            result : ResultType;
        BEGIN
            Val(nString, n);
            SetLength(result.res, 0);
            if(n mod 2 = 1) then
                BEGIN
                    result.len := -1;
                    SetLength(result.res, 1);
                    result.res[0] := -1;
                    solve := result;
                    exit;
                END;
            SetLength(stack, 0);
            SetLength(day, 0);
            SetLength(done, 0);

            eventStr := '';
            for i := 1 to Length(events) do
            BEGIN
                if (events[i] = ' ') or (i = Length(events)) then
                    BEGIN
                        if i = Length(events) then
                            eventStr := eventStr + events[i];
                        
                        Val(eventStr, event);
                        { Do something with the integer value }
                        if(not(IsValueInArray(done, event))) then
                            if (event>0) and not(IsValueInArray(day, event)) then
                                BEGIN
                                    SetLength(day, length(day)+1);
                                    day[High(day)] := event;
                                    SetLength(stack, length(stack)+1);
                                    stack[High(stack)] := event;
                                END
                            else if (event<0) and IsValueInArray(day, -event) then
                                BEGIN
                                    removeFromArray(day, -event);
                                    SetLength(stack, length(stack)+1);
                                    stack[High(stack)] := event;
                                    SetLength(done, length(done)+1);
                                    done[High(done)] := -event;
                                    if(length(day)=0) then
                                        BEGIN
                                            SetLength(result.res, length(result.res)+1);
                                            result.res[High(result.res)] := length(stack);
                                            SetLength(stack, 0);
                                            SetLength(day, 0);
                                            SetLength(done, 0);
                                        END;
                                END
                            else
                                BEGIN
                                    result.len := -1;
                                    SetLength(result.res, 1);
                                    result.res[0] := -1;
                                    solve := result;
                                    exit;
                                END;
                        eventStr := '';
                    END
                else eventStr := eventStr + events[i];  
            END;
            result.len := length(result.res);
            solve := result;
        END;

VAR 
    result : ResultType;
    nString, events: string;
    i: integer;
BEGIN
    readln(nString);
    readln(events);
    
    result := solve(nString, events);
    writeln(result.len);
    for i := 0 to High(result.res) do
        write(result.res[i], ' ');
    writeln()
END.