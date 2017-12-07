unit UnCartaoDebitoSearchModel;

interface

uses
  FMTBcd, DB, DBClient, Provider, Classes, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TCartaoDebitoSearchModel = class(TModelo)
  private
    FSql: TSQL;
  protected
    function GetSQL: TSQL; override;
  end;

var
  CartaoDebitoSearchModel: TCartaoDebitoSearchModel;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCartaoDebitoSearchModel }

function TCartaoDebitoSearchModel.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('cart_oid, cart_cod, cart_des')
      .from('cart')
      .where('cart_dc = 1')
      .order('cart_cod');
  end;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TCartaoDebitoSearchModel);

end.
