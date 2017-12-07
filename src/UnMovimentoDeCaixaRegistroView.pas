unit UnMovimentoDeCaixaRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvCombobox, JvDBCombobox, JvButton, DB,
  JvTransparentButton, ExtCtrls, JvExMask, JvToolEdit, JvDBControls, Mask,
  DBCtrls, JvExControls, JvLinkLabel,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, UnMovimentoDeCaixaRegistroModelo,
  SearchUtil, ConectorDeControles, UnMenuView;

type
  TMovimentoDeCaixaRegistroView = class(TForm, ITela)
    JvLinkLabel7: TJvLinkLabel;
    JvLinkLabel8: TJvLinkLabel;
    JvLinkLabel9: TJvLinkLabel;
    JvLinkLabel3: TJvLinkLabel;
    JvLinkLabel5: TJvLinkLabel;
    JvLinkLabel1: TJvLinkLabel;
    JvLinkLabel12: TJvLinkLabel;
    JvLinkLabel2: TJvLinkLabel;
    JvLinkLabel6: TJvLinkLabel;
    txtCXMVO_DES: TDBEdit;
    txtCATS_DES: TDBEdit;
    txtCRES_DES: TDBEdit;
    txtCXMV_DATA: TJvDBDateEdit;
    txtCXMV_VALOR: TDBEdit;
    txtCXMV_ORDER: TDBEdit;
    txtCXMV_HIST: TDBEdit;
    txtCXMV_DOC: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlPesquisa: TPanel;
    txtCAT_OID: TJvDBComboBox;
    procedure btnMaisOpcoesClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FCategoriaPesquisa: TPesquisa;
    FCentroDeResultadoPesquisa: TPesquisa;
    FControlador: IResposta;
    FMovimentoDeCaixaRegistroModelo: TMovimentoDeCaixaRegistroModelo;
    FOperacaoPesquisa: TPesquisa;
  protected
    procedure Excluir;
    procedure Cancelar;
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
    procedure ProcessarSelecaoDeOperacao(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

{ TMovimentoDeCaixaRegistroView }

function TMovimentoDeCaixaRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FMovimentoDeCaixaRegistroModelo.DataSource);
  Result := Self;
end;

procedure TMovimentoDeCaixaRegistroView.Cancelar;
begin
  Self.FMovimentoDeCaixaRegistroModelo.Cancelar;
  Self.ModalResult := mrOk;
end;

function TMovimentoDeCaixaRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeCaixaRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FCategoriaPesquisa := nil;
  Self.FCentroDeResultadoPesquisa := nil;
  Self.FMovimentoDeCaixaRegistroModelo := nil;
  Self.FOperacaoPesquisa := nil;
  Result := Self;
end;

procedure TMovimentoDeCaixaRegistroView.Excluir;
begin
  Self.FMovimentoDeCaixaRegistroModelo.Excluir;
  Self.ModalResult := mrOk;  
end;

function TMovimentoDeCaixaRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TMovimentoDeCaixaRegistroView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeCaixaRegistroModelo :=
    (Modelo as TMovimentoDeCaixaRegistroModelo);
  Result := Self;
end;

function TMovimentoDeCaixaRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  { Configura ComboBox }
  Self.txtCAT_OID.ListSettings.DataSource :=
    Self.FMovimentoDeCaixaRegistroModelo.DataSource('cat');
  Self.txtCAT_OID.ListSettings.DisplayField := 'CAT_DES';
  Self.txtCAT_OID.ListSettings.KeyField := 'CAT_OID';
  { Pesquisas }
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
  Self.FOperacaoPesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtCXMVO_DES)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('OperacaoDeMovimentoDeCaixaPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeOperacao)
    .Construir;
end;

procedure TMovimentoDeCaixaRegistroView.PrepararPesquisa(
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

procedure TMovimentoDeCaixaRegistroView.ProcessarSelecaoDeCategoria(
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
  Self.FMovimentoDeCaixaRegistroModelo.DataSet
    .FieldByName('cats_oid').AsString :=
      _dataSet.FieldByName('cats_oid').AsString;
end;

procedure TMovimentoDeCaixaRegistroView.ProcessarSelecaoDeCentroDeResultado(
  Pesquisa: TObject);
var
  _evento: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _evento := Self.txtCRES_DES.OnChange;
  Self.txtCRES_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCRES_DES.Text := _dataSet.FieldByName('cres_des').AsString;
  Self.txtCRES_DES.OnChange := _evento;
  Self.FMovimentoDeCaixaRegistroModelo.DataSet
    .FieldByName('cres_oid').AsString :=
      _dataSet.FieldByName('cres_oid').AsString;
end;

procedure TMovimentoDeCaixaRegistroView.ProcessarSelecaoDeOperacao(
  Pesquisa: TObject);
var
  _evento: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _evento := Self.txtCXMVO_DES.OnChange;
  Self.txtCXMVO_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCXMVO_DES.Text := _dataSet.FieldByName('cxmvo_des').AsString;
  Self.txtCXMVO_DES.OnChange := _evento;
  Self.FMovimentoDeCaixaRegistroModelo.DataSet
    .FieldByName('cxmvo_oid').AsString :=
      _dataSet.FieldByName('cxmvo_oid').AsString;
end;

procedure TMovimentoDeCaixaRegistroView.btnMaisOpcoesClick(
  Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou cancelar um registro de movimento ' +
      'de caixa.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir um registro de movimento de caixa.')
    .AdicionarOpcao('cancelar',
      'cancelar', 'Cancelar o registro de um movimento de caixa.');
  try
    _resposta := _menu.Exibir;
    if _resposta = 'excluir' then
      Self.Excluir
    else
      if _resposta = 'cancelar' then
        Self.Cancelar;
  finally
    FreeAndNil(_menu);
  end;
end;

procedure TMovimentoDeCaixaRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FMovimentoDeCaixaRegistroModelo.EhValido then
  begin
    Self.FMovimentoDeCaixaRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao registrar movimento de caixa!');
end;

end.
