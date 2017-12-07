unit UnBancoPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TBancoPesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TBancoPesquisaModelo }

function TBancoPesquisaModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('BancoPesquisaModelo');
    Self.FDominio.Sql
      .Select('BAN_OID, BAN_COD, BAN_NOME')
      .From('BAN')
      .Order('BAN_NOME')
      .Metadados('BAN_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('BAN_COD', 'Número', 5))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('BAN_NOME', 'Banco', 30))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TBancoPesquisaModelo);

end.
