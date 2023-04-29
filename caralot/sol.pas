PROGRAM sol;
CONST MAX = 1000;
TYPE 
    IntList = ^Element;
    Element = record
        value : integer;
        next : IntList;
    END;



FUNCTION solve(events:array[1..MAX] of integer);
VAR
    stack : array[1..MAX] of integer;

BEGIN
    
END;






BEGIN
    writeln('hello')
END.