unit UnContasPagarListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton, DB,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, UnContasPagarListaRegistrosModelo, Componentes,
  UnAplicacao, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TContasPagarListaRegistrosView = class(TForm, ITela)
    pnlTitulo: TPanel;
    btnIncluir: TJvTransparentButton;
    btnMenu: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtContaPagar: TEdit;
    gContasPagar: TJvDBUltimGrid;
    procedure EdtContaPagarChange(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure gContasPagarDblClick(Sender: TObject);
  private
    FControlador: IResposta;
    FContasPagarListaRegistrosModelo: TContasPagarListaRegistrosModelo;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TContaPagarListaRegistrosView }

function TContasPagarListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContasPagarListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FContasPagarListaRegistrosModelo := nil;
  Result := Self;
end;

function TContasPagarListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TContasPagarListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FContasPagarListaRegistrosModelo :=
    (Modelo as TContasPagarListaRegistrosModelo);
  Result := Self;
end;

function TContasPagarListaRegistrosView.Preparar: ITela;
begin
  Self.gContasPagar.DataSource :=
    Self.FContasPagarListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TContasPagarListaRegistrosView.EdtContaPagarChange(
  Sender: TObject);
begin
  if Self.EdtContaPagar.Text = '' then
    Self.FContasPagarListaRegistrosModelo.Carregar
  else
    Self.FContasPagarListaRegistrosModelo.CarregarPor(
        Criterio.Campo('FORN_NOME').como(Self.EdtContaPagar.Text).obter());
end;

procedure TContasPagarListaRegistrosView.btnIncluirClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FContasPagarListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TContasPagarListaRegistrosView.gContasPagarDblClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FContasPagarListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('tit_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

end.
