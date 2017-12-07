unit UnProdutoPesquisaModelo;

interface

uses
  System.SysUtils, FMTBcd, DB, DBClient, Provider, Classes, SqlExpr,
  { Fluente }
  DataUtil, UnModelo, Dominio;

type
  TProdutoPesquisaModelo = class(TModelo)
  protected
    function GetSQL: TSQL; override;
  end;

var
  ProdutoPesquisaModelo: TProdutoPesquisaModelo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TProdutoModelSearch }

function TProdutoPesquisaModelo.GetSQL: TSQL;
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
    Self.FDominio := TDominio.Create('ProdutoPesquisaModelo');
    Self.FDominio.Sql
      .select('PRO_OID, PRO_DES, PRO_VENDA, PRO_COD')
      .from('PRO')
      .Where(Self.FUtil.iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .order('PRO_DES')
      .MetaDados('PRO_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PRO_DES', 'Descrição', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('PRO_VENDA', 'Preço', 10).Formato('R$ 0.00'))
      ;
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TProdutoPesquisaModelo);

end.
