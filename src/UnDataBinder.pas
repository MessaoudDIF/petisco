unit UnDataBinder;

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
    class function ObterNomeDoCampo(const NomeDoCampo: string; DataSet: TDataSet): string;
    class procedure RealizarConexaoDeControles(AContainer: TScrollingWinControl; ADataSource: TDataSource);
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
var
  iField: TStringList;
begin
  with Controle do
  begin
    CharCase := ecUpperCase;
    DataSource := DataSource;
    if Sufixo <> '' then
      DataField := Self.ObterNomeDoCampo(Copy(Controle.Name, 1, Length(Controle.Name)-Length(Sufixo)), DataSource.DataSet)
    else
      DataField := Self.ObterNomeDoCampo(Controle.Name, DataSource.DataSet);
  end;
  iField := TStringList.Create;
  iField.Add(Controle.Name);
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

class procedure TConectorDeControles.RealizarConexaoDeControles(AContainer: TScrollingWinControl; ADataSource: TDataSource);
var
  i: Integer;
begin
  for i := 0 to AContainer.ComponentCount-1 do
  begin
    if (AContainer.Components[i] is TDBEdit) and (AContainer.Components[i].Tag > 0) then
      Self.ConectarControle(AContainer.Components[i] as TDBEdit, ADataSource)
    else
      if (AContainer.Components[i] is TJvDBComboEdit) and (AContainer.Components[i].Tag > 0) then
        Self.ConectarControle(AContainer.Components[i] as TJvDBComboEdit, ADataSource)
      else
        if (AContainer.Components[i] is TDBMemo) and (AContainer.Components[i].Tag > 0) then
          Self.ConectarControle(AContainer.Components[i] as TDBMemo, ADataSource)
        else
          if (AContainer.Components[i] is TJvDBDateEdit) and (AContainer.Components[i].Tag > 0) then
            Self.ConectarControle(AContainer.Components[i] as TJvDBDateEdit, ADataSource)
          else
            if (AContainer.Components[i] is TJvDBMaskEdit) and (AContainer.Components[i].Tag > 0) then
              Self.ConectarControle(AContainer.Components[i] as TJvDBMaskEdit, ADataSource)
            else
              if (AContainer.Components[i] is TDBLookupComboBox) and (AContainer.Components[i].Tag > 0) then
                Self.ConectarControle(AContainer.Components[i] as TDBLookupComboBox, ADataSource)
              else
                if (AContainer.Components[i] is TDBText) and (AContainer.Components[i].Tag > 0) then
                  Self.ConectarControle(AContainer.Components[i] as TDBText, ADataSource)
                else
                  if (AContainer.Components[i] is TJvDBCalcEdit) and (AContainer.Components[i].Tag > 0) then
                    Self.ConectarControle(AContainer.Components[i] as TJvDBCalcEdit, ADataSource)
                  else
                    if (AContainer.Components[i] is TDBCheckBox) and (AContainer.Components[i].Tag > 0) then
                      Self.ConectarControle(AContainer.Components[i] as TDBCheckBox, ADataSource)
                    else
                      if (AContainer.Components[i] is TDBComboBox) and (AContainer.Components[i].Tag > 0) then
                        Self.ConectarControle(AContainer.Components[i] as TDBComboBox, ADataSource)
                      else
                        if (AContainer.Components[i] is TJvDBComboBox) and (AContainer.Components[i].Tag > 0) then
                          Self.ConectarControle(AContainer.Components[i] as TJvDBComboBox, ADataSource);
  end;
end;

class function TConectorDeControles.ObterNomeDoCampo(const NomeDoCampo: string;
  DataSet: TDataSet): string;
var
  _nomeDoCampo: string;
begin
  _nomeDoCampo := UpperCase(Copy(NomeDoCampo,DESLOCAMENTO + 1,TAMANHO_MAXIMO));
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
