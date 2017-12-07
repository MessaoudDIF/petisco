unit FechamentoDeContaAplicacao;

interface

uses Classes, Controls, DBclient,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao, UnFechamentoDeContaModelo,
  UnFechamentoDeContaView;

type
  TFechamentoDeContaAplicacao = class(TAplicacao, IResposta)
  private
    FFechamentoDeContaView: ITela;
    FFechamentoDeContaModelo: TFechamentoDeContaModelo;
  protected
    procedure ExibirDetalhesComanda;
    procedure ExibirPagamentos;
    procedure FecharConta;
    procedure Imprimir;
    procedure LancarDebito;
    procedure LancarCredito;
    procedure LancarDinheiro(const Valor: Real);
  public
    function AtivarAplicacao: TAplicacao; overload; override;
    function AtivarAplicacao(const Chamada: TChamada): TAplicacao; overload; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(
      const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;override;
  end;

  function RetornarOperacaoDeFechamentoDeConta(
    const CodigoDaOperacaoDeFechamentoDeConta: Integer):
    OperacaoDeFechamentoDeConta;

implementation

uses SysUtils, DB,
  { Fluente }
  UnLancarDinheiroView, UnLancarDebitoView,
  UnLancarCreditoView, UnPagamentosView, UnComandaPrint;

{ TFechamentoDeContaAplicacao }

function TFechamentoDeContaAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FFechamentoDeContaView.ExibirTela;
  Result := Self;
end;

procedure TFechamentoDeContaAplicacao.Responder(const
  Chamada: TChamada);
var
  _eventoAntesDaChamada, _eventoAposChamar: TNotifyEvent;
  _operacao: OperacaoDeFechamentoDeConta;
begin
  _operacao := RetornarOperacaoDeFechamentoDeConta(
    Chamada.ObterParametros.Ler('acao').ComoInteiro);

  _eventoAntesDaChamada := Chamada.EventoParaExecutarAntesDeChamar;
  _eventoAposChamar := Chamada.EventoParaExecutarAposChamar;

  if Assigned(_eventoAntesDaChamada) then
    _eventoAntesDaChamada(Self);

  case _operacao of
    opfdcImprimir: Self.Imprimir;
    opfdcLancarCartaoDeDebito: Self.LancarDebito;
    opfdcLancarCartaoDeCredito: Self.LancarCredito;
    opfdcLancarDinheiro: Self.LancarDinheiro(Chamada.ObterParametros.Ler('valor').ComoDecimal);
    opfdcExibirPagamentos: Self.ExibirPagamentos;
    opfdcFecharConta: Self.FecharConta;
    opfdcExibirDetalhesComanda: Self.ExibirDetalhesComanda;
    //opfdcCarregarConta: Self.:
  end;
  if Assigned(_eventoAposChamar) then
    _eventoAposChamar(Self);
end;

function TFechamentoDeContaAplicacao.AtivarAplicacao(const Chamada: TChamada): TAplicacao;
var
  _oid: string;
begin
  _oid := Chamada.ObterParametros.Ler('oid').ComoTexto;
  Self.FFechamentoDeContaModelo.CarregarPor(Criterio.Campo('c.cl_oid').Igual(_oid).Obter);
  Self.FFechamentoDeContaView.ExibirTela;
  Result := Self;
end;

function TFechamentoDeContaAplicacao.Descarregar: TAplicacao;
begin
  if Self.FFechamentoDeContaView <> nil then
    Self.FFechamentoDeContaView.Descarregar;
  Result := Self;
end;

function TFechamentoDeContaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
begin
  Self.FFechamentoDeContaModelo :=
    (Self.FFabricaDeModelos.ObterModelo('FechamentoDeContaModelo') as TFechamentoDeContaModelo);
  Self.FFechamentoDeContaView := TFechamentoDeContaView.Create(nil)
    .Modelo(Self.FFechamentoDeContaModelo)
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

function RetornarOperacaoDeFechamentoDeConta(
  const CodigoDaOperacaoDeFechamentoDeConta: Integer):
  OperacaoDeFechamentoDeConta;
begin
  case CodigoDaOperacaoDeFechamentoDeConta of
    0: Result := opfdcImprimir;
    1: Result := opfdcLancarCartaoDeDebito;
    2: Result := opfdcLancarCartaoDeCredito;
    3: Result := opfdcLancarDinheiro;
    4: Result := opfdcExibirPagamentos;
    5: Result := opfdcFecharConta;
    6: Result := opfdcExibirDetalhesComanda
    else
      Result := opfdcCarregarConta;
  end;
end;

procedure TFechamentoDeContaAplicacao.ExibirDetalhesComanda;
var
  _view: ITela;
begin
  Self.FFechamentoDeContaModelo.Parametros
    .Gravar('dataset', 'mcx');
  _view := TPagamentosView.Create(nil)
    .Preparar;
  try
    _view.ExibirTela;
  finally
    _view.Descarregar;
  end;
end;

procedure TFechamentoDeContaAplicacao.ExibirPagamentos;
var
  _valor: Real;
  _dataSet: TDataSet;
  _view: ITela;
begin
  _dataSet := Self.FFechamentoDeContaModelo.DataSet('mcx');
  if _dataSet.FieldByName('TOTAL').AsString = '' then
    _valor := 0
  else
    _valor := StrToFloat(_dataSet.FieldByName('TOTAL').AsString);
  Self.FFechamentoDeContaModelo.Parametros
    .Gravar('total', FloatToStr(_valor))
    .Gravar('dataset', 'mcx');
  _view := TPagamentosView.Create(nil)
    .Preparar;
  try
    _view.ExibirTela;
  finally
    _view.Descarregar;
  end;
end;

procedure TFechamentoDeContaAplicacao.Imprimir;
var
  _colunas: Integer;
  _impressora: TComandaPrint;
  _linhaSimples, _linhaDupla: string;
  _dataSet: TClientDataSet;
begin
  _colunas := 40;
  _linhaSimples := StringOfChar('-', _colunas);
  _linhaDupla := StringOfChar('=', _colunas);
  // Imprime cabecalho
  _impressora := TComandaPrint.Create
    .DispositivoParaImpressao(ddiTela)
    .DefinirLarguraDaImpressaoEmCaracteres(_colunas)
    .AlinharAEsquerda
    .Preparar
    .IniciarImpressao
    .ImprimirLinha('Lanchonete XPTO')
    .ImprimirLinha(_linhaDupla)
    .ImprimirLinha('Fone: 4028-1010')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha(FormatDateTime('dd/mm/yy hh:nn', NOW))
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('   * * * FECHAMENTO DE CONTA * * *')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('Data     Doc.     Vl.Tot')
    .ImprimirLinha(_linhaSimples);
  // Imprime Contas
  _dataSet := Self.FFechamentoDeContaModelo.DataSet;
  _dataSet.First;
  while not _dataSet.Eof do
  begin
    _impressora
      .ImprimirLinha(
        FormatDateTime('dd/mm/yyyy', _dataSet.FieldByName('coma_data').AsDateTime) + '  ' +
        _dataSet.FieldByName('coma_comanda').AsString + '  ' +
        FormatFloat('#,###,##0.00', _dataSet.FieldByName('coma_saldo').AsFloat)
      );
    _dataSet.Next;
  end;
  _impressora.ImprimirLinha(_linhaSimples);
  // Imprime rodape
  _impressora.ImprimirLinha('Total Bruto R$ ' + StringOfChar(' ', 16) +
    FormatFloat('#,###,##0.00', StrToFloat(_dataSet.FieldByName('saldo_total').AsString))
  );
  _impressora.ImprimirLinha(_linhaSimples);
  _impressora.FinalizarImpressao;
end;

procedure TFechamentoDeContaAplicacao.LancarCredito;
var
  _lancarCreditoView: TLancarCreditoView;
begin
  _lancarCreditoView := TLancarCreditoView.Create(nil)
    .Modelo(Self.FFechamentoDeContaModelo)
    .Preparar;
  try
    _lancarCreditoView.ShowModal;
  finally
    _lancarCreditoView.Descarregar;
    FreeAndNil(_lancarCreditoView);
  end;
end;

procedure TFechamentoDeContaAplicacao.LancarDebito;
var
  _lancarDebito: TLancarDebitoView;
begin
  _lancarDebito := TLancarDebitoView.Create(nil)
    .Modelo(Self.FFechamentoDeContaModelo)
    .Preparar;
  try
    _lancarDebito.ShowModal;
  finally
    _lancarDebito.Descarregar;
    FreeAndNil(_lancarDebito);
  end;
end;

procedure TFechamentoDeContaAplicacao.LancarDinheiro(const Valor: Real);
var
  _view: ITela;
begin
  Self.FFechamentoDeContaModelo.Parametros
    .Gravar('total', Valor);
  _view := TLancarDinheiroView.Create(nil)
    .Modelo(Self.FFechamentoDeContaModelo)
    .Preparar;
  try
    _view.ExibirTela
  finally
    _view.Descarregar;
  end;
end;

procedure TFechamentoDeContaAplicacao.FecharConta;
begin
  Self.FFechamentoDeContaModelo.FecharConta;
end;

initialization
  RegisterClass(TFechamentoDeContaAplicacao);

end.
