unit UnCentroResultadoPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  UnModelo, Util, DataUtil, DBXpress;

type
  TCentroDeResultadoPesquisaModelo = class(TModelo)
    dsCRES_OID: TStringField;
    dsCRES_COD: TStringField;
    dsCRES_DES: TStringField;
    cdsCRES_OID: TStringField;
    cdsCRES_COD: TStringField;
    cdsCRES_DES: TStringField;
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
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('CRES_OID, CRES_COD, CRES_DES')
      .From('CRES')
      .Order('CRES_DES')
      .MetaDados('CRES_OID IS NULL');
  Result := Self.FSql;
end;

initialization
  RegisterClass(TCentroDeResultadoPesquisaModelo);

end.
