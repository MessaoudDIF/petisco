unit DataUtil;

interface

uses SysUtils, Classes, DB, SqlExpr, DBClient, Controls, Variants,
  { helsonsant }
  Util;

type
  { Acoes de Registro }
  AcaoDeRegistro = (adrIncluir, adrCarregar, adrExcluir, adrOutra);

  { Operacao de Registro }
  OperacaoDeRegistro = (odrIncluir, odrAlterar, odrExcluir, odrInativar);

  { Status de Registro  }
  StatusRegistro = (srAtivo, srInativo, srExcluido, srCancelado);

  { Status de Comanda }
  StatusComanda = (scAberta, scPendente, scQuitada);

  { Débito e Crédito }
  DebitoCredito = (dcDebito, dcCredito);

  { Tipos de Origem de Movimento de Caixa }
  TiposDeOrigemDeMovimentoDeCaixa = (tomcComanda, tomcFechamentoDeConta,
    tomcCaixa, tomcVendaRapida);

  { Meios de Pagamento }
  MeiosDePagamento = (mpagDinheiro, mpagCartaoDebito, mpagCartaoCredito,
    mpagCheque, mpagBoleto, mpagNotaPromissoria, mpagDuplicata);

  { Operações de Caixa }
  OperacoesDeCaixa = (odcAbertura, odcTroco, odcSaida, odcSuprimento,
    odcSangria, odcFechamento, odcRecebimentoDeVenda,
    odcRecebimentoDeVendaAPrazo, odcExtrato);

  TSql = class
  private
    FSelect: string;
    FFrom: string;
    FWhere: string;
    FGroup: string;
    FHaving: string;
    FOrder: string;
    FMetaDados: string;
    FCondicaoDeJuncao: string;
  public
    function Select(const Select: string): TSql;
    function From(const From: string): TSql;
    function Where(const Where: string): TSql;
    function Group(const Group: string): TSql;
    function Having(const Having: string): TSql;
    function Order(const Order: string): TSql;
    function CondicaoDeJuncao(const CondicaoDeJuncao: string): TSql;
    function ObterSql: string;
    function ObterSqlComCondicaoDeJuncao: string;
    function ObterSqlFiltrado(const Filtro: string): string;
    function ObterSqlMetadados: string;
    function MetaDados(const MetaDados: string): TSql;
  end;

  TTipoCriterio = (tcIgual, tcComo, tcEntre, tcMaior, tcMenor, tcMaiorOuIgual,
    tcMenorOuIgual);

  Criterio = class of TCriterio;

  TCriterio = class
  public
    class function Campo(const NomeCampo: string): Criterio;
    class function Igual(const Valor: Variant): Criterio;
    class function Como(const Valor: string): Criterio;
    class function Entre(const ValorInicial: Variant): Criterio;
    class function E(const ValorFinal: Variant): Criterio;
    class function MaiorQue(const Valor: Variant): Criterio;
    class function MaiorOuIgualQue(const Valor: Variant): Criterio;
    class function MenorQue(const Valor: Variant): Criterio;
    class function MenorOuIgualQue(const Valor: Variant): Criterio;
    class function Obter: string;
    class function ConectorE: string;
    class function ConectorOu: string;
  end;

  TObjectIdentificator = class(TObject)
  private
    FQuery: TSqlDataSet;
  protected
    FHigh: Int64;
    FLow: Int64;
    procedure GetNextHigh;
  public
    constructor Create(const QueryComponent: TSqlDataSet); reintroduce;
    function GetHigh: Int64;
    function GetLow: Int64;
    function GetOID: string;
  end;

  TDataUtil = class(TObject)
  private
    FObjectIdentificator: TObjectIdentificator;
  private
    class function ExistemFlags(DataSet: TDataSet): Boolean;
  public
    class procedure ConnectionCleanUp(DataModule: TDataModule);
    class function GenerateDocumentNumber(const DocumentName: string;
      QueryComponent: TSqlDataSet): string;
    function GetOIDGenerator(
      const QueryComponent: TSqlDataSet): TObjectIdentificator;
    class procedure GravarFlagsDoRegistro(const DataSet: TDataSet;
      const Operacao: OperacaoDeRegistro);
    procedure OidVerify(const DataSet: TDataSet; const KeyField: string);
    class procedure PostChanges(const DataSet: TDataSet);
  end;

  function RetornarAcaoDeRegistro(
    const CodigoDaAcaoDeRegistro: Integer): AcaoDeRegistro;

  var
    FCampo: string;
    FValorInicial: Variant;
    FValorFinal: Variant;
    FTipoCriterio: TTipoCriterio;

implementation

uses
  { helsonsant }
  UnModelo;

function RetornarAcaoDeRegistro(
  const CodigoDaAcaoDeRegistro: Integer): AcaoDeRegistro;
begin
  if CodigoDaAcaoDeRegistro = 0 then
    Result := adrIncluir
  else
    if CodigoDaAcaoDeRegistro = 1 then
      Result := adrCarregar
    else
      Result := adrOutra;
end;

{ TFlObjetcIdentificator }

constructor TObjectIdentificator.Create(const QueryComponent: TSqlDataSet);
begin
  inherited Create;
  Self.FQuery := QueryComponent;
end;

function TObjectIdentificator.GetHigh: Int64;
begin
  if Self.FHigh = 0 then
    Self.GetNextHigh();
  Result := Self.FHigh;
end;

function TObjectIdentificator.GetLow: Int64;
begin
  if Self.FLow = 9999 then
  begin
    Self.GetNextHigh();
    Self.FLow := 1;
  end
  else
    Inc(Self.FLow);
  Result := Self.FLow;
end;

procedure TObjectIdentificator.GetNextHigh;
begin
  Self.FQuery.Active := False;
  Self.FQuery.CommandText := 'SELECT GEN_ID(OIDS,  1) NEXT_HIGH ' +
    ' FROM ESCLR';
  Self.FQuery.Open();
  Self.FHigh := Self.FQuery.Fields[0].Value;
  Self.FQuery.Close();
end;

function TObjectIdentificator.GetOID: string;
var
  _high: string;
  _low: string;
begin
  _high := IntToStr(Self.GetHigh());
  _low := IntToStr(Self.GetLow());
  Result := UpperCase(TText.EZeros(_high, 10) + TText.EZeros(_low, 4));
end;

{ TDataUtil }
class procedure TDataUtil.ConnectionCleanUp(DataModule: TDataModule);
var
  i: Integer;
begin
  for i := 0 to DataModule.ComponentCount-1 do
    if (DataModule.Components[i] is TClientDataSet) and
      TClientDataSet(DataModule.Components[i]).Active then
    begin
      TClientDataSet(DataModule.Components[i]).EmptyDataSet();
      TClientDataSet(DataModule.Components[i]).Close();
    end;
end;

class function TDataUtil.ExistemFlags(DataSet: TDataSet): Boolean;
begin
  Result := (DataSet.FindField('REC_STT') <> nil)
    and (DataSet.FindField('REC_INS') <> nil)
    and (DataSet.FindField('REC_UPD') <> nil)
    and (DataSet.FindField('REC_DEL') <> nil);
end;

class function TDataUtil.GenerateDocumentNumber(const DocumentName: string;
  QueryComponent: TSqlDataSet): string;
begin
  QueryComponent.Active := False;
  QueryComponent.CommandText := Format('SELECT GEN_ID(%s,  1) NEXT_DOCUMENT ' +
    ' FROM ESCLR ', [DocumentName]);
  QueryComponent.Open();
  Result := QueryComponent.Fields[0].AsString;
  QueryComponent.Close();
end;

function TDataUtil.GetOIDGenerator(
  const QueryComponent: TSqlDataSet): TObjectIdentificator;
begin
  if Self.FObjectIdentificator = nil then
    Self.FObjectIdentificator := TObjectIdentificator.Create(QueryComponent);
  Result := Self.FObjectIdentificator
end;

class procedure TDataUtil.GravarFlagsDoRegistro(const DataSet: TDataSet;
  const Operacao: OperacaoDeRegistro);
var
  _existemFlags: Boolean;
  _agora: TDate;
begin
  _agora := Now;
  _existemFlags := Self.ExistemFlags(DataSet);
  if _existemFlags then
  begin
    if DataSet.FieldByName('REC_STT').AsString = '' then
      DataSet.FieldByName('REC_STT').AsInteger := Ord(srAtivo);
    if Operacao = odrIncluir then
      DataSet.FieldByName('REC_INS').AsDateTime := _agora;
    DataSet.FieldByName('REC_UPD').AsDateTime := _agora;
  end;
end;

procedure TDataUtil.OidVerify(const DataSet: TDataSet; const KeyField: string);
var
  _operacao: OperacaoDeRegistro;
begin
  if DataSet.FieldByName(KeyField).AsString = '' then
  begin
    DataSet.FieldByName(KeyField).Value := Self.GetOIDGenerator(nil).GetOID();
    _operacao := odrIncluir;
  end
  else
    _operacao := odrAlterar;
  Self.GravarFlagsDoRegistro(DataSet, _operacao);
end;

class procedure TDataUtil.PostChanges(const DataSet: TDataSet);
begin
  if DataSet.State in [dsEdit, dsInsert] then
    DataSet.Post;
end;

{ TSql }

function TSql.From(const From: string): TSql;
begin
  Self.FFrom := from;
  Result := Self;
end;

function TSql.ObterSqlFiltrado(const Filtro: string): string;
begin
  Result := Format('SELECT %s FROM %s ', [Self.FSelect, Self.FFrom]);
  if Self.FWhere <> '' then
    if Filtro <> '' then
      Result := Format('%s WHERE %s AND %s ', [Result, Self.FWhere, Filtro])
    else
      Result := Format('%s WHERE %s ', [Result, Self.FWhere])
  else
    if Filtro <> '' then
      Result := Format('%s WHERE %s ', [Result, Filtro]);
  if Self.FGroup <> '' then
    Result := Format('%s GROUP BY %s ', [Result, Self.FGroup]);
  if Self.FHaving <> '' then
    Result := Format('%s HAVING %s ', [Result, Self.FHaving]);
  if Self.FOrder <> '' then
    Result := Format('%s ORDER BY %s', [Result, Self.FOrder]);
end;

function TSql.ObterSql: string;
begin
  Result := Self.ObterSQLFiltrado('');
end;

function TSql.Group(const Group: string): TSql;
begin
  Self.FGroup := Group;
  Result := Self;
end;

function TSql.having(const Having: string): TSql;
begin
  Self.FHaving := Having;
  Result := Self;
end;

function TSql.order(const Order: string): TSql;
begin
  Self.FOrder := Order;
  Result := Self;
end;

function TSql.Select(const Select: string): TSql;
begin
  Self.FSelect := Select;
  Result := Self;
end;

function TSql.Where(const Where: string): TSql;
begin
  Self.FWhere := Where;
  Result := Self;
end;

function TSql.MetaDados(const MetaDados: string): TSql;
begin
  Self.FMetadados := MetaDados;
  Result := Self;
end;

function TSql.ObterSqlMetadados: string;
begin
  Result := Self.ObterSqlFiltrado(Self.FMetaDados)
end;

function TSql.CondicaoDeJuncao(const CondicaoDeJuncao: string): TSql;
begin
  Self.FCondicaoDeJuncao := CondicaoDeJuncao;
  Result := Self;
end;

function TSql.ObterSqlComCondicaoDeJuncao: string;
begin
  Result := Self.ObterSqlFiltrado(Self.FCondicaoDeJuncao);
end;

{ TCriterio }

class function TCriterio.Campo(const NomeCampo: string): Criterio;
begin
  FCampo := NomeCampo;
  Result := Self;
end;

class function TCriterio.Como(const Valor: string): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcComo;
  Result := Self;
end;

class function TCriterio.ConectorE: string;
begin
  Result := ' AND ';
end;

class function TCriterio.ConectorOu: string;
begin
  Result := ' OR ';
end;

class function TCriterio.E(const ValorFinal: Variant): Criterio;
begin
  FValorFinal := ValorFinal;
  Result := Self;
end;

class function TCriterio.Entre(const ValorInicial: Variant): Criterio;
begin
  FValorInicial := ValorInicial;
  FTipoCriterio := tcEntre;
  Result := Self;
end;

class function TCriterio.Igual(const Valor: Variant): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcIgual;
  Result := Self;
end;

class function TCriterio.MaiorOuIgualQue(const Valor: Variant): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcMaiorOuIgual;
  Result := Self;
end;

class function TCriterio.MaiorQue(const Valor: Variant): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcMaior;
  Result := Self;
end;

class function TCriterio.MenorOuIgualQue(const Valor: Variant): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcMenorOuIgual;
  Result := Self;
end;

class function TCriterio.MenorQue(const Valor: Variant): Criterio;
begin
  FValorInicial := Valor;
  FTipoCriterio := tcMenor;
  Result := Self;
end;

class function TCriterio.Obter: string;
begin
  case FTipoCriterio of
    tcIgual:
    begin
      if VarType(FValorInicial) = varString then
        Result := FCampo + '=' + QuotedStr(FValorInicial)
      else
        Result := FCampo + '=' + VarToStr(FValorInicial);
    end;
    tcComo:
    begin
        Result := FCampo +
          ' LIKE ' + QuotedStr('%' + FValorInicial + '%');
    end;
    tcMaior:
    begin
      if VarType(FValorInicial) = varString then
        Result := FCampo + '>' + QuotedStr(FValorInicial)
      else
        Result := FCampo + '>' + VarToStr(FValorInicial);
    end;
    tcMenor:
    begin
      if VarType(FValorInicial) = varString then
        Result := FCampo + '<' + QuotedStr(FValorInicial)
      else
        Result := FCampo + '<' + VarToStr(FValorInicial);
    end;
    tcMaiorOuIgual:
    begin
      if VarType(FValorInicial) = varString then
        Result := FCampo + '>=' + QuotedStr(FValorInicial)
      else
        Result := FCampo + '>=' + VarToStr(FValorInicial);
    end;
    tcMenorOuIgual:
    begin
      if VarType(FValorInicial) = varString then
        Result := FCampo + '<=' + QuotedStr(FValorInicial)
      else
        Result := FCampo + '<=' + VarToStr(FValorInicial);
    end;
    tcEntre:
    begin
      if (VarType(FValorInicial) = varString) then
        Result := FCampo + ' BETWEEN ' + QuotedStr(FValorInicial) +
           ' AND ' + QuotedStr(FValorFinal)
      else
        if VarType(FValorInicial) = varDate then
          Result := FCampo + ' BETWEEN CAST(' +
            QuotedStr(FormatDateTime('mm/dd/yyyy', FValorInicial)) +
            ' as Date) AND CAST(' +
            QuotedStr(FormatDateTime('mm/dd/yyyy', FValorFinal)) + ' as Date)'
        else
          Result := FCampo + ' BETWEEN ' + VarToStr(FValorInicial) +
            ' AND ' + VarToStr(FValorFinal);
    end;
  end;
end;

end.
