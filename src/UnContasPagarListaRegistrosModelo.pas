unit UnContasPagarListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, UnModelo, Dominio;

type
  TContasPagarListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TContaPagarListaRegistrosModelo }

function TContasPagarListaRegistrosModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('ContasPagarListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('T.TIT_OID, T.TIT_VENC, T.TIT_VALOR, T.TIT_LIQ, T.TIT_PAGO, ' +
        'F.FORN_NOME')
      .From('TIT T INNER JOIN FORN F ON T.FORN_OID = F.FORN_OID')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('T.REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('T.TIT_VENC')
      .MetaDados('TIT_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TIT_VENC', 'Vencto.', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TIT_VALOR', 'Valor', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TIT_LIQ', 'Pagto.', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TIT_PAGO', 'Valor Pago', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('FORN_NOME', 'Fornecedor', 30))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TContasPagarListaRegistrosModelo)

end.
