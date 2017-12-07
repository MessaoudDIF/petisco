unit UnCategoriaRegistroModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr,
  { helsonsant}
  Util, DataUtil, UnModelo, Dominio;

type
  TCategoriaRegistroModelo = class(TModelo)
    procedure cdsBeforePost(DataSet: TDataSet);
  protected
    function GetSql: TSql; override;
  public
    function IncluirCategoria(const Categoria: Integer;
      const Descricao: string): TCategoriaRegistroModelo;
  end;

implementation

{$R *.dfm}

{ TCategoriaRegistroModelo }

function TCategoriaRegistroModelo.GetSql: TSql;
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
    Self.FDominio := TDominio.Create('CategoriaRegistroModelo');
    Self.FDominio.Sql
      .Select('CATS_OID, CAT_OID, CATS_COD, CATS_DES, ' +
        'REC_STT, REC_INS, REC_UPD, REC_DEL')
      .From('CATS')
      .Where(Self.FUtil
        .iff(not _exibirRegistrosExcluidos, Format('REC_STT = %s', [IntToStr(Ord(srAtivo))]), ''))
      .Order('CATS_DES')
      .MetaDados('CATS_OID IS NULL');
    Self.FDominio.Campos
      .Adicionar(TFabricaDeCampos.ObterCampoChave('CATS_OID'))
      .Adicionar(TFabricaDeCampos.ObterCampo('CAT_OID')
        .Descricao('Tipo')
        .TornarObrigatorio)
      .Adicionar(TFabricaDeCampos.ObterCampoVisivel('CATS_DES', 'Categoria', 30)
        .TornarObrigatorio)
  end;
  Result := Self.FDominio.Sql;
end;

procedure TCategoriaRegistroModelo.cdsBeforePost(DataSet: TDataSet);
begin
  inherited;
  Self.FDataUtil.OidVerify(DataSet, 'cats_oid');
end;

function TCategoriaRegistroModelo.IncluirCategoria(
  const Categoria: Integer;
  const Descricao: string): TCategoriaRegistroModelo;
begin
  Self.Incluir;
  Self.cds.FieldByName('cat_oid').AsString := IntToStr(Categoria);
  Self.cds.FieldByName('cats_des').AsString := Descricao;
  Self.cds.Post;
  Self.cds.ApplyUpdates(-1);
  Result := Self;
end;

initialization
  RegisterClass(TCategoriaRegistroModelo);

end.
