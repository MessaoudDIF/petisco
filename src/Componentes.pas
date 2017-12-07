unit Componentes;

interface

uses  Classes, Controls, StdCtrls, ExtCtrls, Graphics, Forms, Buttons,
  JvExButtons, JvBitBtn, JvExStdCtrls, JvButton, JvCtrls, JvLinkLabel,
  JvTransparentButton,
  { Fluente }
  DataUtil, UnModelo, UnProduto;

const
  // Propriedades componente TComanda
  COMANDA_ALTURA = 115;
  COMANDA_NOME_FONTE = 'Segoe UI';
  COMANDA_LARGURA = 200;
  COMANDA_MARGENS = 10;
  COMANDA_TAMANHO_FONTE = 28;
  // Propriedades componente Item de Comanda
  ITEM_ALTURA = 40;
  ITEM_NOME_FONTE = 'Segoe UI';
  ITEM_TAMANHO_FONTE = 16;
  // Propriedades componente Bloco de Aplicação no Menu Principal
  APLICACAO_ALTURA  = 75;
  APLICACAO_LARGURA = 135;
  APLICACAO_TAMANHO_FONTE = 24;
  // Cores utilizadas nos Blocos de Aplicação
  AZUL = $00635542;
  VERDE = $00767A5F;
  VERMELHO = $00699AFD;
  AMARELO = $00674761;
  ROSA = $007800F0;
  TEAL = $0082A901;
type
  TComanda = class(TPanel)
  private
    FAcaoAoClicarNaComanda: TNotifyEvent;
    FDescricao: string;
    FIdentificacao: string;
    FLabelDescricao: TLabel;
    FLabelSaldo: TLabel;
    FContainer: TWinControl;
    FConsumo: Real;
    FbtnRegistrarConta: TJvTransparentButton;
    FSaldo: Real;
    FStatus: Integer;
    FImagem: TBitMap;
    FBtnOn: Boolean;
    FEventoAoFecharConta: TNotifyEvent;
  public
    function AoClicarNaComanda(
      const ExecutarAoClicarNaComanda: TNotifyEvent): TComanda;
    function BotaoFecharContaOff: TComanda;
    function BotaoFecharContaOn: TComanda;
    function ClienteIrregularOff: TComanda;
    function ClienteIrregularOn: TComanda;
    function Consumo(const Consumo: Real): TComanda;
    function Container(const Container: TWinControl): TComanda;
    function Descricao(const Descricao: string): TComanda;
    function EstaAberta: Boolean;
    function Identificacao(const Identificacao: string): TComanda;
    function BotaoFecharConta(const NomeComponente: string;
      const Imagem: TBitMap; const EventoAoClicarNoBotao: TNotifyEvent): TComanda;
    function ObterConsumo: Real;
    function ObterIdentificacao: string;
    function ObterSaldo: Real;
    function Preparar: TComanda;
    function Saldo(const Saldo: Real): TComanda;
    function Status(const Status: Integer): TComanda;
    function ZerarComanda: TComanda;
  published
    procedure ProcessarClickBotaoFecharConta(Sender: TObject);
  end;

  TComandas = class
  private
    FComandas: TStringList;
  public
    constructor Create; reintroduce;
    function adicionarComanda(const Sequencia: string;
      const Comanda: TComanda): TComandas;
    function obterComanda(const Sequencia: string): TComanda;
  end;

  TItemEdit = class(TPanel)
  private
    FBtnImprimir: TSpeedButton;
    FLabelProduto: TLabel;
    FLabelQuantidade: TLabel;
    FLabelValorUnitario: TLabel;
    FLabelTotal: TLabel;
    FItem: TItem;
    FBtnEditItem: TSpeedButton;
    {--inicio---> Edição de Quantidade }
    FBtnInc: TButton;
    FEditQtde: TEdit;
    FBtnDec: TButton;
    FAntesDeEditar: TNotifyEvent;
    FAlterarIngredientes: TNotifyEvent;
    FAposEditar: TNotifyEvent;
    {--fim------> Edição de Quantidade }
    FImagens: TImageList;
  protected
    function criaTexto(const aTexto: string): TLabel;
  public
    function AlterarIngredientes(const AcaoParaExecutarAlteracaoDeIngredientes: TNotifyEvent): TItemEdit;
    function AntesDeEditar(const AcaoParaExecutarAntesDeEditar: TNotifyEvent): TItemEdit;
    function AposEditar(const AcaoParaExecutarAposEditar: TNotifyEvent): TItemEdit;
    function Container(const Container: TWinControl): TItemEdit;
    function Imagens(const Imagens: TImageList): TItemEdit;
    function Montar: TItemEdit;
    function Item(const Item: TItem): TItemEdit;
    function ObterItem: TItem;
  published
    procedure AtivarEdicaoDeQuantidade(Sender: TObject);
    procedure DecrementarQuantidade(Sender: TObject);
    procedure DesativarEdicaoDeQuantidade;
    procedure ExecutarEdicao(Sender: TObject);
    procedure IncrementarQuantidade(Sender: TObject);
  end;

implementation

uses SysUtils;

{ TComanda }

function TComanda.AoClicarNaComanda(
  const ExecutarAoClicarNaComanda: TNotifyEvent): TComanda;
begin
  Self.FAcaoAoClicarNaComanda := ExecutarAoClicarNaComanda;
  Result := Self;
end;

function TComanda.BotaoFecharContaOff: TComanda;
begin
  Self.FbtnRegistrarConta.Visible := False;
  Result := Self;
end;

function TComanda.BotaoFecharContaOn: TComanda;
begin
  Self.FbtnRegistrarConta.Visible := True;
  Self.FbtnRegistrarConta.Invalidate;
  Result := Self;
end;

function TComanda.ClienteIrregularOff: TComanda;
begin
  Self.FLabelDescricao.Color := clBtnFace;
  Self.FLabelDescricao.Transparent := True;
  Result := Self;
end;

function TComanda.ClienteIrregularOn: TComanda;
begin
  Self.FLabelDescricao.Color := $000080FF;
  Self.FLabelDescricao.Transparent := False;
  Result := Self;
end;

function TComanda.Consumo(const Consumo: Real): TComanda;
begin
  Self.FConsumo := Consumo;
  Result := Self;
end;

function TComanda.Container(const Container: TWinControl): TComanda;
begin
  Self.FContainer := Container;
  Result := Self;
end;

function TComanda.Descricao(const Descricao: string): TComanda;
begin
  Self.FDescricao := Descricao;
  if Self.FLabelDescricao <> nil then
    Self.FLabelDescricao.Caption := Self.FDescricao;
  Result := Self;
end;

function TComanda.EstaAberta: Boolean;
begin
  Result := Self.FStatus = 0;
end;

function TComanda.Identificacao(const Identificacao: string): TComanda;
begin
  Self.FIdentificacao := Identificacao;
  Result := Self;
end;

function TComanda.BotaoFecharConta(const NomeComponente: string;
  const Imagem: TBitMap; const EventoAoClicarNoBotao: TNotifyEvent): TComanda;
begin
  Self.FImagem := Imagem;
  if NomeComponente = 'On' then
    Self.FBtnOn := True
  else
    Self.FBtnOn := False;
  Self.FEventoAoFecharConta := EventoAoClicarNoBotao;
  Result := Self;
end;

function TComanda.ObterConsumo: Real;
begin
  Result := Self.FConsumo;
end;

function TComanda.ObterIdentificacao: string;
begin
  Result := Self.FIdentificacao;
end;

function TComanda.ObterSaldo: Real;
begin
  Result := Self.FSaldo;
end;

function TComanda.Preparar: TComanda;
var
  _divisor: TSplitter;
  _comandos: TPanel;
begin
  // Painel da Comanda
  inherited create(Self.FContainer);
  Self.Height := COMANDA_ALTURA;
  Self.Width := COMANDA_LARGURA;
  Self.ParentBackground := False;
  Self.Parent := Self.FContainer;
  Self.ParentColor := False;
  Self.Color := TEAL;
  Self.AlignWithMargins := True;
  Self.Margins.Top := 15;
  Self.Margins.Left := 15;
  Self.Margins.Right := 15;
  Self.Margins.Bottom := 15;
  // Painel de comandos no topo da comanda
  _comandos := TPanel.Create(Self);
  _comandos.Height := 60;
  _comandos.Align := alTop;
  _comandos.Parent := Self;
  _comandos.BevelInner := bvNone;
  _comandos.BevelOuter := bvNone;
  // botão de fechamento automático de conta fiado
  Self.FbtnRegistrarConta := TJvTransparentButton.Create(_comandos);
  Self.FbtnRegistrarConta.Align := alRight;
  Self.FbtnRegistrarConta.Width := 60;
  Self.FbtnRegistrarConta.FrameStyle := fsNone;
  Self.FbtnRegistrarConta.Glyph := Self.FImagem;
  Self.FbtnRegistrarConta.Visible := Self.FBtnOn;
  Self.FbtnRegistrarConta.OnClick := Self.ProcessarClickBotaoFecharConta;
  Self.FbtnRegistrarConta.Parent := _comandos;
  // TLabel com o nome do cliente ou mesa
  Self.FLabelDescricao := TLabel.Create(Self);
  Self.FLabelDescricao.Alignment := taCenter;
  Self.FLabelDescricao.Caption := Self.FDescricao;
  Self.FLabelDescricao.Font.Name := COMANDA_NOME_FONTE;
  Self.FLabelDescricao.Font.Size := COMANDA_TAMANHO_FONTE;
  Self.FLabelDescricao.Font.Color := $00F5EAE8;
  Self.FLabelDescricao.Font.Style := [fsBold];
  Self.FLabelDescricao.Align := alClient;
  Self.FLabelDescricao.Parent := _comandos;
  Self.FLabelDescricao.Transparent := False;
  Self.FLabelDescricao.ParentColor := False;
  Self.FLabelDescricao.Color := clBtnFace;
  Self.FLabelDescricao.OnClick := Self.FAcaoAoClicarNaComanda;
  Self.FLabelDescricao.Transparent := True;
  Self.FLabelDescricao.Tag := Integer(Self);
  // Splitter
  _divisor := TSplitter.Create(Self);
  _divisor.Align := alTop;
  _divisor.Parent := Self;
  // TLabel com o Saldo da Comanda
  Self.FLabelSaldo := TLabel.Create(Self);
  Self.FLabelSaldo.Alignment := taCenter;
  Self.FLabelSaldo.Font.Name := COMANDA_NOME_FONTE;
  Self.FLabelSaldo.Font.Style := [fsBold];
  Self.FLabelSaldo.Font.Size := COMANDA_TAMANHO_FONTE;
  Self.FLabelSaldo.Font.Color := clBtnFace;
  Self.FLabelSaldo.Align := alClient;
  Self.FLabelSaldo.Parent := Self;
  Self.FLabelSaldo.Transparent := False;
  Self.FLabelSaldo.ParentColor := False;
  Self.FLabelSaldo.OnClick := Self.FAcaoAoClicarNaComanda;
  Self.FLabelSaldo.Transparent := True;
  Self.FLabelSaldo.Tag := Integer(Self);
  Self.Saldo(Self.FSaldo);
  Result := Self;
end;

procedure TComanda.ProcessarClickBotaoFecharConta(Sender: TObject);
begin
  if Assigned(Self.FEventoAoFecharConta) then
    Self.FEventoAoFecharConta(Self);
end;

function TComanda.Saldo(const Saldo: Real): TComanda;
begin
  Self.FSaldo := Saldo;
  if Self.FSaldo > 0 then
    Self.Color := $0082A901
  else
    Self.Color := clGray;
  if Self.FLabelSaldo <> nil then
    Self.FLabelSaldo.Caption := FormatFloat('R$ ###,##0.00', Self.FSaldo);
  Result := Self;
end;

function TComanda.Status(const Status: Integer): TComanda;
begin
  Self.FStatus := Status;
  Result := Self;
end;

function TComanda.ZerarComanda: TComanda;
begin
  Self.FbtnRegistrarConta.Visible := False;
  Self.Saldo(0);
  Self.Identificacao(IntToStr(Self.Tag));
  Self.Descricao('*****');
  Self.Status(-1);
  Result := Self;
end;

{ TItemEdit }

function TItemEdit.AlterarIngredientes(
  const AcaoParaExecutarAlteracaoDeIngredientes: TNotifyEvent): TItemEdit;
begin
  Self.FAlterarIngredientes := AcaoParaExecutarAlteracaoDeIngredientes;
  Result := Self;
end;

function TItemEdit.AntesDeEditar(
  const AcaoParaExecutarAntesDeEditar: TNotifyEvent): TItemEdit;
begin
  Self.FAntesDeEditar := AcaoParaExecutarAntesDeEditar;
  Result := Self;
end;

function TItemEdit.AposEditar(
  const AcaoParaExecutarAposEditar: TNotifyEvent): TItemEdit;
begin
  Self.FAposEditar := AcaoParaExecutarAposEditar;
  Result := Self;
end;

procedure TItemEdit.AtivarEdicaoDeQuantidade(Sender: TObject);
begin
  if Assigned(Self.FAntesDeEditar) then
    Self.FAntesDeEditar(Self);
  Self.FBtnEditItem.HelpKeyword := 'Quantidade';
  Self.FBtnDec.Visible := True;
  Self.FEditQtde.Visible := True;
  Self.FBtnInc.Visible := True;
  Self.FBtnEditItem.Glyph := nil;
  Self.FImagens.GetBitmap(2, Self.FBtnEditItem.Glyph);
  Self.FBtnEditItem.Repaint;
end;

function TItemEdit.Container(const Container: TWinControl): TItemEdit;
begin
  Self.Visible := False;
  Self.Parent := Container;
  Result := Self;
end;

function TItemEdit.criaTexto(const aTexto: string): TLabel;
begin
  Result := TLabel.Create(Self);
  Result.Font.Name := ITEM_NOME_FONTE;
  Result.Font.Size := ITEM_TAMANHO_FONTE;
  Result.Font.Style := [fsBold];
  Result.Font.Color := clTeal;
  Result.Caption := aTexto;
end;

procedure TItemEdit.DecrementarQuantidade(Sender: TObject);
var  _quantidade: Integer;begin  _quantidade := StrToInt(Self.FEditQtde.Text);
//  if  _quantidade > 1 then
  Dec(_quantidade);
  if _quantidade = 0 then
    _quantidade := -1;
  Self.FEditQtde.Text := IntToStr(_quantidade);
end;

procedure TItemEdit.DesativarEdicaoDeQuantidade;
begin
  Self.FBtnEditItem.HelpKeyword := '';
  Self.FBtnDec.Visible := False;
  Self.FEditQtde.Visible := False;
  Self.FBtnInc.Visible := False;
  Self.FBtnEditItem.Glyph := nil;
  Self.FImagens.GetBitmap(1, Self.FBtnEditItem.Glyph);
  Self.FBtnEditItem.Repaint;
end;

procedure TItemEdit.ExecutarEdicao(Sender: TObject);
begin
  if TControl(Sender).HelpKeyword = 'Quantidade' then
  begin
    { Edição de quantidade do item }
    Self.FItem.AumentarQuantidadeEm(StrToInt(Self.FEditQtde.Text));
    Self.DesativarEdicaoDeQuantidade;
    if Assigned(Self.FAposEditar) then
      Self.FAposEditar(Self.FItem);
    Self.FLabelQuantidade.Caption :=
      IntToStr(Trunc(Self.FItem.ObterQuantidade));
    Self.FLabelTotal.Caption :=
      FormatFloat('#,##0.00',
        Self.FItem.ObterProduto.GetValor * Self.FItem.ObterQuantidade);
  end
  else
  begin
    { Edição de ingredientes do item }
    if Assigned(Self.FAntesDeEditar) then
      Self.FAntesDeEditar(Self);
    if Assigned(Self.FAlterarIngredientes) then
      Self.FAlterarIngredientes(Self);
    if Assigned(Self.FAposEditar) then
      Self.FAposEditar(Self);
  end;
end;

function TItemEdit.Imagens(const Imagens: TImageList): TItemEdit;
begin
  Self.FImagens := Imagens;
  Result := Self;
end;

procedure TItemEdit.IncrementarQuantidade(Sender: TObject);
var
  _quantidade: Integer;
begin
  _quantidade := StrToInt(Self.FEditQtde.Text);
  Inc(_quantidade);
  Self.FEditQtde.Text := IntToStr(_quantidade);
end;

function TItemEdit.Montar: TItemEdit;
var
  _deslocamento: Integer;
begin
  _deslocamento := 2;
  Self.Height := ITEM_ALTURA;
  { Botão de Impressão }
  Self.FBtnImprimir := TSpeedButton.Create(Self);
  Self.FBtnImprimir.Caption := '';
  Self.FImagens.GetBitmap(0, Self.FBtnImprimir.Glyph);
  Self.FBtnImprimir.Top := 2;
  Self.FBtnImprimir.Parent := Self;
  Self.FBtnImprimir.Left := _deslocamento;
  Self.FBtnImprimir.Width := 35;
  Self.FBtnImprimir.Height := 35;
  _deslocamento := _deslocamento + Self.FBtnImprimir.Width;
  { Produto }
  Self.FLabelProduto := Self.criaTexto(Self.FItem.ObterProduto.GetDescricao());
  Self.FLabelProduto.Parent := Self;
  Self.FLabelProduto.Width := 300;
  Self.FLabelProduto.Left := _deslocamento + 2;
  Self.FLabelProduto.Top := 5;
  _deslocamento := _deslocamento + 2 + Self.FLabelProduto.Width;
  { Valor Unitário }
  Self.FLabelValorUnitario := Self.criaTexto(FormatFloat('#,##0.00', Self.FItem.ObterProduto.GetValor));
  Self.FLabelValorUnitario.Parent := Self;
  Self.FLabelValorUnitario.Alignment := taRightJustify;
  Self.FLabelValorUnitario.Width := 80;
  Self.FLabelValorUnitario.Left := _deslocamento + 15;
  Self.FLabelValorUnitario.Top := 5;
  _deslocamento := _deslocamento + 15 + Self.FLabelValorUnitario.Width;
  { Quantidade }
  Self.FLabelQuantidade := Self.criaTexto(FormatFloat('##0', Self.FItem.ObterQuantidade));
  Self.FLabelQuantidade.Parent := Self;
  Self.FLabelQuantidade.Alignment := taLeftJustify;
  Self.FLabelQuantidade.Width := 45;
  Self.FLabelQuantidade.Left := _deslocamento + 65;
  Self.FLabelQuantidade.Color := clGray;
  Self.FLabelQuantidade.Top := 5;
  Self.FLabelQuantidade.OnClick := Self.AtivarEdicaoDeQuantidade;
  _deslocamento := _deslocamento + 65 + Self.FLabelQuantidade.Width;
  {---->Campos para edição de quantidade }
  Self.FBtnDec := TButton.Create(nil);
  Self.FBtnDec.Visible := False;
  Self.FBtnDec.Caption := '-';
  Self.FBtnDec.Width := 40;
  Self.FBtnDec.Height := 40;
  Self.FBtnDec.Font.Size := 14;
  Self.FBtnDec.Font.Style := [fsBold];
  Self.FBtnDec.Left:= _deslocamento - 20;
  Self.FBtnDec.Parent := Self;
  Self.FBtnDec.OnClick := Self.DecrementarQuantidade;

  Self.FEditQtde := TEdit.Create(nil);
  Self.FEditQtde.Visible := False;
  Self.FEditQtde.ParentCtl3D := False;
  Self.FEditQtde.Ctl3D := False;
  Self.FEditQtde.Font.Name := 'Segoe UI';
  Self.FEditQtde.Font.Size := 18;
  Self.FEditQtde.Font.Color := clTeal;
  Self.FEditQtde.Width := 45;
  Self.FEditQtde.Height := 38;
  Self.FEditQtde.Left := _deslocamento + 22;
  Self.FEditQtde.Text := '1';
  Self.FEditQtde.ReadOnly := True;
  Self.FEditQtde.Parent := Self;

  Self.FBtnInc := TButton.Create(nil);
  Self.FBtnInc.Visible := False;
  Self.FBtnInc.Caption := '+';
  Self.FBtnInc.Width := 40;
  Self.FBtnInc.Height := 40;
  Self.FBtnInc.Font.Size := 14;
  Self.FBtnInc.Font.Style := [fsBold];
  Self.FBtnInc.Left:= _deslocamento -20 + 42 + 45;
  Self.FBtnInc.OnClick := Self.IncrementarQuantidade;
  Self.FBtnInc.Parent := Self;
  {---->}
  { Total }
  Self.FLabelTotal := Self.criaTexto(FormatFloat('#,##0.00',
    Self.FItem.ObterQuantidade * Self.FItem.ObterProduto.GetValor));
  Self.FLabelTotal.Parent := Self;
  Self.FLabelTotal.Alignment := taRightJustify;
  Self.FLabelTotal.Width := 95;
  Self.FLabelTotal.Left := _deslocamento + 87;
  Self.FLabelTotal.Top := 5;
  _deslocamento := _deslocamento + 87 + Self.FLabelTotal.Width;
  { Botao de Edicao }
  Self.FBtnEditItem := TSpeedButton.Create(Self);
  Self.FImagens.GetBitmap(1, Self.FBtnEditItem.Glyph);
  Self.FBtnEditItem.Parent := Self;
  Self.FBtnEditItem.Left := _deslocamento + 20;
  Self.FBtnEditItem.Top := 2;
  Self.FBtnEditItem.Width := 35;
  Self.FBtnEditItem.Height := 35;
  Self.FBtnEditItem.OnClick := Self.ExecutarEdicao;
  { Configura Painel}
  Self.Align := alTop;
  Self.Visible := True;
  Result := Self;
end;

function TItemEdit.Item(const Item: TItem): TItemEdit;
begin
  Self.FItem := Item;
  Result := Self;
end;

function TItemEdit.ObterItem: TItem;
begin
  Result := Self.FItem;
end;

{ TComandas }

function TComandas.adicionarComanda(const Sequencia: string;
  const Comanda: TComanda): TComandas;
begin
  Self.FComandas.AddObject(Sequencia, Comanda);
  Result := Self;
end;

constructor TComandas.Create;
begin
  Self.FComandas := TStringList.Create;
end;

function TComandas.obterComanda(const Sequencia: string): TComanda;
var
  _indice: Integer;
begin
  _indice  := Self.FComandas.IndexOf(Sequencia);
  if _indice <> - 1 then
    Result := (Self.FComandas.Objects[_indice] as TComanda)
  else
    Result := nil;
end;

end.
