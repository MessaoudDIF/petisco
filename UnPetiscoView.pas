unit UnPetiscoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList, Menus, System.Math,
  { JEDI }
  JvExStdCtrls, JvScrollBar, JvContentScroller, ComCtrls, JvExComCtrls, JvExControls, JvButton,
  JvPageScroller, JvExExtCtrls, JvExtComponent, JvPanel, JvTransparentButton, JvBevel, JvScrollMax,
  { Spring }
//  Spring.Container,
  { helsonsant }
  Util, DataUtil, Configuracoes, UnPetiscoModel, UnComandaModelo, UnFabricaDeModelos, UnAplicacao,
  UnFabricaDeAplicacoes, Componentes, SearchUtil;

type
  TPetiscoView = class(TForm)
    pnlCommand: TJvPanel;
    PageScroller: TScrollBox;
    pnlDesktop: TJvPanel;
    JvTransparentButton2: TJvTransparentButton;
    PopupMenu: TPopupMenu;
    Configuracoes: TMenuItem;
    FechamentoDeConta: TJvTransparentButton;
    JvBevel1: TJvBevel;
    Caixa: TJvTransparentButton;
    JvBevel2: TJvBevel;
    VendaRapida: TJvTransparentButton;
    btnFicha: TJvTransparentButton;
    procedure FormCreate(Sender: TObject);
    procedure pnlDesktopResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FComandas: TComandas;
    FComandaSelecionada: TComanda;
    FDataUtil: TDataUtil;
    FFabricaDeAplicacoes: TFabricaDeAplicacoes;
    FFabricaDeModelos: TFabricaDeModelos;
    FConfiguracoes: TConfiguracoes;
    FUtil: TUtil;
    FModelo: TPetiscoModel;
  protected
    procedure FecharConta(Sender: TObject);
  public
    procedure AtualizarComandaNoPainel(Sender: TObject);
    procedure CarregarComandasNoPainel;
    function Preparar(Sender: TObject): TPetiscoView;
    procedure AtivarAplicacaoComanda(Sender: TObject);
  published
    procedure ProcessarSelecaoDeAplicacao(Sender: TObject);
  end;

  var
    Main: TPetiscoView;

implementation

{$R *.dfm}

uses
  // VCL
  DB, SqlExpr,
  // Fluente
  UnModelo, ComandaAplicacao;

procedure TPetiscoView.AtualizarComandaNoPainel(Sender: TObject);
var
  _dataSet: TDataSet;
  _comanda: TComanda;
  _statusFichaCliente: StatusFichaCliente;
begin
  _dataSet := TComandaModelo(Sender).DataSet;
  _comanda := Self.FComandaSelecionada;
  _comanda.Status(_dataSet.FieldByName('coma_stt').AsInteger);
  if _comanda.EstaAberta then begin
    if _dataSet.FieldByName('cl_oid').AsString <> '' then begin
      _statusFichaCliente := Self.FModelo.RetornarStatusFichaCliente(
         _dataSet.FieldByName('cl_oid').AsString);
      if _statusFichaCliente = sfcIrregular then begin
        _comanda.ClienteIrregularOn;
      end else begin
        _comanda.ClienteIrregularOff;
      end;
      _comanda.BotaoFecharContaOn;
    end else begin
      _comanda.BotaoFecharContaOff;
    end;
    _comanda
      .Descricao(Self.FUtil.iff(_dataSet.FieldByName('coma_cliente').AsString = '',
        _dataSet.FieldByName('coma_mesa').AsString,
        _dataSet.FieldByName('coma_cliente').AsString))
      .Saldo(_dataSet.FieldByName('coma_saldo').AsFloat)
      .Identificacao(_dataSet.FieldByName('coma_oid').AsString);
  end;
  if ((RoundTo(_comanda.ObterConsumo, -2) > 0)  and (RoundTo(_comanda.ObterSaldo, -2) = 0)) or
    not (_comanda.EstaAberta) then begin
    _comanda.ZerarComanda;
    _comanda.ClienteIrregularOff;
    _comanda.Parent := nil;
    _comanda.Parent := Self.pnlDesktop;
  end;
end;

procedure TPetiscoView.CarregarComandasNoPainel;
var
  i, j: Integer;
  _dataSet: TDataSet;
  _comanda: TComanda;
  _totalDeComandasNoPainel: string;
begin
  _dataSet := Self.FModelo
    .CarregarComandasEmAberto
    .DataSet;
  j := 0;
  while not _dataSet.Eof do begin
    Inc(j);
    _comanda := TComanda.Create(nil)
      .Identificacao(_dataSet.FieldByName('coma_oid').AsString)
      .Descricao(Self.FUtil.iff(_dataSet.FieldByName('coma_cliente').AsString = '',
        _dataSet.FieldByName('coma_mesa').AsString,
        _dataSet.FieldByName('coma_cliente').AsString))
      .Consumo(_dataSet.FieldByName('coma_consumo').AsFloat)
      .Saldo(_dataSet.FieldByName('coma_saldo').AsFloat)
      .Status(_dataSet.FieldByName('coma_stt').AsInteger)
      .Container(Self.pnlDesktop)
      .AoClicarNaComanda(Self.AtivarAplicacaoComanda)
      .BotaoFecharConta(Self.FUtil.iff(_dataSet.FieldByName('cl_oid').AsString = '', 'Off','On'), Self.btnFicha.Glyph, Self.FecharConta)
      .Preparar;
    _comanda.Tag := j;
    Self.FComandas.adicionarComanda(
      IntToStr(j),
      _comanda);
    _dataSet.Next;
  end;
  _dataSet.Close();
  _totalDeComandasNoPainel := Self.FConfiguracoes.Ler('TotalDeComandasNoPainel');
  if _totalDeComandasNoPainel = '' then begin
    _totalDeComandasNoPainel := '36';
  end;
  for i := j to StrToInt(_totalDeComandasNoPainel)-1 do begin
    _comanda := TComanda.Create(nil)
      .Descricao('*****')
      .Identificacao(IntToStr(i + 1))
      .Status(-1)
      .Container(Self.pnlDesktop)
      .AoClicarNaComanda(Self.AtivarAplicacaoComanda)
      .BotaoFecharConta('Off', Self.btnFicha.Glyph, Self.FecharConta)
      .Preparar;
    _comanda.Tag := i;
    Self.FComandas.adicionarComanda(IntToStr(i + 1), _comanda);
  end;
end;

procedure TPetiscoView.AtivarAplicacaoComanda(Sender: TObject);
var
  _configuracao: TConfiguracaoAplicacao;
  _comanda: TComanda;
  _aplicacao: TAplicacao;
begin
  _configuracao := TConfiguracaoAplicacao.Create
    .AposDesativar(Self.AtualizarComandaNoPainel);
  _comanda := TComanda(TControl(Sender).Tag);
  Self.FComandaSelecionada := _comanda;
  if _comanda.EstaAberta then begin
    _configuracao.Parametros(
      TMap.Create
        .Gravar('operacao', Ord(ocmdCarregarComanda))
        .Gravar('oid', _comanda.ObterIdentificacao)
    );
  end else begin
    _configuracao.Parametros(
      TMap.Create
        .Gravar('operacao', Ord(ocmdAbrirComanda))
    );
  end;
  _aplicacao := Self.FFabricaDeAplicacoes.ObterAplicacao('Comanda', _configuracao);
  _aplicacao.AtivarAplicacao;
end;

function TPetiscoView.Preparar(Sender: TObject): TPetiscoView;
var
  _ComandasPorLinhaNoPainel: string;
begin
  Self.FComandas := TComandas.Create;
  Self.FUtil := TUtil.Create;
  Self.FDataUtil := TDataUtil.Create;
  Self.FConfiguracoes := TConfiguracoes.Create('.\system\setup.sys');
  Self.FModelo := TPetiscoModel.Create(nil);
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
  _ComandasPorLinhaNoPainel := Self.FConfiguracoes.Ler('ComandasPorLinha');
  if _ComandasPorLinhaNoPainel <> '' then begin
    Self.pnlDesktop.ArrangeSettings.MaxControlsPerLine := StrToInt(_ComandasPorLinhaNoPainel);
  end;
  Self.CarregarComandasNoPainel();
  Result := Self;
end;

procedure TPetiscoView.FecharConta(Sender: TObject);
var
  _configuracao: TConfiguracaoAplicacao;
  _comanda: TComanda;
begin
  _configuracao := TConfiguracaoAplicacao.Create
    .AposDesativar(Self.AtualizarComandaNoPainel);
  _comanda := Sender as TComanda;
  Self.FComandaSelecionada := _comanda;
  if _comanda.EstaAberta then begin
    _configuracao.Parametros(TMap.Create
      .Gravar('operacao', Ord(ocmdFecharConta))
      .Gravar('oid', _comanda.ObterIdentificacao)
    );
    Self.FFabricaDeAplicacoes.ObterAplicacao(
      'Comanda', _configuracao)
      .AtivarAplicacao;
  end;
end;

procedure TPetiscoView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Util.TMessages.Confirma('Deseja Realmente FECHAR a aplicação ') then begin
    Action := caNone;
  end;
end;

procedure TPetiscoView.FormCreate(Sender: TObject);
begin
  Self.Preparar(Self);
end;

procedure TPetiscoView.pnlDesktopResize(Sender: TObject);
begin
  Self.pnlDesktop.Repaint;
end;

procedure TPetiscoView.ProcessarSelecaoDeAplicacao(Sender: TObject);
var
  _aplicacao: TAplicacao;
begin
  _aplicacao := Self.FFabricaDeAplicacoes.ObterAplicacao(
    (Sender as TComponent).Name);
  try
    _aplicacao.AtivarAplicacao;
  finally
    _aplicacao.Descarregar;
  end;
end;

initialization
  //GlobalContainer.RegisterType<TPetiscoView>;

end.
