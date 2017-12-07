unit UnContaCorrenteRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TContaCorrenteRegistroModelo = class(TModelo)
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function EhValido: Boolean; override;
  end;

var
  ContaCorrenteRegistroModelo: TContaCorrenteRegistroModelo;

implementation

{$R *.dfm}

{ TContaCorrenteRegistroModelo }

function TContaCorrenteRegistroModelo.EhValido: Boolean;
begin
  Result := inherited EhValido and
    (not (Self.cds.FieldByName('CCOR_COD').AsString = '')) and
    (not (Self.cds.FieldByName('CCOR_DES').AsString = ''));
end;

function TContaCorrenteRegistroModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('BancoPesquisaModelo');
    Self.FDominio.Sql
      .Select('C.CCOR_OID, C.BAN_OID, C.CCOR_TIPO, C.CCOR_COD, C.CCOR_DES, ' +
        'C.CCOR_AGN, C.CCOR_AGNDG, C.CCOR_CONTA, C.CCOR_CONTADG, C.CCOR_LIM, ' +
        'C.CCOR_SALDO, C.REC_STT, C.REC_INS, C.REC_UPD, C.REC_DEL, B.BAN_NOME')
      .From('CCOR C LEFT JOIN BAN B ON C.BAN_OID = B.BAN_OID')
      .Order('C.CCOR_OID')
      .MetaDados('C.CCOR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CCOR_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CCOR_COD')
        .Descricao('Código da Conta Corrente')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('CCOR_DES')
        .Descricao('Descrição da Conta Corrente')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampo('BAN_NOME')
        .DesativarAtualizacao)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TContaCorrenteRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'ccor_oid');
end;

initialization
  RegisterClass(TContaCorrenteRegistroModelo);

end.
