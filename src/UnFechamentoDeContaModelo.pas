unit UnFechamentoDeContaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnModelo, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, Pagamentos, Data.DBXFirebird;

type
  TFechamentoDeContaModelo = class(TModelo, IPagamentoDinheiro,
    IPagamentoCartaoDeDebito, IPagamentoCartaoDeCredito)
    dsCOMA_OID: TStringField;
    dsCOMA_DATA: TSQLTimeStampField;
    dsCOMA_COMANDA: TStringField;
    cdsCOMA_OID: TStringField;
    cdsCOMA_DATA: TSQLTimeStampField;
    cdsCOMA_COMANDA: TStringField;
    cdsSALDO_TOTAL: TAggregateField;
    cds_mcx: TClientDataSet;
    cds_mcxMCX_OID: TStringField;
    cds_mcxMCX_DATA: TSQLTimeStampField;
    cds_mcxMCX_TPORIG: TIntegerField;
    cds_mcxMCX_ORIG: TStringField;
    cds_mcxMCXOP_OID: TStringField;
    cds_mcxMCX_DC: TIntegerField;
    cds_mcxMCX_HISTORICO: TStringField;
    cds_mcxMCX_MPAG: TIntegerField;
    cds_mcxCART_OID: TStringField;
    dsr_mcx: TDataSource;
    ds_mcx: TSQLDataSet;
    ds_mcxMCX_OID: TStringField;
    ds_mcxMCX_DATA: TSQLTimeStampField;
    ds_mcxMCX_TPORIG: TIntegerField;
    ds_mcxMCX_ORIG: TStringField;
    ds_mcxMCXOP_OID: TStringField;
    ds_mcxMCX_DC: TIntegerField;
    ds_mcxMCX_HISTORICO: TStringField;
    ds_mcxMCX_MPAG: TIntegerField;
    ds_mcxCART_OID: TStringField;
    dsp_mcx: TDataSetProvider;
    cds_mcxTOTAL: TAggregateField;
    dsCL_COD: TStringField;
    cdsCL_COD: TStringField;
    dsCOMA_STT: TIntegerField;
    cdsCOMA_STT: TIntegerField;
    dsCOMA_CONSUMO: TFMTBCDField;
    dsCOMA_TXSERV: TFMTBCDField;
    dsCOMA_TOTAL: TFMTBCDField;
    dsCOMA_SALDO: TFMTBCDField;
    cdsCOMA_CONSUMO: TFMTBCDField;
    cdsCOMA_TOTAL: TFMTBCDField;
    cdsCOMA_TXSERV: TFMTBCDField;
    cdsCOMA_SALDO: TFMTBCDField;
    ds_mcxMCX_VALOR: TFMTBCDField;
    ds_mcxMCX_DINHEIRO: TFMTBCDField;
    ds_mcxMCX_TROCO: TFMTBCDField;
    cds_mcxMCX_VALOR: TFMTBCDField;
    cds_mcxMCX_DINHEIRO: TFMTBCDField;
    cds_mcxMCX_TROCO: TFMTBCDField;
    cds_detalhe: TClientDataSet;
    dsr_detalhe: TDataSource;
    ds_detalhe: TSQLDataSet;
    dsp_detalhe: TDataSetProvider;
    ds_detalheCOMAI_QTDE: TFMTBCDField;
    ds_detalhePRO_DES: TStringField;
    ds_detalheCOMAI_UNIT: TFMTBCDField;
    ds_detalheCOMAI_TOTAL: TFMTBCDField;
    cds_detalheCOMAI_QTDE: TFMTBCDField;
    cds_detalhePRO_DES: TStringField;
    cds_detalheCOMAI_UNIT: TFMTBCDField;
    cds_detalheCOMAI_TOTAL: TFMTBCDField;
    cds_detalhetotal: TAggregateField;
  protected
    function GetSQL: TSQL; override;
    procedure RegistrarPagamentoCartao(const Parametros: TMap; const Cartao: MeiosDePagamento);
  public
    function Salvar: TModelo; override;
  published
    procedure CarregarDetalhe(const ComandaOid: string);
    procedure FecharConta;
    procedure RegistrarPagamentoEmDinheiro(const Parametros: TMap);
    procedure RegistrarPagamentoCartaoDeDebito(const Parametros: TMap);
    procedure RegistrarPagamentoCartaoDeCredito(const Parametros: TMap);
    function RetornarNomeCliente: string;
  end;

var
  FechamentoDeContaModelo: TFechamentoDeContaModelo;

implementation

{$R *.dfm}

{ TFechamentoDeContaModelo }

procedure TFechamentoDeContaModelo.CarregarDetalhe(const ComandaOid: string);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_detalhe;
  _dataSet.Close;
  _dataSet.CommandText := 'SELECT I.COMAI_QTDE, P.PRO_DES, ' +
    'I.COMAI_UNIT, I.COMAI_TOTAL ' +
    'FROM COMAI I INNER JOIN PRO P ON I.PRO_OID = P.PRO_OID ' +
    'WHERE COMA_OID = :OID ' +
    'ORDER BY COMAI_OID';
  _dataSet.Params.ParamByName('OID').AsString := ComandaOid;
  _dataSet.Open;
end;

procedure TFechamentoDeContaModelo.FecharConta;
var
  _pagamento: Real;
begin
  _pagamento := StrToFloat(Self.cds_mcx.FieldByName('total').AsString);
  Self.cds.First;
  while (_pagamento > 0) and (not Self.cds.Eof) do
  begin
    Self.cds.Edit;
    if Self.cds.FieldByName('coma_saldo').AsFloat <= _pagamento then
    begin
      _pagamento := _pagamento - Self.cds.FieldByName('coma_saldo').AsCurrency;
      Self.cds.FieldByName('coma_saldo').AsCurrency := 0;
      Self.cds.FieldByName('coma_stt').AsInteger := Ord(scQuitada);
    end
    else
    begin
      Self.cds.FieldByName('coma_saldo').AsCurrency := Self.cds.FieldByName('coma_saldo').AsCurrency - _pagamento;
      _pagamento := 0;
    end;
    Self.cds.Post;
    Self.cds.Next;
  end;
  if Self.cds.ChangeCount >0 then
    Self.cds.ApplyUpdates(0);
end;

function TFechamentoDeContaModelo.GetSQL: TSQL;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('C.COMA_DATA, C.COMA_COMANDA, C.COMA_CONSUMO, C.COMA_TXSERV, ' +
        'C.COMA_TOTAL, C.COMA_SALDO, C.COMA_OID, C.COMA_STT, L.CL_COD')
      .from('COMA C INNER JOIN CL L ON C.CL_OID = L.CL_OID')
      .where(Format('C.COMA_STT = %s', [IntToStr(Ord(scPendente))])
      )
      .Order('C.COMA_DATA');
  Result := Self.FSql;
end;

procedure TFechamentoDeContaModelo.RegistrarPagamentoCartao(
  const Parametros: TMap; const Cartao: MeiosDePagamento);
var
  _valorPago: Real;
  _dataHora: TDateTime;
  _dataSet: TClientDataSet;
  _OidCartao, _cartao, _cliente: string;
begin
  _dataHora := Now;
  _OidCartao := Parametros.Ler('cart_oid').ComoTexto;
  _cartao := Parametros.Ler('cart_cod').ComoTexto;
  _valorPago := Parametros.Ler('valor').ComoDecimal;
  _cliente := Self.cds.FieldByName('cl_cod').AsString;
  // Registro de movimento de caixa
  _dataSet := Self.cds_mcx;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'mcx_oid');
  _dataSet.FieldByName('mcx_tporig').AsInteger := Ord(tomcFechamentoDeConta);
  _dataSet.FieldByName('mcx_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('mcx_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('mcxop_oid').AsString :=
    IntToStr(Ord(odcRecebimentoDeVendaAPrazo));
  _dataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('mcx_historico').AsString :=
    'RECEB. CARTÃO ' + _cartao + ' CLIENTE ' + _cliente;
  _dataSet.FieldByName('mcx_mpag').AsInteger := Ord(Cartao);
  _dataSet.FieldByName('cart_oid').AsString := _OidCartao;
  _dataSet.Post();
  Self
    .Salvar;
end;

procedure TFechamentoDeContaModelo.RegistrarPagamentoCartaoDeCredito(
  const Parametros: TMap);
begin
  Self.RegistrarPagamentoCartao(Parametros, mpagCartaoCredito);
end;

procedure TFechamentoDeContaModelo.RegistrarPagamentoCartaoDeDebito(
  const Parametros: TMap);
begin
  Self.RegistrarPagamentoCartao(Parametros, mpagCartaoDebito);
end;

procedure TFechamentoDeContaModelo.RegistrarPagamentoEmDinheiro(
  const Parametros: TMap);
var
  _valorPago, _dinheiro, _troco: Real;
  _dataHora: TDateTime;
  _dataSet: TClientDataSet;
  _cliente: string;
begin
  _dataHora := Now;
  _valorPago := Parametros.Ler('valor').ComoDecimal;
  _dinheiro := Parametros.Ler('dinheiro').ComoDecimal;
  _troco := Parametros.Ler('troco').ComoDecimal;
  _cliente := Self.cds.FieldByName('cl_cod').AsString;
  // Registro de movimento de caixa
  _dataSet := Self.cds_mcx;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'mcx_oid');
  _dataSet.FieldByName('mcx_tporig').AsInteger := Ord(tomcFechamentoDeConta);
  _dataSet.FieldByName('mcx_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('mcx_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('mcxop_oid').AsString := '7';
  _dataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('mcx_historico').AsString :=
    'RECEB. DINHEIRO CONTA ' + _cliente;
  _dataSet.FieldByName('mcx_mpag').AsInteger := Ord(mpagDinheiro);
  _dataSet.FieldByName('mcx_dinheiro').AsCurrency := _dinheiro;
  _dataSet.FieldByName('mcx_troco').AsCurrency := _troco;
  _dataSet.Post();
  Self
    .Salvar;
end;

function TFechamentoDeContaModelo.RetornarNomeCliente: string;
begin
  Self.Sql.Active := False;
  Self.Sql.CommandText := 'select cl_nome from cl where cl_cod = :oid';
  Self.Sql.ParamByName('oid').AsString := Self.cds.FieldByName('cl_cod').AsString;
  Self.Sql.Open;
  Result := Self.Sql.FieldByName('cl_nome').AsString;
  Self.Sql.Close;
end;

function TFechamentoDeContaModelo.Salvar: TModelo;
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.DataSet('mcx');
  if _dataSet.State in [dsEdit, dsInsert] then
    _dataSet.Post();
  if _dataSet.ChangeCount > 0 then
    _dataSet.ApplyUpdates(0);
  Result := Self;
end;

initialization
  RegisterClass(TFechamentoDeContaModelo);

end.
