unit UServer;

interface

uses
  StrUtils, ShellApi, Chat_Tools, Contnrs, Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Buttons,
  jpeg, IdContext,
  IdAntiFreezeBase, IdAntiFreeze, IdTCPConnection, IdTCPServer,
  IdCustomTCPServer, IdBaseComponent, IdComponent, Menus, AppEvnts, IdTCPClient,
  IdHTTP {indy 10};

const
  CheckIPUrl = 'http://ip1.dynupdate.no-ip.com';

type
  {ponteiro para o registro que armazena as informações dos clientes.
  Com este ponteiro é feita a alocação dinâmica dos dados dos clientes
  conectados. Quando um cliente disconecta, as informações dele
  que estavam sendo guardadas são liberadas dinamicamente da memória.}
  PConexao = ^TConexao;
  TConexao = record
    IP: ShortString;
    //ThreadID: Cardinal; //não achei esta propriedade na conexão do indy 10
    //Connection: TidTCPServerConnection; //indy 9
    Connection: TidTCPConnection; //indy 10 - unit IdTCPConnection
    Usuario: ShortString;
  end;

  TFrmServer = class(TForm)
    IdTCPServer1: TIdTCPServer;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    IdAntiFreeze1: TIdAntiFreeze;
    Image1: TImage;
    Label1: TLabel;
    cmbUsuario: TComboBox;
    lbEdtMsg: TLabeledEdit;
    btnEnviar: TBitBtn;
    btnDerrubar: TBitBtn;
    mmoIPs: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    btnSobre: TBitBtn;
    btnLimpar: TBitBtn;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    mnuExibir: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    IdHTTP1: TIdHTTP;
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdTCPServer1Connect(AContext: TIdContext);
    procedure IdTCPServer1Disconnect(AContext: TIdContext);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure btnDerrubarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure lbEdtMsgChange(Sender: TObject);
    procedure cmbUsuarioChange(Sender: TObject);
    procedure btnSobreClick(Sender: TObject);
    procedure lbEdtMsgKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparClick(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure mnuExibirClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    cmd, user_list: TStringList;
    xUniqueUser: Boolean;
    procedure ShowConnections;
    procedure ListUsers;
    procedure ListIPs;
    procedure SendMsg;
    procedure UsuarioEntrou;
    procedure SendMsgToAll(msg: String);
    {função para verificar se o nome de usuário que o cliente escolheu
     não existe na sala de chat}
    function UniqueUser(User: ShortString): Boolean;
    function IndexOfUserConnection(User: ShortString): Integer;
  public
    { Public declarations }

  end;

var
  FrmServer: TFrmServer;
  conn: TList;

implementation


{$R *.dfm}


procedure TFrmServer.Fechar1Click(Sender: TObject);
begin
   close;
end;

procedure TFrmServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tag:= conn.Count;
  if tag > 0 then
  begin
    action:= caNone;
    Application.MessageBox('Você não pode fechar o servidor pois existem clientes conectados','Informação',mb_iconInformation)
  end
  else
  begin
    cmd.Free;
    Conn.Free;
    user_list.Free;

    IdTCPServer1.Active := false;
  end;
end;


procedure TFrmServer.FormCreate(Sender: TObject);
begin
  IdTCPServer1.Active := true;

  cmd:= TStringList.Create;
  user_list:= TStringList.Create;
  conn:= TList.Create;
end;

procedure TFrmServer.FormShow(Sender: TObject);
var
  ip: string;
begin
  TrayIcon1.ShowBalloonHint;
  ip:= IdHTTP1.Get(CheckIPUrl);
  if length(IP) <= 15 then
     StatusBar1.Panels[1].Text := 'IP real do Servidor: '+ip;
end;

procedure TFrmServer.ShowConnections;
begin
    StatusBar1.Panels[0].Text := format('Total de Conexões: %d',[conn.count]);
end;

procedure TFrmServer.TrayIcon1DblClick(Sender: TObject);
begin
  Visible:= not Visible;
end;

procedure TFrmServer.ListUsers;
var
  i: integer;
  aux: String;
  ConAux: PConexao;
begin
  aux:= '';
  for i:= 0 to conn.Count -1 do
  begin
     //GetMem(ConAux, SizeOf(TConexao));
     try
       ConAux:= PConexao(conn[i]);
       aux:= aux + ConAux.Usuario + ';';
     finally
       //FreeMem(ConAux);
     end;
  end;
  if aux <> '' then
     delete(aux,length(aux),1);

  cmbUsuario.Items.clear;
  cmbUsuario.Items.text:= AnsiReplaceText(aux,';',#13);
  if cmbUsuario.Items.Count > 2 then
     aux:= 'Todos;' + aux
  else if cmbUsuario.Items.Count <> 2 then
     aux:= '';


  if cmbUsuario.Items.Count > 1 then
     cmbUsuario.items.Insert(0,'Todos');
  if cmbUsuario.Items.Count > 0 then
     cmbUsuario.ItemIndex := 0;

  cmbUsuarioChange(cmbUsuario);
  SendMsgToAll('list_user=' + aux);
  ListIPs;
end;



procedure TFrmServer.UsuarioEntrou;
var msg: string;
begin
   msg:= cmd.values['nick'] + ' entrou na sala';
   Memo1.lines.add(msg);
   SendMsgToAll(msg);
   ListUsers;
end;


procedure TFrmServer.Image1Click(Sender: TObject);
begin
  ShellExecute(handle,'open','www.indyproject.org',nil,nil,SW_SHOWMAXIMIZED)
end;

function TFrmServer.UniqueUser(User: ShortString): Boolean;
var i: integer;
begin
  result:= true;
  for i:= 0 to conn.Count -1 do
  begin
     if PConexao(Conn[i]).Usuario = User then
     begin
       result:= false;
       break;
     end;
  end;
end;

function TFrmServer.IndexOfUserConnection(User: ShortString): Integer;
var i: integer;
begin
  result:= -1;
  for i:= 0 to conn.Count -1 do
  begin
    if PConexao(conn[i]).Usuario = User then
    begin
      result:= i;
      break;
    end;
  end;
end;

procedure TFrmServer.lbEdtMsgChange(Sender: TObject);
begin
  btnEnviar.Enabled := (trim(lbEdtMsg.Text) <> '') and (cmbUsuario.ItemIndex <> -1);
end;

procedure TFrmServer.cmbUsuarioChange(Sender: TObject);
begin
  lbEdtMsgChange(lbEdtMsg);
  btnDerrubar.Enabled:= (cmbUsuario.ItemIndex <> -1) and (not AnsiSameText('todos',cmbUsuario.Text));
end;

procedure TFrmServer.mnuExibirClick(Sender: TObject);
begin
  Visible:= not Visible;
end;

procedure TFrmServer.PopupMenu1Popup(Sender: TObject);
begin
  if Visible then
     mnuExibir.Caption := 'Ocultar'
  else mnuExibir.Caption := 'Exibir';
end;

procedure TFrmServer.ListIPs;
var
  i: integer;
  aux: String;
  ConAux: PConexao;
begin
  aux:= '';
  for i:= 0 to conn.Count -1 do
  begin
     //GetMem(ConAux, SizeOf(TConexao));
     try
       ConAux:= PConexao(conn[i]);
       aux:= aux + 'Usuário: ' + ConAux.Usuario + ' - IP: ' + ConAux.IP + #13;
     finally
       //FreeMem(ConAux);
     end;
  end;

  mmoIPs.Lines.Text := trim(aux);
end;

procedure TFrmServer.btnSobreClick(Sender: TObject);
begin
  Application.MessageBox(pchar('Sistema de Chat desenvolvido por Manoel Campos da Silva Filho'#13+
   'Professor do Instituto Federal de Educação do Tocantins - TO')
   ,'MCampos Messenger',mb_IconInformation);
end;

procedure TFrmServer.lbEdtMsgKeyPress(Sender: TObject; var Key: Char);
begin
  {o usuário não pode utilizar # pois este é um caracter de controle usado
  nos parâmetros das mensagens enviadas e recebidas}
  if key = '#' then
     abort;
end;

procedure TFrmServer.btnLimparClick(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja limpar as mensagens?',
  'Confirmação', MB_ICONQUESTION or MB_OKCANCEL) = mrOK then
      memo1.Clear;
end;

procedure TFrmServer.IdTCPServer1Disconnect(AContext: TIdContext);
var
  ConAux: PConexao;
  aux: string;
begin
  if xUniqueUser then
  begin
    ConAux:= PConexao(AContext.Data);
    try
      conn.Remove(ConAux);
      aux:= ConAux.Usuario + ' saiu da sala.';
      memo1.lines.add(aux);
      SendMsgToAll(aux);
      AContext.Data := nil;
    finally
      FreeMem(ConAux);
    end;
    ListUsers;
    ShowConnections;
  end
  else xUniqueUser:= true;
end;

procedure TFrmServer.IdTCPServer1Connect(AContext: TIdContext);
var ConAux: PConexao;
begin
 //no indy 9 era AThead.Connection.ReadLn; 
 cmd.text:= AContext.Connection.IOHandler.ReadLn;
 if AnsiSameText(Admin,cmd.Values['nick']) then
    AContext.Connection.IOHandler.Writeln('nick_existente=O nick utilizado é um nick reservado ao administrador do sistema. Utilize outro nick.')
 else
 begin
   xUniqueUser := UniqueUser(cmd.Values['nick']);
   if xUniqueUser then
   begin
     AContext.Connection.IOHandler.Writeln('Bem vindo ao servidor de chat'#10);
     GetMem(ConAux,SizeOf(TConexao));
     try
       //ConAux.ThreadID := AContext.Connection.IOHandler.
       ConAux.Connection:= AContext.Connection;
       ConAux.IP := AContext.Connection.Socket.Binding.PeerIP;
       ConAux.Usuario := cmd.Values['nick'];

       AContext.Data := TObject(ConAux);
       conn.Add(ConAux);
       UsuarioEntrou;
     finally
       //FreeMem(ConAux);
       ShowConnections;
     end;
   end
   else AContext.Connection.IOHandler.Writeln('nick_existente=Já há uma pessoa com o Nick escolhido na sala de chat');
 end;
end;

procedure TFrmServer.IdTCPServer1Execute(AContext: TIdContext);
begin
  try
    cmd.Text:= AContext.Connection.IOHandler.ReadLn;

    //formato da mensagem recebida: msg=UsuarioOrigem#UsuariosDestino#msg[#reservado]
    if VerificaComando(cmd.text,'msg=',true) then
    begin
       SendMsg;
       memo1.lines.add(ReceiveMsg(cmd.text));
    end
    else if VerificaComando(cmd.text,'run=',true) then
    begin
      //o ShellExecute é da Unit ShellApi
      ShellExecute(handle,'open',pchar(cmd.values['run']),nil,nil,sw_showNormal);
    end;
  except
    on e: Exception do
    begin
      AContext.Connection.IOHandler.WriteLn('server_error='+e.message);
    end;
  end;
end;

procedure TFrmServer.SendMsg;
var
  i: integer;
  ConAux: PConexao;
  remetente: ShortString;
begin
  //formato da mensagem recebida: msg=UsuarioOrigem#UsuariosDestino#msg[#reservado]

  //exemplo de comando de envio de msg: msg=manoel#todos#e aí galera

  //enviar msg pra todos da sala se a msg não for reservada
  if (not VerificaComando(cmd.text,'#reservado',true)) then
     SendMsgToAll(cmd.Text)
  else
  begin
    //se a msg for reservada, então envia a msg pro usuário de destino
    user_list.text:= DestinatarioMsg(cmd.text);
    user_list.text:= AnsiReplaceText(user_list.text,';',#13);
    remetente:= RemetenteMsg(cmd.text);

    //percorre a lista dos usuários conectados para enviar a mensagem reservada
    for i:= 0 to conn.Count -1 do
    begin
       ConAux:= PConexao(conn[i]);
       {verifica se o usuário atual está na lista de destinatários (user_list)
        ou se ele é o próprio remetente, se for, a mensagem é enviada ao usuário }
       if (user_list.IndexOf(ConAux.Usuario) <> -1) or (ConAux.Usuario = remetente) then
          ConAux.Connection.IOHandler.WriteLn(cmd.Text);
       //FreeMem(ConAux);
    end;
  end;
end;

procedure TFrmServer.SendMsgToAll(msg: String);
var
  i: integer;
  ConAux: PConexao;
begin
    if trim(msg) = '' then
       exit;

    for i:= 0 to conn.Count -1 do
    begin
       //GetMem(ConAux, SizeOf(TConexao));
       try
         ConAux:= PConexao(conn[i]);
         ConAux.Connection.IOHandler.WriteLn(msg);
       finally
         //FreeMem(ConAux);
       end;
    end;
end;

procedure TFrmServer.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide;
end;

procedure TFrmServer.btnDerrubarClick(Sender: TObject);
begin
  tag:= IndexOfUserConnection(cmbUsuario.Text);
  if tag <> -1 then
  begin
     PConexao(conn[tag]).Connection.IOHandler.WriteLn(
        FormatChatMessage('Você será desconectado da sala pelo administrador do sistema','Administrador',cmbUsuario.Text,true));
     PConexao(conn[tag]).Connection.Disconnect(true);
  end
  else  Application.MessageBox('Usuário não localizado','Informação',mb_IconInformation);
end;

procedure TFrmServer.btnEnviarClick(Sender: TObject);
var msg: string;
begin
  msg:= FormatChatMessage(lbEdtMsg.Text,Admin,cmbUsuario.Text, not AnsiSameText(cmbUsuario.Text,'todos'));
  if AnsiSameText('todos',cmbUsuario.Text) then
     SendMsgToAll(msg)
  else
  begin
    tag:= IndexOfUserConnection(cmbUsuario.Text);
    if tag <> -1 then
       PConexao(conn[tag]).Connection.IOHandler.WriteLn(msg)
    else  Application.MessageBox('Usuário não localizado','Informação',mb_IconInformation);
  end;
  lbEdtMsg.SetFocus;
  lbEdtMsg.SelectAll;
end;

end.
