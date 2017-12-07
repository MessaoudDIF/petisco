unit UnClienteListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton, DB,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, Componentes, UnAplicacao,
  UnClienteListaRegistrosModelo, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  JvComponentBase, JvBalloonHint;

type
  TClienteListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnAdicionar: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtCliente: TEdit;
    gClientes: TJvDBUltimGrid;
    procedure EdtClienteChange(Sender: TObject);
    procedure gClientesDblClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
  private
    FControlador: IResposta;
    FClienteListaRegistrosModelo: TClienteListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

uses
  { helsonsant }
  UnMenuView;

{ TClienteListaRegistrosView }

function TClienteListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TClienteListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FClienteListaRegistrosModelo := nil;
  Result := Self;
end;

function TClienteListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TClienteListaRegistrosView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FClienteListaRegistrosModelo := (Modelo as TClienteListaRegistrosModelo);
  Result := Self;
end;

function TClienteListaRegistrosView.Preparar: ITela;
begin
  Self.gClientes.DataSource := Self.FClienteListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TClienteListaRegistrosView.EdtClienteChange(Sender: TObject);
begin
  if Self.EdtCliente.Text = '' then
    Self.FClienteListaRegistrosModelo.Carregar
  else
    Self.FClienteListaRegistrosModelo.CarregarPor(
        Criterio.Campo('cl_cod').como(Self.EdtCliente.Text).obter());
end;

procedure TClienteListaRegistrosView.gClientesDblClick(Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FClienteListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('cl_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

procedure TClienteListaRegistrosView.btnAdicionarClick(Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FClienteListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', 'incluir');
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

end.
