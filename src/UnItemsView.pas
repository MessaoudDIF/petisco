unit UnItemsView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList, DB, SqlExpr, FMTBcd, Provider, DBClient,
  JvExExtCtrls, JvExtComponent, JvPanel, Buttons,
  { Fluente }
  UnComandaModelo, UnComandaController, UnProduto, Componentes, SearchUtil;

type
  TItemsView = class(TForm)
    pnlDesktop: TPanel;
    pnl: TPanel;
    lblIdComanda: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    EdtProduto: TEdit;
    EdtQtde: TEdit;
    EdtTotal: TEdit;
    btnDecQtde: TButton;
    btnIncQtde: TButton;
    EdtValor: TEdit;
    btnLancar: TBitBtn;
    ScrollBox: TScrollBox;
    ImageList: TImageList;
    Panel6: TPanel;
    Panel7: TPanel;
    lblSaldo: TLabel;
    lblConsumo: TLabel;
    pnlProdutoPesquisa: TPanel;
    Panel3: TPanel;
    lblTaxaServico: TLabel;
    Panel4: TPanel;
    lblTotal: TLabel;
    pnlCommand: TJvPanel;
    EdtOid: TEdit;
    Panel5: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure btnFecharContaClick(Sender: TObject);
    procedure btnLancarClick(Sender: TObject);
    procedure btnDecQtdeClick(Sender: TObject);
    procedure btnIncQtdeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FComandaController: TComandaController;
    FComandaModelo: TComandaModelo;
    FObserver: TNotifyEvent;
    FProdutoPesquisa: TPesquisa;
  protected
    procedure carregarItens;
    procedure TotalizaItem;
    procedure TotalizaComanda;
  public
    constructor Create(const ComandaModelo: TComandaModelo;
      const Observer: TNotifyEvent); reintroduce;
    procedure AfterFecharConta(Sender: TObject);
    procedure AfterLancarPagamento(Sender: TObject);
    procedure ClearInstance;
    procedure InitInstance;
    procedure ProcessarSelecaoDoProduto(Sender: TObject);
  end;

var
  ItemsView: TItemsView;

implementation

{$R *.dfm}

{ TItem }

procedure TItemsView.AfterFecharConta(Sender: TObject);
begin

end;

procedure TItemsView.AfterLancarPagamento(Sender: TObject);
begin

end;

procedure TItemsView.btnDecQtdeClick(Sender: TObject);
var
  _valor: Integer;
begin
  _valor := StrToInt(Self.edtQtde.Text);
  if _valor > 1 then
  begin
    Self.edtQtde.Text := IntToStr(_valor-1);
    Self.TotalizaItem();
  end;
end;

procedure TItemsView.btnFecharContaClick(Sender: TObject);
begin
  Self.FComandaController.FecharConta(Self, Self.AfterFecharConta);
end;

procedure TItemsView.btnIncQtdeClick(Sender: TObject);
begin
  Self.edtQtde.Text := IntToStr(StrToInt(Self.edtQtde.Text) + 1);
  Self.TotalizaItem()
end;

procedure TItemsView.btnOkClick(Sender: TObject);
begin
  if Assigned(Self.FObserver) then
    Self.FObserver(Self.FComandaModelo);
  Self.ModalResult := mrOk;
end;

procedure TItemsView.carregarItens;
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FComandaModelo.DataSet('comai');
  if _dataSet.RecordCount > 0 then
  begin
    _dataSet.Last();
    while not _dataSet.Bof do
    begin
        { Insere Item na lista }
      TItemEdit.Create(Self.ScrollBox,
        TProduto.Create(_dataSet.FieldByName('pro_cod').AsString,
          _dataSet.FieldByName('pro_des').AsString,
          _dataSet.FieldByName('comai_unit').AsFloat,
          _dataSet.FieldByName('comai_qtde').AsFloat));
      _dataSet.Prior();
    end;
  end;
end;

procedure TItemsView.btnLancarClick(Sender: TObject);
begin
  { Insere item no modelo de dados }
  Self.FComandaModelo.InserirItem(
    Self.EdtOid.Text,
    StrToFloat(Self.edtValor.Text),
    StrToFloat(Self.edtQtde.Text),
    StrToFloat(Self.edtTotal.Text));
  { Salva comanda }
  Self.FComandaModelo.SalvarComanda();
  { Insere Item na lista }
  TItemEdit.Create(Self.ScrollBox,
    TProduto.Create('', Self.edtProduto.Text,
    StrToFloat(Self.edtValor.Text),
    StrToFloat(Self.edtQtde.Text)));
  { Limpa campos de edicao }
  Self.EdtOid.Clear;
  Self.EdtProduto.Clear;
  Self.EdtQtde.Text := '1';
  Self.EdtValor.Clear;
  Self.EdtTotal.Clear;
  { Posiciona cursor no campo descricao de produtos }
  Self.EdtProduto.SetFocus();
  { Atualiza Totalizadores }
  Self.TotalizaComanda();
end;

procedure TItemsView.ClearInstance;
begin

end;

constructor TItemsView.Create(const ComandaModelo: TComandaModelo;
  const Observer: TNotifyEvent);
begin
  inherited Create(nil);
  Self.FComandaModelo := ComandaModelo;
  Self.FObserver := Observer;
end;

procedure TItemsView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Self.ModalResult <> mrOK then
    Action := caNone;
end;

procedure TItemsView.InitInstance;
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FComandaModelo.DataSet();
  if _dataSet.FieldByName('cl_oid').AsString <> '' then
    Self.lblIdComanda.Caption :=
      Self.FComandaModelo.DataSet().FieldByName('cl_cod').AsString
  else
    Self.lblIdComanda.Caption :=
      'Mesa ' + _dataSet.FieldByName('coma_mesa').AsString;
  Self.FComandaController := TComandaController.Create(Self.FComandaModelo);
  Self.FProdutoPesquisa := TConstrutorDePesquisas
    .CampoDeEdicao(Self.EdtProduto)
    .PainelDePesquisa(Self.pnlProdutoPesquisa)
    .Modelo('ProdutoModeloPesquisa')
    .AcaoAoSelecionar(Self.ProcessarSelecaoDoProduto)
    .construir();
  Self.carregarItens();
  Self.TotalizaComanda();
end;

procedure TItemsView.ProcessarSelecaoDoProduto(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := (Sender as TPesquisa).Modelo.DataSet();
  Self.EdtOid.Text := _dataset.FieldByName('pro_oid').AsString;
  Self.edtProduto.Text := _dataSet.FieldByName('pro_des').AsString;
  Self.edtValor.Text :=
    FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
  Self.EdtTotal.Text :=
    FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
end;

procedure TItemsView.TotalizaComanda;
var
  _consumo, _taxaServico:  Real;
begin
  _consumo := Self.FComandaModelo.DataSet().FieldByName('coma_total').AsFloat;
  _taxaServico := Self.FComandaModelo.DataSet().FieldByName('coma_txserv').AsFloat;

  Self.lblConsumo.Caption := FormatFloat('###,##0.00', _consumo);
  Self.lblTaxaServico.Caption := FormatFloat('###,##0.00', _taxaServico);
  Self.lblTotal.Caption := FormatFloat('###,##0.00', _consumo + _taxaServico);
end;

procedure TItemsView.TotalizaItem;
begin
  if Self.edtValor.Text <> '' then
    Self.EdtTotal.Text := FormatFloat('###,##0.00',
      StrToFloat(Self.edtQtde.Text) * StrToFloat(Self.edtValor.Text));
end;

end.
