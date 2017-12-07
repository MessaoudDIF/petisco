unit UnComandaModelo;

interface

uses
  { VCL }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, Data.DBXFirebird,
  { helsonsant }
  Util, DataUtil, UnModelo, Pagamentos;

type
  TComandaModelo = class(TModelo, IPagamentoDinheiro, IPagamentoCartaoDeDebito, IPagamentoCartaoDeCredito)
    ds_comai: TSQLDataSet;
    cds_comai: TClientDataSet;
    dsr_comai: TDataSource;
    dsr_coma_comai: TDataSource;
    ds_comap: TSQLDataSet;
    cds_comap: TClientDataSet;
    dsr_comap: TDataSource;
    dsr_coma_comap: TDataSource;
    dsCOMA_OID: TStringField;
    dsCL_OID: TStringField;
    dsCOMA_COMANDA: TStringField;
    dsCOMA_DATA: TSQLTimeStampField;
    dsCOMA_STT: TIntegerField;
    dsCOMA_MESA: TIntegerField;
    dsCL_COD: TStringField;
    ds_comaiCOMAI_OID: TStringField;
    ds_comaiCOMA_OID: TStringField;
    ds_comaiPRO_OID: TStringField;
    ds_comaiPRO_COD: TStringField;
    ds_comaiPRO_DES: TStringField;
    ds_comapCOMAP_OID: TStringField;
    ds_comapCOMA_OID: TStringField;
    ds_comapCOMAP_DC: TIntegerField;
    ds_comapCOMAP_HIST: TStringField;
    cdsCOMA_OID: TStringField;
    cdsCL_OID: TStringField;
    cdsCOMA_COMANDA: TStringField;
    cdsCOMA_DATA: TSQLTimeStampField;
    cdsCOMA_STT: TIntegerField;
    cdsCOMA_MESA: TIntegerField;
    cdsCL_COD: TStringField;
    cdsds_comai: TDataSetField;
    cdsds_comap: TDataSetField;
    cds_comaiCOMAI_OID: TStringField;
    cds_comaiCOMA_OID: TStringField;
    cds_comaiPRO_OID: TStringField;
    cds_comaiPRO_COD: TStringField;
    cds_comaiPRO_DES: TStringField;
    cds_comapCOMAP_OID: TStringField;
    cds_comapCOMA_OID: TStringField;
    cds_comapCOMAP_DC: TIntegerField;
    cds_comapCOMAP_HIST: TStringField;
    ds_comaiCOMAI_EDT: TIntegerField;
    cds_comaiCOMAI_EDT: TIntegerField;
    cds_mcx: TClientDataSet;
    dsr_mcx: TDataSource;
    dsr_comap_mcx: TDataSource;
    cds_comaiVALOR_TOTAL: TAggregateField;
    cds_comaiQTDE_TOTAL: TAggregateField;
    cds_comapds_mcx: TDataSetField;
    cds_comapVALOR_TOTAL: TAggregateField;
    ds_comapCOMAP_DATA: TSQLTimeStampField;
    cds_comapCOMAP_DATA: TSQLTimeStampField;
    ds_mcx: TSQLDataSet;
    ds_mcxMCX_OID: TStringField;
    ds_mcxMCX_DATA: TSQLTimeStampField;
    ds_mcxMCX_TPORIG: TIntegerField;
    ds_mcxMCX_ORIG: TStringField;
    ds_mcxMCXOP_OID: TStringField;
    ds_mcxMCX_DC: TIntegerField;
    ds_mcxMCX_HISTORICO: TStringField;
    ds_mcxMCX_MPAG: TIntegerField;
    ds_mcxCART_OID: TStringField;
    cds_mcxMCX_OID: TStringField;
    cds_mcxMCX_DATA: TSQLTimeStampField;
    cds_mcxMCX_TPORIG: TIntegerField;
    cds_mcxMCX_ORIG: TStringField;
    cds_mcxMCXOP_OID: TStringField;
    cds_mcxMCX_DC: TIntegerField;
    cds_mcxMCX_HISTORICO: TStringField;
    cds_mcxMCX_MPAG: TIntegerField;
    cds_mcxCART_OID: TStringField;
    cds_comaie: TClientDataSet;
    dsr_comaie: TDataSource;
    dsr_comai_comaie: TDataSource;
    cds_comaids_comaie: TDataSetField;
    cds_comaieTOTAL: TAggregateField;
    ds_ingredientes: TSQLDataSet;
    dsp_ingredientes: TDataSetProvider;
    cds_ingredientes: TClientDataSet;
    dsr_ingredientes: TDataSource;
    ds_ingredientesSITUACAO: TIntegerField;
    ds_ingredientesPROCOM_DES: TStringField;
    cds_ingredientesSITUACAO: TIntegerField;
    cds_ingredientesPROCOM_DES: TStringField;
    ds_ingredientesPROCOM_OID: TStringField;
    cds_ingredientesPROCOM_OID: TStringField;
    ds_comaie: TSQLDataSet;
    ds_comaieCOMAIE_OID: TStringField;
    ds_comaieCOMAI_OID: TStringField;
    ds_comaiePROCOM_OID: TStringField;
    ds_comaieCOMAIE_EXCL_INCL: TIntegerField;
    ds_comaieCOMAIE_DES: TStringField;
    cds_comaieCOMAIE_OID: TStringField;
    cds_comaieCOMAI_OID: TStringField;
    cds_comaiePROCOM_OID: TStringField;
    cds_comaieCOMAIE_EXCL_INCL: TIntegerField;
    cds_comaieCOMAIE_DES: TStringField;
    dsCOMA_CLIENTE: TStringField;
    cdsCOMA_CLIENTE: TStringField;
    dsCOMA_CONSUMO: TFMTBCDField;
    dsCOMA_SALDO: TFMTBCDField;
    dsCOMA_TOTAL: TFMTBCDField;
    dsCOMA_TXSERV: TFMTBCDField;
    ds_comaiCOMAI_UNIT: TFMTBCDField;
    ds_comaiCOMAI_QTDE: TFMTBCDField;
    ds_comaiCOMAI_TOTAL: TFMTBCDField;
    ds_comaiPRO_VENDA: TFMTBCDField;
    ds_comaieCOMAIE_VALOR: TFMTBCDField;
    ds_comapCOMAP_VALOR: TFMTBCDField;
    ds_mcxMCX_VALOR: TFMTBCDField;
    ds_mcxMCX_DINHEIRO: TFMTBCDField;
    ds_mcxMCX_TROCO: TFMTBCDField;
    cdsCOMA_CONSUMO: TFMTBCDField;
    cdsCOMA_SALDO: TFMTBCDField;
    cdsCOMA_TOTAL: TFMTBCDField;
    cdsCOMA_TXSERV: TFMTBCDField;
    cds_comaiCOMAI_UNIT: TFMTBCDField;
    cds_comaiCOMAI_QTDE: TFMTBCDField;
    cds_comaiCOMAI_TOTAL: TFMTBCDField;
    cds_comaiPRO_VENDA: TFMTBCDField;
    cds_comapCOMAP_VALOR: TFMTBCDField;
    cds_mcxMCX_VALOR: TFMTBCDField;
    cds_mcxMCX_DINHEIRO: TFMTBCDField;
    cds_mcxMCX_TROCO: TFMTBCDField;
    cds_comaieCOMAIE_VALOR: TFMTBCDField;
    procedure cds_comaieBeforePost(DataSet: TDataSet);
  protected
    function GetSQL: TSQL; override;
    procedure RegistrarPagamentoCartao(const MeioDePagamento: MeiosDePagamento; const ParametrosPagamento: TMap);
  public
    function AbrirComandaParaCliente(const Cliente: string): TComandaModelo;
    function AbrirComandaParaMesa(const Mesa: string): TComandaModelo;
    function AtualizarQuantidadeItem(const Oid: string; const Quantidade: Real): TComandaModelo;
    function CarregarComanda(const Identificacao: string): TComandaModelo;
    function EstaAberta: Boolean;
    function FecharComanda: Boolean;
    function InserirItem(const ProdutoOid, Descricao: string; const ValorUnitario, Quantidade, Total: Real): string;
    function InserirPagamentoDinheiro(const ParametrosPagamento: TMap): TComandaModelo;
    function InserirPagamentoCartaoDeCredito(const ParametrosPagamento: TMap): TComandaModelo;
    function InserirPagamentoCartaoDeDebito(const ParametrosPagamento: TMap): TComandaModelo;
    function LimparComanda: TComandaModelo;
    function SalvarComanda: TComandaModelo;
    function TotalizarComanda: TComandaModelo;
    procedure RegistrarPagamentoEmDinheiro(const Parametros: TMap);
    procedure RegistrarPagamentoCartaoDeDebito(const Parametros: TMap);
    procedure RegistrarPagamentoCartaoDeCredito(const Parametros: TMap);
  published
    function CarregarIngredientes(const OidItem, OidProduto: string): TComandaModelo;
    procedure RemoverIngredientes;
  end;

var
  ComandaModelo: TComandaModelo;

implementation

{$R *.dfm}

{ TComandaModelo }

function TComandaModelo.AbrirComandaParaCliente(const Cliente: string): TComandaModelo;
var
  _clienteCadastrado: string;
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'coma_oid');
  _dataSet.FieldByName('coma_comanda').AsString := Self.FDataUtil.GenerateDocumentNumber('COMANDA', Self.Sql);
  _dataSet.FieldByName('coma_data').AsDateTime := Now;
  _clienteCadastrado := Self.Parametros.Ler('cl_oid').ComoTexto;
  if _clienteCadastrado <> '' then
    _dataSet.FieldByName('cl_oid').AsString := _clienteCadastrado;
  _dataSet.FieldByName('cl_cod').AsString := Cliente;
  _dataSet.FieldByName('coma_cliente').AsString := Cliente;
  _dataSet.FieldByName('coma_stt').AsInteger := Ord(scAberta);
  _dataSet.FieldByName('coma_total').AsFloat := 0;
  _dataSet.Post();
end;

function TComandaModelo.AbrirComandaParaMesa(const Mesa: string): TComandaModelo;
var
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'coma_oid');
  _dataSet.FieldByName('coma_comanda').AsString := Self.FDataUtil.GenerateDocumentNumber('COMANDA', Self.Sql);
  _dataSet.FieldByName('coma_data').AsDateTime := Now;
  _dataSet.FieldByName('coma_mesa').AsString := Mesa;
  _dataSet.FieldByName('coma_stt').AsInteger := Ord(scAberta);
  _dataSet.FieldByName('coma_total').AsFloat := 0;
  _dataSet.Post();
end;

function TComandaModelo.AtualizarQuantidadeItem(const Oid: string; const Quantidade: Real): TComandaModelo;
var
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds_comai;
  if _dataSet.Locate('comai_oid', VarArrayOf([Oid]), [loCaseInsensitive]) then
  begin
    _dataSet.Edit;
    _dataSet.FieldByName('comai_qtde').AsFloat := Quantidade;
    _dataSet.FieldByName('comai_total').AsFloat :=
      Quantidade * _dataSet.FieldByName('comai_unit').AsFloat;
    _dataSet.Post;
  end;
  Self.TotalizarComanda;
end;

function TComandaModelo.CarregarComanda(const Identificacao: string): TComandaModelo;
var
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds;
  _dataSet.Active := False;
  _dataSet.CommandText := Self.GetSql()
    .ObterSqlFiltrado(Criterio.Campo('COMA_OID').igual(Identificacao).obter);
  _dataSet.Open;
end;

function TComandaModelo.CarregarIngredientes(const OidItem, OidProduto: string): TComandaModelo;
var
  _ingrediente: string;
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds_ingredientes;
  _dataSet.Active := False;
  _dataSet.CommandText := 'select 0 situacao, procom_oid, procom_des ' +
    'from procom where pro_oid = :oid';
  _dataSet.Params.ParamByName('oid').AsString := OidProduto;
  _dataSet.Open;
  if Self.cds_comai.Locate('comai_oid', VarArrayOf([OidItem]), [loCaseInsensitive]) then
    if Self.cds_comaie.RecordCount > 0 then
    begin
      Self.cds_comaie.First;
      while not Self.cds_comaie.Eof do
      begin
        _ingrediente := Self.cds_comaie.FieldByName('procom_oid').AsString;
        if _dataSet.Locate('procom_oid', VarArrayOf([_ingrediente]), [loCaseInsensitive]) then
        begin
          _dataSet.Edit;
          _dataSet.FieldByName('situacao').AsInteger := 1;
          _dataSet.Post;
        end;
        Self.cds_comaie.Next;
      end;
    end;
end;

function TComandaModelo.FecharComanda: Boolean;
var
  _dataSet: TClientDataSet;
begin
  Result := False;
  _dataSet := Self.cds;
  _dataSet.Edit();
  _dataSet.FieldByName('coma_stt').AsInteger := Ord(scPendente);
  _dataSet.Post();
  Self.SalvarComanda();
end;

function TComandaModelo.GetSQL: TSQL;
begin
  if Self.FSql = nil then
    Self.FSql := TSql.Create
      .Select('C.COMA_OID, C.CL_OID, C.COMA_COMANDA, C.COMA_DATA, ' +
        'C.COMA_CONSUMO, C.COMA_SALDO, C.COMA_TOTAL, C.COMA_STT, ' +
        'L.CL_COD, C.COMA_TXSERV, C.COMA_MESA, C.COMA_CLIENTE')
      .From('COMA C LEFT JOIN CL L ON C.CL_OID = L.CL_OID')
      .Order('C.COMA_OID')
      .MetaDados('C.COMA_OID IS NULL');
  Result := Self.FSql;
end;

function TComandaModelo.InserirItem(const ProdutoOid, Descricao: string; const ValorUnitario, Quantidade, Total: Real): string;
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.cds_comai;
  _dataSet.Insert();
  Self.FDataUtil.OidVerify(_dataSet, 'comai_oid');
  _dataSet.FieldByName('pro_oid').AsString := ProdutoOid;
  _dataSet.FieldByName('pro_des').AsString := Descricao;
  _dataSet.FieldByName('comai_qtde').AsFloat := Quantidade;
  _dataSet.FieldByName('comai_unit').AsFloat := ValorUnitario;
  _dataSet.FieldByName('comai_total').AsFloat := Total;
  _dataSet.Insert();
  Self
    .TotalizarComanda
    .SalvarComanda;
  Result := _dataSet.FieldByName('comai_oid').AsString;
end;

function TComandaModelo.InserirPagamentoCartaoDeCredito(const ParametrosPagamento: TMap): TComandaModelo;
begin
  Result := Self;
  Self.RegistrarPagamentoCartao(mpagCartaoCredito, ParametrosPagamento);
end;

function TComandaModelo.InserirPagamentoCartaoDeDebito(const ParametrosPagamento: TMap): TComandaModelo;
begin
  Result := Self;
  Self.RegistrarPagamentoCartao(mpagCartaoDebito, ParametrosPagamento);
end;

function TComandaModelo.InserirPagamentoDinheiro(const ParametrosPagamento: TMap): TComandaModelo;
var
  _valorPago, _dinheiro, _troco: Real;
  _dataHora: TDateTime;
  _dataSet: TClientDataSet;
  _comanda: string;
begin
  Result := Self;
  _dataHora := Now;
  _valorPago := ParametrosPagamento.Ler('valor').ComoDecimal;
  _dinheiro := ParametrosPagamento.Ler('dinheiro').ComoDecimal;
  _troco := ParametrosPagamento.Ler('troco').ComoDecimal;
  _comanda := Self.cds.FieldByName('coma_comanda').AsString;
  // Registro de pagamentos na comanda
  _dataSet := Self.cds_comap;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'comap_oid');
  _dataSet.FieldByName('coma_oid').AsString :=
    Self.cds.FieldByName('coma_oid').AsString;
  _dataSet.FieldByName('comap_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('comap_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('comap_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('comap_hist').AsString := 'PAGTO DINHEIRO ' + ' VALOR DE ' + FormatFloat('R$ ###,##0.00', _valorPago);
  _dataSet.Post();
  // Registro de movimento de caixa
  _dataSet := Self.cds_mcx;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'mcx_oid');
  _dataSet.FieldByName('mcx_tporig').AsInteger := Ord(tomcComanda);
  _dataSet.FieldByName('mcx_orig').AsString :=
    Self.cds_comap.FieldByName('comap_oid').AsString;
  _dataSet.FieldByName('mcx_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('mcx_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('mcxop_oid').AsString := '6';
  _dataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('mcx_historico').AsString :=
    'RECEB. DINHEIRO COMANDA' + _comanda;
  _dataSet.FieldByName('mcx_mpag').AsInteger := Ord(mpagDinheiro);
  _dataSet.FieldByName('mcx_dinheiro').AsCurrency := _dinheiro;
  _dataSet.FieldByName('mcx_troco').AsCurrency := _troco;
  _dataSet.Post();
  Self
    .TotalizarComanda
    .SalvarComanda;
end;

function TComandaModelo.LimparComanda: TComandaModelo;
var
  _dataSet: TClientDataSet;
begin
  Result := Self;
  _dataSet := Self.cds;
  _dataSet.Active := False;
  _dataSet.CommandText := Self.GetSql().ObterSqlMetadados;
  _dataSet.Open();
end;

procedure TComandaModelo.RegistrarPagamentoCartao(const MeioDePagamento: MeiosDePagamento; const ParametrosPagamento: TMap);
var
  _valorPago: Real;
  _dataHora: TDateTime;
  _dataSet: TClientDataSet;
  _OidCartao, _cartao, _comanda: string;
begin
  _dataHora := Now;
  _OidCartao := ParametrosPagamento.Ler('cart_oid').ComoTexto;
  _cartao := ParametrosPagamento.Ler('cart_cod').ComoTexto;
  _valorPago := ParametrosPagamento.Ler('valor').ComoDecimal;
  _comanda := Self.cds.FieldByName('coma_comanda').AsString;
  // Registro de pagamentos na comanda
  _dataSet := Self.cds_comap;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'comap_oid');
  _dataSet.FieldByName('coma_oid').AsString := Self.cds.FieldByName('coma_oid').AsString;
  _dataSet.FieldByName('comap_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('comap_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('comap_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('comap_hist').AsString := 'PAGTO CARTÃO ' + _cartao + ' VALOR DE ' + FormatFloat('R$ ###,##0.00', _valorPago);
  _dataSet.Post();
  // Registro de movimento de caixa
  _dataSet := Self.cds_mcx;
  _dataSet.Append();
  Self.FDataUtil.OidVerify(_dataSet, 'mcx_oid');
  _dataSet.FieldByName('mcx_tporig').AsInteger := 0;
  _dataSet.FieldByName('mcx_orig').AsString := Self.cds_comap.FieldByName('comap_oid').AsString;
  _dataSet.FieldByName('mcx_data').AsDateTime := _dataHora;
  _dataSet.FieldByName('mcx_valor').AsCurrency := _valorPago;
  _dataSet.FieldByName('mcxop_oid').AsString := IntToStr(Ord(odcRecebimentoDeVenda));
  _dataSet.FieldByName('mcx_dc').AsInteger := Ord(dcCredito);
  _dataSet.FieldByName('mcx_historico').AsString := 'RECEB. CARTÃO ' + _cartao + ' COMANDA' + _comanda;
  _dataSet.FieldByName('mcx_mpag').AsInteger := Ord(MeioDePagamento);
  _dataSet.FieldByName('cart_oid').AsString := _OidCartao;
  _dataSet.Post();
  Self
    .TotalizarComanda
    .SalvarComanda;
end;

procedure TComandaModelo.RegistrarPagamentoCartaoDeCredito(const Parametros: TMap);
begin
  Self.InserirPagamentoCartaoDeCredito(Parametros);
end;

procedure TComandaModelo.RegistrarPagamentoCartaoDeDebito(const Parametros: TMap);
begin
  Self.InserirPagamentoCartaoDeDebito(Parametros);
end;

procedure TComandaModelo.RegistrarPagamentoEmDinheiro(const Parametros: TMap);
begin
  Self.InserirPagamentoDinheiro(Parametros)
end;

procedure TComandaModelo.RemoverIngredientes;
var
  _item: string;
  _dsOrigem, _dsDestino: TDataSet;
begin
  _item := Self.Parametros.Ler('item').ComoTexto;
  _dsOrigem := Self.cds_ingredientes;
  _dsDestino := Self.cds_comaie;
  _dsOrigem.First;
  while not _dsOrigem.Eof do
  begin
    if _dsOrigem.FieldByName('situacao').AsInteger = 1 then
    begin
      _dsDestino.Append;
      _dsDestino.FieldByName('comai_oid').AsString := _item;
      _dsDestino.FieldByName('procom_oid').AsString :=
        _dsOrigem.FieldByName('procom_oid').AsString;
      _dsDestino.FieldByName('comaie_excl_incl').AsInteger := 0;
      _dsDestino.FieldByName('comaie_des').AsString :=
        _dsOrigem.FieldByName('procom_des').AsString;
      _dsDestino.Post;
    end;
    _dsOrigem.Next;
  end;
end;

function TComandaModelo.SalvarComanda: TComandaModelo;
begin
  Result := Self;
  Self.Salvar();
end;

function TComandaModelo.TotalizarComanda: TComandaModelo;
var
  _consumo, _valorServico, _pagamentos: Real;
  _dataSet: TDataSet;
  _taxaServico: string;
begin
  Result := Self;
  if not (Self.cds_comai.FieldByName('VALOR_TOTAL').AsString = '') then
    _consumo := Self.cds_comai.FieldByName('VALOR_TOTAL').Value
  else
    _consumo := 0;
  if not (Self.cds_comap.FieldByName('VALOR_TOTAL').AsString = '') then
    _pagamentos := Self.cds_comap.FieldByName('VALOR_TOTAL').Value
  else
    _pagamentos := 0;
  _taxaServico := Self.FConfiguracoes.Ler('TaxaServico');
  if _taxaServico <> '' then
    _valorServico := StrToFloat(_taxaServico) / 100 * _consumo
  else
    _valorServico := 0;
  _dataSet := Self.cds;
  if not (_dataSet.State in [dsEdit, dsInsert]) then
    _dataSet.Edit();
  _dataSet.FieldByName('coma_consumo').AsFloat := _consumo;
  _dataSet.FieldByName('coma_txserv').AsCurrency := _valorServico;
  _dataSet.FieldByName('coma_total').AsCurrency := _consumo + _valorServico;
  _dataSet.FieldByName('coma_saldo').AsCurrency :=
    _consumo + _valorServico - _pagamentos;
end;

procedure TComandaModelo.cds_comaieBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'comaie_oid');
end;

function TComandaModelo.EstaAberta: Boolean;
begin
  Result := Self.DataSet.FieldByName('COMA_STT').AsInteger = 0;
end;

initialization
  RegisterClass(TComandaModelo);  

end.
