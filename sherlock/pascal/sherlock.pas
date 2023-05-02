function IsValid(s: string): Boolean;
var
  i, j, originI, cpt, previousCmpt: Integer;
  resultValue: Boolean;
  c: Char;
begin
  i := 1;
  j := 1;
  originI := 0;
  cpt := 0;
  previousCmpt := 0;
  resultValue := True;
  
  while i <= Length(s) do
  begin
    cpt := 0;
    c := s[i];
    originI := i;
  
    while j <= Length(s) do
    begin
      if (s[j] = c) and (j <> originI) then
      begin
        cpt := cpt + 1;
      end;
      j := j + 1;
    end;
    j := 1;
  
    if cpt > 1 then
    begin
      resultValue := False;
      Break;
    end
    else
    begin
      if i = 1 then
      begin
        previousCmpt := cpt;
      end
      else
      begin
        if cpt <= previousCmpt then
        begin
          //true 
          resultValue := True;
        end
        else
        begin
          resultValue := False;
        end;
      end;
    end;
    i := i + 1;
  end;
  IsValid:=resultValue;
end;

begin
  WriteLn(IsValid('lhcceexxnxzy'));
end.