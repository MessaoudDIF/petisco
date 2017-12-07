unit UnOperacaoDeMovimentoDeContaCorrentePesquisaModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TOperacaoDeMovimentoDeContaCorrentePesquisaModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TOperacaoDeMovimentoDeContaCorrenteModelo }

function TOperacaoDeMovimentoDeContaCorrentePesquisaModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('OperacaoDeMovimentoDeContaCorrentePesquisaModelo');
    Self.FDominio.Sql
      .Select('CCORMVO_OID, CCORMVO_COD, CCORMVO_DES')
      .From('CCORMVO')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CCORMVO_DES')
      .MetaDados('CCORMVO_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCORMVO_DES', 'Operação', 30))
  end;
  Result := Self.FDominio.Sql;  
end;

initialization
  RegisterClass(TOperacaoDeMovimentoDeContaCorrentePesquisaModelo);

end.
