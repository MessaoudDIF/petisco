unit UnFornecedorListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton, DB,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, UnFornecedorListaRegistrosModelo,
  Componentes, UnAplicacao, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TFornecedorListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnAdicionar: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtFornecedor: TEdit;
    gFornecedores: TJvDBUltimGrid;
    procedure btnAdicionarClick(Sender: TObject);
    procedure gFornecedoresDblClick(Sender: TObject);
    procedure EdtFornecedorChange(Sender: TObject);
  private
    FControlador: IResposta;
    FFornecedorListaRegistrosModelo: TFornecedorListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TFornecedorListaRegistrosView }

function TFornecedorListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TFornecedorListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FFornecedorListaRegistrosModelo := nil;
  Result := Self;
end;

function TFornecedorListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TFornecedorListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FFornecedorListaRegistrosModelo :=
    (Modelo as TFornecedorListaRegistrosModelo);
  Result := Self;
end;

function TFornecedorListaRegistrosView.Preparar: ITela;
begin
  Self.gFornecedores.DataSource :=
    Self.FFornecedorListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TFornecedorListaRegistrosView.btnAdicionarClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FFornecedorListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', 'incluir');
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TFornecedorListaRegistrosView.gFornecedoresDblClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FFornecedorListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('forn_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

procedure TFornecedorListaRegistrosView.EdtFornecedorChange(
  Sender: TObject);
begin
  if Self.EdtFornecedor.Text = '' then
    Self.FFornecedorListaRegistrosModelo.Carregar
  else
    Self.FFornecedorListaRegistrosModelo.CarregarPor(
        Criterio.Campo('forn_nome').como(Self.EdtFornecedor.Text).obter());
end;

end.
