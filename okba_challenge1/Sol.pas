program OptimalSort;

var
  capitalVowels, smallDiv4, capitalConsonants, capitalDiv4, digits, symbols, smallVowels, smallConsonants, myString: String;
  i: Integer;
  ch: Char;

begin
  capitalVowels := '';
  smallDiv4 := '';
  capitalConsonants := '';
  capitalDiv4 := '';
  digits := '';
  symbols := '';
  smallVowels := '';
  smallConsonants := '';

  Write('Enter the string to sort: ');
  Readln(myString);

  for i := 1 to Length(myString) do
  begin
    ch := myString[i];
    if Pos(ch, 'AEIOUY') <> 0 then
      capitalVowels := capitalVowels + ch
    else if Pos(ch, 'dhlptx') <> 0 then
      smallDiv4 := smallDiv4 + ch
    else if Pos(ch, 'BCDFGHJKLMNOPQRSTVWXZ') <> 0 then
      capitalConsonants := capitalConsonants + ch
    else if Pos(ch, 'DHLPTX') <> 0 then
      capitalDiv4 := capitalDiv4 + ch
    else if Pos(ch, '0123456789') <> 0 then
      digits := digits + ch
    else if Pos(ch, '!@#$%^&*()_+/\][{}":;`<>?''') <> 0 then
      symbols := symbols + ch
    else if Pos(ch, 'aeiouy') <> 0 then
      smallVowels := smallVowels + ch
    else if Pos(ch, 'bcdfghjklmnpqrstvwxz') <> 0 then
      smallConsonants := smallConsonants + ch;
  end;

  Writeln(capitalVowels + smallDiv4 + capitalConsonants + capitalDiv4 + digits + symbols + smallVowels + smallConsonants);
	Readln;
end.
