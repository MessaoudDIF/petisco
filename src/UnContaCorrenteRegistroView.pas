unit UnContaCorrenteRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, StdCtrls, DB,
  Mask, DBCtrls, JvLinkLabel,
  { helsonsant }
  Util, DataUtil, UnModelo, UnContaCorrenteRegistroModelo, Componentes,
  UnAplicacao, ConectorDeControles, UnMenuView, SearchUtil;

type
  TContaCorrenteRegistroView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    lblCNPJCPF: TJvLinkLabel;
    JvLinkLabel1: TJvLinkLabel;
    JvLinkLabel2: TJvLinkLabel;
    JvLinkLabel3: TJvLinkLabel;
    JvLinkLabel4: TJvLinkLabel;
    JvLinkLabel5: TJvLinkLabel;
    JvLinkLabel6: TJvLinkLabel;
    txtCCOR_COD: TDBEdit;
    txtCCOR_AGN: TDBEdit;
    txtCCOR_AGNDG: TDBEdit;
    txtCCOR_CONTA: TDBEdit;
    txtCCOR_CONTADG: TDBEdit;
    txtCCOR_LIM: TDBEdit;
    txtCCOR_SALDO: TDBEdit;
    txtCCOR_DES: TDBEdit;
    txtBAN_NOME: TDBEdit;
    pnlPesquisa: TPanel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FContaCorrentePesquisa: TPesquisa;
    FContaCorrenteRegistroModelo: TContaCorrenteRegistroModelo;
    FControlador: IResposta;
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
    procedure ProcessarSelecaoDeBanco(Pesquisa: TObject);
  end;

implementation

{$R *.dfm}

{ TContaCorrenteRegistroView }

function TContaCorrenteRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FContaCorrenteRegistroModelo.DataSource);
  Result := Self;
end;

function TContaCorrenteRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContaCorrenteRegistroView.Descarregar: ITela;
begin
  Result := Self;
end;

procedure TContaCorrenteRegistroView.Excluir;
begin
  Self.FContaCorrenteRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

function TContaCorrenteRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TContaCorrenteRegistroView.Inativar;
begin
  Self.FContaCorrenteRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

function TContaCorrenteRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FContaCorrenteRegistroModelo := (Modelo as TContaCorrenteRegistroModelo);
  Result := Self;
end;

function TContaCorrenteRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  Self.FContaCorrentePesquisa := TConstrutorDePesquisas
    .ControleDeEdicao(Self.txtBAN_NOME)
    .PainelDePesquisa(Self.pnlPesquisa)
    .Modelo('BancoPesquisaModelo')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeBanco)
    .Construir;
end;

procedure TContaCorrenteRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FContaCorrenteRegistroModelo.EhValido then
  begin
    Self.FContaCorrenteRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir conta corrente!');
end;

procedure TContaCorrenteRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar uma conta corrente.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir uma conta corrente já cadastrada.')
    .AdicionarOpcao('inativar',
      'Inativar', 'Alterar o status de uma conta corrente para inativa.');
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

procedure TContaCorrenteRegistroView.ProcessarSelecaoDeBanco(
  Pesquisa: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.txtBAN_NOME.OnChange;
  Self.txtBAN_NOME.OnChange := nil;
  _dataSet := TPesquisa(Pesquisa).Modelo.DataSet;
  Self.txtBAN_NOME.Text := _dataSet.FieldByName('ban_nome').AsString;
  Self.txtBAN_NOME.OnChange := _event;
  Self.FContaCorrenteRegistroModelo.DataSet.FieldByName('ban_oid').AsString :=
    _dataSet.FieldByName('ban_oid').AsString;
end;

end.
