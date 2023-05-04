uses StrUtils, sysutils;

function checkHorizontal(matrix : Array of String; target_word : String; row : integer):boolean;
var left : String;
    right : String;
    reversed : String;
begin
    right := matrix[row] + matrix[row];
    reversed := ReverseString(matrix[row]);
    left := reversed + reversed;

    checkHorizontal := (Pos(target_word, right) <> 0) Or (Pos(target_word, left) <> 0);
end;

function getColumn(matrix : Array of String; col : integer):String;
    var col_str : String;
        row : String;
begin
    col_str := '';
    for row in matrix do
        col_str := col_str + row[col+1];
    getColumn := col_str
end;

function checkVertical(matrix : Array of String; target_word : String; col : integer):boolean;
var up : String;
    bottom : String;
    reversed : String;
    col_str : String;
begin
    col_str := getColumn(matrix, col);
    bottom := col_str + col_str;
    reversed := ReverseString(col_str);
    up := reversed + reversed;

    checkVertical := (Pos(target_word, bottom) <> 0) Or (Pos(target_word, up) <> 0);
end;
function sol(rows : integer; cols : integer; target_word : String; matrix : Array of String):String;
var i : integer;
begin
    for i:= 0 to rows - 1 do
        if checkHorizontal(matrix, target_word, i) then
            Exit('row ' + IntToStr(i + 1));
    
    for i:= 0 to cols - 1 do
        if checkVertical(matrix, target_word, i) then
            Exit('col ' +IntToStr(i + 1));
    Exit('none');
end;

var
    target_word : String;
    rows : integer;
    cols : integer;
    matrix : Array of String;
    i : integer;
begin
    // read capacity, weights and uses
    read(target_word);
    read(rows);
    read(cols);
    setLength(matrix, rows);

    readln;
    for i:= 0 to rows - 1 do
        readln(matrix[i]);

    writeln(sol(rows, cols, target_word, matrix));
end.