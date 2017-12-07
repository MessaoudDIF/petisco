unit UnCartaoDebitoModeloPesquisa;

interface

uses
  FMTBcd, DB, DBClient, Provider, Classes, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TCartaoDebitoModeloPesquisa = class(TModelo)
    dsCART_OID: TStringField;
    dsCART_COD: TStringField;
    cdsCART_OID: TStringField;
    cdsCART_COD: TStringField;
  protected
    function GetSQL: TSQL; override;
  end;

var
  CartaoDebitoModeloPesquisa: TCartaoDebitoModeloPesquisa;

implementation

{$R *.dfm}

{ TCartaoDebitoModeloPesquisa }

function TCartaoDebitoModeloPesquisa.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('cart_oid, cart_cod')
      .from('cart')
      .where('cart_dc = 1')
      .order('cart_cod');
  end;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TCartaoDebitoModeloPesquisa);

end.
