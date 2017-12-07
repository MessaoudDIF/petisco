unit UnLancarDinheiroView;

interface

uses
  SysUtils, Controls, ExtCtrls, StdCtrls, Classes, Forms, JvExStdCtrls, JvEdit,
  JvValidateEdit,
  { Fluente }
  Util, UnModelo, Pagamentos, Componentes, UnAplicacao, UnTeclado;

type
  TLancarDinheiroView = class(TForm, ITela)
    Label1: TLabel;
    EdtValor: TJvValidateEdit;
    btnOk: TPanel;
    Label2: TLabel;
    EdtDinheiro: TJvValidateEdit;
    Label3: TLabel;
    EdtTroco: TJvValidateEdit;
    procedure btnOkClick(Sender: TObject);
    procedure EdtValorEnter(Sender: TObject);
    procedure EdtDinheiroEnter(Sender: TObject);
    procedure EdtValorExit(Sender: TObject);
    procedure EdtDinheiroExit(Sender: TObject);
  private
    FControlador: IResposta;
    FModelo: TModelo;
    FTeclado: TTeclado;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela: Integer;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
  published
    procedure CalcularTroco(Sender: TObject);
  end;

var
  LancarDinheiroView: TLancarDinheiroView;

implementation

{$R *.dfm}

procedure TLancarDinheiroView.btnOkClick(Sender: TObject);
begin
  if Supports(Self.FModelo, IPagamentoDinheiro) then
    (Self.FModelo as IPagamentoDinheiro)
    .RegistrarPagamentoEmDinheiro(
      TMap.Create
        .Gravar('valor', Self.EdtValor.AsFloat)
        .Gravar('dinheiro', Self.EdtDinheiro.Text)
        .Gravar('troco', Self.EdtTroco.Text)
    );
  Self.ModalResult := mrOk;
end;

procedure TLancarDinheiroView.CalcularTroco(Sender: TObject);
begin
  if (Self.EdtValor.Value > 0) and (Self.EdtDinheiro.Value) then
    Self.EdtTroco.Value := Self.EdtDinheiro.Value - Self.EdtValor.Value
  else
    Self.EdtTroco.Value := 0;
end;

function TLancarDinheiroView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TLancarDinheiroView.Descarregar: ITela;
begin
  Self.FModelo := nil;
  Self.FControlador := nil;
  Result := Self;
end;

function TLancarDinheiroView.Preparar: ITela;
begin
  Self.EdtValor.Value := Self.FModelo.Parametros.Ler('total').ComoDecimal;
  Result := Self;
end;

function TLancarDinheiroView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

procedure TLancarDinheiroView.EdtDinheiroEnter(Sender: TObject);
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height;
    Self.FTeclado.Parent := Self;
  end;
  Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  Self.FTeclado.Visible := True;
end;

procedure TLancarDinheiroView.EdtDinheiroExit(Sender: TObject);
begin
  Self.CalcularTroco(Sender);
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

procedure TLancarDinheiroView.EdtValorEnter(Sender: TObject);
begin
  if Self.FTeclado = nil then
  begin
    Self.FTeclado := TTeclado.Create(nil);
    Self.FTeclado.Top := Self.Height - Self.FTeclado.Height;
    Self.FTeclado.Parent := Self;
  end;
  Self.FTeclado.ControleDeEdicao(Sender as TCustomEdit);
  Self.FTeclado.Visible := True;
end;

procedure TLancarDinheiroView.EdtValorExit(Sender: TObject);
begin
  Self.CalcularTroco(Sender);
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

function TLancarDinheiroView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;



end.
