unit ClienteAplicacao;

interface

uses Classes,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, UnClienteListaRegistrosView;

type
  TClienteAplicacao = class(TAplicacao, IResposta)
  private
    FClienteListaRegistrosView: TClienteListaRegistrosView;
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
  UnClienteRegistroView, ComObj;

{ TClienteAplicacao }

function TClienteAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FClienteListaRegistrosView.ShowModal;
  Result := Self;
end;

function TClienteAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TClienteAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
begin
  Self.FClienteListaRegistrosView := TClienteListaRegistrosView.Create(nil);
  Self.FClienteListaRegistrosView
    .Modelo(Self.FFabricaDeModelos.ObterModelo('ClienteListaRegistrosModelo'))
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TClienteAplicacao.Responder(const Chamada: TChamada);
var
  _OidRegistro: string;
  _acao: AcaoDeRegistro;
  _modelo: TModelo;
  _clienteRegistroView: ITela;
begin
  if Chamada.ObterParametros.Ler('conta').ComoInteiro <> 0 then
    Self.FControlador.Responder(Chamada)
  else
  begin
    _modelo := Self.FFabricaDeModelos.ObterModelo('ClienteRegistroModelo');
    _acao := RetornarAcaoDeRegistro(
      Chamada.ObterParametros.Ler('acao').ComoInteiro);
    if _acao = adrIncluir then
      _modelo.Incluir
    else
    begin
      _OidRegistro := Chamada.ObterParametros.Ler('oid').ComoTexto;
      _modelo.CarregarPor(Criterio.Campo('cl_oid').igual(_OidRegistro).obter);
    end;
    _clienteRegistroView := TClienteRegistroView.Create(nil)
      .Modelo(_modelo)
      .Controlador(Self)
      .Preparar;
    try
      _clienteRegistroView.ExibirTela;
    finally
      _clienteRegistroView.Descarregar;
    end;
  end
end;

initialization
  RegisterClass(TClienteAplicacao);

end.
