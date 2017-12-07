unit UnCategoriaPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  UnModelo, Util, DataUtil,Dominio;

type
  TCategoriaPesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

var
  CategoriaPesquisaModelo: TCategoriaPesquisaModelo;

implementation

{$R *.dfm}

{ TCategoriaPesquisaModelo }

function TCategoriaPesquisaModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('CategoriaPesquisaModelo');
    Self.FDominio.Sql
      .Select('S.CATS_OID, S.CATS_COD, S.CATS_DES')
      .From('CATS S INNER JOIN CAT C ON S.CAT_OID = C.CAT_OID')
      .Order('S.CATS_DES')
      .MetaDados('S.CATS_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CATS_DES', 'Categoria', 35));
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TCategoriaPesquisaModelo);

end.
