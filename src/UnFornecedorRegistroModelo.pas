unit UnFornecedorRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio, Data.DBXFirebird;

type
  TFornecedorRegistroModelo = class(TModelo)
    ds_fornp: TSQLDataSet;
    dsp_fornp: TDataSetProvider;
    cds_fornp: TClientDataSet;
    dsr_fornp: TDataSource;
    ds_fornpFORNP_OID: TStringField;
    ds_fornpFORN_OID: TStringField;
    ds_fornpPRO_OID: TStringField;
    ds_fornpFORNP_DES: TStringField;
    ds_fornpFORNP_QTDE: TIntegerField;
    cds_fornpFORNP_OID: TStringField;
    cds_fornpFORN_OID: TStringField;
    cds_fornpPRO_OID: TStringField;
    cds_fornpFORNP_DES: TStringField;
    cds_fornpFORNP_QTDE: TIntegerField;
    ds_fornpFORNP_DATA: TDateField;
    ds_fornpFORNP_UNIT: TFMTBCDField;
    ds_fornpFORNP_TOTAL: TFMTBCDField;
    cds_fornpFORNP_DATA: TDateField;
    cds_fornpFORNP_UNIT: TFMTBCDField;
    cds_fornpFORNP_TOTAL: TFMTBCDField;
    procedure cdsBeforePost(DataSet: TDataSet);
    procedure cds_fornpBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  published
    procedure CarregarProdutos;
    procedure IncluirProduto(const Data: TDate; const Oid: string = '';
  const Descricao: string = ''; const Quantidade: Real = 0; const ValorUnitario: Real = 0; const ValorTotal: Real = 0);
  end;

var
  FornecedorRegistroModelo: TFornecedorRegistroModelo;

implementation

{$R *.dfm}

{ TFornecedorRegistroModelo }

function TFornecedorRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('FornecedorRegistroModelo');
    Self.FDominio.Sql
      .Select('FORN_OID, FORN_COD, FORN_NOME, FORN_FONE, FORN_ENDER, ' +
        'REC_STT, REC_INS, REC_UPD, REC_DEL, ' +
        'FORN_BAIRRO, FORN_CIDADE, FORN_UF, FORN_CEP, FORN_IERG, FORN_CNPJCPF')
      .From('FORN')
      .Order('FORN_OID')
      .MetaDados('FORN_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('FORN_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('FORN_COD')
        .Descricao('Código')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('FORN_NOME')
        .Descricao('Nome')
        .TornarObrigatorio)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TFornecedorRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'forn_oid');
end;

procedure TFornecedorRegistroModelo.CarregarProdutos;
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_fornp;
  _dataSet.Active := False;
  _dataSet.CommandText := 'SELECT FORNP_OID, FORN_OID, PRO_OID, FORNP_DATA, FORNP_UNIT, FORNP_TOTAL, ' +
    'FORNP_DES, FORNP_QTDE ' +
    'FROM FORNP ' +
    'WHERE FORN_OID = ' + QuotedStr(Self.cds.FieldByName('forn_oid').AsString) +  
    'ORDER BY FORNP_DES';
  _dataSet.Open();
end;

procedure TFornecedorRegistroModelo.IncluirProduto(const Data: TDate; const Oid: string = '';
  const Descricao: string = ''; const Quantidade: Real = 0; const ValorUnitario: Real = 0; const ValorTotal: Real = 0);
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds_fornp;
  _dataSet.Append;
  _dataSet.FieldByName('fornp_data').AsDateTime := Data;
  if Oid <> '' then
    _dataSet.FieldByName('pro_oid').AsString := Oid;
  _dataSet.FieldByName('fornp_des').AsString := Descricao;
  _dataSet.FieldByName('fornp_qtde').AsFloat := Quantidade;
  _dataSet.FieldByName('fornp_unit').AsFloat := ValorUnitario;
  _dataSet.FieldByName('fornp_total').AsFloat := ValorTotal;
  _dataSet.Post;
  _dataSet.ApplyUpdates(-1);
end;

procedure TFornecedorRegistroModelo.cds_fornpBeforePost(DataSet: TDataSet);
var
  _dataSet: TDataSet;
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'fornp_oid');
  _dataSet := Self.cds_fornp;
  _dataSet.FieldByName('forn_oid').AsString :=
    Self.cds.FieldByName('forn_oid').AsString;
end;

initialization
  RegisterClass(TFornecedorRegistroModelo);

end.
