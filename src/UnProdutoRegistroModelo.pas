unit UnProdutoRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo, Dominio;

type
  TProdutoRegistroModelo = class(TModelo)
  protected
    function GetSQL: TSQL; override;
  public
    function retornarSaldoEstoque: Real;
  published
    procedure AvaliarRegraAtomicaProduto(DataSet: TDataSet);
    procedure AvaliarRegraAtomicaIngrediente(DataSet: TDataSet);
  end;

var
  ProdutoRegistroModelo: TProdutoRegistroModelo;

implementation

{$R *.dfm}

{ TProdutoRegistroModelo }

function TProdutoRegistroModelo.GetSQL: TSQL;
var
  _detalhe: TDominio;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('pro');
    Self.FDominio.Sql
      .Select('PRO_OID, PRO_COD, PRO_DES, PRO_CUSTO, PRO_VENDA, PRO_SALDO, ' +
        ' REC_STT, REC_INS, REC_UPD, REC_DEL')
      .From('PRO')
      .Metadados('PRO_OID IS NULL')
      .Order('PRO_OID');
    Self.FDominio.AntesDePostarRegistro(Self.AvaliarRegraAtomicaProduto);
    Self.FDominio.RegraDeNegocioGerencial(function (Modelo: TObject): Boolean
      var
        _dataSet: TDataSet;
      begin
        Result := True;
        _dataSet := (Modelo as TModelo).cds;
        Self.FDataUtil.PostChanges(_dataSet);
        if (_dataSet.FieldByName('pro_venda').AsFloat = 0) then
          Result := False;
      end
    );
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('PRO_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('PRO_COD')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('PRO_DES')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('PRO_VENDA')
        .TornarObrigatorio);
    _detalhe := TDominio.Create('procom');
    _detalhe.Sql
      .Select('PROCOM_OID, PRO_OID, PROCOM_DES')
      .From('PROCOM')
      .Order('PROCOM_OID')
      .Metadados('PROCOM_OID IS NULL')
      .CondicaoDeJuncao('PRO_OID = :PRO_OID');
    _detalhe.AntesDePostarRegistro(Self.AvaliarRegraAtomicaIngrediente);
    _detalhe.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('PROCOM_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PROCOM_DES', 'Ingrediente', 35));
    Self.FDominio.Detalhes.Adicionar(_detalhe);
  end;
  Result := Self.FDominio.Sql;
end;

function TProdutoRegistroModelo.retornarSaldoEstoque: Real;
var
  Produto: string;
begin
  Produto := Self.cds.FieldByName('pro_oid').AsString;
  Self.Sql.Active := False;
  Self.Sql.CommandText := ' select sum(saldo) saldo_estoque ' +
    ' from ( ' +
    '   select mcx_orig pro_oid, sum(mcx_troco *-1) saldo ' +
    '     from mcx ' +
    '     where mcx_tporig = 3 and (not mcx_orig is null) and mcx_orig = :oid ' +
    '     group by mcx_orig ' +
    ' union ' +
    '   select pro_oid, sum(fornp_qtde) saldo ' +
    '     from fornp ' +
    '     where (not pro_oid is null) and pro_oid = :oid ' +
    '   group by pro_oid ' +
    ' union ' +
    '   select pro_oid, sum(comai_qtde*-1) saldo ' +
    '     from comai ' +
    '     where pro_oid = :oid ' +
    '     group by pro_oid ' +
    ')';
  Self.Sql.ParamByName('oid').AsString := Produto;
  Self.Sql.Open();
  if Self.Sql.FieldByName('saldo_estoque').IsNull then
    Result := 0
  else
    Result := Self.Sql.FieldByName('saldo_estoque').AsFloat;
  Self.Sql.Close();
end;

procedure TProdutoRegistroModelo.AvaliarRegraAtomicaIngrediente(
  DataSet: TDataSet);
begin
  Self.FDataUtil.OidVerify(DataSet, 'procom_oid');
  DataSet.FieldByName('pro_oid').AsString :=
    Self.cds.FieldByName('pro_oid').AsString;
end;

procedure TProdutoRegistroModelo.AvaliarRegraAtomicaProduto(DataSet: TDataSet);
begin
  Self.FDataUtil.OidVerify(DataSet, 'PRO_OID');
  if DataSet.FieldByName('pro_cod').AsString = '' then
    DataSet.FieldByName('pro_cod').AsString := Self.FDataUtil.GenerateDocumentNumber('pro', Self.Sql);
end;

initialization
  RegisterClass(TProdutoRegistroModelo);

end.
