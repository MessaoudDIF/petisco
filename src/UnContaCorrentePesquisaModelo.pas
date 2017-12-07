unit UnContaCorrentePesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TContaCorrentePesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TContaCorrentePesquisaModelo }

function TContaCorrentePesquisaModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('ContaCorrentePesquisaModelo');
    Self.FDominio.Sql
      .Select('CCOR_OID, CCOR_COD, CCOR_DES')
      .From('CCOR')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CCOR_DES')
      .MetaDados('CCOR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCOR_COD', 'Código', 5))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCOR_DES', 'Conta Corrente', 30))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TContaCorrentePesquisaModelo);

end.
