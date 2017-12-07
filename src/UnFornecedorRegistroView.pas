unit UnFornecedorRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, JvExControls, JvButton, JvTransparentButton,
  ExtCtrls, StdCtrls, Mask, DBCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, ConectorDeControles,
  UnFornecedorRegistroModelo, UnMenuView, System.ImageList;

type
  TFornecedorRegistroView = class(TForm, ITela)
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EdtFORN_COD: TDBEdit;
    EdtFORN_NOME: TDBEdit;
    EdtFORN_ENDER: TDBEdit;
    EdtFORN_CIDADE: TDBEdit;
    EdtFORN_UF: TDBEdit;
    EdtFORN_BAIRRO: TDBEdit;
    EdtFORN_CEP: TDBEdit;
    EdtFORN_RG: TDBEdit;
    EdtFORN_CPF: TDBEdit;
    EdtFORN_FONE: TDBEdit;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    ImageList: TImageList;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FControlador: IResposta;
    FFornecedorRegistroModelo: TFornecedorRegistroModelo;
  protected
    procedure Excluir;
    procedure Inativar;
    procedure Produtos;
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

{ TFornecedorRegistroView }

function TFornecedorRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FFornecedorRegistroModelo.DataSource);
  Result := Self;
end;

function TFornecedorRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TFornecedorRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FFornecedorRegistroModelo := nil;
  Result := Self;
end;

function TFornecedorRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TFornecedorRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FFornecedorRegistroModelo := (Modelo as TFornecedorRegistroModelo);
  Result := Self;
end;

function TFornecedorRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
end;

procedure TFornecedorRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FFornecedorRegistroModelo.EhValido then
  begin
    Self.FFornecedorRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir produto!');
end;

procedure TFornecedorRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir, inativar um fornecedor ou informar os ' +
      'produtos fornecidos por ele.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir um fornecedor já cadastrado.')
    .AdicionarOpcao('inativar',
      'Inativar', 'Alterar o status de um fornecedor para inativo.')
    .AdicionarOpcao('produtos',
      'Produtos', 'Lista de Produtos fornecidos.');
  try
    _resposta := _menu.Exibir;
    if _resposta = 'excluir' then
      Self.Excluir
    else
      if _resposta = 'inativar' then
        Self.Inativar
      else
        if _resposta = 'produtos' then
          Self.Produtos;
  finally
    FreeAndNil(_menu);
  end;
end;

procedure TFornecedorRegistroView.Excluir;
begin
  Self.FFornecedorRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

procedure TFornecedorRegistroView.Inativar;
begin
  Self.FFornecedorRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

procedure TFornecedorRegistroView.Produtos;
var
  _parametros: TMap;
  _chamada: TChamada;
begin
  _parametros := Self.FFornecedorRegistroModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrOutra))
    .Gravar('modelo', Self.FFornecedorRegistroModelo);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
