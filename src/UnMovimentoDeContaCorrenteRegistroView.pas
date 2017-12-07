unit UnMovimentoDeContaCorrenteRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExMask, JvToolEdit, JvDBControls, StdCtrls, Mask, DBCtrls, DB,
  JvExControls, JvLinkLabel, JvButton, JvTransparentButton, ExtCtrls,
  { helsonsant }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, ConectorDeControles,
  UnMovimentoDeContaCorrenteRegistroModelo, SearchUtil, UnMenuView,
  JvExStdCtrls, JvCombobox, JvDBCombobox;

type
  TMovimentoDeContaCorrenteRegistroView = class(TForm, ITela)
    JvLinkLabel7: TJvLinkLabel;
    JvLinkLabel8: TJvLinkLabel;
    JvLinkLabel9: TJvLinkLabel;
    JvLinkLabel3: TJvLinkLabel;
    JvLinkLabel5: TJvLinkLabel;
    JvLinkLabel1: TJvLinkLabel;
    JvLinkLabel12: TJvLinkLabel;
    JvLinkLabel2: TJvLinkLabel;
    JvLinkLabel4: TJvLinkLabel;
    txtCCORMVO_DES: TDBEdit;
    txtCATS_DES: TDBEdit;
    txtCRES_DES: TDBEdit;
    txtCCORMV_DATA: TJvDBDateEdit;
    txtCCORMV_VALOR: TDBEdit;
    txtCCORMV_ORDER: TDBEdit;
    txtCCORMV_HIST: TDBEdit;
    txtCCORMV_DOC: TDBEdit;
    txtCCOR_DES: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlPesquisa: TPanel;
    JvLinkLabel6: TJvLinkLabel;
    txtCAT_OID: TJvDBComboBox;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FCategoriaPesquisa: TPesquisa;
    FCentroDeResultadoPesquisa: TPesquisa;
    FContaCorrentePesquisa: TPesquisa;
    FControlador: IResposta;
    FMovimentoDeContaCorrenteRegistroModelo:
      TMovimentoDeContaCorrenteRegistroModelo;
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
    procedure ProcessarSelecaoDeContaCorrente(Pesquisa: TObject);
    procedure ProcessarSelecaoDeOperacao(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

{ TMovimentoDeContaCorrenteRegistroView }

function TMovimentoDeContaCorrenteRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FMovimentoDeContaCorrenteRegistroModelo.DataSource);
  Result := Self;
end;

function TMovimentoDeContaCorrenteRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TMovimentoDeContaCorrenteRegistroView.Descarregar: ITela;
begin
  Result := Self;
end;

procedure TMovimentoDeContaCorrenteRegistroView.Excluir;
begin
  Self.FMovimentoDeContaCorrenteRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

function TMovimentoDeContaCorrenteRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TMovimentoDeContaCorrenteRegistroView.Cancelar;
begin
  Self.FMovimentoDeContaCorrenteRegistroModelo.Cancelar;
  Self.ModalResult := mrOk;
end;

function TMovimentoDeContaCorrenteRegistroView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FMovimentoDeContaCorrenteRegistroModelo :=
    (Modelo as TMovimentoDeContaCorrenteRegistroModelo);
  Result := Self;
end;

function TMovimentoDeContaCorrenteRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  { Configura ComboBox }
  Self.txtCAT_OID.ListSettings.DataSource :=
    Self.FMovimentoDeContaCorrenteRegistroModelo.DataSource('cat');
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
  Self.FContaCorrentePesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtCCOR_DES)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('ContaCorrentePesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeContaCorrente)
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
    .ControleDeEdicao(Self.txtCCORMVO_DES)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('OperacaoDeMovimentoDeContaCorrentePesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeOperacao)
    .Construir;
end;

procedure TMovimentoDeContaCorrenteRegistroView.PrepararPesquisa(
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

procedure TMovimentoDeContaCorrenteRegistroView.ProcessarSelecaoDeCategoria(
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
  Self.FMovimentoDeContaCorrenteRegistroModelo.DataSet
    .FieldByName('cats_oid').AsString :=
      _dataSet.FieldByName('cats_oid').AsString;
end;

procedure TMovimentoDeContaCorrenteRegistroView.ProcessarSelecaoDeCentroDeResultado(
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
  Self.FMovimentoDeContaCorrenteRegistroModelo.DataSet
    .FieldByName('cres_oid').AsString :=
      _dataSet.FieldByName('cres_oid').AsString;
end;

procedure TMovimentoDeContaCorrenteRegistroView.ProcessarSelecaoDeContaCorrente(
  Pesquisa: TObject);
var
  _evento: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _evento := Self.txtCCOR_DES.OnChange;
  Self.txtCCOR_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCCOR_DES.Text := _dataSet.FieldByName('ccor_des').AsString;
  Self.txtCCOR_DES.OnChange := _evento;
  Self.FMovimentoDeContaCorrenteRegistroModelo.DataSet
    .FieldByName('ccor_oid').AsString :=
      _dataSet.FieldByName('ccor_oid').AsString;
end;

procedure TMovimentoDeContaCorrenteRegistroView.ProcessarSelecaoDeOperacao(
  Pesquisa: TObject);
var
  _evento: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _evento := Self.txtCCORMVO_DES.OnChange;
  Self.txtCCORMVO_DES.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCCORMVO_DES.Text := _dataSet.FieldByName('ccormvo_des').AsString;
  Self.txtCCORMVO_DES.OnChange := _evento;
  Self.FMovimentoDeContaCorrenteRegistroModelo.DataSet
    .FieldByName('ccormvo_oid').AsString :=
      _dataSet.FieldByName('ccormvo_oid').AsString;
end;

procedure TMovimentoDeContaCorrenteRegistroView.btnGravarClick(
  Sender: TObject);
begin
  if Self.FMovimentoDeContaCorrenteRegistroModelo.EhValido then
  begin
    Self.FMovimentoDeContaCorrenteRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao registrar movimento de conta corrente!');
end;

procedure TMovimentoDeContaCorrenteRegistroView.btnMaisOpcoesClick(
  Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou cancelar um registro de movimento ' +
      'de conta corrente.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir um registro de movimento de conta corrente.')
    .AdicionarOpcao('cancelar',
      'cancelar', 'Cancelar o registro de um movimento de conta corrente.');
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

end.
