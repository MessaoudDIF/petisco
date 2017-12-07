unit UnFechamentoContaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, db, Grids,
  DBGrids,
  { Fluente }
  DataUtil, UNModelo, UnFechamentoDeContaModelo, UnFechamentoContaController,
  SearchUtil;

type
  TFechamentoDeContaView = class(TForm)
    pnlComandos: TJvPanel;
    btnOk: TPanel;
    btnImprimir: TPanel;
    btnLancarDebito: TPanel;
    btnLancarCredito: TPanel;
    btnLancarDinheiro: TPanel;
    btnVisualizarPagamentos: TPanel;
    btnFecharConta: TPanel;
    pnlDetalheView: TPanel;
    DetalheView: TMemo;
    pnlDesktop: TPanel;
    pnlCliente: TPanel;
    lblCliente: TLabel;
    EdtCliente: TEdit;
    EdtOid: TEdit;
    EdtCod: TEdit;
    pnlTitulo: TPanel;
    lblIdComanda: TLabel;
    pnlSumario: TPanel;
    Panel6: TPanel;
    lblTotalEmAberto: TLabel;
    Panel7: TPanel;
    lblSaldo: TLabel;
    Panel3: TPanel;
    lblPagamentos: TLabel;
    pnlClientePesquisa: TPanel;
    gConta: TDBGrid;
    procedure btnLancarDebitoClick(Sender: TObject);
    procedure btnLancarCreditoClick(Sender: TObject);
    procedure btnLancarDinheiroClick(Sender: TObject);
    procedure btnVisualizarPagamentosClick(Sender: TObject);
    procedure btnFecharContaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FFechamentoContaController: TFechamentoContaController;
    FFechamentoContaModelo: TFechamentoDeContaModelo;
    FPesquisaCliente: TPesquisa;
  public
    function Descarregar: TFechamentoDeContaView;
    function Modelo(
      const FechamentoDeContaModelo: TModelo): TFechamentoDeContaView;
    function Preparar: TFechamentoDeContaView;
    procedure ProcessarSelecaoDeCliente(Pesquisa: TObject);
    procedure AtualizarSumario(Sender: TObject);
  end;

var
  FechamentoDeContaView: TFechamentoDeContaView;

implementation

{$R *.dfm}

{ TFechamentoDeContaView }

function TFechamentoDeContaView.Descarregar: TFechamentoDeContaView;
begin
  Result := Self;
end;

function TFechamentoDeContaView.Modelo(
  const FechamentoDeContaModelo: TModelo): TFechamentoDeContaView;
begin
  Self.FFechamentoContaModelo :=
    (FechamentoDeContaModelo as TFechamentoDeContaModelo);
  Result := Self;
end;

function TFechamentoDeContaView.Preparar: TFechamentoDeContaView;
begin
  Self.FFechamentoContaController := TFechamentoContaController.Create
    .Modelo(Self.FFechamentoContaModelo)
    .Preparar;
  Self.gConta.DataSource := Self.FFechamentoContaModelo.DataSource;
  Self.FPesquisaCliente := TConstrutorDePesquisas
    .CampoDeEdicao(Self.EdtCliente)
    .PainelDePesquisa(Self.pnlClientePesquisa)
    .Modelo('ClienteModeloPesquisa')
    .AcaoAposSelecao(Self.ProcessarSelecaoDeCliente)
    .Construir;
  Result := Self;
end;

procedure TFechamentoDeContaView.ProcessarSelecaoDeCliente(
  Pesquisa: TObject);
var
  _event: TNotifyEvent;
  _dataSet: TDataSet;
begin
  _event := Self.EdtCliente.OnChange;
  Self.EdtCliente.OnChange := nil;
  _dataSet := (Pesquisa as TPesquisa).Modelo.DataSet;
  Self.EdtCliente.Text := _dataSet.FieldByName('cl_cod').AsString;
  Self.EdtCliente.OnChange := _event;
  Self.FFechamentoContaModelo.CarregarPor(
    Criterio.campo('c.cl_oid').igual(_dataSet.FieldByName('cl_oid').AsString).obter);
  _dataSet := Self.FFechamentoContaModelo.DataSet;
  if _dataSet.FieldByName('SALDO_TOTAL').AsString <> '' then
    Self.lblTotalEmAberto.Caption :=
      FormatFloat('0.00', StrToFloat(_dataSet.FieldByName('SALDO_TOTAL').AsString))
  else
    Self.lblTotalEmAberto.Caption := '0,00';
end;

procedure TFechamentoDeContaView.btnLancarDebitoClick(Sender: TObject);
begin
  Self.FFechamentoContaController.LancarDebito(Self, Self.AtualizarSumario);
end;

procedure TFechamentoDeContaView.AtualizarSumario(Sender: TObject);
var
  _dataSet: TDataSet;
  _totalEmAberto, _pagamentos, _saldo: Real;
begin
  _dataSet := Self.FFechamentoContaModelo.DataSet;
  if _dataSet.FieldByName('SALDO_TOTAL').AsString = '' then
    _totalEmAberto :=  0
  else
    _totalEmAberto := StrToFloat(_dataSet.FieldByName('SALDO_TOTAL').AsString);
  _dataSet := Self.FFechamentoContaModelo.DataSet('mcx');
  if _dataSet.FieldByName('TOTAL').AsString = '' then
    _pagamentos := 0
  else
    _pagamentos := StrToFloat(_dataSet.FieldByName('TOTAL').AsString);
  _saldo := _totalEmAberto - _pagamentos;
  Self.lblTotalEmAberto.Caption := FormatFloat('0.00', _totalEmAberto);
  Self.lblPagamentos.Caption := FormatFloat('0.00', _pagamentos);
  Self.lblSaldo.Caption := FormatFloat('0.00', _saldo);
end;

procedure TFechamentoDeContaView.btnLancarCreditoClick(Sender: TObject);
begin
  Self.FFechamentoContaController.LancarCredito(Self, Self.AtualizarSumario);
end;

procedure TFechamentoDeContaView.btnLancarDinheiroClick(Sender: TObject);
begin
  Self.FFechamentoContaController.LancarDinheiro(Self, Self.AtualizarSumario);
end;

procedure TFechamentoDeContaView.btnVisualizarPagamentosClick(
  Sender: TObject);
begin
  Self.FFechamentoContaController.ExibirPagamentos(Self);
end;

procedure TFechamentoDeContaView.btnFecharContaClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TFechamentoDeContaView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

end.
