unit UnRelatorioView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, JvExControls, JvButton, JvTransparentButton, ExtCtrls,
  Grids, DBGrids,
  { helsonsant }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, UnRelatorioModelo,
  Relatorios;
  //UnResultadoGeralMesRelatorio, UnResultadoGeralAnoRelatorio,


type
  TRelatorioView = class(TForm, ITela)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    txtInicio: TJvDatePickerEdit;
    txtFim: TJvDatePickerEdit;
    txtTipo: TComboBox;
    procedure btnGravarClick(Sender: TObject);
  private
    FControlador: IResposta;
    FRelatorioModelo: TRelatorioModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

var
  RelatorioView: TRelatorioView;

implementation

uses DateUtils,
  { helsonsant }
  UnResultadoGeralMesRelatorio, UnResultadoGeralAnoRelatorio;

{$R *.dfm}

{ TRelatorioView }

function TRelatorioView.Controlador(const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TRelatorioView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FRelatorioModelo := nil;
  Result := Self;
end;

function TRelatorioView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TRelatorioView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FRelatorioModelo := (Modelo as TRelatorioModelo);
  Result := Self;
end;

function TRelatorioView.Preparar: ITela;
begin
  Result := Self;
end;

procedure TRelatorioView.btnGravarClick(Sender: TObject);
var
  _relatorio: IReport;
begin
  if Self.txtTipo.Text = 'Demonstração de Resultados Geral' then
  begin
    Self.FRelatorioModelo.CarregarResultadoGeral(Self.txtInicio.Date,
      Self.txtFim.Date);
    if MonthOf(Self.txtInicio.Date) = MonthOf(Self.txtFim.Date) then
      _relatorio := TResultadoGeralMesRelatorio.Create(nil)
    else
      _relatorio := TResultadoGeralAnoRelatorio.Create(nil);
    _relatorio.Dados(Self.FRelatorioModelo.DataSource);
    _relatorio.ObterRelatorio.Prepare;
    _relatorio.Subtitulo('Do período de: ' +
      FormatDatetime('dd/mm/yyyy', Self.txtInicio.Date) + ' até ' +
      FormatDatetime('dd/mm/yyyy', Self.txtFim.Date));
    _relatorio.ObterRelatorio.Preview;
  end
end;

end.
