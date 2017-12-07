unit Configuracoes;

interface

uses SysUtils, Classes,
  { Fluente }
  Util;

type
  TConfiguracoes = class(TObject)
  private
    FConfiguracoes: TStringList;
  public
    constructor Create(const CaminhoArquivoConfiguracao: string); reintroduce;
    function Gravar(const Chave, Valor: string): TConfiguracoes;
    function Ler(const Key: string): string;
  end;

implementation

{ TConfiguracoes }

constructor TConfiguracoes.Create(const CaminhoArquivoConfiguracao: string);
var
  _i: Integer;
  _arquivo: TStringList;
begin
  inherited Create;
  Self.FConfiguracoes := TStringList.Create;
  if FileExists(CaminhoArquivoConfiguracao) then
  begin
    _arquivo := TStringList.Create();
    try
      _arquivo.LoadFromFile(CaminhoArquivoConfiguracao);
      for _i := 0 to _arquivo.Count-1 do
        Self.FConfiguracoes.AddObject(
          Copy(_arquivo[_i], 1, Pos('=', _arquivo[_i]) -1),
          TValor.Create()
            .Texto(Copy(_arquivo[_i], Pos('=', _arquivo[_i])+1, 1024))) ;
    finally
      FreeAndNil(_arquivo);
    end;
  end;
end;

function TConfiguracoes.Ler(const Key: string): string;
var
  _indice: Integer;
begin
  _indice := Self.FConfiguracoes.IndexOf(Key);
  if _indice <> -1 then
    Result := (Self.FConfiguracoes.Objects[_indice] as TValor).ObterTexto()
  else
    Result := '';
end;

function TConfiguracoes.Gravar(const Chave, Valor: string): TConfiguracoes;
var
  _indice: Integer;
begin
  _indice := Self.FConfiguracoes.IndexOf(Chave);
  if _indice = -1 then
    Self.FConfiguracoes.AddObject(Chave, TValor.Create().Texto(Valor))
  else
    (Self.FConfiguracoes.Objects[_indice] as TValor).Texto(Valor);
  Result := Self;
end;

end.
