unit ContaCorrenteAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao,
  UnContaCorrenteListaRegistrosModelo, UnContaCorrenteListaRegistrosView,
  UnContaCorrenteRegistroView;

type
  TContaCorrenteAplicacao = class(TAplicacao, IResposta)
  private
    FContaCorrenteListaRegistrosView: TContaCorrenteListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses SysUtils;

{ TContaCorrenteAplicacao }

function TContaCorrenteAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FContaCorrenteListaRegistrosView :=
    TContaCorrenteListaRegistrosView.Create(nil);
  Self.FContaCorrenteListaRegistrosView
      .Modelo(Self.FFabricaDeModelos
        .ObterModelo('ContaCorrenteListaRegistrosModelo'))
      .Controlador(Self)
      .Preparar;
  Self.FContaCorrenteListaRegistrosView.ShowModal;
  Result := Self;
end;

function TContaCorrenteAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TContaCorrenteAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TContaCorrenteAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _registroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos.ObterModelo('ContaCorrenteRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('ccor_oid').igual(_OidRegistro).obter);
  end;
  _registroView := TContaCorrenteRegistroView.Create(nil)
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
  RegisterClass(TContaCorrenteAplicacao);

end.
