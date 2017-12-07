unit UnRelatorioModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo;

type
  TRelatorioModelo = class(TModelo)
    SqlTemp: TSQLDataSet;
  protected
    function GetSQL: TSql; override;
  public
    procedure CarregarResultadoGeral(const DataInicial, DataFinal: TDate); overload;
    procedure CarregarResultadoGeral(const Mes: string;
      const DataInicial, DataFinal: TDate); overload;
  end;

implementation

uses DateUtils;

{$R *.dfm}

{ TRelatorioModelo }

procedure TRelatorioModelo.CarregarResultadoGeral(const DataInicial,
  DataFinal: TDate);
var
  _meses: TMap;
  _mes, _ano: Integer;
  _dataSet: TClientDataSet;
  _competenciaInicial, _competenciaFinal: string;

  function RetornarDataTexto(const Dia, Mes, Ano: Integer): string;
  begin
    Result := Self.FUtil.Text.EZeros(IntToStr(Dia), 2) + '/' +
      Self.FUtil.Text.EZeros(IntToStr(Mes), 2) + '/' +
      Self.FUtil.Text.EZeros(IntToStr(Ano), 4);
  end;
begin
  _meses := TMap.Create
    .Gravar('1', 'JAN_')
    .Gravar('2', 'FEV_')
    .Gravar('3', 'MAR_')
    .Gravar('4', 'ABR_')
    .Gravar('5', 'MAI_')
    .Gravar('6', 'JUN_')
    .Gravar('7', 'JUL_')
    .Gravar('8', 'AGO_')
    .Gravar('9', 'SET_')
    .Gravar('10', 'OUT_')
    .Gravar('11', 'NOV_')
    .Gravar('12', 'DEZ_');
  _dataSet := Self.cds;
  _dataSet.Active := False;
  _dataSet.CommandText := 'SELECT CAT_OID, CAT_DES CATEGORIA, ' +
    'ESCLR_MOEDA JAN_, ' +
    'ESCLR_MOEDA FEV_, ' +
    'ESCLR_MOEDA MAR_, ' +
    'ESCLR_MOEDA ABR_, ' +
    'ESCLR_MOEDA MAI_, ' +
    'ESCLR_MOEDA JUN_, ' +
    'ESCLR_MOEDA JUL_, ' +
    'ESCLR_MOEDA AGO_, ' +
    'ESCLR_MOEDA SET_, ' +
    'ESCLR_MOEDA OUT_, ' +
    'ESCLR_MOEDA NOV_, ' +
    'ESCLR_MOEDA DEZ_ ' +
    'FROM CAT, ESCLR ' +
    'UNION ' +
    'SELECT 5 CAT_OID, ' + QuotedStr('RESULTADO') + ' CATEGORIA, ' +
    'ESCLR_MOEDA JAN_, ' +
    'ESCLR_MOEDA FEV_, ' +
    'ESCLR_MOEDA MAR_, ' +
    'ESCLR_MOEDA ABR_, ' +
    'ESCLR_MOEDA MAI_, ' +
    'ESCLR_MOEDA JUN_, ' +
    'ESCLR_MOEDA JUL_, ' +
    'ESCLR_MOEDA AGO_, ' +
    'ESCLR_MOEDA SET_, ' +
    'ESCLR_MOEDA OUT_, ' +
    'ESCLR_MOEDA NOV_, ' +
    'ESCLR_MOEDA DEZ_ ' +
    'FROM ESCLR ' +
    'ORDER BY 1';
  _dataSet.Open;
  _competenciaInicial := FormatDateTime('yyyymm', DataInicial);
  _competenciaFinal := FormatDateTime('yyyymm', DataFinal);
  if _competenciaInicial = _competenciaFinal then
    Self.CarregarResultadoGeral('JAN_', DataInicial, DataFinal)
  else
  begin
    _competenciaInicial := FormatDateTime('yyyy', DataInicial);
    Self.SqlTemp.Active := False;
    Self.SqlTemp.CommandText := 'SELECT DISTINCT COMPETENCIA ' +
      'FROM ( ' +
      'SELECT DISTINCT EXTRACT(YEAR FROM CCORMV_DATA) || LPAD(EXTRACT(MONTH FROM CCORMV_DATA), 2, ''0'') COMPETENCIA ' +
      'FROM CCORMV ' +
      'WHERE EXTRACT(YEAR FROM CCORMV_DATA) = :ANO ' +
      'UNION ' +
      'SELECT DISTINCT EXTRACT(YEAR FROM CXMV_DATA) || LPAD(EXTRACT(MONTH FROM CXMV_DATA), 2, ''0'') COMPETENCIA ' +
      'FROM CXMV ' +
      'WHERE EXTRACT(YEAR FROM CXMV_DATA) = :ANO ' +
      ') ORDER BY COMPETENCIA';
    Self.SqlTemp.Params.ParamByName('ANO').AsSmallInt := StrToInt(_competenciaInicial);
    Self.SqlTemp.Open;
    Self.SqlTemp.First;
    while not Self.SqlTemp.Eof do
    begin
      _mes := StrToInt(Copy(Self.SqlTemp.FieldByName('competencia').AsString, 5, 2));
      _ano := StrToInt(Copy(Self.SqlTemp.FieldByName('competencia').AsString, 1, 4));
      _competenciaInicial := '01' + '/' + IntToStr(_mes) + '/' + IntToStr(_ano);
      _competenciaFinal := IntToStr(DaysInAMonth(_ano, _mes)) + '/' + IntToStr(_mes) + '/' + IntToStr(_ano);
      Self.CarregarResultadoGeral(_meses.Ler(IntToStr(_mes)).ComoTexto, StrToDate(_competenciaInicial), StrToDate(_competenciaFinal));
      Self.SqlTemp.Next;
    end;
  end;
end;

procedure TRelatorioModelo.CarregarResultadoGeral(const Mes: string;
  const DataInicial, DataFinal: TDate);
var
  _receitas, _impostos, _despesasFixas, _despesasVariaveis: Real;
begin
  { RECEITAS }
  Self.Sql.Active := False;
  Self.Sql.CommandText := 'SELECT SUM(RECEITAS) RECEITAS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) RECEITAS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 0 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) RECEITAS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 0 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.Sql.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.Sql.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.Sql.Open;
  _receitas := Self.Sql.FieldByName('RECEITAS').AsCurrency;
  { IMPOSTOS }
  Self.Sql.Active := False;
  Self.Sql.CommandText := 'SELECT SUM(IMPOSTOS) IMPOSTOS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) IMPOSTOS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 3 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) IMPOSTOS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 3 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.Sql.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.Sql.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.Sql.Open;
  _impostos := Self.Sql.FieldByName('IMPOSTOS').AsCurrency;
  { DESPESAS FIXAS }
  Self.Sql.Active := False;
  Self.Sql.CommandText := 'SELECT SUM(DESPESAS_FIXAS) DESPESAS_FIXAS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) DESPESAS_FIXAS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 1 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) DESPESAS_FIXAS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 1 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.Sql.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.Sql.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.Sql.Open;
  _despesasFixas := Self.Sql.FieldByName('DESPESAS_FIXAS').AsCurrency;
  { DESPESAS VARIÁVEIS }
  Self.Sql.Active := False;
  Self.Sql.CommandText := 'SELECT SUM(DESPESAS_VARIAVEIS) DESPESAS_VARIAVEIS ' +
    'FROM ( ' +
      'SELECT SUM(CXMV_VALOR) DESPESAS_VARIAVEIS ' +
      'FROM CXMV ' +
      'WHERE CAT_OID = 2 AND CXMV_DATA BETWEEN :INICIO AND :FIM ' +
      'UNION ' +
      'SELECT SUM(CCORMV_VALOR) DESPESAS_VARIAVEIS ' +
      'FROM CCORMV ' +
      'WHERE CAT_OID = 2 AND CCORMV_DATA BETWEEN :INICIO AND :FIM' +
    ')';
  Self.Sql.Params.ParamByName('INICIO').AsDate := DataInicial;
  Self.Sql.Params.ParamByName('FIM').AsDate := DataFinal;
  Self.Sql.Open;
  _despesasVariaveis := Self.Sql.FieldByName('DESPESAS_VARIAVEIS').AsCurrency;
  { Registra Resultados }
  Self.cds.First;
  Self.cds.Edit;
  Self.cds.FieldByName(Mes).AsCurrency := _receitas;
  Self.cds.Next;
  Self.cds.Edit;
  Self.cds.FieldByName(Mes).AsCurrency := _impostos;
  Self.cds.Next;
  Self.cds.Edit;
  Self.cds.FieldByName(Mes).AsCurrency := _despesasFixas;
  Self.cds.Next;
  Self.cds.Edit;
  Self.cds.FieldByName(Mes).AsCurrency := _despesasVariaveis;
  Self.cds.Next;
  Self.cds.Edit;
  Self.cds.FieldByName(Mes).AsCurrency := _receitas - _impostos -
    _despesasFixas - _despesasVariaveis;
  Self.cds.Post;
end;

function TRelatorioModelo.GetSQL: TSql;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create;
  Result := Self.FSql;
end;

initialization
  RegisterClass(TRelatorioModelo);

end.
