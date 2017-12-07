unit MovimentoDeCaixaAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao,
  UnMovimentoDeCaixaListaRegistrosModelo,
  UnMovimentoDeCaixaListaRegistrosView,
  UnMovimentoDeCaixaRegistroView,
  UnMovimentoDeCaixaImpressaoView;

type
  TMovimentoDeCaixaAplicacao = class(TAplicacao, IResposta)
  private
    FMovimentoDeCaixaListaRegistrosView: ITela;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

{ TMovimentoDeContaCorrenteAplicacao }

function TMovimentoDeCaixaAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FMovimentoDeCaixaListaRegistrosView :=
    TMovimentoDeCaixaListaRegistrosView.Create(nil)
      .Modelo(Self.FFabricaDeModelos
        .ObterModelo('MovimentoDeCaixaListaRegistrosModelo'))
      .Controlador(Self)
      .Preparar;
  Self.FMovimentoDeCaixaListaRegistrosView.ExibirTela;
  Result := Self;
end;

function TMovimentoDeCaixaAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TMovimentoDeCaixaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TMovimentoDeCaixaAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _registroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos
    .ObterModelo('MovimentoDeCaixaRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao in [adrIncluir, adrCarregar] then
  begin
    if _acao = adrIncluir then
      _modelo.Incluir
    else
    begin
      _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
      _modelo.CarregarPor(
        Criterio.Campo('cxmv_oid').igual(_OidRegistro).obter);
    end;
    _registroView := TMovimentoDeCaixaRegistroView.Create(nil)
      .Modelo(_modelo)
      .Controlador(Self)
      .Preparar;
    try
      _registroView.ExibirTela;
    finally
      _registroView.Descarregar;
    end;
  end
  else
    if _acao = adrOutra then
    begin
      _modelo := (Chamada.ObterParametros.Ler('modelo').ComoObjeto
        as TModelo);
      _registroView := TMovimentoDeCaixaImpressaoView.Create(nil)
        .Controlador(Self)
        .Modelo(_modelo)
        .Preparar;
      try
        _registroView.ExibirTela;
      finally
        _registroView.Descarregar;
      end;
    end
end;

initialization
  RegisterClass(TMovimentoDeCaixaAplicacao);

end.
