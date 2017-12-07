unit UnCentroDeResultadoPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  UnModelo, Util, DataUtil, Dominio;

type
  TCentroDeResultadoPesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

var
  CentroDeResultadoPesquisaModelo: TCentroDeResultadoPesquisaModelo;

implementation

{$R *.dfm}

{ TCentroResultadoPesquisaModelo }

function TCentroDeResultadoPesquisaModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('BancoPesquisaModelo');
    Self.FDominio.Sql
      .Select('CRES_OID, CRES_COD, CRES_DES')
      .From('CRES')
      .Order('CRES_DES')
      .MetaDados('CRES_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CRES_DES', 'Centro de Resultado', 35));
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TCentroDeResultadoPesquisaModelo);

end.
