unit UnMensagemView;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ImgList,
  System.ImageList,
  // JEDI
  JvExControls, JvButton, JvTransparentButton;

type
  TMensagemView = class(TForm)
    pnlDesktop: TPanel;
    pnlTitle: TPanel;
    btnFechar: TJvTransparentButton;
    pnlCaption: TPanel;
    lblMensagem: TLabel;
    pnlFooter: TPanel;
    btnSim: TPanel;
    btnNao: TPanel;
    Imagem: TImage;
    Imagens: TImageList;
    procedure btnFecharClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
  protected
    function ShowModalDimmed(Form: TForm; Centered: Boolean = true): TModalResult;
  public
    function ExibirConfirmacao: Integer;
    function ExibirMensagem: Integer;
    function ExibirMensagemDeErro: Integer;
    function Legenda(const Legenda: string): TMensagemView;
    function LegendaBotaoNao(const LegendaBotaoNao: string): TMensagemView;
    function LegendaBotaoSim(const LegendaBotaoSim: string): TMensagemView;
    function Mensagem(const Mensagem: string): TMensagemView;
  end;

implementation

{$R *.dfm}

{ TMensagemView }

function TMensagemView.ExibirMensagem: Integer;
begin
  Result := Self.ShowModalDimmed(Self, True);
end;

function TMensagemView.Legenda(const Legenda: string): TMensagemView;
begin
  Self.pnlCaption.Caption := Legenda;
  Result := Self;
end;

function TMensagemView.Mensagem(const Mensagem: string): TMensagemView;
begin
  Self.lblMensagem.Caption := Mensagem;
  Result := Self;
end;

function TMensagemView.ShowModalDimmed(Form: TForm; Centered: Boolean = true): TModalResult;
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

procedure TMensagemView.btnFecharClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

function TMensagemView.LegendaBotaoNao(
  const LegendaBotaoNao: string): TMensagemView;
begin
  Self.btnNao.Caption := LegendaBotaoNao;
  Result := Self;
end;

function TMensagemView.LegendaBotaoSim(
  const LegendaBotaoSim: string): TMensagemView;
begin
  Self.btnSim.Caption := LegendaBotaoSim;
  Result := Self;
end;

function TMensagemView.ExibirConfirmacao: Integer;
begin
  Self.Imagem.Picture.Bitmap := nil;
  Self.Imagens.GetBitmap(1, Self.Imagem.Picture.Bitmap);
  Self.Imagem.Visible := True;
  Self.btnSim.Visible := True;
  Self.btnNao.Visible := True;
  Result := Self.ShowModalDimmed(Self, True);
end;

function TMensagemView.ExibirMensagemDeErro: Integer;
begin
  Self.Imagem.Picture.Bitmap := nil;;
  Self.Imagens.GetBitmap(0, Self.Imagem.Picture.Bitmap);
  Self.Imagem.Visible := True;
  Result := Self.ShowModalDimmed(Self, True);
end;

procedure TMensagemView.btnSimClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TMensagemView.btnNaoClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

end.
