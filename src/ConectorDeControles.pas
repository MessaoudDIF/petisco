unit ConectorDeControles;

interface

uses
  Classes, DB, DBCtrls, DBGrids, Forms, Controls, JvDBControls, JvDBUltimGrid, JvDBCombobox,
  { Fluente }
  UnModelo;

const
  { Tamanho do Prefixo no nome dos Campos de Edição }
  DESLOCAMENTO = 3;
  { Tamanho Máximo do nome dos Campos de Edição}
  TAMANHO_MAXIMO = 99;

type
  TConectorDeControles = class(TObject)
  protected
    class function ObterNomeDoCampo(const NomeDoCampo: string;
      const DataSet: TDataSet; const Sufixo: string = ''): string;
    class procedure RealizarConexaoDeControles(Container: TScrollingWinControl; DataSource: TDataSource);
    class procedure FocusControl(AContainer: TScrollingWinControl; AComponent: TComponent);
  public
    class procedure ConectarControle(const Controle: TDBEdit; const DataSource: TDataSource; const Sufixo: string = ''); overload;
    class procedure ConectarControle(const EditBox: TDBMemo; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TDBComboBox; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TJvDBComboEdit; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TJvDBComboBox; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TJvDBDateEdit; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TJvDBMaskEdit; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TDBLookUpComboBox; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TDBText; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TJvDBCalcEdit; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControle(const EditBox: TDBCheckBox; const ADataSource: TDataSource; const ASufix: string = ''); overload;
    class procedure ConectarControles(AContainer: TScrollingWinControl; Modelo: TModelo); overload;
    class procedure ConectarControles(AContainer: TScrollingWinControl; ADataSource: TDataSource); overload;
    class procedure ConectarLista(const AGrid: TDBGrid; ADataSource: TDataSource); overload;
    class procedure ConectarLista(const AGrid: TJvDBUltimGrid; ADataSource: TDataSource); overload;
    class procedure ClearInstance(Sender: TObject);
  end;

implementation

uses StdCtrls, Graphics, DBClient, SysUtils;

{ TFlDataBinder }

class procedure TConectorDeControles.ConectarControle(const EditBox: TJvDBComboEdit; const ADataSource: TDataSource; const ASufix: string = '');
begin
  with EditBox do
  begin
    CharCase := ecUpperCase;
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const Controle: TDBEdit;
  const DataSource: TDataSource; const Sufixo: string = '');
begin
  Controle.CharCase := ecUpperCase;
  Controle.DataSource := DataSource;
  Controle.DataField := Self.ObterNomeDoCampo(Controle.Name, DataSource.DataSet, Sufixo);
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TDBLookUpComboBox; const ADataSource: TDataSource; const ASufix: string = '');
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(Name)-Length(ASufix)-3), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TJvDBDateEdit; const ADataSource: TDataSource; const ASufix: string = '');
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TDBMemo; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControles(AContainer: TScrollingWinControl; Modelo: TModelo);
begin
  inherited;
  Self.RealizarConexaoDeControles(AContainer, Modelo.DataSource);
end;

class procedure TConectorDeControles.ConectarLista(const AGrid: TDBGrid; ADataSource: TDataSource);
var
  i: Integer;
begin
  with AGrid do
  begin
    DataSource := ADataSource;
    Columns.RebuildColumns;
    for i := 0 to Columns.Count-1 do
      if (not DataSource.DataSet.Fields[i].Visible) or (DataSource.DataSet.Fields[i].DataType = ftDataSet) then
        Columns[i].Visible := False;
  end;
end;

class procedure TConectorDeControles.ConectarControles(AContainer: TScrollingWinControl; ADataSource: TDataSource);
begin
  Self.RealizarConexaoDeControles(AContainer, ADataSource);
end;

class procedure TConectorDeControles.ConectarLista(const AGrid: TJvDBUltimGrid; ADataSource: TDataSource);
var
  i: Integer;
begin
  with AGrid do
  begin
    DataSource := ADataSource;
    Columns.RebuildColumns;
    for i := 0 to Columns.Count-1 do
      if (not DataSource.DataSet.Fields[i].Visible) or (DataSource.DataSet.Fields[i].DataType = ftDataSet) then
        Columns[i].Visible := False;
  end;
end;

class procedure TConectorDeControles.RealizarConexaoDeControles(
  Container: TScrollingWinControl; DataSource: TDataSource);
var
  _i: Integer;
  _controle: TComponent;
begin
  for _i := 0 to Container.ComponentCount-1 do
  begin
    _controle := Container.Components[_i];
    if _controle.Tag > 0 then
      if (_controle is TDBEdit) then
        Self.ConectarControle(_controle as TDBEdit, DataSource)
      else if (_controle is TJvDBComboEdit) then
          Self.ConectarControle(_controle as TJvDBComboEdit, DataSource)
      else if (_controle is TDBMemo) then
          Self.ConectarControle(_controle as TDBMemo, DataSource)
      else if (_controle is TJvDBDateEdit) then
          Self.ConectarControle(_controle as TJvDBDateEdit, DataSource)
      else if (_controle is TJvDBMaskEdit) then
          Self.ConectarControle(_controle as TJvDBMaskEdit, DataSource)
      else if (_controle is TDBLookupComboBox) then
          Self.ConectarControle(_controle as TDBLookupComboBox, DataSource)
      else if (_controle is TDBText) then
          Self.ConectarControle(_controle as TDBText, DataSource)
      else if (_controle is TJvDBCalcEdit) then
          Self.ConectarControle(_controle as TJvDBCalcEdit, DataSource)
      else if (_controle is TDBCheckBox) then
          Self.ConectarControle(_controle as TDBCheckBox, DataSource)
      else if (_controle is TDBComboBox) then
          Self.ConectarControle(_controle as TDBComboBox, DataSource)
      else if (_controle is TJvDBComboBox) then
          Self.ConectarControle(_controle as TJvDBComboBox, DataSource);
  end;
end;

class function TConectorDeControles.ObterNomeDoCampo(const NomeDoCampo: string;
  const DataSet: TDataSet; const Sufixo: string = ''): string;
var
  _nomeDoCampo: string;
begin
  _nomeDoCampo := UpperCase(Copy(NomeDoCampo,DESLOCAMENTO + 1,TAMANHO_MAXIMO));
  if Sufixo <> '' then
    _nomeDoCampo := Copy(_nomeDoCampo, 1, Length(_nomeDoCampo)-Length(Sufixo));
  if (DataSet.FieldList.IndexOf(_nomeDoCampo) <> -1) or
    (DataSet.AggFields.FindField(_nomeDoCampo) <> nil) then
  begin
    Result := _nomeDoCampo
  end;
end;

class procedure TConectorDeControles.FocusControl(AContainer: TScrollingWinControl; AComponent: TComponent);
begin
  if (AContainer.Parent <> nil) and (AContainer.Parent is TForm) and (AComponent.Tag > 10) then
    if TWinControl(AComponent).CanFocus and TForm(AContainer.Parent).CanFocus then
      TForm(AContainer.Parent).FocusControl(TWinControl(AComponent));
end;

class procedure TConectorDeControles.ClearInstance(Sender: TObject);
begin
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TJvDBComboBox; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TJvDBMaskEdit; const ADataSource: TDataSource; const ASufix: string);
var
  iMask: string;
begin
  with EditBox do
  begin
    iMask := EditMask;
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(Name)-Length(ASufix)-3), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
    EditMask := iMask;
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TDBText; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TJvDBCalcEdit; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TDBCheckBox; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

class procedure TConectorDeControles.ConectarControle(const EditBox: TDBComboBox; const ADataSource: TDataSource; const ASufix: string);
begin
  with EditBox do
  begin
    DataSource := ADataSource;
    if ASufix <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(EditBox.Name, 1, Length(EditBox.Name)-Length(ASufix)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(EditBox.Name, DataSource.DataSet);
  end;
end;

end.
