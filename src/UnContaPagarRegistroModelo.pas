unit UnContaPagarRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo;

type
  TContaPagarRegistroModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

var
  ContaPagarRegistroModelo: TContaPagarRegistroModelo;

implementation

{$R *.dfm}

{ TContaPagarRegistroModelo }

function TContaPagarRegistroModelo.EhValido: Boolean;
begin
  Result := inherited EhValido;

end;

function TContaPagarRegistroModelo.GetSql: TSql;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('T.TIT_OID, T.FORN_OID, T.CATS_OID, T.CRES_OID, T.TIT_DOC, ' +
        ' T.TIT_EMIS, T.TIT_VENC, T.TIT_VALOR, T.TIT_HIST, T.TIT_LIQ, ' +
        ' T.TIT_PAGO, F.FORN_NOME, C.CATS_DES, R.CRES_DES')
      .From('TIT T INNER JOIN FORN F ON T.FORN_OID = F.FORN_OID ' +
        ' INNER JOIN CATS C ON T.CATS_OID = C.CATS_OID ' +
        ' LEFT JOIN CRES R ON T.CRES_OID = R.CRES_OID')
      .Order('TIT_OID')
      .MetaDados('TIT_OID IS NULL');
  Result := Self.FSql;
end;

initialization
  RegisterClass(TContaPagarRegistroModelo)

end.
