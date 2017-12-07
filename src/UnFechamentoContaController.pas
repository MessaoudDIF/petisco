unit UnFechamentoContaController;

interface

uses Classes,
  { Fluente }
  UnModelo, UnFechamentoDeContaModelo, UnAplicacao;

type
  TFechamentoContaController = class
  private
    FFechamentoContaModelo: TFechamentoDeContaModelo;
  public
    function ExibirPagamentos(Sender: TObject): TFechamentoContaController;
    function Modelo(const Modelo: TModelo): TFechamentoContaController;
    function LancarDinheiro(Sender: TObject;
      const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
    function LancarCredito(Sender: TObject;
      const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
    function  LancarDebito(Sender: TObject;
      const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
    function Preparar: TFechamentoContaController;
  end;

implementation

uses SysUtils, Controls, Dialogs, DB, 
  { Fluente }
  UnLancarDinheiroView, UnLancarDebitoView, UnLancarCreditoView,
  UnPagamentosView;

{ TFechamentoContaController }

function TFechamentoContaController.ExibirPagamentos(
  Sender: TObject): TFechamentoContaController;
var
  _valor: Real;
  _dataSet: TDataSet;
  _pagamentos: TPagamentosView;
begin
  Result := Self;
end;

function TFechamentoContaController.LancarCredito(Sender: TObject;
  const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
var
  _lancarCreditoView: TLancarCreditoView;
begin
  _lancarCreditoView := TLancarCreditoView.Create(nil)
    .Modelo(Self.FFechamentoContaModelo)
    .Preparar;
  try
    if (_lancarCreditoView.ShowModal = mrOk) and
      Assigned(AposRegistrarLancamento) then
    begin
      AposRegistrarLancamento(Self);
    end;
  finally
    _lancarCreditoView.Descarregar;
    FreeAndNil(_lancarCreditoView);
  end;
  Result := Self;
end;

function TFechamentoContaController.LancarDebito(Sender: TObject;
  const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
var
  _lancarDebito: TLancarDebitoView;
begin
  _lancarDebito := TLancarDebitoView.Create(nil)
    .Modelo(Self.FFechamentoContaModelo)
    .Preparar;
  try
    if (_lancarDebito.ShowModal = mrOk) and
      Assigned(AposRegistrarLancamento) then
    begin
      AposRegistrarLancamento(Self);
    end;
  finally
    _lancarDebito.Descarregar;
    FreeAndNil(_lancarDebito);
  end;
  Result := Self;
end;

function TFechamentoContaController.LancarDinheiro(Sender: TObject;
  const AposRegistrarLancamento: TNotifyEvent): TFechamentoContaController;
var
  _valor: Real;
  _dataSet: TDataSet;
  _lancarDinheiroView: ITela;
begin
  _dataSet := Self.FFechamentoContaModelo.DataSet;
  if _dataSet.FieldByName('SALDO_TOTAL').AsString = '' then
    _valor := 0
  else
    _valor := StrToFloat(_dataSet.FieldByName('SALDO_TOTAL').AsString);
  Self.FFechamentoContaModelo.Parametros.GravarParametro('total', FloatToStr(_valor));
  _lancarDinheiroView := TLancarDinheiroView.Create(nil)
    .Modelo(Self.FFechamentoContaModelo)
    .Preparar;
  try
    if (_lancarDinheiroView.ExibirTela = mrOk) and
      Assigned(AposRegistrarLancamento) then
    begin
      AposRegistrarLancamento(Self);
    end;
  finally
    _lancarDinheiroView.Descarregar;
    FreeAndNil(_lancarDinheiroView);
  end;
  Result := Self;
end;

function TFechamentoContaController.Modelo(
  const Modelo: TModelo): TFechamentoContaController;
begin
  Self.FFechamentoContaModelo := (Modelo as TFechamentoDeContaModelo);
  Result := Self;
end;

function TFechamentoContaController.Preparar: TFechamentoContaController;
begin
  Result := Self;
end;

end.
