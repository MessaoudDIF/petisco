unit UnCartaoCreditoModeloPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo;

type
  TCartaoCreditoModeloPesquisa = class(TModelo)
    dsCART_OID: TStringField;
    dsCART_COD: TStringField;
    cdsCART_OID: TStringField;
    cdsCART_COD: TStringField;
  protected
    function GetSQL: TSQL; override;
  public
  end;

var
  CartaoCreditoModeloPesquisa: TCartaoCreditoModeloPesquisa;

implementation

{$R *.dfm}

{ TCartaoCreditoModeloPesquisa }

function TCartaoCreditoModeloPesquisa.GetSQL: TSQL;
begin
  if Self.FSql = nil then
  begin
    Self.FSql := TSQL.Create()
      .select('cart_oid, cart_cod')
      .from('cart')
      .where('cart_dc = 2')
      .order('cart_cod');
  end;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TCartaoCreditoModeloPesquisa);

end.
