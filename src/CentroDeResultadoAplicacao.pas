unit CentroDeResultadoAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnCentroDeResultadoListaRegistrosModelo,
  UnCentroDeResultadoListaRegistrosView, UnCentroDeResultadoRegistroModelo,
  UnCentroDeResultadoRegistroView;

type
  TCentroDeResultadoAplicacao = class(TAplicacao, IResposta)
  private
    FCentroDeResultadoListaRegistrosView: TCentroDeResultadoListaRegistrosView;
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

function TCentroDeResultadoAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FCentroDeResultadoListaRegistrosView.ShowModal;
  Result := Self;
end;

function TCentroDeResultadoAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TCentroDeResultadoAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Self.FCentroDeResultadoListaRegistrosView :=
    TCentroDeResultadoListaRegistrosView.Create(nil);
  Self.FCentroDeResultadoListaRegistrosView
    .Modelo(Self.FFabricaDeModelos
      .ObterModelo('CentroDeResultadoListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TCentroDeResultadoAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _registroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos
    .ObterModelo('CentroDeResultadoRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('cres_oid').igual(_OidRegistro).obter);
  end;
  _registroView := TCentroDeResultadoRegistroView.Create(nil)
    .Modelo(_modelo)
    .Controlador(Self)
    .Preparar;
  try
    _registroView.ExibirTela;
  finally
    _registroView.Descarregar;
  end;
end;

initialization
  RegisterClass(TCentroDeResultadoAplicacao);

end.
