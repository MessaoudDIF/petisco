unit UnFornecedorProdutoView;

interface

uses
  { VCL }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, StdCtrls,
  Data.DB, Vcl.Mask, Grids, DBGrids,
  { JEDI }
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, JvExStdCtrls, JvEdit, JvValidateEdit,
  JvExMask, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, UnFornecedorRegistroModelo, SearchUtil;

type
  TFornecedorProdutoView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    gProdutos: TJvDBUltimGrid;
    pnlCategoria: TPanel;
    Label3: TLabel;
    EdtProduto: TEdit;
    btnInclui: TPanel;
    EdtQuantidade: TJvValidateEdit;
    Label1: TLabel;
    EdtProdutoOid: TEdit;
    Label2: TLabel;
    EdtValorUnitario: TJvValidateEdit;
    Label4: TLabel;
    EdtValorTotal: TJvValidateEdit;
    EdtData: TJvDatePickerEdit;
    Label5: TLabel;
    pnlProdutoPesquisa: TPanel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluiClick(Sender: TObject);
    procedure EdtQuantidadeExit(Sender: TObject);
    procedure EdtValorUnitarioExit(Sender: TObject);
  private
    FControlador: IResposta;
    FFornecedorRegistroModelo: TFornecedorRegistroModelo;
    FProdutoPesquisa: TPesquisa;
  public
    function BindControls: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
    procedure ProcessarSelecaoDeProduto(Sender: TObject);
    function TotalizaProduto(Sender: TObject): TFornecedorProdutoView;
  end;

var
  FornecedorProdutoView: TFornecedorProdutoView;

implementation

{$R *.dfm}

{ TFornecedorProdutosView }

function TFornecedorProdutoView.BindControls: ITela;
begin
  Result := Self;
end;

function TFornecedorProdutoView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TFornecedorProdutoView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FFornecedorRegistroModelo := nil;
  Result := Self;
end;

procedure TFornecedorProdutoView.EdtQuantidadeExit(Sender: TObject);
begin
  Self.TotalizaProduto(nil);
end;

procedure TFornecedorProdutoView.EdtValorUnitarioExit(Sender: TObject);
begin
  Self.TotalizaProduto(nil);
end;

function TFornecedorProdutoView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TFornecedorProdutoView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FFornecedorRegistroModelo := (Modelo as TFornecedorRegistroModelo);
  Result := Self;
end;

function TFornecedorProdutoView.Preparar: ITela;
begin
  Self.gProdutos.DataSource :=
    Self.FFornecedorRegistroModelo.DataSource('fornp');
  Self.FFornecedorRegistroModelo.CarregarProdutos;
  Self.FProdutoPesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.EdtProduto)
    .PainelDePesquisa(Self.pnlProdutoPesquisa)
    .Modelo('ProdutoPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeProduto)
    .Construir;
  Result := Self;
end;

procedure TFornecedorProdutoView.ProcessarSelecaoDeProduto(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := (Sender as TPesquisa).Modelo.DataSet();
  Self.EdtProdutoOid.Text := _dataset.FieldByName('pro_oid').AsString;
  Self.EdtProduto.Text := _dataSet.FieldByName('pro_des').AsString;
  Self.EdtQuantidade.Text := '1';
  Self.EdtValorUnitario.Text := FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
  Self.TotalizaProduto(nil);
end;

function TFornecedorProdutoView.TotalizaProduto(Sender: TObject): TFornecedorProdutoView;
begin
  if (Self.EdtQuantidade.Value > 0) and (Self.EdtValorUnitario.Value > 0) then
    Self.EdtValorTotal.Value := Self.EdtQuantidade.Value * Self.EdtValorUnitario.Value
  else
    Self.EdtValorTotal.Value := 0;
  Result := Self;
end;

procedure TFornecedorProdutoView.btnGravarClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TFornecedorProdutoView.btnIncluiClick(Sender: TObject);
begin
  Self.FFornecedorRegistroModelo.IncluirProduto(
    Self.EdtData.Date,
    Self.EdtProdutoOid.Text,
    Self.EdtProduto.Text,
    Self.EdtQuantidade.AsInteger,
    Self.EdtValorUnitario.AsCurrency,
    Self.EdtValorTotal.AsCurrency);
  Self.EdtProdutoOid.Clear;
  Self.EdtProduto.Clear;
  Self.EdtQuantidade.Value := 0;
  Self.EdtProduto.SetFocus;
end;

end.
