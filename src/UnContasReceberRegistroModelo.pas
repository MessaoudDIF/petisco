unit UnContasReceberRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TContasReceberRegistroModelo = class(TModelo)
    ds_cat: TSQLDataSet;
    ds_catCAT_OID: TStringField;
    ds_catCAT_DES: TStringField;
    dsp_cat: TDataSetProvider;
    cds_cat: TClientDataSet;
    cds_catCAT_OID: TStringField;
    cds_catCAT_DES: TStringField;
    dsr_cat: TDataSource;
    procedure cdsBeforePost(DataSet: TDataSet);
    procedure cdsAfterInsert(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

var
  ContasReceberRegistroModelo: TContasReceberRegistroModelo;

implementation

{$R *.dfm}

{ TContasReceberRegistroModelo }

function TContasReceberRegistroModelo.EhValido: Boolean;
begin
  Result := inherited EhValido;
end;

function TContasReceberRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('ContasReceberRegistroModelo');
    Self.FDominio.Sql
      .Select('T.TITR_OID, T.CL_OID, T.CATS_OID, T.CRES_OID, T.TITR_DOC, ' +
        ' T.TITR_EMIS, T.TITR_VENC, T.TITR_VALOR, T.TITR_HIST, T.TITR_LIQ, ' +
        ' T.TITR_PAGO, L.CL_NOME, C.CATS_DES, R.CRES_DES, T.CAT_OID, ' +
        ' T.REC_STT, T.REC_INS, T.REC_UPD, T.REC_DEL ')
      .From('TITR T INNER JOIN CL L ON T.CL_OID = L.CL_OID ' +
        ' INNER JOIN CATS C ON T.CATS_OID = C.CATS_OID ' +
        ' LEFT JOIN CRES R ON T.CRES_OID = R.CRES_OID')
      .Order('T.TITR_OID')
      .MetaDados('T.TITR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('TITR_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CL_OID')
        .Descricao('Cliente')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CL_OID')
        .Descricao('Cliente')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_OID')
        .Descricao('Categoria')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TITR_VENC')
        .Descricao('Vencimento da Conta a Receber')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TITR_VALOR')
        .Descricao('Valor da Conta a Receber')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('TITR_HIST')
        .Descricao('Histórico da Conta a Receber')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CL_NOME')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CATS_DES')
        .DesativarAtualizacao)
      .Adicionar(TFabricaDeCampos.ObterCampo('CRES_DES')
        .DesativarAtualizacao)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TContasReceberRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'titr_oid');
end;

procedure TContasReceberRegistroModelo.cdsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('cat_oid').AsString := '0';
end;

initialization
  RegisterClass(TContasReceberRegistroModelo);

end.
