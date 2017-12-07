unit UnPetisco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  { Fluente }
  Util, DataUtil, Configuracoes, UnPetiscoModel, UnComandaModelo, Componentes,
  UnFabricaDeModelos, SearchUtil;

type
  TPetiscoView = class(TForm)
    pnlCommand: TJvPanel;
    pnlDesktop: TJvPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    FComandaModelo: TComandaModelo;
    FComandas: TComandas;
    FComandaSelecionada: TComanda;
    FDataUtil: TDataUtil;
    FFabricaDeModelos: TFabricaDeModelos;
    FConfiguracoes: TConfiguracoes;
    FUtil: TUtil;
    FModelo: TPetiscoModel;
    procedure exibirComanda;
  protected
    procedure CarregarComandas;
    function Comandas: TComandas;
  public
    function InitInstance(Sender: TObject): TPetiscoView;
    procedure comandaClick(Sender: TObject);
    procedure AfterComandaEdit(Sender: TObject);
  end;

var
  PetiscoView: TPetiscoView;

implementation

{$R *.dfm}

uses DB, SqlExpr, StdCtrls,
  { Fluente }
  UnModelo, UnAbrirComandaView, UnComandaView;

procedure TPetiscoView.AfterComandaEdit(Sender: TObject);
var
  _comanda: TComanda;
  _comandaModel: TComandaModelo;
  _dataSet: TDataSet;
begin
  _comandaModel := TComandaModelo(Sender);
  _dataSet := _comandaModel.DataSet();
  _comanda := Self.Comandas().obterComanda(
    _comandaModel.DataSet().FieldByName('coma_oid').AsString);
  if _comanda <> nil then
  begin
    // atualiza total de comanda existente
    _comanda.Total := _comandaModel.DataSet().FieldByName('coma_total').AsFloat;
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

procedure TPetiscoView.exibirComanda;
var
  _comandaView: TComandaView;
begin
  _comandaView := TComandaView.Create(Self.FComandaModelo, Self.AfterComandaEdit);
  try
    _comandaView.InitInstance;
    _comandaView.ShowModal;
  finally
    _comandaView.ClearInstance;
  end;
end;

procedure TPetiscoView.CarregarComandas;
var
  i, j: Integer;
  _Sql: TSQLDataSet;
  _comanda: TComanda;
begin
  _Sql := Self.FModelo.Sql;
  _Sql.Active := False;
  _Sql.CommandText := 'select c.coma_oid, c.cl_oid, c.coma_mesa, c.coma_total, l.cl_cod ' +
    ' from coma c left join cl l on c.cl_oid = l.cl_oid ' +
    ' where c.coma_stt = 0';
  _Sql.Open();
  j := 0;
  while not _Sql.Eof do
  begin
    Inc(j);
    _comanda := TComanda.Create(Self.pnlDesktop,
      Self.FUtil.iff(_Sql.FieldByName('cl_oid').IsNull,
        _Sql.FieldByName('coma_mesa').AsString,
        _Sql.FieldByName('cl_cod').AsString),
      _Sql.FieldByName('coma_total').AsFloat,
      Self.comandaClick);
    _comanda.identificacao := _Sql.FieldByName('coma_oid').AsString;
    Self.Comandas().adicionarComanda(
      _Sql.FieldByName('coma_oid').AsString,
      _comanda);
    _Sql.Next();
  end;
  _Sql.Close();
  for i := j to 35 do
    Self.Comandas().adicionarComanda(
      IntToStr(i + 1),
      TComanda.Create(Self.pnlDesktop, '*****', 0, Self.comandaClick));
end;

procedure TPetiscoView.comandaClick(Sender: TObject);
var
  _abrirComandaView: TAbrirComandaView;
  _comanda: TComanda;
begin
  _comanda := TComanda(TLabel(Sender).Parent);
  if _comanda.Identificacao <> '' then
  begin
    Self.FComandaModelo.carregarComanda(_comanda.Identificacao);
    Self.exibirComanda();
  end
  else
  begin
    _abrirComandaView := TAbrirComandaView.Create(Self.FComandaModelo);
    try
      if _abrirComandaView.ShowModal() = mrOk then
      begin
        Self.FComandaSelecionada := _comanda;
        Self.FComandaModelo.abrirComanda(
          _abrirComandaView.edtCliente.Text,
          _abrirComandaView.edtMesa.Text);
      Self.exibirComanda();
      end;
    finally
      FreeAndNil(_abrirComandaView);
    end;
  end;
end;

function TPetiscoView.Comandas: TComandas;
begin
  if Self.FComandas = nil then
    Self.FComandas := TComandas.Create();
  Result := Self.FComandas;
end;

function TPetiscoView.InitInstance(Sender: TObject): TPetiscoView;
begin
  Self.FUtil := TUtil.Create;
  Self.FDataUtil := TDataUtil.Create;
  Self.FConfiguracoes := TConfiguracoes.Create('.\system\setup.sys');
  Self.FModelo := TPetiscoModel.Create(nil);
  Self.FDataUtil.GetOIDGenerator(Self.FModelo.Sql);
  Self.FFabricaDeModelos := TFabricaDeModelos.Create(Self.FModelo.cnn)
    .Util(Self.FUtil)
    .DataUtil(Self.FDataUtil)
    .Configuracoes(Self.FConfiguracoes);
  TConstrutorDePesquisas.FabricaDeModelos(Self.FFabricaDeModelos);
  Self.FComandaModelo :=
      (Self.FFabricaDeModelos.ObterModelo('ComandaModelo') as TComandaModelo);
  Self.CarregarComandas();
  Result := Self;
end;

procedure TPetiscoView.FormCreate(Sender: TObject);
begin
  Self.InitInstance(Self)
end;

end.
