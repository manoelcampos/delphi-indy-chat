program Chat_Client;

uses
  Forms,
  UClient in 'UClient.pas' {FrmClient},
  Chat_Tools in '..\Chat_Tools.pas',
  Client_Tools in '..\Client_Tools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Indy Chat Client';
  Application.CreateForm(TFrmClient, FrmClient);
  Application.Run;
end.
