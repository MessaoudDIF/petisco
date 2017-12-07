unit ContasReceberAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao,
  UnContasReceberListaRegistrosView;

type
  TContasReceberAplicacao = class(TAplicacao, IResposta)
  private
    FContasReceberListaRegistrosView: TContasReceberListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil)
      : TAplicacao; override;
  end;

implementation

uses SysUtils,
  { Fluente }
  UnContasReceberRegistroView;

{ TContasPagarAplicacao }

function TContasReceberAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FContasReceberListaRegistrosView :=
    TContasReceberListaRegistrosView.Create(nil);
  Self.FContasReceberListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('ContasReceberListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Self.FContasReceberListaRegistrosView.ExibirTela;
  Result := Self;
end;

function TContasReceberAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TContasReceberAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TContasReceberAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _registroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos.ObterModelo('ContasReceberRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('titr_oid').igual(_OidRegistro).obter);
  end;
  _registroView := TContasReceberRegistroView.Create(nil)
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
  RegisterClass(TContasReceberAplicacao);

end.
