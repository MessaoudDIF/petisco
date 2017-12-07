unit UnClienteRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TClienteRegistroModelo = class(TModelo)
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TClienteRegistroModelo }

function TClienteRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('ClienteRegistroModelo');
    Self.FDominio.Sql
      .Select('CL_OID, CL_COD, CL_NOME, CL_FONE, CL_ENDER, CL_BAIRRO, ' +
        'CL_CIDADE, CL_UF, CL_CEP, CL_RG, CL_CPF, CL_CARENCIA, CL_LIMITE, ' +
        'REC_STT, REC_INS, REC_UPD, REC_DEL ')
      .From('CL')
      .Order('CL_OID')
      .MetaDados('CL_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CL_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CL_COD')
        .Descricao('Apelido')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CL_NOME')
        .Descricao('Nome do Cliente')
        .TornarObrigatorio)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TClienteRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'cl_oid');
end;

function TClienteRegistroModelo.EhValido: Boolean;
var
  _dataSet: TDataSet;
begin
  Result := inherited EhValido;
  _dataSet := Self.DataSet;
  if _dataSet.FieldByName('cl_cod').AsString = '' then
    Result := False;
end;

initialization
  RegisterClass(TClienteRegistroModelo);

end.
