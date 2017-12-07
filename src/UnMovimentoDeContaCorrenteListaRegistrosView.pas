unit UnMovimentoDeContaCorrenteListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, Grids,
  DBGrids, StdCtrls, Mask, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit,
  { helsonsant }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao,
  UnMovimentoDeContaCorrenteListaRegistrosModelo, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Data.DB;

type
  TMovimentoDeContaCorrenteListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnIncluir: TJvTransparentButton;
    pnlFiltro: TPanel;
    gMovimentos: TJvDBUltimGrid;
    btnImprimir: TJvTransparentButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EdtFiltro: TEdit;
    txtInicio: TJvDatePickerEdit;
    txtFim: TJvDatePickerEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnIncluirClick(Sender: TObject);
    procedure gMovimentosDblClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    FControlador: IResposta;
    FMovimentoDeContaCorrenteListaRegistrosModelo:
      TMovimentoDeContaCorrenteListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  published
    procedure FiltrarLancamentos(Sender: TObject);
  end;

var
  MovimentoDeContaCorrenteListaRegistrosView: TMovimentoDeContaCorrenteListaRegistrosView;

implementation

{$R *.dfm}

{ TMovimentoDeContaCorrenteListaRegistrosView }

function TMovimentoDeContaCorrenteListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeContaCorrenteListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Result := Self;
end;

function TMovimentoDeContaCorrenteListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TMovimentoDeContaCorrenteListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeContaCorrenteListaRegistrosModelo :=
    (Modelo as TMovimentoDeContaCorrenteListaRegistrosModelo);
  Result := Self;
end;

function TMovimentoDeContaCorrenteListaRegistrosView.Preparar: ITela;
begin
  Self.gMovimentos.DataSource :=
    Self.FMovimentoDeContaCorrenteListaRegistrosModelo.DataSource;
  Self.txtInicio.Date := Date - 7;
  Self.txtFim.Date := Date;
  Self.FMovimentoDeContaCorrenteListaRegistrosModelo
    .CarregarRegistros(Self.txtInicio.Date, Self.txtFim.Date,
      Self.EdtFiltro.Text);
  Result := Self;
end;

procedure TMovimentoDeContaCorrenteListaRegistrosView.btnIncluirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FMovimentoDeContaCorrenteListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TMovimentoDeContaCorrenteListaRegistrosView.FiltrarLancamentos(
  Sender: TObject);
begin
  Self.FMovimentoDeContaCorrenteListaRegistrosModelo.CarregarRegistros(
    Self.txtInicio.Date, Self.txtFim.Date, Self.EdtFiltro.Text);
end;

procedure TMovimentoDeContaCorrenteListaRegistrosView.gMovimentosDblClick(
  Sender: TObject);
var
  _parametros: TMap;
  _chamada: TChamada;
  _modelo: TModelo;
begin
  _modelo := Self.FMovimentoDeContaCorrenteListaRegistrosModelo;
  _parametros := _modelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrCarregar))
    .Gravar('oid', _modelo.DataSet.FieldByName('ccormv_oid').AsString);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TMovimentoDeContaCorrenteListaRegistrosView.btnImprimirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FMovimentoDeContaCorrenteListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrOutra))
    .Gravar('inicio', Self.txtInicio.Text)
    .Gravar('fim', Self.txtFim.Text)
    .Gravar('modelo',
      Self.FMovimentoDeContaCorrenteListaRegistrosModelo);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
