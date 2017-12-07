unit UnClienteLookUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, StdCtrls, Controls,
  Forms, Dialogs, ExtCtrls, ComCtrls, DB, SqlExpr, FMTBcd, Provider, DBClient,
  Grids, DBGrids
  { Fluente }
  ;

type
  TClienteLookUp = class(TObject)
  private
    FDataSource: TDataSource;
    FEdit: TCustomEdit;
    FList: TDBGrid;
    FObserver: TNotifyEvent;
    FParent: TControl;
  protected
    procedure ActivateList(const Sender: TObject);
    procedure DeactivateList(const Sender: TObject);
    procedure SelectProduto;
  public
    constructor Create(const EditControl: TCustomEdit;
      const DataSource: TDataSource; const Parent: TControl;
      const Observer: TNotifyEvent); reintroduce;
    procedure ClearInstance;
    procedure OnChange(Sender: TObject);
    procedure OnEnter(Sender: TObject);
    procedure OnExit(Sender: TObject);
    procedure OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnKeyPress(Sender: TObject);
    procedure OnKeyUp(Sender: TObject);
    procedure ListOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListOnDblClick(Sender: TObject);
  end;

var
  ClienteLookUp: TClienteLookUp;

implementation

procedure TClienteLookUp.ActivateList(const Sender: TObject);
begin
  if not Self.FList.Visible then
  begin
    Self.FList.Align := alClient;
    Self.FList.Visible := True;
    Self.FList.Parent := TWinControl(Sender);
    Self.FParent.Height := 240;
    Self.FParent.Visible := True;
  end;
end;

procedure TClienteLookUp.ClearInstance;
begin
  // Desfaz Referencias
  Self.FDataSource := nil;
  Self.FEdit := nil;
  Self.FObserver := nil;
  Self.FParent := nil;
  // Libera objetos instanciados
  Self.FList.DataSource := nil;
  FreeAndNil(Self.FList);
end;

constructor TClienteLookUp.Create(const EditControl: TCustomEdit;
  const DataSource: TDataSource; const Parent: TControl;
  const Observer: TNotifyEvent);
begin
  inherited Create();
  Self.FDataSource := DataSource;
  Self.FParent := Parent;
  Self.FObserver := Observer;
  // Referência ao Controle de Edição
  Self.FEdit := EditControl;
  //
  // to-do: ligar eventos aos métodos
  //
  TEdit(Self.FEdit).OnChange := Self.OnChange;
  TEdit(Self.FEdit).OnKeyDown := Self.OnKeyDown;
  // Grid
  Self.FList := TDBGrid.Create(nil);
  Self.FList.Visible := False;
  Self.FList.DataSource := Self.FDataSource;
  Self.FList.Ctl3D := False;
  Self.FList.Options := Self.FList.Options - [dgTitles, dgEditing, dgIndicator, dgColLines, dgRowLines] + [dgRowSelect];
  Self.FList.Font.Name := 'Segoe UI';
  Self.FList.Font.Size := 12;
  Self.FList.Font.Style := [fsBold];
  Self.FList.OnKeyDown := Self.ListOnKeyDown;
  Self.FList.OnDblClick := Self.ListOnDblClick;
end;

procedure TClienteLookUp.DeactivateList(const Sender: TObject);
begin
  Self.FParent.Visible := False;
  Self.FList.Visible := False;
end;

procedure TClienteLookUp.ListOnDblClick(Sender: TObject);
begin
  Self.SelectProduto();
  Self.DeactivateList(Sender);
end;

procedure TClienteLookUp.ListOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Self.SelectProduto();
    Self.DeactivateList(Sender);
  end
  else
    if not (Key in [VK_DOWN, VK_UP]) then
      Self.FEdit.SetFocus();
end;

procedure TClienteLookUp.OnChange(Sender: TObject);
var
  iDataSet: TClientDataSet;
begin
  Self.ActivateList(Self.FParent);
  iDataSet := TClientDataSet(Self.FDataSource.DataSet);
  iDataSet.Active := False;
  iDataSet.CommandText := Format('SELECT CL_OID, CL_COD, CL_NOME, CL_RG, CL_FONE, CL_CPF FROM CL WHERE CL_NOME LIKE %s ORDER BY CL_NOME', [QuotedStr('%' + TEdit(Sender).Text + '%')]);
  iDataSet.Active := True;
end;

procedure TClienteLookUp.OnEnter(Sender: TObject);
begin

end;

procedure TClienteLookUp.OnExit(Sender: TObject);
begin

end;

procedure TClienteLookUp.OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  else
    if Key = VK_RETURN then
    begin
      Self.SelectProduto();
      Self.DeactivateList(Sender);
    end
    else
      if Key = VK_DOWN then
        Self.FList.SetFocus()
      else
        TCustomEdit(Sender).SetFocus();
end;

procedure TClienteLookUp.OnKeyPress(Sender: TObject);
begin

end;

procedure TClienteLookUp.OnKeyUp(Sender: TObject);
begin

end;


procedure TClienteLookUp.SelectProduto;
begin
  if Assigned(Self.FObserver) then
    Self.FObserver(Self)
end;

end.
