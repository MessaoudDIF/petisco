unit FornecedorAplicacao;

interface

uses Classes,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao,
  UnFornecedorListaRegistrosView;

type
  TFornecedorAplicacao = class(TAplicacao, IResposta)
  private
    FFornecedorListaRegistrosView: TFornecedorListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses
  { Fluente }
  UnFornecedorRegistroView, UnFornecedorProdutoView;

{ TFornecedorAplicacao }

function TFornecedorAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FFornecedorListaRegistrosView.ShowModal;
  Result := Self;
end;

function TFornecedorAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TFornecedorAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
begin
  Self.FFornecedorListaRegistrosView := TFornecedorListaRegistrosView.Create(nil);
  Self.FFornecedorListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('FornecedorListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TFornecedorAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _fornecedorRegistroView, _fornecedorProdutoView: ITela;
begin
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao in [adrIncluir, adrCarregar] then
  begin
    _modelo := Self.FFabricaDeModelos.ObterModelo('FornecedorRegistroModelo');
    if _acao = adrIncluir then
      _modelo.Incluir
    else
    begin
      _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
      _modelo.CarregarPor(Criterio.Campo('forn_oid').igual(_OidRegistro).obter);
    end;
    _fornecedorRegistroView := TFornecedorRegistroView.Create(nil)
      .Modelo(_modelo)
      .Controlador(Self)
      .Preparar;
    try
      _fornecedorRegistroView.ExibirTela;
    finally
      _fornecedorRegistroView.Descarregar;
    end;
  end
  else
    if _acao = adrOutra then
    begin
      _modelo :=
        (Chamada.ObterParametros.Ler('modelo').ComoObjeto as TModelo);
      _fornecedorProdutoView := TFornecedorProdutoView.Create(nil)
        .Modelo(_modelo)
        .Controlador(Self)
        .Preparar;
      try
        _fornecedorProdutoView.ExibirTela;
      finally
        _fornecedorProdutoView.Descarregar;
      end;
    end
end;

initialization
  RegisterClass(TFornecedorAplicacao);

end.
