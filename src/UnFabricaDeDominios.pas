unit UnFabricaDeDominios;

interface

uses SysUtils, Classes, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio, FMTBcd;

type
  FabricaDeDominio = class of TFabricaDeDominio;

  TFabricaDeDominio = class(TDataModule)
  private
    class procedure ConstruirDataSet(const DataSet: TDataSet;
      const Sql: string; const Campos: TCampos);
    class function CopiarCampo(const CampoOrigem, CampoDestino: TField;
      const DataSet: TDataSet): TField;
    class function DuplicarCampo(const CampoOrigem: TField; const DataSet: TDataSet;
      const Modelo: TModelo = nil): Boolean;
    class procedure ConstruirDataSetDetalhe(const Modelo: TModelo;
      const EntidadeMestre, EntidadeDetalhe: TDominio;
      const MasterSqlDataSet: TSqlDataSet;
      const MasterClientDataSet: TClientDataSet);
  public
    class function Conexao(const Conexao: TSQLConnection): FabricaDeDominio;
    class procedure FabricarDominio(const Dominio: TDominio; const Modelo: TModelo);
  end;

var
  FConexao: TSQLConnection;
  FSqlProcessor: TSQLDataSet;

implementation

{$R *.dfm}

class procedure TFabricaDeDominio.FabricarDominio(const Dominio: TDominio;
  const Modelo: TModelo);
var
  _i: Integer;
  _ds: TSQLDataSet;
  _dsp: TDataSetProvider;
  _cds: TClientDataSet;
  _dsr: TDataSource;
begin
  // configura SqlDataSet com conexão, comando Sql e cria seus campos
  _ds := Modelo.ds;
  _ds.SQLConnection := FConexao;
  _ds.CommandText := Dominio.Sql.ObterSql;
  Self.ConstruirDataSet(_ds, Dominio.Sql.ObterSqlMetadados, Dominio.Campos);
  // configua DataSetProvider com seu SqlDataSet, opções de
  _dsp := Modelo.dsp;
  _dsp.DataSet := _ds;
  _dsp.Options := [] + [poCascadeDeletes] + [poCascadeUpdates] +
    [poAllowCommandText];
  _dsp.UpdateMode := upWhereKeyOnly;
  _cds := Modelo.cds;
  // configura ClientDataSet
  _cds.ProviderName := 'dsp';
  if Assigned(Dominio.EventoAntesDePostarRegistro) then
    _cds.BeforePost := Dominio.EventoAntesDePostarRegistro;
  Self.ConstruirDataSet(_cds, Dominio.Sql.ObterSqlMetadados, Dominio.Campos);
  _dsr := Modelo.dsr;
  _dsr.DataSet := _cds;
  // Construir Detail
  for _i := 0 to Dominio.Detalhes.Count-1 do
    Self.ConstruirDataSetDetalhe(Modelo, Dominio,
      Dominio.Detalhes.Objects[_i] as TDominio, _ds, _cds);
end;

class function TFabricaDeDominio.Conexao(
  const Conexao: TSQLConnection): FabricaDeDominio;
begin
  // Armazena referência à conexão ao banco de dados e configura
  // SqlProcessor com esta conexão.
  FConexao := Conexao;
  if FSqlProcessor = nil then
  begin
    FSqlProcessor := TSQLDataSet.Create(nil);
    FSqlProcessor.SQLConnection := Conexao;
  end;
  Result := Self;
end;

class function TFabricaDeDominio.DuplicarCampo(const CampoOrigem: TField;
  const DataSet: TDataSet; const Modelo: TModelo = nil): Boolean;
var
  _campoDestino: TField;
begin
  // cria um novo campo _campoDestino para espelhar CampoOrigem
  _campoDestino := nil;
  case CampoOrigem.DataType of
    ftString: _campoDestino := TStringField.Create(Modelo);
    ftSmallint: _campoDestino := TSmallintField.Create(Modelo);
    ftInteger: _campoDestino := TIntegerField.Create(Modelo);
    ftWord: _campoDestino := TWordField.Create(Modelo);
    ftFloat: _campoDestino := TFloatField.Create(Modelo);
    ftCurrency: _campoDestino := TCurrencyField.Create(Modelo);
    ftBCD: _campoDestino := TBCDField.Create(Modelo);
    ftDate: _campoDestino := TDateField.Create(Modelo);
    ftTime: _campoDestino := TTimeField.Create(Modelo);
    ftDateTime: _campoDestino := TDateTimeField.Create(Modelo);
    ftAutoInc: _campoDestino := TAutoIncField.Create(Modelo);
    ftWideString: _campoDestino := TWideStringField.Create(Modelo);
    ftLargeint: _campoDestino := TLargeIntField.Create(Modelo);
    ftTimeStamp: _campoDestino := TSQLTimesTampField.Create(Modelo);
    ftFMTBcd: _campoDestino := TFMTBCDField.Create(Modelo);
  end;
  // copia atributos de CampoOrigem em _campoDestino;
  if _campoDestino <> nil then
    Self.CopiarCampo(CampoOrigem, _campoDestino, DataSet);
  Result := _campoDestino <> nil;
end;

class function TFabricaDeDominio.CopiarCampo(const CampoOrigem, CampoDestino: TField;
  const DataSet: TDataSet): TField;
begin
  // copia atributos de CampoOrigem em CampoDestino;
  CampoDestino.Name := CampoOrigem.Name;
  CampoDestino.FieldName := CampoOrigem.FieldName;
  CampoDestino.Alignment := CampoOrigem.Alignment;
  CampoDestino.DefaultExpression := CampoOrigem.DefaultExpression;
  CampoDestino.DisplayLabel := CampoOrigem.DisplayLabel;
  CampoDestino.DisplayWidth := CampoOrigem.DisplayWidth;
  CampoDestino.FieldKind := CampoOrigem.FieldKind;
  CampoDestino.Tag := CampoOrigem.Tag;
  CampoDestino.Size := CampoOrigem.Size;
  // todos os campos são inicialmente invisíveis
  CampoDestino.Visible := False;
  CampoDestino.ProviderFlags := CampoOrigem.ProviderFlags;
  CampoDestino.Index := CampoOrigem.Index;
  // precisão de campos numéricos
  if CampoOrigem is TBCDField then
    (CampoDestino as TBCDField).Precision := (CampoOrigem as TBCDField).Precision;
  if CampoOrigem is TFMTBCDField then
    (CampoDestino as TFMTBCDField).Precision := (CampoOrigem as TFMTBCDField).Precision;
  // configura DataSet
  CampoDestino.DataSet := DataSet;
  Result := CampoDestino;
end;

class procedure TFabricaDeDominio.ConstruirDataSet(const DataSet: TDataSet;
  const Sql: string; const Campos: TCampos);
var
  _i: Integer;
  _campo: TCampo;
  _campoDS: TField;
begin
  // executa comando Sql para recuperar campos
  FSqlProcessor.Active := False;
  FSqlProcessor.CommandText := Sql;
  FSqlProcessor.Open;
  // cria cópia dos campos no DataSet de destino
  for _i := 0 to FSqlProcessor.FieldCount-1 do
    Self.DuplicarCampo(FSqlProcessor.Fields[_i], DataSet, DataSet.Owner as TModelo);
  FSqlProcessor.Active := False;
  // configura campos de acordo com as regras do Domínio
  for _i := 0 to Campos.Count-1 do
  begin
    _campo := Campos.Objects[_i] as TCampo;
    _campoDS := DataSet.FindField(_campo.ObterNome);
    _campoDS.DisplayLabel := _campo.ObterDescricao;
    if _campo.ObterTamanho <> 0 then
      _campoDS.DisplayWidth := _campo.ObterTamanho;
    _campoDS.ProviderFlags := [];
    if _campo.EhChave then
      _campoDS.ProviderFlags := _campoDS.ProviderFlags + [pfInKey];
    if _campo.EhAtualizavel then
      _campoDS.ProviderFlags := _campoDS.ProviderFlags + [pfInUpdate];
    _campoDS.Required := _campo.EhObrigatorio;
    _campoDS.Visible := _campo.EhVisivel;
    // formato de campos numéricos, data e hora
    if (_campoDS is TBCDField) and (_campo.ObterFormato <> '') then
      (_campoDS as TBCDField).DisplayFormat := _campo.ObterFormato;
    if (_campoDS is TFMTBCDField) and (_campo.ObterFormato <> '') then
      (_campoDS as TFMTBCDField).DisplayFormat := _campo.ObterFormato;
    if (_campoDS is TDateField) and (_campo.ObterFormato <> '') then
      (_campoDS as TDateField).DisplayFormat := _campo.ObterFormato;
    if (_campoDS is TDateTimeField) and (_campo.ObterFormato <> '') then
      (_campoDS as TDateTimeField).DisplayFormat := _campo.ObterFormato;
    if (_campoDS is TTimeField) and (_campo.ObterFormato <> '') then
      (_campoDS as TTimeField).DisplayFormat := _campo.ObterFormato;
    if (_campoDS is TSQLTimestampField) and (_campo.ObterFormato <> '') then
      (_campoDS as TSQLTimestampField).DisplayFormat := _campo.ObterFormato;
  end;
end;

class procedure TFabricaDeDominio.ConstruirDataSetDetalhe(const Modelo: TModelo;
      const EntidadeMestre, EntidadeDetalhe: TDominio;
      const MasterSqlDataSet: TSqlDataSet;
      const MasterClientDataSet: TClientDataSet);
var
  _i: Integer;
  _ds: TSQLDataSet;
  _ds_dsr: TDataSource;
  _cds: TClientDataSet;
  _dsr: TDataSource;
  _campoDeLigacao: TDataSetField;
begin
  // DataSource que liga o MasterDS ao DetailDS
  _ds_dsr := TDataSource.Create(Modelo);
  _ds_dsr.DataSet := MasterSqlDataSet;
  _ds_dsr.Name := 'ds_' +
    EntidadeMestre.Entidade + '_' + EntidadeDetalhe.Entidade;
  MasterSqlDataSet.Active := True;
  // DetailDS
  _ds := TSQLDataSet.Create(Modelo);
  _ds.SQLConnection := FConexao;
  _ds.Name := 'ds_' + EntidadeDetalhe.Entidade;
  _ds.CommandText := EntidadeDetalhe.Sql.ObterSqlComCondicaoDeJuncao;
  _ds.DataSource := _ds_dsr;
  Self.ConstruirDataSet(_ds,
    EntidadeDetalhe.Sql.ObterSqlMetadados,
    EntidadeDetalhe.Campos);
  // DataSetField que liga MasterClientDataSet ao DetailClientDataSet
  _campoDeLigacao := TDataSetField.Create(Modelo);
  _campoDeLigacao.Name := MasterSqlDataSet.Name + _ds.Name;
  _campoDeLigacao.FieldName := _ds.Name;
  _campoDeLigacao.DataSet := MasterClientDataSet;
  // DetailClientDataSet
  _cds := TClientDataSet.Create(Modelo);
  _cds.Name := 'cds_' + EntidadeDetalhe.Entidade;
  _cds.DataSetField := _campoDeLigacao;
  Self.ConstruirDataSet(_cds,
    EntidadeDetalhe.Sql.ObterSql,
    EntidadeDetalhe.Campos);
  // DetailDataSource
  _dsr := TDataSource.Create(Modelo);
  _dsr.Name := 'dsr_' + EntidadeDetalhe.Entidade;
  _dsr.DataSet := _cds;
  for _i := 0 to EntidadeDetalhe.Detalhes.Count-1 do
    Self.ConstruirDataSetDetalhe(Modelo,
      EntidadeDetalhe,
      EntidadeDetalhe.Detalhes.Objects[_i] as TDominio,
      _ds,
      _cds);
  MasterSqlDataSet.Active := False;
end;

end.
