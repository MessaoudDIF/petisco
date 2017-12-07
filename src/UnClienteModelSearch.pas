unit UnClienteModelSearch;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TClienteModelSearch = class(TModelo)
  private
    FSql: TSQL;
  protected
    function GetSQL: TSQL; override;
  end;

var
  ClienteModelSearch: TClienteModelSearch;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TModel1 }

function TClienteModelSearch.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('cl_oid, cl_cod, cl_nome')
      .from('cl')
      .order('cl_cod');
  end;
  Result := Self.FSql;
end;

end.
