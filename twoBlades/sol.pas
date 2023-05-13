program sol;

TYPE
  IntList = array of integer;

function stringToList(input: string): IntList;
  var
    i, e: integer;
    temp: string;
    result: IntList;
  begin
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
  end;


procedure solve(input: string; target: integer);
  var
    indexA, indexB: integer;
    arr: IntList;
  begin
    arr := stringToList(input);
    for indexA := 0 to High(arr) do
      if target > arr[indexA] then
        for indexB := 0 to High(arr) do
          if (arr[indexA]+arr[indexB] = target) then
            begin
              writeln(indexA, ' ', indexB);
              exit;
            end;
  end;


VAR
  input: string;
  value: integer;

BEGIN
  readln(input);
  readln(value);
  solve(input, value)
END.