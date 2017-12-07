unit DataManager;

interface

uses
  Windows, SysUtils, Classes, DB, DBClient, FMTBcd, Provider, SqlExpr,
  { Fluente }
  UnModelo;

type
  TDataManager = class(TObject)
  private
    FSystem: TFlSystem;
    FDataObjects: TList;
    FDataProxy: TFlDataProxy;
  protected
    function GetConnection(ADataObject: TFlComp = nil; AConnection: TFlConnection = nil): TFlConnection;
    function NewDataObjectInstance(ADataObjectClassName: string; AConnection: TFlConnection): TFlDataObject;
  public
    constructor Create(ADataProxy: TFlDataProxy); reintroduce;
    procedure ClearInstance(Sender: TObject);
    function FindDataObject(ADataObject: TFlComp; const ACreateIt: Boolean = True): TFlDataObject;
    function GetAssemblyConnection: TFlAssembly;
    function GetDataObject(ADataObjectCode: string): TFlDataObject; overload;
    function GetDataObject(ADataObject: TFlComp; AUpdated: Boolean = False; AConnection: TFlConnection = nil): TFlDataObject; overload;
    function GetDataObjects: TList;
    function GetDataProxy: TFlDataProxy;
    function GetSystem: TFlSystem;
    procedure SetSystem(ASystem: TFlSystem);
  published
  end;

implementation

uses Dialogs;

{ TFlDataManager }

function TFlDataManager.FindDataObject(ADataObject: TFlComp; const ACreateIt: Boolean = True): TFlDataObject;
var
  i: Integer;
  iComp: TFlComp;
begin
  Result := nil;
  for i := 0 to Self.GetDataObjects().Count-1 do
  begin
    iComp := TFlComp(TFlDataObject(Self.GetDataObjects().Items[i]).GetComp());
    if (iComp <> nil) and (iComp.Info.Code = ADataObject.Info.Code) then
    begin
      Result := TFlDataObject(Self.GetDataObjects().Items[i]);
      Break;
    end;
  end;
  if (Result = nil) and ACreateIt then
    Result := Self.GetDataObject(ADataObject);
end;

function TFlDataManager.GetDataObject(ADataObject: TFlComp; AUpdated: Boolean = False; AConnection: TFlConnection = nil): TFlDataObject;
var
  iConnection: TFlConnection;
  iDataObjectCode, iDataObjectName: string;
begin
  iConnection := Self.GetConnection(ADataObject, AConnection);
  iDataObjectCode := ADataObject.Info.Code;
  iDataObjectName := 'T' + iConnection.GetConnectionItem.DriverName + iDataObjectCode;
  Result := Self.NewDataObjectInstance(iDataObjectName, iConnection);
end;

function TFlDataManager.GetDataObjects: TList;
begin
  if Self.FDataObjects = nil then
    Self.FDataObjects := TList.Create;
  Result := Self.FDataObjects;
end;

constructor TFlDataManager.Create(ADataProxy: TFlDataProxy);
begin
  inherited Create();
  Self.FDataProxy := ADataProxy;
end;

function TFlDataManager.GetDataProxy: TFlDataProxy;
begin
  Result := Self.FDataProxy;
end;

procedure TFlDataManager.ClearInstance(Sender: TObject);
begin
  while Self.FDataObjects.Count > 0 do
  begin
    TFlDataObject(Self.FDataObjects.Items[0]).ClearInstance(Self);
    TFlDataObject(Self.FDataObjects.Items[0]).Free;
    Self.FDataObjects.Delete(0);
  end;
  Self.FDataObjects.Free;
  Self.FDataObjects := nil;
end;

function TFlDataManager.GetSystem: TFlSystem;
begin
  Result := Self.FSystem;
end;

procedure TFlDataManager.SetSystem(ASystem: TFlSystem);
begin
  Self.FSystem := ASystem;
end;

function TFlDataManager.GetConnection(ADataObject: TFlComp = nil; AConnection: TFlConnection = nil): TFlConnection;
begin
  if (ADataObject <> nil) and (ADataObject.Info.Connection <> '') then
    Result := Self.GetDataProxy().GetConnection(ADataObject.Info.Connection)
  else
    if AConnection <> nil then
      Result := AConnection
    else
      if Self.GetSystem().DefaultConnectionName <> '' then
        Result := Self.GetDataProxy().GetConnection(Self.GetSystem().DefaultConnectionName)
      else
        Result := Self.GetDataProxy().GetDefaultLocalConnection();
end;          

function TFlDataManager.GetDataObject(ADataObjectCode: string): TFlDataObject;
var
  iConnection: TFlConnection;
  iDataObjectCode, iDataObjectName: string;
begin
  iConnection := Self.GetConnection();
  iDataObjectCode := ADataObjectCode;
  iDataObjectName := 'T' + iConnection.GetConnectionItem.DriverName + iDataObjectCode;
  Result := Self.NewDataObjectInstance(iDataObjectName, iConnection);
end;

function TFlDataManager.NewDataObjectInstance(ADataObjectClassName: string; AConnection: TFlConnection): TFlDataObject;
var
  iDataObjectClass: TFlDataObjectClass;
begin
  iDataObjectClass := TFlDataObjectClass(Classes.GetClass(ADataObjectClassName));
  if iDataObjectClass <> nil then
    Result := TComponentClass(iDataObjectClass).Create(nil) as TFlDataObject
  else
    Result := TFlDataObject.Create(nil);
  Result.SetConnection(AConnection);
  Result.SetSystem(Self.GetSystem());
  Result.InitInstance(Self);
  Self.GetDataObjects().Add(Result);
end;
                                                                          
function TFlDataManager.GetAssemblyConnection: TFlAssembly;
begin
  Result := Self.GetDataProxy().GetDefaultAssemblyConnection();
end;

end.

