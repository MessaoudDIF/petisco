unit UnWidgets;

interface

uses  Classes, Controls, StdCtrls, ExtCtrls,
  { Fluente }
  UnProduto;

const
  COMANDA_ALTURA = 123;
  COMANDA_NOME_FONTE = 'Segoe UI';
  COMANDA_LARGURA = 270;
  COMANDA_MARGENS = 10;
  COMANDA_TAMANHO_FONTE = 34;

  ITEM_ALTURA = 45;
  ITEM_NOME_FONTE = 'Segoe UI';
  ITEM_TAMANHO_FONTE = 16;

type
  TComanda = class(TPanel)
  private
    FDescricao: string;
    FFichaAbertaDesde: TDate;
    FFichaTotal: Real;
    FIdentificacao: string;
    FLabelIdentificacao: TLabel;
    FLabelTotal: TLabel;
    FTotal: Real;
  protected
    procedure SetDescricao(const Descricao: string);
    procedure SetTotal(const Total: Real);
  public
    property Identificacao: string read FIdentificacao write FIdentificacao;
    property Descricao: string read FDescricao write SetDescricao;
    property FichaAbertaDesde: TDate read FFichaAbertaDesde
      write FFichaAbertaDesde;
    property FichaTotal: Real read FFichaTotal write FFichaTotal;
    property Total: Real read FTotal write SetTotal;
    constructor Create(const ParentControl: TWinControl;
      const Descricao: string; const Total: Real; const aEvent: TNotifyEvent); reintroduce;
  end;

  TItemEdit = class(TPanel)
  private
    FLabelProduto: TLabel;
    FLabelQuantidade: TLabel;
    FLabelValorUnitario: TLabel;
    FLabelTotal: TLabel;
    FProduto: TProduto;
    FBtnEditItem: TButton;
  protected
    function criaTexto(const aTexto: string): TLabel;
  public
    constructor Create(const aParentControl: TWinControl;
      const aProduto: TProduto); reintroduce;
    property Produto: TProduto read FProduto;
  end;

implementation

uses SysUtils, Graphics;

{ TComanda }

constructor TComanda.Create(const ParentControl: TWinControl;
  const Descricao: string; const Total: Real; const aEvent: TNotifyEvent);
var
  _divisor: TSplitter;
begin
  inherited create(ParentControl);
  Self.FDescricao := Descricao;
  Self.FTotal := Total;

  Self.Height := COMANDA_ALTURA;
  Self.Width := COMANDA_LARGURA;

  Self.Parent := ParentControl;
  Self.ParentColor := False;
  Self.Color := $006F3700;

  Self.FLabelIdentificacao := TLabel.Create(Self);
  Self.FLabelIdentificacao.Alignment := taCenter;
  Self.FLabelIdentificacao.Caption := Descricao;
  Self.FLabelIdentificacao.Font.Name := COMANDA_NOME_FONTE;
  Self.FLabelIdentificacao.Font.Size := COMANDA_TAMANHO_FONTE;
  Self.FLabelIdentificacao.Font.Color := clWhite;
  Self.FLabelIdentificacao.Font.Style := [fsBold];
  Self.FLabelIdentificacao.Align := alTop;
  Self.FLabelIdentificacao.Parent := Self;
  Self.FLabelIdentificacao.Transparent := False;
  Self.FLabelIdentificacao.ParentColor := False;
  Self.FLabelIdentificacao.Color := $006F3700;
  Self.FLabelIdentificacao.OnClick := aEvent;

  _divisor := TSplitter.Create(Self);
  _divisor.Align := alTop;
  _divisor.Parent := Self;

  Self.FLabelTotal := TLabel.Create(Self);
  Self.FLabelTotal.Alignment := taCenter;
  Self.FLabelTotal.Caption := FormatFloat('R$ ###,##0.00', Total);
  Self.FLabelTotal.Font.Name := COMANDA_NOME_FONTE;
  Self.FLabelTotal.Font.Style := [fsBold];
  Self.FLabelTotal.Font.Size := COMANDA_TAMANHO_FONTE;
  Self.FLabelTotal.Font.Color := clWhite;
  Self.FLabelTotal.Align := alClient;
  Self.FLabelTotal.Parent := Self;
  Self.FLabelTotal.Transparent := False;
  Self.FLabelTotal.ParentColor := False;
  Self.FLabelTotal.OnClick := aEvent;

end;

procedure TComanda.SetDescricao(const Descricao: string);
begin
  Self.FDescricao := Descricao;
  Self.FLabelIdentificacao.Caption := Self.FDescricao;
end;

procedure TComanda.SetTotal(const Total: Real);
begin
  Self.FTotal := Total;
  Self.FLabelTotal.Caption := FormatFloat('R$ ###,##0.00', Self.FTotal);
end;

{ TItemEdit }

constructor TItemEdit.Create(const aParentControl: TWinControl; const aProduto: TProduto);
begin
  inherited Create(aParentControl);
  Self.FProduto := aProduto;
  Self.Height := ITEM_ALTURA;
  { Produto }
  Self.FLabelProduto := Self.criaTexto(aProduto.GetDescricao());
  Self.FLabelProduto.Parent := Self;
  Self.FLabelProduto.Width := 330;
  Self.FLabelProduto.Left := 10;
  Self.FLabelProduto.Top := 5;
  { Valor Unitário }
  Self.FLabelValorUnitario := Self.criaTexto(FormatFloat('##0.00', aProduto.GetValor));
  Self.FLabelValorUnitario.Parent := Self;
  Self.FLabelValorUnitario.Alignment := taRightJustify;
  Self.FLabelValorUnitario.Width := 110;
  Self.FLabelValorUnitario.Left := Self.FLabelProduto.Width + 10;
  Self.FLabelValorUnitario.Top := 5;
  { Quantidade }
  Self.FLabelQuantidade := Self.criaTexto(FormatFloat('##0.00', aProduto.GetQuantidade));
  Self.FLabelQuantidade.Parent := Self;
  Self.FLabelQuantidade.Alignment := taRightJustify;
  Self.FLabelQuantidade.Width := 110;
  Self.FLabelQuantidade.Left := Self.FLabelProduto.Width + 10 +
    Self.FLabelValorUnitario.Width + 10;
  Self.FLabelQuantidade.Top := 5;
  { Total }
  Self.FLabelTotal := Self.criaTexto(FormatFloat('##0.00',
    aProduto.GetQuantidade() * aProduto.GetValor));
  Self.FLabelTotal.Parent := Self;
  Self.FLabelTotal.Alignment := taRightJustify;
  Self.FLabelTotal.Width := 110;
  Self.FLabelTotal.Left := Self.FLabelProduto.Width + 10 +
    Self.FLabelValorUnitario.Width + 10 +
    Self.FLabelQuantidade.Width + 10 + 35;
  Self.FLabelTotal.Top := 5;
  { Botao de Edicao }
  Self.FBtnEditItem := TButton.Create(Self);
  Self.FBtnEditItem.Parent := Self;
  Self.FBtnEditItem.Left := Self.FLabelProduto.Width + 10 +
    Self.FLabelValorUnitario.Width + 10 +
    Self.FLabelQuantidade.Width + 10 + 35 +
    Self.FLabelTotal.Width + 10;
  Self.FBtnEditItem.Width := 50;
  Self.FBtnEditItem.Height := 40;
  { Configura Painel}
  Self.Align := alTop;
  Self.Parent := aParentControl;
end;

function TItemEdit.criaTexto(const aTexto: string): TLabel;
begin
  Result := TLabel.Create(Self);
  Result.Font.Name := ITEM_NOME_FONTE;
  Result.Font.Size := ITEM_TAMANHO_FONTE;
  Result.Font.Style := [fsBold];
  Result.Caption := aTexto;
end;

end.
