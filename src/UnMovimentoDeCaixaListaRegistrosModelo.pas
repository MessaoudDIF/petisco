unit UnMovimentoDeCaixaListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TMovimentoDeCaixaListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  published
    procedure CarregarRegistros(const DataInicio, DataFim: TDateTime;
      const Filtro: string);
  end;

var
  MovimentoDeCaixaListaRegistrosModelo: TMovimentoDeCaixaListaRegistrosModelo;

implementation

{$R *.dfm}

{ TMovimentoDeCaixaListaRegistrosModelo }

procedure TMovimentoDeCaixaListaRegistrosModelo.CarregarRegistros(
  const DataInicio, DataFim: TDateTime; const Filtro: string);
var
  _filtro: string;
begin
  _filtro := Criterio.Campo('cxmv_data').Entre(DataInicio).e(DataFim).Obter;
  if Filtro <> '' then
    _filtro := _filtro + Criterio.ConectorE +
      Criterio.Campo('cxmv_hist').Como(Filtro).Obter;
  Self.CarregarPor(_filtro);
end;

function TMovimentoDeCaixaListaRegistrosModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('MovimentoDeCaixaListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('M.CXMV_OID, M.CXMV_DATA, M.CXMV_VALOR, O.CXMVO_DES, ' +
        'M.CXMV_HIST, M.CXMV_DOC, S.CATS_DES, R.CRES_DES')
      .From('CXMV M ' +
        'INNER JOIN CXMVO O ON M.CXMVO_OID = O.CXMVO_OID ' +
        'LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID ' +
        'LEFT JOIN CRES R ON M.CRES_OID = R.CRES_OID')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('M.REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('M.CXMV_OID')
      .MetaDados('M.CXMV_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMV_DATA', 'Data', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMV_VALOR', 'Valor', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMVO_DES', 'Operação', 20))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMV_HIST', 'Histórico', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CXMV_DOC', 'Documento', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CATS_DES', 'Categoria', 25))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CRES_DES', 'Centro de Resultado', 25))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TMovimentoDeCaixaListaRegistrosModelo)

end.
