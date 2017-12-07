unit UnOperacaoDeMovimentoDeCaixaPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TOperacaoDeMovimentoDeCaixaPesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TOperacaoDeMovimentoDeCaixaPesquisaModelo }

function TOperacaoDeMovimentoDeCaixaPesquisaModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('OperacaoDeMovimentoDeCaixaPesquisaModelo');
    Self.FDominio.Sql
      .Select('CXMVO_OID, CXMVO_COD, CXMVO_DES')
      .From('CXMVO')
      .Order('CXMVO_COD')
      .MetaDados('CXMVO_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMVO_DES', 'Operação', 30));
  end;
  Result := Self.FDominio.Sql;  if Self.FSql = nil then
end;

initialization
  RegisterClass(TOperacaoDeMovimentoDeCaixaPesquisaModelo);

end.
