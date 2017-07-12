unit Client_Tools;

interface

uses Classes;
var
  cmd: TStrings;
  
implementation

initialization
  if cmd = nil then
     cmd:= TStringList.Create;
finalization
  if cmd <> nil then
     cmd.free;
end.
