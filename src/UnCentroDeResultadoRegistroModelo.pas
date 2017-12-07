unit UnCentroDeResultadoRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnModelo, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, Dominio;

type
  TCentroDeResultadoRegistroModelo = class(TModelo)
    procedure cdsBeforePost(DataSet: TDataSet);
  private
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TCentroDeResultadoRegistroModelo }

function TCentroDeResultadoRegistroModelo.EhValido: Boolean;
begin
  Result := inherited EhValido;
  if Self.cds.FieldByName('cres_cod').AsString = '' then
    Result := False;
end;

function TCentroDeResultadoRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('CentroDeResultadoRegistroModelo');
    Self.FDominio.Sql
      .Select('CRES_OID, CRES_COD, CRES_DES, ' +
        'REC_STT, REC_INS, REC_UPD, REC_DEL')
      .From('CRES')
      .Order('CRES_OID')
      .MetaDados('CRES_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CRES_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CRES_DES')
        .Descricao('Descrição do Centro de Resultado')
        .TornarObrigatorio)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TCentroDeResultadoRegistroModelo.cdsBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'cres_oid');
end;

initialization
  RegisterClass(TCentroDeResultadoRegistroModelo);

end.
