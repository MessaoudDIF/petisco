unit UnComandaView;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Buttons,
  Dialogs, ExtCtrls, StdCtrls, ImgList, DB, SqlExpr, FMTBcd, Provider, DBClient, System.ImageList,
  // JEDI
  JvExExtCtrls, JvExtComponent, JvPanel, JvExButtons, JvBitBtn, JvExStdCtrls, JvButton,
  Vcl.Mask, JvExMask,
  // helsonsant
  Util, UnModelo, UnComandaModelo, UnProduto, Componentes, SearchUtil, UnAplicacao,
  UnRemocaoInclusaoIngredientesView, UnTeclado, JvToolEdit;

type
  AcoesDeComanda = (acmdImprimir, acmdDividir, acmdLancarPagamentoCartaoDeDebito, acmdLancarPagamentoCartaoDeCredito,
    acmdLancarPagamentoDinheiro, acmdExibirPagamentos, acmdFecharConta, acmdAlterarCliente);

  TComandaView = class(TForm, ITela, IResposta)
    pnlDesktop: TPanel;
    pnl: TPanel;
    lblIdComanda: TEdit;
    pnlSumario: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    EdtProduto: TJvComboEdit;
    EdtQtde: TEdit;
    EdtTotal: TEdit;
    btnDecQtde: TButton;
    btnIncQtde: TButton;
    EdtValor: TEdit;
    btnLancar: TBitBtn;
    ScrollBox: TScrollBox;
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
    btnOk: TPanel;
    btnImprimir: TPanel;
    EdtCod: TEdit;
    btnDividir: TPanel;
    btnLancarDebito: TPanel;
    btnLancarCredito: TPanel;
    btnLancarDinheiro: TPanel;
    btnVisualizarPagamentos: TPanel;
    btnFecharConta: TPanel;
    pnlDetalheView: TPanel;
    DetalheView: TMemo;
    ImageList: TImageList;
    pnlClientePesquisa: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure btnLancarClick(Sender: TObject);
    procedure btnDecQtdeClick(Sender: TObject);
    procedure btnIncQtdeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDividirClick(Sender: TObject);
    procedure btnLancarDebitoClick(Sender: TObject);
    procedure btnLancarCreditoClick(Sender: TObject);
    procedure btnLancarDinheiroClick(Sender: TObject);
    procedure btnVisualizarPagamentosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnFecharContaClick(Sender: TObject);
    procedure EdtProdutoEnter(Sender: TObject);
    procedure EdtProdutoExit(Sender: TObject);
    procedure EdtProdutoButtonClick(Sender: TObject);
    procedure lblIdComandaEnter(Sender: TObject);
    procedure lblIdComandaExit(Sender: TObject);
  private
    FClientePesquisa: TPesquisa;
    FControlador: IResposta;
    FComandaModelo: TComandaModelo;
    FAoFecharComanda: TNotifyEvent;
    FProdutoPesquisa: TPesquisa;
    FTeclado: TTeclado;
  protected
    function CarregarItens: TComandaView;
    function AtualizarTotalItem: TComandaView;
    function AtualizarTotais: TComandaView;
    procedure AtualizarConta(Sender: TObject);
    procedure AtualizarDivisaoDaConta(Sender: TObject);
    function GetTeclado(Sender: TObject): TTeclado;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela:  Integer;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    procedure Responder(const Chamada: TChamada);
  published
    procedure AlterarIngredientes(Sender: TObject);
    procedure GravarEdicaoDeItem(Sender: TObject);
    procedure ProcessarSelecaoDoProduto(Sender: TObject);
    procedure ProcessarSelecaoDeCliente(Pesquisa: TObject);
  end;

  function RetornarAcaoDeComanda(const CodigoDaAcaoDeComanda: Integer): AcoesDeComanda;

var
  ComandaView: TComandaView;

implementation

{$R *.dfm}

{ TItem }

procedure TComandaView.btnDecQtdeClick(Sender: TObject);
var
  _valor: Integer;
begin
  _valor := StrToInt(Self.edtQtde.Text);
  if _valor > 1 then
  begin
    Self.edtQtde.Text := IntToStr(_valor-1);
    Self.AtualizarTotalItem();
  end;
end;

procedure TComandaView.btnIncQtdeClick(Sender: TObject);
begin
  Self.edtQtde.Text := IntToStr(StrToInt(Self.edtQtde.Text) + 1);
  Self.AtualizarTotalItem()
end;

procedure TComandaView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

function TComandaView.CarregarItens: TComandaView;
var
  _dataSet: TDataSet;
begin
  Result := Self;
  _dataSet := Self.FComandaModelo.DataSet('comai');
  if _dataSet.RecordCount > 0 then
  begin
    _dataSet.Last();
    while not _dataSet.Bof do
    begin
      TItemEdit.Create(nil)
        .Container(Self.ScrollBox)
        .Imagens(Self.ImageList)
        .Item(TItem.Create
          .Identificacao(_dataSet.FieldByName('comai_oid').AsString)
          .Produto(TProduto.Create(_dataSet.FieldByName('pro_oid').AsString,
            _dataSet.FieldByName('pro_des').AsString,
            _dataSet.FieldByName('comai_unit').AsFloat)
          )
          .Quantidade(_dataSet.FieldByName('comai_qtde').AsInteger)
        )
        .AlterarIngredientes(Self.AlterarIngredientes)
        .AposEditar(Self.GravarEdicaoDeItem)
        .Montar;
      _dataSet.Prior();
    end;
  end;
end;

procedure TComandaView.btnLancarClick(Sender: TObject);
var
  _oid: string;
begin
  _oid := Self.FComandaModelo.InserirItem(
    Self.EdtOid.Text,
    Self.EdtProduto.Text,
    StrToFloat(Self.edtValor.Text),
    StrToFloat(Self.edtQtde.Text),
    StrToFloat(Self.edtTotal.Text)
  );
  { Insere Item na lista }
  TItemEdit.Create(nil)
    .Imagens(Self.ImageList)
    .Container(Self.ScrollBox)
    .Item(TItem.Create
      .Identificacao(_oid)
      .Produto(TProduto.Create(Self.EdtOid.Text,
        Self.EdtProduto.Text,
        StrToFloat(Self.EdtValor.Text))
      )
      .Quantidade(StrToInt(Self.EdtQtde.Text))
    )
    .AlterarIngredientes(Self.AlterarIngredientes)
    .AposEditar(Self.GravarEdicaoDeItem)
    .Montar;
  Self.EdtOid.Clear;
  TUtil.AtualizarCampoDeEdicao(Self.EdtProduto, '');
  Self.EdtQtde.Text := '1';
  Self.EdtValor.Clear;
  Self.EdtTotal.Clear;
  Self.EdtProduto.SetFocus();
  Self.AtualizarTotais();
end;

function TComandaView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FComandaModelo := nil;
  Self.FAoFecharComanda := nil;
  Self.FProdutoPesquisa.Descarregar;
  FreeAndNil(Self.FProdutoPesquisa);
  Result := Self;
end;

procedure TComandaView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Self.ModalResult <> mrOK then
    Action := caNone
  else
    if Assigned(Self.FAoFecharComanda) then
      Self.FAoFecharComanda(Self.FComandaModelo);
end;

function TComandaView.Preparar: ITela;
var
  _dataSet: TDataSet;
begin
  Result := Self;
  _dataSet := Self.FComandaModelo.DataSet;
  _dataSet.First();
  if _dataSet.FieldByName('coma_cliente').AsString <> '' then
    Self.lblIdComanda.Text := Self.FComandaModelo.DataSet.FieldByName('coma_cliente').AsString
  else
    Self.lblIdComanda.Text := 'Mesa ' + _dataSet.FieldByName('coma_mesa').AsString;
  Self.FClientePesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.lblIdComanda)
    .PainelDePesquisa(Self.pnlClientePesquisa)
    .Modelo('ClientePesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCliente)
    .Construir;

  Self.FProdutoPesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.EdtProduto)
    .PainelDePesquisa(Self.pnlProdutoPesquisa)
    .Modelo('ProdutoPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDoProduto)
    .Construir;
  Self
    .CarregarItens
    .AtualizarTotais;
end;

procedure TComandaView.ProcessarSelecaoDeCliente(Pesquisa: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdAlterarCliente))
    );
  TUtil.AtualizarCampoDeEdicao(Self.lblIdComanda, TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_cod').AsString);
  Self.FComandaModelo
    .Parametros
      .Gravar('cl_oid', TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_oid').AsString)
      .Gravar('cl_cod', TPesquisa(Pesquisa).Modelo.DataSet.FieldByName('cl_cod').AsString);
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.ProcessarSelecaoDoProduto(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := (Sender as TPesquisa).Modelo.DataSet;
  Self.EdtOid.Text := _dataset.FieldByName('pro_oid').AsString;
  Self.EdtProduto.Text := _dataSet.FieldByName('pro_des').AsString;
  Self.EdtValor.Text := FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
  Self.EdtTotal.Text := FormatFloat('0.00', _dataSet.FieldByName('pro_venda').AsFloat);
end;

function TComandaView.AtualizarTotais: TComandaView;
var
  _dataSet: TDataSet;
  _consumo, _taxaServico, _saldo:  Real;
begin
  Result := Self;
  _dataSet := Self.FComandaModelo.DataSet;
  _consumo := _dataSet.FieldByName('coma_consumo').AsFloat;
  _taxaServico := _dataSet.FieldByName('coma_txserv').AsFloat;
  _saldo := _dataSet.FieldByName('coma_saldo').AsFloat;
  Self.lblConsumo.Caption := FormatFloat('###,##0.00', _consumo);
  Self.lblTaxaServico.Caption := FormatFloat('###,##0.00', _taxaServico);
  Self.lblTotal.Caption := FormatFloat('###,##0.00', _consumo + _taxaServico);
  Self.lblSaldo.Caption := FormatFloat('###,##0.00', _saldo);
end;

function TComandaView.AtualizarTotalItem: TComandaView;
begin
  Result := Self;
  if Self.edtValor.Text <> '' then
    Self.EdtTotal.Text := FormatFloat('###,##0.00', StrToFloat(Self.edtQtde.Text) * StrToFloat(Self.edtValor.Text));
end;

function TComandaView.Modelo(const Modelo: TModelo): ITela;
begin
  Result := Self;
  Self.FComandaModelo := (Modelo as TComandaModelo);
end;

procedure TComandaView.AtualizarDivisaoDaConta(Sender: TObject);
begin
  Self.DetalheView.Lines.Clear();
  Self.DetalheView.Text := Self.FComandaModelo.Parametros.Ler('divisao').ComoTexto;
end;

procedure TComandaView.btnDividirClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdDividir))
    )
    .AposChamar(Self.AtualizarDivisaoDaConta);
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.btnFecharContaClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(Self.AtualizarConta)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdFecharConta))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.btnLancarDebitoClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(Self.AtualizarConta)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdLancarPagamentoCartaoDeDebito))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.AtualizarConta(Sender: TObject);
begin
  if not Self.FComandaModelo.EstaAberta then
    Self.ModalResult := mrOk;
end;

procedure TComandaView.btnLancarCreditoClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(Self.AtualizarConta)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdLancarPagamentoCartaoDeCredito))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.btnLancarDinheiroClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(Self.AtualizarConta)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdLancarPagamentoDinheiro))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.btnVisualizarPagamentosClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdExibirPagamentos))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TComandaView.Responder(const Chamada: TChamada);
begin

end;

function TComandaView.Controlador(const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

procedure TComandaView.EdtProdutoButtonClick(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TComandaView.EdtProdutoEnter(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TComandaView.EdtProdutoExit(Sender: TObject);
begin
  Self.FTeclado.Visible := False;
end;

function TComandaView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function RetornarAcaoDeComanda(const CodigoDaAcaoDeComanda: Integer): AcoesDeComanda;
begin
  case CodigoDaAcaoDeComanda of
    0: Result := acmdImprimir;
    1: Result := acmdDividir;
    2: Result := acmdLancarPagamentoCartaoDeDebito;
    3: Result := acmdLancarPagamentoCartaoDeCredito;
    4: Result := acmdLancarPagamentoDinheiro;
    5: Result := acmdExibirPagamentos;
    6: Result := acmdFecharConta;
    else
    Result := acmdAlterarCliente;
  end;
end;

procedure TComandaView.btnImprimirClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(acmdImprimir))
      .Gravar('obs', Self.DetalheView.Text)
    );
  Self.FControlador.Responder(_chamada);
end;

function TComandaView.GetTeclado(Sender: TObject): TTeclado;
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Left := 15;
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height - 30;
    Self.FTeclado.Parent := Self;
  end;
  Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  Result := Self.FTeclado;
end;

procedure TComandaView.GravarEdicaoDeItem(Sender: TObject);
var
  _oid: string;
  _quantidade: Integer;
begin
  if Sender is TItem then
  begin
    _oid := TItem(Sender).ObterIdentificacao;
    _quantidade := Trunc(TItem(Sender).ObterQuantidade);
    Self.FComandaModelo.AtualizarQuantidadeItem(_oid, _quantidade);
    Self.FComandaModelo.SalvarComanda;
    Self.AtualizarConta(Sender);
  end;
end;

procedure TComandaView.lblIdComandaEnter(Sender: TObject);
begin
  Self.GetTeclado(Sender).Exibir;
end;

procedure TComandaView.AlterarIngredientes(Sender: TObject);
var
  _view: ITela;
  _item: TItem;
begin
  _item := TItemEdit(Sender).ObterItem;
  try
    Self.FComandaModelo
      .CarregarIngredientes(_item.ObterIdentificacao, _item.ObterProduto.GetCodigo)
      .Parametros.Gravar('item', _item.ObterIdentificacao);
    _view := TRemocaoInclusaoIngredientesView.Create(nil)
      .Modelo(Self.FComandaModelo)
      .Preparar;
    _view.ExibirTela;
  finally
    FreeAndNil(_view);
  end;
end;

procedure TComandaView.lblIdComandaExit(Sender: TObject);
begin
  Self.GetTeclado(Sender).Visible := False;
end;

end.
