unit UnVendaRapidaRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Data.DBXFirebird;

type
  TVendaRapidaRegistroModelo = class(TModelo)
    dsMCX_OID: TStringField;
    dsMCX_DATA: TSQLTimeStampField;
    dsMCX_TPORIG: TIntegerField;
    dsMCX_DC: TIntegerField;
    dsMCX_HISTORICO: TStringField;
    dsMCX_MPAG: TIntegerField;
    cdsMCX_OID: TStringField;
    cdsMCX_DATA: TSQLTimeStampField;
    cdsMCX_TPORIG: TIntegerField;
    cdsMCX_DC: TIntegerField;
    cdsMCX_HISTORICO: TStringField;
    cdsMCX_MPAG: TIntegerField;
    ds_usr: TSQLDataSet;
    dsp_usr: TDataSetProvider;
    cds_usr: TClientDataSet;
    dsr_usr: TDataSource;
    ds_usrUSR_NAME: TStringField;
    cds_usrUSR_NAME: TStringField;
    dsMCXOP_OID: TStringField;
    cdsMCXOP_OID: TStringField;
    dsMCX_VALOR: TFMTBCDField;
    dsMCX_DINHEIRO: TFMTBCDField;
    dsMCX_TROCO: TFMTBCDField;
    cdsMCX_VALOR: TFMTBCDField;
    cdsMCX_DINHEIRO: TFMTBCDField;
    cdsMCX_TROCO: TFMTBCDField;
    dsMCX_ORIG: TStringField;
    cdsMCX_ORIG: TStringField;
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSQL: TSQL; override;
  public
    procedure InserirVendaRapida(const Valor: Real; const Dinheiro: Real = 0;
      const Troco: Real = 0; const Produtos: string = ''; const ProdutoOid: string = ''; const Quantidade: Real = 0);
  end;

implementation

{$R *.dfm}

{ TVendaRapidaRegistroModelo }

function TVendaRapidaRegistroModelo.GetSQL: TSQL;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('MCX_OID, MCX_DATA, MCX_ORIG, MCX_TPORIG, MCXOP_OID, MCX_VALOR, MCX_DC, ' +
        'MCX_HISTORICO, MCX_MPAG, MCX_DINHEIRO, MCX_TROCO')
      .From('MCX')
      .Order('MCX_OID')
      .MetaDados('MCX_OID IS NULL');
  Result := Self.FSql;
end;

procedure TVendaRapidaRegistroModelo.InserirVendaRapida(const Valor: Real;
  const Dinheiro: Real = 0; const Troco: Real = 0; const Produtos: string = '';
  const ProdutoOid: string = ''; const Quantidade: Real = 0);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds;
  _dataSet.Append;
  _dataSet.FieldByName('mcx_data').AsDateTime := Date;
  _dataSet.FieldByName('mcx_valor').AsCurrency := Valor;
  _dataSet.FieldByName('mcx_orig').AsString := ProdutoOid;
  _dataSet.FieldByName('mcx_tporig').AsInteger := Ord(tomcVendaRapida);
  _dataSet.FieldByName('mcxop_oid').AsInteger := Ord(odcRecebimentoDeVenda);
  _dataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('mcx_mpag').AsInteger := Ord(mpagDinheiro);
  _dataSet.FieldByName('mcx_historico').AsString := Produtos;
  _dataSet.FieldByName('mcx_dinheiro').AsCurrency := Dinheiro;
  if ProdutoOid <> '' then
    _dataSet.FieldByName('mcx_troco').AsCurrency := Quantidade
  else
    _dataSet.FieldByName('mcx_troco').AsCurrency := Troco;
  _dataSet.Post;
  _dataSet.ApplyUpdates(-1);
end;

procedure TVendaRapidaRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'mcx_oid');
end;

initialization
  RegisterClass(TVendaRapidaRegistroModelo);

end.
