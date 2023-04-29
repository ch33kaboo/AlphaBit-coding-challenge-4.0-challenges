program Hello;

uses
  Math, SysUtils;

var
  n: integer;
  s1, s2: string;

procedure racineN(n: integer; var s1, s2: string);
var
  a, b: integer;
begin
  if (n = 0) or (n = 1) or (n = 2) or (n = 3) then
  begin
    s1 := s1+'';
  end
  else
  begin
    a :=Trunc(Sqrt(n));
    WriteLn(a);
    b := n - a * a;
    s1 := s1 + IntToStr(a);
    s2 := s2 + IntToStr(b);
    racineN(a, s1, s2);
    if (b <> 0) then
      racineN(b, s1, s2);
  end;
end;

begin
  s1 :='';
  s2 := '';
  racineN(20, s1, s2);
  WriteLn('S1: ', s1);
  WriteLn('S2: ', s2);
end.