Val(nString, n);

    if(n mod 2 = 1) print()

    SetLength(stack, 0);
    SetLength(day, 0);
    SetLength(done, 0);
    SetLength(oute_index, 0);

    eventStr := '';
    for i := 1 to Length(events) do
    BEGIN
        if (events[i] = ' ') or (i = Length(events)) then
            BEGIN
                if i = Length(events) then
                    eventStr := eventStr + events[i];
                    
                event := StrToInt(eventStr);
                { Do something with the integer value }
                if(!IsValueInArray(done, event)) then
                    if (event>0 and !IsValueInArray(day, event)) then
                        BEGIN
                            SetLength(day, length(day)+1);
                            day[High(day)] := e;
                            SetLength(stack, length(stack)+1);
                            stack[High(stack)] := e;
                        END;
                    else if (event<0 and IsValueInArray(day, -event)) then
                        BEGIN
                            removeFromArray(day, -event);
                            SetLength(stack, length(stack)+1);
                            stack[High(stack)] := e;
                            SetLength(done, length(done)+1);
                            done[High(done)] := -e;
                            if(length(day)=0) then
                                BEGIN
                                    SetLength(oute_index, length(oute_index)+1);
                                    oute_index[High(oute_index)] := length(stack);
                                    SetLength(stack, 0);
                                    SetLength(day, 0);
                                    SetLength(done, 0);
                                END;
                        END;
                    else 
                eventStr := '';
            END
        else eventStr := eventStr + events[i];  
    END;