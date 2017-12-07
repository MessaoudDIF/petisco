unit UnContaCorrenteListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton, DB,
  JvTransparentButton, ExtCtrls,
  { helsonsant }
  Util, DataUtil, UnModelo, UnContaCorrenteListaRegistrosModelo,
  Componentes, UnAplicacao, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TContaCorrenteListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnIncluir: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtContaCorrente: TEdit;
    gContasCorrentes: TJvDBUltimGrid;
    procedure btnIncluirClick(Sender: TObject);
    procedure EdtContaCorrenteChange(Sender: TObject);
    procedure gContasCorrentesDblClick(Sender: TObject);
  private
    FControlador: IResposta;
    FContaCorrenteListaRegistrosModelo: TContaCorrenteListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TContaCorrenteListaRegistrosView }

function TContaCorrenteListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContaCorrenteListaRegistrosView.Descarregar: ITela;
begin
  Result := Self;
end;

function TContaCorrenteListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TContaCorrenteListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FContaCorrenteListaRegistrosModelo :=
    (Modelo as TContaCorrenteListaRegistrosModelo);
  Result := Self;
end;

function TContaCorrenteListaRegistrosView.Preparar: ITela;
begin
  Self.gContasCorrentes.DataSource :=
    Self.FContaCorrenteListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TContaCorrenteListaRegistrosView.btnIncluirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FContaCorrenteListaRegistrosModelo.Parametros;
  _parametros.Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TContaCorrenteListaRegistrosView.EdtContaCorrenteChange(
  Sender: TObject);
begin
  if Self.EdtContaCorrente.Text = '' then
    Self.FContaCorrenteListaRegistrosModelo.Carregar
  else
    Self.FContaCorrenteListaRegistrosModelo.CarregarPor(
        Criterio.Campo('ccor_des').como(Self.EdtContaCorrente.Text).Obter);
end;

procedure TContaCorrenteListaRegistrosView.gContasCorrentesDblClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
  _parametros: TMap;
begin
  _dataSet := Self.FContaCorrenteListaRegistrosModelo.DataSet;
  _parametros := Self.FContaCorrenteListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrCarregar))
    .Gravar('oid', _dataSet.FieldByName('ccor_oid').AsString);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada)
end;

end.
