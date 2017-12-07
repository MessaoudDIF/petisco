unit UnContaPagarListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, UnContasPagarListaRegistrosModelo, Componentes,
  UnAplicacao;

type
  TContaPagarListaRegistrosView = class(TForm, ITela)
    pnlTitulo: TPanel;
    btnIncluir: TJvTransparentButton;
    btnMenu: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtContaPagar: TEdit;
    gProdutos: TDBGrid;
    procedure EdtContaPagarChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    FControlador: IResposta;
    FContasPagarListaRegistrosModelo: TContasPagarListaRegistrosModelo;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TContaPagarListaRegistrosView }

function TContaPagarListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContaPagarListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FContasPagarListaRegistrosModelo := nil;
  Result := Self;
end;

function TContaPagarListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TContaPagarListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FContasPagarListaRegistrosModelo :=
    (Modelo as TContasPagarListaRegistrosModelo);
  Result := Self;
end;

function TContaPagarListaRegistrosView.Preparar: ITela;
begin
  Result := Self;
end;

procedure TContaPagarListaRegistrosView.EdtContaPagarChange(
  Sender: TObject);
begin
  if Self.EdtContaPagar.Text = '' then
    Self.FContasPagarListaRegistrosModelo.Carregar
  else
    Self.FContasPagarListaRegistrosModelo.CarregarPor(
        Criterio.Campo('FORN_NOME').como(Self.EdtContaPagar.Text).obter());
end;

procedure TContaPagarListaRegistrosView.btnIncluirClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self);
  Self.FControlador.Responder(_chamada);
end;

end.
