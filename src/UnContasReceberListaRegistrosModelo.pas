unit UnContasReceberListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, 
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TContasReceberListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TContasReceberListaRegistrosModelo }

function TContasReceberListaRegistrosModelo.GetSql: TSql;
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
      .Select('T.TITR_OID, T.TITR_VENC, T.TITR_VALOR, T.TITR_LIQ, T.TITR_PAGO, ' +
        'C.CL_NOME')
      .From('TITR T INNER JOIN CL C ON T.CL_OID = C.CL_OID')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('T.REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('T.TITR_VENC')
      .MetaDados('TITR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TITR_VENC', 'Vencto.', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TITR_VALOR', 'Valor', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TITR_LIQ', 'Data Pagto.', 10))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('TITR_PAGO', 'Valor Pago', 10).Formato('#,##0.00'))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_NOME', 'Cliente', 30))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TContasReceberListaRegistrosModelo);

end.
