unit Chat_Tools;

interface



uses SysUtils;

const Admin = 'Administrador';

function VerificaComando(Recebido, Comando: String; Parcial: boolean = false): Boolean;
function ReceiveMsg(Received: String): String;
function RemetenteMsg(Received: String): ShortString;
function DestinatarioMsg(Received: String): ShortString;
function FormatChatMessage(Msg, UsuarioOrigem, UsuarioDestino: String; Reservado: Boolean = false): String;

implementation

uses StrUtils;

function VerificaComando(Recebido, Comando: String; Parcial: boolean): Boolean;
begin
  recebido:= AnsiLowerCase(trim(recebido));
  comando:= AnsiLowerCase(trim(comando));
  if not Parcial then
     result:= AnsiSameText(recebido, comando)
  else result:= pos(comando, recebido) <> 0;
end;

function ReceiveMsg(Received: String): String;
var
  i: integer;
  de, para, aux: ShortString;
  msg: String;
begin
  //formato da mensagem recebida: msg=UsuarioOrigem#UsuariosDestino#msg[#reservado]
  i:= pos('=',Received);
  aux:= copy(Received,i+1,length(Received));

  i:= pos('#',aux);
  de:= copy(aux,1,i-1);
  delete(aux,1,i);

  i:= pos('#',aux);
  para:= copy(aux,1,i-1);
  para:= AnsiReplaceText(para,';', ', ');
  if (para <> '') and (para[length(para)] = ';') then
     delete(para,length(para),1);
  delete(aux,1,i);
  msg:= aux;

  i:= pos('#',msg);
  if i = 0 then
     result:= de + ' fala com ' + para + ': ' + msg
  else
  begin
    delete(msg,i,length(msg));
    result:= de + ' fala reservadamente com ' + para + ': ' + msg
  end;
end;

function RemetenteMsg(Received: String): ShortString;
var
  i: integer;
begin
  i:= pos('=',Received);
  received:= copy(Received,i+1,length(Received));

  i:= pos('#',received);
  result:= copy(received,1,i-1);
end;

function DestinatarioMsg(Received: String): ShortString;
var
  i: integer;
begin
  //formato da msg recebida: msg=UsuarioOrigem#UsuariosDestino#msg[#reservado]
  i:= pos('=',Received);
  Received:= copy(Received,i+1,length(Received));

  i:= pos('#',Received);
  delete(Received,1,i);

  i:= pos('#',Received);
  result:= copy(Received,1,i-1);
end;

function FormatChatMessage(Msg, UsuarioOrigem, UsuarioDestino: String; Reservado: Boolean = false): String;
begin
  result:= 'msg=' + UsuarioOrigem + '#' + UsuarioDestino + '#' + msg;
  if Reservado then
     result:= result + '#reservado';
end;

end.

