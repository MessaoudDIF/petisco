unit UnPetiscoDashBoardModel;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, DBClient, Provider, SqlExpr,
  Controls;

type
  TPetiscoDashBoardModel = class(TDataModule)
    cnn: TSQLConnection;
    SqlProcessor: TSQLDataSet;
    ds: TSQLDataSet;
    dsp: TDataSetProvider;
    cds: TClientDataSet;
    dsr: TDataSource;
    dsTIT_DOC: TStringField;
    dsTIT_VENC: TDateField;
    dsTIT_VALOR: TBCDField;
    dsTIT_HIST: TStringField;
    dsFORN_NOME: TStringField;
    cdsTIT_DOC: TStringField;
    cdsTIT_VENC: TDateField;
    cdsTIT_VALOR: TBCDField;
    cdsTIT_HIST: TStringField;
    cdsFORN_NOME: TStringField;
    cdsTOTAL: TAggregateField;
    dsSITUACAO: TIntegerField;
    cdsSITUACAO: TIntegerField;
    dsTIT_OID: TStringField;
    cdsTIT_OID: TStringField;
    procedure cnnBeforeConnect(Sender: TObject);
  public
    function CarregarContasPagar(
      const DataInicial, DataFinal: TDate): TDataModule;
  end;

implementation

{$R *.dfm}

{ TPetiscoDashBoardModel }

function TPetiscoDashBoardModel.CarregarContasPagar(
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

procedure TPetiscoDashBoardModel.cnnBeforeConnect(Sender: TObject);
begin
  Self.cnn.LoadParamsFromIniFile('.\dbx.ini');
end;

end.
