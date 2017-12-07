unit UnPetiscoDashBoardModelo;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr,
  Controls, dbxInterbase, Data.DBXFirebird;

type
  TPetiscoDashBoardModelo = class(TDataModule)
    cnn: TSQLConnection;
    SqlProcessor: TSQLDataSet;
    ds: TSQLDataSet;
    dsp: TDataSetProvider;
    cds: TClientDataSet;
    dsr: TDataSource;
    cdsTOTAL: TAggregateField;
    ds_resultado: TSQLDataSet;
    dsp_resultado: TDataSetProvider;
    cds_resultado: TClientDataSet;
    dsr_resultado: TDataSource;
    dsSITUACAO: TIntegerField;
    dsTIT_DOC: TStringField;
    dsTIT_VENC: TDateField;
    dsTIT_VALOR: TFMTBCDField;
    dsTIT_HIST: TStringField;
    dsFORN_NOME: TStringField;
    dsTIT_OID: TStringField;
    cdsSITUACAO: TIntegerField;
    cdsTIT_DOC: TStringField;
    cdsTIT_VENC: TDateField;
    cdsTIT_VALOR: TFMTBCDField;
    cdsTIT_HIST: TStringField;
    cdsFORN_NOME: TStringField;
    cdsTIT_OID: TStringField;
    ds_resultadoRECEITAS: TFMTBCDField;
    ds_resultadoIMPOSTOS: TFMTBCDField;
    ds_resultadoDESPESAS_FIXAS: TFMTBCDField;
    ds_resultadoDESPESAS_VARIAVEIS: TFMTBCDField;
    cds_resultadoRECEITAS: TFMTBCDField;
    cds_resultadoIMPOSTOS: TFMTBCDField;
    cds_resultadoDESPESAS_FIXAS: TFMTBCDField;
    cds_resultadoDESPESAS_VARIAVEIS: TFMTBCDField;
    procedure cnnBeforeConnect(Sender: TObject);
  public
    function CarregarContasPagar(
      const DataInicial, DataFinal: TDate): TDataModule;
    function CarregarResultado(
      const DataInicial, DataFinal: TDate): TDataModule;
  end;

implementation

{$R *.dfm}

{ TPetiscoDashBoardModel }

function TPetiscoDashBoardModelo.CarregarContasPagar(
  const DataInicial, DataFinal: TDate): TDataModule;
begin
  { Contas a Pagar }
  Self.cds.Active := False;
  Self.cds.CommandText := 'SELECT 0 SITUACAO, T.TIT_DOC, T.TIT_VENC, ' +
    ' T.TIT_VALOR, T.TIT_HIST, F.FORN_NOME, TIT_OID' +
    ' FROM TIT T INNER JOIN FORN F ON T.FORN_OID = F.FORN_OID ' +
    ' WHERE T.TIT_VENC BETWEEN :INICIO AND :FIM' +
    ' ORDER BY T.TIT_VENC';
  Self.cds.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.cds.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.cds.Open;
  { Resumo para Gráfico }
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT TIT_VENC, SUM(TIT_VALOR) TOTAL' +
    ' FROM TIT' +
    ' WHERE TIT_VENC BETWEEN :INICIO AND :FIM' +
    ' GROUP BY TIT_VENC' +
    ' ORDER BY TIT_VENC';
  Self.SqlProcessor.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.SqlProcessor.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.SqlProcessor.Open;
  Result := Self;
end;

function TPetiscoDashBoardModelo.CarregarResultado(const DataInicial,
  DataFinal: TDate): TDataModule;
var
  _receitas, _impostos, _despesasFixas, _despesasVariaveis: Real;
begin
  { RECEITAS }
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT SUM(RECEITAS) RECEITAS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) RECEITAS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 0 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) RECEITAS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 0 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.SqlProcessor.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.SqlProcessor.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.SqlProcessor.Open;
  _receitas := Self.SqlProcessor.FieldByName('RECEITAS').AsCurrency;
  { IMPOSTOS }
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT SUM(IMPOSTOS) IMPOSTOS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) IMPOSTOS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 1 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) IMPOSTOS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 1 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.SqlProcessor.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.SqlProcessor.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.SqlProcessor.Open;
  _impostos := Self.SqlProcessor.FieldByName('IMPOSTOS').AsCurrency;
  { DESPESAS FIXAS }
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT SUM(DESPESAS_FIXAS) DESPESAS_FIXAS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) DESPESAS_FIXAS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 2 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) DESPESAS_FIXAS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 2 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.SqlProcessor.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.SqlProcessor.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.SqlProcessor.Open;
  _despesasFixas := Self.SqlProcessor.FieldByName('DESPESAS_FIXAS').AsCurrency;
  { DESPESAS VARIÁVEIS }
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT SUM(DESPESAS_VARIAVEIS) DESPESAS_VARIAVEIS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) DESPESAS_VARIAVEIS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 3 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) DESPESAS_VARIAVEIS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 3 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.SqlProcessor.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.SqlProcessor.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.SqlProcessor.Open;
  _despesasVariaveis := Self.SqlProcessor.FieldByName('DESPESAS_VARIAVEIS').AsCurrency;
  { Registra Resultados }
  Self.cds_resultado.Active := True;
  Self.cds_resultado.Append;
  Self.cds_resultado.FieldByName('RECEITAS').AsCurrency := _receitas;
  Self.cds_resultado.FieldByName('IMPOSTOS').AsCurrency := _impostos;
  Self.cds_resultado.FieldByName('DESPESAS_FIXAS').AsCurrency := _despesasFixas;
  Self.cds_resultado.FieldByName('DESPESAS_VARIAVEIS').AsCurrency := _despesasVariaveis;
  Self.cds_resultado.Post;
  Result := Self;
end;

procedure TPetiscoDashBoardModelo.cnnBeforeConnect(Sender: TObject);
begin
  Self.cnn.LoadParamsFromIniFile('.\dbx.ini');
end;

end.
