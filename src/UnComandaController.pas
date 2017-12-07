unit UnComandaController;

interface

uses
  StdCtrls, ExtCtrls, Classes,
  { Fluente }
  Util, UnComandaModelo, SearchUtil, UnAplicacao, Pagamentos;

type
  TComandaController = class(TAplicacao, IResposta)
  private
    FComandaModelo: TComandaModelo;
    FDivisao: string;
    FOnChangeModel: TNotifyEvent;
  protected
  public
    constructor Create(const ComandaModelo: TComandaModelo); reintroduce;
    property Divisao: string read FDivisao write FDivisao;
    property OnChangeModel: TNotifyEvent read FOnChangeModel write FOnChangeModel;
    function Dividir(Sender: TObject; const AfterChange: TNotifyEvent): TComandaController;
    function ExibirPagamentos(Sender: TObject): TComandaController;
    procedure LancarDinheiro(Sender: TObject; const AfterChange: TNotifyEvent);
    procedure LancarCredito(Sender: TObject; const AfterChange: TNotifyEvent);
    procedure LancarDebito(Sender: TObject; const AfterChange: TNotifyEvent);
    function Modelo(const Modelo: TModelo):
  end;

implementation

uses Controls, SysUtils, DB,
  { Fluente }
  UnDividirView, UnLancarCreditoView,
  UnLancarDebitoView, UnLancarDinheiroView, UnPagamentosView;

{ TComandaController }

constructor TComandaController.Create(const ComandaModelo: TComandaModelo);
begin
  Self.FComandaModelo := ComandaModelo;
end;

function TComandaController.Dividir(Sender: TObject;
  const AfterChange: TNotifyEvent): TComandaController;
var
  _dividirView: TDividirView;
begin
  if Self.FComandaModelo.DataSet.FieldByName('coma_saldo').AsFloat > 0 then
  begin
    _dividirView := TDividirView.Create(nil)
      .ComandaModelo(Self.FComandaModelo)
      .Preparar;
    try
      if (_dividirView.ShowModal = mrOk) and Assigned(AfterChange) then
        AfterChange(Self);
    finally
      _dividirView.Descarregar;
      FreeAndNil(_dividirView);
    end;
  end
  else
    TFlMessages.MensagemErro('Não há saldo para dividir!');
  Result := Self;
end;

procedure TComandaController.LancarDinheiro(Sender: TObject; const AfterChange: TNotifyEvent);
var
  _lancarDinheiroView: ITela;
begin
  Self.FComandaModelo.Parametros.GravarParametro('total',
    Self.FComandaModelo.DataSet.FieldByName('COMA_SALDO').AsString);
  _lancarDinheiroView := TLancarDinheiroView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    if (_lancarDinheiroView.ExibirTela = mrOk) and Assigned(AfterChange) then
      AfterChange(Self);
  finally
    _lancarDinheiroView.Descarregar;
    FreeAndNil(_lancarDinheiroView);
  end;
end;

procedure TComandaController.LancarCredito(Sender: TObject; const AfterChange: TNotifyEvent);
var
  _lancarCreditoView: TLancarCreditoView;
begin
  _lancarCreditoView := TLancarCreditoView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    if (_lancarCreditoView.ShowModal = mrOk) and Assigned(AfterChange) then
      AfterChange(Self);
  finally
    _lancarCreditoView.Descarregar;
    FreeAndNil(_lancarCreditoView);
  end;
end;

procedure TComandaController.LancarDebito(Sender: TObject; const AfterChange: TNotifyEvent);
var
  _lancarDebito: TLancarDebitoView;
begin
  _lancarDebito := TLancarDebitoView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    if (_lancarDebito.ShowModal = mrOk) and Assigned(AfterChange) then
      AfterChange(Self);
  finally
    _lancarDebito.Descarregar;
    FreeAndNil(_lancarDebito);
  end;
end;

function TComandaController.ExibirPagamentos(
  Sender: TObject): TComandaController;
var
  _dataSet: TDataSet;
  _pagamentos: ITela;
begin
  _dataSet := Self.FComandaModelo.DataSet('comap');
  Self.FComandaModelo.Parametros
    .GravarParametro('total',
      FloatToStr(_dataSet.FieldByName('VALOR_TOTAL').AsFloat))
    .GravarParametro('datasource', 'mcx');
  _pagamentos := TPagamentosView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    _pagamentos.ExibirTela
  finally
    _pagamentos.Descarregar;
    FreeAndNil(_pagamentos);
  end;
  Result := Self;
end;

end.
