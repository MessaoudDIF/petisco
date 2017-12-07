unit UnFornecedorListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TFornecedorListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TFornecedorListaRegistrosModelo }

function TFornecedorListaRegistrosModelo.GetSql: TSql;
var
  _exibirRegistrosExcluidos: Boolean;
  _configuracao: string;
begin
  _exibirRegistrosExcluidos := False;
  _configuracao := Self.FConfiguracoes.Ler('ExibirRegistrosExcluidos');
  if _configuracao = '1' then
    _exibirRegistrosExcluidos := True;
  if Self.FDominio = nil then
  begin
    Self.FDominio := TDominio.Create('FornecedorListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('FORN_OID, FORN_COD, FORN_NOME, FORN_FONE, FORN_CIDADE, FORN_UF')
      .From('FORN')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('FORN_OID')
      .MetaDados('FORN_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_COD', 'Código', 5))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_NOME', 'Fornecedor', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_FONE', 'Telefone', 20))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_CIDADE', 'Cidade', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_UF', 'Estado', 3))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TFornecedorListaRegistrosModelo);

end.
