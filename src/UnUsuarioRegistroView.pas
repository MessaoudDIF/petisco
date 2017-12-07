unit UnUsuarioRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, StdCtrls, Mask, DBCtrls, JvExControls, JvButton,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, UnUsuarioRegistroModelo, Componentes, UnAplicacao,
  ConectorDeControles, UnMenuView;

type
  TUsuarioRegistroView = class(TForm, ITela)
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    EdtUSR_NAME: TDBEdit;
    EdtUSR_PW: TDBEdit;
    EdtUSR_ADM: TDBCheckBox;
    Label1: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
  private
    FControlador: IResposta;
    FUsuarioRegistroModelo: TUsuarioRegistroModelo;
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

{ TUsuarioRegistroView }

function TUsuarioRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FUsuarioRegistroModelo.DataSource);
  Result := Self;
end;

function TUsuarioRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TUsuarioRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FUsuarioRegistroModelo := nil;
  Result := Self;
end;

function TUsuarioRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TUsuarioRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FUsuarioRegistroModelo := (Modelo as TUsuarioRegistroModelo);
  Result := Self;
end;

function TUsuarioRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls
end;

procedure TUsuarioRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FUsuarioRegistroModelo.EhValido then
  begin
    Self.FUsuarioRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.Mensagem('Erro ao cadastrar USUÁRIO!');
end;

procedure TUsuarioRegistroView.Excluir;
begin
  Self.FUsuarioRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

procedure TUsuarioRegistroView.Inativar;
begin
  Self.FUsuarioRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

procedure TUsuarioRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar um usuário.')
    .AdicionarOpcao('excluir',
      'Excluir', 'Excluir um usuário já cadastrado.')
    .AdicionarOpcao('inativar',
      'Inativar', 'Alterar o status de um usuário para inativo.');
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
