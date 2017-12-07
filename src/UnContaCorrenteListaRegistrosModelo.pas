unit UnContaCorrenteListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, 
  { helsonsant }
  Util, DataUtil, UnModelo, Dominio;

type
  TContaCorrenteListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

var
  ContaCorrenteListaRegistrosModelo: TContaCorrenteListaRegistrosModelo;

implementation

{$R *.dfm}

{ TContaCorrenteListaRegistrosModelo }

function TContaCorrenteListaRegistrosModelo.GetSql: TSql;
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
      .Select('CCOR_OID, CCOR_COD, CCOR_DES')
      .From('CCOR')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CCOR_OID')
      .MetaDados('CCOR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCOR_COD', 'C�digo', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CCOR_DES', 'Conta Corrente', 100))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TContaCorrenteListaRegistrosModelo);

end.
