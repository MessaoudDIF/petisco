unit Util;

interface

uses
  { VCL }
  Windows, Classes, SysUtils, Vcl.Graphics , Vcl.StdCtrls, Controls, Forms, Dialogs,
  { Spring}
  //Spring.Collections,
  { JEDI }
  JvToolEdit,
  { helsonsant }
  UnMensagemView;

type

  TValor = class
  private
    FTexto: string;
    FInteiro: Integer;
    FDecimal: Real;
  public
    function Texto(const Texto: string): TValor;
    function Inteiro(const ValorInteiro: Integer): TValor;
    function Decimal(const Decimal: Real): TValor;
    function ObterTexto: string;
  end;

  TMap = class
  private
    FValor: TValor;
    FObject: TObject;
    FMap: TStringList;
    procedure RemoveParametroSeExistir(const Chave: string);
  public
    function ComoDecimal: Real;
    function ComoInteiro: Integer;
    function ComoObjeto: TObject;
    function ComoTexto: string;
    constructor Create; reintroduce;
    function Ler(const Chave: string): TMap;
    function Gravar(const Chave: string; Valor: Integer): TMap; overload;
    function Gravar(const Chave: string; Valor: Real): TMap; overload;
    function Gravar(const Chave: string; Valor: TObject): TMap; overload;
    function Gravar(const Chave, Valor: string): TMap; overload;
    function Limpar: TMap;
  end;

  TText = class(TObject)
  protected
  public
    class function DSpaces(Astring: string; ATamanho: Integer):string;
    class function DZeros(Astring: string; ATamanho: Integer):string;
    class function ESpaces(Astring: string; ATamanho: Integer):string;
    class function EZeros(Astring: string; ATamanho: Integer):string;
    class function LowerCase(AString: string): string;
    class function MaskCEP(ACEP: string): string;
    class function MaskCNPJ(ACNPJ: string): string;
    class function MaskCPF(ACPF: string): string;
    class function UpperCase(Astring: string): string;
    class function StringReplaceAll(ASourceString, AOldString, ANewString: string): string;
  end;

  TUtil = class
  private
    FText: TText;
  public
    property Text: TText read FText write FText;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: string): string; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Char): Char; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Byte): Byte; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Integer): Integer; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Cardinal): Cardinal; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Single): Single; overload;
    function Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Boolean): Boolean; overload;
    function ObterValorVariavelAmbiente(const NomeVariavelAmbiente: string): string;
    class procedure AtualizarCampoDeEdicao(const CampoDeEdicao: TCustomEdit; const Texto: string = '');
  end;

  TMessages = class(TObject)
  protected
  public
    class function GetCanceled: Boolean;
    class function Confirma(const Mensagem: string; ACanCancel: Boolean = False): Boolean;
    class procedure Mensagem(const Mensagem: string);
    class procedure MensagemErro(const Mensagem: string);
  end;

var
  FCanceled: Boolean;

implementation

{ TFlText }

class function TText.UpperCase(AString: string): string;
begin
  Result := UpperCase(AString)
end;

class function TText.LowerCase(AString: string): string;
begin
  Result := SysUtils.LowerCase(AString)
end;

class function TText.EZeros(Astring: string; ATamanho: Integer): string;
var
  strEZeros: string;
  i: Integer;
begin
  strEZeros := Trim(Astring);
  for i := 0 to (ATamanho - Length(strEZeros))-1  do begin
    strEZeros := '0' + strEZeros;
  end;
  Result := strEZeros;
end;

class function TText.DZeros(Astring: string; ATamanho: Integer): string;
var
  strDZeros: string;
  i: Integer;
begin
  strDZeros := Trim(Astring);
  for i := 0 to (ATamanho - Length(strDZeros))-1  do begin
    strDZeros := strDZeros + '0';
  end;
  Result := strDZeros;
end;

class function TText.DSpaces(Astring: string; ATamanho: Integer): string;
var
  strDSpaces: string;
  i: Integer;
begin
  strDSpaces := Trim(Astring);
  for i := 0 to (ATamanho - Length(strDSpaces))-1  do begin
    strDSpaces := strDSpaces + ' ';
  end;
  Result := strDSpaces;
end;

class function TText.ESpaces(Astring: string; ATamanho: Integer): string;
var
  strDSpaces: string;
  i: Integer;
begin
  strDSpaces := Trim(Astring);
  for i := 0 to (ATamanho - Length(strDSpaces))-1  do begin
    strDSpaces := ' ' + strDSpaces;
  end;
  Result := strDSpaces;
end;

class function TText.StringReplaceAll(ASourceString, AOldString, ANewString: string): string;
begin
  Result := StringReplace(Trim(ASourceString), AOldString, ANewString, [rfReplaceAll, rfIgnoreCase]);
end;

class function TText.MaskCNPJ(ACNPJ: string): string;
begin
  if Trim(ACNPJ) <> '' then begin
    Result := Copy(ACNPJ, 1, 2) + '.' +
      Copy(ACNPJ, 3, 3) + '.' +
      Copy(ACNPJ, 6, 3) + '/' +
      Copy(ACNPJ, 9, 4) + '-' +
      Copy(ACNPJ, 13, 2);
  end else begin
    Result := ACNPJ;
  end;
end;

class function TText.MaskCPF(ACPF: string): string;
begin
  if Trim(ACPF) <> '' then begin
    Result := Copy(ACPF, 1, 3) + '.' +
      Copy(ACPF, 4, 3) + '.' +
      Copy(ACPF, 7, 3) + '-' +
      Copy(ACPF, 10, 2);
  end else begin
    Result := ACPF;
  end;
end;

class function TText.MaskCEP(ACEP: string): string;
begin
  if Trim(ACEP) <> '' then begin
    Result := Copy(ACEP, 1, 5) + '-' + Copy(ACEP, 6, 3);
  end else begin
    Result := ACEP;
  end;
end;

{ Util }
function TUtil.ObterValorVariavelAmbiente(const NomeVariavelAmbiente: string): string;
begin
  Result := GetEnvironmentVariable(NomeVariavelAmbiente);
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: string): string;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Char): Char;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Byte): Byte;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Integer): Integer;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Cardinal): Cardinal;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Single): Single;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

class procedure TUtil.AtualizarCampoDeEdicao(const CampoDeEdicao: TCustomEdit; const Texto: string);
var
  _event: TNotifyEvent;
begin
  if CampoDeEdicao is TEdit then
  begin
    _event := (CampoDeEdicao as TEdit).OnChange;
    (CampoDeEdicao as TEdit).OnChange := nil;
  end
  else
  begin
    if CampoDeEdicao is TJvComboEdit then
    begin
      _event := (CampoDeEdicao as TJvComboEdit).OnChange;
      (CampoDeEdicao as TJvComboEdit).OnChange := nil;
    end;
  end;
  try
    CampoDeEdicao.Text := Texto;
    if CampoDeEdicao is TEdit then
    begin
      (CampoDeEdicao as TEdit).OnChange := _event;
    end
    else
    begin
      if CampoDeEdicao is TJvComboEdit then
      begin
        (CampoDeEdicao as TJvComboEdit).OnChange := _event;
      end;
    end;
  finally
    _event := nil;
  end;
end;

function TUtil.Iff(const ACondition: Boolean; const ATruePart, AFalsePart: Boolean): Boolean;
begin
  if ACondition then begin
    Result := ATruePart;
  end else begin
    Result := AFalsePart;
  end;
end;

{ TValor }
function TValor.Decimal(const Decimal: Real): TValor;
begin
  Self.FDecimal := Decimal;
  Result := Self;
end;

function TValor.Inteiro(const ValorInteiro: Integer): TValor;
begin
  Self.FInteiro := ValorInteiro;
  Result := Self;
end;

function TValor.ObterTexto: string;
begin
  Result := Self.FTexto;
end;

function TValor.Texto(const Texto: string): TValor;
begin
  Self.FTexto := Texto;
  Result := Self;
end;

{ TParameters }
function TMap.ComoDecimal: Real;
begin
  if Self.FValor <> nil then begin
    Result := Self.FValor.FDecimal;
    FreeAndNil(Self.FValor);
  end else begin
    Result := 0;
  end;
end;

function TMap.ComoInteiro: Integer;
begin
  if Self.FValor <> nil then begin
    Result := Self.FValor.FInteiro;
    FreeAndNil(Self.FValor);
  end else begin
    Result := 0;
  end;
end;

function TMap.ComoObjeto: TObject;
begin
  Result := Self.FObject;
  Self.FObject := nil;
end;

function TMap.ComoTexto: string;
begin
  if Self.FValor <> nil then begin
    Result := Self.FValor.ObterTexto;
    FreeAndNil(Self.FValor);
  end else begin
    Result := '';
  end;
end;

constructor TMap.Create;
begin
  inherited;
  Self.FMap := TStringList.Create;
end;

{ TMap }
function TMap.Gravar(const Chave, Valor: string): TMap;
begin
  Self.RemoveParametroSeExistir(Chave);
  Self.FMap.AddObject(Chave, TValor.Create().Texto(Valor));
  Result := Self;
end;

function TMap.Gravar(const Chave: string; Valor: Integer): TMap;
begin
  Self.RemoveParametroSeExistir(Chave);
  Self.FMap.AddObject(Chave, TValor.Create.Inteiro(Valor));
  Result := Self;
end;

function TMap.Gravar(const Chave: string; Valor: TObject): TMap;
begin
  Self.RemoveParametroSeExistir(Chave);
  Self.FMap.AddObject(Chave, Valor);
  Result := Self;
end;

function TMap.Gravar(const Chave: string; Valor: Real): TMap;
begin
  Self.RemoveParametroSeExistir(Chave);
  Self.FMap.AddObject(Chave, TValor.Create.Decimal(Valor));
  Result := Self;
end;

function TMap.Ler(const Chave: string): TMap;
var
  _indice: Integer;
begin
  _indice := Self.FMap.IndexOf(Chave);
  if _indice <> -1 then begin
    if (Self.FMap.Objects[_indice] is TValor) then begin
      Self.FValor := TValor(Self.FMap.Objects[_indice]);
    end else begin
      Self.FObject := Self.FMap.Objects[_indice];
    end;
    Self.RemoveParametroSeExistir(Chave);
  end else begin
    Self.FValor := nil;
  end;
  Result := Self;
end;

function TMap.Limpar: TMap;
begin
  Self.FMap.Clear();
  Result := Self;
end;

procedure TMap.RemoveParametroSeExistir(const Chave: string);
var
  _indice: Integer;
begin
  _indice := Self.FMap.IndexOf(Chave);
  if _indice <> -1 then begin
    Self.FMap.Delete(_indice);
  end;
end;

{ TFlMessages }
class function TMessages.Confirma(const Mensagem: string; ACanCancel: Boolean = False): Boolean;
var
  _view: TMensagemView;
begin
  _view := TMensagemView.Create(nil);
  try
    _view
      .Legenda('Confirme sua Ação.')
      .Mensagem(Mensagem + '?');
    Result := _view.ExibirConfirmacao = mrOk;
  finally
    FreeAndNil(_view);
  end;
end;

class function TMessages.GetCanceled: Boolean;
begin
  Result := FCanceled;
end;

class procedure TMessages.Mensagem(const Mensagem: string);
var
  _view: TMensagemView;
begin
  _view := TMensagemView.Create(nil);
  try
    _view
      .Legenda('Atenção!')
      .Mensagem(Mensagem)
      .ExibirMensagem
  finally
    FreeAndNil(_view);
  end;
end;

class procedure TMessages.MensagemErro(const Mensagem: string);
var
  _view: TMensagemView;
begin
  _view := TMensagemView.Create(nil);
  try
    _view
      .Legenda('Atenção! Ocorreu um Erro.')
      .Mensagem(Mensagem)
      .ExibirMensagemDeErro;
  finally
    FreeAndNil(_view);
  end;
end;

end.
