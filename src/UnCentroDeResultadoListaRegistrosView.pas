unit UnCentroDeResultadoListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, Grids, DB,
  DBGrids, StdCtrls,
    { helsonsant }
  Util, DataUtil, UnModelo, UnCentroDeResultadoListaRegistrosModelo,
  Componentes, UnAplicacao, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TCentroDeResultadoListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnIncluir: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtCentroDeResultado: TEdit;
    gCentrosResultado: TJvDBUltimGrid;
    procedure EdtCentroDeResultadoChange(Sender: TObject);
    procedure gCentrosResultadoDblClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    FControlador: IResposta;
    FCentroDeResultadoListaRegistrosModelo:
      TCentroDeResultadoListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TCentroDeResultadoListaRegistrosView }

function TCentroDeResultadoListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TCentroDeResultadoListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FCentroDeResultadoListaRegistrosModelo := nil;
  Result := Self;
end;

function TCentroDeResultadoListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TCentroDeResultadoListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FCentroDeResultadoListaRegistrosModelo :=
    (Modelo as TCentroDeResultadoListaRegistrosModelo);
  Result := Self;
end;

function TCentroDeResultadoListaRegistrosView.Preparar: ITela;
begin
  Self.gCentrosResultado.DataSource :=
    Self.FCentroDeResultadoListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TCentroDeResultadoListaRegistrosView.EdtCentroDeResultadoChange(
  Sender: TObject);
begin
  if Self.EdtCentroDeResultado.Text = '' then
    Self.FCentroDeResultadoListaRegistrosModelo.Carregar
  else
    Self.FCentroDeResultadoListaRegistrosModelo.CarregarPor(
        Criterio.Campo('cres_des').como(Self.EdtCentroDeResultado.Text).Obter);
end;

procedure TCentroDeResultadoListaRegistrosView.gCentrosResultadoDblClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FCentroDeResultadoListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('cres_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

procedure TCentroDeResultadoListaRegistrosView.btnIncluirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FCentroDeResultadoListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(Self.FCentroDeResultadoListaRegistrosModelo.Parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
