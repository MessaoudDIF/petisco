unit ProdutoAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnProdutoListaRegistrosModelo,
  UnProdutoListaRegistrosView, UnProdutoRegistroModelo, UnProdutoRegistroView;

type
  TProdutoAplicacao = class(TAplicacao, IResposta)
  private
    FProdutoListaRegistrosView: TProdutoListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses SysUtils;

{ TProdutoAplicacao }

function TProdutoAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FProdutoListaRegistrosView.ShowModal;
  Result := Self;
end;

function TProdutoAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TProdutoAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Self.FProdutoListaRegistrosView := TProdutoListaRegistrosView.Create(nil);
  Self.FProdutoListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('ProdutoListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TProdutoAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _produtoRegistroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos.ObterModelo('ProdutoRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('pro_oid').igual(_OidRegistro).obter);
  end;
  _produtoRegistroView := TProdutoRegistroView.Create(nil)
    .Modelo(_modelo)
    .Controlador(Self)
    .Preparar;
  try
    _produtoRegistroView.ExibirTela;
  finally
    _produtoRegistroView.Descarregar;
  end;
end;

initialization
  RegisterClass(TProdutoAplicacao);

end.
