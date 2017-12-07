unit UnTeclado;

interface

uses
  { VCL }
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Vcl.ExtCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, Vcl.ComCtrls;

const
  TECLADO_COMPLETO = 935;
  TECLADO_NUMERICO = 400;

type
  TTeclado = class(TFrame)
    pgTeclado: TPageControl;
    tabCompleto: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton37: TSpeedButton;
    btnBackSpace: TSpeedButton;
    SpeedButton38: TSpeedButton;
    btnClose: TSpeedButton;
    btnVirgula: TSpeedButton;
    tabNumerico: TTabSheet;
    SpeedButton36: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    SpeedButton46: TSpeedButton;
    SpeedButton47: TSpeedButton;
    SpeedButton48: TSpeedButton;
    SpeedButton49: TSpeedButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnBackSpaceClick(Sender: TObject);
  private
    FControleDeEdicao: TCustomEdit;
  protected
    function PosicionaCursor: TTeclado;
  public
    function ControleDeEdicao(const ControleDeEdicao: TCustomEdit): TTeclado;
    function Exibir: TTeclado;
  published
    procedure ProcessarTecla(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TTeclado }

function TTeclado.ControleDeEdicao(const ControleDeEdicao: TCustomEdit): TTeclado;
begin
  Result := Self;
  Self.FControleDeEdicao := ControleDeEdicao;
end;

function TTeclado.Exibir: TTeclado;
begin
  Result := Self;
  if (Self.FControleDeEdicao is TJvComboEdit)
    and (Self.FControleDeEdicao as TJvComboEdit).NumbersOnly then begin
    Self.Width := TECLADO_NUMERICO;
    Self.pgTeclado.ActivePageIndex := 1;
  end else begin
    Self.Width := TECLADO_COMPLETO;
    Self.pgTeclado.ActivePageIndex := 0;
  end;
  Self.Visible := True;
end;

function TTeclado.PosicionaCursor: TTeclado;
begin
  Result := Self;
  Self.FControleDeEdicao.SelStart := Length(Self.FControleDeEdicao.Text);
end;

procedure TTeclado.ProcessarTecla(Sender: TObject);
begin
  Self.FControleDeEdicao.Text := Self.FControleDeEdicao.Text + TSpeedButton(Sender).Caption;
  Self.PosicionaCursor;
end;

procedure TTeclado.btnBackSpaceClick(Sender: TObject);
begin
  if Length(Self.FControleDeEdicao.Text) > 0 then begin
    Self.FControleDeEdicao.Text := Copy(Self.FControleDeEdicao.Text, 1, Length(Self.FControleDeEdicao.Text)-1);
    Self.PosicionaCursor;
  end;
end;

procedure TTeclado.btnCloseClick(Sender: TObject);
begin
  Self.Visible := False;
end;

end.
