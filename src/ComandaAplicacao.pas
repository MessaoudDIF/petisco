unit ComandaAplicacao;

interface

uses
  StdCtrls, ExtCtrls, Classes, DBClient, Controls, SysUtils, DB,
  { Fluente }
  Util, UnComandaModelo, SearchUtil, UnAplicacao, Pagamentos,
  UnAbrirComandaView, UnComandaView, UnDividirView, UnLancarCreditoView,
  UnLancarDebitoView, UnLancarDinheiroView, UnPagamentosView, UnComandaPrint;

type
  { Operações de Comanda }
  OperacoesDeComanda = (ocmdAbrirComanda, ocmdCarregarComanda, ocmdFecharConta);

  TComandaAplicacao = class(TAplicacao, IResposta)
  private
    FComandaModelo: TComandaModelo;
    FConfiguracaoAplicacao: TConfiguracaoAplicacao;
    FDivisao: string;
    FOnChangeModel: TNotifyEvent;
  protected
    procedure AlterarCliente;
    procedure Dividir;
    procedure ExibirComanda;
    procedure ExibirPagamentos;
    function FecharConta: Boolean;
    procedure Imprimir(const Observacoes: string = '');
    procedure LancarDinheiro;
    procedure LancarCredito;
    procedure LancarDebito;
  public
    function AtivarAplicacao: TAplicacao; override;
    procedure Responder(const Chamada: TChamada);
    function Descarregar: TAplicacao; override;
    function Preparar(const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao; override;
  published
    property Divisao: string read FDivisao write FDivisao;
    property OnChangeModel: TNotifyEvent read FOnChangeModel write FOnChangeModel;
  end;

  function RetornarOperacaoDeComanda(
    const OperacaoDeComanda: Integer): OperacoesDeComanda;

implementation

{ TComandaController }

procedure TComandaAplicacao.Dividir;
var
  _dividirView: TDividirView;
begin
  if Self.FComandaModelo.DataSet.FieldByName('coma_saldo').AsFloat > 0 then
  begin
    _dividirView := TDividirView.Create(nil)
      .Modelo(Self.FComandaModelo)
      .Preparar;
    try
      _dividirView.ShowModal;
    finally
      _dividirView.Descarregar;
      FreeAndNil(_dividirView);
    end;
  end
  else
    TMessages.MensagemErro('Não há saldo para dividir!');
end;

procedure TComandaAplicacao.LancarDinheiro;
var
  _lancarDinheiroView: ITela;
begin
  Self.FComandaModelo.Parametros.Gravar('total',
    Self.FComandaModelo.DataSet.FieldByName('COMA_SALDO').AsFloat);
  _lancarDinheiroView := TLancarDinheiroView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    _lancarDinheiroView.ExibirTela;
  finally
    _lancarDinheiroView.Descarregar;
  end;
end;

procedure TComandaAplicacao.LancarCredito;
var
  _lancarCreditoView: TLancarCreditoView;
begin
  Self.FComandaModelo.Parametros.Gravar('total',
    Self.FComandaModelo.DataSet.FieldByName('COMA_SALDO').AsFloat);
  _lancarCreditoView := TLancarCreditoView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    _lancarCreditoView.ShowModal;
  finally
    _lancarCreditoView.Descarregar;
    FreeAndNil(_lancarCreditoView);
  end;
end;

procedure TComandaAplicacao.LancarDebito;
var
  _lancarDebito: TLancarDebitoView;
begin
  Self.FComandaModelo.Parametros.Gravar('total',
    Self.FComandaModelo.DataSet.FieldByName('COMA_SALDO').AsFloat);
  _lancarDebito := TLancarDebitoView.Create(nil)
    .Modelo(Self.FComandaModelo)
    .Preparar;
  try
    _lancarDebito.ShowModal;
  finally
    _lancarDebito.Descarregar;
    FreeAndNil(_lancarDebito);
  end;
end;

procedure TComandaAplicacao.ExibirPagamentos;
var
  _dataSet: TDataSet;
  _pagamentos: ITela;
  _valorTotal: Real;
begin
  _dataSet := Self.FComandaModelo.DataSet('comap');
  if _dataSet.FieldByName('VALOR_TOTAL').AsString <> '' then
  begin
    _valorTotal := StrToFloat(_dataSet.FieldByName('VALOR_TOTAL').AsString);
    Self.FComandaModelo.Parametros
      .Gravar('total', _valorTotal)
      .Gravar('datasource', 'mcx');
    _pagamentos := TPagamentosView.Create(nil)
      .Modelo(Self.FComandaModelo)
      .Preparar;
    try
      _pagamentos.ExibirTela
    finally
      _pagamentos.Descarregar;
    end;
  end
  else
    TMessages.Mensagem('Nenhum pagamento efetuado!');
end;

function TComandaAplicacao.FecharConta: Boolean;
var
  _valorTotal, _saldo: Real;
  _dataSet: TDataSet;
begin
  Result := False;
  _dataSet := Self.FComandaModelo.DataSet;
  if _dataSet.FieldByName('coma_total').AsString = '' then
    _valorTotal := 0
  else
    _valorTotal := _dataSet.FieldByName('coma_total').AsCurrency;
  _saldo := _dataSet.FieldByName('coma_saldo').AsFloat;
  if _valorTotal > 0 then
  begin
    if (_saldo = 0) or
      TMessages.Confirma('Fechar comanda com SALDO A PAGAR?') then
    begin
        Self.FComandaModelo.FecharComanda;
        Result := True;
    end
    else
      TMessages.MensagemErro('Não foi possível fechar Conta!');
  end
  else
    TMessages.MensagemErro('Não é possível fechar conta sem consumo!');
end;

procedure TComandaAplicacao.AlterarCliente;
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.FComandaModelo.DataSet;
  if not (_dataSet.State in [dsEdit, dsInsert]) then
  begin
    if _dataSet.RecordCount > 0 then
    begin
      _dataSet.Edit;
    end
    else
    begin
      _dataSet.Append;
    end;
  end;
  _dataSet.FieldByName('cl_oid').AsString := Self.FComandaModelo.Parametros.Ler('cl_oid').ComoTexto;
  _dataSet.FieldByName('cl_cod').AsString := Self.FComandaModelo.Parametros.Ler('cl_cod').ComoTexto;
  _dataSet.FieldByName('coma_cliente').AsString := _dataSet.FieldByName('cl_cod').AsString;
  _dataSet.Post;
  Self.FComandaModelo.SalvarComanda;
end;

function TComandaAplicacao.AtivarAplicacao: TAplicacao;
var
  _eventoAntesDeAtivar, _eventoAposDesativar: TNotifyEvent;
  _operacao: OperacoesDeComanda;
  _abrirComandaView: TAbrirComandaView;
  _chaveComanda: string;
begin
  _operacao := RetornarOperacaoDeComanda(Self.FConfiguracaoAplicacao.ObterParametros.Ler('operacao').ComoInteiro);
  _eventoAntesDeAtivar := Self.FConfiguracaoAplicacao.EventoParaExecutarAntesDeAtivar;
  _eventoAposDesativar := Self.FConfiguracaoAplicacao.EventoParaExecutarAposDesativar;
  if _operacao = ocmdAbrirComanda then
  begin
    _abrirComandaView := TAbrirComandaView
      .Create(Self.FComandaModelo)
      .Preparar;
    try
      if _abrirComandaView.ShowModal() = mrOk then
      begin
        _chaveComanda := Self.FComandaModelo.Parametros.Ler('mesa').ComoTexto;
        if _chaveComanda <> '' then
          Self.FComandaModelo
            .LimparComanda
            .AbrirComandaParaMesa(_chaveComanda)
        else
        begin
          _chaveComanda := Self.FComandaModelo.Parametros.Ler('cl_cod').ComoTexto;
          Self.FComandaModelo
            .LimparComanda
            .AbrirComandaParaCliente(_chaveComanda);
        end;
        if Assigned(_eventoAntesDeAtivar) then
          _eventoAntesDeAtivar(Self.FComandaModelo);
        Self.ExibirComanda();
        if Assigned(_eventoAposDesativar) then
          _eventoAposDesativar(Self.FComandaModelo);
      end;
    finally
      FreeAndNil(_abrirComandaView);
    end;
  end
  else
  begin
    Self.FComandaModelo.CarregarComanda(Self.FConfiguracaoAplicacao.ObterParametros.Ler('oid').ComoTexto);
    if Assigned(_eventoAntesDeAtivar) then
      _eventoAntesDeAtivar(Self.FComandaModelo);
    if _operacao = ocmdCarregarComanda then
      Self.ExibirComanda
    else
      Self.FecharConta;
    if Assigned(_eventoAposDesativar) then
      _eventoAposDesativar(Self.FComandaModelo);
  end;
  Result := Self;
end;

function TComandaAplicacao.Descarregar: TAplicacao;
begin
  Result := Self;
end;

function TComandaAplicacao.Preparar(
  const ConfiguracaoAplicacao: TConfiguracaoAplicacao = nil): TAplicacao;
begin
  Self.FComandaModelo :=
    (Self.FFabricaDeModelos.ObterModelo('ComandaModelo') as TComandaModelo);
  Self.FConfiguracaoAplicacao := ConfiguracaoAplicacao;
  Result := Self;
end;

procedure TComandaAplicacao.Responder(const Chamada: TChamada);
var
  _eventoAntesDaChamada, _eventoAposChamar: TNotifyEvent;
  _acao: AcoesDeComanda;
begin
  _acao := RetornarAcaoDeComanda(Chamada.ObterParametros.Ler('acao').ComoInteiro);
  _eventoAntesDaChamada := Chamada.EventoParaExecutarAntesDeChamar;
  _eventoAposChamar := Chamada.EventoParaExecutarAposChamar;
  if Assigned(_eventoAntesDaChamada) then
    _eventoAntesDaChamada(Self);
  case _acao of
    acmdImprimir: Self.Imprimir(Chamada.ObterParametros.Ler('obs').ComoTexto);
    acmdDividir: Self.Dividir;
    acmdLancarPagamentoCartaoDeDebito: Self.LancarDebito;
    acmdLancarPagamentoCartaoDeCredito: Self.LancarCredito;
    acmdLancarPagamentoDinheiro: Self.LancarDinheiro;
    acmdExibirPagamentos: Self.ExibirPagamentos;
    acmdFecharConta: Self.FecharConta;
    acmdAlterarCliente: Self.AlterarCliente;
  end;
  if Assigned(_eventoAposChamar) then
    _eventoAposChamar(Self);
end;

procedure TComandaAplicacao.ExibirComanda;
var
  _comandaView: ITela;
begin
  try
    _comandaView := TComandaView.Create(nil)
      .Controlador(Self)
      .Modelo(Self.FComandaModelo)
      .Preparar;
    _comandaView.ExibirTela;
  finally
    _comandaView.Descarregar;
  end;
end;

function RetornarOperacaoDeComanda(const OperacaoDeComanda: Integer): OperacoesDeComanda;
begin
  if OperacaoDeComanda = 0 then
    Result := ocmdAbrirComanda
  else
    if OperacaoDeComanda = 1 then
      Result := ocmdCarregarComanda
    else
      Result := ocmdFecharConta;
end;

procedure TComandaAplicacao.Imprimir(const Observacoes: string = '');
var
  _colunas: Integer;
  _impressora: TComandaPrint;
  _linhaSimples, _linhaDupla: string;
  _dataSet, _dsIngredientes: TClientDataSet;
begin
  _dataSet := Self.FComandaModelo.DataSet;
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
    .ImprimirLinha('BAR MERCEARIA E LANCH PIRATEI LTDA ME')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('AV.JOSE MARIA M OLIVEIRA, 583')
    .ImprimirLinha('CNPJ: 52.274.420/0001-60')
    .ImprimirLinha('Vila Norma - Salto - SP - CEP 13327-300')
    .ImprimirLinha(_linhaDupla)
    .ImprimirLinha('Fone: 4028-1010')
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha(FormatDateTime('dd/mm/yy hh:nn', NOW) + '            DOC: ' +
      _dataSet.FieldByName('coma_comanda').AsString)
    .ImprimirLinha(_linhaSimples)
    .ImprimirLinha('')
    .ImprimirLinha('Qtde. Descrição             Unit. Vl.Tot')
    .ImprimirLinha(_linhaSimples);
  // Imprime itens
  _dataSet := Self.FComandaModelo.DataSet('comai');
  _dataSet.First;
  while not _dataSet.Eof do
  begin
    _impressora
      .ImprimirLinha(
        Format('%4.0f', [_dataSet.FieldByName('comai_qtde').AsFloat]) + '  ' +
        Copy(_dataSet.FieldByName('pro_des').AsString, 1, 25) + '  ' +
        Format('%4.2f', [_dataSet.FieldByName('comai_unit').AsFloat]) + ' ' +
        Format('%6.2f', [_dataSet.FieldByName('comai_qtde').AsFloat * _dataSet.FieldByName('comai_unit').AsFloat])
      );
    _dsIngredientes := Self.FComandaModelo.DataSet('comaie');
    if _dsIngredientes.RecordCount > 0 then
    begin
      _dsIngredientes.First;
      while not _dsIngredientes.Eof do
      begin
        _impressora.ImprimirLinha('    * * * SEM ' +
          _dsIngredientes.FieldByName('comaie_des').AsString + ' * * *');
        _dsIngredientes.Next;
      end
    end;
    _dataSet.Next;
  end;
  _impressora.ImprimirLinha(_linhaSimples);
  // Imprime rodape
  _dataSet := Self.FComandaModelo.DataSet;
  _impressora.ImprimirLinha('Total Bruto R$ ' + StringOfChar(' ', 16) +
    Format('%9.2f', [_dataSet.FieldByName('coma_total').AsFloat])
  );
  if Observacoes <> '' then
  begin
    _impressora.ImprimirLinha(_linhaSimples);
    _impressora.ImprimirLinha(Observacoes);
    _impressora.ImprimirLinha(_linhaSimples);
  end;
  _impressora.ImprimirLinha(_linhaSimples);
  _impressora.FinalizarImpressao;
end;

initialization
  RegisterClass(TComandaAplicacao);

end.
