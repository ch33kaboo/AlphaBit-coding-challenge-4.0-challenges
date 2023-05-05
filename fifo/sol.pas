program fifoCache;

var
  storageSize: integer;
  data: array of integer;
  occupiedSize: integer;
  oldestIndex: integer;
  i: integer;

begin
  storageSize := 1000;
  data := [100, 200, 300, 400, 500];
  occupiedSize := 0;
  oldestIndex := 0;

  for i := Low(data) to High(data) do
    begin
    while (occupiedSize + data[i] > storageSize) do
        begin
          occupiedSize := occupiedSize - data[oldestIndex];
          oldestIndex := oldestIndex + 1;
        end;
    end;

  writeln(occupiedSize);
  writeln(oldestIndex);
end.
