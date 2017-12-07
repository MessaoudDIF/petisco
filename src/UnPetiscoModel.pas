unit UnPetiscoModel;

interface

uses
  SysUtils, Classes, DB, SqlExpr, FMTBcd, Provider, DBClient, Data.DBXInterBase, Data.DBXFirebird,
  { helsonsant }
  DataUtil;

type
  StatusFichaCliente = (sfcRegular, sfcIrregular);
  
  TPetiscoModel = class(TDataModule)
    cnn: TSQLConnection;
    SqlProcessor: TSQLDataSet;
    ds: TSQLDataSet;
    dsCOMA_OID: TStringField;
    dsCL_OID: TStringField;
    dsCOMA_COMANDA: TStringField;
    dsCOMA_DATA: TSQLTimeStampField;
    dsCOMA_CONSUMO: TBCDField;
    dsCOMA_TXSERV: TBCDField;
    dsCOMA_TOTAL: TBCDField;
    dsCOMA_SALDO: TBCDField;
    dsCOMA_STT: TIntegerField;
    dsCOMA_MESA: TIntegerField;
    dsp: TDataSetProvider;
    cds: TClientDataSet;
    cdsCOMA_OID: TStringField;
    cdsCL_OID: TStringField;
    cdsCOMA_COMANDA: TStringField;
    cdsCOMA_DATA: TSQLTimeStampField;
    cdsCOMA_CONSUMO: TBCDField;
    cdsCOMA_TXSERV: TBCDField;
    cdsCOMA_TOTAL: TBCDField;
    cdsCOMA_SALDO: TBCDField;
    cdsCOMA_STT: TIntegerField;
    cdsCOMA_MESA: TIntegerField;
    cdstotal: TAggregateField;
    procedure cnnBeforeConnect(Sender: TObject);
  private
  public
    function CarregarComandasEmAberto: TPetiscoModel;
    function DataSet(const NomeDataSet: string = ''): TDataSet;
    function RetornarStatusFichaCliente(const Cliente: string): StatusFichaCliente;
  end;

implementation

{$R *.dfm}

{ TPetiscoModel }

function TPetiscoModel.CarregarComandasEmAberto: TPetiscoModel;
var
  _Sql: TSQLDataSet;
begin
  _Sql := Self.SqlProcessor;
  _Sql.Active := False;
  _Sql.CommandText := Format('SELECT C.COMA_OID, C.CL_OID, C.COMA_MESA, ' +
    ' C.COMA_CONSUMO, C.COMA_SALDO, C.COMA_STT, L.CL_COD, C.COMA_CLIENTE  ' +
    ' FROM COMA C LEFT JOIN CL L ON C.CL_OID = L.CL_OID ' +
    ' WHERE C.COMA_SALDO > %s  AND C.COMA_STT = %s ' +
    ' ORDER BY C.COMA_OID', ['0', IntToStr(Ord(scAberta))]);
  _Sql.Open;
  Result := Self;
end;

function TPetiscoModel.DataSet(const NomeDataSet: string): TDataSet;
var
  _dataSet: TComponent;
begin
  if NomeDataSet = '' then
    _dataSet := Self.SqlProcessor
  else
    _dataSet := Self.FindComponent(NomeDataSet);
  if (_dataSet <> nil) and (_dataSet is TDataSet) then
    Result := (_dataSet as TDataSet)
  else
    Result := nil;
end;

procedure TPetiscoModel.cnnBeforeConnect(Sender: TObject);
begin
  Self.cnn.LoadParamsFromIniFile('.\dbx.ini');
end;

function TPetiscoModel.RetornarStatusFichaCliente(const Cliente: string): StatusFichaCliente;
var
  _carencia: Integer;
  _limite: Real;
begin
  Result := sfcRegular;
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT CL_LIMITE, CL_CARENCIA ' +
    ' FROM CL ' +
    ' WHERE CL_OID = :CLIENTE ';
  Self.SqlProcessor.Params.ParamByName('CLIENTE').AsString := Cliente;
  Self.SqlProcessor.Open;
  _limite := Self.SqlProcessor.FieldByName('cl_limite').AsFloat;
  _carencia := Self.SqlProcessor.FieldByName('cl_carencia').AsInteger;
  Self.SqlProcessor.Active := False;
  Self.SqlProcessor.CommandText := 'SELECT SUM(COMA_SALDO) SALDO, ' +
    'MIN(COMA_DATA) DESDE ' +
    'FROM COMA ' +
    'WHERE CL_OID = :CLIENTE AND COMA_STT = ' + IntToStr(Ord(scPendente));
  Self.SqlProcessor.Params.ParamByName('CLIENTE').AsString := Cliente;
  Self.SqlProcessor.Open;
  if (Self.SqlProcessor.FieldByName('desde').AsDateTime > 0) and
    ((Self.SqlProcessor.FieldByName('desde').AsDateTime + _carencia) < Date) then
    Result := sfcIrregular
  else
    if (Self.SqlProcessor.FieldByName('saldo').AsFloat > _limite) then
      Result := sfcIrregular;
  Self.SqlProcessor.Close;
end;

end.
