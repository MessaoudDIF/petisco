unit UnFabricaDeModelos;

interface

uses
  SysUtils, Classes, DB, SqlExpr, DBClient,
  { helsonsant }
  Util, DataUtil, Configuracoes, UnModelo, Dominio;

type
  TFabricaDeModelos = class
  private
    FConexao: TSQLConnection;
    FConfiguracoes: TConfiguracoes;
    FDataUtil: TDataUtil;
    FModelos: TStringList;
    FUtil: TUtil;
  public
    function Configuracoes(
      const Configuracoes: TConfiguracoes): TFabricaDeModelos;
    constructor Create(const Conexao: TSQLConnection); reintroduce;
    function DataUtil(const DataUtil: TDataUtil): TFabricaDeModelos;
    function Descarregar: TFabricaDeModelos;
    function DescarregarModelo(const Modelo: TModelo): TFabricaDeModelos;
    function ObterModelo(const NomeModelo: string): TModelo;
    function Preparar: TFabricaDeModelos;
    function Util(const Util: TUtil): TFabricaDeModelos;
  end;

implementation

{ TFabricaDeModelos }

function TFabricaDeModelos.Descarregar: TFabricaDeModelos;
begin
  while Self.FModelos.Count > 0 do
    Self.DescarregarModelo(Self.FModelos.Objects[0] as TModelo);
  FreeAndNil(Self.FModelos);
  Result := Self;
end;

function TFabricaDeModelos.Configuracoes(
  const Configuracoes: TConfiguracoes): TFabricaDeModelos;
begin
  Self.FConfiguracoes := Configuracoes;
  Result := Self;
end;

constructor TFabricaDeModelos.Create(const Conexao: TSQLConnection);
begin
  inherited Create;
  Self.FConexao := Conexao;
  Self.FModelos := TStringList.Create();
end;

function TFabricaDeModelos.DataUtil(
  const DataUtil: TDataUtil): TFabricaDeModelos;
begin
  Self.FDataUtil := DataUtil;
  Result := Self;
end;

function TFabricaDeModelos.ObterModelo(const NomeModelo: string): TModelo;
var
  _modelo: Modelo;
begin
  _modelo := Modelo(GetClass('T' + NomeModelo));
  Result := TComponentClass(_modelo).Create(nil) as TModelo;
  Result
    .Util(Self.FUtil)
    .DataUtil(Self.FDataUtil)
    .Configuracoes(Self.FConfiguracoes)
    .Preparar(Self.FConexao);
  Self.FModelos.AddObject(NomeModelo, Result);
end;                 

function TFabricaDeModelos.Util(const Util: TUtil): TFabricaDeModelos;
begin
  Self.FUtil := Util;
  Result := Self;
end;

function TFabricaDeModelos.DescarregarModelo(
  const Modelo: TModelo): TFabricaDeModelos;
var
  _indice: Integer;
begin
  _indice := Self.FModelos.IndexOfObject(Modelo);
  if _indice <> -1 then
  begin
    (Self.FModelos.Objects[_indice] as TModelo).Descarregar;
    (Self.FModelos.Objects[_indice] as TModelo).Free;
    Self.FModelos.Delete(_indice);
  end;
  Result := Self;
end;

function TFabricaDeModelos.Preparar: TFabricaDeModelos;
begin
  Result := Self;
end;

end.
