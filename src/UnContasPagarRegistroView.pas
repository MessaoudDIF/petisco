unit UnContasPagarRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExMask, JvToolEdit, JvDBControls, StdCtrls, Mask, DBCtrls,
  JvExControls, JvLinkLabel, JvComponentBase, JvBalloonHint, Menus, JvButton,
  JvTransparentButton, ExtCtrls, DB, JvExStdCtrls, JvCombobox, JvDBCombobox,
  { helsonsant }
  Util, DataUtil, UnModelo, Componentes, UnContasPagarRegistroModelo,
  UnAplicacao, ConectorDeControles, SearchUtil, UnMenuView;

type
  TContasPagarRegistroView = class(TForm, ITela)
    lblCL_OID: TJvLinkLabel;
    txtFORN_NOME: TDBEdit;
    JvLinkLabel2: TJvLinkLabel;
    txtTIT_DOC: TDBEdit;
    JvLinkLabel3: TJvLinkLabel;
    txtTIT_EMIS: TJvDBDateEdit;
    JvLinkLabel4: TJvLinkLabel;
    txtTIT_VENC: TJvDBDateEdit;
    JvLinkLabel5: TJvLinkLabel;
    txtTIT_VALOR: TDBEdit;
    JvLinkLabel7: TJvLinkLabel;
    txtCATS_DES: TDBEdit;
    JvLinkLabel10: TJvLinkLabel;
    txtCRES_DES: TDBEdit;
    JvLinkLabel12: TJvLinkLabel;
    txtTIT_HIST: TDBEdit;
    JvLinkLabel20: TJvLinkLabel;
    txtTIT_LIQ: TJvDBDateEdit;
    JvLinkLabel23: TJvLinkLabel;
    txtTIT_PAGO: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlPesquisa: TPanel;
    JvLinkLabel1: TJvLinkLabel;
    txtCAT_OID: TJvDBComboBox;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FCategoriaPesquisa: TPesquisa;
    FCentroDeResultadoPesquisa: TPesquisa;
    FControlador: IResposta;
    FContasPagarRegistroModelo: TContasPagarRegistroModelo;
    FFornecedorPesquisa: TPesquisa;
  protected
    procedure Excluir;
    procedure Inativar;
  public
    function BindControls: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  published
    procedure PrepararPesquisa(Pesquisa: TObject);
    procedure ProcessarSelecaoDeCategoria(Pesquisa: TObject);
    procedure ProcessarSelecaoDeCentroDeResultado(Pesquisa: TObject);
    procedure ProcessarSelecaoDeFornecedor(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

{ TContasPagarRegistroView }

function TContasPagarRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self, Self.FContasPagarRegistroModelo);
  Result := Self;
end;

function TContasPagarRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContasPagarRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FContasPagarRegistroModelo := nil;
  Result := Self;
end;

function TContasPagarRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TContasPagarRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FContasPagarRegistroModelo := (Modelo as TContasPagarRegistroModelo);
  Result := Self;
end;

procedure TContasPagarRegistroView.PrepararPesquisa(
  Pesquisa: TObject);
var
  _controle: TCustomEdit;
begin
  _controle := (Pesquisa as TPesquisa).ControleDeEdicao;
  Self.pnlPesquisa.Top := _controle.Top + _controle.Height + 5;
  if _controle.Name = 'txtCATS_DES' then
    (Pesquisa as TPesquisa).FiltrarPor(
      Criterio.Campo('S.CAT_OID').Igual(Self.txtCAT_OID.DataSource.DataSet.FieldByName('cat_oid').AsString).Obter)
  else
    (Pesquisa as TPesquisa).FiltrarPor('');
end;

function TContasPagarRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  Self.txtCAT_OID.ListSettings.DataSource :=
    Self.FContasPagarRegistroModelo.DataSource('cat');
  Self.txtCAT_OID.ListSettings.DisplayField := 'CAT_DES';
  Self.txtCAT_OID.ListSettings.KeyField := 'CAT_OID';
  Self.FFornecedorPesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtFORN_NOME)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('FornecedorPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeFornecedor)
    .Construir;
  Self.FCategoriaPesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtCATS_DES)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('CategoriaPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCategoria)
    .Construir;
  Self.FCentroDeResultadoPesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtCRES_DES)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('CentroDeResultadoPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCentroDeResultado)
    .Construir;
end;

procedure TContasPagarRegistroView.ProcessarSelecaoDeCategoria(
  Pesquisa: TObject);
var
  _evento: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _evento := Self.txtCATS_DES.OnChange;
  Self.txtCATS_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCATS_DES.Text := _dataSet.FieldByName('cats_des').AsString;
  Self.txtCATS_DES.OnChange := _evento;
  Self.FContasPagarRegistroModelo.DataSet.FieldByName('cats_oid').AsString :=
    _dataSet.FieldByName('cats_oid').AsString;
end;

procedure TContasPagarRegistroView.ProcessarSelecaoDeCentroDeResultado(
  Pesquisa: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.txtCRES_DES.OnChange;
  Self.txtCRES_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCRES_DES.Text := _dataSet.FieldByName('cres_des').AsString;
  Self.txtCRES_DES.OnChange := _event;
  Self.FContasPagarRegistroModelo.DataSet.FieldByName('cres_oid').AsString :=
    _dataSet.FieldByName('cres_oid').AsString;
end;

procedure TContasPagarRegistroView.ProcessarSelecaoDeFornecedor(
  Pesquisa: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.txtFORN_NOME.OnChange;
  Self.txtFORN_NOME.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtFORN_NOME.Text := _dataSet.FieldByName('forn_nome').AsString;
  Self.txtFORN_NOME.OnChange := _event;
  Self.FContasPagarRegistroModelo.DataSet.FieldByName('forn_oid').AsString :=
    _dataSet.FieldByName('forn_oid').AsString;
end;

procedure TContasPagarRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FContasPagarRegistroModelo.EhValido then
  begin
    Self.FContasPagarRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir conta a pagar!');
end;

procedure TContasPagarRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar uma conta a pagar.')
    .AdicionarOpcao('excluir', 'Excluir', 'Excluir uma conta já cadastrada.')
    .AdicionarOpcao('inativar',
      'Inativar', 'Alterar o status de uma conta para inativa.');
  try
    _resposta := _menu.Exibir;
    if _resposta = 'excluir' then
      Self.Excluir
    else
      if _resposta = 'inativar' then
        Self.Inativar;
  finally
    FreeAndNil(_menu);
  end;
end;

procedure TContasPagarRegistroView.Excluir;
begin
  Self.FContasPagarRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

procedure TContasPagarRegistroView.Inativar;
begin
  Self.FContasPagarRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

end.
