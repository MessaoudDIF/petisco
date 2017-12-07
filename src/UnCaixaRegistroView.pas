unit UnCaixaRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, JvExControls, JvButton, JvTransparentButton,
  StdCtrls, Mask, DBCtrls, JvExMask, JvToolEdit, JvBaseEdits, JvDBControls,
  CheckLst,
  { Fluente }
  DataUtil, UnModelo, Componentes, UnAplicacao, UnCaixaModelo, CaixaAplicacao,
  ConectorDeControles, UnTeclado;

type
  TCaixaRegistroView = class(TForm, ITela)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    lblOperacao: TLabel;
    Label2: TLabel;
    EdtMCX_VALOR: TJvDBCalcEdit;
    Label3: TLabel;
    EdtMCX_HISTORICO: TDBEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure EdtMCX_HISTORICOEnter(Sender: TObject);
    procedure EdtMCX_HISTORICOExit(Sender: TObject);
  private
    FCaixaModelo: TCaixaModelo;
    FControlador: IResposta;
    FOperacaoDeCaixa: OperacoesDeCaixa;
    FTeclado: TTeclado;
  public
    function BindControls: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function ExecutarAcao(const Acao: AcaoDeRegistro;
      const Modelo: TModelo): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TCaixaRegistroView }

function TCaixaRegistroView.BindControls: ITela;
begin
  TConectorDeControles.ConectarControles(Self, Self.FCaixaModelo.DataSource);
  Result := Self;
end;

function TCaixaRegistroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TCaixaRegistroView.Descarregar: ITela;
begin
  Self.FCaixaModelo := nil;
  Self.FControlador := nil;
  Result := Self;
end;

function TCaixaRegistroView.ExecutarAcao(const Acao: AcaoDeRegistro;
  const Modelo: TModelo): ITela;
begin
  Result := Self;
end;

function TCaixaRegistroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TCaixaRegistroView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FCaixaModelo := (Modelo as TCaixaModelo);
  Result := Self;
end;

function TCaixaRegistroView.Preparar: ITela;
begin
  Self.BindControls;
  Self.FOperacaoDeCaixa := RetornarOperacaoDeCaixa(
    Self.FCaixaModelo.Parametros.Ler('operacao').ComoInteiro);
  case Self.FOperacaoDeCaixa of
    odcAbertura: Self.lblOperacao.Caption := 'Abertura de Caixa';
    odcTroco: Self.lblOperacao.Caption := 'Troco';
    odcSaida: Self.lblOperacao.Caption := 'Saída de Caixa';
    odcSuprimento: Self.lblOperacao.Caption := 'Suprimento de Caixa';
    odcSangria: Self.lblOperacao.Caption := 'Sangria';
    odcFechamento: Self.lblOperacao.Caption := 'Fechamento de Caixa';
  end;
  Self.FCaixaModelo.DataSet.Append;
  Result := Self;
end;

procedure TCaixaRegistroView.btnGravarClick(Sender: TObject);
begin
  Self.FCaixaModelo.Parametros
    .Gravar('operacao', Ord(Self.FOperacaoDeCaixa));
  if Self.FCaixaModelo.EhValido then
  begin
    Self.FCaixaModelo.salvar;
    Self.ModalResult := mrOk;
  end
  else
    ShowMessage('Erro ao gravar registro de caixa!');
end;

procedure TCaixaRegistroView.EdtMCX_HISTORICOEnter(Sender: TObject);
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height;
    Self.FTeclado.Parent := Self;
    Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  end;
  Self.FTeclado.Visible := True;
end;

procedure TCaixaRegistroView.EdtMCX_HISTORICOExit(Sender: TObject);
begin
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

end.
