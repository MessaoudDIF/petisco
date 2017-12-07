unit UnModel;

interface

uses
  SysUtils, Classes, SqlExpr, FMTBcd, DB, DBClient, Provider, 
  { Fluente }
  Util, DataUtil, Settings;

type
  TModel = class(TDataModule)
    Sql: TSQLDataSet;
    ds: TSQLDataSet;
    dsp: TDataSetProvider;
    cds: TClientDataSet;
    dsr: TDataSource;
  private
    FDataUtil: TDataUtil;
    FParameters: TStringList;
    FPesquisaExata: Boolean;
    FSettings: TSettings;
    FUtil: TUtil;
  protected
    FSql: TSQL;
    function RetornarComponente(const Prefixo, Nome: string): TComponent;
    function GetParameters: TStringList;
    function GetSQL: TSQL; virtual; abstract;
  public
    function Util(const Util: TUtil): TModel;
    function DataUtil(const DataUtil: TDataUtil): TModel;
    function Configuracoes(const Configuracoes: TSettings): TModel;
    function Incluir: TModel; virtual;
    function Salvar: TModel; virtual;
    function Excluir: TModel; virtual;
    function DataSet(const DataSetName: string = ''): TClientDataSet;
    function DataSource(const DataSourceName: string = ''): TDataSource;
    function Preparar(const Conexao: TSQLConnection): TModel; virtual;
    function PesquisaExataLigada: TModel;
    function PesquisaExataDesligada: TModel;
    function Carregar: TModel; virtual;
    function CarregarPor(const Criterio: string): TModel; virtual;
  end;

  var
    FConexao: TSQLConnection;
    FSql: TSQL;
    FDataUtil: TDataUtil;
    FUtil: TUtil;
    FConfiguracoes: TSettings;

implementation

uses Dialogs, Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TModel }
function TModel.Carregar: TModel;
begin
  Self.CarregarPor('');
  Result := Self;
end;

function TModel.CarregarPor(const Criterio: string): TModel;
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds;
  _dataSet.Active := False;
  if Criterio = '' then
    _dataSet.CommandText := Self.GetSQL().ObterSQL
  else
    _dataSet.CommandText := Self.GetSQL().ObterSQLFiltrado(Criterio);
  _dataSet.Open();
  Result := Self;
end;

function TModel.Configuracoes(const Configuracoes: TSettings): TModel;
begin
  Self.FSettings := Configuracoes;
  Result := Self;
end;

function TModel.DataSet(const DataSetName: string): TClientDataSet;
begin
  if DataSetName <> '' then
    Result := Self.RetornarComponente('cds_', DataSetName) as TClientDataSet
  else
    Result := Self.cds;
end;

function TModel.DataSource(const DataSourceName: string): TDataSource;
begin
  if DataSourceName <> '' then
    Result := Self.RetornarComponente('dsr_', DataSourceName) as TDataSource
  else
    Result := Self.dsr;
end;

function TModel.DataUtil(const DataUtil: TDataUtil): TModel;
begin
  Self.FDataUtil := DataUtil;
  Result := Self;
end;

function TModel.Excluir: TModel;
begin
  Result := Self;
end;

function TModel.GetParameters: TStringList;
begin
  if Self.FParameters = nil then
    Self.FParameters := TStringList.Create;
  Result := Self.FParameters;
end;

function TModel.Incluir: TModel;
begin
  Result := Self;
end;

function TModel.PesquisaExataDesligada: TModel;
begin
  Self.FPesquisaExata := False;
  Result := Self;
end;

function TModel.PesquisaExataLigada: TModel;
begin
  Self.FPesquisaExata := True;
  Result := Self;
end;

function TModel.Preparar(const Conexao: TSQLConnection): TModel;
var
  _i: Integer;
begin
  // inicia valores padrao
  Self.FPesquisaExata := True;
  // liga datasets a conexao
  for _i := 0 to Self.ComponentCount-1 do
    if (Self.Components[_i].Tag <> 0) and
      (Self.Components[_i] is TSQLDataSet) then
    begin
      (Self.Components[_i] as TSQLDataSet).SQLConnection := Conexao;
    end;
  for _i := 0 to Self.ComponentCount-1 do
    if (Self.Components[_i].Tag <> 0) and
      (Self.Components[_i] is TClientDataSet) then
    begin
      (Self.Components[_i] as TClientDataSet).Open();
    end;
  Result := Self;
end;

function TModel.RetornarComponente(const Prefixo, Nome: string): TComponent;
var
  _nome: string;
begin
  _nome := Format('%s%s', [Prefixo, Nome]);
  Result := Self.FindComponent(_nome);
end;

function TModel.Salvar: TModel;
begin
  Result := Self;
end;

function TModel.Util(const Util: TUtil): TModel;
begin
  Self.FUtil := Util;
  Result := Self;
end;

end.


