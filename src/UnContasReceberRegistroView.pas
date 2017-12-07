unit UnContasReceberRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvCombobox, JvDBCombobox, JvButton, DB,
  JvTransparentButton, ExtCtrls, JvExMask, JvToolEdit, JvDBControls, Mask,
  DBCtrls, JvExControls, JvLinkLabel,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, Componentes,
  UnContasReceberRegistroModelo, UnMenuView, SearchUtil, ConectorDeControles;

type
  TContasReceberRegistroView = class(TForm, ITela)
    lblCL_OID: TJvLinkLabel;
    JvLinkLabel2: TJvLinkLabel;
    JvLinkLabel3: TJvLinkLabel;
    JvLinkLabel4: TJvLinkLabel;
    JvLinkLabel5: TJvLinkLabel;
    JvLinkLabel7: TJvLinkLabel;
    JvLinkLabel10: TJvLinkLabel;
    JvLinkLabel12: TJvLinkLabel;
    JvLinkLabel20: TJvLinkLabel;
    JvLinkLabel23: TJvLinkLabel;
    JvLinkLabel1: TJvLinkLabel;
    txtCL_NOME: TDBEdit;
    txtTITR_DOC: TDBEdit;
    txtTITR_EMIS: TJvDBDateEdit;
    txtTITR_VENC: TJvDBDateEdit;
    txtTITR_VALOR: TDBEdit;
    txtCATS_DES: TDBEdit;
    txtCRES_DES: TDBEdit;
    txtTITR_HIST: TDBEdit;
    txtTITR_LIQ: TJvDBDateEdit;
    txtTITR_PAGO: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlPesquisa: TPanel;
    txtCAT_OID: TJvDBComboBox;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FCategoriaPesquisa: TPesquisa;
    FCentroDeResultadoPesquisa: TPesquisa;
    FClientePesquisa: TPesquisa;
    FControlador: IResposta;
    FContasReceberRegistroModelo: TContasReceberRegistroModelo;
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
    procedure ProcessarSelecaoDeCliente(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

{ TContasReceberRegistroView }

function TContasReceberRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FContasReceberRegistroModelo.DataSource);
  Result := Self;
end;

function TContasReceberRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContasReceberRegistroView.Descarregar: ITela;
begin
  Self.FCategoriaPesquisa := nil;
  Self.FCentroDeResultadoPesquisa := nil;
  Self.FClientePesquisa := nil;
  Self.FControlador := nil;
  Self.FContasReceberRegistroModelo := nil;
  Result := Self;
end;

procedure TContasReceberRegistroView.Excluir;
begin
  Self.FContasReceberRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

function TContasReceberRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TContasReceberRegistroView.Inativar;
begin
  Self.FContasReceberRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

function TContasReceberRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FContasReceberRegistroModelo :=
    (Modelo as TContasReceberRegistroModelo);
  Result := Self;
end;

function TContasReceberRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  Self.txtCAT_OID.ListSettings.DataSource :=
    Self.FContasReceberRegistroModelo.DataSource('cat');
  Self.txtCAT_OID.ListSettings.DisplayField := 'CAT_DES';
  Self.txtCAT_OID.ListSettings.KeyField := 'CAT_OID';
  Self.FClientePesquisa := TConstrutorDePesquisas
    .AcaoAntesDeAtivar(Self.PrepararPesquisa)
    .ControleDeEdicao(Self.txtCL_NOME)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('ClientePesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCliente)
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

procedure TContasReceberRegistroView.PrepararPesquisa(Pesquisa: TObject);
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

procedure TContasReceberRegistroView.ProcessarSelecaoDeCategoria(
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
  Self.FContasReceberRegistroModelo.DataSet.FieldByName('cats_oid').AsString :=
    _dataSet.FieldByName('cats_oid').AsString;
end;

procedure TContasReceberRegistroView.ProcessarSelecaoDeCentroDeResultado(
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
  Self.FContasReceberRegistroModelo.DataSet.FieldByName('cres_oid').AsString :=
    _dataSet.FieldByName('cres_oid').AsString;
end;

procedure TContasReceberRegistroView.ProcessarSelecaoDeCliente(
  Pesquisa: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.txtCL_NOME.OnChange;
  Self.txtCL_NOME.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtCL_NOME.Text := _dataSet.FieldByName('cl_nome').AsString;
  Self.txtCL_NOME.OnChange := _event;
  Self.FContasReceberRegistroModelo.DataSet.FieldByName('cl_oid').AsString :=
    _dataSet.FieldByName('cl_oid').AsString;
end;

procedure TContasReceberRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FContasReceberRegistroModelo.EhValido then
  begin
    Self.FContasReceberRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir conta a receber!');
end;

procedure TContasReceberRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar uma conta a receber.')
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

end.
