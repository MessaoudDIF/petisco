unit UnMenuView;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvButton, JvTransparentButton, ExtCtrls, StdCtrls, Vcl.Buttons,
  // JEDI
  JvExExtCtrls, JvExtComponent, JvPanel,
  // helsonsant
  Util;

type
  TMenuItemView = class(TJvPanel)
  private
    FLegenda: TLabel;
    FDescricao: TLabel;
    FAoClicar: TNotifyEvent;
  protected
    procedure Destacar(Sender: TObject);
    procedure RemoverDestaque(Sender: TObject);
  public
    function AoClicar(const EventoParaExecutarAoClicar: TNotifyEvent): TMenuItemView;
    function Descricao(const Descricao: string): TMenuItemView;
    function Legenda(const Legenda: string): TMenuItemView;
    function Montar: TMenuItemView;
  end;

  TMenuView = class(TForm)
    pnlDesktop: TPanel;
    pnlTitle: TPanel;
    btnFechar: TSpeedButton;
    pnlCaption: TPanel;
    pnlFooter: TPanel;
    lblMensagem: TLabel;
    pnlOpcoes: TJvPanel;
    procedure btnFecharClick(Sender: TObject);
  private
    FOpcoes: TStringList;
    FResposta: string;
  protected
    function ShowModalDimmed(Form: TForm; Centered: Boolean = true): TModalResult;
  public
    property Resposta: string read FResposta;
    function AdicionarOpcao(const Opcao, Legenda: string;
      const Descricao: string = ''): TMenuView;
    function Exibir: string;
    function Legenda(const Legenda: string): TMenuView;
    function Mensagem(const Mensagem: string): TMenuView;
  published
    procedure ProcessarSelecaoDeOpcao(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TMenuView }

function TMenuView.AdicionarOpcao(const Opcao, Legenda: string;
  const Descricao: string = ''): TMenuView;
var
  _menuItem: TMenuItemView;
begin
  if Self.FOpcoes = nil then
    Self.FOpcoes := TStringList.Create;
  _menuItem := TMenuItemView.Create(Self.pnlOpcoes)
    .Legenda(Legenda)
    .Descricao(Descricao)
    .AoClicar(Self.ProcessarSelecaoDeOpcao)
    .Montar;
  _menuItem.Parent := Self.pnlOpcoes;
  _menuItem.Align := altop;
  Self.FOpcoes.AddObject(Opcao, _menuItem);
  Result := Self;
end;

function TMenuView.Exibir: string;
begin
  Self.ShowModalDimmed(Self);
  Result := Self.FResposta;
end;

function TMenuView.Legenda(const Legenda: string): TMenuView;
begin
  Self.pnlCaption.Caption := Legenda;
  Result := Self;
end;

function TMenuView.Mensagem(const Mensagem: string): TMenuView;
begin
  Self.lblMensagem.Caption := '   ' + Mensagem;
  Result := Self;
end;

procedure TMenuView.ProcessarSelecaoDeOpcao(Sender: TObject);
var
  _indice: Integer;
  _opcao: TMenuItemView;
begin
  if Sender is TLabel then
    _opcao := (TLabel(Sender).Parent as TMenuItemView)
  else
    _opcao := (Sender as TMenuItemView);
  _indice := Self.FOpcoes.IndexOfObject(_opcao);
  if _indice <> -1 then
    Self.FResposta := Self.FOpcoes[_indice]
  else
    Self.FResposta := '';
  Self.ModalResult := mrOk;
end;

function TMenuView.ShowModalDimmed(Form: TForm; Centered: Boolean): TModalResult;
var
  Back: TForm;
begin
  Back := TForm.Create(nil);
  try
    Back.Position := poDesigned;
    Back.BorderStyle := bsNone;
    Back.AlphaBlend := true;
    Back.AlphaBlendValue := 192;
    Back.Color := clBlack;
    Back.SetBounds(0, 0, Screen.Width, Screen.Height);
    Back.Show;
    if Centered then begin
      Form.Left := (Back.ClientWidth - Form.Width) div 2;
      Form.Top := (Back.ClientHeight - Form.Height) div 2;
    end;
    Result := Form.ShowModal;
  finally
    Back.Free;
  end;
end;

{ TMenuItemView }

function TMenuItemView.AoClicar(
  const EventoParaExecutarAoClicar: TNotifyEvent): TMenuItemView;
begin
  Self.FAoClicar := EventoParaExecutarAoClicar;
  Self.FLegenda.OnClick := EventoParaExecutarAoClicar;
  Self.FDescricao.OnClick := EventoParaExecutarAoClicar;
  Self.OnClick := EventoParaExecutarAoClicar;
  Result := Self;
end;

function TMenuItemView.Descricao(const Descricao: string): TMenuItemView;
begin
  if Self.FDescricao = nil then
  begin
    Self.FDescricao := TLabel.Create(Self);
    Self.FDescricao.Align := alClient;
    Self.FDescricao.Font.Name := 'Segoe UI';
    Self.FDescricao.Font.Size := 12;
    Self.FDescricao.Font.Color := clGray;
    Self.FDescricao.Font.Style := [];
    Self.FDescricao.Parent := Self;
  end;
  Self.FDescricao.Caption := Descricao;
  Result := Self;
end;

function TMenuItemView.Legenda(const Legenda: string): TMenuItemView;
begin
  if Self.FLegenda = nil then
  begin
    Self.FLegenda := TLabel.Create(Self);
    Self.FLegenda.Align := alTop;
    Self.FLegenda.Font.Name := 'Segoe UI';
    Self.FLegenda.Font.Size := 14;
    Self.FLegenda.Font.Color := clTeal;
    Self.FLegenda.Font.Style := [fsBold];
    Self.FLegenda.Parent := Self;
  end;
  Self.FLegenda.Caption := Legenda;
  Result := Self;
end;

function TMenuItemView.Montar: TMenuItemView;
begin
  Self.BevelOuter := bvNone;
  Self.BorderStyle := bsSingle;
  Self.BorderWidth := 5;
  Self.Color := clWhite;
  Self.Height := 80;
  Self.OnMouseEnter := Destacar;
  Self.OnMouseLeave := RemoverDestaque;
  Result := Self;
end;

procedure TMenuView.btnFecharClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TMenuItemView.Destacar(Sender: TObject);
begin
  if TJvPanel(Sender).Color = clWhite then
    TJvPanel(Sender).Color := $00F0FFBB;
end;

procedure TMenuItemView.RemoverDestaque(Sender: TObject);
begin
  if not (TJvPanel(Sender).Color = clWhite) then
    TJvPanel(Sender).Color := clWhite;
end;

end.
