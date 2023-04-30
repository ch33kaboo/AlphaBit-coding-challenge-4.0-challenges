program sol;

procedure twoSumOptimized(arr: string; target: integer):string;
var
  iteratorA, iteratorB: integer;
  indexA, indexB: integer;
begin
  for indexA := Low(arr) to High(arr) do
  begin
    iteratorA := arr[indexA];
    if target > iteratorA then
    begin
      for indexB := Low(arr) to High(arr) do
      begin
        iteratorB := arr[indexB];
        if iteratorB + iteratorA = target then
        begin
          writeln(indexA, ' ', indexB);
        end;
      end;
    end;
  end;
end;