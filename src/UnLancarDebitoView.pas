unit UnLancarDebitoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, DB, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvExStdCtrls, JvEdit, JvValidateEdit,
  { Fluente }
  Util, UnComandaModelo, SearchUtil, Pagamentos, UnTeclado;

type
  TLancarDebitoView = class(TForm)
    Label1: TLabel;
    EdtValor: TJvValidateEdit;
    btnOk: TPanel;
    Label2: TLabel;
    edtCartaoDebito: TEdit;
    pnlCartaoDebitoPesquisa: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure EdtValorEnter(Sender: TObject);
    procedure EdtValorExit(Sender: TObject);
  private
    FModelo: IPagamentoCartaoDeDebito;
    FCartaoDebitoPesquisa: TPesquisa;
    FTeclado: TTeclado;
  public
    function Modelo(const Modelo: IPagamentoCartaoDeDebito): TLancarDebitoView;
    function Descarregar: TLancarDebitoView;
    function Preparar: TLancarDebitoView;
    procedure ProcessarSelecaoCartaoDebito(Sender: TObject);
  end;

var
  LancarDebitoView: TLancarDebitoView;

implementation

{$R *.dfm}

procedure TLancarDebitoView.btnOkClick(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FCartaoDebitoPesquisa.Modelo.DataSet;
  Self.FModelo.RegistrarPagamentoCartaoDeDebito(
    TMap.Create
      .Gravar('valor', Self.EdtValor.AsCurrency)
      .Gravar('cart_oid', _dataSet.FieldByName('cart_oid').AsString)
      .Gravar('cart_cod', _dataSet.FieldByName('cart_cod').AsString)
  );
  Self.ModalResult := mrOk;
end;

function TLancarDebitoView.Modelo(
  const Modelo: IPagamentoCartaoDeDebito): TLancarDebitoView;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TLancarDebitoView.Descarregar: TLancarDebitoView;
begin
  Self.FCartaoDebitoPesquisa.Descarregar;
  FreeAndNil(Self.FCartaoDebitoPesquisa);
  Result := Self;
end;

procedure TLancarDebitoView.EdtValorEnter(Sender: TObject);
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

procedure TLancarDebitoView.EdtValorExit(Sender: TObject);
begin
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

function TLancarDebitoView.Preparar: TLancarDebitoView;
begin
  Self.EdtValor.Value := Self.FModelo.Parametros.Ler('total').ComoDecimal;
  Self.FCartaoDebitoPesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.EdtCartaoDebito)
    .PainelDePesquisa(Self.pnlCartaoDebitoPesquisa)
    .Modelo('CartaoDebitoModeloPesquisa')
    .AcaoAposSelecao(Self.ProcessarSelecaoCartaoDebito)
    .Construir;
  Result := Self;
end;

procedure TLancarDebitoView.ProcessarSelecaoCartaoDebito(Sender: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.EdtCartaoDebito.OnChange;
  Self.EdtCartaoDebito.OnChange := nil;
  _dataSet := Self.FCartaoDebitoPesquisa.Modelo.DataSet;
  Self.EdtCartaoDebito.Text := _dataSet.FieldByName('cart_cod').AsString;
  Self.EdtCartaoDebito.OnChange := _event;
end;



end.
