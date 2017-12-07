unit UnMovimentoDeContaCorrenteListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TMovimentoDeContaCorrenteListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  public
    procedure CarregarRegistros(const DataInicio, DataFim: TDateTime;
      const Filtro: string);
  end;

implementation

{$R *.dfm}

{ TMovimentoDeContaCorrenteListaRegistrosmodelo }

procedure TMovimentoDeContaCorrenteListaRegistrosmodelo.CarregarRegistros(
  const DataInicio, DataFim: TDateTime; const Filtro: string);
var
  _filtro: string;
begin
  _filtro := Criterio.Campo('ccormv_data').Entre(DataInicio).e(DataFim).Obter;
  if Filtro <> '' then
    _filtro := _filtro + Criterio.ConectorE +
      Criterio.Campo('ccormv_hist').Como(Filtro).Obter;
  Self.CarregarPor(_filtro);
end;

function TMovimentoDeContaCorrenteListaRegistrosmodelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('BancoPesquisaModelo');
    Self.FDominio.Sql
      .Select('M.CCORMV_OID, M.CCORMV_DATA, M.CCORMV_VALOR, O.CCORMVO_DES, ' +
        'M.CCORMV_HIST, M.CCORMV_DOC, C.CCOR_DES, S.CATS_DES, R.CRES_DES')
      .From('CCORMV M ' +
        'INNER JOIN CCORMVO O ON M.CCORMVO_OID = O.CCORMVO_OID ' +
        'INNER JOIN CCOR C ON M.CCOR_OID = C.CCOR_OID ' +
        'LEFT JOIN CATS S ON M.CATS_OID = S.CATS_OID ' +
        'LEFT JOIN CRES R ON M.CRES_OID = R.CRES_OID')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('M.REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('M.CCORMV_OID')
      .MetaDados('M.CCORMV_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMV_DATA', 'Data', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMV_VALOR', 'Valor', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMVO_DES', 'Operação', 20))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMV_HIST', 'Histórico', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMV_DOC', 'Documento', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCOR_DES', 'Conta Corrente', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CATS_DES', 'Categoria', 25))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CRES_DES', 'Centro de Resultado', 25))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TMovimentoDeContaCorrenteListaRegistrosModelo);

end.
