unit UnProdutoSearch;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Data.SqlExpr, Data.FMTBcd,
  Datasnap.Provider, Datasnap.DBClient, Data.DBXFirebird, Vcl.Grids, Vcl.DBGrids
  { Fluente }
  ;

type
  TProdutoLookUp = class(TObject)
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
  ProdutoLookUp: TProdutoLookUp;

implementation

procedure TProdutoLookUp.ActivateList(const Sender: TObject);
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

constructor TProdutoLookUp.Create(const EditControl: TCustomEdit;
  const DataSource: TDataSource; const Parent: TControl;
  const Observer: TNotifyEvent);
begin
  inherited Create();
  Self.FDataSource := DataSource;
  Self.FParent := Parent;
  Self.FObserver := Observer;
  // Refer�ncia ao Controle de Edi��o
  Self.FEdit := EditControl;
  //
  // to-do: ligar eventos aos m�todos
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

procedure TProdutoLookUp.DeactivateList(const Sender: TObject);
begin
  Self.FParent.Visible := False;
  Self.FList.Visible := False;
end;

procedure TProdutoLookUp.ListOnDblClick(Sender: TObject);
begin
  Self.SelectProduto();
  Self.DeactivateList(Sender);
end;

procedure TProdutoLookUp.ListOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TProdutoLookUp.OnChange(Sender: TObject);
var
  iDataSet: TClientDataSet;
begin
  Self.ActivateList(Self.FParent);
  iDataSet := TClientDataSet(Self.FDataSource.DataSet);
  iDataSet.Active := False;
  iDataSet.CommandText := Format('SELECT PRO_OID, PRO_DES, PRO_VENDA FROM PRO WHERE PRO_DES LIKE %s ORDER BY PRO_DES', [QuotedStr('%' + TEdit(Sender).Text + '%')]);
  iDataSet.Active := True;
end;

procedure TProdutoLookUp.OnEnter(Sender: TObject);
begin

end;

procedure TProdutoLookUp.OnExit(Sender: TObject);
begin

end;

procedure TProdutoLookUp.OnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TProdutoLookUp.OnKeyPress(Sender: TObject);
begin

end;

procedure TProdutoLookUp.OnKeyUp(Sender: TObject);
begin

end;


procedure TProdutoLookUp.SelectProduto;
begin
  if Assigned(Self.FObserver) then
    Self.FObserver(Self)
end;

end.
