unit UnRemocaoInclusaoIngredientesView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, StdCtrls,
  JvExControls, JvButton, JvTransparentButton, ExtCtrls, ComCtrls,
  JvExComCtrls, JvComCtrls, JvComponentBase, JvTabBar, JvExStdCtrls,
  JvEdit, JvValidateEdit, DB, System.UITypes,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, UnComandaModelo;

type
  TRemocaoInclusaoIngredientesView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    Panel2: TPanel;
    btnRemoverIngredientes: TPanel;
    btnIncluirIngredientes: TPanel;
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    gIngredientes: TJvDBUltimGrid;
    TabSheet2: TTabSheet;
    Panel5: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdtIngrediente: TEdit;
    EdtValor: TJvValidateEdit;
    Panel6: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    gIngredientesInseridos: TJvDBUltimGrid;
    procedure btnRemoverIngredientesClick(Sender: TObject);
    procedure btnIncluirIngredientesClick(Sender: TObject);
    procedure gIngredientesDblClick(Sender: TObject);
    procedure gIngredientesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Panel6Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FComandaModelo: TComandaModelo;
    FControlador: IResposta;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela:  Integer;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
  published
    procedure AtivarAba(const Aba: TPanel);
    procedure DesativarAba(const Aba: TPanel); 
  end;

implementation

{$R *.dfm}

procedure TRemocaoInclusaoIngredientesView.AtivarAba(const Aba: TPanel);
begin
  Aba.Color := $0082A901;
  Aba.Font.Color := clWhite;
end;

procedure TRemocaoInclusaoIngredientesView.btnRemoverIngredientesClick(Sender: TObject);
begin
  Self.AtivarAba(Self.btnRemoverIngredientes);
  Self.DesativarAba(Self.btnIncluirIngredientes);
  Self.Pages.ActivePageIndex := 0;
end;

procedure TRemocaoInclusaoIngredientesView.DesativarAba(const Aba: TPanel);
begin
  Aba.Color := clSilver;
  Aba.Font.Color := clTeal;
end;

procedure TRemocaoInclusaoIngredientesView.btnIncluirIngredientesClick(
  Sender: TObject);
begin
  Self.AtivarAba(Self.btnIncluirIngredientes);
  Self.DesativarAba(Self.btnRemoverIngredientes);
  Self.Pages.ActivePageIndex := 1;
end;

function TRemocaoInclusaoIngredientesView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TRemocaoInclusaoIngredientesView.Descarregar: ITela;
begin
  Result := Self;
end;

function TRemocaoInclusaoIngredientesView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TRemocaoInclusaoIngredientesView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FComandaModelo := (Modelo as TComandaModelo);
  Result := Self;
end;

function TRemocaoInclusaoIngredientesView.Preparar: ITela;
begin
  Self.gIngredientes.DataSource :=
    Self.FComandaModelo.DataSource('ingredientes');
  Self.gIngredientesInseridos.DataSource :=
    Self.FComandaModelo.DataSource('comaie');
  Result := Self;
end;

procedure TRemocaoInclusaoIngredientesView.gIngredientesDblClick(
  Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.gIngredientes.DataSource.DataSet;
  _dataSet.Edit;
  if _dataSet.FieldByName('situacao').AsInteger = 1 then
    _dataSet.FieldByName('situacao').AsInteger := 0
  else
    _dataSet.FieldByName('situacao').AsInteger := 1;
end;

procedure TRemocaoInclusaoIngredientesView.gIngredientesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  _dataSet: TDataSet;
  _grid: TJvDBUltimGrid;
begin
  _dataSet := Self.gIngredientes.DataSource.DataSet;
  _grid := Self.gIngredientes;
  if _dataSet.FieldByName('situacao').AsInteger = 1 then
  begin
    _grid.Canvas.Font.Style := _grid.Canvas.Font.Style + [fsStrikeOut];
    _grid.Canvas.Font.Color := clRed;
  end
  else
  begin
    _grid.Canvas.Font.Style := _grid.Canvas.Font.Style - [fsStrikeOut];
    _grid.Canvas.Font.Color := clTeal;
  end;
  _grid.DefaultDrawDataCell(Rect, _grid.columns[datacol].field, State)
end;

procedure TRemocaoInclusaoIngredientesView.Panel6Click(Sender: TObject);
begin
  {
  if Self.EdtIngrediente.Text <> '' then
    Self.FComandaModelo.InserirIngrediente(Self.EdtIngrediente.Text);
  }
end;

procedure TRemocaoInclusaoIngredientesView.btnGravarClick(Sender: TObject);
begin
  Self.FComandaModelo.RemoverIngredientes;
  Self.FComandaModelo.SalvarComanda;
  Self.ModalResult := mrOk;
end;

end.
