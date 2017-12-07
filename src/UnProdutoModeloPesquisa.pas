unit UnProdutoModeloPesquisa;

interface

uses
  FMTBcd, DB, DBClient, Provider, Classes, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TProdutoPesquisaModelo = class(TModelo)
    dsPRO_OID: TStringField;
    dsPRO_COD: TStringField;
    dsPRO_DES: TStringField;
    cdsPRO_OID: TStringField;
    cdsPRO_COD: TStringField;
    cdsPRO_DES: TStringField;
    dsPRO_VENDA: TBCDField;
    cdsPRO_VENDA: TBCDField;
  protected
    function GetSql: TSql; override;
  end;

var
  ProdutoPesquisaModelo: TProdutoPesquisaModelo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TProdutoModelSearch }

function TProdutoPesquisaModelo.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('pro_oid, pro_cod, pro_des, pro_venda')
      .from('pro')
      .order('pro_des')
      .MetaDados('pro_oid is null');
  end;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TProdutoPesquisaModelo);

end.
