unit Dominio;

interface

uses Classes, Data.DB,
  { helsonsant }
  Util, DataUtil;

type
  TCampo = class
  private
    FNome: string;
    FDescricao: string;
    FFlagChave: Boolean;
    FFlagAtualizar: Boolean;
    FVisivel: Boolean;
    FTamanho: Integer;
    FFormato: string;
    FObrigatorio: Boolean;
  public
    constructor Create(const NomeDoCampo: string); reintroduce;
    function Nome(const Nome: string): TCampo;
    function Descricao(const Descricao: String): TCampo;
    function AtivarChave: TCampo;
    function AtivarAtualizacao: TCampo;
    function DesativarAtualizacao: TCampo;
    function AtivarVisualizacao: TCampo;
    function DesativarVisualizacao: TCampo;
    function Tamanho(const Tamanho: Integer): TCampo;
    function Formato(const Formato: string): TCampo;
    function TornarObrigatorio: TCampo;
    function EhChave: Boolean;
    function EhAtualizavel: Boolean;
    function EhVisivel: Boolean;
    function EhObrigatorio: Boolean;
    function ObterNome: string;
    function ObterTamanho: Integer;
    function ObterFormato: string;
    function ObterDescricao: string;
  end;

  TCampos = class(TStringList)
  public
    function  Adicionar(const Campo: TCampo): TCampos;
    function Campo(const NomeDoCampo: string): TCampo;
  end;

  TFabricaDeCampos = class
  public
    class function ObterCampo(const NomeDoCampo: string): TCampo;
    class function ObterCampoChave(const NomeDoCampo: string): TCampo;
    class function ObterCampoVisivel(const NomeDoCampo: string;
      const Descricao: string; const Tamanho: Integer;
      const Formato: string = ''): TCampo;
  end;

  TDominio = class;

  TEntidades = class(TStringList)
  public
    function Adicionar(const Entidade: TDominio): TEntidades;
  end;

  TRegraDeNegocio = reference to function (Modelo: TObject): Boolean;

  TDominio = class(TPersistent)
  private
    FEntidade: string;
    FSql: TSql;
    FCampos: TCampos;
    FDetalhes: TEntidades;
    FAntesDePostarRegistro: TDataSetNotifyEvent;
    FRegraDeNegocioGerencial: TRegraDeNegocio;
  public
    constructor Create(const Entidade: string); reintroduce;
    property EventoAntesDePostarRegistro: TDataSetNotifyEvent read FAntesDePostarRegistro;
    property EventoRegraDeNegocioGerencial: TRegraDeNegocio read FRegraDeNegocioGerencial;
    function Sql: TSql;
    function Campos: TCampos;
    function Detalhes: TEntidades;
    function Entidade: string;
    function AntesDePostarRegistro(const Evento: TDataSetNotifyEvent): TDominio;
    function RegraDeNegocioGerencial(
      const RegraDeNegocio: TRegraDeNegocio): TDominio;
  end;

implementation

{ TCampo }

function TCampo.AtivarAtualizacao: TCampo;
begin
  Self.FFlagAtualizar := True;
  Result := Self;
end;

function TCampo.AtivarChave: TCampo;
begin
  Self.FFlagChave := True;
  Result := Self;
end;

function TCampo.AtivarVisualizacao: TCampo;
begin
  Self.FVisivel := True;
  Result := Self;
end;

constructor TCampo.Create(const NomeDoCampo: string);
begin
  inherited Create;
  Self.FNome := NomeDoCampo;
  Self.FFlagChave := False;
  Self.FFlagAtualizar := True;
  Self.FVisivel := False;
  Self.FObrigatorio := False;
end;

function TCampo.DesativarAtualizacao: TCampo;
begin
  Self.FFlagAtualizar := False;
  Result := Self;
end;

function TCampo.DesativarVisualizacao: TCampo;
begin
  Self.FVisivel := False;
  Result := Self;
end;

function TCampo.Descricao(const Descricao: String): TCampo;
begin
  Self.FDescricao := Descricao;
  Result := Self;
end;

function TCampo.EhAtualizavel: Boolean;
begin
  Result := Self.FFlagAtualizar;
end;

function TCampo.EhChave: Boolean;
begin
  Result := Self.FFlagChave;
end;

function TCampo.EhObrigatorio: Boolean;
begin
  Result := Self.FObrigatorio;
end;

function TCampo.EhVisivel: Boolean;
begin
  Result := Self.FVisivel;
end;

function TCampo.Formato(const Formato: string): TCampo;
begin
  Self.FFormato := Formato;
  Result := Self;
end;

function TCampo.Nome(const Nome: string): TCampo;
begin
  Self.FNome := Nome;
  Result := Self;
end;

function TCampo.ObterDescricao: string;
begin
  Result := Self.FDescricao;
end;

function TCampo.ObterFormato: string;
begin
  Result := Self.FFormato;
end;

function TCampo.ObterNome: string;
begin
  Result := Self.FNome;
end;

function TCampo.ObterTamanho: Integer;
begin
  Result := Self.FTamanho;
end;

function TCampo.Tamanho(const Tamanho: Integer): TCampo;
begin
  Self.FTamanho := Tamanho;
  Result := Self;
end;

function TCampo.TornarObrigatorio: TCampo;
begin
  Self.FObrigatorio := True;
  Result := Self;
end;

{ TFabricaDeCampos }

class function TFabricaDeCampos.ObterCampo(
  const NomeDoCampo: string): TCampo;
begin
  Result := TCampo.Create(NomeDoCampo)
    .AtivarAtualizacao;
end;

class function TFabricaDeCampos.ObterCampoChave(
  const NomeDoCampo: string): TCampo;
begin
  Result := TCampo.Create(NomeDoCampo)
    .AtivarChave
    .AtivarAtualizacao;
end;

class function TFabricaDeCampos.ObterCampoVisivel(const NomeDoCampo,
  Descricao: string; const Tamanho: Integer;
  const Formato: string): TCampo;
begin
  Result := TCampo.Create(NomeDoCampo)
    .Descricao(Descricao)
    .AtivarChave
    .AtivarAtualizacao
    .AtivarVisualizacao
    .Tamanho(Tamanho)
    .Formato(Formato);
end;

{ TDominio }

function TDominio.AntesDePostarRegistro(const Evento: TDataSetNotifyEvent): TDominio;
begin
  Self.FAntesDePostarRegistro := Evento;
  Result := Self;
end;

function TDominio.Campos: TCampos;
begin
  Result := Self.FCampos;
end;

constructor TDominio.Create(const Entidade: string);
begin
  inherited Create;
  Self.FEntidade := Entidade;
  Self.FSql := TSql.Create;
  Self.FCampos := TCampos.Create;
  Self.FDetalhes := TEntidades.Create;
end;

function TDominio.Detalhes: TEntidades;
begin
  Result := Self.FDetalhes;
end;

function TDominio.Entidade: string;
begin
  Result := Self.FEntidade;
end;

function TDominio.Sql: TSql;
begin
  Result := Self.FSql;
end;

function TDominio.RegraDeNegocioGerencial(
  const RegraDeNegocio: TRegraDeNegocio): TDominio;
begin
  Self.FRegraDeNegocioGerencial := RegraDeNegocio;
  Result := Self;
end;

{ TCampos }

function TCampos.Adicionar(const Campo: TCampo): TCampos;
begin
  Self.AddObject(Campo.ObterNome, Campo);
  Result := Self;
end;

function TCampos.Campo(const NomeDoCampo: string): TCampo;
var
  _indice: Integer;
begin
  _indice := Self.IndexOf(NomeDoCampo);
  Result := nil;
  if _indice > -1 then
    Result := Self.GetObject(_indice) as TCampo;
end;

{ TEntidades }

function TEntidades.Adicionar(const Entidade: TDominio): TEntidades;
begin
  Self.AddObject(Entidade.Entidade, Entidade);
  Result := Self;
end;

end.
 