unit UnFornecedorPesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TFornecedorPesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

var
  FornecedorPesquisaModelo: TFornecedorPesquisaModelo;

implementation

{$R *.dfm}

{ TFornecedorModeloPesquisa }

function TFornecedorPesquisaModelo.GetSql: TSql;
begin
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('FornecedorPesquisaModelo');
    Self.FDominio.Sql
      .Select('FORN_OID, FORN_NOME, FORN_CIDADE, FORN_UF, FORN_FONE')
      .From('FORN')
      .Order('FORN_NOME')
      .MetaDados('FORN_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_NOME', 'Fornecedor', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_CIDADE', 'Cidade', 20))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_UF', 'Estado', 3))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_FONE', 'Telefone', 20));
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TFornecedorPesquisaModelo);

end.
