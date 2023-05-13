program sol;

TYPE
    StringList = array of string;

VAR
    maze, hint: array of StringList;
    h: StringList;
    n, m, nh, mh, i_line, i_col, count_left, count_right, spots, spins, i: integer;
    direction, temp : string;

FUNCTION stringToList(input: string; separator: char): StringList;
  var
    i: integer;
    temp: string;
    result: StringList;
  begin
    SetLength(result, 0);
    temp := '';
    for i := 1 to Length(input) do
      if (input[i] = separator) or (i = Length(input)) then
        BEGIN
          if i = Length(input) then temp := temp + input[i];
          SetLength(result, Length(result)+1);
          result[High(result)] := temp;
          temp := '';
        END
      else temp := temp + input[i];
    stringToList := result;
  end;

PROCEDURE mark(spots, spins, i_line, i_col: integer; direction: string);
    BEGIN
        if spots = 1 then
            BEGIN
                if spins mod 4 = 0 then
                    maze[i_line * 2 + 1][i_col * 2 + 1] := 'X'
                else if spins mod 4 = 1 then
                    BEGIN
                        if direction = 'l' then
                            maze[i_line * 2][i_col * 2 + 1] := 'X'
                        else if direction = 'r' then
                            maze[i_line * 2 + 1][i_col * 2] := 'X';
                    END
                else if spins mod 4 = 2 then
                    maze[i_line * 2][i_col * 2] := 'X'
                else if spins mod 4 = 3 then
                    BEGIN
                        if direction = 'r' then
                            maze[i_line * 2][i_col * 2 + 1] := 'X'
                        else if direction = 'l' then
                            maze[i_line * 2 + 1][i_col * 2] := 'X';
                    END;
            END;

        if spots = 2 then
            BEGIN
                if spins mod 4 = 0 then
                    BEGIN
                        maze[i_line * 2][i_col * 2] := 'X';
                        maze[i_line * 2][i_col * 2 + 1] := 'X';
                    END
                else if spins mod 4 = 1 then
                    BEGIN
                        if direction = 'l' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2] := 'X';
                            END
                        else if direction = 'r' then
                            BEGIN
                                maze[i_line * 2][i_col * 2 + 1] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END;
                    END
                else if spins mod 4 = 2 then
                    BEGIN
                        maze[i_line * 2 + 1][i_col * 2] := 'X';
                        maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                    END
                else if spins mod 4 = 3 then
                    BEGIN
                        if direction = 'r' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2] := 'X';
                            END
                        else if direction = 'l' then
                            BEGIN
                                maze[i_line * 2][i_col * 2 + 1] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END;
                    END;
            END;

        if spots = 3 then
            BEGIN
                if spins mod 4 = 0 then
                    BEGIN
                        maze[i_line * 2][i_col * 2 + 1] := 'X';
                        maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                        maze[i_line * 2 + 1][i_col * 2] := 'X';
                    END
                else if spins mod 4 = 1 then
                    BEGIN
                        if direction = 'l' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2][i_col * 2 + 1] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END
                        else if direction = 'r' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END;
                    END
                else if spins mod 4 = 2 then
                    BEGIN
                        maze[i_line * 2][i_col * 2] := 'X';
                        maze[i_line * 2][i_col * 2 + 1] := 'X';
                        maze[i_line * 2 + 1][i_col * 2] := 'X';
                    END
                else if spins mod 4 = 3 then
                    BEGIN
                        if direction = 'r' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2][i_col * 2 + 1] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END
                        else if direction = 'l' then
                            BEGIN
                                maze[i_line * 2][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2] := 'X';
                                maze[i_line * 2 + 1][i_col * 2 + 1] := 'X';
                            END;
                    END;
            END;
    END;


BEGIN
    readln(n, m);
    SetLength(maze, n);
    for i_line := 0 to n - 1 do
        BEGIN
            SetLength(maze[i_line], m);
            readln(temp);
            maze[i_line] := stringToList(temp, ' ')
        END;

    readln(nh, mh);
    SetLength(hint, nh);
    for i_line := 0 to nh - 1 do
        BEGIN
            SetLength(hint[i_line], mh);
            readln(temp);
            hint[i_line] := stringToList(temp, ' ')
        END;

    for i_line := 0 to nh - 1 do
        BEGIN
            for i_col := 0 to mh - 1 do
                BEGIN
                    h := stringToList(hint[i_line][i_col], ',');
                    Val(h[0], spots);

                    count_left := 0;
                    count_right := 0;
                    for i:=1 to High(h) do
                        BEGIN
                            if h[i] = 'l' then count_left := count_left +1
                            else if h[i] = 'r' then count_right := count_right +1
                        END;

                    spins := abs(count_left - count_right);
                    if (count_left - count_right > 0) then direction := 'l'
                    else direction := 'r';
                        
                    mark(spots, spins, i_line, i_col, direction);
                END;
        END;

    for i_line := 0 to n - 1 do
        BEGIN
            for i_col := 0 to m-1 do
                if i_col < m-1 then write(maze[i_line][i_col], ' ')
                else write(maze[i_line][i_col]);

            writeln()
        END;
END.