unit ContasPagarAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnProdutoListaRegistrosModelo,
  UnContasPagarListaRegistrosView, UnProdutoRegistroModelo, UnProdutoRegistroView;

type
  TContasPagarAplicacao = class(TAplicacao, IResposta)
  private
    FContasPagarListaRegistrosView: TContasPagarListaRegistrosView;
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
  UnContasPagarRegistroView;

{ TContasPagarAplicacao }

function TContasPagarAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FContasPagarListaRegistrosView :=
    TContasPagarListaRegistrosView.Create(nil);
  Self.FContasPagarListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('ContasPagarListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Self.FContasPagarListaRegistrosView.ExibirTela;
  Result := Self;
end;

function TContasPagarAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TContasPagarAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TContasPagarAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _contasPagarRegistroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos.ObterModelo('ContasPagarRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler(('acao')).ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('tit_oid').igual(_OidRegistro).obter);
  end;
  _contasPagarRegistroView := TContasPagarRegistroView.Create(nil)
    .Modelo(_modelo)
    .Controlador(Self)
    .Preparar;
  try
    _contasPagarRegistroView.ExibirTela;
  finally
    _contasPagarRegistroView.Descarregar;
  end;
end;

initialization
  RegisterClass(TContasPagarAplicacao);

end.
