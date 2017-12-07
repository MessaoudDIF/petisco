unit UnFood;

interface

uses
  Windows, Variants, Classes, DB, 
  { Fluente }
  Util, DataUtil, Settings, UnFoodModel, UnComandaModel, UnProduto, UnWidgets,
  Controls, Forms, ExtCtrls;

type
  TFoodApp = class(TForm)
    ScrollBox: TScrollBox;
    pnlCommand: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBoxResize(Sender: TObject);
  private
    FComandaModel: TComandaModel;
    FComandas: TList;
    FComandaSelecionada: TComanda;
    FDataUtil: TDataUtil;
    FSettings: TSettings;
    FUtil: TUtil;
    FModel: TFoodModel;
    procedure exibirComanda;
  protected
    procedure CarregarComandas;
    function GetComandaModel: TComandaModel;
    function GetComandas: TDictionary<string, TComanda>;
  public
    function InitInstance(Sender: TObject): TFoodApp;
  published
    procedure comandaClick(Sender: TObject);
    procedure AfterComandaEdit(Sender: TObject);
  end;

var
  FoodApp: TFoodApp;

implementation

{$R *.dfm}

uses Data.SqlExpr, Vcl.StdCtrls,
  { Fluente }
  UnModel, UnAbrirComandaView, UnItemsView;

procedure TFoodApp.AfterComandaEdit(Sender: TObject);
var
  _comanda: TComanda;
  _comandaModel: TComandaModel;
  _dataSet: TDataSet;
begin
  _comandaModel := TComandaModel(Sender);
  _dataSet := _comandaModel.cds_coma;
  if Self.GetComandas().TryGetValue(
    _comandaModel.cds_coma.FieldByName('coma_oid').AsString, _comanda) then
  begin
    // atualiza total de comanda existente
    _comanda.Total := _comandaModel.cds_coma.FieldByName('coma_total').AsFloat;
  end
  else
  begin
    // carrega nova comanda
    Self.FComandaSelecionada.Identificacao :=
      _dataSet.FieldByName('coma_oid').AsString;
    if _dataSet.FieldByName('cl_oid').AsString <> '' then
      Self.FComandaSelecionada.Descricao :=
        _dataSet.FieldByName('cl_cod').AsString
    else
      Self.FComandaSelecionada.Descricao :=
        _dataSet.FieldByName('coma_mesa').AsString;
    Self.FComandaSelecionada.Total :=
      _dataSet.FieldByName('coma_total').AsFloat;
  end;
end;

procedure TFoodApp.exibirComanda;
var
  _itemView: TItemsView;
begin
  _itemView := TItemsView.Create(Self.FComandaModel, Self.AfterComandaEdit);
  try
    _itemView.InitInstance;
    _itemView.ShowModal;
  finally
    _itemView.ClearInstance;
  end;
end;

procedure TFoodApp.CarregarComandas;
var
  i, j: Integer;
  _Sql: TSQLDataSet;
  _comanda: TComanda;
begin
  _Sql := Self.FModel.Sql;
  _Sql.Active := False;
  _Sql.CommandText := 'select c.coma_oid, c.cl_oid, c.coma_mesa, c.coma_total, l.cl_cod ' +
    ' from coma c left join cl l on c.cl_oid = l.cl_oid ' +
    ' where c.coma_stt = 0';
  _Sql.Open();
  j := 0;
  while not _Sql.Eof do
  begin
    Inc(j);
    _comanda := TComanda.Create(Self.pnlComandas,
      Self.FUtil.iff(_Sql.FieldByName('cl_oid').IsNull,
        _Sql.FieldByName('coma_mesa').AsString,
        _Sql.FieldByName('cl_cod').AsString),
      _Sql.FieldByName('coma_total').AsFloat,
      Self.comandaClick);
    _comanda.identificacao := _Sql.FieldByName('coma_oid').AsString;
    Self.GetComandas().Add(_Sql.FieldByName('coma_oid').AsString, _comanda);
    _Sql.Next();
  end;
  _Sql.Close();
  for i := j to 35 do
    Self.GetComandas.Add(IntToStr(i + 1),
      TComanda.Create(Self.pnlComandas, '*****', 0, Self.comandaClick));
end;

procedure TFoodApp.comandaClick(Sender: TObject);
var
  _abrirComandaView: TAbrirComandaView;
  _comanda: TComanda;
begin
  _comanda := TComanda(TLabel(Sender).Parent);
  if _comanda.Identificacao <> '' then
  begin
    Self.GetComandaModel().carregarComanda(_comanda.Identificacao);
    Self.exibirComanda();
  end
  else
  begin
    _abrirComandaView := TAbrirComandaView.Create(Self.GetComandaModel());
    try
      if _abrirComandaView.ShowModal() = mrOk then
      begin
        Self.FComandaSelecionada := _comanda;
        Self.FComandaModel.abrirComanda(
          _abrirComandaView.edtCliente.Text,
          _abrirComandaView.edtMesa.Text);
      Self.exibirComanda();
      end;
    finally
      FreeAndNil(_abrirComandaView);
    end;
  end;
end;

procedure TFoodApp.FormCreate(Sender: TObject);
begin
  Self.InitInstance(Self)
end;

function TFoodApp.GetComandaModel: TComandaModel;
begin
  if Self.FComandaModel = nil then
  begin
    Self.FComandaModel := TComandaModel.Create(nil);
    Self.FComandaModel.Connection := Self.FModel.cnn;
    Self.FComandaModel.Util := Self.FUtil;
    Self.FComandaModel.DataUtil := Self.FDataUtil;
    Self.FComandaModel.Settings := Self.FSettings;
    Self.FComandaModel.InitInstance(Self);
  end;
  Result := Self.FComandaModel;
end;

function TFoodApp.GetComandas: TDictionary<string, TComanda>;
begin
  if Self.FComandas = nil then
    Self.FComandas := TDictionary<string, TComanda>.Create();
  Result := Self.FComandas;
end;

function TFoodApp.InitInstance(Sender: TObject): TFoodApp;
begin
  Self.FUtil := TUtil.Create;
  Self.FDataUtil := TDataUtil.Create;
  Self.FSettings := TSettings.Create('.\system\setup.sys');
  Self.FModel := TFoodModel.Create(nil);
  Self.FDataUtil.GetOIDGenerator(Self.FModel.Sql);
  Self.CarregarComandas();
  Result := Self;
end;

procedure TFoodApp.ScrollBoxResize(Sender: TObject);
begin
  Self.pnlComandas.Align := alLeft;
  Self.pnlComandas.Align := alTop;
end;

end.
