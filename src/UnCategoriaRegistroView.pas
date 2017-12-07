unit UnCategoriaRegistroView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExStdCtrls, JvEdit, JvValidateEdit, StdCtrls, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, JvExControls, JvButton,
  JvTransparentButton, ExtCtrls,
  { helsonsant }
  Util, DataUtil, UnModelo, UnCategoriaRegistroModelo, UnAplicacao, Data.DB;

type
  TCategoriaRegistroView = class(TForm)
    Panel1: TPanel;
    btnGravar: TJvTransparentButton;
    btnMaisOpcoes: TJvTransparentButton;
    pnlSpace: TPanel;
    Panel2: TPanel;
    btnRecebimentos: TPanel;
    btnImpostos: TPanel;
    Pages: TPageControl;
    TabSheet1: TTabSheet;
    gCategorias: TJvDBUltimGrid;
    btnDespesasFixas: TPanel;
    btnDespesasVariaveis: TPanel;
    pnlCategoria: TPanel;
    Label3: TLabel;
    EdtCategoria: TEdit;
    btnInclui: TPanel;
    Panel12: TPanel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluiClick(Sender: TObject);
  private
    FControlador: IResposta;
    FCategoriaRegistroModelo: TCategoriaRegistroModelo;
    FGrupoSelecionado: Integer;
    FGrupos: TStringList;
  public
    function Controlador(const Controlador: IResposta): TCategoriaRegistroView; 
    function Modelo(const Modelo: TModelo): TCategoriaRegistroView;
    function Preparar: TCategoriaRegistroView;
  published
    procedure AlterarSelecaoDeCategoria(Sender: TObject);
    procedure Desselecionar(const Botao: TPanel);
    procedure Selecionar(const Botao: TPanel);
  end;

var
  CategoriaRegistroView: TCategoriaRegistroView;

implementation

{$R *.dfm}

function TCategoriaRegistroView.Modelo(
  const Modelo: TModelo): TCategoriaRegistroView;
begin
  Self.FCategoriaRegistroModelo := (Modelo as TCategoriaRegistroModelo);
  Result := Self;
end;

function TCategoriaRegistroView.Preparar: TCategoriaRegistroView;
begin
  Self.FGrupos := TStringList.Create;
  Self.FGrupos.AddObject('Recebimentos', Self.btnRecebimentos);
  Self.FGrupos.AddObject('Impostos', Self.btnImpostos);
  Self.FGrupos.AddObject('Despesas Fixas', Self.btnDespesasFixas);
  Self.FGrupos.AddObject('Despesas Variáveis', Self.btnDespesasVariaveis);
  Self.FGrupoSelecionado := -1;
  Self.AlterarSelecaoDeCategoria(Self.btnRecebimentos);
  Self.gCategorias.DataSource := Self.FCategoriaRegistroModelo.DataSource;
  Result := Self;
end;

procedure TCategoriaRegistroView.AlterarSelecaoDeCategoria(Sender: TObject);
var
  _selecao: TPanel;
  _chamada: TChamada;
begin
  _selecao := TPanel(Sender);
  if _selecao.Tag <> Self.FGrupoSelecionado then
  begin
    if Self.FGrupoSelecionado > -1 then
      Self.Desselecionar(TPanel(Self.FGrupos.Objects[Self.FGrupoSelecionado]));
    Self.Selecionar(_selecao);
    Self.FCategoriaRegistroModelo.Parametros
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('categoria', Self.FGrupoSelecionado);
    _chamada := TChamada.Create
      .Chamador(Self)
      .Parametros(Self.FCategoriaRegistroModelo.Parametros);
    Self.FControlador.Responder(_chamada);
  end;
end;

procedure TCategoriaRegistroView.btnGravarClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TCategoriaRegistroView.Selecionar(const Botao: TPanel);
begin
  Self.FGrupoSelecionado := Botao.Tag;
  Botao.Color := $0082A901;
  Botao.Font.Color := clWhite;
  Botao.Font.Style := [fsBold];
end;

procedure TCategoriaRegistroView.Desselecionar(const Botao: TPanel);
begin
  Botao.Color := clSilver;
  Botao.Font.Color := clTeal;
  Botao.Font.Style := [];
end;

function TCategoriaRegistroView.Controlador(
  const Controlador: IResposta): TCategoriaRegistroView;
begin
  Self.FControlador := Controlador;
  Result := Self;
end;

procedure TCategoriaRegistroView.btnIncluiClick(Sender: TObject);
var
  _chamada: TChamada;
begin
  if Self.EdtCategoria.Text <> '' then
  begin
    Self.FCategoriaRegistroModelo.Parametros
      .Gravar('acao', Ord(adrIncluir))
      .Gravar('categoria', Self.FGrupoSelecionado)
      .Gravar('descricaoCategoria', Self.EdtCategoria.Text);
    _chamada := TChamada.Create
      .Chamador(Self)
      .Parametros(Self.FCategoriaRegistroModelo.Parametros);
    try
      Self.FControlador.Responder(_chamada);
      Self.EdtCategoria.Clear;
    finally
      FreeAndNil(_chamada);
    end;
  end;
end;


end.
