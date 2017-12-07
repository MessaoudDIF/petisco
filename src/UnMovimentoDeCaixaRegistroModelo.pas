unit UnMovimentoDeCaixaRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TMovimentoDeCaixaRegistroModelo = class(TModelo)
    ds_cat: TSQLDataSet;
    ds_catCAT_OID: TStringField;
    ds_catCAT_DES: TStringField;
    dsp_cat: TDataSetProvider;
    cds_cat: TClientDataSet;
    cds_catCAT_OID: TStringField;
    cds_catCAT_DES: TStringField;
    dsr_cat: TDataSource;
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
    procedure Cancelar;
  end;

implementation

{$R *.dfm}

{ TMovimentoDeCaixaRegistroModelo }

procedure TMovimentoDeCaixaRegistroModelo.Cancelar;
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds;
  _dataSet.Edit;
  _dataSet.FieldByName('REC_STT').AsInteger := Ord(srCancelado);
  _dataSet.Post;
  _dataSet.ApplyUpdates(-1);
end;

function TMovimentoDeCaixaRegistroModelo.EhValido: Boolean;
begin
  {
  TODO: validação de dados padrão
    - data: faixa de datas;
    - valor: maior que zero, faixa de valores
  }
  Self.FDataUtil.PostChanges(Self.cds);
  Result := inherited EhValido and
    (not (Self.cds.FieldByName('cxmvo_oid').AsString = '')) and
    (not (Self.cds.FieldByName('cats_oid').AsString = '')) and
    (not (Self.cds.FieldByName('cxmv_data').AsString = '')) and
    (not (Self.cds.FieldByName('cxmv_valor').AsString = '')) and
    (not (Self.cds.FieldByName('cxmv_hist').AsString = ''));
end;

function TMovimentoDeCaixaRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('MovimentoDeCaixaRegistroModelo');
    Self.FDominio.Sql
      .Select('M.CXMV_OID, M.CXMVO_OID, M.CAT_OID, M.CATS_OID, ' +
        'M.CRES_OID, M.CXMV_ORDER, M.CXMV_COMPETENCIA, M.CXMV_DATA, ' +
        'M.CXMV_VALOR, M.CXMV_DOC, M.CXMV_HIST, ' +
        'M.REC_STT, M.REC_INS, M.REC_UPD, M.REC_DEL, ' +
        'O.CXMVO_DES, S.CATS_DES, R.CRES_DES')
      .From('CXMV M ' +
        'INNER JOIN CXMVO O ON M.CXMVO_OID = O.CXMVO_OID ' +
        'LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID ' +
        'LEFT JOIN CRES R ON M.CRES_OID = R.CRES_OID')
      .Order('M.CXMV_OID')
      .MetaDados('M.CXMV_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CXMV_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CXMVO_OID')
        .Descricao('Operação')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CAT_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CXMV_DATA')
        .Descricao('Data')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CXMV_VALOR')
        .Descricao('Valor')
        .Formato('#,##0.00')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CXMV_HIST')
        .Descricao('Histórico')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CXMVO_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CRES_DES')
        .DesativarAtualizacao)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TMovimentoDeCaixaRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'cxmv_oid');
  if DataSet.FieldByName('cxmv_data').AsString = '' then
    DataSet.FieldByName('cxmv_data').AsDateTime := Date;
end;

initialization
  RegisterClass(TMovimentoDeCaixaRegistroModelo);

end.
