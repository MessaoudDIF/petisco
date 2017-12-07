unit UnCaixaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnModelo, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil;

type
  TCaixaModelo = class(TModelo)
    ds_extrato: TSQLDataSet;
    dsp_extrato: TDataSetProvider;
    cds_extrato: TClientDataSet;
    dsr_extrato: TDataSource;
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSQL: TSQL; override;
  public
    function EhValido: Boolean; override;
    procedure CarregarExtrato(const DataInicial, DataFinal: TDate);
  end;

implementation

{$R *.dfm}

uses
  { Fluente }
  CaixaAplicacao;

{ TCaixaModelo }

function TCaixaModelo.EhValido: Boolean;
var
  _dataSet: TClientDataSet;
begin
  Result := True;
  _dataSet := Self.DataSet;
  Self.FDataUtil.PostChanges(_dataSet);
  if (_dataSet.FieldByName('mcx_valor').AsString = '')
    or (_dataSet.FieldByName('mcx_valor').AsFloat <= 0) then
    Result := False
  else
    if _dataSet.FieldByName('mcx_historico').AsString = '' then
      Result := False;
end;

function TCaixaModelo.GetSQL: TSQL;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('MCX_OID, MCXOP_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR, MCX_DC, ' +
        'MCX_HISTORICO, MCX_MPAG')
      .From('MCX')
      .Order('MCX_OID')
      .Metadados('MCX_OID IS NULL');
  Result := Self.FSql;
end;

procedure TCaixaModelo.cdsBeforePost(DataSet: TDataSet);
var
  _operacaoDeCaixa: OperacoesDeCaixa;
begin
  inherited;
  // Gera OID se necessário
  Self.FDataUtil.OidVerify(DataSet, 'mcx_oid');
  // campos com valor pré-definidos
  DataSet.FieldByName('mcx_data').AsDateTime := Now;
  DataSet.FieldByName('mcx_tporig').AsInteger := Ord(tomcCaixa);
  DataSet.FieldByName('mcx_mpag').AsInteger := Ord(mpagDinheiro);
  // débito ou crédito
  _operacaoDeCaixa := RetornarOperacaoDeCaixa(
    Self.Parametros.Ler('operacao').ComoInteiro);
  if _operacaoDeCaixa in [odcAbertura, odcTroco, odcSuprimento] then
    DataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito)
  else
    DataSet.FieldByName('mcx_dc').AsInteger := Ord(dcDebito);
  // operação de caixa
  DataSet.FieldByName('mcxop_oid').AsString := IntTostr(Ord(_operacaoDeCaixa));
end;

procedure TCaixaModelo.CarregarExtrato(const DataInicial,
  DataFinal: TDate);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_extrato;
  _dataSet.Active := False;
  _dataSet.CommandText := 'SELECT MCX_OID, MCX_DATA, MCX_TPORIG, MCX_VALOR, ' +
    'MCXOP_OID, MCX_DC, MCX_HISTORICO, MCX_MPAG ' +
    'FROM MCX '+
    'WHERE CAST(MCX_DATA AS DATE) BETWEEN :INICIO AND :FIM ' +
    'ORDER BY MCX_OID';
  _dataSet.Params.ParamByName('INICIO').AsDate := DataInicial;
  _dataSet.Params.ParamByName('FIM').AsDate := DataFinal;
  _dataSet.Open;
end;

initialization
  RegisterClass(TCaixaModelo);

end.
