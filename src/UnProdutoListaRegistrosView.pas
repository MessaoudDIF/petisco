unit UnProdutoListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, Grids, DBGrids,
  StdCtrls, DB, JvExControls, JvButton, JvTransparentButton,
  { helsonsant }
  Util, DataUtil, UnModelo, UnProdutoListaRegistrosModelo,
  Componentes, UnAplicacao, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TProdutoListaRegistrosView = class(TForm, ITela)
    pnlDesktop: TPanel;
    pnlFiltro: TPanel;
    gProdutos: TJvDBUltimGrid;
    JvPanel1: TJvPanel;
    Panel1: TPanel;
    EdtProduto: TEdit;
    btnIncluir: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    procedure EdtProdutoChange(Sender: TObject);
    procedure gProdutosDblClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    FControlador: IResposta;
    FProdutoListaRegistrosModelo: TProdutoListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TProdutoListaRegistrosView }

function TProdutoListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FProdutoListaRegistrosModelo := (Modelo as TProdutoListaRegistrosModelo);
  Result := Self;
end;

function TProdutoListaRegistrosView.Preparar: ITela;
begin
  Self.gProdutos.DataSource := Self.FProdutoListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TProdutoListaRegistrosView.EdtProdutoChange(Sender: TObject);
begin
  if Self.EdtProduto.Text = '' then
    Self.FProdutoListaRegistrosModelo.Carregar
  else
    Self.FProdutoListaRegistrosModelo.CarregarPor(
        Criterio.Campo('pro_des').como(Self.EdtProduto.Text).obter());
end;

function TProdutoListaRegistrosView.Descarregar: ITela;
begin
  Result := Self;
end;

function TProdutoListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

procedure TProdutoListaRegistrosView.gProdutosDblClick(Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FProdutoListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('pro_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

function TProdutoListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

procedure TProdutoListaRegistrosView.btnIncluirClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FProdutoListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(Self.FProdutoListaRegistrosModelo.Parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
