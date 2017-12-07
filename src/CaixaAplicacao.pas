unit CaixaAplicacao;

interface

uses Classes, DB, DBClient,
  { Fluente }
  Util, DataUtil, UnCaixaModelo, Componentes, UnAplicacao;

type
  TCaixaAplicacao = class(TAplicacao, IResposta)
  private
    FCaixaMenuView: ITela;
    FCaixaModelo: TCaixaModelo;
  protected
    procedure ExibirRegistroDeCaixa(const Chamada: TChamada);
    procedure ImprimirExtratoDeCaixa;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(
      const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;override;
  end;

  function RetornarOperacaoDeCaixa(
    const CodigoDaOperacaoDeCaixa: Integer): OperacoesDeCaixa;
    
implementation

uses SysUtils,
  { Fluente }
  UnCaixaMenuView, UnCaixaRegistroView, UnComandaPrint;

function RetornarOperacaoDeCaixa(
  const CodigoDaOperacaoDeCaixa: Integer): OperacoesDeCaixa;
begin
  case CodigoDaOperacaoDeCaixa of
    0: Result := odcAbertura;
    1: Result := odcTroco;
    2: Result := odcSaida;
    3: Result := odcSuprimento;
    4: Result := odcSangria;
    5: Result := odcFechamento;
  else
    Result := odcExtrato;
  end;
end;    

{ TProdutoAplicacao }

function TCaixaAplicacao.AtivarAplicacao: TAplicacao;
begin
  Self.FCaixaMenuView.ExibirTela;
  Result := Self;
end;

procedure TCaixaAplicacao.Responder(const Chamada: TChamada);
var
  _operacao: OperacoesDeCaixa;
begin
  _operacao := RetornarOperacaoDeCaixa(Chamada.ObterParametros
    .Ler('operacao').ComoInteiro);
  if _operacao = odcExtrato then
  begin
    Self.FCaixaModelo.CarregarExtrato(Date, Date);
    Self.ImprimirExtratoDeCaixa;
  end
  else
  begin
    Chamada.ObterParametros.Gravar('operacao', Ord(_operacao));
    Self.ExibirRegistroDeCaixa(Chamada);
  end;
end;

function TCaixaAplicacao.Descarregar: TAplicacao;
begin
  if Self.FCaixaMenuView <> nil then
    Self.FCaixaMenuView.Descarregar;
  Result := Self;
end;

function TCaixaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao): TAplicacao;
begin
  Self.FCaixaModelo := (
    Self.FFabricaDeModelos.ObterModelo('CaixaModelo') as TCaixaModelo);
  Self.FCaixaMenuView := TCaixaMenuView.Create(nil)
    .Modelo(Self.FCaixaModelo)
    .Controlador(Self)
    .Preparar;
  Result := Self;
end;

procedure TCaixaAplicacao.ExibirRegistroDeCaixa(const Chamada: TChamada);
var
  _caixaRegistroView: ITela;
  _eventoAntesDeChamar, _eventoAposChamar: TNotifyEvent;
begin
  _eventoAntesDeChamar := Chamada.EventoParaExecutarAntesDeChamar;
  _eventoAposChamar := Chamada.EventoParaExecutarAposChamar;
  _caixaRegistroView := TCaixaRegistroView.Create(nil)
    .Controlador(Self)
    .Modelo(Self.FCaixaModelo)
    .Preparar;
  try
    if Assigned(_eventoAntesDeChamar) then
      _eventoAntesDeChamar(Chamada.ObterChamador);
    _caixaRegistroView.ExibirTela;
    if Assigned(_eventoAposChamar) then
      _eventoAposChamar(Chamada.ObterChamador);
  finally
    _caixaRegistroView.Descarregar;
  end;
end;

procedure TCaixaAplicacao.ImprimirExtratoDeCaixa;
var
  _colunas: Integer;
  _impressora: TComandaPrint;
  _linhaSimples, _linhaDupla: string;
  _dataSet: TClientDataSet;
  _valor, _saldoFinal: Real;
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
    .ImprimirLinha('Lanchonete')
    .ImprimirLinha(_linhaDupla)
    .ImprimirLinha('Fone: 4028-1010')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha(FormatDateTime('dd/mm/yy hh:nn', NOW))
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('   * * * EXTRATO DE CAIXA * * *')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('Data     Histórico            Valor')
    .ImprimirLinha(_linhaSimples);
  // Imprime Contas
  _dataSet := Self.FCaixaModelo.DataSet('extrato');
  _dataSet.First;
  _saldoFinal := 0;
  while not _dataSet.Eof do
  begin
    _valor := Self.FUtil.iff(_dataSet.FieldByName('mcx_dc').AsInteger = Ord(dcDebito),
      _dataSet.FieldByName('mcx_valor').AsFloat * -1,
      _dataSet.FieldByName('mcx_valor').AsFloat);
    _saldoFinal := _saldoFinal + _valor;
    _impressora
      .ImprimirLinha(
        FormatDateTime('dd/mm/yyyy hh:nn', _dataSet.FieldByName('mcx_data').AsDateTime) + '  ' +
        TText.DSpaces(Copy(_dataSet.FieldByName('mcx_historico').AsString, 1, 19), 19) + '  ' +
        TText.ESpaces(FormatFloat('#,##0.00', _valor), 8)
      );
    _dataSet.Next;
  end;
  _impressora.ImprimirLinha(_linhaSimples);
  // Imprime rodape
  _impressora.ImprimirLinha('Saldo Final R$ ' + StringOfChar(' ', 16) +
    FormatFloat('#,###,##0.00', _saldoFinal)
  );
  _impressora.ImprimirLinha(_linhaSimples);
  _impressora.FinalizarImpressao;
end;

initialization
  RegisterClass(TCaixaAplicacao);

end.
