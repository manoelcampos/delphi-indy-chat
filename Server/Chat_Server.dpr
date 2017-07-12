program Chat_Server;

uses
  Forms,
  Windows,
  UServer in 'UServer.pas' {FrmServer},
  Chat_Tools in '..\Chat_Tools.pas';

{$R *.res}

var AppHandle: THandle;
begin
  CreateSemaphore(nil,1,1,'SIPOM - MCampos Sistemas');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    //"MCampos Messeger Server" é o caption do form principal
    AppHandle:= FindWindow(nil,'MCampos Messeger Server');
    if not IsWindowVisible(AppHandle) then
       ShowWindow(AppHandle,SW_SHOWMAXIMIZED);
    SetForegroundWindow(AppHandle);
  end
  else
  begin
    Application.Initialize;
    Application.Title := 'Indy Chat Server';
  Application.CreateForm(TFrmServer, FrmServer);
  Application.Run;
  end;
end.
