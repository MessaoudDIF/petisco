unit UnCentroDeResultadoRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, JvExControls, JvButton, JvTransparentButton,
  ExtCtrls,
  { helsonsant }
  Util, DataUtil, UnAplicacao, Componentes, UnModelo,
  UnCentroDeResultadoRegistroModelo, ConectorDeControles, UnMenuView;

type
  TCentroDeResultadoRegistroView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    Label1: TLabel;
    EdtCRES_COD: TDBEdit;
    Label2: TLabel;
    EdtCRES_DES: TDBEdit;
    procedure btnGravarClick(Sender: TObject);
  private
    FControlador: IResposta;
    FCentroDeResultadoRegistroModelo: TCentroDeResultadoRegistroModelo;
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

{ TCentroDeResultadoRegistroView }

function TCentroDeResultadoRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self,
    Self.FCentroDeResultadoRegistroModelo.DataSource);
  Result := Self;
end;

function TCentroDeResultadoRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TCentroDeResultadoRegistroView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FCentroDeResultadoRegistroModelo := nil;
  Result := Self;
end;

procedure TCentroDeResultadoRegistroView.Excluir;
begin
  Self.FCentroDeResultadoRegistroModelo.Excluir;
  Self.ModalResult := mrOk;
end;

function TCentroDeResultadoRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TCentroDeResultadoRegistroView.Inativar;
begin
  Self.FCentroDeResultadoRegistroModelo.Inativar;
  Self.ModalResult := mrOk;
end;

function TCentroDeResultadoRegistroView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FCentroDeResultadoRegistroModelo :=
    (Modelo as TCentroDeResultadoRegistroModelo);
  Result := Self;
end;

function TCentroDeResultadoRegistroView.Preparar: ITela;
begin
  Result := Self.BindControls;
end;

procedure TCentroDeResultadoRegistroView.btnGravarClick(Sender: TObject);
begin
  if Self.FCentroDeResultadoRegistroModelo.EhValido then
  begin
    Self.FCentroDeResultadoRegistroModelo.Salvar;
    Self.ModalResult := mrOk;
  end
  else
    TMessages.MensagemErro('Erro ao incluir centro de resultado!');
end;

end.
