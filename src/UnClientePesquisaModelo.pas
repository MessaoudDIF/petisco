unit UnClientePesquisaModelo;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo, Dominio;

type
  TClientePesquisaModelo = class(TModelo)
  private
  protected
    function GetSQL: TSQL; override;
  end;

var
  ClientePesquisaModelo: TClientePesquisaModelo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TModel1 }

function TClientePesquisaModelo.GetSQL: TSQL;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('ClientePesquisaModelo');
    Self.FDominio.Sql
      .select('CL_OID, CL_COD, CL_NOME')
      .from('CL')
      .order('CL_NOME')
      .MetaDados('CL_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_COD', 'Cliente', 35));
  end;
  Result := Self.FDominio.Sql;  
end;

initialization
  RegisterClass(TClientePesquisaModelo);

end.
