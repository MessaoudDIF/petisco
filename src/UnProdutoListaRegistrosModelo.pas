unit UnProdutoListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  DataUtil, UnModelo, Dominio;

type
  TProdutoListaRegistrosModelo = class(TModelo)
  protected
    function GetSQL: TSQL; override;
  end;

implementation

{$R *.dfm}

{ TProdutoListaRegistrosModelo }

function TProdutoListaRegistrosModelo.GetSQL: TSQL;
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
    Self.FDominio := TDominio.Create('ProdutoListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('PRO_OID, PRO_COD, PRO_DES, PRO_VENDA')
      .From('PRO')
      .Where(Self.FUtil
        .Iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('PRO_DES')
      .Metadados('PRO_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PRO_COD', 'Código', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PRO_DES', 'Descrição', 45))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PRO_VENDA', 'Preço', 15).Formato('#,##0.00')) 
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TProdutoListaRegistrosModelo);

end.
