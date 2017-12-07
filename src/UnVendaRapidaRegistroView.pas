unit UnVendaRapidaRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls, Mask, DBCtrls, JvExControls, JvButton, JvTransparentButton,
  ExtCtrls, JvExMask, JvToolEdit, JvBaseEdits, JvExStdCtrls, JvEdit, DB,
  JvValidateEdit,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, UnVendaRapidaRegistroModelo,
  UnMenuView, UnTeclado, SearchUtil, Vcl.Buttons;

type
  TVendaRapidaRegistroView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    txtValor: TJvEdit;
    txtProdutos: TJvComboEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel17: TPanel;
    Panel16: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    txtFita: TMemo;
    Panel20: TPanel;
    Panel21: TPanel;
    pnlProdutoPesquisa: TPanel;
    btnDecQtde: TButton;
    EdtQtde: TEdit;
    btnIncQtde: TButton;
    Label3: TLabel;
    EdtTotal: TEdit;
    Label4: TLabel;
    EdtProdutoOid: TEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure Panel21Click(Sender: TObject);
    procedure txtProdutosExit(Sender: TObject);
    procedure btnIncQtdeClick(Sender: TObject);
    procedure btnDecQtdeClick(Sender: TObject);
    procedure txtProdutosEnter(Sender: TObject);
    procedure txtProdutosButtonClick(Sender: TObject);
  private
    FResultado: Real;
    FOperacao: Integer;
    FProdutoPesquisa: TPesquisa;
    FControlador: IResposta;
    FVendaRapidaRegistroModelo: TVendaRapidaRegistroModelo;
    FTeclado: TTeclado;
  protected
    procedure Calcular;
    function GetTeclado(Sender: TObject): TTeclado;
    function TotalizarItem: TVendaRapidaRegistroView;
  public
    function BindControls: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  published
    procedure Limpar(Sender: TObject);
    procedure ProcessarNumero(Sender: TObject);
    procedure ProcessarOperacao(Sender: TObject);
    procedure ProcessarSelecaoDoProduto(Sender: TObject);
    procedure Resultado(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TVendaRapidaRegistroView }

function TVendaRapidaRegistroView.BindControls: ITela;
begin
  Result := Self;
end;

function TVendaRapidaRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TVendaRapidaRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Result := Self;
end;

function TVendaRapidaRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TVendaRapidaRegistroView.GetTeclado(Sender: TObject): TTeclado;
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height;
    Self.FTeclado.Parent := Self;
    Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  end;
  Result := Self.FTeclado;
end;

function TVendaRapidaRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FVendaRapidaRegistroModelo := (Modelo as TVendaRapidaRegistroModelo);
  Result := Self;
end;

procedure TVendaRapidaRegistroView.Panel21Click(Sender: TObject);
begin
  Self.txtValor.Text := Copy(Self.txtValor.Text, 1, Length(Self.txtValor.Text)-1);
end;

function TVendaRapidaRegistroView.Preparar: ITela;
begin
  Self.FOperacao := -1;
  Self.FProdutoPesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.txtProdutos)
    .PainelDePesquisa(Self.pnlProdutoPesquisa)
    .Modelo('ProdutoPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDoProduto)
    .Construir;
  Result := Self;
end;

procedure TVendaRapidaRegistroView.ProcessarSelecaoDoProduto(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := (Sender as TPesquisa).Modelo.DataSet();
  Self.EdtProdutoOid.Text := _dataset.FieldByName('pro_oid').AsString;
  Self.txtProdutos.Text := _dataSet.FieldByName('pro_des').AsString;
  Self.txtValor.Text := FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
  Self.EdtTotal.Text := FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
end;

procedure TVendaRapidaRegistroView.btnDecQtdeClick(Sender: TObject);
var
  _valor: Integer;
begin
  _valor := StrToInt(Self.edtQtde.Text);
  if _valor > 1 then
  begin
    Self.edtQtde.Text := IntToStr(_valor-1);
    Self.TotalizarItem();
  end;
end;

procedure TVendaRapidaRegistroView.btnGravarClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
  _dataSet: TDataSet;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Informe o vendedor:')
    .Mensagem('Informe o vendedor que realizou a venda.');
  _dataSet := Self.FVendaRapidaRegistroModelo.DataSet('usr');
  _dataSet.First;
  while not _dataSet.Eof do
  begin
    _menu.AdicionarOpcao(_dataSet.FieldByName('usr_name').AsString,
      _dataSet.FieldByName('usr_name').AsString);
    _dataSet.Next;
  end;
  try
    _resposta := _menu.Exibir;
    if _resposta <> '' then
    begin
      if (Self.txtValor.Text <> '') and  (StrToFloat(Self.txtValor.Text) > 0) then
      begin
        Self.FVendaRapidaRegistroModelo.InserirVendaRapida(
          StrToFloat(Self.txtValor.Text),
          0, 0, Self.txtProdutos.Text + ' : ' + _resposta, Self.EdtProdutoOid.Text, StrToInt(Self.EdtQtde.Text)) ;
      end;
      Self.ModalResult := mrOk;
    end;
  finally
    FreeAndNil(_menu);
  end;
end;

procedure TVendaRapidaRegistroView.btnIncQtdeClick(Sender: TObject);
begin
  Self.edtQtde.Text := IntToStr(StrToInt(Self.edtQtde.Text) + 1);
  Self.TotalizarItem()
end;

procedure TVendaRapidaRegistroView.Limpar(Sender: TObject);
begin
  Self.txtValor.Text := '';
  Self.txtFita.Lines.Clear;
  Self.FResultado := -1;
  Self.FOperacao := -1;
end;

procedure TVendaRapidaRegistroView.ProcessarNumero(Sender: TObject);
begin
  Self.txtValor.Text := Self.txtValor.Text + TPanel(Sender).Caption;
end;

procedure TVendaRapidaRegistroView.ProcessarOperacao(Sender: TObject);
begin
  if Self.FOperacao > -1 then
    Self.Calcular
  else
  begin
    Self.FResultado := StrToFloat(Self.txtValor.Text);
    Self.txtFita.Lines.Add(Self.txtValor.Text);
    Self.txtValor.Clear;
  end;
  Self.FOperacao := TComponent(Sender).Tag;
    case Self.FOperacao of
      0: Self.txtFita.Lines.Add('÷');
      1: Self.txtFita.Lines.Add('x');
      2: Self.txtFita.Lines.Add('+');
      3: Self.txtFita.Lines.Add('-');
    end;
end;

procedure TVendaRapidaRegistroView.Resultado(Sender: TObject);
begin
  Self.Calcular;
end;

function TVendaRapidaRegistroView.TotalizarItem: TVendaRapidaRegistroView;
begin
  if Self.txtValor.Text <> '' then
    Self.EdtTotal.Text := FormatFloat('###,##0.00',
      StrToFloat(Self.edtQtde.Text) * StrToFloat(Self.txtValor.Text));
  Result := Self;
end;

procedure TVendaRapidaRegistroView.txtProdutosButtonClick(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TVendaRapidaRegistroView.txtProdutosEnter(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TVendaRapidaRegistroView.txtProdutosExit(Sender: TObject);
begin
  Self.GetTeclado(Sender).Visible := False;
end;

procedure TVendaRapidaRegistroView.Calcular;
begin
  if (Self.FOperacao = -1) and (Self.txtValor.Text <> '') then
    Self.FResultado := StrToFloat(Self.txtValor.Text)
  else
  begin
    Self.txtFita.Lines.Add(Self.txtValor.Text);
    case Self.FOperacao of
      0:
      begin
        Self.FResultado := Self.FResultado / StrToFloat(Self.txtValor.Text);
      end;
      1: Self.FResultado := Self.FResultado * StrToFloat(Self.txtValor.Text);
      2: Self.FResultado := Self.FResultado + StrToFloat(Self.txtValor.Text);
      3: Self.FResultado := Self.FResultado - StrToFloat(Self.txtValor.Text);
    end;
  end;
  if Self.FResultado <> -1 then
  begin
    Self.txtValor.Text := FormatFloat('0.00', Self.FResultado);
    Self.FOperacao := -1;
    Self.txtFita.Lines.Add('=');
    Self.txtFita.Lines.Add(FormatFloat('0.00', Self.FResultado));
  end;
end;

end.
