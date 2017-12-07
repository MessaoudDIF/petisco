unit UnFabricaDeAplicacoes;

interface

uses Classes,
  { Fluente }
  Util, DataUtil, Configuracoes, UnAplicacao, UnFabricaDeModelos;

type
  TFabricaDeAplicacoes = class
  private
    FAplicacoes: TStringList;
    FConfiguracoes: TConfiguracoes;
    FDataUtil: TDataUtil;
    FFabricaDeModelos: TFabricaDeModelos;
    FUtil: TUtil;
  public
    function Configuracoes(const Configuracoes: TConfiguracoes): TFabricaDeAplicacoes;
    function DataUtil(const DataUtil: TDataUtil): TFabricaDeAplicacoes;
    function Descarregar: TFabricaDeAplicacoes;
    function DescarregarAplicacao(const Apliacao: TAplicacao): TFabricaDeAplicacoes;
    function FabricaDeModelos(const FabricaDeModelos: TFabricaDeModelos): TFabricaDeAplicacoes;
    function ObterAplicacao(const NomeDaAplicacao: string; const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
    function Preparar: TFabricaDeAplicacoes;
    function Util(const Util: TUtil): TFabricaDeAplicacoes;
  end;

implementation

{ TFabricaDeAplicacoes }

function TFabricaDeAplicacoes.Configuracoes(
  const Configuracoes: TConfiguracoes): TFabricaDeAplicacoes;
begin
  Self.FConfiguracoes := Configuracoes;
  Result := Self;
end;

function TFabricaDeAplicacoes.DataUtil(
  const DataUtil: TDataUtil): TFabricaDeAplicacoes;
begin
  Self.FDataUtil := DataUtil;
  Result := Self;
end;

function TFabricaDeAplicacoes.Descarregar: TFabricaDeAplicacoes;
begin
  Self.FConfiguracoes := nil;
  Self.FDataUtil := nil;
  Self.FUtil := nil;
  Result := Self;
end;

function TFabricaDeAplicacoes.DescarregarAplicacao(
  const Apliacao: TAplicacao): TFabricaDeAplicacoes;
begin
  Result := Self;
end;

function TFabricaDeAplicacoes.FabricaDeModelos(
  const FabricaDeModelos: TFabricaDeModelos): TFabricaDeAplicacoes;
begin
  Self.FFabricaDeModelos := FabricaDeModelos;
  Result := Self;
end;

function TFabricaDeAplicacoes.ObterAplicacao(const NomeDaAplicacao: string;
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
var
  _aplicacao: TAplicacao;
begin
  _aplicacao := TAplicacao(Classes.GetClass('T' + NomeDaAplicacao + 'Aplicacao'));
  if _aplicacao <> nil then
  begin
    Result := TPersistentClass(_aplicacao).Create as TAplicacao;
    Result
      .FabricaDeModelos(Self.FFabricaDeModelos)
      .Util(Self.FUtil)
      .DataUtil(Self.FDataUtil)
      .Configuracoes(Self.FConfiguracoes)
      .Preparar(ConfiguracaoAplicacao);
    Self.FAplicacoes.AddObject(NomeDaAplicacao, Result);
  end
  else
    Result := nil;
end;

function TFabricaDeAplicacoes.Preparar: TFabricaDeAplicacoes;
begin
  Self.FAplicacoes := TStringList.Create;
  Result := Self;
end;

function TFabricaDeAplicacoes.Util(
  const Util: TUtil): TFabricaDeAplicacoes;
begin
  Self.FUtil := Util;
  Result := Self;
end;

end.
