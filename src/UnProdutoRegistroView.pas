unit UnProdutoRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, DB, ImgList, Menus, StdCtrls, Mask, DBCtrls,
  JvExControls, JvButton, JvTransparentButton, DBClient, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  { helsonsant }
  Util, DataUtil, UnModelo, UnProdutoRegistroModelo, Componentes, UnAplicacao,
  ConectorDeControles, UnMenuView, JvExStdCtrls, JvEdit, JvValidateEdit;

type
  TProdutoRegistroView = class(TForm, ITela)
    Panel1: TPanel;
    ExtPRO_COD: TDBEdit;
    EdtPRO_DES: TDBEdit;
    EdtPRO_CUSTO: TDBEdit;
    EdtPRO_VENDA: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    gIngredientes: TJvDBUltimGrid;
    JvTransparentButton1: TJvTransparentButton;
    Label5: TLabel;
    EdtSaldoEstoque: TJvValidateEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FControlador: IResposta;
    FProdutoRegistroModelo: TProdutoRegistroModelo;
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
  end;

implementation

{$R *.dfm}

{ TProdutoRegistroView }

function TProdutoRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FProdutoRegistroModelo := nil;
  Result := Self;
end;

function TProdutoRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FProdutoRegistroModelo := (Modelo as TProdutoRegistroModelo);
  Result := Self;
end;

function TProdutoRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
  Self.EdtSaldoEstoque.Value := Self.FProdutoRegistroModelo.retornarSaldoEstoque;
  Self.gIngredientes.DataSource := Self.FProdutoRegistroModelo.DataSource('procom');
end;

function TProdutoRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TProdutoRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TProdutoRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FProdutoRegistroModelo.DataSource);
  Result := Self;
end;

procedure TProdutoRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FProdutoRegistroModelo.EhValido then
  begin
    Self.FProdutoRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir produto!');
end;

procedure TProdutoRegistroView.Excluir;
begin
  Self.FProdutoRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

procedure TProdutoRegistroView.Inativar;
begin
  Self.FProdutoRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

procedure TProdutoRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar um produto.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir um produto já cadastrado.')
    .AdicionarOpcao('inativar',
      'Inativar', 'Alterar o status de um produto para inativo.');
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
