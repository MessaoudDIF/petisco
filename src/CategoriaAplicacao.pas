unit CategoriaAplicacao;

interface

uses Classes,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnCategoriaRegistroModelo,
  UnCategoriaRegistroView;

type
  TCategoriaAplicacao = class(TAplicacao, IResposta)
  private
    FCategoriaRegistroModelo: TCategoriaRegistroModelo;
    FCategoriaRegistroView: TCategoriaRegistroView;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil):
      TAplicacao; override;
  end;

implementation

uses SysUtils, Util;

{ TProdutoAplicacao }

function TCategoriaAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FCategoriaRegistroView := TCategoriaRegistroView.Create(nil)
    .Modelo(Self.FCategoriaRegistroModelo)
    .Controlador(Self)
    .Preparar;
  Self.FCategoriaRegistroView.ShowModal;
  Result := Self;
end;

function TCategoriaAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TCategoriaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Self.FCategoriaRegistroModelo :=(Self.FFabricaDeModelos
    .ObterModelo('CategoriaRegistroModelo') as TCategoriaRegistroModelo);
  Result := Self;
end;

procedure TCategoriaAplicacao.Responder(const Chamada: TChamada);
var
  _descricao: string;
  _categoria: Integer;
  _acao: AcaoDeRegistro;
begin
  _acao := RetornarAcaoDeRegistro(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);
  if _acao = adrIncluir then
  begin
    _categoria := Chamada.ObterParametros.Ler('categoria').ComoInteiro;
    _descricao :=
      Chamada.ObterParametros.Ler('descricaoCategoria').ComoTexto;
    Self.FCategoriaRegistroModelo
      .IncluirCategoria(_categoria, _descricao)
      .CarregarPor(Criterio.Campo('cat_oid').igual(_categoria).Obter);
  end
  else
    if _acao = adrCarregar then
    begin
      _categoria :=
        Chamada.ObterParametros.Ler('categoria').ComoInteiro;
      Self.FCategoriaRegistroModelo.CarregarPor(
        Criterio.Campo('cat_oid').igual(_categoria).Obter);
    end
    else
      if _acao = adrExcluir then
      begin
      end;
end;

initialization
  RegisterClass(TCategoriaAplicacao);

end.
