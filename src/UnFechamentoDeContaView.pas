unit UnFechamentoDeContaView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, db, Grids,
  DBGrids,
  { Fluente }
  Util, DataUtil, UnModelo, UnFechamentoDeContaModelo, 
  SearchUtil, Componentes, UnAplicacao, JvExStdCtrls, JvEdit, JvValidateEdit;

type
  OperacaoDeFechamentoDeConta = (opfdcImprimir, opfdcLancarCartaoDeDebito,
    opfdcLancarCartaoDeCredito, opfdcLancarDinheiro, opfdcExibirPagamentos,
    opfdcFecharConta, opfdcExibirDetalhesComanda, opfdcCarregarConta);

  TFechamentoDeContaView = class(TForm, ITela)
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
    Label2: TLabel;
    btnDecAcrescimo: TButton;
    txtAcrescimo: TJvValidateEdit;
    btnIncAcrescimo: TButton;
    procedure btnLancarDebitoClick(Sender: TObject);
    procedure btnLancarCreditoClick(Sender: TObject);
    procedure btnLancarDinheiroClick(Sender: TObject);
    procedure btnVisualizarPagamentosClick(Sender: TObject);
    procedure btnFecharContaClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure gContaDblClick(Sender: TObject);
    procedure btnIncAcrescimoClick(Sender: TObject);
    procedure btnDecAcrescimoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFocusControl: TWinControl;
    FControlador: IResposta;
    FFechamentoContaModelo: TFechamentoDeContaModelo;
    FPesquisaCliente: TPesquisa;
    procedure ProcessarSelecaoDeCliente(Pesquisa: TObject);
    procedure AtualizarTela;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function ExibirTela: Integer;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
  published
    procedure AtualizarSumario(Sender: TObject);
  end;

var
  FechamentoDeContaView: TFechamentoDeContaView;

implementation

{$R *.dfm}

{ TFechamentoDeContaView }

function TFechamentoDeContaView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FFechamentoContaModelo := nil;
  Self.FPesquisaCliente.Descarregar;
  Self.FPesquisaCliente.Free;
  Self.FPesquisaCliente := nil;
  Result := Self;
end;

function TFechamentoDeContaView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FFechamentoContaModelo := (Modelo as TFechamentoDeContaModelo);
  Result := Self;
end;

function TFechamentoDeContaView.Preparar: ITela;
begin
  Self.gConta.DataSource := Self.FFechamentoContaModelo.DataSource;
  Self.FPesquisaCliente := TConstrutorDePesquisas
    .Formulario(Self)
    .ControleDeEdicao(Self.EdtCliente)
    .PainelDePesquisa(Self.pnlClientePesquisa)
    .Modelo('ClientePesquisaModelo')
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
  Self.FFechamentoContaModelo.CarregarPor(Criterio.campo('c.cl_oid').igual(_dataSet.FieldByName('cl_oid').AsString).Obter);
  Self.AtualizarTela;
end;

procedure TFechamentoDeContaView.btnLancarDebitoClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(AtualizarSumario)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcLancarCartaoDeDebito))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TFechamentoDeContaView.AtualizarSumario(Sender: TObject);
var
  _dataSet: TDataSet;
  _totalEmAberto, _pagamentos, _acrescimo, _saldo: Real;
begin
  _totalEmAberto := 0 ;
  _pagamentos := 0;
  _acrescimo := 0;

  _dataSet := Self.FFechamentoContaModelo.DataSet;

  if _dataSet.FieldByName('SALDO_TOTAL').AsString <> '' then
    _totalEmAberto := StrToFloat(_dataSet.FieldByName('SALDO_TOTAL').AsString);

  _dataSet := Self.FFechamentoContaModelo.DataSet('mcx');
  if _dataSet.FieldByName('TOTAL').AsString <> '' then
    _pagamentos := StrToFloat(_dataSet.FieldByName('TOTAL').AsString);

  _saldo := _totalEmAberto;

  if (_saldo > 0) and (Self.txtAcrescimo.Value > 0) then
    _acrescimo := _saldo * Self.txtAcrescimo.Value / 100;

  _saldo := _totalEmAberto + _acrescimo - _pagamentos;

  Self.lblTotalEmAberto.Caption := FormatFloat('0.00', _totalEmAberto);
  Self.lblPagamentos.Caption := FormatFloat('0.00', _pagamentos);
  Self.lblSaldo.Caption := FormatFloat('0.00', _saldo);
end;


procedure TFechamentoDeContaView.AtualizarTela;
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FFechamentoContaModelo.DataSet;
  if _dataSet.FieldByName('SALDO_TOTAL').AsString <> '' then
    Self.lblTotalEmAberto.Caption := FormatFloat('0.00', StrToFloat(_dataSet.FieldByName('SALDO_TOTAL').AsString))
  else
    Self.lblTotalEmAberto.Caption := '0,00';
  Self.AtualizarSumario(nil);
end;
procedure TFechamentoDeContaView.btnLancarCreditoClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(AtualizarSumario)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcLancarCartaoDeCredito))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TFechamentoDeContaView.btnLancarDinheiroClick(Sender: TObject);
var
  _chamada: TChamada;
  _valor: Real;
begin
  _valor := StrToFloat(Self.lblSaldo.Caption);
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(AtualizarSumario)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcLancarDinheiro))
      .Gravar('valor', _valor)
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TFechamentoDeContaView.btnVisualizarPagamentosClick(
  Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Chamador(Self)
    .AposChamar(AtualizarSumario)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcExibirPagamentos))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TFechamentoDeContaView.btnDecAcrescimoClick(Sender: TObject);
var
  _valor: Integer;
begin
  _valor := StrToInt(Self.txtAcrescimo.Text);
  if _valor > 0 then
  begin
    Self.txtAcrescimo.Text := IntToStr(_valor-1);
    Self.AtualizarSumario(nil);
  end;
end;

procedure TFechamentoDeContaView.btnFecharContaClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcFecharConta))
    );
  Self.FControlador.Responder(_chamada);
  Self.ModalResult := mrOk;
end;

procedure TFechamentoDeContaView.btnOkClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

function TFechamentoDeContaView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TFechamentoDeContaView.ExibirTela: Integer;
var
  _event: TNotifyEvent;
begin
  if Self.FFechamentoContaModelo.DataSet.RecordCount > 0  then
  begin
    _event := Self.EdtCliente.OnChange;
    Self.EdtCliente.OnChange := nil;
    Self.EdtCliente.Text := Self.FFechamentoContaModelo.DataSet.FieldByName('cl_cod').AsString;
    Self.EdtCliente.OnChange := _event;
    Self.AtualizarTela;
    Self.FFocusControl := Self.gConta;
  end;
  Result := Self.ShowModal;
end;

procedure TFechamentoDeContaView.FormShow(Sender: TObject);
begin
  if Self.FFocusControl <> nil then
    Self.FFocusControl.SetFocus;
end;

procedure TFechamentoDeContaView.gContaDblClick(Sender: TObject);
begin
  {}
end;

procedure TFechamentoDeContaView.btnImprimirClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  _chamada := TChamada.Create
    .Parametros(TMap.Create
      .Gravar('acao', Ord(opfdcImprimir))
    );
  Self.FControlador.Responder(_chamada);
end;

procedure TFechamentoDeContaView.btnIncAcrescimoClick(Sender: TObject);
begin
  Self.txtAcrescimo.Text := IntToStr(StrToInt(Self.txtAcrescimo.Text) + 1);
  Self.AtualizarSumario(nil);
end;

end.
