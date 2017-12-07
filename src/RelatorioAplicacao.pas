unit RelatorioAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnRelatorioModelo,
  UnRelatorioView;

type
  TRelatorioAplicacao = class(TAplicacao, IResposta)
  private
    FRelatorioView: ITela;
    FRelatorioModelo: TRelatorioModelo;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(
      const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;override;
  end;

implementation

{ TRelatorioAplicacao }

function TRelatorioAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FRelatorioView := TRelatorioView.Create(nil)
    .Modelo(Self.FRelatorioModelo)
    .Controlador(Self)
    .Preparar;
  Self.FRelatorioView.ExibirTela;
  Result := Self;
end;

procedure TRelatorioAplicacao.Responder(const Chamada: TChamada);
begin
end;

function TRelatorioAplicacao.Descarregar: TAplicacao;
begin
  if Self.FRelatorioView <> nil then
    Self.FRelatorioView.Descarregar;
  Result := Self;
end;

function TRelatorioAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
begin
  Self.FRelatorioModelo :=
    (Self.FFabricaDeModelos.ObterModelo('RelatorioModelo') as TRelatorioModelo);
  Result := Self;
end;

initialization
  RegisterClass(TRelatorioAplicacao);

end.
