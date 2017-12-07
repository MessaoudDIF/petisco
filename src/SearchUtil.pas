unit SearchUtil;

interface

uses
  { VCL }
  SysUtils, Variants, Classes, StdCtrls, Controls, Forms, Graphics, Windows,
  Dialogs, ExtCtrls, ComCtrls, DB, SqlExpr, FMTBcd, DBClient, DBGrids,
  { helsonsant }
  DataUtil, UnModelo, UnFabricaDeModelos, UnTeclado;

type
  TPesquisa = class(TObject)
  private
    FAcaoAntesDeAtivar: TNotifyEvent;
    FAcaoAposSelecionar: TNotifyEvent;
    FEdit: TCustomEdit;
    FFiltro: string;
    FList: TDBGrid;
    FModelo: TModelo;
    FParent: TControl;
    FTeclado: TTeclado;
    FFormulario: TForm;
  private
    FOnChange : TNotifyEvent;
    FOnEnter : TNotifyEvent;
    FOnExit : TNotifyEvent;
    FOnKeyDown : TKeyEvent;
  protected
    procedure ActivateList(const Sender: TObject);
    procedure DeactivateList(const Sender: TObject);
    procedure Selecionar;
  public
    property ControleDeEdicao: TCustomEdit read FEdit;
    property Modelo: TModelo read FModelo;
    constructor Create(const EditControl: TCustomEdit = nil;
      const Modelo: TModelo = nil; const Parent: TControl = nil;
      const AcaoAposSelecionar: TNotifyEvent = nil;
      const AcaoAntesDeAtivar: TNotifyEvent = nil); reintroduce;
    function Descarregar: TPesquisa;
    procedure FiltrarPor(const Criterio: string);
    function Formulario(const Formulario: TForm): TPesquisa;
    procedure OnChange(Sender: TObject);
    procedure OnEnter(Sender: TObject);
    procedure OnExit(Sender: TObject);
    procedure OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnKeyPress(Sender: TObject);
    procedure OnKeyUp(Sender: TObject);
    procedure ListOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListOnDblClick(Sender: TObject);
  end;

  ConstrutorDePesquisas = class of TConstrutorDePesquisas;

  TConstrutorDePesquisas = class
  public
    class function AcaoAntesDeAtivar(const EventoDeAcaoAntesDeAtivar: TNotifyEvent): ConstrutorDePesquisas;
    class function AcaoAposSelecao(const EventoDeAcaoAposSelecao: TNotifyEvent): ConstrutorDePesquisas;
    class function ControleDeEdicao(const ReferenciaCampoDeEdicao: TCustomEdit): ConstrutorDePesquisas;
    class function Construir: TPesquisa;
    class function FabricaDeModelos(const FabricaDeModelos: TFabricaDeModelos): ConstrutorDePesquisas;
    class function Formulario(const Formulario: TForm): ConstrutorDePesquisas;
    class function Modelo(const NomeModelo: string): ConstrutorDePesquisas;
    class function PainelDePesquisa(const ReferenciaPainelDePesquisa: TControl): ConstrutorDePesquisas;
  end;

var
  FPesquisas: TStringList;
  FCampoDeEdicao: TCustomEdit;
  FModelo: string;
  FPainelDePesquisa: TControl;
  FAcaoAposSelecao: TNotifyEvent;
  FFabricaDeModelos: TFabricaDeModelos;
  FAcaoAntesDeAtivar: TNotifyEvent;
  FForm: TForm;

implementation

procedure TPesquisa.ActivateList(const Sender: TObject);
begin
  if Assigned(Self.FAcaoAntesDeAtivar) then
    Self.FAcaoAntesDeAtivar(Self);
  if not Self.FList.Visible then
  begin
    Self.FList.Align := alClient;
    Self.FList.Visible := True;
    Self.FList.Parent := TWinControl(Sender);
    Self.FParent.Height := 240;
    Self.FParent.Visible := True;
  end;
end;

function TPesquisa.Descarregar: TPesquisa;
begin
  // Desfaz Referencias
  FFabricaDeModelos.DescarregarModelo(Self.FModelo);
  Self.FModelo := nil;
  Self.FEdit := nil;
  Self.FAcaoAposSelecionar := nil;
  Self.FParent := nil;
  // Libera objetos instanciados
  Self.FList.DataSource := nil;
  FreeAndNil(Self.FList);
  Result := Self;
end;

constructor TPesquisa.Create(const EditControl: TCustomEdit = nil;
  const Modelo: TModelo = nil; const Parent: TControl = nil;
  const AcaoAposSelecionar: TNotifyEvent = nil;
  const AcaoAntesDeAtivar: TNotifyEvent = nil);
begin
  inherited Create();
  Self.FModelo := Modelo;
  Self.FParent := Parent;
  Self.FAcaoAntesDeAtivar := AcaoAntesDeAtivar;
  Self.FAcaoAposSelecionar := AcaoAposSelecionar;
  // Referência ao Controle de Edição
  Self.FEdit := EditControl;
  // Captura eventos necessários à pesquisa
  // Salva eventos originais
  Self.FOnChange := TEdit(EditControl).OnChange;
  Self.FOnEnter := TEdit(EditControl).OnEnter;
  Self.FOnExit := TEdit(EditControl).OnExit;
  Self.FOnKeyDown := TEdit(EditControl).OnKeyDown;
  // Captura para Pesquisa
  TEdit(Self.FEdit).OnChange := Self.OnChange;
  TEdit(Self.FEdit).OnEnter := Self.OnEnter;
  TEdit(Self.FEdit).OnExit := Self.OnExit;
  TEdit(Self.FEdit).OnKeyDown := Self.OnKeyDown;
  // Grid
  Self.FList := TDBGrid.Create(nil);
  Self.FList.BorderStyle := bsNone;
  Self.FList.Visible := False;
  Self.FList.DataSource := Self.FModelo.DataSource();
  Self.FList.Ctl3D := False;
  Self.FList.Options := Self.FList.Options - [dgTitles, dgEditing, dgIndicator, dgColLines, dgRowLines] + [dgRowSelect];
  Self.FList.Font.Name := 'Segoe UI';
  Self.FList.Font.Size := 16;
  Self.FList.Font.Style := [fsBold];
  Self.FList.OnKeyDown := Self.ListOnKeyDown;
  Self.FList.OnDblClick := Self.ListOnDblClick;
end;

procedure TPesquisa.DeactivateList(const Sender: TObject);
begin
  Self.FParent.Visible := False;
  Self.FList.Visible := False;
end;

procedure TPesquisa.ListOnDblClick(Sender: TObject);
begin
  Self.Selecionar();
  Self.DeactivateList(Sender);
end;

procedure TPesquisa.ListOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Self.DeactivateList(Sender);
    Self.FEdit.SetFocus;
  end
  else
    if Key = VK_RETURN then
    begin
      Self.Selecionar;
      Self.DeactivateList(Sender);
    end
    else
      if not (Key in [VK_DOWN, VK_UP]) then
        Self.FEdit.SetFocus;
end;

procedure TPesquisa.OnChange(Sender: TObject);
var
  _edit: TEdit;
  _nomeDoCampo, _filtro: string;
begin
  if Assigned(Self.FOnChange) then
    Self.FOnChange(Sender);
  _edit := TEdit(Sender);
  if _edit.HelpKeyword <> '' then
    _nomeDoCampo := _edit.HelpKeyword
  else
    _nomeDoCampo := Copy(_edit.Name, 4, 1024);
  Self.ActivateList(Self.FParent);
  _filtro := Criterio.Campo(_nomeDoCampo).Como(_edit.Text).Obter;
  if Self.FFiltro <> '' then
    _filtro := _filtro + Criterio.ConectorE + Self.FFiltro;
  Self.FModelo.CarregarPor(_filtro);
end;

procedure TPesquisa.OnEnter(Sender: TObject);
begin
  if Assigned(Self.FOnEnter) then
    Self.FOnEnter(Sender);
//  if Self.FFormulario <> nil then
//  begin
//    if Self.FTeclado = nil then
//    begin
//      Self.FTeclado := TTeclado.Create(nil);
//      Self.FTeclado.Top := Self.FFormulario.Height - Self.FTeclado.Height;
//      Self.FTeclado.Parent := Self.FFormulario;
//      Self.FTeclado.ControleDeEdicao(Self.ControleDeEdicao);
//    end;
//    Self.FTeclado.Visible := True;
//  end;
end;

procedure TPesquisa.OnExit(Sender: TObject);
begin
  if Assigned(Self.FOnExit) then
    Self.FOnExit(Sender);
  if Self.FTeclado <> nil then
    Self.FTeclado.Visible := False;
end;

procedure TPesquisa.OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(Self.FOnKeyDown) then
    Self.FOnKeyDown(Sender, Key, Shift);
  if Key = VK_ESCAPE then
    TCustomEdit(Sender).Clear
  else
    if Key = VK_RETURN then
    begin
      Self.Selecionar();
      Self.DeactivateList(Sender);
    end
    else
      if Key = VK_DOWN then
        Self.FList.SetFocus()
      else
        TCustomEdit(Sender).SetFocus();
end;

procedure TPesquisa.OnKeyPress(Sender: TObject);
begin

end;

procedure TPesquisa.OnKeyUp(Sender: TObject);
begin

end;

procedure TPesquisa.Selecionar;
begin
  if Assigned(Self.FAcaoAposSelecionar) then
    Self.FAcaoAposSelecionar(Self)
end;

{ TConstrutorDePesquisas }

class function TConstrutorDePesquisas.AcaoAntesDeAtivar(
  const EventoDeAcaoAntesDeAtivar: TNotifyEvent): ConstrutorDePesquisas;
begin
  FAcaoAntesDeAtivar := EventoDeAcaoAntesDeAtivar;
  Result := Self;
end;

class function TConstrutorDePesquisas.AcaoAposSelecao(
  const EventoDeAcaoAposSelecao: TNotifyEvent): ConstrutorDePesquisas;
begin
  FAcaoAposSelecao := EventoDeAcaoAposSelecao;
  Result := Self;
end;

class function TConstrutorDePesquisas.ControleDeEdicao(
  const ReferenciaCampoDeEdicao: TCustomEdit): ConstrutorDePesquisas;
begin
  Result := Self;
  FCampoDeEdicao := ReferenciaCampoDeEdicao;
end;

class function TConstrutorDePesquisas.Construir: TPesquisa;
var
  _modelo: TModelo;
begin
  _modelo := FFabricaDeModelos.ObterModelo(FModelo);
  Result := TPesquisa.Create(
    FCampoDeEdicao,
    _modelo,
    FPainelDePesquisa,
    FAcaoAposSelecao,
    FAcaoAntesDeAtivar);
  Result.Formulario(FForm);
end;

class function TConstrutorDePesquisas.FabricaDeModelos(
  const FabricaDeModelos: TFabricaDeModelos): ConstrutorDePesquisas;
begin
  FFabricaDeModelos := FabricaDeModelos;
  Result := Self;
end;

class function TConstrutorDePesquisas.Modelo(
  const NomeModelo: string): ConstrutorDePesquisas;
begin
  FModelo := NomeModelo;
  Result := Self;
end;

class function TConstrutorDePesquisas.PainelDePesquisa(
  const ReferenciaPainelDePesquisa: TControl): ConstrutorDePesquisas;
begin
  FPainelDePesquisa := ReferenciaPainelDePesquisa;
  Result := Self;
end;

procedure TPesquisa.FiltrarPor(const Criterio: string);
begin
  Self.FFiltro := Criterio;
end;

class function TConstrutorDePesquisas.Formulario(
  const Formulario: TForm): ConstrutorDePesquisas;
begin
  FForm := Formulario;
  Result := Self;
end;

function TPesquisa.Formulario(const Formulario: TForm): TPesquisa;
begin
  Self.FFormulario := Formulario;
  Result := Self;
end;

end.
