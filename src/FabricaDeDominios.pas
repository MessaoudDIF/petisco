unit FabricaDeDominios;

interface

uses Classes, SqlExpr, Provider, DB, DBClient,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TFabricaDeDominios = class
  private
    function CopiarCampo(const CampoOrigem, CampoDestino: TField;
      const DataSet: TDataSet): TField;
    function CriarCampo(const CampoOrigem: TField; const DataSet: TDataSet;
      const Modelo: TModelo = nil): Boolean;
  protected
    procedure ClearPriorDataObject(const Dominio: string;
      const Modelo: TModelo);
    procedure GenerateDataObject(const Dominio: TDominio; const Modelo: TModelo);
  public
    constructor Create(const Conexao: TSQLConnection); reintroduce;
    procedure FabricarDominio(const Dominio: TDominio; const Modelo: TModelo);
  end;

implementation

procedure TFabricaDeDominios.GenerateDataObject(const Dominio: TDominio;
  const Modelo: TModelo);
var
  _ds: TSQLDataSet;
  _dsp: TDataSetProvider;
  _cds: TClientDataSet;
  _dsr: TDataSource;
begin
  // ClearPriorDataObject
  // Gera Conjunto de Objetos da Classe Entidade.
  _ds := Modelo.ds;
  _ds.CommandText := Dominio.Sql.ObterSql;
  _dsp := Modelo.dsp;
  _dsp.DataSet := _ds;
  _dsp.Options := [] + [poCascadeDeletes] + [poCascadeUpdates] + [poAllowCommandText];
  _dsp.UpdateMode := upWhereKeyOnly;
  // Configura ClientDataSet
  _cds := Modelo.cds;
  _cds.ProviderName := 'dsp';
  _dsr := Modelo.dsr;
  _dsr.DataSet := _cds;
  // todo: Gerar Dependentes
end;

constructor TFabricaDeDominios.Create(const Conexao: TSQLConnection);
begin

end;

function TFabricaDeDominios.CriarCampo(const CampoOrigem: TField;
  const DataSet: TDataSet; const Modelo: TModelo = nil): Boolean;
var
  _campoDestino: TField;
begin
  Result := True;
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
  if _campoDestino is TFMTBCDField then
    (_campoDestino as TFMTBCDField).Precision := (CampoOrigem as TFMTBCDField).Precision;
  if _campoDestino is TFloatField then
    (_campoDestino as TFloatField).Precision := (CampoOrigem as TFloatField).Precision;
  if _campoDestino is TCurrencyField then
    (_campoDestino as TCurrencyField).Precision := (CampoOrigem as TCurrencyField).Precision;
  if _campoDestino is TBCDField then
    (_campoDestino as TBCDField).Precision := (CampoOrigem as TBCDField).Precision;
end;

function TFabricaDeDominios.CopiarCampo(const CampoOrigem, CampoDestino: TField;
  const DataSet: TDataSet): TField;
begin
  CampoDestino.Name := CampoOrigem.Name;
  CampoDestino.FieldName := CampoOrigem.FieldName;
  CampoDestino.Alignment := CampoOrigem.Alignment;
  CampoDestino.DefaultExpression := CampoOrigem.DefaultExpression;
  CampoDestino.DisplayLabel := CampoOrigem.DisplayLabel;
  CampoDestino.DisplayWidth := CampoOrigem.DisplayWidth;
  CampoDestino.FieldKind := CampoOrigem.FieldKind;
  CampoDestino.Tag := CampoOrigem.Tag;
  CampoDestino.Size := CampoOrigem.Size;
  CampoDestino.Visible := CampoOrigem.Visible;
  CampoDestino.ProviderFlags := CampoOrigem.ProviderFlags;
  CampoDestino.Index := CampoOrigem.Index;
  CampoDestino.DataSet := DataSet;
  Result := CampoDestino;
end;


procedure TFabricaDeDominios.ClearPriorDataObject(const Dominio: string;
  const Modelo: TModelo);
begin

end;

procedure TFabricaDeDominios.FabricarDominio(const Dominio: TDominio;
  const Modelo: TModelo);
begin

end;

end.
