unit UnContasPagarRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TContasPagarRegistroModelo = class(TModelo)
    ds_cat: TSQLDataSet;
    dsp_cat: TDataSetProvider;
    cds_cat: TClientDataSet;
    dsr_cat: TDataSource;
    ds_catCAT_OID: TStringField;
    ds_catCAT_DES: TStringField;
    cds_catCAT_OID: TStringField;
    cds_catCAT_DES: TStringField;
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TContaPagarRegistroModelo }

function TContasPagarRegistroModelo.EhValido: Boolean;
var
  _dataSet: TDataSet;
begin
  Result := inherited EhValido;
  _dataSet := Self.DataSet;
  Self.FDataUtil.PostChanges(_dataSet);
end;

function TContasPagarRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('ContasPagarRegistroModelo');
    Self.FDominio.Sql
      .Select('T.TIT_OID, T.FORN_OID, T.CATS_OID, T.CRES_OID, T.TIT_DOC, ' +
        ' T.TIT_EMIS, T.TIT_VENC, T.TIT_VALOR, T.TIT_HIST, T.TIT_LIQ, ' +
        ' T.TIT_PAGO, F.FORN_NOME, C.CATS_DES, R.CRES_DES, T.CAT_OID, ' +
        ' T.REC_STT, T.REC_INS, T.REC_UPD, T.REC_DEL ')
      .From('TIT T INNER JOIN FORN F ON T.FORN_OID = F.FORN_OID ' +
        ' INNER JOIN CATS C ON T.CATS_OID = C.CATS_OID ' +
        ' LEFT JOIN CRES R ON T.CRES_OID = R.CRES_OID')
      .Order('T.TIT_OID')
      .MetaDados('T.TIT_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('TIT_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('FORN_OID')
        .Descricao('Fornecedor')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TIT_VENC')
        .Descricao('Vencimento')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TIT_VALOR')
        .Descricao('Valor da Conta a Pagar')
        .Formato('#,##0.00')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TIT_PAGO')
        .Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampo('TIT_HIST')
        .Descricao('Histórico da Conta a Pagar')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('FORN_NOME')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CRES_DES')
        .DesativarAtualizacao)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TContasPagarRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'TIT_OID');
end;

initialization
  RegisterClass(TContasPagarRegistroModelo)

end.
