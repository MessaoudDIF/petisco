unit UnClienteModelPesquisa;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo, DBXpress;

type
  TClienteModeloPesquisa = class(TModelo)
    dsCL_OID: TStringField;
    dsCL_COD: TStringField;
    dsCL_NOME: TStringField;
    cdsCL_OID: TStringField;
    cdsCL_COD: TStringField;
    cdsCL_NOME: TStringField;
  private
    FSql: TSQL;
  protected
    function GetSQL: TSQL; override;
  end;

var
  ClienteModeloPesquisa: TClienteModeloPesquisa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TModel1 }

function TClienteModeloPesquisa.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('cl_oid, cl_cod, cl_nome')
      .from('cl')
      .order('cl_cod')
      .MetaDados('cl_oid is null');
  end;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TClienteModeloPesquisa);

end.
