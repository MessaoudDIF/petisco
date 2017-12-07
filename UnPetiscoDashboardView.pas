unit UnPetiscoDashboardView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExExtCtrls, JvExtComponent, JvPanel, ExtCtrls, ToolWin, JvExForms,
  JvScrollPanel, DateUtils, JvExControls, JvButton, JvTransparentButton, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, StdCtrls, Mask, JvExMask,
  JvToolEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit, ImgList,
  TeEngine, Series, TeeProcs, Chart, DB,
  { helsonsant }
  Util, DataUtil, UnFabricaDeModelos, UnFabricaDeAplicacoes, Componentes,
  Configuracoes, UnAplicacao, SearchUtil, UnPetiscoDashBoardModelo,
  ContasPagarAplicacao, VclTee.TeeGDIPlus, System.ImageList, Vcl.ComCtrls;

type
  TPetiscoDashBoardView = class(TForm, IResposta)
    pnlTitulo: TPanel;
    pnlFundo: TPanel;
    pnlDesktop: TJvPanel;
    Splitter1: TSplitter;
    btnFecharAplicacao: TJvTransparentButton;
    pnlResumo: TPanel;
    Panel1: TPanel;
    gContasPagar: TJvDBUltimGrid;
    Panel2: TPanel;
    Splitter2: TSplitter;
    lblDia: TLabel;
    lblDataCompleta: TLabel;
    pnlFiltroData: TPanel;
    GroupBox1: TGroupBox;
    txtDataInicial: TJvDatePickerEdit;
    GroupBox2: TGroupBox;
    txtDataFinal: TJvDatePickerEdit;
    Images: TImageList;
    Chart: TChart;
    GroupBox3: TGroupBox;
    lblTOTAL: TLabel;
    Serie: TBarSeries;
    pnlResultado: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblReceitasValor: TLabel;
    lblImpostosValor: TLabel;
    lblDespesasFixaValor: TLabel;
    lblDespesasVariaveisValor: TLabel;
    lblResultadoFinalValor: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharAplicacaoClick(Sender: TObject);
    procedure txtDataInicialChange(Sender: TObject);
    procedure gContasPagarDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure txtDataFinalChange(Sender: TObject);
    procedure gContasPagarDblClick(Sender: TObject);
  private
    FConfiguracoes: TConfiguracoes;
    FDataUtil: TDataUtil;
    FFabricaDeAplicacoes: TFabricaDeAplicacoes;
    FFabricaDeModelos: TFabricaDeModelos;
    FModelo: TPetiscoDashBoardModelo;
    FUtil: TUtil;
  protected
    procedure CarregarRegumoExecutivo;
    procedure MontarPainelDeAplicacoes;
  public
    function Preparar: TPetiscoDashBoardView;
    procedure Responder(const Chamada: TChamada);
  published
    procedure ProcessarSelecaoDeAplicacao(Sender: TObject);
  end;

var
  PetiscoDashBoardView: TPetiscoDashBoardView;

implementation

{$R *.dfm}

{ TPetiscoDashBoardView }

function TPetiscoDashBoardView.Preparar: TPetiscoDashBoardView;
begin
  Self.FUtil := TUtil.Create;
  Self.FDataUtil := TDataUtil.Create;
  Self.FConfiguracoes := TConfiguracoes.Create('.\system\setup.sys');
  Self.FModelo := TPetiscoDashBoardModelo.Create(nil);
  Self.FDataUtil.GetOIDGenerator(Self.FModelo.SqlProcessor);
  Self.FFabricaDeModelos := TFabricaDeModelos.Create(Self.FModelo.cnn)
    .Util(Self.FUtil)
    .DataUtil(Self.FDataUtil)
    .Configuracoes(Self.FConfiguracoes)
    .Preparar;
  Self.FFabricaDeAplicacoes := TFabricaDeAplicacoes.Create
    .FabricaDeModelos(Self.FFabricaDeModelos)
    .Util(Self.FUtil)
    .DataUtil(Self.FDataUtil)
    .Configuracoes(Self.FConfiguracoes)
    .Preparar;
  TConstrutorDePesquisas.FabricaDeModelos(Self.FFabricaDeModelos);
  Self.lblDia.Caption := IntToStr(DayOfTheMonth(Date));
  Self.lblDataCompleta.Caption :=
    FormatDateTime('dd "de" mmmm "de" yyyy.', Date);
  Self.txtDataInicial.Date := Date - 7;
  Self.txtDataFinal.Date := Date + 7;
  Self.MontarPainelDeAplicacoes;
  Self.CarregarRegumoExecutivo;
  Result := Self;
end;

procedure TPetiscoDashBoardView.FormCreate(Sender: TObject);
begin
  Self.BorderStyle := bsNone;
  Self.Preparar;
end;

procedure TPetiscoDashBoardView.ProcessarSelecaoDeAplicacao(
  Sender: TObject);
var
  _aplicacao: TAplicacao;
begin
  _aplicacao := Self.FFabricaDeAplicacoes.ObterAplicacao(
    (Sender as TComponent).Name);
  try
    _aplicacao
      .Controlador(Self)
      .AtivarAplicacao;
  finally
    _aplicacao.Descarregar;
  end;
end;

procedure TPetiscoDashBoardView.Responder(const Chamada: TChamada);
var
  _aplicacao: TAplicacao;
begin
  _aplicacao := Self.FFabricaDeAplicacoes.ObterAplicacao('FechamentoDeConta');
  try
    _aplicacao.AtivarAplicacao(Chamada);
  finally
    _aplicacao.Descarregar;
  end;
end;

procedure TPetiscoDashBoardView.MontarPainelDeAplicacoes;
begin
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Cliente')
    .Legenda('Clientes')
    .Dica('Acesso ao cadastro dos clientes')
    .Container(Self.pnlDesktop)
    .Cor(AMARELO)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Produto')
    .Legenda('Produtos')
    .Dica('Acesso ao cadastro dos produtos')
    .Container(Self.pnlDesktop)
    .Cor(VERDE)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('MovimentoDeCaixa')
    .Legenda('Caixa')
    .Dica('Controle de caixa')
    .Container(Self.pnlDesktop)
    .Cor(ROSA)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('ContasPagar')
    .Legenda('Contas ' + #13 + ' a ' + #13 + 'Pagar')
    .Dica('Acesso ao controle de contas a pagar')
    .Container(Self.pnlDesktop)
    .Cor(AZUL)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('ContasReceber')
    .Legenda('Contas ' + #13 + ' a ' + #13 + 'Receber')
    .Dica('Acesso ao controle de contas a receber')
    .Container(Self.pnlDesktop)
    .Cor(VERDE)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('ContaCorrente')
    .Legenda('Contas Correntes')
    .Dica('Acesso ao cadastro de contas correntes')
    .Container(Self.pnlDesktop)
    .Cor(TEAL)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('MovimentoDeContaCorrente')
    .Legenda('Movimentos de Conta Corrente')
    .Dica('Acesso aos registros de movimentos de contas correntes')
    .Container(Self.pnlDesktop)
    .Cor(VERMELHO)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Relatorio')
    .Legenda('Relatórios')
    .Dica('Acesso aos relatórios gerenciais do sistema')
    .Container(Self.pnlDesktop)
    .Cor(AMARELO)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Usuario')
    .Legenda('Usuários')                                                     
    .Dica('Acesso ao controle de usuários e senhas de acesso ao sistema')
    .Container(Self.pnlDesktop)
    .Cor(ROSA)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Fornecedor')
    .Legenda('Fornecedores')
    .Dica('Acesso ao controle de fornecedores')
    .Container(Self.pnlDesktop)
    .Cor(TEAL)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('CentroDeResultado')
    .Legenda('Centros de Resultado')
    .Dica('Acesso ao cadastro de centros de resultado')
    .Container(Self.pnlDesktop)
    .Cor(AZUL)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
  TAplicacaoBloco.Create(Self.pnlDesktop)
    .Aplicacao('Categoria')
    .Legenda('Categorias de Movimentação Financeira')
    .Dica('Acesso ao cadastro das categorias utilizadas para classificar as ' +
      'movimentações financeiras')
    .Container(Self.pnlDesktop)
    .Cor(AMARELO)
    .AoSelecionarAplicacao(Self.ProcessarSelecaoDeAplicacao)
    .Preparar;
end;

procedure TPetiscoDashBoardView.btnFecharAplicacaoClick(Sender: TObject);
begin
  if TMessages.Confirma('Sair da aplicação') then
    Self.Close;
end;

procedure TPetiscoDashBoardView.CarregarRegumoExecutivo;
var
  _valorMaximo, _resultado: Real;
  _dataSet: TDataSet;
begin
  Self.FModelo.CarregarContasPagar(Self.txtDataInicial.Date,
    Self.txtDataFinal.Date);
  Self.gContasPagar.DataSource := Self.FModelo.dsr;
  if Self.FModelo.cds.FieldByName('TOTAL').AsString <> '' then
    Self.lblTOTAL.Caption := FormatFloat('R$ #,##0.00',
        StrToFloat(Self.FModelo.cds.FieldByName('TOTAL').AsString))
  else
    Self.lblTOTAL.Caption := '0,00';
  _valorMaximo := 0;
  _dataSet := Self.FModelo.SqlProcessor;
  Serie.Clear;
  _dataSet.First;
  while not _dataSet.Eof do
  begin
    if _dataSet.FieldByName('TOTAL').AsFloat > _valorMaximo then
      _valorMaximo := _dataSet.FieldByName('TOTAL').AsFloat;
    Serie.Add(_dataSet.FieldByName('TOTAL').AsFloat,
      FormatDateTime('dd"/"mmm', _dataSet.FieldByName('TIT_VENC').AsDateTime));
    _dataSet.Next;
  end;
  Serie.GetVertAxis.SetMinMax(0, _valorMaximo * 1.25);
  Self.FModelo.CarregarResultado(Self.txtDataInicial.Date,
    Self.txtDataFinal.Date);
  _dataSet := Self.FModelo.cds_resultado;
  Self.lblReceitasValor.Caption := FormatFloat('R$ #,##0.00',
    _dataSet.FieldByName('RECEITAS').AsCurrency);
  Self.lblImpostosValor.Caption := FormatFloat('R$ #,##0.00',
    _dataSet.FieldByName('IMPOSTOS').AsCurrency);
  Self.lblDespesasFixaValor.Caption := FormatFloat('R$ #,##0.00',
    _dataSet.FieldByName('DESPESAS_FIXAS').AsCurrency);
  Self.lblDespesasVariaveisValor.Caption := FormatFloat('R$ #,##0.00',
    _dataSet.FieldByName('DESPESAS_VARIAVEIS').AsCurrency);
  _resultado := _dataSet.FieldByName('RECEITAS').AsCurrency -
    _dataSet.FieldByName('IMPOSTOS').AsCurrency -
    _dataSet.FieldByName('DESPESAS_FIXAS').AsCurrency -
    _dataSet.FieldByName('DESPESAS_VARIAVEIS').AsCurrency;
  Self.lblResultadoFinalValor.Caption := FormatFloat('R$ #,##0.00', _resultado);
  if _resultado >= 0 then
    Self.lblResultadoFinalValor.Font.Color := clNavy
  else
    Self.lblResultadoFinalValor.Font.Color := clMaroon;
end;

procedure TPetiscoDashBoardView.txtDataInicialChange(Sender: TObject);
begin
  Self.CarregarRegumoExecutivo;
end;

procedure TPetiscoDashBoardView.gContasPagarDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  _indice: Integer;
  _grid: TDBGrid;
  _dataSet: TDataSet;
begin
  inherited;
  _grid := (Sender as TDBGrid);
  _dataSet := _grid.DataSource.DataSet;
  if (Column.Index > 0) then
    _grid.DefaultDrawColumnCell(Rect, DataCol, Column, State)
  else
  begin
    if _dataSet.FieldByName('TIT_VENC').AsDatetime < Date then
      _indice := 2
    else
      if _dataSet.FieldByName('TIT_VENC').AsDatetime < (Date + 7) then
        _indice := 1
      else
        _indice := 0;
    _grid.Canvas.FillRect(Rect);
    Self.Images.Draw(_grid.Canvas,Rect.Left + 1, Rect.Top + 1, _indice);
  end;
end;

procedure TPetiscoDashBoardView.txtDataFinalChange(Sender: TObject);
begin
  Self.CarregarRegumoExecutivo;  
end;

procedure TPetiscoDashBoardView.gContasPagarDblClick(Sender: TObject);
var
  _aplicacao: TContasPagarAplicacao;
  _chamada: TChamada;
begin
  _aplicacao := (Self.FFabricaDeAplicacoes.ObterAplicacao('ContasPagar')
    as TContasPagarAplicacao);
  _chamada := TChamada.Create
    .Chamador(Self)
    .Parametros(TMap.Create
      .Gravar('acao', Ord(adrCarregar))
      .Gravar('oid',
        Self.gContasPagar.DataSource.DataSet.FieldByName('tit_oid').AsString)
    );
  _aplicacao.Responder(_chamada);
  Self.CarregarRegumoExecutivo;
end;

end.
