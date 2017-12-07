unit UnClienteRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ImgList, StdCtrls, Mask, DBCtrls, JvExControls, JvButton,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, UnClienteRegistroModelo,
  ConectorDeControles, UnMenuView, System.ImageList;

type
  TClienteRegistroView = class(TForm, ITela)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    ExtCL_COD: TDBEdit;
    EdtCL_NOME: TDBEdit;
    EdtCL_CARENCIA: TDBEdit;
    EdtCL_LIMITE: TDBEdit;
    ImageList: TImageList;
    EdtCL_ENDER: TDBEdit;
    Label5: TLabel;
    EdtCL_CIDADE: TDBEdit;
    Label6: TLabel;
    EdtCL_UF: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    EdtCL_BAIRRO: TDBEdit;
    Label9: TLabel;
    EdtCL_CEP: TDBEdit;
    Label10: TLabel;
    EdtCL_RG: TDBEdit;
    Label11: TLabel;
    EdtCL_CPF: TDBEdit;
    Label12: TLabel;
    EdtCL_FONE: TDBEdit;
    btnContaCliente: TJvTransparentButton;
    procedure btnGravarClick(Sender: TObject);
    procedure btnMaisOpcoesClick(Sender: TObject);
    procedure btnContaClienteClick(Sender: TObject);
  private
    FControlador: IResposta;
    FClienteRegsitroModelo: TClienteRegistroModelo;
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

{ TClienteRegistroView }

function TClienteRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FClienteRegsitroModelo.DataSource);
  Result := Self;
end;

function TClienteRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TClienteRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FClienteRegsitroModelo := nil;
  Result := Self;
end;

function TClienteRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TClienteRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FClienteRegsitroModelo := (Modelo as TClienteRegistroModelo);
  Result := Self;
end;

function TClienteRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
end;

procedure TClienteRegistroView.btnContaClienteClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('conta', Ord(adrCarregar))
      .Gravar('oid', Self.FClienteRegsitroModelo.DataSet.FieldByName('cl_oid').AsString)
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TClienteRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FClienteRegsitroModelo.EhValido then
  begin
    Self.FClienteRegsitroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir cliente!');
end;

procedure TClienteRegistroView.btnMaisOpcoesClick(Sender: TObject);
var
  _resposta: string;
  _menu: TMenuView;
begin
  _menu := TMenuView.Create(nil)
    .Legenda('Selecione sua Opção:')
    .Mensagem('Aqui você pode excluir ou inativar um cliente.')
    .AdicionarOpcao('excluir', 'Excluir', 'Excluir um cliente já cadastrado')
    .AdicionarOpcao('inativar', 'Inativar', 'Alterar o status de um cliente para inativo');
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

procedure TClienteRegistroView.Excluir;
begin
  Self.FClienteRegsitroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

procedure TClienteRegistroView.Inativar;
begin
  Self.FClienteRegsitroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

end.
