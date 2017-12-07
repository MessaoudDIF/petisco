unit UnProdutoAplicacao;

interface

uses Classes,
  { Fluente }
  UnModelo, Componentes, UnAplicacao, UnProdutoListaRegistrosModelo, UnProdutoListaRegistrosView,
  UnProdutoRegistroModelo, UnProdutoRegistroView;

type
  TProdutoAplicacao = class(TAplicacao, IResposta)
  private
    FProdutoListaRegistrosView: TProdutoListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(
      const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;override;
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
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
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
  _produtoRegistroView: TProdutoRegistroView;
begin
  _produtoRegistroView := TProdutoRegistroView.Create(nil);
  _produtoRegistroView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('ProdutoRegistroModelo'))
    .Controlador(Self)
    .Preparar
    .ExibirTela;
  try
    _produtoRegistroView.ExibirTela;
  finally
    _produtoRegistroView.Descarregar;
  end;
end;

initialization
  RegisterClass(TProdutoAplicacao);

end.
