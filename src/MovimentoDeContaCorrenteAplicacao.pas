unit MovimentoDeContaCorrenteAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao,
  UnMovimentoDeContaCorrenteListaRegistrosModelo,
  UnMovimentoDeContaCorrenteListaRegistrosView,
  UnMovimentoDeContaCorrenteRegistroView,
  UnMovimentoDeContaCorrenteImpressaoView;

type
  TMovimentoDeContaCorrenteAplicacao = class(TAplicacao, IResposta)
  private
    FMovimentoDeContaCorrenteListaRegistrosView: ITela;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

{ TMovimentoDeContaCorrenteAplicacao }

function TMovimentoDeContaCorrenteAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FMovimentoDeContaCorrenteListaRegistrosView :=
    TMovimentoDeContaCorrenteListaRegistrosView.Create(nil)
      .Modelo(Self.FFabricaDeModelos
        .ObterModelo('MovimentoDeContaCorrenteListaRegistrosModelo'))
      .Controlador(Self)
      .Preparar;
  Self.FMovimentoDeContaCorrenteListaRegistrosView.ExibirTela;
  Result := Self;
end;

function TMovimentoDeContaCorrenteAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TMovimentoDeContaCorrenteAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TMovimentoDeContaCorrenteAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _registroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos
    .ObterModelo('MovimentoDeContaCorrenteRegistroModelo');
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
        Criterio.Campo('ccormv_oid').igual(_OidRegistro).obter);
    end;
    _registroView := TMovimentoDeContaCorrenteRegistroView.Create(nil)
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
      _registroView := TMovimentoDeContaCorrenteImpressaoView.Create(nil)
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
  RegisterClass(TMovimentoDeContaCorrenteAplicacao);

end.
