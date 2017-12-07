unit UnProdutoSearchModel;

interface

uses
  FMTBcd, DB, DBClient, Provider, Classes, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TProdutoSearchModel = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

var
  ProdutoSearchModel: TProdutoSearchModel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TProdutoModelSearch }

function TProdutoSearchModel.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create();
    Self.FSql
      .select('pro_oid, pro_cod, pro_des, pro_venda')
      .from('pro')
      .where('')
      .order('pro_des');
  end;
  Result := Self.FSql;
end;

end.
