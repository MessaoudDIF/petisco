unit UnContasReceberListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, DB,
  { helsonsant }
  Util, DataUtil, UnModelo, UnAplicacao, UnContasReceberListaRegistrosModelo,
  Grids, DBGrids, StdCtrls, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TContasReceberListaRegistrosView = class(TForm, ITela)
    pnlTitulo: TPanel;
    btnIncluir: TJvTransparentButton;
    btnMenu: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtContaReceber: TEdit;
    gContasReceber: TJvDBUltimGrid;
    procedure btnIncluirClick(Sender: TObject);
    procedure gContasReceberDblClick(Sender: TObject);
    procedure EdtContaReceberChange(Sender: TObject);
  private
    FControlador: IResposta;
    FContasReceberListaRegistrosModelo: TContasReceberListaRegistrosModelo;
  public
    function Controlador(const Controlador: IResposta): ITela;
    function Descarregar: ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TContasReceberListaRegistrosView }

function TContasReceberListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TContasReceberListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FContasReceberListaRegistrosModelo := nil;
  Result := Self;
end;

function TContasReceberListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TContasReceberListaRegistrosView.Modelo(
  const Modelo: TModelo): ITela;
begin
  Self.FContasReceberListaRegistrosModelo :=
    (Modelo as TContasReceberListaRegistrosModelo);
  Result := Self;
end;

function TContasReceberListaRegistrosView.Preparar: ITela;
begin
  Self.gContasReceber.DataSource :=
    Self.FContasReceberListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TContasReceberListaRegistrosView.btnIncluirClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _parametros: TMap;
begin
  _parametros := Self.FContasReceberListaRegistrosModelo.Parametros;
  _parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(_parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TContasReceberListaRegistrosView.gContasReceberDblClick(
  Sender: TObject);
var
  _chamada: TChamada;
  _dataSet: TDataSet;
begin
  _dataSet := Self.FContasReceberListaRegistrosModelo.DataSet;
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('titr_oid').AsString)
    );
  Self.FControlador.Responder(_chamada)
end;

procedure TContasReceberListaRegistrosView.EdtContaReceberChange(
  Sender: TObject);
begin
  if Self.EdtContaReceber.Text = '' then
    Self.FContasReceberListaRegistrosModelo.Carregar
  else
    Self.FContasReceberListaRegistrosModelo.CarregarPor(
        Criterio.Campo('CL_NOME').como(Self.EdtContaReceber.Text).obter());
end;

end.
