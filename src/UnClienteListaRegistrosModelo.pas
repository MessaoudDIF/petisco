unit UnClienteListaRegistrosModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UnModelo, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { Fluente }
  Util, DataUtil, Dominio;

type
  TClienteListaRegistrosModelo = class(TModelo)
  protected
    function GetSql: TSql; override;
  public
    function OrdernarPor(const Campo: string): TModelo; override;
  end;

implementation

{$R *.dfm}

{ TClienteListaRegistrosModelo }

function TClienteListaRegistrosModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('ClienteListaRegistrosModelo');
    Self.FDominio.Sql
      .Select('CL_OID, CL_COD, CL_NOME, CL_FONE, CL_ENDER')
      .From('CL')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CL_OID')
      .MetaDados('CL_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_COD', 'Código', 15))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_NOME', 'Cliente', 30))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_FONE', 'Telefone', 20))
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CL_ENDER', 'Endereço', 30));
  end;
  Result := Self.FDominio.Sql;
end;

function TClienteListaRegistrosModelo.OrdernarPor(const Campo: string): TModelo;
begin
  if Campo = 'Codigo' then
    Self.cds.IndexName := 'codigo'
  else
    if Campo = 'Nome' then
      Self.cds.IndexName := 'nome'
    else
      Self.cds.IndexName := '';
  Result := Self;
end;

initialization
  RegisterClass(TClienteListaRegistrosModelo);

end.
