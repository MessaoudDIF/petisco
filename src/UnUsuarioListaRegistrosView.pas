unit UnUsuarioListaRegistrosView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, JvExControls, JvButton, DB,
  JvTransparentButton, ExtCtrls,
  { Fluente }
  Util, DataUtil, UnModelo, UnUsuarioListaRegistrosModelo, Componentes,
  UnAplicacao;

type
  TUsuarioListaRegistrosView = class(TForm, ITela)
    Panel1: TPanel;
    btnIncluir: TJvTransparentButton;
    JvTransparentButton2: TJvTransparentButton;
    pnlFiltro: TPanel;
    EdtUsuario: TEdit;
    gUsuarios: TDBGrid;
    procedure gUsuariosDblClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure EdtUsuarioChange(Sender: TObject);
  private
    FControlador: IResposta;
    FUsuarioListaRegistrosModelo: TUsuarioListaRegistrosModelo;
  public
    function Descarregar: ITela;
    function Controlador(const Controlador: IResposta): ITela;
    function Modelo(const Modelo: TModelo): ITela;
    function Preparar: ITela;
    function ExibirTela: Integer;
  end;

implementation

{$R *.dfm}

{ TUsuarioListaRegistrosView }

function TUsuarioListaRegistrosView.Controlador(
  const Controlador: IResposta): ITela;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

function TUsuarioListaRegistrosView.Descarregar: ITela;
begin
  Self.FControlador := nil;
  Self.FUsuarioListaRegistrosModelo := nil;
  Result := Self;
end;

function TUsuarioListaRegistrosView.ExibirTela: Integer;
begin
  Result := Self.ShowModal;
end;

function TUsuarioListaRegistrosView.Modelo(const Modelo: TModelo): ITela;
begin
  Self.FUsuarioListaRegistrosModelo := (Modelo as TUsuarioListaRegistrosModelo);
  Result := Self;
end;

function TUsuarioListaRegistrosView.Preparar: ITela;
begin
  Self.gUsuarios.DataSource := Self.FUsuarioListaRegistrosModelo.DataSource;
  Result := Self;
end;

procedure TUsuarioListaRegistrosView.gUsuariosDblClick(Sender: TObject);
var
  _dataSet: TDataSet;
  _chamada: TChamada;
begin
  _dataSet := Self.FUsuarioListaRegistrosModelo.DataSet;
  if (_dataSet.RecordCount > 0) and (_dataSet.FieldByName('usr_oid').AsString <> '') then
  begin
    Self.FUsuarioListaRegistrosModelo.Parametros
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid', _dataSet.FieldByName('usr_oid').AsString);
    _chamada := TChamada.Create
      .Chamador(Self)
      .Parametros(Self.FUsuarioListaRegistrosModelo.Parametros);
    Self.FControlador.Responder(_chamada);
  end;
end;

procedure TUsuarioListaRegistrosView.btnIncluirClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  Self.FUsuarioListaRegistrosModelo.Parametros
    .Gravar('acao', Ord(adrIncluir));
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(Self.FUsuarioListaRegistrosModelo.Parametros);
  Self.FControlador.Responder(_chamada);
end;

procedure TUsuarioListaRegistrosView.EdtUsuarioChange(Sender: TObject);
begin
  if Self.EdtUsuario.Text = '' then
    Self.FUsuarioListaRegistrosModelo.Carregar
  else
    Self.FUsuarioListaRegistrosModelo.CarregarPor(
        Criterio.Campo('usr_name').como(Self.EdtUsuario.Text).obter());
end;

end.
