unit UnUsuarioRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TUsuarioRegistroModelo = class(TModelo)
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TUsuarioRegistroModelo }

function TUsuarioRegistroModelo.EhValido: Boolean;
var
  _dataSet: TDataSet;
begin
  Result := inherited EhValido;
  _dataSet := Self.DataSet;
  Self.FDataUtil.PostChanges(_dataSet);
  if (_dataSet.FieldByName('usr_name').AsString = '')
    or (_dataSet.FieldByName('usr_pw').AsString = '') then
  begin
    Result := False;
  end;
end;

function TUsuarioRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('UsuarioRegistroModelo');
    Self.FDominio.Sql
      .Select('USR_OID, USR_NAME, USR_PW, USR_ADM, ' +
        'REC_STT, REC_INS, REC_UPD, REC_DEL')
      .From('USR')
      .Order('USR_OID')
      .MetaDados('USR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('USR_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('USR_NAME').TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('USR_PW').TornarObrigatorio)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TUsuarioRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'usr_oid');
end;

initialization
  RegisterClass(TUsuarioRegistroModelo);

end.
