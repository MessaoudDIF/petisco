unit UnLancarCreditoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, JvExStdCtrls, JvEdit, JvValidateEdit,
  { Fluente }
  Util, SearchUtil, UnComandaModelo, Pagamentos, UnTeclado;

type
  TLancarCreditoView = class(TForm)
    Label1: TLabel;
    EdtValor: TJvValidateEdit;
    btnOk: TPanel;
    Label2: TLabel;
    EdtCartaoCredito: TEdit;
    pnlCartaoCreditoPesquisa: TPanel;
    procedure btnOkClick(Sender: TObject);
    procedure EdtValorEnter(Sender: TObject);
    procedure EdtValorExit(Sender: TObject);
  private
    FCartaoCreditoPesquisa: TPesquisa;
    FModelo: IPagamentoCartaoDeCredito;
    FTeclado: TTeclado;
  public
    function Modelo(
      const Modelo: IPagamentoCartaoDeCredito): TLancarCreditoView;
    function Descarregar: TLancarCreditoView;
    function Preparar: TLancarCreditoView;
    procedure ProcessarSelecaoCartaoCredito(Sender: TObject);
  end;

var
  LancarCreditoView: TLancarCreditoView;

implementation

{$R *.dfm}

procedure TLancarCreditoView.btnOkClick(Sender: TObject);
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FCartaoCreditoPesquisa.Modelo.DataSet;
  Self.FModelo.RegistrarPagamentoCartaoDeCredito(
    TMap.Create
      .Gravar('cart_oid', _dataSet.FieldByName('cart_oid').AsString)
      .Gravar('cart_cod', _dataSet.FieldByName('cart_cod').AsString)
      .Gravar('valor', Self.EdtValor.AsCurrency)
  );
  Self.ModalResult := mrOk;
end;

function TLancarCreditoView.Modelo(
  const Modelo: IPagamentoCartaoDeCredito): TLancarCreditoView;
begin
  Self.FModelo := Modelo;
  Result := Self;
end;

function TLancarCreditoView.Descarregar: TLancarCreditoView;
begin
  Self.FModelo := nil;
  Result := Self;
end;

procedure TLancarCreditoView.EdtValorEnter(Sender: TObject);
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

procedure TLancarCreditoView.EdtValorExit(Sender: TObject);
begin
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := True;
end;

function TLancarCreditoView.Preparar: TLancarCreditoView;
begin
  Self.EdtValor.Value := Self.FModelo.Parametros.Ler('total').ComoDecimal;
  Self.FCartaoCreditoPesquisa := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.EdtCartaoCredito)
    .PainelDePesquisa(Self.pnlCartaoCreditoPesquisa)
    .Modelo('CartaoCreditoModeloPesquisa')
    .AcaoAposSelecao(Self.ProcessarSelecaoCartaoCredito)
    .Construir;
  Result := Self;
end;

procedure TLancarCreditoView.ProcessarSelecaoCartaoCredito(Sender: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.EdtCartaoCredito.OnChange;
  Self.EdtCartaoCredito.OnChange := nil;
  _dataSet := Self.FCartaoCreditoPesquisa.Modelo.DataSet;
  Self.EdtCartaoCredito.Text := _dataSet.FieldByName('cart_cod').AsString;
  Self.EdtCartaoCredito.OnChange := _event;
end;

end.
