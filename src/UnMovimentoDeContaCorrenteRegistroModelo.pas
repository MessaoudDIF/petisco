unit UnMovimentoDeContaCorrenteRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TMovimentoDeContaCorrenteRegistroModelo = class(TModelo)
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

var
  MovimentoDeContaCorrenteRegistroModelo: TMovimentoDeContaCorrenteRegistroModelo;

implementation

{$R *.dfm}

{ TMovimentoDeContaCorrenteRegistroModelo }

function TMovimentoDeContaCorrenteRegistroModelo.EhValido: Boolean;
begin
  {
  TODO: validação de dados padrão
    - data: faixa de datas;
    - valor: maior que zero, faixa de valores
  }
  Self.FDataUtil.PostChanges(Self.cds);
  Result := inherited EhValido and
    (not (Self.cds.FieldByName('ccor_oid').AsString = '')) and
    (not (Self.cds.FieldByName('ccormvo_oid').AsString = '')) and
    (not (Self.cds.FieldByName('cats_oid').AsString = '')) and
    (not (Self.cds.FieldByName('ccormv_data').AsString = '')) and
    (not (Self.cds.FieldByName('ccormv_valor').AsString = '')) and
    (not (Self.cds.FieldByName('ccormv_hist').AsString = ''));
end;

function TMovimentoDeContaCorrenteRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('BancoPesquisaModelo');
    Self.FDominio.Sql
      .Select('M.CCORMV_OID, M.CCOR_OID, M.CCORMVO_OID, M.CAT_OID, ' +
        'M.CATS_OID, M.CRES_OID, M.CCORMV_ORDER, M.CCORMV_COMPETENCIA, ' +
        'M.CCORMV_DATA, M.CCORMV_VALOR, M.CCORMV_DOC, M.CCORMV_HIST, ' +
        'M.REC_STT, M.REC_INS, M.REC_UPD, M.REC_DEL, ' +
        'C.CCOR_DES, O.CCORMVO_DES, S.CATS_DES, R.CRES_DES')
      .From('CCORMV M ' +
        'INNER JOIN CCOR C ON M.CCOR_OID = C.CCOR_OID ' +
        'INNER JOIN CCORMVO O ON M.CCORMVO_OID = O.CCORMVO_OID ' +
        'LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID ' +
        'LEFT JOIN CRES R ON M.CRES_OID = R.CRES_OID')
      .Order('M.CCORMV_OID')
      .MetaDados('M.CCORMV_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CCORMV_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CCOR_OID')
        .Descricao('Conta Corrente')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCORMVO_OID')
        .Descricao('Operação')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CAT_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCORMV_DATA')
        .Descricao('Data')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCORMV_VALOR')
        .Descricao('Valor')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCORMV_HIST')
        .Descricao('Histórico')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCOR_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCORMVO_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CRES_DES')
        .DesativarAtualizacao)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TMovimentoDeContaCorrenteRegistroModelo.cdsBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'ccormv_oid');
end;

procedure TMovimentoDeContaCorrenteRegistroModelo.Cancelar;
var
  _dataSet: TClientDataSet;
begin
  _dataSet := Self.cds;
  _dataSet.Edit;
  _dataSet.FieldByName('REC_STT').AsInteger := Ord(srCancelado);
  _dataSet.Post;
  _dataSet.ApplyUpdates(-1);
end;

initialization
  RegisterClass(TMovimentoDeContaCorrenteRegistroModelo);

end.
