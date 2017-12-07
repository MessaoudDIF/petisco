unit UnUsuarioListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  Util, DataUtil, UnModelo, Dominio;

type
  TUsuarioListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  end;

implementation

{$R *.dfm}

{ TUsuarioListaRegistrosModelo }

function TUsuarioListaRegistrosModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('UsuarioListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('USR_OID, USR_NAME')
      .From('USR')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('USR_OID')
      .MetaDados('USR_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('USR_NAME', 'Nome de Usuário', 100))
  end;
  Result := Self.FDominio.Sql;
end;

initialization
  RegisterClass(TUsuarioListaRegistrosModelo);

end.
