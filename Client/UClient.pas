  unit UClient;

interface

uses
  ShellApi, Client_Tools, Chat_Tools, Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, ExtCtrls, Buttons, IdIntercept, IdAntiFreezeBase, IdAntiFreeze,
  ComCtrls, jpeg, CheckLst;

type
  TFrmClient = class(TForm)
    IdTCPClient1: TIdTCPClient;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    checkListUsuario: TCheckListBox;
    lbEdtMsg: TLabeledEdit;
    btnEnviar: TBitBtn;
    Memo1: TMemo;
    IdAntiFreeze1: TIdAntiFreeze;
    StatusBar1: TStatusBar;
    cboxReservado: TCheckBox;
    ScrollBox2: TScrollBox;
    btnConecta: TBitBtn;
    Image1: TImage;
    lbEdtServidor: TLabeledEdit;
    lbEdtPorta: TLabeledEdit;
    lbEdtNick: TLabeledEdit;
    btnSobre: TBitBtn;
    btnExecutarAppServ: TBitBtn;
    btnLimpar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConectaClick(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure lbEdtPortaKeyPress(Sender: TObject; var Key: Char);
    procedure btnEnviarClick(Sender: TObject);
    procedure lbEdtNickChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
    procedure lbEdtMsgKeyPress(Sender: TObject; var Key: Char);
    procedure btnExecutarAppServClick(Sender: TObject);
    procedure checkListUsuarioClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    procedure desconectou;
    procedure ShowReceiveMsg;
    procedure ListUsers;
    procedure UnknowCmd;
    procedure NickExistente;
    procedure ShowServerError;
    procedure SetCaptionAndAppTitle(Text: String);

    //retorna a lista dos usuários checkados (no CheckListBox) numa string separada por virgula
    function GetUserList: String;

    //descobre quantos itens estão checados (marcados)
    function CheckedUserCount: Integer;

    //marca ou desmarca (propriedade checked do checklistbox) todos os items do checklistbox de usuários
    procedure SetChecked(Value: Boolean);
  public
    { Public declarations }
  end;

  TClientThread = class(TThread)
  protected
    procedure Execute; override;
    procedure Terminado(Sender: TObject);
  public
    constructor Create(CreateSuspended: Boolean);
  end;

const
  ColorEnabled: array [boolean] of TColor = (clBtnFace, clWindow);
var
  FrmClient: TFrmClient;

implementation

uses Math, StrUtils;

{$R *.dfm}

procedure TFrmClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IdTCPClient1.Disconnect;
end;

procedure TFrmClient.btnConectaClick(Sender: TObject);
begin
  if IdTCPClient1.Connected then
     IdTCPClient1.Disconnect
  else
  begin
    IdTCPClient1.Host := lbEdtServidor.Text;
    IdTCPClient1.Port := StrToInt(lbEdtPorta.Text);
    try
      //alterada propriedade connectTimeout
      IdTCPClient1.Connect;
    except
      on e: Exception do
      begin
        if pos('connection refused',AnsiLowerCase(e.message)) > 0 then
           Application.MessageBox('Conexão recusada. Talvez o servidor esteja fora do ar.','Erro',mb_IconError);
      end;
    end;
  end;
end;

procedure TFrmClient.IdTCPClient1Connected(Sender: TObject);
begin
  IdTCPClient1.IOHandler.WriteLn('nick='+lbEdtNick.Text);
  ScrollBox1.Visible := true;
  btnConecta.Caption := 'Dis&conectar';
  StatusBar1.Panels[0].text:= 'Conectado ao servidor remoto';
  TClientThread.Create(false);
  SetCaptionAndAppTitle('Indy Chat Client - ' + lbEdtNick.Text);
  Memo1.Lines.Clear;

  lbEdtServidor.Enabled := false;
  lbEdtServidor.Color := ColorEnabled[lbEdtServidor.Enabled];
  lbEdtNick.Enabled := false;
  lbEdtNick.Color := ColorEnabled[lbEdtNick.Enabled];
  lbEdtPorta.Enabled := false;
  lbEdtPorta.Color := ColorEnabled[lbEdtPorta.Enabled];
  checkListUsuario.SetFocus;
end;

procedure TFrmClient.lbEdtPortaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
     key:= #0;
     if btnConecta.Enabled then
        btnConecta.Click;
  end;
end;

procedure TFrmClient.btnEnviarClick(Sender: TObject);
begin
   //no indy 9 era IdTCPClient1.WriteLn
  IdTCPClient1.IOHandler.WriteLn(FormatChatMessage(lbEdtMsg.Text,lbEdtNick.Text,GetUserList,cboxReservado.Checked));
  lbEdtMsg.SetFocus;
  lbEdtMsg.SelectAll;
end;

procedure TFrmClient.ShowReceiveMsg;
begin
  memo1.lines.add(ReceiveMsg(cmd.text));
  if not FrmClient.Active then
  begin
     SetForegroundWindow(Handle);
     FrmClient.Activate;
  end;
end;

procedure TFrmClient.lbEdtNickChange(Sender: TObject);
begin
  btnConecta.Enabled :=
    (trim(lbEdtServidor.Text) <> '') and
    (trim(lbEdtPorta.Text) <> '') and
    (trim(lbEdtNick.Text) <> '');
end;

{ TClientThread }

constructor TClientThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  Priority := tpIdle;
  FreeOnTerminate:= true;
  //código incluído
  OnTerminate := Terminado;
end;

procedure TClientThread.Execute;
begin
  inherited;
  with FrmClient do
  begin
    if not IdTCPClient1.Connected then
       exit;
    repeat
      try
        //no indy 9 era IdTCPClient1.ReadLn;
        cmd.text:= IdTCPClient1.IOHandler.ReadLn;
        if trim(cmd.text) <> '' then
        begin
          if VerificaComando(cmd.text,'msg=',true) then
             Synchronize(ShowReceiveMsg)
          else if VerificaComando(cmd.text,'list_user=',true) then
             Synchronize(ListUsers)
          else if VerificaComando(cmd.text,'nick_existente=',true) then
             Synchronize(NickExistente)
          else if VerificaComando(cmd.text,'server_error=',true) then
             Synchronize(ShowServerError)
          else Synchronize(UnknowCmd);
        end;
      except
        //código incluído
        on e: exception do
        begin
           if not AnsiSameText(e.message, 'Disconnected.') then
           begin
             Application.MessageBox(pchar(e.message), 'Erro', mb_iconError);
             IdTCPClient1.Disconnect;
           end;
        end;
      end;
    until not IdTCPClient1.Connected;
  end;
  //Terminate;
end;

procedure TFrmClient.ListUsers;
begin
  checkListUsuario.Items.Text := cmd.Values['list_user'];
  checkListUsuario.Items.Text:=AnsiReplaceText(checkListUsuario.Items.Text,';',#13);
  if checkListUsuario.Items.Count > 0 then
  begin
     //deleta o nome do próprio usuário da lista para que ele não mande msg para ele mesmo
     checkListUsuario.Items.Delete(checkListUsuario.Items.IndexOf(lbEdtNick.Text));
     checkListUsuario.ItemIndex := 0;
  end;
  lbEdtMsg.Enabled := checkListUsuario.Items.Count > 0;
  if checkListUsuario.Items.Count = 1 then
     checkListUsuario.Checked[0]:= true;
end;

procedure TFrmClient.UnknowCmd;
begin
  Memo1.Lines.add(cmd.text)
end;

procedure TFrmClient.Image1Click(Sender: TObject);
begin
  ShellExecute(handle,'open','www.indyproject.org',nil,nil,SW_SHOWMAXIMIZED)
end;

procedure TFrmClient.NickExistente;
var msg: String;
begin
  msg:= copy(cmd.text,16,length(cmd.text));
  Application.messageBox(pchar(msg),'Informação',mb_iconInformation);
  IdTCPClient1.Disconnect;
end;

procedure TFrmClient.ShowServerError;
var msg: String;
begin
  msg:= copy(cmd.text,14,length(cmd.text));
  memo1.lines.Add('Erro no Servidor: ' + msg);
end;

procedure TFrmClient.SetCaptionAndAppTitle(Text: String);
begin
  Caption:= Text;
  Application.Title := Caption;
end;

procedure TFrmClient.btnSobreClick(Sender: TObject);
begin
  Application.MessageBox(pchar('Sistema de Chat desenvolvido por Manoel Campos da Silva Filho'#13+
   'Professor do Instituto Federal de Educação do Tocantins - TO')
   ,'Indy Chat Client',mb_IconInformation);
end;

procedure TFrmClient.lbEdtMsgKeyPress(Sender: TObject; var Key: Char);
begin
  {o usuário não pode utilizar # pois este é um caracter de controle usado
  nos parâmetros das mensagens enviadas e recebidas}
  if key = '#' then
     abort;
end;

procedure TFrmClient.btnExecutarAppServClick(Sender: TObject);
var path: string;
begin
  path:=InputBox('Executar Aplicação no Servidor','Informe o caminho da aplicação no Servidor','');
  path:= trim(path);
  if path <> '' then
     IdTCPClient1.IOHandler.WriteLn('run=' + path);
end;

procedure TFrmClient.checkListUsuarioClick(Sender: TObject);
begin
  {verifica que o usuário selecionou o primeiro item  (Todos) e se este
  está selecionado. Se estiver, então deve desmarcar todos os outros itens
  pois o primeiro item já é pra enviar msg pra todos os usuários}
  if checkListUsuario.Selected[0] and checkListUsuario.Checked[0] then
  begin
     SetChecked(false);
     checkListUsuario.Checked[0]:= true;
  end
  else if CheckedUserCount > 1 then
     checkListUsuario.Checked[0]:= false;

  cboxReservado.Enabled := not checkListUsuario.Checked[0];
  if not cboxReservado.Enabled then
     cboxReservado.Checked := false;
     
  btnEnviar.Enabled := (CheckedUserCount > 0) and (trim(lbEdtMsg.Text) <> '');
end;

function TFrmClient.GetUserList: String;
var i: integer;
begin
  result:= '';
  for i:= 0 to checkListUsuario.Items.Count -1 do
    if checkListUsuario.Checked[i] then
      result:= result + checkListUsuario.Items[i] + ';';
  delete(result,length(result),1);

end;

function TFrmClient.CheckedUserCount: Integer;
var i: integer;
begin
  result:= 0;
  for i:= 0 to checkListUsuario.Items.Count -1 do
    if checkListUsuario.Checked[i] then
       inc(result);
end;

procedure TFrmClient.btnLimparClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja limpar as mensagens?',
  'Confirmação', MB_ICONQUESTION or MB_OKCANCEL) = mrOK then
      memo1.Clear;
end;

procedure TFrmClient.SetChecked(Value: Boolean);
var i: integer;
begin
  for i:= 0 to checkListUsuario.Items.Count -1 do
     checkListUsuario.Checked[i]:= value;
end;

procedure TClientThread.Terminado(Sender: TObject);
begin
  ShowMessage('Terminou Thead');
  FrmClient.desconectou;
end;

procedure TFrmClient.FormShow(Sender: TObject);
begin
  desconectou;
end;

procedure TFrmClient.desconectou;
begin
  SetCaptionAndAppTitle('Indy Chat Client');
  ScrollBox1.Visible := false;
  StatusBar1.Panels[0].text:= 'Desconectado do servidor';
  btnConecta.Caption := '&Conectar';

  lbEdtServidor.Enabled := true;
  lbEdtServidor.Color := ColorEnabled[lbEdtServidor.Enabled];
  lbEdtNick.Enabled := true;
  lbEdtNick.SetFocus;
  lbEdtNick.Color := ColorEnabled[lbEdtNick.Enabled];
  lbEdtPorta.Enabled := true;
  lbEdtPorta.Color := ColorEnabled[lbEdtPorta.Enabled];
end;

end.
