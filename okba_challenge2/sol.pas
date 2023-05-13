uses sysutils,
    StrUtils,
    Types;

procedure sol(items: TStringDynArray);
    var item : String;
        item_int : Int64;
        is_bit : boolean;
        unit_char : Char;
begin

    for item in items do
    begin
    is_bit := item[Length(item)] = 'b';
    if ((ord(item[Length(item) - 1]) >= ord('0')) and (ord(item[Length(item) - 1]) <= ord('9'))) then
    begin
        item_int := StrToInt(Copy(item, 1, Length(item) - 1));
        unit_char := ' ';
    end else begin
        item_int := StrToInt(Copy(item, 1, Length(item) - 2));
        unit_char := item[Length(item) - 1];
    end;

    case unit_char of
        'K' : item_int := item_int * 1024;
        'M' : item_int := item_int * 1024 * 1024;
        'G' : item_int := item_int * 1024 * 1024 * 1024;
        'T' : item_int := item_int * 1024 * 1024 * 1024 * 1024;
    end;
    if(is_bit) then write(Format('%g', [item_int / 8]), ' ')
        else write(item_int, ' ');
    end;
    writeln;

end;

var
    input_str : String;
begin
    readln(input_str);
    sol(SplitString(input_str, ' '));
end.