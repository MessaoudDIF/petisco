unit UnCentroDeResultadoListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TCentroDeResultadoListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TCentroDeResultadoListaRegistrosModelo }

function TCentroDeResultadoListaRegistrosModelo.GetSql: TSql;
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
      .Select('CRES_OID, CRES_COD, CRES_DES')
      .From('CRES')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CRES_OID')
      .MetaDados('CRES_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CRES_COD', 'Código', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CRES_DES', 'Centro de Resultado', 100));
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TCentroDeResultadoListaRegistrosModelo);

end.
