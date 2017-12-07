unit UnModelo;

interface

uses
  SysUtils, Classes, SqlExpr, FMTBcd, DB, DBClient, Provider,
  { helsonsant }
  Util, DataUtil, Configuracoes, Dominio;

type
  TModelo = class;
  Modelo = class of TModelo;

  TModelo = class(TDataModule)
    Sql: TSQLDataSet;
    ds: TSQLDataSet;
    dsp: TDataSetProvider;
    cds: TClientDataSet;
    dsr: TDataSource;
    procedure cdsAfterPost(DataSet: TDataSet);
  protected
    FDominio: TDominio;
    FDataUtil: TDataUtil;
    FParameters: TMap;
    FConfiguracoes: TConfiguracoes;
    FSql: TSQL;
    FUtil: TUtil;
    function RetornarComponente(const Prefixo, Nome: string): TComponent;
    function GetSQL: TSQL; virtual; abstract;
  public
    constructor Create(const Dominio: TDominio); reintroduce;
    function Util(const Util: TUtil): TModelo;
    function DataUtil(const DataUtil: TDataUtil): TModelo;
    function Configuracoes(const Configuracoes: TConfiguracoes): TModelo;
    function Incluir: TModelo; virtual;
    function Inativar: TModelo; virtual;
    function Salvar: TModelo; virtual;
    function EhValido: Boolean; virtual;
    function Excluir: TModelo; virtual;
    function DataSet(const DataSetName: string = ''): TClientDataSet;
    function DataSource(const DataSourceName: string = ''): TDataSource;
    function Preparar(const Conexao: TSQLConnection): TModelo; virtual;
    function Carregar: TModelo; virtual;
    function CarregarPor(const Criterio: string): TModelo; virtual;
    function Descarregar: TModelo;
    function Parametros: TMap;
    function OrdernarPor(const Campo: string): TModelo; virtual;
  end;

  var
    FConexao: TSQLConnection;
    FSql: TSQL;
    FDataUtil: TDataUtil;
    FUtil: TUtil;
    FConfiguracoes: TConfiguracoes;

implementation

{$R *.dfm}

uses UnFabricaDeDominios;

{ TModel }
function TModelo.Carregar: TModelo;
begin
  Result := Self;
  Self.CarregarPor('');
end;

function TModelo.CarregarPor(const Criterio: string): TModelo;
var
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds;
  _dataSet.Active := False;
  if Criterio = '' then begin
    _dataSet.CommandText := Self.GetSQL().ObterSQL;
  end else begin
    _dataSet.CommandText := Self.GetSQL().obterSQLFiltrado(Criterio);
  end;
  _dataSet.Open();
end;

procedure TModelo.cdsAfterPost(DataSet: TDataSet);
begin
  if (Self.FDominio <> nil) and
    Assigned(Self.FDominio.EventoAntesDePostarRegistro) then begin
    Self.FDominio.EventoAntesDePostarRegistro(DataSet);
  end;
end;

function TModelo.Configuracoes(const Configuracoes: TConfiguracoes): TModelo;
begin
  Result := Self;
  Self.FConfiguracoes := Configuracoes;
end;

constructor TModelo.Create(const Dominio: TDominio);
begin
  inherited Create(nil);
  Self.FDominio := Dominio;
end;

function TModelo.DataSet(const DataSetName: string): TClientDataSet;
begin
  if DataSetName <> '' then begin
    Result := Self.RetornarComponente('cds_', DataSetName) as TClientDataSet;
  end else begin
    Result := Self.cds;
  end;
end;

function TModelo.DataSource(const DataSourceName: string): TDataSource;
begin
  if DataSourceName <> '' then begin
    Result := Self.RetornarComponente('dsr_', DataSourceName) as TDataSource;
  end else begin
    Result := Self.dsr;
  end;
end;

function TModelo.DataUtil(const DataUtil: TDataUtil): TModelo;
begin
  Result := Self;
  Self.FDataUtil := DataUtil;
end;

function TModelo.Descarregar: TModelo;
begin
  Result := Self;
  Self.FDataUtil := nil;
  Self.FParameters := nil;
  Self.FConfiguracoes := nil;
  Self.FSql := nil;
  Self.FUtil := nil;
end;

function TModelo.Excluir: TModelo;
begin
  Result := Self;
  Self.cds.Edit;
  Self.cds.FieldByName('REC_STT').AsInteger := Ord(srExcluido);
  Self.cds.FieldByName('REC_DEL').AsDateTime := Now;
  Self.cds.Post;
  Self.Salvar;
end;

function TModelo.Parametros: TMap;
begin
  if Self.FParameters = nil then begin
    Self.FParameters := TMap.Create;
  end;
  Result := Self.FParameters;
end;

function TModelo.Incluir: TModelo;
begin
  Result := Self;
  Self.cds.Append;
end;

function TModelo.OrdernarPor(const Campo: string): TModelo;
begin
  Result := Self;
end;

function TModelo.Preparar(const Conexao: TSQLConnection): TModelo;
var
  _i: Integer;
begin
  Result := Self;
  Self.GetSQL;
  if Self.FDominio <> nil then begin
    TFabricaDeDominio
      .Conexao(Conexao)
      .FabricarDominio(Self.FDominio, Self);
  end;
  for _i := 0 to Self.ComponentCount-1 do begin
    if (Self.Components[_i].Tag <> 0) and
      (Self.Components[_i] is TSQLDataSet) then begin
      (Self.Components[_i] as TSQLDataSet).SQLConnection := Conexao;
    end;
  end;
  for _i := 0 to Self.ComponentCount-1 do begin
    if (Self.Components[_i].Tag <> 0) and
      (Self.Components[_i] is TClientDataSet) then begin
      (Self.Components[_i] as TClientDataSet).Open();
    end;
  end;
end;

function TModelo.RetornarComponente(const Prefixo, Nome: string): TComponent;
begin
  Result := Self.FindComponent(Format('%s%s', [Prefixo, Nome]));
end;

function TModelo.Salvar: TModelo;
begin
  Result := Self;
  Self.FDataUtil.PostChanges(Self.cds);
  if Self.cds.ChangeCount > 0 then begin
    Self.cds.ApplyUpdates(-1);
  end;
end;

function TModelo.Util(const Util: TUtil): TModelo;
begin
  Result := Self;
  Self.FUtil := Util;
end;

function TModelo.EhValido: Boolean;
begin
  Result := True;
  if Assigned(Self.FDominio.EventoRegraDeNegocioGerencial) then begin
    Result := Self.FDominio.EventoRegraDeNegocioGerencial(Self);
  end;
end;

function TModelo.Inativar: TModelo;
begin
  Result := Self;
  Self.cds.Edit;
  Self.cds.FieldByName('REC_STT').AsInteger := Ord(srInativo);
  Self.cds.FieldByName('REC_UPD').AsDateTime := Now;
  Self.cds.Post;
  Self.Salvar;
end;

end.
