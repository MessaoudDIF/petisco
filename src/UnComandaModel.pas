unit UnComandaModel;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider, DBXpress,
  { Fluente }
  Util, DataUtil, Configuracoes;

const
  SQL_COMA = ' select c.coma_oid, c.cl_oid, c.coma_comanda, c.coma_data, ' +
    ' c.coma_consumo, c.coma_saldo, c.coma_total, c.coma_stt, ' +
    ' c.coma_txserv, c.coma_mesa,  l.cl_cod ' +
    ' from coma c inner join cl l on c.cl_oid = l.cl_oid ' +
    ' where coma_oid is null ';
  SQL_PRO  = 'select pro_oid, pro_des, pro_venda ' +
    ' from pro ' +
    ' where pro_oid is null';
  SQL_CL   = 'select cl_oid, cl_cod, cl_nome, cl_cpf, cl_rg, cl_fone ' +
    ' from cl ' +
    ' where cl_oid is null' +
    ' order by cl_nome';
  SQL_DEB  = 'select cart_oid, cart_cod, cart_des ' +
    ' from cart ' +
    ' where cart_dc = 1 ' +
    ' order by cart_des';
  SQL_CRE  = 'select cart_oid, cart_cod, cart_des ' +
    ' from cart ' +
    ' where cart_dc = 1 ' +
    ' order by cart_des';

type
  TComandaModelo = class(TDataModule)
    ds_coma: TSQLDataSet;
    ds_comaCOMA_OID: TStringField;
    ds_comaCL_OID: TStringField;
    ds_comaCOMA_COMANDA: TStringField;
    ds_comaCOMA_DATA: TSQLTimeStampField;
    ds_comaCOMA_TOTAL: TFMTBCDField;
    ds_comaCOMA_STT: TIntegerField;
    dsp_coma: TDataSetProvider;
    cds_coma: TClientDataSet;
    cds_comaCOMA_OID: TStringField;
    cds_comaCL_OID: TStringField;
    cds_comaCOMA_COMANDA: TStringField;
    cds_comaCOMA_DATA: TSQLTimeStampField;
    cds_comaCOMA_TOTAL: TFMTBCDField;
    cds_comaCOMA_STT: TIntegerField;
    cds_comads_comap: TDataSetField;
    cds_comads_comai: TDataSetField;
    dsr_coma: TDataSource;
    ds_comai: TSQLDataSet;
    ds_comaiCOMAI_OID: TStringField;
    ds_comaiCOMA_OID: TStringField;
    ds_comaiCOMAI_QTDE: TFMTBCDField;
    ds_comaiPRO_OID: TStringField;
    ds_comaiCOMAI_UNIT: TFMTBCDField;
    ds_comaiCOMAI_TOTAL: TFMTBCDField;
    ds_comaiPRO_COD: TStringField;
    ds_comaiPRO_DES: TStringField;
    ds_comaiPRO_VENDA: TFMTBCDField;
    cds_comai: TClientDataSet;
    cds_comaiCOMAI_OID: TStringField;
    cds_comaiCOMA_OID: TStringField;
    cds_comaiCOMAI_QTDE: TFMTBCDField;
    cds_comaiPRO_OID: TStringField;
    cds_comaiCOMAI_UNIT: TFMTBCDField;
    cds_comaiCOMAI_TOTAL: TFMTBCDField;
    cds_comaiPRO_COD: TStringField;
    cds_comaiPRO_DES: TStringField;
    cds_comaiPRO_VENDA: TFMTBCDField;
    dsr_comai: TDataSource;
    dsr_coma_comai: TDataSource;
    ds_pro_lkp: TSQLDataSet;
    ds_pro_lkpPRO_OID: TStringField;
    ds_pro_lkpPRO_DES: TStringField;
    ds_pro_lkpPRO_VENDA: TFMTBCDField;
    dsp_pro_lkp: TDataSetProvider;
    cds_pro_lkp: TClientDataSet;
    cds_pro_lkpPRO_OID: TStringField;
    cds_pro_lkpPRO_DES: TStringField;
    cds_pro_lkpPRO_VENDA: TFMTBCDField;
    dsr_pro_lkp: TDataSource;
    ds_comap: TSQLDataSet;
    ds_comapCOMAP_OID: TStringField;
    ds_comapCOMA_OID: TStringField;
    ds_comapCOMAP_DC: TIntegerField;
    ds_comapCOMAP_HIST: TStringField;
    ds_comapCOMAP_VALOR: TFMTBCDField;
    cds_comap: TClientDataSet;
    cds_comapCOMAP_OID: TStringField;
    cds_comapCOMA_OID: TStringField;
    cds_comapCOMAP_DC: TIntegerField;
    cds_comapCOMAP_HIST: TStringField;
    cds_comapCOMAP_VALOR: TFMTBCDField;
    dsr_comap: TDataSource;
    dsr_coma_comap: TDataSource;
    ds_cl_lkp: TSQLDataSet;
    ds_cl_lkpCL_OID: TStringField;
    ds_cl_lkpCL_COD: TStringField;
    ds_cl_lkpCL_NOME: TStringField;
    ds_cl_lkpCL_CPF: TStringField;
    ds_cl_lkpCL_RG: TStringField;
    ds_cl_lkpCL_FONE: TStringField;
    dsp_cl_lkp: TDataSetProvider;
    cds_cl_lkp: TClientDataSet;
    cds_cl_lkpCL_OID: TStringField;
    cds_cl_lkpCL_COD: TStringField;
    cds_cl_lkpCL_NOME: TStringField;
    cds_cl_lkpCL_CPF: TStringField;
    cds_cl_lkpCL_RG: TStringField;
    cds_cl_lkpCL_FONE: TStringField;
    dsr_cl_lkp: TDataSource;
    ds_cart_debito_lkp: TSQLDataSet;
    ds_cart_debito_lkpCART_OID: TStringField;
    ds_cart_debito_lkpCART_COD: TStringField;
    ds_cart_debito_lkpCART_DES: TStringField;
    dsp_cart_debito_lkp: TDataSetProvider;
    cds_cart_debito_lkp: TClientDataSet;
    cds_cart_debito_lkpCART_OID: TStringField;
    cds_cart_debito_lkpCART_COD: TStringField;
    cds_cart_debito_lkpCART_DES: TStringField;
    dsr_cart_debito_lkp: TDataSource;
    ds_cart_credito_lkp: TSQLDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    dsp_cart_credito_lkp: TDataSetProvider;
    cds_cart_credito_lkp: TClientDataSet;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    dsr_cart_credito_lkp: TDataSource;
    Sql: TSQLDataSet;
    cnn: TSQLConnection;
    ds_comaCOMA_CONSUMO: TFMTBCDField;
    ds_comaCOMA_SALDO: TFMTBCDField;
    ds_comaCOMA_TXSERV: TFMTBCDField;
    ds_comaCOMA_MESA: TIntegerField;
    cds_comaCOMA_CONSUMO: TFMTBCDField;
    cds_comaCOMA_SALDO: TFMTBCDField;
    cds_comaCOMA_TXSERV: TFMTBCDField;
    cds_comaCOMA_MESA: TIntegerField;
    ds_comaCL_COD: TStringField;
    cds_comaCL_COD: TStringField;
  private
    FConnection: TSQLConnection;
    FDataUtil: TDataUtil;
    FMensagem: string;
    FParameters: TMap;
    FConfiguracoes: TConfiguracoes;
    FUtil: TUtil;
  protected
    function GetParameters: TMap;
  public
    property Connection: TSQLConnection read FConnection write FConnection;
    property DataUtil: TDataUtil read FDataUtil write FDataUtil;
    property Mensagem: string read FMensagem write FMensagem;
    property Configuracoes: TConfiguracoes
      read FConfiguracoes write FConfiguracoes;
    property Util: TUtil read FUtil write FUtil;
    procedure abrirComanda(const Cliente: string; const Mesa: string);
    procedure carregarComanda(const Identificacao: string);
    procedure limparComanda;
    procedure InitInstance(Sender: TObject);
    procedure InserirItem(const ProdutoOid: string; const ValorUnitario,
      Quantidade, Total: Real);
    procedure InserirPagamento;
    procedure SalvarComanda;
    procedure TotalizaComanda;
    function lerParametro(const Chave: string): string;
    function gravarParametro(const Chave, Valor: string): TComandaModelo;
    function limparParametros: TComandaModelo;
  end;

var
  ComandaModelo: TComandaModelo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TComandaModel }
procedure TComandaModelo.abrirComanda(const Cliente, Mesa: string);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_coma;
  _dataSet.Append();
  Self.DataUtil.OidVerify(_dataSet, 'coma_oid');
  _dataSet.FieldByName('coma_comanda').AsString := Mesa;
  _dataSet.FieldByName('coma_data').AsDateTime := Now;
  _dataSet.FieldByName('coma_mesa').AsString := Mesa;
  if Cliente <> '' then
  begin
    _dataSet.FieldByName('cl_oid').AsString := Self.lerParametro('cl_oid');
    _dataSet.FieldByName('cl_cod').AsString := Self.lerParametro('cl_cod');
  end;
  _dataSet.FieldByName('coma_stt').AsInteger := 0;
  _dataSet.FieldByName('coma_total').AsFloat := 0;
  _dataSet.Post();
end;

procedure TComandaModelo.carregarComanda(const Identificacao: string);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_coma;
  _dataSet.Active := False;
  _dataSet.CommandText := Format(' select c.coma_oid, c.cl_oid, ' +
    ' c.coma_comanda, c.coma_data, c.coma_consumo, c.coma_saldo, ' +
    ' c.coma_total, c.coma_stt, l.cl_cod, ' +
    ' c.coma_txserv, c.coma_mesa ' +
    ' from coma c inner join cl l on c.cl_oid = l.cl_oid ' +
    ' where c.coma_oid = %s', [QuotedStr(Identificacao)]);
  _dataSet.Open();
end;

function TComandaModelo.GetParameters: TMap;
begin
  if Self.FParameters = nil then
    Self.FParameters := TMap.Create;
  Result := Self.FParameters;
end;

function TComandaModelo.gravarParametro(const Chave,
  Valor: string): TComandaModelo;
begin
  Self.GetParameters().gravarParametro(Chave, Valor);
  Result := Self;
end;

procedure TComandaModelo.InitInstance(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
    if Self.Components[i] is TSQLDataSet then
      TSQLDataSet(Components[i]).SQLConnection := Self.FConnection;
  for i := 0 to Self.ComponentCount-1 do
    if (Self.Components[i] is TClientDataSet) and (Self.Components[i].Tag <> 0) then
      TClientDataSet(Self.Components[i]).Open();
end;

procedure TComandaModelo.InserirItem(const ProdutoOid: string;
  const ValorUnitario, Quantidade, Total: Real);
var
  _dataSet: TDataSet;
begin
  _dataSet := Self.cds_comai;
  _dataSet.Insert();
  Self.DataUtil.OidVerify(_dataSet, 'comai_oid');
  _dataSet.FieldByName('pro_oid').AsString := ProdutoOid;
  _dataSet.FieldByName('comai_qtde').AsFloat := Quantidade;
  _dataSet.FieldByName('comai_unit').AsFloat := ValorUnitario;
  _dataSet.FieldByName('comai_total').AsFloat := Total;
  _dataSet.Insert();
  Self.TotalizaComanda();
  Self.SalvarComanda();
end;

procedure TComandaModelo.InserirPagamento;
var
  _dataSet: TClientDataSet;
begin
  _DataSet := Self.cds_comap;
  Self.DataUtil.OidVerify(_dataSet, 'comap_oid');
end;

function TComandaModelo.lerParametro(const Chave: string): string;
begin
  Result := Self.GetParameters().lerParametro(Chave);
end;

procedure TComandaModelo.limparComanda;
var
  _dataSet: TClientDataSet;
begin
  // Comanda
  _dataSet := Self.cds_coma;
  _dataSet.CommandText := SQL_COMA;
  _dataSet.Open();
  // Pesquisa de Clientes
  _dataSet := Self.cds_cl_lkp;
  _dataSet.CommandText := SQL_CL;
  _dataSet.Open();
  // Pesquisa de Produtos
  _dataSet := Self.cds_pro_lkp;
  _dataSet.CommandText := SQL_PRO;
  _dataSet.Open();
  // Pesquisa de cartoes de credito
  _dataSet := Self.cds_cart_credito_lkp;
  _dataSet.CommandText := SQL_CRE;
  _dataSet.Open();
  // Pesquisa de cartoes de debito
  _dataSet := Self.cds_cart_debito_lkp;
  _dataSet.CommandText := SQL_DEB;
  _dataSet.Open();
end;

function TComandaModelo.limparParametros: TComandaModelo;
begin
  Self.GetParameters().Clear();
  Result := Self;
end;

procedure TComandaModelo.SalvarComanda;
begin
  if Self.cds_coma.ChangeCount > 0 then
    Self.cds_coma.ApplyUpdates(0);
end;

procedure TComandaModelo.TotalizaComanda;
var
  _total: Real;
  _dataSet: TDataSet;
  _taxaServico: string;
begin
  _dataSet := Self.cds_comai;
  _dataSet.First();
  _total := 0;
  while not _dataSet.Eof do
  begin
    _total := _total + _dataSet.FieldByName('comai_total').AsFloat;
    _dataSet.Next();
  end;
  if not (Self.cds_coma.State in [dsEdit, dsInsert]) then
    Self.cds_coma.Edit();
  Self.cds_coma.FieldByName('coma_total').AsFloat := _total;
  _taxaServico := Self.FConfiguracoes.ler('TaxaServico');
  if _taxaServico <> '' then
    Self.cds_coma.FieldByName('coma_txserv').AsFloat :=
      StrToFloat(_taxaServico) / 100 * _total;

end;

end.
