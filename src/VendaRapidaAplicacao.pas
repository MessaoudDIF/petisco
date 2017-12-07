unit VendaRapidaAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnVendaRapidaRegistroModelo,
  UnVendaRapidaRegistroView;

type
  TVendaRapidaAplicacao = class(TAplicacao, IResposta)
  private
    FVendaRapidaRegistroView: ITela;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses SysUtils;

{ TVendaRapidaAplicacao }

function TVendaRapidaAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FVendaRapidaRegistroView := TVendaRapidaRegistroView.Create(nil)
    .Modelo(Self.FFabricaDeModelos.ObterModelo('VendaRapidaRegistroModelo'))
    .Controlador(Self)
    .Preparar;
  try
    Self.FVendaRapidaRegistroView.ExibirTela;
  finally
    Self.FVendaRapidaRegistroView.Descarregar;
  end;
  Result := Self;
end;

function TVendaRapidaAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TVendaRapidaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Result := Self;
end;

procedure TVendaRapidaAplicacao.Responder(const Chamada: TChamada);
begin

end;

initialization
  RegisterClass(TVendaRapidaAplicacao);

end.
