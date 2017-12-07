unit UnMovimentoDeCaixaListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, Grids,
  DBGrids, StdCtrls, Mask, JvExMask, JvToolEdit, JvMaskEdit,
  JvCheckedMaskEdit, JvDatePickerEdit,
  { helsonsant }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao,
  UnMovimentoDeCaixaListaRegistrosModelo, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Data.DB;

type
  TMovimentoDeCaixaListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnIncluir: TJvTransparentButton;
    btnImprimir: TJvTransparentButton;
    pnlFiltro: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    txtInicio: TJvDatePickerEdit;
    txtFim: TJvDatePickerEdit;
    GroupBox2: TGroupBox;
    EdtFiltro: TEdit;
    gMovimentos: TJvDBUltimGrid;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure gMovimentosDblClick(Sender: TObject);
  private
    FControlador: IResposta;
    FMovimentoDeCaixaListaRegistrosModelo: TMovimentoDeCaixaListaRegistrosModelo;
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
  MovimentoDeCaixaListaRegistrosView: TMovimentoDeCaixaListaRegistrosView;

implementation

{$R *.dfm}

{ TMovimentoDeCaixaListaRegistrosView }

function TMovimentoDeCaixaListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeCaixaListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FMovimentoDeCaixaListaRegistrosModelo := nil;
  Result := Self;
end;

function TMovimentoDeCaixaListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TMovimentoDeCaixaListaRegistrosView.FiltrarLancamentos(
  Sender: TObject);
begin
  Self.FMovimentoDeCaixaListaRegistrosModelo.CarregarRegistros(
    Self.txtInicio.Date, Self.txtFim.Date, Self.EdtFiltro.Text);
end;

function TMovimentoDeCaixaListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeCaixaListaRegistrosModelo :=
    (Modelo as TMovimentoDeCaixaListaRegistrosModelo);
  Result := Self;
end;

function TMovimentoDeCaixaListaRegistrosView.Preparar: ITela;
begin
  Self.gMovimentos.DataSource :=
    Self.FMovimentoDeCaixaListaRegistrosModelo.DataSource;
  Self.txtInicio.Date := Date - 7;
  Self.txtFim.Date := Date;
  Self.FMovimentoDeCaixaListaRegistrosModelo
    .CarregarRegistros(Self.txtInicio.Date, Self.txtFim.Date,
      Self.EdtFiltro.Text);
  Result := Self;
end;

procedure TMovimentoDeCaixaListaRegistrosView.btnIncluirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FMovimentoDeCaixaListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TMovimentoDeCaixaListaRegistrosView.btnImprimirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FMovimentoDeCaixaListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrOutra))
    .Gravar('inicio', Self.txtInicio.Text)
    .Gravar('fim', Self.txtFim.Text)
    .Gravar('modelo',
      Self.FMovimentoDeCaixaListaRegistrosModelo);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TMovimentoDeCaixaListaRegistrosView.gMovimentosDblClick(
  Sender: TObject);
var
  _parametros: TMap;
  _chamada: TChamada;
  _modelo: TModelo;
begin
  _modelo := Self.FMovimentoDeCaixaListaRegistrosModelo;
  _parametros := _modelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrCarregar))
    .Gravar('oid', _modelo.DataSet.FieldByName('cxmv_oid').AsString);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
