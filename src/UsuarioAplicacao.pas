unit UsuarioAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnUsuarioListaRegistrosModelo,
  UnUsuarioListaRegistrosView, UnUsuarioRegistroModelo, UnUsuarioRegistroView;

type
  TUsuarioAplicacao = class(TAplicacao, IResposta)
  private
    FUsuarioListaRegistrosView: TUsuarioListaRegistrosView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses SysUtils;

{ TUsuarioAplicacao }

function TUsuarioAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FUsuarioListaRegistrosView.ShowModal;
  Result := Self;
end;

function TUsuarioAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TUsuarioAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Self.FUsuarioListaRegistrosView := TUsuarioListaRegistrosView.Create(nil);
  Self.FUsuarioListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('UsuarioListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TUsuarioAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _usuarioRegistroView: ITela;
begin
  _modelo := Self.FFabricaDeModelos.ObterModelo('UsuarioRegistroModelo');
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
    _modelo.Incluir
  else
  begin
    _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
    _modelo.CarregarPor(Criterio.Campo('usr_oid').igual(_OidRegistro).obter);
  end;
  _usuarioRegistroView := TUsuarioRegistroView.Create(nil)
    .Modelo(_modelo)
    .Controlador(Self)
    .Preparar;
  try
    _usuarioRegistroView.ExibirTela;
  finally
    _usuarioRegistroView.Descarregar;
  end;
end;

initialization
  RegisterClass(TUsuarioAplicacao);

end.
